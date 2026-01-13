Return-Path: <linux-wireless+bounces-30723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8ED16923
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 04:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B74D6300A7A1
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 03:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0A31A7F2;
	Tue, 13 Jan 2026 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="TOVaAmh/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D7315D2C
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276588; cv=none; b=NxmjlzuBlA0HjMclLZet1LCDPSEkln5/BFpfyKmyw472hrJdGo+tW4e1ErwZifa/YE46fgDH8Qi2CYy31Gy5eQf3edYTib9vWS81sf8cw6JJ1AKhEXdQqhaTl6KmGcn41q8YTt4V6poAQr++Z1tTFD9XV6qSCl8WyvgGftshid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276588; c=relaxed/simple;
	bh=SWvOBqUw+VvA1lS5YstYEBn104wCaDGx4sQB1gQxu7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGJHbY1EAgK+pQUFuVNlWbl0Nb5NDuNjs/x25eFx9K183PecbANiBOnUKZvDHfvtE6lr3EM1y0k/hpPtVG16EMxibxSs9iEIZPokWA5cLimpWB1Be2vbLUtOyklt2+EWKdA0vk5pVLArMHON6G1nUvYTB21XYot0KfCS7YbfPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=TOVaAmh/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29efd139227so49690855ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 19:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1768276587; x=1768881387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7uJxpSimBmDj+yrVe0KKcl3FvE4r/2uj9DlZGTble7g=;
        b=TOVaAmh/ew8t9Cq4r7He9MJCrVVBH5Anj2eCqXHZSYtCGjHaR+2/i/6oH/KBCLdQ6m
         MaZmID0iS4LxvpJ0NTExSpDy9x35rL51ILS3d5UH3Z8XiPxnVXnRmATVPBGlJuz++EiC
         vW6z4t/HqSM3boNo2zNvpu9XEfyczkq89Z7VJtYWGhclHsnN9Mi8vMipXYgrX5XPsDxp
         bqDplhRQNKgLUw8iF4VYtAJ/bR9vkJfNA5cZoI5paOoFWe81t1o0Ex4eWPigGU1t66++
         UgzIS2QmeEQZyFxR501YB/8p485tutN5qsw+1Gll9qwKc5R1K0Kv8NVOvL9/uYIjJfaf
         xd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768276587; x=1768881387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uJxpSimBmDj+yrVe0KKcl3FvE4r/2uj9DlZGTble7g=;
        b=m8gkMUldR2WcIunYhLk9r4m+HFtfgO4VeFoYHGvN8RE1GbMW1UGKMdQsKpCBbaRswJ
         Dp6uxYtFHRIvSiXn0kvaKcRyIQaJ0ejiX/RnGpxa2oT/jkyEwslODHJtFSnbthP5OMHS
         LdXOz2iygC4fcpzqnI47jNEBlcZXHnl3UACOiVJSm/WTrKq9R2hsSgxLUEGSxN18EQnZ
         wMnk97vId2OJlm06rvvIyEVBq+KxQwbCE1XYlOH7kmbEjPpaHP5tGW6Uiwnv2eUDaykv
         Y9magA5sHCjsUSbFtFmUd71rtcR5+V7EF2sHH56epsxoJxJONmhqqSVfWPiKxP/w+e+T
         Ed5w==
X-Gm-Message-State: AOJu0YznEDANSx1YKGjhw761u7UyzPU52FjZALiHocD3zC1jrTc/FeP4
	UTFgplbKycvL9BQAMH7TMbsnO8dpCXe9Udvve1IFpjQZxs7vhqDsfNkfF5J8Jn5SKYA=
