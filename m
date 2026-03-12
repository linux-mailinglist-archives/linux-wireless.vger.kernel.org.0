Return-Path: <linux-wireless+bounces-33043-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONbcD8dJsmn8LAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33043-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:06:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D326D482
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A724301C15A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA553A1681;
	Thu, 12 Mar 2026 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="MwIC1fMu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE343976B2
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291972; cv=none; b=KkE8x7szXyPIVSRz3vwuM2vdYP45NGsb1tU5dlOGtmQqzIXGBNI7CdCLi5lzO6EXWDj84RA1Tz547CcQaBtY0O/9LQUiy4ESKoaOZQxx5o9DPekpb73l0V0KQj+nI7iBGMjr6ChC9UhaNmaGE83Aisje4AvPg6WDiQcFwy4rhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291972; c=relaxed/simple;
	bh=GOwASmi9jXCVcRijzrzkwH4bMsO4RxA+K48QABkjVwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz9zZAldJX3WudZjo1DwudxKrIWnGn7NM8jRWlDYBN8aV55J9WP9krILjlJCxPyg5ShMkW/a0w9oNgqoOuWvyV7uHKww3PggvbL5FMwuBITl79UMownA+FGtINTPTNUDSVjJZnydOCCHmWhDx0G3VMGHGxxM/YaOPhUpgNtWBh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=MwIC1fMu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82985f42664so371674b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 22:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773291971; x=1773896771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GwfStmmXpK96p/L60KF8aIs2+dXAuqxeTiEYEZjwryk=;
        b=MwIC1fMuaNh6//ZBtKM0p7CKprUh6owkLWuNmqWCMOm0NUtQvKJrVQyPugWHFxFCzO
         dVZG3Om853qLfEGZeL7s+XYiwrUjJO730fTyjgQ3ICPAoA8djbDN/ulWOExUZOdrXD/R
         0Zv48Pm1C7Z2ln2CJN4nPiQuFh50fZma96U28AGIhcSEqhqy2Iq0sMhIwXJXajgE9iNK
         nRHLwObUKF+k4X0uoOLh/ZFh6dKlcwmcO/WyPSuV/p2maptx0/XW1+zyx2oGyKnQL/8S
         t9qhNkcYTZ1X3TU3lE/IFNFq0PRZGQS7cB/JVthsTFPsHLrcZGv5GVwwZEq1maYhW5vq
         V57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291971; x=1773896771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwfStmmXpK96p/L60KF8aIs2+dXAuqxeTiEYEZjwryk=;
        b=LWcrj9s5R300dQeiayHiNMryYPvx9Izdxff3e14Ku6xhcbgRAAHcIdlr13rBQQLzXs
         N/4VetnqJpEuyEXjWm0Rz1I5QlTGuUcKo+Ur5g/v1T0jZQQGqSTKjqXez7p1kTBfHgcE
         fko8LcjLa29+ozmZz/Nsl6iAwMKl6oUiWTpbHA8a5cRXgjB0fPl2deSyOe3S9/rbwFqM
         VsYEIVaJx+t6oFXriHs0EuB0AYeGYE1TuE2gBF48WBKJnpC7O2LenUyY9A7DOQ5g+v0J
         xmeVL4oOXO1sGXwSo/+Q+P1LAcFPsV3XspuQnMjv2mcHR86/jJ2r5ZU0Z059J7HzTilG
         AodQ==
X-Gm-Message-State: AOJu0Yxt1fsNkLGIpV+9N7cPhGvsB1jumN/Nj09stjiGjosLQ0Z5hucL
	HmGTlxbM4ihoBNAnQjKZRhYAQ3UwCQQOL4okeAM66xLZI0BQzgJNNHvlEJA33gbgCUk=
X-Gm-Gg: ATEYQzwI3k7QquZcWHo3yfhDPZKuL/FsjKgytwX78OklJ4J/H+eDHk1Nfu1dtg96uBA
	VBlznOMTMhNwH3kKY3D71a80S40DphTn1gOau4csT5+eFgYuzA/AsloyBkBnsnh7wgwe1yPYXwM
	YV1FEYdYVg1Bia1P+be9ljj78H0Iuh3FVq8D4cVrcqTaWpvueFXeqpEYHmRVIbbjxE022AWIjTH
	IdAd5tUyD4f6+zlfwgcCGDbwKwjnShja1DVnNBJmFh2aBmtBAYyJTNVXvVnbn1jxyZP5K75+4h1
	/vMVIgq2H37ULIV2XlvQTaFhae8dHhJM8TaQV3YyMkDV4MclRCLmnbHr8Xedl+p1uzcqqJinqgs
	UzpDOwL/L20KndwFLPQ0I3+QcIiC8nK0ct1kIn9qDn07rbo3Uh1RUfxbyS3+bHaUjylL9PQ5CYm
	yJ+Pyfosl2aEyd225ehT0yduqhtAH1vXEHg+1qXs5Iu5c7jXs7l/xZpwbjaRFqvfiyZ0dIxNPjB
	sl0hVHl6femQAZEy3DA6BQ=
X-Received: by 2002:a05:6a00:4390:b0:829:7a4b:3768 with SMTP id d2e1a72fcca58-829f6f40bb0mr4489843b3a.25.1773291970530;
        Wed, 11 Mar 2026 22:06:10 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738bca8sm1373609b3a.60.2026.03.11.22.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 22:06:10 -0700 (PDT)
Date: Thu, 12 Mar 2026 16:06:07 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next v3 0/3] misc chandef cleanups
Message-ID: <jl5ftay42uv27aq7e22sxmd5swebafymq3uhk3spo2hm6gkx5u@jfc7uijgify3>
References: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33043-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D64D326D482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Lachlan Hodges (3):
>   wifi: mac80211: don't use cfg80211_chandef_create() for default
>     chandef
>   wifi: cfg80211: restrict cfg80211_chandef_create() to only HT-based
>     bands
>   wifi: cfg80211: check non-S1G width with S1G chandef

Ah something I forgot to mention is I put the mac80211 patch first,
otherwise maybe during some bisect or something it would break if
we changed the cfg80211_create_chandef() without modifying the
creation of the default one first.

lachlan

