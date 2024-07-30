Return-Path: <linux-wireless+bounces-10686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BF09413AF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF7BB2466C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D941A08C2;
	Tue, 30 Jul 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SZS6Cj+D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QAgBwod4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95F1A08AE;
	Tue, 30 Jul 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347594; cv=none; b=e95ZYlWDQAmnQ2PLP+w+hmIS+bWqVYRiNGTE/rnNBGk8spS5OVXPTP98Lu0h79Zj+mPR4XZbetaq//KIcwJNHTag/kkXVoruB2HmYNzEAu0iDNOjYn/QqJeGU+k7i1mxh29lb9EdzhFP0ZJ2FQk3JtR4vjOY9G8qFz9wj4kPR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347594; c=relaxed/simple;
	bh=v+GdyHMBxPxewNSWLopSbrq6JyNNA4B9F0eCYvLWuEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvLBln8rw8lfahsrdwgdOIsMzIsgBmKgHqD5sLAVTiKE1rUkVPAPrqtx0Eelbes8R+HLtxpqqc9dapPffPD4q4ZKz+H8B6cDpno+FVmcJRIFvYyhY1b0JNFUDTtPaB9JAaIVQCdjTWAgyI62cvYVX8Z3TlFwq9QzhcrSSA3d4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=SZS6Cj+D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QAgBwod4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id BB2A6138057D;
	Tue, 30 Jul 2024 09:53:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 30 Jul 2024 09:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722347590; x=1722433990; bh=PUtjY+8IDe
	2YsJuBKLG+kluaMusGn//j0/vcDSgjktA=; b=SZS6Cj+DeAeMjfHVF+AzViVI27
	NQsIRl6l88jmGXp9pejkXQF4tDYG/WdFpOefjpFoqPfsP2KlJCKsBYtmTuPM+4G3
	HPwU0JOaHlTBL3zmqfwzaYQmQc8ukXmZ9GcJ+/d9/F2r6Ah6KuroUn1c2KM6RQjy
	q9sWNbIlnO/Pl0g9SlUEk5mhfEhEFQC/uebuJ0EH4HFhKFCYhbtr9YFSP+wiQJ+0
	LR+gqB6k55bEm5G16HxWhGUMUeyOWRvSTIrMGydsAixbYcYwRytReTh31uxbL+CM
	CMx8kFosuJYl6yLW4c5U+Z7c0WTNayAN73DC7kgIhfmSca7NDX9arUUYGrrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722347590; x=1722433990; bh=PUtjY+8IDe2YsJuBKLG+kluaMusG
	n//j0/vcDSgjktA=; b=QAgBwod4rKe+S8Vu5Q9trlLCO4kexKNUBlgc+mq4HlTk
	w9T5ONWikrwwMq8nDdQtk2MHBZrS0gOQaEKbKOMqCbOuR2dcXtju7zwTj3ONzi2t
	7OXFRgPHhAM6LAGOHRBr6nvrYzrxL5SJKI9hjtQYlUwxkho0JaQzNJizCenanGq9
	fwcugD+bYrZfXNWcSOet3XPnUy6gLrmPcj6sIoWKnddLc7i+Qj+QVJxpi/hGbDah
	YoK49MAJQzZthSzUL9/oHveWq+P218FU7qoBEbLLuI6f3FSACrSSBAzOvPF8hBal
	kIEZhooOQpcVZm/kwPEg1Wtinijy1HcBEXXltnzRPg==
X-ME-Sender: <xms:RvCoZsXYf57mHPE34z96yOyL8SCDlovw55WgWL0c4qW2exPzm3-oPg>
    <xme:RvCoZglmwkxaIxRJzwnx6UrbYn9DlPHdJntbzFQYGWOBiL-37He2DLsnRrgCwhqoE
    nTZojPzmC0Riw>
X-ME-Received: <xmr:RvCoZgbgHSzKG49NoBJn40wrOLsJrPaxcKMW6L3wT7l14Z9fDE2ZJufGWjGz5xcJNJ7YSxcVGGn-DrTqPr5fuaSkfx1KksavJvfzKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeejteeuhe
    etkeeuhfelheekffffiefffeettdeigeekvdeigffgfeeuffekgfeuffenucffohhmrghi
    nhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:RvCoZrUyaZ61WDGHc9WGBwR6a4bcj4SPo8xLIhxqL6w91N7g2kn73w>
    <xmx:RvCoZmn5eOe93UsQPRCJqz7VlAaktaKQ3wdOOTMoWxW71lqOHYpPqw>
    <xmx:RvCoZgckSbqgdua_Owt5wOSCZBfe8nBXtLcGWfJJ8is2AM31qeUksQ>
    <xmx:RvCoZoEylMJbs7Eix04RydPgUjN5Yj8T8Kjv6HGIgqroBeYj8gmWIg>
    <xmx:RvCoZr-D289iyccVoc4PwXUOk_n1UUmWWu8eCFBU4cgSEX8JMIOQOenL>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 09:53:09 -0400 (EDT)
Date: Tue, 30 Jul 2024 15:53:07 +0200
From: Greg KH <greg@kroah.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: stable@vger.kernel.org, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH 6.6] wifi: mac80211: track capability/opmode NSS
 separately
Message-ID: <2024073001-unarmored-friday-0b79@gregkh>
References: <20240729225849.1352302-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729225849.1352302-1-hauke@hauke-m.de>

On Tue, Jul 30, 2024 at 12:58:49AM +0200, Hauke Mehrtens wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> [ Upstream commit a8bca3e9371dc5e276af4168be099b2a05554c2a ]
> 
> We're currently tracking rx_nss for each station, and that
> is meant to be initialized to the capability NSS and later
> reduced by the operating mode notification NSS.
> 
> However, we're mixing up capabilities and operating mode
> NSS in the same variable. This forces us to recalculate
> the NSS capability on operating mode notification RX,
> which is a bit strange; due to the previous fix I had to
> never keep rx_nss as zero, it also means that the capa is
> never taken into account properly.
> 
> Fix all this by storing the capability value, that can be
> recalculated unconditionally whenever needed, and storing
> the operating mode notification NSS separately, taking it
> into account when assigning the final rx_nss value.
> 
> Cc: stable@vger.kernel.org
> Fixes: dd6c064cfc3f ("wifi: mac80211: set station RX-NSS on reconfig")
> Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> Link: https://msgid.link/20240228120157.0e1c41924d1d.I0acaa234e0267227b7e3ef81a59117c8792116bc@changeid
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> [Fixed trivial merge conflict in copyright year net/mac80211/sta_info.h]
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  net/mac80211/cfg.c         |  2 +-
>  net/mac80211/ieee80211_i.h |  2 +-
>  net/mac80211/rate.c        |  2 +-
>  net/mac80211/sta_info.h    |  6 ++++-
>  net/mac80211/vht.c         | 46 ++++++++++++++++++--------------------
>  5 files changed, 30 insertions(+), 28 deletions(-)
> 

Now queued up, thanks.

greg k-h

