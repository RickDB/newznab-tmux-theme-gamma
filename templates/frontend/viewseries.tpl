{if $nodata != ""}

<h2>View TV Series</h2>

<div class="alert">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>Sorry!</strong>
	{$nodata}
</div>
{else}

<h2>
	{foreach $rage as $r}
	{if $isadmin}
	<a title="Edit rage data" href="{$smarty.const.WWW_TOP}/admin/rage-edit.php?id={$r.id}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}">{$r.releasetitle} </a>
	{else}
	{$r.releasetitle} 
	{/if}
	{if !$r@last} / {/if}
	{/foreach}

	{if $catname != ''} in {$catname|escape:"htmlall"}{/if}

</h2>

<div>
	<b><a title="Manage your shows" href="{$smarty.const.WWW_TOP}/myshows">My Shows</a></b>:
	<div class="btn-group">

		{if $myshows.id != ''}
		<a class="btn btn-mini btn-warning" href="{$smarty.const.WWW_TOP}/myshows/edit/{$rage[0].rageid}?from={$smarty.server.REQUEST_URI|escape:"url"}" class="myshows" rel="edit" name="series{$rage[0].rageid}" title="Edit Categories for this show">Edit</a> | 
		<a class="btn btn-mini btn-danger" href="{$smarty.const.WWW_TOP}/myshows/delete/{$rage[0].rageid}?from={$smarty.server.REQUEST_URI|escape:"url"}" class="myshows" rel="remove" name="series{$rage[0].rageid}" title="Remove from My Shows">Remove</a>
		{else}
		<a class="btn btn-mini btn-success" href="{$smarty.const.WWW_TOP}/myshows/add/{$rage[0].rageid}?from={$smarty.server.REQUEST_URI|escape:"url"}" class="myshows" rel="add" name="series{$rage[0].rageid}" title="Add to My Shows">Add</a>
		{/if}
	</div>
</div>

<div class="tvseriesheading">
	{if $rage[0].imgdata != ""}
	<center>
		<img class="shadow img img-polaroid" style="max-height:300px;" alt="{$rage[0].releasetitle} Logo" src="{$smarty.const.WWW_TOP}/covers/tvrage/{$rage[0].rageid}.jpg" />
	</center>
	<br/>
	{/if}
	<p>
		{if $seriesGenre != ''}<b>{$seriesgenre}</b><br />{/if}
		<span class="descinitial">{$seriesdescription|escape:"htmlall"|nl2br|magicurl}</span>
	</p>

</div>

<center>
	<div class="btn-group">
		{if $rage|@count == 1 && $isadmin}
		<a class="btn btn-small" href="{$smarty.const.WWW_TOP}/admin/rage-edit.php?id={$r.id}&amp;action=update&amp;from={$smarty.server.REQUEST_URI|escape:"url"}">Update From Tv Rage</a>
		{/if}
		<a class="btn btn-small btn-primary" target="_blank" href="{$site->dereferrer_link}http://trakt.tv/search/tvrage/{$rage[0].rageid}" title="View on Trakt">View on Trakt</a>
		<a class="btn btn-small" href="{$smarty.const.WWW_TOP}/rss?rage={$rage[0].rageid}{if $category != ''}&amp;t={$category}{/if}&amp;dl=1&amp;i={$userdata.id}&amp;r={$userdata.rsstoken}">Rss for this Series <i class="fa-icon-rss"></i></a>
	</div>
</center>

<br/>

