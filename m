Return-Path: <linux-wireless+bounces-31370-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDmyFxvBfGmTOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31370-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:32:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E66BB9C4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5734B300291B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB351EB9E3;
	Fri, 30 Jan 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="OASQNzUn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976411D86DC
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783572; cv=none; b=Cn5oSL+ahFYYhbvvZZbuH7dxlu9A2DbmY1YTyH7za+RrVtucu/bD3kZsVhs3f7uPhzbGsw3gFRxGWPGNDZwXIycY3gNRRi26a2uuAUgW1M3evE+twZSMGV8z/cwGNwLo8lgqmsI2s0+Oye9Eo/eJ6aiUaxHP77IHVB9BBXsncN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783572; c=relaxed/simple;
	bh=+vyiH+eOTTCpLkSCBITb2Fyv1A+K0T+MWVcQOYgBf+Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oOFBMYmnSm5gVkUvZDZ2hJ0xw6hbfz3cLBzSx0tVOXf85B13KAhZbcyqqKNe0qmCPEVzUud4CrcboTkIeX34TdLcdHlcIGxKF/SJeNASJHUuOubXrzfJyPKyAKTUVe+7dFz1jClVyNe9OViyJK8vmMx5qCsRSAu5+lgIXK87klQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=OASQNzUn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso16871885e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 06:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769783568; x=1770388368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMdNIV8At4FZNWJnSGpgEGdXHYLJWKxSQaS0YvjJ+RI=;
        b=OASQNzUnIpf2nsCOKHxRks+E1LamuE2wYugLRGoNxKK0AnRvH4DmoKwtJ0yVabuvCR
         DEb0MmYTF84XZkxZHbRb5CQM8lLG0gJkmHn7IrR5G1lpWzAo/Cagtm3YhNUE2WDSvyoX
         kCU6zD6ChxWkF7trGQ5jk6khfNPfpQFdF6D5OkHDNTsLxCx2QOEnodQ0RADr80cLeSik
         r4ufyZWbNA80BlN8zhA7NCFmJEKUiLlXBZY31iRbie4vw4Ft/0tvClgaS1Czwei/R+vS
         7XVu/5s71aM36T77jqd3TxdJLQJBK55MxvpFYCNiADIgD7ZOFEa8YMlm23PNvy621pYL
         h8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769783568; x=1770388368;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMdNIV8At4FZNWJnSGpgEGdXHYLJWKxSQaS0YvjJ+RI=;
        b=tXOmvneDhBd6a0XMQVJIdrnDdbyjWWUenSkJ7HOJ0Zuv+zWB5qElS14c5xQ2E+OY0Y
         +6kXc+JMz3i2Xma9Nuts4Zzxfi/Z4wcYWiPeslA2HCZ904NSXoONE/zyqPWu4uAUZf9R
         ljktzpONBIjdZVtZUx+IrPl+qQIbZ22qz+goynuZW/6Vv7D6oEus0u18bk1PFx0X7E13
         L1h79k4MYWA0N09zPWTOEx0UElRnnk1WVlzen3Y9cP9eEvr219PNydeOPq6aQNjbzQCh
         ili3iR3Zo+eWaMbSf71LebW4pKb0acC1T69mRMP5eNKdUr7PCxeD3svSP3uUJmMwe4W7
         Qy3w==
X-Forwarded-Encrypted: i=1; AJvYcCX9FNm7fNIngH8fb6tdp1T9NbnEsuZXzyOfNS16/8mhrj6poSST7eJ/TudkfGvKFKyzU3gjp4X7xpn8nwmzDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvtjTzonpyR68NdRrEgh8Fcc4xKW8d2pCEF9K4roSlerO4Slve
	kvODirPqbgCluvFVZEJmmJemXzbAo4lxEm51yQ3UnNTMN/GWaZ7yNGSIJR/qJwqOFvjIjSeWV+7
	LDprl
