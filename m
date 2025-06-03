Return-Path: <linux-wireless+bounces-23558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F5ACC8B9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C93A5E7F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826BB238C2D;
	Tue,  3 Jun 2025 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="PYWg7j/p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A29230268
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959659; cv=none; b=mxZCqbxZgaSONw3WVb98bimdnRlQzk78ARhkxaILxtvQ8+vDlEgo9ounP/kPaeM3KfkFomj552UIJqLxvu9lPdjHlbcQF6M1vUpkrU4Xj1X1TdLlLx5rbL+K65IvTS8En8XfiQWqfDcsDqVlRqSy1u6GhoL8Ykfcg0ssqbGtZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959659; c=relaxed/simple;
	bh=4z9DWs3xtUttPftAetKvNxvf/H6ms3sZ7+0TG0+YMrI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVjU61hy9TewGdCL0AWQ0aOZwJ7/0mwnJJhpcOU5O/TNe0Tf+oL/4kO3CEJ8HYxfCmiRe6gmgeXxCB6iH8pLqcNnTEp95zvsQJfLdkWVIhDnZFJXNZjEI3i2RUb8wsgu88mYOFS9x0pb8C++jVok1XE3qqmdZNVUJDmooyLzx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=PYWg7j/p; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748959658; x=1780495658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4z9DWs3xtUttPftAetKvNxvf/H6ms3sZ7+0TG0+YMrI=;
  b=PYWg7j/pqBq2Xj3QTLOmv5zcjVR8UnJxewcGilOVd/jCpqFDV+UalVqx
   svSZ1Ve8jvcvJUs8YeTI6GemiSJ9O1+h7lRKvtvnqyBDEmc0yhbBlR4PO
   H+D+bFcVUL7yqLBKSpcnkx2Y5Lnko9hlA7liqulB2YHr3fVGXgQUWU3Id
   Q=;
X-CSE-ConnectionGUID: kzLrO93LTB6w7qH1kMbgYA==
X-CSE-MsgGUID: lNGNfFEaQ6KqEby0nF683w==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="112948205"
X-IronPort-AV: E=Sophos;i="6.16,206,1744063200"; 
   d="scan'208";a="112948205"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 16:07:36 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 16:07:35 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 16:07:32 +0200
Date: Tue, 3 Jun 2025 19:37:24 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend Van Spriel
	<arend.vanspriel@broadcom.com>
CC: Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, <linux-wireless@vger.kernel.org>,
	<brcm80211@lists.linux.dev>, <wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH wireless-next v2 0/5] wifi: cfg80211: Add support to
 indicate changed AP BSS parameters to drivers
Message-ID: <aD8BaLWyVM5SRSCx@ISCN5CG14747PP.infineon.com>
References: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
 <e36c8a9149f85383b4f3e8793381842088853dbe.camel@sipsolutions.net>
 <aD7mpkhmQXuN9tMT@ISCN5CG14747PP.infineon.com>
 <5095079184a282ae552c50c8c121a632d51b0419.camel@sipsolutions.net>
 <19735f0a5c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19735f0a5c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

On 06/03, Arend Van Spriel wrote:
> On June 3, 2025 2:29:54 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> > On Tue, 2025-06-03 at 17:42 +0530, Gokul Sivakumar wrote:
> > > > 
> > > > > In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
> > > > > 0 = allow low-level bridging of frames between associated stations
> > > > > 1 = restrict low-level bridging of frames to isolate associated stations
> > > > > -1 = do not change existing setting
> > > > 
> > > > Is that -1 still true? Seems like now it should just be that
> > > > CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE isn't set and then you don't touch
> > > > it?
> > 
> > > Kindly note that the driver is rejecting the SET_BSS operation if an
> > > unsupported AP BSS param is passed by userspace, while the opposite is not
> > > true. ie. the operation would not be rejected by the driver, when a
> > > supported AP BSS param is not passed by the userspace.
> > 
> > Sure. That's a different question though.
> > 
> > > So yes, the significance of "-1" still holds true, because if suppose the
> > > userspace skipped this param in the SET_BSS request, the driver when
> > > receiving the request will have the ap_isolate param with the default
> > > value "-1". The driver is checking if the param value is >=0 before
> > > proceeding with handling it. And will ignore the param, only if it is -1.
> > 
> > Why though? It seems odd. Basically in this case cfg80211 is saying "I'm
> > not changing this parameter" but then anyway you check it's value, why?

yes, if the driver individually checks for the CFG80211_BSS_PARAM_CHANGED_*
flag before handling the corresponding AP BSS param, then the check for the
param value as -1 is not necessary.

> > While we're changing all the drivers, it would seem better to me to just
> > change them in a way that they don't look at the value if the
> > corresponding change flag isn't set?

your suggested approach is fine, will update this and submit a v3 patchset.

> I do have a couple of patches prepped for this, but did want to run few
> tests before sending it out. Now that this is submitted I am not sure what
> to do with that. I can send it as RFC so the idea is clear.

Ok. I have submitted this patchset based on the suggestions in our v1 patch
review discussion, to address johannes's comment using the newly introduced
CHANGED_* flags which are helpful to the drivers.

Gokul

