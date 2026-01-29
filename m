Return-Path: <linux-wireless+bounces-31331-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMkhLfiEe2mvFAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31331-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:04:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A7B1C61
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3556300E188
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998062DEA90;
	Thu, 29 Jan 2026 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="DNcLJOeF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE62DC355
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702608; cv=none; b=ZTdNTtQdYUTnd2lQMZOvGRLjkbRex84/+KRSFrd5P8k0ANvfRdvd5wRW2KNnTwdg4cVNQbLe5mZGMOrGhwPFTS/teoVIswyGVGozHkYTH0rXramsshlUxKE7ah84Lvtp0y16jl9SSVkOXRE+2Zdpvvsf5sy5+aOVPK6ti9l6SL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702608; c=relaxed/simple;
	bh=Kpz9BrCGSdGldAyp7EK45NtR1kdkmvagd2g15cAdkow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATNc6XPzjAomN7a8FYkUFAc+dPioF9KUWPuiUXISzpfcTxUUnzu1x8q/phwNm7ltrsGXlpsC6u9+fn2VDodMhbTP5q4+RqKc5VdEpTcX5q4jO1bn4Vcenm3MVZ11uuJJ/VZ4GKoPZjLscT6oWsHIUVEcf/QyQmC/hmRffUcapz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=DNcLJOeF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432da746749so785864f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769702604; x=1770307404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAboxghVcPqCNPJFbNK+/J58zoS/eAE56cCuzYvZZmE=;
        b=DNcLJOeFLArSjkLzyYaKDFTBikLeUNk3KzQuTOJcqLXU13bnhDsHukyVLfi6BeJgzG
         bTQYVlm6shA8aW9BMfhhPwmu0gtExQd+IjG0Kp4Zj7HHpGu37p4YGQHToBx+89UbeXDd
         ancjmKG0Ui50y/2cfCQblmoHWKYBd/QWgmTSAuXr5gqwcZsIes4vjGhvd4EqTmPrnb5s
         xiYYhTIWouLKAns7RcxLswdt7yFZkugM7gFJtrJI2hluZOE3E9PvybN4RUYfSWrX4Dsd
         CHAgTIuzT7YyawUmFkb+NHYiz9USF1QZ8Dr/TdpzKlVQxQYNwD5LgmOGRTQsF0rLvEJD
         5ZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769702604; x=1770307404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAboxghVcPqCNPJFbNK+/J58zoS/eAE56cCuzYvZZmE=;
        b=FMH+151YjQhuEleYxRqf8qhu9AKir3MHy78uzNrgDy93TQ4i/pucKfG4yCfAFpxd4o
         qVHWi3tekU6zcgA8Z41pGRZ6khEbnyKEOjsTbvRQwduefJp+jw0SJzIAO9e9LKbdIk2/
         7bzB35dleSb1O1yyIgzGZYUNrZ1zZo+W+TjHzgLAXwi/bL+0XK4IkoerE0ITDf/pPK5/
         f4WFy3JHU0AWWWnoxZcr978i8a2s1IsCFQDdUitqPDJNNPLAyRZuEBZqMT9j7dkQTdzR
         Xr9DGgBWT6EAiLfuldf+RWKRJsXWnxwnQ3fR7aXlNfOKEORw56VO2gZ/xabnn6sSm1pF
         vI/g==
X-Forwarded-Encrypted: i=1; AJvYcCVH6EH4/TN5BiG7HeXjpCiOyO2w6Go4f1mgdu1AjgO7uQIznO4O/B3lTfsAmPz9QIYDH5MnIE2T7d1HV1VD4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq61RL8bprMaVho1L2lpgagFfkrpnj3G42ghxzFfp1dlmmGt6s
	hE24ymt9zLWO4AETIZDxE178S+9kNt1EsxY+WUECzoe0E8ZHv5MyZOlPXRMGJdYEScwUBhQbl+g
	sAaFY
