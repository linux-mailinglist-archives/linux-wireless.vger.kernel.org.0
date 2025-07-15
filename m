Return-Path: <linux-wireless+bounces-25458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A94B055FA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 11:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F721AA7883
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1A2D5424;
	Tue, 15 Jul 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="SoYLbehl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E34277CB0
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570750; cv=none; b=KufPj+8/yQ9VVOUjdHcyypN60aznpmdOooqtBT6totb/5EpGZ/g7tUqxpP8PpNljE5uAvdYo8IWFQbgUvw8VTlKogxmzK4eDRjZjqKcupckABf8Ab23Qi6Vlok35CSsRzKS2sQcsx6jlCOUfAAuwhpnYVe90qmdudHUZ0kysKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570750; c=relaxed/simple;
	bh=7gk1fAMm+bpVPCVv+Tj4gFv+zk63/lpK8GIE3gpDj1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQmD88DXL51dd5rBIXp/Z3YrETfjSVAHTUpW1xCoAzIh0llRCBx8ansORJcbGi9o/4tFzp58ErbAN4NISavJkBIe+IuhQb/rfepopKUU2LpdnsDwpMfh300BcRVLxKiUx9qPAvC21BPq58dH3zdiaSx5osOMiQbCkInJwodDJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=SoYLbehl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74931666cbcso4153923b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752570748; x=1753175548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9OxszSt1/RmIAVP/jtUMOWgSI7Qv1C2lWFwEIS/7CQ=;
        b=SoYLbehlXrvZrU2CX84pR/Vicp6pUfde3MwONN445m2s7DKnGMV78V+bzzLJ8IS2dU
         rWZBnx4gjon6gc45ZdDddXtqAMZyBN95caMEEzvysxQekJorBgO0A7IGl+lLvxudnQ99
         osuHnNCBjNYExZxD43hgPPcWG8VnzEqfr0liSFXgsE2ZOJ73iaahPGRgYHBRMY0AByRv
         BPe0oncIN4cFR7sjZ/bVZ8ob0pOL570WBMpBqfFVVP9M7rlSkwI0iXRG2IYtLU9VDPGj
         WzD6I43GwSkSmRasPQ2fGT2GhTK6trQteJgd3PM7xz78kLI5Lr2yDKCQfnhpOwbYN4eA
         uqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570748; x=1753175548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9OxszSt1/RmIAVP/jtUMOWgSI7Qv1C2lWFwEIS/7CQ=;
        b=XJUr98EY3e+ZFfgLoidBz9QzLp5BsVHr+XuIHoOjE9sgVcAEadOnBS+KJHjmP634is
         72eGNwHPVJQL8qDXhqIOI+oSeKc9WotE7/n4R/rUZpTVzrWLGlNczJx+qLw3oaXYiVQ0
         CGuLy6Eu9r/VF8zFYJhIPFXyGyCOj7CX/GPm7RrdGZe+CqYNupkXqptAtBSRZua/QjBh
         ygilzfebDvV3FEduRUJpQYaqrw0ltrLlMiZbX0SjygvFPp+ULTmeplmKXrA7dAW5rPGV
         zpQjnqK6H0lED4CIGtQEA82cs8OTu24RMSNP9yANI/6xk37RYTxamFMfBF2jse/q9j5P
         bedw==
X-Gm-Message-State: AOJu0Yy8/5zFkmLpYxQuxqWZ/dOJQDgtC3PWLUtp+g66AKbmYY79WByV
	GYgeQio5McB1foOdLPmmoNYp6ZzV8Wd0IGJ6AL8b2CIEBxHTQHorl3U7HMnaJgMBMxI=
X-Gm-Gg: ASbGncv1vFDQ/6nRRAUj81hFi1TsS1Xt6ZPEDsB+yB1yUh7L16F4wgaBIDPidMGjT7R
	FslBxkHGmTqAQ53htUYqKB68F3mz/5lOucjD1VpMrvQo+jwdK0O9t0hTYyMyK0uEGtBdQqjEuwx
	U3rMM4JAEXouY6obWF5/ztOMdJHgSeUHSUdm75WdTvPl21azkrbGLqs06hTcGMac++50yGlYwSp
	7rUYRGLu6cAzEbnkNqZBP6QXXhn+dnnSra2xa90mf496VMxs3IuK6LtklCDkCC9Ka+p6sQotbXF
	p57xFjR4pCIDdiZ93zqML2lL1/hdo+jf6CjUExPoOEF/UV0kc9vf3KFKoAz+DnKZmvW66PEdA67
	JnKmkLQ91gqJQfa4uu82ofh68vjk=
