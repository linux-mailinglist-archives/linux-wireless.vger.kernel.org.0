Return-Path: <linux-wireless+bounces-35288-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8l4TNDkd7GloUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-35288-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 03:47:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C5464799
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 03:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF3B300D86B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2185917BEBF;
	Sat, 25 Apr 2026 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="RjF4UNoR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752314A4CC
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081655; cv=none; b=tvRcBVlTtNk4519/kRDCNqV5VL78xAFeiEaRfj961V180yFcUcJKmLJNqNWCHIakXy3AomCjfR/32JsYwkbbkRkIgDEHmC62C92kSC+c6vuaBaxJnoJnYajW76uUgBYeOexhGO+Qb1kEXgHIpRd+ilfllj4hlcf3q6orL74jL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081655; c=relaxed/simple;
	bh=mlxtZc0QH06kZ6tGKSb3kmeh4mki15DGlR4cVtEwRaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPle+nIxTUlcYGoLRfg9dmMOgbH5HMhRvccUuDLCDs+JzY/mchMJ5J8zScVO3bw50Y/iMRK0UiQrUHrPYAZ4mheTVR3hSbyKnIfMdZ0W04yCsIZpjNbIFYVmwNG81+0hXbXLAhYqPkuo7vYi1gUifP7lV1p4laVPq3Swlhz6TXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=RjF4UNoR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35e576110adso5885877a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 18:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777081653; x=1777686453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDbgk3LIrFcNnrvRDCz9fBzhhWNxXTrnYrQ2HVhKUvQ=;
        b=RjF4UNoR6KPn7wa/BcBrg/ZOMo1QAAlT9hzNtgH+mEOllvO4JG2ghXibBxS6RFusu0
         ixblfjCdgySWYFn9muujRp9fuk8VhITHanfvhLjvTI/s88TRga8lYUSPulQbSPh2izPl
         Pm82GWOBzoZLfVuZ/39Xd/e7r08fB5f0f3Pz57rsKUheVnPWccy3JNk2zifcHmGxr/5N
         m1MnjyHiNfleXA53Zq4t9/xdCxXwG/eP7TEq0GTpOVtaAT+LGJ1m4k2jE2v/c0+uohxN
         5ik5m739+nmlbc+IgiQJ6lechNiCklfytu9NfshHygmJG9B24MXqOcyhs094djxW8AUi
         wvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777081653; x=1777686453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDbgk3LIrFcNnrvRDCz9fBzhhWNxXTrnYrQ2HVhKUvQ=;
        b=dJGh7Dr5C1t2gwTZqrjotEU7mHjM43kW1S36mYKaNOeNqTxE3U8OpJLO0os5oSelAh
         uAglismyxqOL41gUCMkV0SvQrtPwWoSXHF082ETjEpYQrha26/0RCd/EZXKon+RyzWrJ
         BYFQnoeMg/qNFNhUVJUU7ZtW+5xzSlV0WwC+B/mSLMgZzB8+jt0s+40/eR00hSGz5lXl
         FuDfdRmJ4wlfCL+4Y27syeShQiX6+PEm2uqWo2aKUUHgcyXy/XE/QG7ilOGr7MkaZ6St
         i13U24VeR2YGyOIsLy0okTBChCw3t2o2HS0peLxmbx+ex57nwuNVrF95QBKjJlCN6w26
         IKbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2Yiqf3jEegImdg+0vLyOpGFuRKYBr59aU/cI7F38OTo006d5chRsj/rAXGIUiJUeNGCpWKcWlnrB9ePCwsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHpSCN/GPmtvFXAbvqs89dyczlUhl7iI1PjD1XBjWeK0JhsEy
	yX0GK7S3c0l75GLhXk25mSxiVZKCBVqrjZmW/eIKDhLwXDIwKoMi46h4HAeveEGKgAg=
X-Gm-Gg: AeBDievWiXSPQLbQ3aO6tsDZ3mnaZMQCvoCbNCyLsxlqHR381z8dtbVUhG5JPNVyOIl
	Fld3j+1HAD0calcxjrZE4r3RJ//7DpRo/oau2LchGmZmWwfc5kxhv7aOdd/2DhW5Aotg41dIrhy
	KmSYjSGE6eyKlsRZnjSG5R6NQBZ5Yv1pEdZUa9WtegDQqZIhJ5Fkx6ZfU28ljc0PXpY1x32cgat
	r8zQZMo/JqIFRs3Bo7y7BnU9AK3Seu2lvvIgFiBIE4cD/uHyW5XtIWIe+nVO8QzWTLcxbyJJtoy
	sqOVAsBsvVRXreoRPkQ48cmoLxzhKPEsalZhHkURdeiKsLkg4/ATLaJKJr71VSb0YjplquUW72u
	YLfB2j/kBvqTmsebz4IzcQ6IBkNM7pBQXPUBKEzSnJAdfqfQl3LXYdAi3TKKpTBooVPGcXVpJ6D
	kiHnuFdnbRS1HXberoA+IM/A8UX5Jaoj47yhd/tKVYwJmAiQdGNDFjugF8OGYKrRVtQm3qKrSqw
	GU=
