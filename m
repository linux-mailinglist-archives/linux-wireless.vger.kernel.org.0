Return-Path: <linux-wireless+bounces-22097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7310A9D930
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5594C27F7
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 07:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19C724E01D;
	Sat, 26 Apr 2025 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="THN9/s+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479124C09E
	for <linux-wireless@vger.kernel.org>; Sat, 26 Apr 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745653997; cv=none; b=tf7nhlTJnLd7jqdBDHFlZEtHmHkiNofq/w4xqlpWqkxqX1G6yYS1Vtck0ie/bET/P6MRO0+ZBYj5hIXI+PVIRoLXberBPqeiwX5F2hNtGjvv8UalR/Brrmixd/syviS8ou3KmRemXgVpVkeEFllORpGWTRlzLLS5tWoqAam1E0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745653997; c=relaxed/simple;
	bh=sV8hgg4kXMgsfFNYcf/JrTGuFAAxfaYLCRjp/wi1IpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7DL+EXf+LkOHCcdJN7OZvVPW/BFTQqMHTo/zUVy2R7s9QdaTKfEVsbfzm5G+cVzBp/mowOUWRLzW9uzGAa9kupqGZ6mSDjLsSwpFuCQVHIZofNx4teoW9PHKufXCizPyi44GvJR/4SvJt1liPiAcZhwfcdQLzLtOTszHAbqric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=THN9/s+p; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1745653996; x=1777189996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sV8hgg4kXMgsfFNYcf/JrTGuFAAxfaYLCRjp/wi1IpQ=;
  b=THN9/s+pglg7fQq5c/JF5HWY1tUBMRCb2O5edjGhZ1T/JJLQU29p9pjG
   pWB3jN88Kx7ty6hW22oFYhTMnlpkbXock3/uxcmk7GJTCTjQW99h0L4CF
   7yTdSneTs9yG2GEBCM6SS4jKOJzmlQVfuA6s+rMEcRCnIlDiCj4Jerqdu
   s=;
X-CSE-ConnectionGUID: +dAVXthrRqqZTaGMf5MhPw==
X-CSE-MsgGUID: ReBPwKqAQDKmbP1uy1jVpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="93240621"
X-IronPort-AV: E=Sophos;i="6.15,241,1739833200"; 
   d="scan'208";a="93240621"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 09:52:04 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 26 Apr
 2025 09:52:04 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 26 Apr 2025 09:52:02 +0200
Date: Sat, 26 Apr 2025 13:21:53 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, Gokul Sivakumar
	<gokulkumar.sivakumar@infineon.com>
Subject: Re: [PATCH] brcmfmac: support AP isolation to restrict reachability
 between stations
Message-ID: <aAyQma_qLrH_7S2a@ISCN5CG14747PP.infineon.com>
References: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
 <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
 <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
 <9e6febe76a55053972049b13b254474a82b26571.camel@sipsolutions.net>
 <2a6f7d20-2901-46d6-a16a-b977ff0a3724@broadcom.com>
 <29fa5ea7f4cc177bed823ec3489d610e1d69a08f.camel@sipsolutions.net>
 <c4b1d809-59fc-4d65-a840-d35598e8dfe5@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c4b1d809-59fc-4d65-a840-d35598e8dfe5@broadcom.com>
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

