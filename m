Return-Path: <linux-wireless+bounces-10144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C592CF28
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 12:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD641F2550B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA719006D;
	Wed, 10 Jul 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MoKCsSlN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ag2jSf4s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79DC190068;
	Wed, 10 Jul 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607102; cv=none; b=ItHXInvVZ9FFSI4q7Urjkz/EYWxo4AOLsHJrkZepzkF4DKMCd7552B/5Xi2Ue5po9iJvVkMk4Jqv2/LWE+INbUx9652Ld0X3pZmsSlspeL44bCV78Xed8ARfIZ6l7KfShblphTrDgsiWobQ3t05+4+hSc0ErVIwwNLvc+CanQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607102; c=relaxed/simple;
	bh=FC04BLdIs8tuiDfvf/c1ZzpMpSeOaRa/C5ZTu2v8tNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMZfBsM7AyZ9yXEd9zjroety0vBtDGqDI33UMr8+XU5x/2IbUwhGtA9eIa5DCiEe6AZJ+h8y2tqIGDj5eHvXJ+YxvnZ8rEE2p3eyNiDq2UzrqDOqKkRsL5Td4YhsCa/604IWOtgbQ1D+xZ8vuWaWyWKa/RfYcJdUV0I0n+sTStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=MoKCsSlN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ag2jSf4s; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id BCD602004B2;
	Wed, 10 Jul 2024 06:24:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 10 Jul 2024 06:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720607099; x=1720614299; bh=VVZAdYDgdn
	sfeF4pUTyu7FXWVOGM6tvVCvnnRo6O8PU=; b=MoKCsSlNBy6bgouajIyVgN/zhj
	Er7/Rk9QqGPtZr/wVKqy44VGRa6XWubW2QuWxhsDYV4h0Z3WPhWkAmNTW4YvAXdf
	BrGZBFhqVq8HJx1ld5AkVqGCYjiSewKpNW/3OBqJPA5Cd20v3vWVU+2+Lhp6aMg7
	2eMaCLJtFGuVQvIOHqjx7ObNeIuLHPOwc6Km/27ctjP3DEJEcMISrDlrKRSqneb0
	uUBiRxFIuKrOdoDWy0ECYxuvSF1jNCmBJXWPNKrQM30SJ7y5c7jLDDjV7QhCYmse
	YT4qiCzCy+4R7CKjFIf1pzZd+e0jo3DXp66qz6+xVmlyLevuDgIoxJyiTYFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720607099; x=1720614299; bh=VVZAdYDgdnsfeF4pUTyu7FXWVOGM
	6tvVCvnnRo6O8PU=; b=ag2jSf4sQ+V5anT5AGga62piqqrUy5vQAjmyDo75xrTz
	Yxs0Oq/RKG9xLEJL0fQRszct7rYSaCbAAteXH/FQ+57huUJFbQ3IDaGpYeycTDTp
	Wlg5RU5Ve9q+8ifuFbDNfqsjJOwIh4LiWWvsy9wGMCFREXiriucmzNoeR6un1mEW
	+6ngYPUBMjTAbg1OB1g+zvNtog5AQVnx5d+sD5mZsz0XZO2xaSediZ5aJs7SgAci
	zQ/MN3WXXaK4lhcb7V1IrRlhyXntWHx6tsMROhlDxCeBo0eBXbNCqssk/uE6rWzg
	rw5xyNnyCnCGff9fNch2nTMO4eKLo/92biOxz7SqlQ==
X-ME-Sender: <xms:emGOZhCzlwAQMgOIgSRZj_TKljUCaVaRn0Ep7wT4-xKAgvlyL1F9Tg>
    <xme:emGOZvi5Lcbtxunsa--WqRb0XHSO5g9cv8cpDF5ZZLAerxVMHHSisT4JdhXSp_4Yt
    bLivpSjT7upFQ>
X-ME-Received: <xmr:emGOZslWje7kWkXLR-vBIkn4Uc39s9QXHQ04o_CACiq0zuNTW8QbaysCfkU-KKI1NNspPExXyWtwP0N0EJsM5zS6x459NZtrqzFzbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:emGOZrz1VSKtafnVU48h05mD3oRW2dWTfUYDWZZ3fJLhqv-PLInS7A>
    <xmx:emGOZmRN9Ka7NH62KKB45QopZVxAox0ticbPIDcJBGco3OEhxw_WPg>
    <xmx:emGOZuZnoyRUi504xvKURnDneeQUWCSzP54FNASIZ39EiuYB3WLmPA>
    <xmx:emGOZnRykRfpY-YtacHi3j_hT7bSB81dyp6D6VryvQnMUqhs8sgoVA>
    <xmx:e2GOZqoJ7wn4xbIhpqX5LKMGZweVNa2GpKq2oBtncNWlVDYwA4AK4hQy>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jul 2024 06:24:57 -0400 (EDT)
Date: Wed, 10 Jul 2024 12:24:55 +0200
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@denx.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19] wifi: cfg80211: wext: add extra SIOCSIWSCAN
 data check
Message-ID: <2024071033-geologic-emerald-f6a2@gregkh>
References: <20240701001526.2921645-1-sashal@kernel.org>
 <Zo5cn37w8NjVyZdj@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo5cn37w8NjVyZdj@duo.ucw.cz>

On Wed, Jul 10, 2024 at 12:04:15PM +0200, Pavel Machek wrote:
> Hi!
> 
> > [ Upstream commit 6ef09cdc5ba0f93826c09d810c141a8d103a80fc ]
> > 
> > In 'cfg80211_wext_siwscan()', add extra check whether number of
> > channels passed via 'ioctl(sock, SIOCSIWSCAN, ...)' doesn't exceed
> > IW_MAX_FREQUENCIES and reject invalid request with -EINVAL otherwise.
> 
> This results in very confusing code in 4.19 at least. It should goto
> out for consistency, exploting kfree(NULL) to be nop. Ok, not sure we
> care...

kfree(NULL) is always supposed to be a nop, we have relied on that for
decades, that's not an issue anywhere.

greg k-h