X-Received: by 2002:a17:90b:4cc2:b0:35d:a31e:6b04 with SMTP id 98e67ed59e1d1-361401bf776mr30877364a91.3.1777081652938;
        Fri, 24 Apr 2026 18:47:32 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79770512afsm19500117a12.31.2026.04.24.18.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 18:47:32 -0700 (PDT)
Date: Sat, 25 Apr 2026 11:47:28 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Brite <brite.airgeddon@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	fjhhz1997@gmail.com, oscar.alfonso.diaz@gmail.com
Subject: Re: [PATCH] wifi: mac80211: restore monitor injection when
 coexisting with another VIF
Message-ID: <4i5nyqdrtpgm575dd3swyp7662wjdxu3hky7ucgwnuwigx5ge4@tc474ip5qxtc>
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
 <20260424120807.25005-1-brite.airgeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424120807.25005-1-brite.airgeddon@gmail.com>
X-Rspamd-Queue-Id: 1D8C5464799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35288-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim]

Hi,

I will leave implementation discussion to Johannes, but I have some
generic feedback;

> + * Context: Must be called with wiphy->mtx held.
> + *          Always process context - GFP_KERNEL is safe and appropriate.

This comment seems redundant given the lockdep assert?

> + */
> +void ieee80211_update_sole_chandef(struct ieee80211_local *local)
> +{
> +	struct ieee80211_chanctx      *ctx, *found = NULL;
> +	struct ieee80211_sole_chandef *snap = NULL;
> +	struct ieee80211_sole_chandef *old;

Don't align the local names i.e

	struct ieee80211_chanctx *ctx, *found = NULL;
	struct ieee80211_sole_chandef *snap = NULL;
	...

> +	if (found) {
> +		snap = kmalloc(sizeof(*snap), GFP_KERNEL);
> +		if (snap)
> +			snap->def = found->conf.def;
> +		/* alloc failure -> snap == NULL -> publish NULL below */

Same here - this comment adds no value

>  struct ieee80211_chanctx_user_iter {
>  	struct ieee80211_chan_req *chanreq;
>  	struct ieee80211_sub_if_data *sdata;
> @@ -729,6 +784,9 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
>  				     const struct ieee80211_chan_req *chanreq)
>  {
>  	_ieee80211_change_chanctx(local, ctx, old_ctx, chanreq, NULL);
> +
> +	/* Hook 4/4: channel parameters changed; refresh snapshot */
> +	ieee80211_update_sole_chandef(local);

Without the context of this patch, there is no way to understand
what this is doing (same with 3/4). The comment doesn't help and
the general idea of a "sole chandef" seems strange. hw.conf.chandef
is also a sole chandef?

> +/* Defined in chan.c */
> +void ieee80211_update_sole_chandef(struct ieee80211_local *local);

Another comment not needed
 
> +	/*
> +	 * All interfaces are gone by this point, so every chanctx has been
> +	 * freed and ieee80211_update_sole_chandef() has already published
> +	 * NULL. Assert the invariant.
> +	 */
> +	WARN_ON_ONCE(rcu_access_pointer(local->sole_chandef));

Seems unnecessary?
 
> -	if (chanctx_conf)
> +	if (chanctx_conf) {
>  		chandef = &chanctx_conf->def;
> -	else
> -		goto fail_rcu;
> +	} else {
> +		/*
> +		 * Real-chanctx drivers (e.g. mt76) do not assign a chanctx to
> +		 * the monitor VIF, so vif.bss_conf.chanctx_conf is NULL here.
> +		 * Fall back to the sole_chandef snapshot maintained by
> +		 * ieee80211_update_sole_chandef(). NULL means MCC or no active
> +		 * channel - drop the frame.
> +		 *
> +		 * The snapshot is valid for this whole function: it is freed
> +		 * via kfree_rcu() after a full grace period, and we are inside
> +		 * rcu_read_lock() throughout.
> +		 */

is the bottom half of this comment really needed?

> +		struct ieee80211_sole_chandef *sole =
> +			rcu_dereference(local->sole_chandef);
> +		chandef = sole ? &sole->def : NULL;

nit: space after local declaration

> +		list_for_each_entry_rcu(tmp_sdata, &local->interfaces, list) {
> +			struct ieee80211_chanctx_conf *tx_conf;
> +
> +			if (!ieee80211_sdata_running(tmp_sdata))
> +				continue;
> +			if (tmp_sdata->vif.type == NL80211_IFTYPE_MONITOR ||
> +			    tmp_sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
> +				continue;
> +
> +			tx_conf = rcu_dereference(tmp_sdata->vif.bss_conf.chanctx_conf);
> +

nit: remove this space after tx_conf = ..

lachlan