<form id="nzb_multi_operations_form" action="get">

	<div class="well well-small">
		<div class="nzb_multi_operations">
			With Selected:
			<div class="btn-group">
				<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
				<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
				{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to queue" />{/if}
				{if $nzbgetintegrated}<input type="button" class="nzb_multi_operations_nzbget btn btn-small btn-primary" value="Send to NZBGet" />{/if}
			</div>

		    <div class="btn-group pull-right">
		        <div class="input-append">
                    <input class="span2"  id="filter-text" type="text">
                    <span class="add-on"><i class="fa-icon-search"></i></span>
                </div>
		    </div>

		    <div class="btn-group pull-right" data-toggle="buttons-radio" id="filter-quality">
		        <button data-quality="" class="btn active">Any</button>
		        <button data-quality="hdtv" class="btn">HDTV</button>
		        <button data-quality="720p" class="btn">720p</button>
		        <button data-quality="1080p" class="btn">1080p</button>
		    </div>

			{if $isadmin}
			<div class="pull-right">
				Admin: 	
				<div class="btn-group">	
					<input type="button" class="nzb_multi_operations_edit btn btn-small btn-warning" value="Edit" />
					<input type="button" class="nzb_multi_operations_delete btn btn-small btn-danger" value="Delete" />
				</div>
			</div>
			{/if}	
		</div>
	</div>

	<script type="text/javascript">
        $(document).ready(function(){
            var ul = $('div.tabbable ul.nav').prepend('<ul id="filters">');

            function filter(event){
                var elements = $('table.data:visible tr.filter');
                elements.hide();

                /* quality filter */
                x = event;
                //if(event.currentTarget.at)
                if(event.target.dataset.quality != undefined){
                    var quality = event.target.dataset.quality;
                }else{
                    var quality = $('#filter-quality button.active').data('quality');
                }
                if(quality){
                    elements = elements.filter('[data-name*="' + quality + '"]');
                }

                var values = $('#filter-text').val().split(/\s+/);
                var i = values.length;
                while(i--){
                    var value = values[i];
                    //console.log('value', value);
                    if(value)elements = elements.filter('[data-name*="' + values[i] + '"]');
                }
                elements.show();
            }
            $('#filter-text').click(filter).blur(filter).keyup(filter);
            $('#filter-quality button').mouseup(filter);
        });
	</script>

	<br clear="all" />

	<a id="latest"></a>



	<div class="tabbable">
		<ul class="nav nav-tabs">
			{foreach $seasons as $seasonnum => $season name="seas"}
			<li {if $smarty.foreach.seas.first}class="active"{/if}><a title="View Season {$seasonnum}" href="#{$seasonnum}" data-toggle="tab">{$seasonnum}</a></li>
			{/foreach}
		</ul>

		<div class="tab-content">
			{foreach $seasons as $seasonnum => $season name=tv}
			<div class="tab-pane{if $smarty.foreach.tv.first} active{/if}" id="{$seasonnum}">
				<table class="tb_{$seasonnum} data highlight icons table table-striped" id="browsetable">
					<tr class="dont-filter">
						<th>Ep</th>
						<th>Name</th>
						<th><input id="chkSelectAll{$seasonnum}" type="checkbox" name="{$seasonnum}" class="nzb_check_all_season" /><label for="chkSelectAll{$seasonnum}" style="display:none;">Select All</label></th>
						<th>Category</th>
						<th style="text-align:center;">Posted</th>
						<th width="80" >Size</th>
						<th>Files</th>
						<th>Stats</th>
						<th></th>
					</tr>
					{foreach $season as $episodes}
					{foreach $episodes as $result}

					{if $result@index == 0}
					<tr class="{cycle values=",alt"} dont-filter">
						<td style="padding-top: 20px;" colspan="8" class="static"><h4 style="height: 0px; margin-top: 20px; margin-bottom: -50px;">{$episodes@key}</h4></td>
					</tr>
					{/if}

					<tr class="{cycle values=",alt"} filter" id="guid{$result.guid}" data-name="{$result.searchname|escape:"htmlall"|lower|replace:".":" "}">
						<td width="20" class="static"></td>
						<td>
							<a title="View details" href="{$smarty.const.WWW_TOP}/details/{$result.guid}/{$result.searchname|escape:"seourl"}"><h5>{$result.searchname|escape:"htmlall"|replace:".":" "}</h5></a>

							<div class="resextra">
								<div class="btns">
									{if $result.nfoID > 0}<a href="{$smarty.const.WWW_TOP}/nfo/{$result.guid}" title="View Nfo" class="modal_nfo rndbtn badge halffade" rel="nfo">Nfo</a>{/if}
									{if $result.haspreview == 1 && $userdata.canpreview == 1}<a href="{$smarty.const.WWW_TOP}/covers/preview/{$result.guid}_thumb.jpg" name="name{$result.guid}" title="View Screenshot" class="modal_prev rndbtn badge halffade" rel="preview">Preview</a>{/if}
									{if $result.tvairdate != ""}<span class="rndbtn badge badge-success halffade" title="{$result.tvtitle} Aired on {$result.tvairdate|date_format}">Aired {if $result.tvairdate|strtotime > $smarty.now}in future{else}{$result.tvairdate|daysago}{/if}</span>{/if}
									{if $result.reid > 0}<span class="mediainfo rndbtn badge halffade" title="{$result.guid}">Media</span>{/if}
								</div>
							</div>
						</td>
						<td class="check"><input id="chk{$result.guid|substr:0:7}" type="checkbox" class="nzb_check" name="{$seasonnum}" value="{$result.guid}" /></td>
						<td class="less"><a title="This series in {$result.category_name}" href="{$smarty.const.WWW_TOP}/series/{$result.rageid}?t={$result.categoryid}">{$result.category_name}</a></td>
						<td class="less mid" width="40" title="{$result.postdate}">{$result.postdate|timeago}</td>
						
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
							<a title="View file list" href="{$smarty.const.WWW_TOP}/filelist/{$result.guid}">{$result.totalpart}</a> <i class="fa-icon-file"></i>
							
							{if $result.rarinnerfilecount > 0}
							<div class="rarfilelist">
								<img src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/magnifier.png" alt="{$result.guid}" class="tooltip" />				
							</div>
							{/if}							
						</td>
						<td width="40" class="less nowrap">
							<a title="View comments for {$result.searchname|escape:"htmlall"}" href="{$smarty.const.WWW_TOP}/details/{$result.guid}/#comments">{$result.comments} <i class="fa-icon-comments-alt"></i></a>
						</td>
						<td class="icons" style='width:100px;'>
							<ul class="inline">
								<li>
									<div class="icon icon_nzb">
										<a title="Download Nzb" href="{$smarty.const.WWW_TOP}/getnzb/{$result.guid}/{$result.searchname|escape:"url"}"><img src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/nzbup.png"></a>
									</div>
								</li>
								<li>
									<a class="icon icon_cart" href="#" title="Add to Cart">
										<img src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/cartup.png">
									</a>
								</li>
								{if $sabintegrated}
								<li>
									<a class="icon icon_sab" href="#" title="Send to queue">
										<img class="icon icon_sab" alt="Send to my Sabnzbd" src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/queueup.png">
									</a>
								</li>
								{/if}
								{if $nzbgetintegrated}
								<li>
									<a class="icon icon_nzbget" href="#" title="Send to NZBGet">
										<img class="icon icon_nzbget" alt="Send to my NZBGet" src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/nzbgetup.png">
									</a>
								</li>
								{/if}
                                {if $weHasVortex}
                                    <li>
                                        <a class="icon icon_nzbvortex" href="#" title="Send to NZBVortex">
                                            <img class="icon icon_nzbvortex" alt="Send to my NZBVortex" src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/vortex/bigsmile.png">
                                        </a>
                                    </li>
                                {/if}
							</ul>
						</td>
					</tr>
					{/foreach}
					{/foreach}
				</table>
			</div>
			{/foreach}
		</div>
	</div>
</form>
{/if}