X-Gm-Gg: AY/fxX7VE5Ue4FgKE5vxoWagXNH7Wzcq1Og0vxLJRaqRFtohkHU92mxc3NA7Z1fBEnq
	ERjRdsBqyCZY8B0thGQYJC0+G+0WJbxd4gBEP4NMbOn9KBOboiHPoT3RacrCw97LAQNJ/Zf2R3b
	rEdBXHWQSYdORdvc/Mr5WH6mPU+YImyJgivAbm5DP6iBNdJtzaNEJn7gxuj2CJtpMFTckx+Wosd
	xtNmSVyL2tv6PdEwiIHmNF8CKMcVD39RAXWvE1Ms33Hjjjr5rKhrEs5OXNhWtYrQkC+WcY3l/+H
	VT3LxJbu/VvdAGMXXp69Uw5v0z4gqvDRPXGLGD/9FDzM5O+8ilehFspcBQCOTVUqWK00jsRUDxt
	cSoLGUXoeQbMLbUY1NIpyXVy3uDxwejOFKwYhThO+CoNWA/fSD/yegL2U/mINIOKSA/rqpc2875
	HOhWXWkz/1CnC1l8foU8Do3hNErm0BwgwTZKgOQuuo+2wyPxbCQNfT
X-Google-Smtp-Source: AGHT+IGcCw7/ry4jSrmf38+5OAAJSCU2+aCdUERr+F0pJjaXkKGBc5A4ZLG+JQEgyXbB0Sv0HQsSqg==
X-Received: by 2002:a17:903:178e:b0:2a3:e70d:5817 with SMTP id d9443c01a7336-2a3ee374d39mr180808315ad.0.1768276586590;
        Mon, 12 Jan 2026 19:56:26 -0800 (PST)
Received: from localhost ([60.227.235.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3f3115682sm152100685ad.55.2026.01.12.19.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:56:26 -0800 (PST)
Date: Tue, 13 Jan 2026 14:56:22 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: cfg80211: don't apply HT flags to
 S1G channels
Message-ID: <csqd3cp5twlhfsrkrppe25q2xby6wb37fhtxfrzgffjzoww2hw@xcixpwzlxzmi>
References: <20260113030934.18726-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113030934.18726-1-lachlan.hodges@morsemicro.com>

> 925.500 MHz (Band: 900 MHz, Channel 47) [NO_HT40+, NO_HT40-, NO_16MHZ]
> 926.500 MHz (Band: 900 MHz, Channel 49) [NO_HT40+, NO_HT40-, NO_16MHZ]
> 927.500 MHz (Band: 900 MHz, Channel 51) [NO_HT40+, NO_HT40-, NO_16MHZ, NO_PRIMARY]

So something we have been thinking about while we test the implementation
against usermode software such as OpenWRT, and not just hostapd,
is that we don't have an equivalent to the [HT40+/-] flags. Now while S1G
obviously isn't HT and while this doesn't affect the actual regulatory behaviour
as mentioned in this patch, the information conveyed is still very useful
to usermode as usermode itself can restrict what's allowed.

However looking at the regdb, it appears that the notion of HT40-/+ is more
or less a "cfg80211 specific" regulatory componenet where the adjacent 20 MHz
channels are validated to check if bonding in that direction is allowed (please
do correct me if I'm wrong) which is more or less equivalent to what's done
for wider VHT channels and S1G channels as per this comment aswell:

        /*
         * TODO: What if there are only certain 80/160/80+80 MHz channels
         *       allowed by the driver, or only certain combinations?
         *       For 40 MHz the driver can set the NO_HT40 flags, but for
         *       80/160 MHz and in particular 80+80 MHz this isn't really
         *       feasible and we only have NO_80MHZ/NO_160MHZ so far but
         *       no way to cover 80+80 MHz or more complex restrictions.
         *       Note that such restrictions also need to be advertised to
         *       userspace, for example for P2P channel selection.
         */

(13 years ago!! :-))

Playing around with some 5 GHz configurations in OpenWRT it appears that only
so much information can be conveyed and indeed there are configurations that
will be rejected by cfg80211 (or maybe hostapd in some cases, not sure). I
suppose what I'm asking is - how much do we need to protect usermode from
this? Do you feel it's worth including a flag that somewhat emulates
NOHT40+/-? I know much of that logic is quite old and S1G is "modern" ... ?

--

Now on an unrelated note while I'm sending this email, we've sent a few additional
fixups / cleanups over the last 2 months as we hope to have a driver submitted
for review in the coming weeks. There's still 2 small fixes that need to be
done within hwsim before we can send up our hostapd patchset but I will
wait until we have at least kicked of the driver review process before sending
them.

lachlan

