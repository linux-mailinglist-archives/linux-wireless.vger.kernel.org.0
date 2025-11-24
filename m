Return-Path: <linux-wireless+bounces-29275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 266CDC7F3A8
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 08:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54A8F347267
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F302EB86A;
	Mon, 24 Nov 2025 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="yjU5V31X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C132EB847
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970065; cv=none; b=b17qWNAn402gdsbISmhMAMWHMkS1ll7cXVK3rhloo+hWquNiqMqr8JFCjitFc2qF9KovIKNsXPbXeHJz2a9GAxWwzXGJHwPmIz25OYgElBln55Pxhi9n1DTPx5WiwH4UirifOGlzb3obkmCzwzg8qdsfb2qbHVkFvNFyZCcFwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970065; c=relaxed/simple;
	bh=tS9JFXZnHznExIV3KvEVgCd79bIN1HwEFkXwECS9Kzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLxcty/n8qukGFZwr34/6fZL9iHOCfnjyGlE25pLVcsm/bmYQYXH2dw/JOIhhO+JToug0AIdbqm6Iad2oJ5aZ3wfIIPkDWs9Y4kudtFP7Awe5VySSffKZShr2gced3mdgIfJ+mgOmit6xZvXfF+VPd4RE/Qpn13vndYI/vSyBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=yjU5V31X; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so3225289a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1763970061; x=1764574861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUo7+ECuH1paZhOXML3GUIN5dmSWOEn94r5f6cvR2n0=;
        b=yjU5V31XP+vSx8zemr/As2sjVWsFNFm2lWjDuOoLtcK0vLDe4e1uOwV1cMB5iC4stk
         nItovxMqesXxMBGZ/R83TgckmNiKOejFr4sQSpS8PWZVN/pQwkNkhC6GwhCeo73QHXrX
         NFi/LXz2081ymeXP4puFz++ejeBP8bLPiY+nJ8gDi05sZ3ICFHzekl6Z60U10v3mTjMs
         yA3O1u+T4qmoymRCfNcUs2cceEiM6dGD35OtIffJ/t55r83vAmAfuEpsDCy8XH8NBS8y
         yoV3oJTnYZs+G+fNQlNFPJbjUi9UOCsz04cybgpx8YPKgZTm7GCL4o6+XkuZtQpPAcVt
         IV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970061; x=1764574861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUo7+ECuH1paZhOXML3GUIN5dmSWOEn94r5f6cvR2n0=;
        b=Im9n2HMaQJXTsh83DOIN86sT7ydycn+S+5KwYEroesAQfMyrCkOhvO1UfTxGYooZ8u
         V/qiMVbfa5Xz297b3LdtmSaVu1Hx1JVNW0xkEXbvtZzNGfQ1ON63RFm1WwmLknubaopn
         ygCd/YZWXnTXJfKiK7vk6AZBBmidtBecSMhMMKV7aFaYwnV/vZbBQTltJ6F7eBEO4XCc
         3mpZY8kSfe5QYS63SwILYq8JQSzDGddDDtGwkln4rIIMSgezgxWk2dUIV9wnoZCExt7Y
         73M9p+TzS87CIwXWIwuGgeiKIck/GXFDfjPnD4YuG5r5F2l6J8HC9OLEzsnafWHhR0JF
         X7Gw==
X-Gm-Message-State: AOJu0YyaNb+vdvMlw+FM8SvXjh+KuSa2MuNcq/3MgJtBHH6I7bMjY1Vy
	p1vg5yLXme2ySNUFuT7dJuWwj6H1EGkBQn6odeQk/ak0RoqNmTK8fRoHufjJJnGew21RfZacJbW
	gBAOLsJ4=
