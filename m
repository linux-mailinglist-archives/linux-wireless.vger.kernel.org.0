Return-Path: <linux-wireless+bounces-23555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867ABACC635
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 14:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3916C6A6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C631D63E4;
	Tue,  3 Jun 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="mAD+a/IB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7A205AD7
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952788; cv=none; b=Li3j9pc7KxFihfCoYNLCrMp+gU/TWoqx1EhUhhw3KbNoVZf5T1u4K71QNV3meder5+pdz8dV2+AUb9Jolqv5l2OuTCbYbMYGRC85CGiF1tCsaRMRqLkL635gxsK616xjT9GyNG5cpYCnEUaWuluE7yvWMhwWI9V69ECn9dUJius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952788; c=relaxed/simple;
	bh=bfmWaWay1gIg12mfQpH+kfGBnfLo93mAPsqL43peEwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/JdBYLvdY83fxfmBEqZRW3+soi1chiLvpy5U3pX9kWZjofggwm/4nclFYes+guFS0UJvcbclSxdqTCdmeUrVBkshlbUyIU/F52E8fMfjIrHQXdJSYQH1FkZhCYhc8SlqWXiqcLOAkVPXXBVh52yQ7l9CScrlKwm1I1iWUtzbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=mAD+a/IB; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748952787; x=1780488787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bfmWaWay1gIg12mfQpH+kfGBnfLo93mAPsqL43peEwk=;
  b=mAD+a/IBNxiTJs1RiM3KrhFWK7R1ButwKJuDS5vwC73FDxFrYQgXH+vk
   pNCMG3Y3uAlc/nLxk6VOMxqRJYiWxoya7OK2kJNXGPphHMXyXGkx/A2hy
   EczPKOXWXtj+jTEfDK4w5DsZ1H7lb+sP9+cYK10wM+my6FPxxDHZgJlNI
   0=;
X-CSE-ConnectionGUID: KjXSub4CQwW0GBNeDGF/lQ==
X-CSE-MsgGUID: /ZrCwkzQRVa7P6x/+d+GsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="53482565"
X-IronPort-AV: E=Sophos;i="6.16,206,1744063200"; 
   d="scan'208";a="53482565"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:13:04 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 14:13:04 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 14:13:01 +0200
Date: Tue, 3 Jun 2025 17:42:22 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Arend van Spriel <arend.vanspriel@broadcom.com>, Ajay Singh
	<ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, Gokul Sivakumar
	<gokulkumar.sivakumar@infineon.com>
Subject: Re: [PATCH wireless-next v2 0/5] wifi: cfg80211: Add support to
 indicate changed AP BSS parameters to drivers
Message-ID: <aD7mpkhmQXuN9tMT@ISCN5CG14747PP.infineon.com>
References: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
 <e36c8a9149f85383b4f3e8793381842088853dbe.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e36c8a9149f85383b4f3e8793381842088853dbe.camel@sipsolutions.net>
X-ClientProxiedBy: MUCSE810.infineon.com (172.23.29.36) To
 MUCSE827.infineon.com (172.23.29.20)

On 06/03, Johannes Berg wrote:
> On Tue, 2025-06-03 at 16:02 +0530, Gokul Sivakumar wrote:
> > In cfg80211, added provision for the drivers which registers the callback
> > .change_bss() cfg80211_ops, to find which set of AP BSS params are changed
> > by the userpsace in the SET_BSS operation. With this the drivers can decide
> > to reject the operation if any of the changed AP BSS param is not supported
> > for explicit configuration. This helps ensuring that the driver does not
> > partially handle the AP BSS params and avoid misleading the userspace that
> > the SET_BSS operation is fully successful.
> >
> > Also introduced the "changed" bitmask check in all the drivers that are
> > currently registering to .change_bss() cfg80211_ops. This would make the
> > condition for handling SET_BSS operation equally stirct across all drivers.
> >
> 
> Oh, nice! I'll have to look at it in more detail later, but one thing I
> saw now is in patch 2 you have this:
> 
> > In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
> >  0 = allow low-level bridging of frames between associated stations
> >  1 = restrict low-level bridging of frames to isolate associated stations
> > -1 = do not change existing setting
> 
> Is that -1 still true? Seems like now it should just be that
> CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE isn't set and then you don't touch
> it?
> 

Apologies for the HTML content in my earlier reply which got rejected by
the mailing list.

Kindly note that the driver is rejecting the SET_BSS operation if an
unsupported AP BSS param is passed by userspace, while the opposite is not
true. ie. the operation would not be rejected by the driver, when a
supported AP BSS param is not passed by the userspace.

So yes, the significance of "-1" still holds true, because if suppose the
userspace skipped this param in the SET_BSS request, the driver when
receiving the request will have the ap_isolate param with the default
value "-1". The driver is checking if the param value is >=0 before
proceeding with handling it. And will ignore the param, only if it is -1.

Gokul

