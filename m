Return-Path: <linux-wireless+bounces-25922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F6B0EDAA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7552188C9BA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD02AD23;
	Wed, 23 Jul 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="XxptZiw0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B24211A15
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260771; cv=none; b=pvc4o8HLiGPXoP+ifHC/Jv/SIv3PpKfTtCovbs9Xlm6B7gl7zKlh0R0gvI+Z1vYEL8GHR+zPxyGQZ8pgrGdrpPzywSBhghynPY4pvBbd33omzYK3ehI+bz5/ZVP3Yx4PkcMVYRIl4zbFBLqlE5iJR86Qh37zF+Hvqzerfy2/570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260771; c=relaxed/simple;
	bh=j4dlvOMpn572AAW3IhAc8DVgXwfguKWVueT3R9vI75Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA+/rEn7K5sCiSH/SnAkSX08snyUWQ1lsl/5YjjRn/OIyqnriAp8UVtsq2jHxSj7AoE2ekSC5AHHMiPYwkaSruPwr3SSCxtvQ09iIEAjfx+3dz1gRc+yr6V3ci0mRar1AsF0YmrZtwI5TqoNs+gT4U2u9RdFrNfhBLbVu0zFs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=XxptZiw0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so622736b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753260769; x=1753865569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl5/f59RFWNbIuwC780oOSk1LB1mCkdlzk2hc5hpm8s=;
        b=XxptZiw0KQXuEe3hwndNOhgIqqUj44oyPCzeq94nDsp0VSeWtinsWxWSD+LIzgNETL
         kHm9fT1ZOo+j5+PbEfoeNI96/G4XnYD6fbA0Ynm30YRmZYH0zHAtSj6OaWuvKLY90WX0
         AzMQV2NcsbypdXqIAUI9E0HdCqszKBcO6OoF+fN6IhgrQ7siAlAFuxRCOS7mfD4xX1qI
         1lB7TcGphrWdCX3BWqJ5NZfc2pgoDpZUH+6mpTw4ZspZFyA78LwUqg3xuanSuKbH5/2q
         to6mQAEqXB4ZBGOxVfWDWIU58sr08BecrdYCI+B5MEmjb7JjkSZPA4kEgSRXYoG2OVfr
         VDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260769; x=1753865569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl5/f59RFWNbIuwC780oOSk1LB1mCkdlzk2hc5hpm8s=;
        b=Mc2pLHLatifudL4Prxk1gFviYibiwmEUt5hoQIbVbl5qt6q7LcOvEXnEBQFRXiLZoE
         1KXgeCcwi95GpftZyIdHXcyEn3vEJq3Fr70cCA0C6Op4NYJG1V2Yu+pEnYrfpte3LB3N
         Hkbkj0pjxzQq/ACI+RxJcZ3I4ZZwnbFEWP8dPThJciz4yJqPl1TTEqR4nm8nalxB2RTp
         Jkdfvxqw+l6RIY9JrwroHxThwM1r7GzyDnY6dK5T90zeE1qKxxP3e+8544nt/9ZERfdx
         QpXL5Q1G9dvrxb1Ive+rUWZlKY75Yp9/kJU0kbvAEuxZLGp9s3ppOJalWCreUPA//8ul
         6rzA==
X-Gm-Message-State: AOJu0YxRzUu2BJLvJl3PDBZzzfFxAItBmiSvmJHpPwAxM/9pDOB5X490
	0hSgDlNAYRQT/KcxgItifJEteFlkU0vz7skg0+s8hSG3u2YAd6rh+8PPneHH4O+5xzc8CNhjXJk
	WZX8OYO4=
X-Gm-Gg: ASbGncsGy+o22uiqNG/3HCaMU689aC8PrY5lJK19lkMQi4PJdqj15gOIhi0MQFK2dRi
	c+OpgQz+MINHeI0fiEdOAWZGbyhSVdS77vHfe0Kx9GAy20FwuxPPwx0dhsYixTw4/lfBpQkjDkB
	cp3xkNRT6NKNx62c69SQkmP9eeByhVOz0RLP0kBdcSHz5Ebj99lQK327X6J3YpBR+uQpdu+L63N
	vIBSljK6vuEC9l4MPvuAcM0EKE727SvliNxTOUfRYyoc5zQhVP+4fgQsAtc8zyuYosUXXiCFemH
	C0ZiOiF/VPJhOleqpkCWR6C675lZOdWo7bHm1WRorMVWy25CjCeakGDsvYr2axmxezQ6RzqHkKW
	eVGWG3jDfLLl4Bs47ZScxDaeM1hyhEmI=