X-Google-Smtp-Source: AGHT+IHq5bqBQalOkZQK/Az1F0HizrKC4bliSgq9gbU1yT+lJWYu22JoFgU54DEdjK2bLdHx1JeSAw==
X-Received: by 2002:a05:6a00:21d3:b0:749:b41:2976 with SMTP id d2e1a72fcca58-74ee0aa6410mr24329313b3a.3.1752570747938;
        Tue, 15 Jul 2025 02:12:27 -0700 (PDT)
Received: from localhost ([1.145.89.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7341sm12128350b3a.15.2025.07.15.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:12:27 -0700 (PDT)
Date: Tue, 15 Jul 2025 19:12:21 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [RFC 1/5] wifi: cfg80211: support configuring an S1G short
 beaconing BSS
Message-ID: <bbxqihfwpz3w64md63opkek3z5p2vssgs2g5ha4gwerlbzqknn@wl53iztdzxfb>
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
 <20250714051403.597090-2-lachlan.hodges@morsemicro.com>
 <4333caeb7a98bf2d29da7a26181dc34032d5bd9b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4333caeb7a98bf2d29da7a26181dc34032d5bd9b.camel@sipsolutions.net>

On Mon, Jul 14, 2025 at 03:00:11PM +0200, Johannes Berg wrote:
> On Mon, 2025-07-14 at 15:13 +1000, Lachlan Hodges wrote:
> > 
> > +/**
> > + * enum nl80211_s1g_short_beacon_attrs - S1G short beacon data
> > + *
> > + * @__NL80211_S1G_SHORT_BEACON_ATTR_INVALID: Invalid
> > + *
> > + * @NL80211_S1G_SHORT_BEACON_HEAD: Short beacon head (binary).
> > + * @NL80211_S1G_SHORT_BEACON_TAIL: Short beacon tail (binary).
> > + * @NL80211_S1G_SHORT_BEACON_INTERVAL: Time in TUs between each short
> > + *	beacon transmission (u32).
> > + * @NL80211_S1G_SHORT_BEACON_DTIM_PERIOD: DTIM period for a short
> > + *	beaconing BSS (u8).
> > + */
> > +enum nl80211_s1g_short_beacon_attrs {
> > +	__NL80211_S1G_SHORT_BEACON_ATTR_INVALID,
> > +
> > +	NL80211_S1G_SHORT_BEACON_HEAD,
> > +	NL80211_S1G_SHORT_BEACON_TAIL,
> > +	NL80211_S1G_SHORT_BEACON_INTERVAL,
> > +	NL80211_S1G_SHORT_BEACON_DTIM_PERIOD,
> 
> nit: we usually have _ATTR_ in there after the qualification, so
> something like NL80211_S1G_SHORT_BEACON_ATTR_HEAD.
> 
> Also, the bot complained about some missing kernel-doc.
>

Yea, forgot to describe the max attributes :( Will fix for next set.

> > +/*
> > + * Short beacons contain a limited set of allowed elements as per
> > + * IEEE80211-2024 9.3.4.3 Table 9-76. The TIM element is allowed,
> > + * but as it is inserted by mac80211, we do not check for it.
> > + */
> > +static int is_valid_s1g_short_elem(const struct element *elem)
> > +{
> > +	switch (elem->id) {
> > +	case WLAN_EID_FMS_DESCRIPTOR:
> > +	case WLAN_EID_RPS:
> > +	case WLAN_EID_SST:
> > +	case WLAN_EID_S1G_RELAY:
> > +	case WLAN_EID_PAGE_SLICE:
> > +	case WLAN_EID_VENDOR_SPECIFIC:
> > +	case WLAN_EID_MMIE:
> > +	case WLAN_EID_MIC:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> 
> Is that really worth it? We don't have to protect userspace from
> shooting it self into the foot _too_ much, just make sure that we don't
> get into a mess in the kernel itself. As long as the elements are not
> malformed, I'd argue we're fine from a kernel perspective?
> 
> This also prevents future updates and experimentation, and I see little
> value in it?

In that case, would you have any opposition to using the regular
validate_beacon_head and validate_ie_attr for short beacon validation?
 
> why not call the validation inside nl80211_parse_s1g_short_beacon()?
> seems harder to misuse later then, and the order shouldn't matter much?
> 
> > @@ -6550,6 +6745,19 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
> >  			goto out;
> >  	}
> >  
> > +	attr = info->attrs[NL80211_ATTR_S1G_SHORT_BEACON];
> > +	if (attr) {
> > +		err = nl80211_parse_s1g_short_beacon(rdev, attr,
> > +						     &params->s1g_short_beacon);
> > +		if (err)
> > +			goto out;
> > +
> > +		if (!params->s1g_short_beacon.update) {
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> 
> And you already forgot the validation here, it seems?

The lack of validation is one of the issues I have with doing this
"correctly". I've made some changes here so I'll leave that to be
discussed in the forthcoming patchset.

lachlan

