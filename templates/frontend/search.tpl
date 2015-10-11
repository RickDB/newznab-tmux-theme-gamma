<h2>Search</h2>
<div style="display:none;text-align:right;">
	<a href="#" onclick="if(jQuery(this).text()=='Advanced Search')jQuery(this).text('Basic Search');else jQuery(this).text('Advanced Search');jQuery('#sbasic,#sadvanced').toggle();return false;">{if $sadvanced}Basic{else}Advanced{/if} Search</a>
</div>
<div class="navbar">
	<div class="navbar-inner">
		<form method="get" class="navbar-form pull-left" action="{$smarty.const.WWW_TOP}/search">
			<div id="sbasic" style="text-align:center;{if $sadvanced} display:none;{/if}">
				<div class="input-append">
				<input id="search" class="input-large" name="search" value="{$search|escape:'html'}" type="text" placeholder="What are you looking for?" />
				<input id="search_search_button" class="btn btn-success" type="submit" value="Search" />
				</div>
				<input type="hidden" name="t" value="{if $category[0]!=""}{$category[0]}{else}-1{/if}" id="search_cat" />
				<input type="hidden" name="search_type" value="basic" id="search_type" />
			</div>
		</form>
	</div>
</div>

<form method="get" action="{$smarty.const.WWW_TOP}/search">
	<div id="sadvanced" {if not $sadvanced}style="display:none"{/if}>
		<center>
		<table class="data">
			<tr>
				<th><label for="searchadvr">Release Name</label>:</th>
				<td><input id="searchadvr" name="searchadvr" value="{$searchadvr|escape:'html'}" type="text"/></td>
			</tr>
			<tr>
				<th><label for="searchadvf">Filename</label>:</th>
				<td><input id="searchadvf" name="searchadvf" value="{$searchadvf|escape:'html'}" type="text"/></td>
			</tr>			
			<tr>
				<th><label for="searchadvposter">Poster</label>:</th>
				<td><input id="searchadvposter" name="searchadvposter" value="{$searchadvposter|escape:'html'}" type="text"/></td>
			</tr>				
			<tr>
				<th><label for="searchadvgroups">Group</label>:</th>
				<td>{html_options id="searchadvgroups" name=searchadvgroups options=$grouplist selected=$selectedgroup}</td>
			</tr>
			<tr>
				<th><label for="searchadvcat">Category</label>:</th>
				<td>{html_options id="searchadvcat" name=searchadvcat options=$catlist selected=$selectedcat}</td>
			</tr>
			<tr>
				<th><label for="searchadvsizefrom">Size Between</label>:</th>
				<td>
					{html_options id="searchadvsizefrom" name=searchadvsizefrom options=$sizelist selected=$selectedsizefrom}
					and {html_options id="searchadvsizeto" name=searchadvsizeto options=$sizelist selected=$selectedsizeto}
				</td>
			</tr>	
			<tr>
				<th></th>
				<td>
					<input type="hidden" name="search_type" value="adv" id="search_type" />
					<input id="search_adv_button" type="submit" value="search" />
				</td>
			</tr>
		</table>
		</center>
	</div>
</form>

{if $results|@count == 0 && $search != ""}
	<div class="alert alert-block">
		<h4>No result!</h4>
		Your search - <strong>{$search|escape:'htmlall'}</strong> - did not match any releases.
		<br/><br/>
		Suggestions:
		<br/><br/>
		<ul>
		<li>Make sure all words are spelled correctly.</li>
		<li>Try different keywords.</li>
		<li>Try more general keywords.</li>
		<li>Try fewer keywords.</li>
		</ul>
	</div>
{elseif $search == ""}
{else}

{$site->adbrowse}	

