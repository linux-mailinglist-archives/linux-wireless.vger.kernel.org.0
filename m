Return-Path: <linux-wireless+bounces-31402-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3wvoOqH4fGmGPgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31402-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 19:29:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A050BDB23
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 19:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E66F7300DF46
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5010E211A09;
	Fri, 30 Jan 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="CUVWKenm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91837F113
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769797790; cv=none; b=nbviTERLZVwBa9YQqxBozxfw583LCA/mW3vxHODO62peyr6dSVk4Fa20wjS0n4nJkg92F+sqapM/hbWEvON8jLgToFA1YKZvApttp1CfkxmKNK4UekYY1SC+5JV1wREhYdI9SKRJ2+6sXOsP8kGyM8bCHf/LX7518Bm/ty9bRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769797790; c=relaxed/simple;
	bh=YLAXuhhVLj1jqxPsiXalFFXrN4TYXCUUrye/uvJq+LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlOBaWGNlJtreIKzIF7gU0xwYYJkqyv0mUT1uh/bIt3i4aFsGUTLWLV4Yc1S79mA06TK8bWq64JaECUcWeVR8yW8rPKHXDF0HhrKysCY8jzZVoVU2dLQ2HMfLhfcpOjkBGNK32jiYK+IzIR6Isr8NJoCuB8VS1I9kTS9JfOL2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=CUVWKenm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so25302615e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 10:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769797784; x=1770402584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DamiLGsZakw2ZDAXFo8seYTotYZ3hYwfpzIwXRYEiw=;
        b=CUVWKenm7qHqQ5R0y+CkMJM5BeP8A1biE0DN6XO/atFzJj6UchQ1QJJrFeAX9Vb+EQ
         sMa7OJpt4Ki+5fR9cRo8Z3gJl697tyGS11dNtXGGg4f/gRrxvwTYvQ+KpkSbBXuIBli4
         5uMn6PEIlPjr/1x0nCIrIfxQz+vhmhOyewgzeV2+vHIRZna8uMdrM/KWwaP0xgd90QjV
         jfd3GY1DEDHDU+lX9Ez5WT3Vk5FpQtU1Po5zqgMVtuhiDbxQfzUpDAQpbV9Wa01zN7JF
         AokPInMWhVxyyIJHBqc4moKIAfSTJs1I1+ekw4RtAfOqPTKkuULOA6hEDkCO9V9hDDO0
         6Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769797784; x=1770402584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DamiLGsZakw2ZDAXFo8seYTotYZ3hYwfpzIwXRYEiw=;
        b=Y9ykWMSe2OWHe3bRTrb19Me5u5K7G7uXVPmvC95eoYaRo+JK/fG7X0Lou/pqRO1bJ2
         4G9v1QejCKq05aK8/gej0zvbXdjNCkJo76z5A7Mwt/HQNE0HOHXCdK8UtRMwo9g8zy0s
         +780Dcm2sWWS6WWDvGvFK+Zxbs2Oc5hb2tqtI2f8myooH/vPjif0UE1mXtenkKty3SSv
         x6gBON/nknlS7PxjRxmSQ4frMGelckqzdzAIYg3LtlUcbjI6pAEVAWPwErJldxyB/ETD
         6j37DiKcb1/rbjPQftmQes/KVtio52DjFa+R0kbFvOktR69iKYvLKSxol3GMwSOx8enO
         cvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHZKjnz06dRaOpAEtMAAJgyxPwRaRE/yK9ai1LbsnymG7NwE6tOysyOQsYlip/RWId4/iF3XLSbZMilRBW6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuavy2eSxIjkd8HvCqU6jdenkW7qje9d9j4Gsc39aNvgdgj7bz
	X/TpgqLju/IFo4M2BgtywZ8nG0UB8LcuhqDVw8yexIyqTJjqbxRlKPmqCCJLJcqGo6U=
