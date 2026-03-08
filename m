Return-Path: <linux-wireless+bounces-32716-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z3QoGX0mrWm2ywEAu9opvQ
	(envelope-from <linux-wireless+bounces-32716-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 08:34:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF622EF24
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 08:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8511B3017C35
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2026 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4621CA13;
	Sun,  8 Mar 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="SWcuz5ah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7417A2EA
	for <linux-wireless@vger.kernel.org>; Sun,  8 Mar 2026 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772955257; cv=none; b=pVxqtEY8dIOo30xxdPjg4MYfyLhzSSGDrHacyue3TdKX4E2E/DhWozyDcUP2XS0KWzRA3z9bTvLhX9KiGNma7w5/lWj8XVp1LmAp/tqZyVvcQ7JyRnT/O0ZWxSzPSEQxuPFeop/yvFAAqWSlcW3vdPczFuAAUC7/oiS5YRgEiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772955257; c=relaxed/simple;
	bh=q6hDr7o6nM2JCDINfA4nFGlxT1lZUO++vrggu3Sh2PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNxNzW2/DEhFAhhbKFKp69k2EvEB/4KW7GcrVlT6byEjmzg+4zdSC0kbNGYqc7mlS2XQwvpXu7x3xcrVtR0+WZ51ZHWFGD2U+NU6uvNcImerOut+Owc76n6vLlVTGfV+dfjj28owz+0sjkRAhKRUXzLWVzggmiKV4kPV5hzKKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=SWcuz5ah; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so2314499b3a.1
        for <linux-wireless@vger.kernel.org>; Sat, 07 Mar 2026 23:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772955256; x=1773560056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLLooLNh/hqXZDf1JcthfOMLcySSPO+hnBkJICZjlko=;
        b=SWcuz5ahKKZEs0qwEWXE5hENDmQKr/6oMJV9tmQkmAsOBtGk89Y7Z3Dl7A3gYYmpNX
         KIAnI8vud/oOCm0JtsCYv4/spAqKDeM36tnb02gHumqU72hY7tVhDKq4F6LAOqbBPN2Y
         z9GZfiuWdWRu5wi4ZK4KB0NU5VzpWy8sJYHbjE/qTFee3jLYk7vLlL90+dq2U1TmZTgo
         Bt22cRgKqxoGDV4ie4cDouaj9UmYZKJNWpv4BVSZqmLsUH43LZi14C87tGcEJ811kWA9
         M+3qRiVf4NSKhwHuQgYfOkrAHQ3UF4Y/8/MzSiJBFD4RQDwAnxK9zQLT2ZIjjCAisgCo
         SP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772955256; x=1773560056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLLooLNh/hqXZDf1JcthfOMLcySSPO+hnBkJICZjlko=;
        b=E9srTC+LuJmgfoE7CzeQVFSPMsaVzyeFYmcAfGzc42i9CHwdJ0X4f5Jf20zrHmOTNm
         4fGsirLC0bGQPLpEhikJggDBdOmZ/hs2f2cx9x5eaSFRyY1J8YNvxBROytr5ZJ8ed8AP
         sSMYd0xQTsq1KZvt3C6yHq1566mRHOiOD87LVebg0ePiyggD4ll8TqozOMmqGbH/2is8
         xHO4JQqvcHoe24Z2BZvQqC/vjXP1YRTn7eyqfYzKXkZQAliU2oru+LbirUnQuEoIUEc5
         F98rcMjx/8WfgeijiUUcSV3WDkUqhflRmpNKfQ04F9tH7H9U4X4BbHstutMYHS3EdjR/
         DSJw==
X-Forwarded-Encrypted: i=1; AJvYcCWN//QejCatAOcR69ZFYpepAnNN5QB05O7fEtg+d6CJRfA2ubDbBBjfjfNt2aVcC4yoHQm9ya4+asGVK51D2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdIGGUpNkyN8qiWArbxwyL+UjO5QWmR95WV+EYsBIvn1izjWy
	LswZItCZCufvCWEbXLQ1H10k58uaeyJyu2KRIRzbHxvjh/mAbRYNCTNONdkedQwSVY4=
X-Gm-Gg: ATEYQzxlE/zPyguEEBkS7b69VXYTOAmt1CC2Fql5sHc81BQik9n1yFiiJ6wqXZfoRJ6
	DbFptVj90GOHWJ69LQoU91E0xotWrIHbM8QJ6ZL/MMdSagnrMnun3+ZiRP2utRN2h67kyKNnLcp
	U4rNySKfNDtWZVOlHhZJdfuR19JNyg1xXCtSLAGlqvP7ppn/x354FRNNGbgntchxfftQtHunbXn
	fiLN8GRIuu0c2cVDlEQ+KeWSo5zaCOWzSA5FhzGNiZm9J2zCWFVUDdAvQDsh/8+VpO9NBBeusZE
	MNITZZom+xD1QgghPvMNyyZFJiHxjSX3zcWQNPz2HqPE/OwIQUXKlDt5LGy05iPGP5dwW6Kvz6R
	RgY+T7bTWUMSRUeuLfb4uurBhzyMNRmxoPkqnT8TIhU92QMUKV/pEK3ahj+6UfCvV8W0OiwNJVl
	Nm/7aaFOFqzFS9fbx82966klve+AG1/8smyk+OGqGOUJCs1yWk1LU4IsRykoVaJkqn
X-Received: by 2002:a05:6a00:c95:b0:827:3310:fb18 with SMTP id d2e1a72fcca58-829a30a63e7mr6807850b3a.51.1772955255781;
        Sat, 07 Mar 2026 23:34:15 -0800 (PST)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48de551sm6601290b3a.57.2026.03.07.23.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 23:34:15 -0800 (PST)
Date: Sun, 8 Mar 2026 18:34:11 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: mac80211: Remove deleted sta links
 in ieee80211_ml_reconf_work()
Message-ID: <jv2kdsru66rktkm6bwq3ww5wshubjtv36le5xk4ziedocc72gp@psssohaoamus>
References: <20260307-mac80211-reconf-remove-sta-link-v1-1-efe58070cd36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307-mac80211-reconf-remove-sta-link-v1-1-efe58070cd36@kernel.org>
X-Rspamd-Queue-Id: A0CF622EF24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32716-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> +	rcu_read_lock();
> +	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
> +	if (sta) {
> +		unsigned long removed_links = sdata->u.mgd.removed_links;
> +		unsigned int link_id;
> +
> +		for_each_set_bit(link_id, &removed_links,
> +				 IEEE80211_MLD_MAX_NUM_LINKS)
> +			ieee80211_sta_free_link(sta, link_id);
> +	}
> +	rcu_read_unlock();
> +

Could use scoped_guard(rcu) instead?

lachlan