X-Gm-Gg: AZuq6aJbOBk7fkAGcDiAWJ/6cDHfhFQN/ECTYFHKDUTUBIWtUYWkXtnKx9xi8D5NlZ+
	QVA1kVQKfsbL7nNaH5gbGzrECY2yDh92I1/EoZbGW1vhVxHBkiXLb0dbAx+HGtwGXZGvfzs0mmu
	0/4BlRxmoGkzOCrEf0NVcfIW75nU5Q5LN1q6OIx5S5n+d5bI7/kxQN1u5QHRING3+1KbqCjN7Gt
	U01vV34/2cdjf2OiBUtQ2aHk57iKCQvQYZ5YsdKgKfrAh/mq9wELudFh26cTLN495iBDyOWDeuO
	HpvRxTWun33DhSjd1K5ceBHd1iAJ/LOPOywEIpItNbP0OJMp+5z1CH2v4GVsfxL2GxvgFT7kF0M
	UcZdzyi6YjK1Xh2/UN+NLhmNhx3Hdz9IhEsdg9AmiuyA6kObfIcn5/C07uK3kxnUO+jLcTwzRje
	m9G/fAmdoBHF1RFZnNB/NeiZIy4FSkhB0yf7irT6O5NA==
X-Received: by 2002:a05:6000:1a8f:b0:42f:bb4a:9989 with SMTP id ffacd0b85a97d-435f3a9ad2cmr132521f8f.28.1769702604048;
        Thu, 29 Jan 2026 08:03:24 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm16540355f8f.38.2026.01.29.08.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:03:23 -0800 (PST)
Message-ID: <2144630f-6abd-4a97-821a-51cada015867@freebox.fr>
Date: Thu, 29 Jan 2026 17:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 1/3] wifi: ieee80211: add some initial
 UHR definitions
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260129134944.a84420ec58d6.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260129134944.a84420ec58d6.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31331-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,freebox.fr:mid,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B06A7B1C61
X-Rspamd-Action: no action

On 29/01/2026 13:49, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> This is based on Draft P802.11bn_D1.2, but that's still very
> incomplete, so don't handle a number of things and make some
> local decisions such as using 40 bits for MAC capabilities
> and 8 bits for PHY capabilities.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v6:
>    - add 'ap' argument to ieee80211_uhr_phy_cap()
> v5:
>    - use correct EHT MCS len (24 bits, not 24 bytes)
>    - handle DBE AP/non-AP in ieee80211_uhr_capa_size_ok()
> v4:
>    - update to D1.2, including DBE in UHR capabilities
>    - fold in suggestions from Pablo
> ---
>   include/linux/ieee80211-uhr.h | 219 ++++++++++++++++++++++++++++++++++
>   include/linux/ieee80211.h     |  33 ++++-
>   2 files changed, 250 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/ieee80211-uhr.h
[...]
> +struct ieee80211_uhr_oper {
> +	__le16 params;
> +	u8 basic_mcs_nss_set[4];
> +	u8 variable[];
> +} __packed;
> +

I've just noticed that all the other PHYs have a type name 
`ieee80211_*PHY*_operation`, it would make sense to keep the same 
template for UHR.

[...]
> +
> +struct ieee80211_uhr_capa_mac {
> +	u8 mac_cap[5];
> +} __packed;
> +
> +struct ieee80211_uhr_capa {
> +	struct ieee80211_uhr_capa_mac mac;
> +	/* DBE, PHY capabilities */
> +	u8 variable[];
> +} __packed;
> +
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x01
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80	0x02
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160	0x04
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160	0x08
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320	0x10
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320	0x20
> +#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x40
> +#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x80
> +
> +struct ieee80211_uhr_capa_phy {
> +	u8 cap;
> +} __packed;
> +
>
> +}

Same for the capabilities. For the other PHYs, we use *PHY*_cap_[...], 
so I would stick with that.

Pablo


