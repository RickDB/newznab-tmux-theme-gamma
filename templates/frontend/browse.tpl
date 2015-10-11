<ul class="breadcrumb">
	<li><a href="{$smarty.const.WWW_TOP}{$site->home_link}">Home</a> <span class="divider">/</span></li>
	<li class="active">{$catname|escape:"htmlall"}</li>
</ul>

{$site->adbrowse}	

{if $shows}
<center>
<div class="btn-group">
	<a class="btn btn-small" href="{$smarty.const.WWW_TOP}/series" title="View available TV series">Series List</a> | 
	<a class="btn btn-small" title="Manage your shows" href="{$smarty.const.WWW_TOP}/myshows">Manage My Shows</a> | 
	<a class="btn btn-small" title="All releases in your shows as an RSS feed" href="{$smarty.const.WWW_TOP}/rss?t=-3&amp;dl=1&amp;i={$userdata.id}&amp;r={$userdata.rsstoken}">Rss <i class="fa fa-rss"></i></a>
</div>
</center>
<br/>
{/if}

{if $results|@count > 0}

<form id="nzb_multi_operations_form" action="get">

	<div class="well well-small">
		<div class="nzb_multi_operations">
			<table width="100%">
				<tr>
					<td width="30%">
						With Selected:
						<div class="btn-group">
							<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
							<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
							{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to queue" />{/if}
							{if $nzbgetintegrated}<input type="button" class="nzb_multi_operations_nzbget btn btn-small btn-primary" value="Send to NZBGet" />{/if}
						</div>
						{if (strpos($category, '60')  !== false)}
							&nbsp;&nbsp;&nbsp;&nbsp;<a title="Switch to Cover view" href="{$smarty.const.WWW_TOP}/xxx"><i class="fa fa-lg fa-file-image-o"></i></a>
						{/if}
						{if (strpos($category, '20') !== false)}
							&nbsp;&nbsp;&nbsp;&nbsp;<a title="Switch to Cover view" href="{$smarty.const.WWW_TOP}/movies"><i class="fa fa-lg fa-file-image-o"></i></a>
						{/if}
					</td>
					<td width="50%">
						<center>
							{$pager}
						</center>
					</td>
					<td width="20%">
						<div class="pull-right">
						<a class="btn btn-small" title="All releases in your shows as an RSS feed" href="{$smarty.const.WWW_TOP}/rss?t={$category}&amp;dl=1&amp;i={$userdata.id}&amp;r={$userdata.rsstoken}">Rss <i class="fa fa-rss"></i></a>
						{if $isadmin}
							Admin: 	
							<div class="btn-group">	
								<input type="button" class="nzb_multi_operations_edit btn btn-small btn-warning" value="Edit" />
								<input type="button" class="nzb_multi_operations_delete btn btn-small btn-danger" value="Delete" />
							</div>
						{/if}
						{if $section != ''}
							<a href="{$smarty.const.WWW_TOP}/{$section}?t={$category}"><i class="fa fa-th-list"></i></a>
						{/if}						
						&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<table style="100%" class="data highlight icons table table-striped" id="browsetable">

		<tr>
			<th style="padding-top:0px; padding-bottom:0px;">
				<input id="chkSelectAll" type="checkbox" class="nzb_check_all" />
				<label for="chkSelectAll" style="display:none;">Select All</label>
			</th>

			<th style="padding-top:0px; padding-bottom:0px;">name<br/>
				<a title="Sort Descending" href="{$orderbyname_desc}">
					<i class="fa fa-caret-down"></i>
				</a>
				<a title="Sort Ascending" href="{$orderbyname_asc}">
					<i class="fa fa-caret-up"></i>
				</a>
			</th>

			<th style="padding-top:0px; padding-bottom:0px;">category<br/>
				<a title="Sort Descending" href="{$orderbycat_desc}">
					<i class="fa fa-caret-down"></i>
				</a>
				<a title="Sort Ascending" href="{$orderbycat_asc}">
					<i class="fa fa-caret-up"></i>
				</a>
			</th>

			<th style="padding-top:0px; padding-bottom:0px;">posted<br/>
				<a title="Sort Descending" href="{$orderbyposted_desc}">
					<i class="fa fa-caret-down"></i>
				</a>
				<a title="Sort Ascending" href="{$orderbyposted_asc}">
					<i class="fa fa-caret-up"></i>
				</a>
			</th>

			<th style="padding-top:0px; padding-bottom:0px;">size<br/>
				<a title="Sort Descending" href="{$orderbysize_desc}">
					<i class="fa fa-caret-down"></i>
				</a>
				<a title="Sort Ascending" href="{$orderbysize_asc}">
					<i class="fa fa-caret-up"></i>
				</a>
			</th>

			<th style="padding-top:0px; padding-bottom:0px;">files<br/>
				<a title="Sort Descending" href="{$orderbyfiles_desc}">
					<i class="fa fa-caret-down"></i>
				</a>
				<a title="Sort Ascending" href="{$orderbyfiles_asc}">
					<i class="fa fa-caret-up"></i>
				</a>
			</th>
			<th>action</th>
		</tr>

		{foreach from=$results item=result}
		<tr class="{cycle values=",alt"}{if $lastvisit|strtotime<$result.adddate|strtotime} new{/if}" id="guid{$result.guid}">
			{if (strpos($category, '60') !== false)}
					<td class="check" width="25%"><input id="chk{$result.guid|substr:0:7}"
					 type="checkbox" class="nzb_check"
					 value="{$result.guid}"/>								 
					{if $result.jpgstatus == 1}
						<img width="250" height="150" src="{$smarty.const.WWW_TOP}/covers/sample/{$result.guid}_thumb.jpg" />
					{else}
						{if $result.haspreview == 1}
							<img width="250" height="150" src="{$smarty.const.WWW_TOP}/covers/preview/{$result.guid}_thumb.jpg" />
						{/if}
					{/if}
					</td>
				{else}
				<td class="check"><input id="chk{$result.guid|substr:0:7}"
				 type="checkbox" class="nzb_check"
				 value="{$result.guid}"/></td>
			{/if}

			<td class="item">
				<label for="chk{$result.guid|substr:0:7}">
					<a class="title" title="View details"  href="{$smarty.const.WWW_TOP}/details/{$result.guid}/{$result.searchname|escape:"seourl"}"><h5>{$result.searchname|escape:"htmlall"|replace:".":" "}</h5></a>
				</label>

				{if $result.passwordstatus == 2}
				<i class="fa fa-lock"></i>
				{elseif $result.passwordstatus == 1}
				<i class="fa fa-lock"></i>
				{/if}

				{if $userdata.canpre == 1 && $result.nuketype != ''}
				&nbsp;<img title="{$result.nuketype}" src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/nuke.png" width="10" height="10" alt="{$result.nuketype}" />
				{/if}

				<div class="resextra">
					<div class="btns">{strip}
						{if $result.nfoid > 0}
						<a href="{$smarty.const.WWW_TOP}/nfo/{$result.guid}" title="View Nfo" class="modal_nfo badge halffade" rel="nfo">Nfo</a> 
						{/if}

						{if $result.imdbid > 0}
						<a href="{$smarty.const.WWW_TOP}/movies?imdb={$result.imdbid}" title="View movie info" class="badge badge-inverse halffade" rel="movie" >Movie</a> 
						{/if}
						
						{if $result.haspreview == 1 && $userdata.canpreview == 1}
						<a href="{$smarty.const.WWW_TOP}/covers/preview/{$result.guid}_thumb.jpg" name="name{$result.guid}" 
						title="View Screenshot" class="modal_prev badge badge-success halffade" rel="preview">Preview</a> 
						{/if}

						{if $result.haspreview == 2 && $userdata.canpreview == 1}
						<a href="#" name="audio{$result.guid}" title="Listen to Preview" class="audioprev badge badge-success halffade" rel="audio">Listen</a> 
						<audio id="audprev{$result.guid}" src="{$smarty.const.WWW_TOP}/covers/audio/{$result.guid}.mp3" preload="none"></audio>
						{/if}

						{if $result.musicinfoid > 0}
						<a href="#" name="name{$result.musicinfoid}" title="View music info" class="modal_music badge badge-success halffade" rel="music" >Cover</a> 
						{/if}

						{if $result.consoleinfoID > 0}
						<a href="#" name="name{$result.consoleinfoID}" title="View console info" class="modal_console badge badge-success halffade" rel="console" >Cover</a> 
						{/if}

						{if $result.bookinfoid > 0}
						<a href="#" name="name{$result.bookinfoid}" title="View book info" class="modal_book badge badge-success halffade" rel="console" >Cover</a> 
						{/if}

						{if $result.rageid > 0}
						<a class="badge badge-inverse halffade" href="{$smarty.const.WWW_TOP}/series/{$result.rageid}" title="View all episodes">View Series</a> 
						{/if}

						{if $result.anidbidb > 0}
						<a class="badge badge-inverse halffade" href="{$smarty.const.WWW_TOP}/anime/{$result.anidbidb}" title="View all episodes">View Anime</a> 
						{/if}

						{if $result.tvairdate != ""}
						<span class="seriesinfo badge badge-success halffade" title="{$result.guid}">Aired {if $result.tvairdate|strtotime > $smarty.now}in future{else}{$result.tvairdate|daysago}
							{/if}
						</span> 
						{/if}

						{if $result.reid > 0}
						<span class="mediainfo badge badge-inverse halffade" title="{$result.guid}">Media</span> 
						{/if}
						
						{if $result.preid > 0 && $userdata.canpre == 1}
						<span class="preinfo badge badge-inverse halffade" title="{$result.searchname}">PreDB</span>
						{/if}
						
						{if $result.prehashid > 0}
						<span class="prehashinfo badge badge-inverse halffade" title="{$result.prehashid}">Prehash</span>
						{/if}

						{/strip}
					</div>
				</div>
			</td>
			
			<td class="less">
				<a title="Browse {$result.category_name}" href="{$smarty.const.WWW_TOP}/browse?t={$result.categoryid}">{$result.category_name}</a>
			</td>

			<td class="less mid" title="{$result.postdate}">{$result.postdate|timeago}</td>

			<td class="less right">
				{$result.size|fsize_format:"MB"}
				{if $result.completion > 0}<br />
				{if $result.completion < 100}
				<span class="label label-important">{$result.completion}%</span>
				{else}
				<span class="label label-success">{$result.completion}%</span>
				{/if}
				{/if}
			</td>
			<td class="less mid">
				<a title="View file list" href="{$smarty.const.WWW_TOP}/filelist/{$result.guid}">{$result.totalpart}</a> <i class="fa fa-file"></i>
				
				{if $result.rarinnerfilecount > 0}
				<div class="rarfilelist">
					<img src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/magnifier.png" alt="{$result.guid}" class="tooltip" />				
				</div>
				{/if}
			</td>
			<td class="icons" style='width:100px;'>
				<ul class="inline">
					<li>
						<a class="icon icon_nzb fa fa-download" style="text-decoration: none; color: #7ab800;" title="Download Nzb" href="{$smarty.const.WWW_TOP}/getnzb/{$result.guid}/{$result.searchname|escape:"url"}"></a>
					</li>
					<li>
						<a href="#" class="icon icon_cart fa fa-shopping-cart" style="text-decoration: none; color: #5c5c5c;" title="Add to Cart">
						</a>
					</li>
					{if $sabintegrated}
					<li>
						<a class="icon icon_sab fa fa-cloud-download" style="text-decoration: none; color: #008ab8;"  href="#" title="Send to queue">
						</a>
					</li>
					{/if}
					{if $nzbgetintegrated}
					<li>
						<a class="icon icon_nzb fa fa-downloadget" href="#" title="Send to NZBGet">
							<img class="icon icon_nzb fa fa-downloadget" alt="Send to my NZBGet" src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/nzbgetup.png">
						</a>
					</li>
					{/if}
                    {if $weHasVortex}
                        <li>
                            <a class="icon icon_nzb fa fa-downloadvortex" href="#" title="Send to NZBVortex">
                                <img class="icon icon_nzb fa fa-downloadvortex" alt="Send to my NZBVortex" src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/vortex/bigsmile.png">
                            </a>
                        </li>
                    {/if}
				</ul>
			</td>
		</tr>
		{/foreach}
	</table>

	{if $results|@count > 10}
	<div class="well well-small">
		<div class="nzb_multi_operations">
			<table width="100%">
				<tr>
					<td width="30%">
						With Selected:
						<div class="btn-group">
							<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
							<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
							{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to queue" />{/if}
							{if $nzbgetintegrated}<input type="button" class="nzb_multi_operations_nzbget btn btn-small btn-primary" value="Send to NZBGet" />{/if}
						</div>
						{if (strpos($category, '60')  !== false)}
							&nbsp;&nbsp;&nbsp;&nbsp;<a title="Switch to Cover view" href="{$smarty.const.WWW_TOP}/xxx"><i class="fa fa-lg fa-file-image-o"></i></a>
						{/if}
						{if (strpos($category, '20') !== false)}
							&nbsp;&nbsp;&nbsp;&nbsp;<a title="Switch to Cover view" href="{$smarty.const.WWW_TOP}/movies"><i class="fa fa-lg fa-file-image-o"></i></a>
						{/if}
					</td>
					<td width="50%">
						<center>
							{$pager}
						</center>
					</td>
					<td width="20%">
						<div class="pull-right">
						{if $isadmin}
							Admin: 	
							<div class="btn-group">	
								<input type="button" class="nzb_multi_operations_edit btn btn-small btn-warning" value="Edit" />
								<input type="button" class="nzb_multi_operations_delete btn btn-small btn-danger" value="Delete" />
							</div>
						{/if}
						{if $section != ''}
							<a href="{$smarty.const.WWW_TOP}/{$section}?t={$category}"><i class="fa fa-th-list"></i></a>
						{/if}
						{if (strpos($category, '60')  !== false)}
								<a href="{$smarty.const.WWW_TOP}/xxx"><i class="fa fa-lg fa-file-image-o"></i></a>
						{/if}
						{if (strpos($category, '20') !== false)}
							<a href="{$smarty.const.WWW_TOP}/movies"><i class="fa fa-lg fa-file-image-o"></i></a>
						{/if}
						&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	{/if}
	
</form>

{else}
<div class="alert">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>Sorry!</strong> There is nothing here at the moment.
</div>
{/if}