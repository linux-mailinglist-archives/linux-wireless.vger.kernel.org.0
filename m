Return-Path: <linux-wireless+bounces-23419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F179AC3D26
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C483B8A51
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C11E1C02;
	Mon, 26 May 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kW53G5X0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+DQhnPO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD91DDC00;
	Mon, 26 May 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252690; cv=none; b=eiziAKgIC+CD1fJCKXluSZ4F6pvbCNExPIXUO+ysdQ6sALTHeh5UthZhH8JBIgr9HEJldfVtN3IFG1W35hPd6UGtyd0FkDwbVI2Kgd8TiEARx9NzAC4Ea/h6uuTKdQ/1+vsBvLmEr60+90oo4J6+Ig+y5uFMeJNtj3/u7qw2hTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252690; c=relaxed/simple;
	bh=bb98zN70alBi04NywXfw0P2mmtqlU0HLOtZ6Cu7eZmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCVV2kHpPmgBHFmDIT/wGBbhuZKIE9k0KhkyS4Dwmx8Wv7E+UlnC59wrVHZuHE7wqzroQM+gCbZ4yz2OorOP3bwp0z9nKBr/rKJ6Th+PIP54vOWTsinlnGs44lhbUSwpyoGowSEIx9QFXVkTshJM52yCEH4onLyphhyGgvrPDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=kW53G5X0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+DQhnPO; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1459A1140145;
	Mon, 26 May 2025 05:44:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 May 2025 05:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748252685; x=1748339085; bh=2s1FVRH8ze
	XTYEXSnFTRCvOwlP/FaIIrpYPPnfZTWeg=; b=kW53G5X0MDr+cwcxkNHxyjQokg
	m6egZZtU18nuddTtqCurOLqEJ7oecTDJTjjsmQ0ppp4t3yhL3MCbUqSp3c7AsDE9
	MeqZ7fGFjqDmMjU7P9Bzhw7Ba5eX18RtG26YI+cS6b+R80F2BI5saEK+9ondWWIF
	ln5Ga5lmh4JTsFp773j3jwwkCkYFDc1+PkGU2Q3D90wJI0WRlob1mdmkpP3emT/k
	RYMD3No5ccuslcDv0BK1wH69+oDlrBuIcDFp6OIpqskrJ772b1B2aaNwDf+dTKlI
	RvajcWNxoKfNgoUI8kyMmcysDfXQQqyNjKammE4MNLApgJuLpQYDTik82HxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748252685; x=1748339085; bh=2s1FVRH8zeXTYEXSnFTRCvOwlP/FaIIrpYP
	PnfZTWeg=; b=f+DQhnPOBd1mblLJF+FxzCUpNxI4F1yuj2o6Byy9u6lt0nlze8R
	Jt0RoDkXOG88kS52ATPYGbEKO7QXRVhKg4Vkn+Xgl8pzw4/40d+r+P9qkBwu7EaR
	2felheDGHzGFF3miBWvGABY2cjpJMyrGuSPUBLLi4peigOeWAl8DP8aWz9OXYtNB
	9ZRAnYA8l501jvQhvTS6U4Ys2ll5RwEgHAJvtSU63QTfZdSEtvQVvCwbSx/sZkbb
	w/PcsUWQFk5Z/G37ADlC+8vrmE+rX90jXpn1TxVKCNgRSlf/X63bjyeKGjxCj7tr
	cOpc6W6TTcbHLKsYkAcBKoi/eSD5+IwXPJA==
X-ME-Sender: <xms:DTg0aDzqpmImc7Kn4A9Ve2jiLFKJJFCMARf5zOWXcrWqBysCekF7PQ>
    <xme:DTg0aLS_yTZYHReJhfed8LBk11cfuZoxkqNCbI0nBccbtH1LPzYXVlGDqDIMYl4-0
    eOQ5Ze2CDBH_A>
X-ME-Received: <xmr:DTg0aNWvcl89EMPWsiiBfmnMEwzuSksDEAtgkjQ5ZjHbr3S9u3II-YJazZ7s1f2cDkiNm5mXPqxYzQ39FgwTpr2ELJMtrTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujedvtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    ifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnh
    epgeegkeeugefffeevjeelleduhfetkeefveehiefhheejfeejtefgfeejtdevhfeknecu
    ffhomhgrihhnpegvrhhrohhrrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhulhgrsgesihhstg
    grshdrrggtrdgtnhdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhsohhluhhtihho
    nhhsrdhnvghtpdhrtghpthhtoheplhhutghirghnohdrtghovghlhhhosehinhhtvghlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:DTg0aNinDcEcvYecpixnBVUZcwhHkkmm8EywxABOCoka2pN6h3lcAg>
    <xmx:DTg0aFBLAL8yE1M5Dy7IcGFgRSm-YWK7Gb2RhFEkes_V0292JFMLxA>
    <xmx:DTg0aGKNcOUdNfHVs0b5RDtQKUiB4YqwGWqZX4G8-vDX9NDp7CUSMA>
    <xmx:DTg0aEDQ55S9TyG0cn-SG9rRonI4c-ASU6MWshzX3voofNCKWvcPlg>
    <xmx:DTg0aKUvDe8sQp-pK0nzd5R3C1xaA6VHgHswT148zdOGRgcQuvv5cAcZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 05:44:44 -0400 (EDT)
Date: Mon, 26 May 2025 11:44:42 +0200
From: Greg KH <greg@kroah.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: johannes@sipsolutions.net, luciano.coelho@intel.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mac80211: Add null pointer check for
 ieee80211_link_get_chanctx()
Message-ID: <2025052614-spring-ether-8d09@gregkh>
References: <20250526091903.587-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526091903.587-1-vulab@iscas.ac.cn>

On Mon, May 26, 2025 at 05:19:03PM +0800, Wentao Liang wrote:
> The function ieee80211_chsw_switch_vifs() calls the function
> ieee80211_link_get_chanctx(), but does not check its return value.
> The return value is a null pointer if the ieee80211_link_get_chanctx()
> fails. This will lead to a null pointer dereference in the following
> code "&old_ctx->conf". A proper implementation can be found in
> ieee80211_link_use_reserved_assign().
> 
> Add a null pointer check and goto error handling path if the
> function fails.
> 
> Fixes: 5d52ee811019 ("mac80211: allow reservation of a running chanctx")
> Cc: stable@vger.kernel.org # v3.16
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v2: Fix code error.
> 
>  net/mac80211/chan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
> index a442cb667520..c9b703c283e7 100644
> --- a/net/mac80211/chan.c
> +++ b/net/mac80211/chan.c
> @@ -1503,6 +1503,10 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
>  				continue;
>  
>  			old_ctx = ieee80211_link_get_chanctx(link);
> +			if (WARN_ON(!old_ctx)) {

You just caused the machine to crash and reboot on billions of Linux
systems if this ever is triggered.  So please never do that :(

thanks,

greg k-h

