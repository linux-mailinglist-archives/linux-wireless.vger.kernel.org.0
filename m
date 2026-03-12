Return-Path: <linux-wireless+bounces-33042-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id V3COH+VIsmn8LAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33042-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:02:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA61526D425
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 569253051D39
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B933FE10;
	Thu, 12 Mar 2026 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="lp5xZZgn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399DA3321C2
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291746; cv=none; b=olCrJHMcYgrAvvhhajoWBvJyDq0VqVZ/g9+htzXbEVKGKhgoxxVvxF1Fxd7p3Zb3//0D8kMhSH0QYeoA9ljCPEiGm+XvnTuSwrvmHFm1gUBj9vwCLIxg5DIFbt+mSs8S8Tq8YWnBM1qHlhRwaNPqS6pW/55DI+hF2HppXZVel0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291746; c=relaxed/simple;
	bh=zQ1ScD2VlQI9e1AxnRwiEL5ET11/oTCaW5Geo0kT7s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU48gB12lHyP8MJFA7EmT+tJyAKUJNBr9k0wJmLnIobYMxkWjGp6DjtjQAVPKHXigup1JRKAZs6fqJI7/wyWVXkCmZrizSuWnUJrr0UYhIKZb6HLlqsUcnMPHuhM1+/4ni2lMSNtzahx2xzVHMvIcd0gyQJd7BsNVLjQ6S/yRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=lp5xZZgn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab46931cf1so13655715ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 22:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773291744; x=1773896544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvZZyWXnpeIA/F6JdEFAm/z7wX/n0fiVqH5ORTiFerA=;
        b=lp5xZZgnMclowLaFK7kFeoy0eQjUtr/ekbb80AaovsMSeusEFX9onI4HIlxSu8OQDN
         YR91N9JvD9ia1U9VO8o9zuBLxOLiffnjJk6Y8cVpEnxUeAXOmcKw6dP5TldAZtWlBda9
         B2N+JizU0F4KjmNQmdTVMdtOiFRg5ytwNwXCf1JdnpGm/FFulmZoW2RhNNyCu3s1O2A6
         bIB9AIr4GXSyxuot1FjVqK3pMJMvAdFTElnlK/RKxQy/1wgqChKnfcQcjLBtxmcv1qU6
         /iPc96WzcgMO1tHLaGfZd3vMwaNmbHst6MGSTzkYkd5A1+Udns17wGs0UzH0xWUSPFs1
         3sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291744; x=1773896544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvZZyWXnpeIA/F6JdEFAm/z7wX/n0fiVqH5ORTiFerA=;
        b=o+ysgeXTIuaWJ4hmkDmaguF04XsMPXTMKq58Y3HGPt7IWTTma+ureFOFXlYh9ayM/A
         V9xzLRFr9aYTxp8DeOJJDU1kgVVrh1P6AFwiURhNi7EsCVGcs+NDbqw6V3Zk/U4IHmlV
         x6Dr+MIktlz3jAGlCYwd5sB4WxZcnmn9LBhcwXFlHJLhRcrEenI84EABd/Jno5sXmkaE
         FVjpetxfu5x3RZJDyWTwK770Hk8q6NmV24cNAj92wSlQandhSGcPXI8JrweJhYwNYjlz
         H0yamywfO931bgYBk5935xvgYaLbzK+Z9GVrSRXPF7ZwA6L4S3GdmmC/w0QiJI31OtMQ
         nxnA==
X-Gm-Message-State: AOJu0Yw+LdA/wJnIocFuKFE353lgwICGJNU7+Gy7bNXGbEsM244/mn1s
	VJCtw9+sYvSfAxveuS4Fz4V0mPXTSgLLMgp/za8bLOFR2NzbbNKsbbWYZBjOkPQwM2GpZl2TpOF
	Wqi9B
X-Gm-Gg: ATEYQzz8xbzDONv5A4qv5FLgQeKiA+Ck794WOXy4zEYcUQlsfDkIrC60y1wCIckhBhz
	mykgoG0v6fJdSGU54tFeRuPlhZfI9mNuA1sNAHblzEmp89uHEUQUZ09VT/D+E++bunZbkvpZydX
	9NGrTIhOf9nZDiEx+dbi2nwzcnQ/7VhZx89adVwzhGbRdt2XsgBXn59GWg74MY9KCgdyb+kKp4N
	eFzE7t9Ep8PzhNAXUbN2CkqpnAq0JSmsQahXAzbkud8Bj8TZOFFaxMJSIEMiP1jAvzvnTPqRKbK
	Fn3XoreOdNbRCIXpQOOfFxdDl0gJiVwC5oG1SwdmIX2grRan8BSnGpldxw+/k8QlnUsVjstzXzy
	DLoy+u1Zk0iIPab4FS91c80K57peJOkfc0P8K6zp/LehIultdROEHZUj/jHM+PeHMddUz0UrLTR
	PAtBOqesCyLLxZgPVIrw6spvmrTr1y5t5+RNxxKsPthfFQCxBvM8lteZm9qkUUKCCjMeOoEaj6s
	DCEnvy549BPvtW2z3KRjPw=
X-Received: by 2002:a17:902:ec85:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2aeba4417a7mr19736575ad.2.1773291744514;
        Wed, 11 Mar 2026 22:02:24 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378a1dsm57953455ad.83.2026.03.11.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 22:02:24 -0700 (PDT)
Date: Thu, 12 Mar 2026 16:02:19 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next v3 3/3] wifi: cfg80211: check non-S1G width
 with S1G chandef
Message-ID: <hawbfgavdwvganyq4xxohx7osgqanky3xwidoouer7wzludoqi@wvme76rvmimf>
References: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
 <20260312045804.362974-4-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312045804.362974-4-lachlan.hodges@morsemicro.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33042-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BA61526D425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +	if (cfg80211_chandef_is_s1g(chandef) &&
> +	    chandef->width != NL80211_CHAN_WIDTH_1 &&
> +	    chandef->width != NL80211_CHAN_WIDTH_2 &&
> +	    chandef->width != NL80211_CHAN_WIDTH_4 &&
> +	    chandef->width != NL80211_CHAN_WIDTH_8 &&
> +	    chandef->width != NL80211_CHAN_WIDTH_16)
> +		return false;
> +

Admittedly this makes this already noisy functiona fair bit noiser. An
option was to do the following:

	switch (chandef->width) {
	case NL80211_CHAN_WIDTH_5:
	case NL80211_CHAN_WIDTH_10:
	case NL80211_CHAN_WIDTH_20:
	case NL80211_CHAN_WIDTH_20_NOHT:
		if (ieee80211_chandef_to_khz(chandef) !=
		    ieee80211_channel_to_khz(chandef->chan))
			return false;
		if (chandef->center_freq2)
			return false;
+		if (cfg80211_chandef_is_s1g(chandef))
+			return false;
		break;

Since that would cover all the cases where a chandef is initialised,
but not some weird edge case where maybe an S1G chandef somehow got a
80MHz width or something but I guess better to cover all cases.

lachlan

