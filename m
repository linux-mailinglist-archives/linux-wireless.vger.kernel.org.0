Return-Path: <linux-wireless+bounces-12360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0D69692F1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 06:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C706F1F23BA0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CAD1CDFCD;
	Tue,  3 Sep 2024 04:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lrRrLrd5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkgRwXxK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C02904;
	Tue,  3 Sep 2024 04:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725339366; cv=none; b=rXw/MhW4gQRugbXi+4pFM0lO0wRZFPehP4IpbYwR49EC3IoaO/IE58Msv3y5eAARtspE65d4xtUSNVI+S+PATpYnJz7qevJFfeSqaL1YA+68JVuHNKxSp9VR2AK01gFEGNekFSe/P0txUo6dDI90fr4rnSM+//7NVxWiVkg9y1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725339366; c=relaxed/simple;
	bh=6QgKRJ5Pc9xgqkDF9sMaV53v4Fz99GqqxpewHhlftzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PToHOUBm1UFS1BviX1ai1zsvD5225UMzOs+zr/iW0v55njnUEci8KsuCxYXlOVNzUAQakSCZY5WQCKnRlOa/TCagPn986h+BBtPU6uyk5iga/fpTUnKSd9a/Mx7ZlWZrmSWa6MaIDhfftr6TetAOQ9n6EQsoIUyhtmxSISv1fXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=lrRrLrd5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkgRwXxK; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailflow.nyi.internal (Postfix) with ESMTP id 6E99B200212;
	Tue,  3 Sep 2024 00:55:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Sep 2024 00:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725339359; x=1725346559; bh=QaXgD3nnEB
	f2FvN2o3oUkR2SpAKFJSDAPnp60cmG00M=; b=lrRrLrd5xSbH/ug6+KlAeIfBcR
	qaQYhdGGV7g5qvomtuPvVCMlau0MKsFqfRc879wODFXaTZBZ/8QYTrmCO/6Yfpov
	2ofD83p+Sx+1eM4rBcMiOnuOtYgX6NZqA7lqQ9ea6PLfY8fORimsjINWuFPFpg9w
	nlrqOjfEMj8USskrW7U4iI+8fc5w4dBYU4TXmS6uw3npwQdgzbH6AD3aLaeBwN+i
	nCOWnv5OCd6SaeCEN9mTkU/75o1nd/x0LRTNXgL9CCbe/aSLwnJvatF9R+Oxzxe3
	pnQDJGCpME7OqAK9Ls1KWjwrTLgtcTTICWodNuDF+Flp0WugvWvWaPXVNGvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725339359; x=1725346559; bh=QaXgD3nnEBf2FvN2o3oUkR2SpAKF
	JSDAPnp60cmG00M=; b=kkgRwXxKqXV4hca5Mw/+wTzndZFnOTrZVr5Yy5gSzUcN
	l/Frz31dZBhO8irg8IrtIv8IUC8O+bGi7H+JS2I8VYCHwzTCUx8IiP9fHkSiFGJv
	VxG+nPvPgjQBJW0InT1DKfDC+Qxrg3qNI50htHB8evCNGDSx4Y5LDD4yKvT/3r1V
	5h5v2DJmeN3PlAisV2E1EPdB4dtKQrHIVHEOA4kSA7lQH7/cTVQQYlYpftnuJe/S
	Mn5bIWK/wo3+LVK+Ws0RopxFA8dOMjLo9efsrIVhWClubstfR2RamDzUTzWvbidG
	7Xv+gdG3LGqwddh44BV6gWO/z1kKQwsnS2uhV6Oahw==
X-ME-Sender: <xms:3pbWZkZlMyT8nw3X75H33sZYTuBLrC2qifWq9WD_djnoYfCmXyhlCw>
    <xme:3pbWZvYeXe-W_dw6QF1ChUzuwLRcmQ7EPqLqGaslQy4vdlg_VsX7Rnmg9ROs3-uVA
    IW0HI9l_ifYiQ>
X-ME-Received: <xmr:3pbWZu-Kn2oarZ8_9Ow94znknYYSJ9cGVsBC0eSNUTNqsPkrViiznZL2cnR9dzZFZw7RyeepUkvC_kFAqiQI10MUsueiXng_U3D_Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeegkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrkhgvvdegsehishgtrghsrdgrtgdrtghnpdhrtg
    hpthhtohepnhgsugesnhgsugdrnhgrmhgvpdhrtghpthhtoheplhhorhgvnhiioheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhihuggvrhdrlhgvvgesmhgvughirghtvghkrd
    gtohhmpdhrtghpthhtohepshhhrgihnhgvrdgthhgvnhesmhgvughirghtvghkrdgtohhm
    pdhrtghpthhtohepshgvrghnrdifrghnghesmhgvughirghtvghkrdgtohhmpdhrtghpth
    htohepkhhvrghloheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhthhhirghs
    rdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthh
    hinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomh
X-ME-Proxy: <xmx:3pbWZupN-FcNMwfx2JqME2u1giu4qg3Knb8zOft___manRJ7U81gCA>
    <xmx:3pbWZvostYbpJjibu84wEbU76J0ekjMUe3kGMLFc0Icz6nSJHJj9RQ>
    <xmx:3pbWZsRe6-QfWiv-rn4CV96o3PV6tnGlWHsb91TvFygcH64qTChGPA>
    <xmx:3pbWZvoCqbYWRGd-lJbR7yyo4QovcSguYwsB9V73AVlGZNw2wTnPgg>
    <xmx:35bWZqHQxUchp1_GGGk2zcsVFWLUDcR1HYI8TELq0TunTNpuIIxF_hxh>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 00:55:57 -0400 (EDT)
Date: Tue, 3 Sep 2024 06:55:55 +0200
From: Greg KH <greg@kroah.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com, howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com, benjamin-jw.lin@mediatek.com,
	allen.ye@mediatek.com, chank.chen@mediatek.com,
	meichia.chiu@mediatek.com, Money.Wang@mediatek.com,
	Bo.Jiao@mediatek.com, akpm@linux-foundation.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: mt76: mt7996: fix NULL pointer dereference
 in mt7996_mcu_sta_bfer_he
Message-ID: <2024090332-waged-yummy-296b@gregkh>
References: <20240903013913.4143602-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903013913.4143602-1-make24@iscas.ac.cn>

On Tue, Sep 03, 2024 at 09:39:13AM +0800, Ma Ke wrote:
> Fix the NULL pointer dereference in mt7996_mcu_sta_bfer_he
> routine adding an sta interface to the mt7996 driver.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> index 2e4fa9f48dfb..cba28d8d5562 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -1544,6 +1544,9 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
>  	u8 nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
>  	u8 snd_dim, sts;
>  
> +	if (!vc)
> +		return;

Why is this the only place you are checking the return value of
mt76_connac_get_he_phy_cap()?  Either fix them all in this driver or
none as obviously it can not fail :(

thanks,

greg k-h