X-Gm-Gg: AZuq6aLlcyManqyJTt1JKmba7OQ/JNrhB+s3IRl5+1z6M6RyOBOKxG7QsRtyQC1Q3PC
	IhzvPG5tdP3CjxT8lbC+KbXNMspRVSX+koQ91VMnad2IpVnYRU0GW9WU9JNEjJ2H6ompeODN3Qg
	JgW0cP55P2httymF+hin1JsEnFSaU7tWd2dcoVklE3TLiZeYKj3mNbniELUeoRXSgBrg8+ONRTz
	nJGdOgigDe7pJBxsm1+t+6sPrKeuYA7RFluH/jW+oj/4qGb3i9+hHYBvpNosfhqAxOvx4xkYG5L
	IyAggnqFdBsMJlehJKCnl4+ymC88pFzw1K3jbjCyGlNPwmhCmSRWwRw0wtvvtDrSoxYKskDU5Zn
	ubdI6DJQPeYAIwmM6Nd46E9qDyVJ9fMiPDLjVfpKdkXL389p9I6fPhpZZjRb+ehga5oZI0FVx8u
	SPvxPbR68SFxXad8SCv3F3zZQ1Hi3r0w0EjIVJB6cs9Q==
X-Received: by 2002:a05:600c:810c:b0:47e:e414:b915 with SMTP id 5b1f17b1804b1-482db44d338mr46269655e9.2.1769797783305;
        Fri, 30 Jan 2026 10:29:43 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd79c7sm211866695e9.2.2026.01.30.10.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 10:29:42 -0800 (PST)
Message-ID: <009232c6-2a67-4df4-9309-71c9d5788c73@freebox.fr>
Date: Fri, 30 Jan 2026 19:29:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 3/3] wifi: mac80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
 <20260130164259.7185980484eb.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260130164259.7185980484eb.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31402-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3A050BDB23
X-Rspamd-Action: no action

On 30/01/2026 16:21, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Add support for making UHR connections and accepting AP
> stations with UHR support.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v7:
>   - adjust and normalize naming
> v6:
>   - fix ieee80211_uhr_phy_cap() usage
> v5:
>   - parse UHR capa as from AP
> v4:
>   - fix NPCA validation
> v3:
>   - use uhr_oper instead of removed uhr_capa
>   - fix indentation (Jeff Johnson)
> ---
>   include/net/mac80211.h     |  35 ++++++++++-
>   net/mac80211/Makefile      |   2 +-
>   net/mac80211/cfg.c         |  16 +++++-
>   net/mac80211/ieee80211_i.h |  19 +++++-
>   net/mac80211/main.c        |  15 ++++-
>   net/mac80211/mlme.c        | 115 ++++++++++++++++++++++++++++++++++---
>   net/mac80211/parse.c       |  22 ++++++-
>   net/mac80211/rx.c          |  26 +++++++++
>   net/mac80211/sta_info.c    |  13 ++++-
>   net/mac80211/sta_info.h    |  80 +++++++++++++++++++-------
>   net/mac80211/uhr.c         |  30 ++++++++++
>   net/mac80211/util.c        |  36 +++++++++++-
>   12 files changed, 370 insertions(+), 39 deletions(-)
>   create mode 100644 net/mac80211/uhr.c
>
[...]
> diff --git a/net/mac80211/uhr.c b/net/mac80211/uhr.c
> new file mode 100644
> index 000000000000..2d8f5e5480ef
> --- /dev/null
> +++ b/net/mac80211/uhr.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UHR handling
> + *
> + * Copyright(c) 2025-2026 Intel Corporation
> + */
> +
> +#include "ieee80211_i.h"
> +
> +void
> +ieee80211_uhr_cap_ie_to_sta_uhr_cap(struct ieee80211_sub_if_data *sdata,
> +				    struct ieee80211_supported_band *sband,
> +				    const struct ieee80211_uhr_cap *uhr_cap,
> +				    u8 uhr_cap_len,
> +				    struct link_sta_info *link_sta)
> +{
> +	struct ieee80211_sta_uhr_cap *sta_uhr_cap = &link_sta->pub->uhr_cap;
> +	bool from_ap;
> +
> +	memset(sta_uhr_cap, 0, sizeof(*sta_uhr_cap));
> +
> +	if (!ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif))
> +		return;
> +
> +	sta_uhr_cap->has_uhr = true;
> +
> +	sta_uhr_cap->mac = uhr_cap->mac;
> +	from_ap = sdata->vif.type == NL80211_IFTYPE_STATION;
My knowledge of mac80211 is quite limited so I might be very well wrong 
but it feels that either this is wrong and it should be `sdata->vif.type 
== NL80211_IFTYPE_AP` or this is correct but it won't work with mesh 
point for example and that  `sdata->vif.type != NL80211_IFTYPE_AP` would 
be better.
> +	sta_uhr_cap->phy = *ieee80211_uhr_phy_cap(uhr_cap, from_ap);
> +}

Pablo MG