On 04/24, Arend van Spriel wrote:
> On 4/24/2025 1:46 PM, Johannes Berg wrote:
> > On Thu, 2025-04-24 at 13:36 +0200, Arend van Spriel wrote:
> > > On 4/24/2025 12:22 PM, Johannes Berg wrote:
> > > > On Thu, 2025-04-24 at 11:50 +0200, Arend van Spriel wrote:
> > > > > 
> > > > > Looked at other drivers implementing this callback and here are the results:
> > > > > 
> > > > > [wil6210] wil_cfg80211_change_bss(): does exactly the same thing.
> > > > > [wilc1000] change_bss(): worse! it accepts everything and does nothing.
> > > > > [rtl8723bs] cfg80211_rtw_change_bss(): same. just an empty callback.
> > > > 
> > > > OK, though I guess other drivers being bad doesn't mean this one should
> > > > be :)
> > > 
> > > Sure. I am on your team in this. Can you recommend a plan of attack
> > > here? Should we add a mechanism to expose what BSS parameter changes the
> > > driver can handle similar to what is used for struct
> > > station_info::bss_params?
> > 
> > I don't even know off the top of my head what's there and what isn't,
> > just thought the code looked odd. I guess mac80211 just mostly supports
> > all of them anyway.
> > 
> > Today the change is simply rejected by cfg80211 with -EOPNOTSUPP:
> > 
> > static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
> > {
> > ...
> >          if (!rdev->ops->change_bss)
> >                  return -EOPNOTSUPP;
> > 
> > 
> > why not keep doing that for everything but ap_isolate?
> > 
> > Oh, I see what you mean, there's no way to keep that updated since you'd
> > have to check each value for being changed and reject that ...
> > 
> > Hmm, yeah, that's not great. I guess ideally then we'd have a bitmap of
> > what changed, and what the driver can support?
> > 
> > enum {
> >       CFG80211_BSS_PARAM_CHANGE_CTS_PROT      = BIT(0),
> >       CFG80211_BSS_PARAM_CHANGE_SHORT_PRE     = BIT(1),
> >       CFG80211_BSS_PARAM_CHANGE_SHORT_SLOT    = BIT(2),
> > ...
> >       CFG80211_BSS_PARAM_CHANGE_AP_ISOLATE    = BIT(N),
> > ...
> > };
> > 
> > and
> > 
> > struct bss_parameters {
> >       int link_id;
> >       u32 changed;
> >       ...
> > }
> > 
> > and then this driver can just do
> > 
> >       if (params->changed & ~CFG80211_BSS_PARAM_CHANGE_AP_ISOLATE)
> >               return -EOPNOTSUPP;
> > 
> > or so?

IMHO, In CFG80211, if we introduce a bitmap to track which BSS Parameter
is changed by the userspace in the SET_BSS operation and then used this
bitmap while handling the request, then the WLAN Driver would reject the
operation with "EOPTNOTSUPP", instead of doing AP Isolation, because it
does not support setting the other BSS params in the request.

For Example, considering hostapd (iwd doesn't support SET BSS operation)
if the user only enabled the config file param "ap_isolate", but didn't
explicitly set "preamble", hostapd would implicitly set default value
(0 - LONG_PREAMBLE) in the preamble param while sending the SET_BSS
operation request to CFG80211.

CFG80211 would then mark the bit corresponding to the SHORT_PREAMBLE BSS
param as "changed" in the bitmap. WLAN Driver on receiving this SET_BSS
request, would then have to reject the entire operation without enabling
the user requested "ap_isolation" param, because of the preamble param
that is not even explicitly requested by the user.

In a way, we can consider this as an implementation specific behaviour
of the userspace application. But what i'm trying to convey is that the
userspace currently does not have a mechanism to know which subset of
BSS parameters are supported by the WLAN Drivers, so it is enabling
all the params while doing the SET_BSS operation. This increases the
chances for the entire SET_BSS operation getting rejected,
 
> > Not sure how that'd be related to station_info::bss_param, that's just
> > output from the driver.
> 
> It kinda looked similar. At least there is a bitmap in place for it that
> is a subset of the enum you listed above.

I guess, you are referring to the enum bss_param_flags. Since it is
currently being used by drivers to set the fields specific to STA BSS
while returning the STATION info to cfg80211, we may not be able to
extended this enum with the new AP specific BSS params like ap_isolate.

enum bss_param_flags {
        BSS_PARAM_FLAGS_CTS_PROT        = BIT(0),
        BSS_PARAM_FLAGS_SHORT_PREAMBLE  = BIT(1),
        BSS_PARAM_FLAGS_SHORT_SLOT_TIME = BIT(2)
};

Ideally renaming this from "bss_param_flags" -> "sta_bss_param_flags"
would be more appropriate, because these flags are only being used by
the struct member "station_info::bss::flags".

> I was wondering if we should convey the bitmask to usesr-space
> beforehand in struct wiphy.

Yes, if the WLAN driver is able to advertise the list of AP BSS params
that can be set bv userpace, then userspace can attempt to configure
only the BSS params that the driver can support, increasing the chances
for the SET_BSS operation to become successful.

And I can see the following two NL80211 feature flags already existing
which corresponds to the members in the AP/P2P-GO BSS Parameter struct.

@NL80211_FEATURE_P2P_GO_CTWIN: P2P GO implementation supports
	CT Window setting                                                                
@NL80211_FEATURE_P2P_GO_OPPPS: P2P GO implementation supports
	opportunistic powersave                                                              

However, for other AP BSS Parammeters, we don't have the corresponding
NL80211 feature flags.

Will wait for Johannes's opinion on this.

Regards,
Gokul