X-Google-Smtp-Source: AGHT+IH+VhxFB8u/vAx4FWoc0Qel2eBC3kPGmXDYSRM+D+x8GjOw2mVZhw5gegv7vSWost9W2TBBIg==
X-Received: by 2002:a05:6a21:e92:b0:222:ca3f:199 with SMTP id adf61e73a8af0-23d48e7269bmr3323284637.18.1753260769088;
        Wed, 23 Jul 2025 01:52:49 -0700 (PDT)
Received: from localhost ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2706sm9071060b3a.31.2025.07.23.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:52:48 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:52:46 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next 2/2] wifi: mac80211: support parsing S1G TIM PVB
Message-ID: <s75ll2rbyrmeyg62sbb7nlconska6337qjinyt35skrpqcgrj5@hjayizfsrob6>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
 <20250722071642.875875-3-lachlan.hodges@morsemicro.com>
 <e60156bc1097385bceb624bac6bf55906947e6a9.camel@sipsolutions.net>
 <ksb6rptacpnyxbcep332q247agx2u62h6o3j4oqfestaal2b7x@el6snwrs4kx5>
 <98abd0c936a6169a106682da9359c01708cf4ee9.camel@sipsolutions.net>
 <yy2mk5xsimlpnohsg7d22cl7u45n3exmu43jo5l3qmqjx5wzer@mrnzw7rax5ew>
 <de49f2491030902d981840f36087af3dc2c9377e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de49f2491030902d981840f36087af3dc2c9377e.camel@sipsolutions.net>

On Wed, Jul 23, 2025 at 09:39:47AM +0200, Johannes Berg wrote: 
> Yes, they just go to net/mac80211/tests/. You can put something in the
> same patch or if you feel that gets too big into a separate patch in the
> series, I don't really care too much.

I am playing around with them now, so will include them in the next
patchset :)
 
> > whereas (and, do correct me if im
> > wrong) on the AP side the AID is passed down from hostap via
> > NL80211_ATTR_PEER_AID, which is then validated using the
> > NLA_POLICY_RANGE where the max is IEEE80211_MAX_AID. So if we were to
> > limit the AID to 1600 for S1G, we'd need some way to validate it within
> > cfg80211. Don't think this would be too hard, since we can confirm we
> > have an S1G station via the presence of the S1G capabilities within
> > nl80211_set_station_tdls():
> > 
> > ...
> > 	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
> > 		params->link_sta_params.s1g_capa =
> > 			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
> > ...
> > 
> > where we could maybe perform some extra validation on the AID? I know
> > its maybe not the prettiest since we aren't technically using the
> > explicit nl80211 intrinsic validation - but I would say it gets the job
> > done.
> 
> Ohh! Now I see where you're coming from, I was completely handwaving
> away the _practicalities_ of checking the limit in my head.
> 
> I mean, sure, we currently use a policy ... Using the S1G_CAPABILITY
> attribute wouldn't work if hostapd isn't including it at that time, but
> mac80211 can always also do the validation. Worst case we can even
> expose a new max-AID attribute, per interface type.
> 
> If we wanted to extend it later to up to 8191 then we'd need to remove
> the IEEE80211_MAX_AID policy anyway since it'd be limiting to much less.
> 
> So I don't really see this as too much an issue, I'd probably just have
> added a comment in nl80211.h that it's practically 1600 for S1G for now,
> and added validation in mac80211. Then if _later_ we extend it, we can
> add a feature flag/feature attribute for "now we support bigger AIDs for
> S1G".

Sure
 
> > I think what I'll do from here, is wait for your response to my
> > comments, mainly on the maximum AID count and any other comments you may 
> > have, and work on v2 which would roughly consist of the following:
> > 
> > 1. On the AP side, we simply support block bitmap encoding. Patch 1 
> >    would more or less be the same (with the addition potentially of
> >    new AID validation) though I'd add some details in there and
> >    change some comments etc.
> 
> Sure. I write in a comment on the other patch that
> IEEE80211_MAX_AID_S1G_NO_PS should probably not be in ieee80211.h, but I
> guess with the changes to validation etc. you'd renamed that anyway and
> put it in a different place. Or remove it.

Yep sorry I did read that (and will respond after this email).

> > 2. Support decoding the other encoding modes on the STA side. I think
> >    while a bit more work upfront, worth it in the long run.
> > 3. Add in some kunit tests to tests both the encoding of block bitmap
> >    and also the decoding of all the formats from Annex L.
> > 4. Fix up the AID stuff depending on what you think, If we go with the
> >    hard limit of 1600, ensure on the AP side we perform that validation.
> 
> I really don't mind either way. Like I said above, it's a bit of a
> question of complexity in the AP encoding implementation. Maybe just
> start updating the AP encoding implementation and see how hard the TIM
> element length validation would be to add to it, vs. a priori knowledge
> that it'll always fit?

Based on our discussion now (going to read patch #1 email after this) 
Ill stick to 1600 limit, Ill leave that for response on patch #1 since
seems to be more relevent there.

lachlan