<form style="padding-top:10px;" id="nzb_multi_operations_form" method="get" action="{$smarty.const.WWW_TOP}/search">

	<form id="nzb_multi_operations_form" action="get">
		<div class="well well-small">
			<div class="nzb_multi_operations">
				<table width="100%">
					<tr>
						<td width="33%">
							With Selected:
							<div class="btn-group">
								<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
								<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
								{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to queue" />{/if}
								{if $nzbgetintegrated}<input type="button" class="nzb_multi_operations_nzbget btn btn-small btn-primary" value="Send to NZBGet" />{/if}
							</div>
						</td>
						<td width="33%">
							<center>
								{$pager}
							</center>
						</td>
						<td width="33%">
							<div class="pull-right">
							<a class="btn btn-small" title="All releases in your shows as an RSS feed" href="{$smarty.const.WWW_TOP}/rss?t={$category[0]}&amp;dl=1&amp;i={$userdata.id}&amp;r={$userdata.rsstoken}&amp;uFilter={$search|escape:'html'}">Rss <i class="fa fa-rss"></i></a>
							{if $isadmin}
									Admin: 	
									<div class="btn-group">	
										<input type="button" class="nzb_multi_operations_edit btn btn-small btn-warning" value="Edit" />
										<input type="button" class="nzb_multi_operations_delete btn btn-small btn-danger" value="Delete" />
									</div>
									&nbsp;
								{/if}
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
		<th style="padding-top:0px; padding-bottom:0px;"></th>
	</tr>

	{foreach from=$results item=result}
		<tr class="{cycle values=",alt"}{if $lastvisit|strtotime<$result.adddate|strtotime} new{/if}" id="guid{$result.guid}">
			{if (strpos($category[0], '60') !== false)}
					<td class="check" width="25%"><input id="chk{$result.guid|substr:0:7}"
					 type="checkbox" class="nzb_check"
					 value="{$result.guid}"/>
					 
					{if $result.jpgstatus == 1}
						<img width="363" height="450" src="{$smarty.const.WWW_TOP}/covers/sample/{$result.guid}_thumb.jpg" />
					{else}
						{if $result.haspreview == 1}
							<img width="400" height="250" src="{$smarty.const.WWW_TOP}/covers/preview/{$result.guid}_thumb.jpg" />
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
					<a class="title" title="View details" href="{$smarty.const.WWW_TOP}/details/{$result.guid}/{$result.searchname|escape:"seourl"}">
						<h5>{$result.searchname|escape:"htmlall"|replace:".":" "}</h5>
					</a>
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

						{if $result.preid > 0 && $userdata.canpre == 1}
						<span class="preinfo badge halffade" title="{$result.searchname}">Pre'd {$result.ctime|timeago}</span> 
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

						{/strip}
					</div>
				</div>
			</td>
			
			<td width="100px" class="less">
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
			</td>
			<td class="icons" style='width:100px;'>
				<ul class="inline">
					<li>
						<a class="icon icon_nzb fa fa-download" style="text-decoration: none; color: #7ab800;" title="Download Nzb" href="{$smarty.const.WWW_TOP}/getnzb/{$result.guid}/{$result.searchname|escape:"url"}"></a>
					</li>
					<li>
						<a href="#" class="icon icon_cart fa fa-shopping-cart" style="text-decoration: none;  color: #5c5c5c;" title="Add to Cart">
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
<br/>

{if $results|@count > 10}
<div class="well well-small">
	<div class="nzb_multi_operations">
		<table width="100%">
			<tr>
				<td width="33%">
					With Selected:
					<div class="btn-group">
						<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
						<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
						{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to queue" />{/if}
						{if $nzbgetintegrated}<input type="button" class="nzb_multi_operations_nzbget btn btn-small btn-primary" value="Send to NZBGet" />{/if}
					</div>
				</td>
				<td width="33%">
					<center>
						{$pager}
					</center>
				</td>
				<td width="33%">
					{if $isadmin}
						<div class="pull-right">
							Admin: 	
							<div class="btn-group">	
								<input type="button" class="nzb_multi_operations_edit btn btn-small btn-warning" value="Edit" />
								<input type="button" class="nzb_multi_operations_delete btn btn-small btn-danger" value="Delete" />
							</div>
							&nbsp;
						</div>
						{/if}
				</td>
			</tr>
		</table>
	</div>
</div>
{/if}
</form>

{/if}