X-Gm-Gg: ASbGnctEAa9rRwPMtoRKz+gvXQ/3W1kLMi5Z676jmUbQON6benOEB9+0oEkDHdBq7dK
	oYFtazhCECm0Sn3EXffXVSH3KLB0ZQrfVVXuxdlj3ZWUcCY0fn1aDil/Jueo/QuHLr1lXm/bSsL
	dRUSuGvi1cC8vLoLxdkOFuqFf1WxUvLZn0wkp2ITpJEsSWf4tF1G24WCkHTpx2qqQxxQhbgh9IT
	B53xvVoDgEf8oCEQVTl+hM/LTBTboV4FkO8GHLaIWAYBM1Ri+LNDaDL450lm5NayGq5yGIHrC/i
	AU8s/smpmsyHLATiGgbL0zDM1D9veaooK5AMJLTFXo8llzYNbcNCkH9uCjfyb/UjqAOBIWC1Flm
	bDOE9N2kreG70e3egBEIjyW0m1UqHTttcewZbpKHlwKFhEL6eFMkFol9Y3oiW1t2/8h4jwsidgD
	G5A+ZDTFIlvU0ymNd47HspHIty3Ag64LZPX77ksEieNhF2U9uYJ1mmHJO1/JnJLTs=
X-Google-Smtp-Source: AGHT+IGNX2/I0lXHos5WbdmrEbTRFIcf7AsBlcWNdiBVU9+qnpP7XRoZlJyzAMCr88uTEo13oK65fw==
X-Received: by 2002:a17:90b:4c04:b0:340:6f07:fefa with SMTP id 98e67ed59e1d1-34733f19bafmr10363866a91.20.1763970060901;
        Sun, 23 Nov 2025 23:41:00 -0800 (PST)
Received: from localhost ([60.227.142.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0d55b71sm13735336b3a.55.2025.11.23.23.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:41:00 -0800 (PST)
Date: Mon, 24 Nov 2025 18:40:57 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next v2 0/3] wifi: correctly represent S1G
 channels
Message-ID: <tx5ss62hjgfuha57z67cefnbdmxld4wrxjeudghpojxpxkbtab@22b35kctcbti>
References: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
 <5ec4190eb06c2b3763b8eb9d114a200d07437c11.camel@sipsolutions.net>
 <lf22zjgof4ysu4v3blfbt3kv54l75rdbw3pecknlmlq6kmokha@a64bzx2dtrdr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lf22zjgof4ysu4v3blfbt3kv54l75rdbw3pecknlmlq6kmokha@a64bzx2dtrdr>

> >  - _cfg80211_chandef_compatible() (not sure about this regarding primary 2mhz)
> 
> This looks to require a similar S1G specific path like we did within
> _cfg80211_chandef_usable(). Also zooming out a bit, may need some adjustments
> within _ieee80211_change_chanctx(). Additionally would be good to extend the
> unit tests for this.
> 
> I will do some more research and testing here.

So, I have been doing some reading here.

Firstly, _cfg80211_chandef_compatible() is not used during the association
process as S1G doesn't require the same "upgrade" process to parse the
various HT -> VHT etc. elements and ensure the HT chandef is compatible
with the VHT chandef and so on. (This is obvious though otherwise S1G wouldn't
work at all :D)

The next scenario is channel context sharing by interfaces. This again would
be very similar to non-S1G - where as long as the primaries are shared the
channel context can be used (among other things of course):

	[...]
	if (c1->width == NL80211_CHAN_WIDTH_1)
		return c2;

	ret = check_s1g_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_2);
	if (ret)
		return ret;

	ret = check_s1g_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_4);
	if (ret)
		return ret;

	ret = check_s1g_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_8);
	if (ret)
		return ret;
	[...]

The above would then be in addition to all the common checks, such that the
control channel is the same etc.

The problem is, as mentioned previously, adding specific S1G Tx/Rx rate
flags within link_sta_info / ieee80211_link_sta such that interfaces
using a subband primary (say 4MHz on 8MHz chanctx) can clamp their
Tx and Rx is not super nice (This was briefly mentioned in [1])

So essentially I have two ideas / queries:

1) For now, we could simply say unless the chandefs are exactly the same, they
   aren't compatible for S1G. We don't even test this internally, but we
   aren't the only users here. This would enable _ieee80211_change_chanctx()
   to function for S1G, probably through an S1G specific function that we can
   extend in the future.

2) In the future if / when some basic rate reporting / S1G bandwidths are
   implemented this could be revisted to mimic VHT. Implementing proper rates
   for S1G will probably require some time to figure out how to implement
   it cleanly.

Let me know what you think. I will also send some patches for the
s1g_primary_2mhz in the chandef sometime this week.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/20251008014006.219605-1-lachlan.hodges@morsemicro.com/

lachlan