X-Gm-Gg: AZuq6aK2tGStB2RpqTaPRaKytyy9PW7aaipGH/36+zx9VPkgOFwKGUj1CO5ifHalyjr
	rvCPfPIyXUlxK4ZKaG0uBKkTKawFJtm8S+zITYToN51GlvxRj4eUBq9DRMJs+ivfqt57P9XOtur
	JTccECVnOUjWpRqyqopuN4Fbt50rp7lW3xQ7cOkPvSdVVSK+7ls7f07RcSC7WfvccrsJDy2m3MT
	EmU15gCl9Z0nqB/f8abJMKJjGEaofpKkcTaw5GRVqojbTujz3zgSemhpCR3NqJ6oCn5hnkPWgBP
	7FnZuRQYPSkKjw67zNtzGhc8Hj8sjgWB7wLZGAgzqjT/mFxR/EirqYyXe+8h8wcnEHY5TuAXCZ+
	DJgixSU3RKiHWRBttOpmJsfzUBUpcLqvFAQvDRLd3whiOfP1W97/DeNBsJa0rVdddi/djSJZ8oV
	CN4SojG+jL45qaSCHSjUh9ZjVo2AYZMrhpSBqkvatJGQ==
X-Received: by 2002:a05:600c:354c:b0:480:73ef:e73b with SMTP id 5b1f17b1804b1-482db4953b3mr33783925e9.25.1769783567677;
        Fri, 30 Jan 2026 06:32:47 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e04a87a2sm16752585e9.4.2026.01.30.06.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 06:32:47 -0800 (PST)
Message-ID: <873509e5-6752-4847-b120-147899fbcd17@freebox.fr>
Date: Fri, 30 Jan 2026 15:32:46 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Subject: Re: [PATCH wireless-next v7 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260130142019.bd561c0eae91.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
 <20260130142019.69d59a4538d6.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
Content-Language: en-US
In-Reply-To: <20260130142019.69d59a4538d6.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31370-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 60E66BB9C4
X-Rspamd-Action: no action

On 30/01/2026 14:20, Johannes Berg wrote:
> From: Johannes Berg<johannes.berg@intel.com>
>
> Add initial support for making UHR connections (or suppressing
> that), adding UHR capable stations on the AP side, encoding
> and decoding UHR MCSes (except rate calculation for the new
> MCSes 17, 19, 20 and 23) as well as regulatory support.
>
> Signed-off-by: Johannes Berg<johannes.berg@intel.com>
> ---
> v7:
>   - adjust for changed naming
> v5:
>   - validate NL80211_ATTR_UHR_CAPABILITY for non-AP (only)
> v4:
>   - check for correct NSS/MCS for interference mitigation
> v3:
>   - remove UHR capa pointer from AP settings, it's not in
>     the beacon anyway
>   - fix kernel-doc (Jeff Johnson)
> ---
>   include/net/cfg80211.h       |  58 ++++++++++++++++++--
>   include/uapi/linux/nl80211.h |  30 +++++++++++
>   net/wireless/nl80211.c       | 102 +++++++++++++++++++++++++++++++++--
>   net/wireless/reg.c           |   4 +-
>   net/wireless/util.c          | 101 ++++++++++++++++++++++++++--------
>   5 files changed, 265 insertions(+), 30 deletions(-)
[...]
> @@ -1486,6 +1522,7 @@ struct cfg80211_s1g_short_beacon {
>    * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
>    * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
>    * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
> + * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
>    * @ht_required: stations must support HT
>    * @vht_required: stations must support VHT
>    * @twt_responder: Enable Target Wait Time
> @@ -1525,6 +1562,7 @@ struct cfg80211_ap_settings {
>   	const struct ieee80211_he_operation *he_oper;
>   	const struct ieee80211_eht_cap_elem *eht_cap;
>   	const struct ieee80211_eht_operation *eht_oper;
> +	const struct ieee80211_uhr_oper *uhr_oper;

You forgot to update the typename.

Pablo

