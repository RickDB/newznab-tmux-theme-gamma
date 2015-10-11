{if $results|@count > 0}
	{foreach from=$results item=result}
		
		<div id="moviefull" style="min-height:340px;">
		{if $result.cover == 1}<img class="shadow pic img-polaroid pull-right" style="margin-right:50px;" width="200px" alt="{$result.title|escape:"htmlall"} Logo" src="{$smarty.const.WWW_TOP}/covers/movies/{$result.imdbid}-cover.jpg" />{/if}
		

		<h2 style="display:inline;">{$result.title|escape:"htmlall"} ({$result.year})</h2>    <a class="rndbtn badge badge-imdb" target="_blank" href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbid}/" name="imdb{$result.imdbid}" title="View imdb page">Imdb</a>
		<a class="rndbtn badge badge-trakt" target="_blank" href="{$site->dereferrer_link}http://trakt.tv/search/imdb/tt{$result.imdbid}/" name="trakt{$result.imdbid}" title="View trakt page">Trakt</a>
		{if $result.imdbid != ""}
			<a {if $userimdbs[$result.imdbid] != ""}style="display:none;"{/if} onclick="mymovie_add('{$result.imdbid}', this);return false;" class="rndbtn btn btn-mini btn-info" href="#">Add To My Movies</a>
		{/if}
		<h4>{if $result.genre != ''}{$result.genre|replace:"|":" / "}{/if}</h4>
		
		
		{if $result.tagline != ''}
			<p class="lead" style="margin-right:300px;">"{$result.tagline|escape:"htmlall"}"</p>
		{/if}
		
		
		<dl style="margin-right:300px;">
			{if $result.plot != ''}
				<dt>Plot</dt>
				<dd>{$result.plot|escape:"htmlall"}</dd>
			{/if}
			{if $result.rating != ''}
				<dt>Rating</dt>
				<dd>{$result.rating}/10 {if $result.ratingcount != ''}({$result.ratingcount|number_format} votes)</dd>{/if}
			{/if}
			{if $result.director != ''}
				<dt>Director</dt> 
				<dd>{$result.director|replace:"|":", "}</dd>
			{/if}
			{if $result.actors != ''}
				<dt>Actors</dt> 
				<dd>{$result.actors|replace:"|":", "}</dd>
			{/if}
		</dl>
		
		
		</div>
		
		<form id="nzb_multi_operations_form" action="get">
		<div class="well well-small">
			<div class="nzb_multi_operations">
				{if $section != ''}View: <a href="{$smarty.const.WWW_TOP}/{$section}?t={$category}">Covers</a> | <b>List</b><br />{/if}
				With Selected:
				<div class="btn-group">
					<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
					<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
					{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to queue" />{/if}
					{if $nzbgetintegrated}<input type="button" class="nzb_multi_operations_nzbget btn btn-small btn-primary" value="Send to NZBGet" />{/if}
				</div>
				{if $isadmin}
				<div class="pull-right">
					Admin: 	
					<div class="btn-group">	
						<input type="button" class="nzb_multi_operations_edit btn btn-small btn-warning" value="Edit" />
						<input type="button" class="nzb_multi_operations_delete btn btn-small btn-danger" value="Delete" />
					</div>
				</div>
				<div class="btn-group pull-right">
					<div class="input-append">
						<input class="span2"  id="filter-text" type="text">
						<span class="add-on"><i class="fa-icon-search"></i></span>
					</div>
				</div>

				<div class="btn-group pull-right" data-toggle="buttons-radio" id="filter-quality">
					<button data-quality="" class="btn btn-primary active">Any</button>
					<button data-quality="720p" class="btn btn-primary">720p</button>
					<button data-quality="1080p" class="btn btn-primary">1080p</button>
					<button data-quality="complete bluray" class="btn btn-primary">BDISK</button>
				</div>
				{/if}	
			</div>
		</div>
		
		<table style="width:100%;" class="data highlight icons table table-striped" id="browsetable">
			<tr class="dont-filter"> 
				<th>
					<input id="chkSelectAll" type="checkbox" class="nzb_check_all" />
					<label for="chkSelectAll" style="display:none;">Select All</label>
				</th>

				<th>name<br/>
					<a title="Sort Descending" href="{$orderbyname_desc}">
						<i class="fa-icon-caret-down"></i>
					</a>
					<a title="Sort Ascending" href="{$orderbyname_asc}">
						<i class="fa-icon-caret-up"></i>
					</a>
				</th>

				<th>category<br/>
					<a title="Sort Descending" href="{$orderbycat_desc}">
						<i class="fa-icon-caret-down"></i>
					</a>
					<a title="Sort Ascending" href="{$orderbycat_asc}">
						<i class="fa-icon-caret-up"></i>
					</a>
				</th>

				<th>posted<br/>
					<a title="Sort Descending" href="{$orderbyposted_desc}">
						<i class="fa-icon-caret-down"></i>
					</a>
					<a title="Sort Ascending" href="{$orderbyposted_asc}">
						<i class="fa-icon-caret-up"></i>
					</a>
				</th>

				<th>size<br/>
					<a title="Sort Descending" href="{$orderbysize_desc}">
						<i class="fa-icon-caret-down"></i>
					</a>
					<a title="Sort Ascending" href="{$orderbysize_asc}">
						<i class="fa-icon-caret-up"></i>
					</a>
				</th>

				<th>files<br/>
					<a title="Sort Descending" href="{$orderbyfiles_desc}">
						<i class="fa-icon-caret-down"></i>
					</a>
					<a title="Sort Ascending" href="{$orderbyfiles_asc}">
						<i class="fa-icon-caret-up"></i>
					</a>
				</th>

				<th>action</th>
			</tr>

		{assign var="msplits" value=","|explode:$result.grp_release_id}
		{assign var="mguid" value=","|explode:$result.grp_release_guid}
		{assign var="mnfo" value=","|explode:$result.grp_release_nfoID}
		{assign var="mgrp" value=","|explode:$result.grp_release_grpname}
		{assign var="mname" value="#"|explode:$result.grp_release_name}
		{assign var="mpostdate" value=","|explode:$result.grp_release_postdate}
		{assign var="msize" value=","|explode:$result.grp_release_size}
		{assign var="mtotalparts" value=","|explode:$result.grp_release_totalparts}
		{assign var="mcomments" value=","|explode:$result.grp_release_comments}
		{assign var="mgrabs" value=","|explode:$result.grp_release_comments}
		{assign var="mpass" value=","|explode:$result.grp_release_password}
		{assign var="minnerfiles" value=","|explode:$result.grp_rarinnerfilecount}
		{assign var="mhaspreview" value=","|explode:$result.grp_haspreview}
		{assign var="mcat" value=","|explode:$result.grp_release_categoryID}
		{assign var="mcatname" value=","|explode:$result.grp_release_categoryName}
		
		{foreach from=$msplits item=m}

			<tr class="{cycle values=",alt"} filter"data-name="{$mname[$m@index]|escape:"htmlall"|replace:".":" "|lower}" id="guid{$mguid[$m@index]}">
				<td class="check"><input id="chk{$mguid[$m@index]|substr:0:7}" type="checkbox" class="nzb_check" value="{$mguid[$m@index]}" /></td>
				<td class="item">
					<label for="chk{$mguid[$m@index]|substr:0:7}">
						<a class="title" title="View details" href="{$smarty.const.WWW_TOP}/details/{$mguid[$m@index]}/{$mname[$m@index]|escape:"seourl"}">{$mname[$m@index]|escape:"htmlall"|replace:".":" "}</a>
					</label>
					
					{if $mpass[$m@index] == 2}
						<i class="fa-icon-lock"></i>
					{elseif $mpass[$m@index] == 1}
						<i class="fa-icon-lock"></i>
					{/if}
					
					<div class="resextra">
						<div class="btns">{strip}
							{if $mnfo[$m@index] > 0}<a href="{$smarty.const.WWW_TOP}/nfo/{$mguid[$m@index]}" title="View Nfo" class="modal_nfo rndbtn badge" rel="nfo">Nfo</a>{/if}
							{if $mhaspreview[$m@index] == 1 && $userdata.canpreview == 1}<a href="{$smarty.const.WWW_TOP}/covers/preview/{$mguid[$m@index]}_thumb.jpg" name="name{$mguid[$m@index]}" title="View Screenshot" class="modal_prev rndbtn badge" rel="preview">Preview</a>{/if}
							{if $mre[$m@index] > 0}<span class="mediainfo rndbtn badge" title="{$mguid[$m@index]}">Media</span>{/if}
						{/strip}</div>
					</div>
				</td>
				<td class="less"><a title="Browse {$mcatname[$m@index]}" href="{$smarty.const.WWW_TOP}/browse?t={$mcat[$m@index]}">{$mcatname[$m@index]}</a></td>
				<td class="less mid" title="{$mpostdate[$m@index]}">{$mpostdate[$m@index]|timeago}</td>
				<td class="less right">{$msize[$m@index]|fsize_format:"MB"}</td>
				<td class="less mid">
					<a title="View file list" href="{$smarty.const.WWW_TOP}/filelist/{$mguid[$m@index]}">{$mtotalparts[$m@index]}</a>
					{if $minnerfiles[$m@index] > 0}
						<div class="rarfilelist">
							<i class="fa-icon-search"></i>				
						</div>
					{/if}
				</td>
				
				<td class="icons">
					<div class="icon icon_nzb">
						<a title="Download Nzb" href="{$smarty.const.WWW_TOP}/getnzb/{$mguid[$m@index]}/{$mname[$m@index]|escape:"url"}">
							<img src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/nzbup.png"/>
						</a>
					</div>
					<div class="icon icon_cart" title="Add to Cart">
						<img src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/cartup.png"/>
					</div>
					{if $sabintegrated}
						<div class="icon">
							<div id="sab">
								<div class="icon_sab" title="Send to my Queue">	
									<img src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/queueup.png"/>
								</div>
							</div>
						</div>
					{/if}
					{if $nzbgetintegrated}
						<div class="icon">
							<a class="icon icon_nzbgetMovieinfo" id="{$mguid[$m@index]}" href="#" title="Send to my NZBGet">
								<img src="{$smarty.const.WWW_TOP}/themes/gamma/images/icons/nzbgetup.png"/>
							</a>
						</div>
					{/if}
				</td>
			</tr>
		{/foreach}	

	</table>
	</div>
	<br/>
	
	{$pager}
	{if $results|@count > 10}
		<div class="well well-small">
			<div class="nzb_multi_operations">
				{if $section != ''}View: <a href="{$smarty.const.WWW_TOP}/{$section}?t={$category}">Covers</a> | <b>List</b><br />{/if}
				With Selected:
				<div class="btn-group">
					<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
					<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
					{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to queue" />{/if}
					{if $nzbgetintegrated}<input type="button" class="nzb_multi_operations_nzbget btn btn-small btn-primary" value="Send to NZBGet" />{/if}
				</div>
				<div class="btn-group pull-right">
					<div class="input-append">
						<input class="span2" id="filter-text" type="text">
						<span class="add-on"><i class="icon-search"></i></span>
					</div>
				</div>

				<div class="btn-group pull-right" data-toggle="buttons-radio" id="filter-quality">
					<button data-quality="" class="btn active">Any</button>
					<button data-quality="720p" class="btn">720p</button>
					<button data-quality="1080p" class="btn">1080p</button>
					<button data-quality="complete Rbluray" class="BDISK">HDTV</button>
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
	
		</form>
	{/if}
	{/foreach}
{/if}
<script type="text/javascript">
	$(document).ready(function(){
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