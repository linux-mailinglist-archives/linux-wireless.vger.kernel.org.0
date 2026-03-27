Return-Path: <linux-wireless+bounces-34085-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFeuHYOIxmldLgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34085-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:39:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A2345671
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9078830E3ED0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8593E716B;
	Fri, 27 Mar 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="skGnGmmn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7D396576
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618463; cv=none; b=D75TV9XbeNmmPgXhLJxZdS9XZoDaIyQp6UvS+pGT1+XJx6z7vIVyr8zDM6+HPCsg1nFcTluReBnFVURvmFg9wdtFZMuwgc7L+JazngP/GDM/L60Xt6/rp8PlQbXfRydr1mSTyoePCrVTcV6fKnaDU2qMKWMweo4YyFrbIzE3ze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618463; c=relaxed/simple;
	bh=O24slo2UhgMkRwJMj0j21oJsJ+any5+gO5NUuBNLtWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5FR+OobdjPAHzsGuKzL+VMdaS1aFAlYteH2qbu22GDEONDInq4bVl6PSMrDwnOvSCIjG7jzOBK8nfLdE4DzsqHa/Cox3Sd3hvvlvt/Espzt+n8PB83s3Zj+n7mcVqv7tAtNiaFYWxgsO7/0lwWQZ/hjQBYO8KcLS0VnOf3DnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=skGnGmmn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so1845936f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774618456; x=1775223256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWGPpauP59fuqRw+F6MCtZLDAq+cjpx3qqqsOQm0kaw=;
        b=skGnGmmniPX8Ven05ewVFC1peZLn+T4v3nzEcQ01xzRW24xTiqjGNz2OtFgs5YZ3KI
         07JfJsUZ31wFVMKD2cVX6A2gDcf+HfsNm+eor0aIw2EJkK9Lw2aj7TH3Fbz/BRsuZUW5
         4IJbQf3cvST7ChaA1oVf1rtfgs6HM3Co6rLDNXpD3FqQL/sm2iCav8pzc3cFHcvYV1N7
         BMq2tOTIzyTQgwJz+0U4Pc+Nig76/ZNhLStgqCz9V+N0fwduySdEndSQewpfAZ/xpqeH
         Kbtm/B17y417UNsBI37Qwm2YtlfA7Ct933LlwC7zrPmVvMvOlEfAR7YIfoYZ6+Qb3hXw
         EXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774618456; x=1775223256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWGPpauP59fuqRw+F6MCtZLDAq+cjpx3qqqsOQm0kaw=;
        b=QqekJKqbi2e34GxYFaqbkrWixDhCP47gy2IVxfu0f0qOoscJ/3MMghvFGrrI+oEK+g
         qAIVo0hNAGYzzlCk8htjtFmk73ADpV6psECGBr5lb+FR5N3mBRFa6W765VO6HZXvFodQ
         CiApyoFoOsaWKIdVZ8DcXwgmwVU30W/vzGQ1RXvDOVRVPWH4YoJBwMq+/2VdDmSgvUNz
         96TtHL05kZvMBAQrlT6geNu80SQXC4noTW0bMODEQTcM6rSela00gJKuBkBARZMYS8UU
         strTo6nz2sjwglmUDCfAUyo+pVe7wXTvQvcfDBaImshgTO7ZCWxqexGIBOh3fDvVOeSP
         N/vw==
X-Forwarded-Encrypted: i=1; AJvYcCXwsZYRmCtxshIAgjzCvjp5J0ZS8a4afwqkyAHpy5OX1csUKce6bk2AhiWdD8xEuLfiyWFZrpN8fxwj3HChkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiIzylYs5jVl8EW1h5Ad99HHpRVlFttWfUgd/pfDNj4xK7O+h
	u37CVh8qMGM00RmvRSAOFNFNuEmSFC5yvB03BwBi1q25FGKCUo7sTXwVkWqle05jJSdHvc//WBU
	KxLFD
X-Gm-Gg: ATEYQzyXNN1DPz8wUaevaBkdgq27OatQzv3WHnsJEmDWzo/Cj2MGQEHHxbfQM3+bXTI
	Uu5qTqePOFFTwqPtxpmJzPMu5FeB+fNwIbPThw0U4pJbAswMm0BYsRJbEC8fbdfFLLDmaSfgEEo
	4MZBEzpn1a7nmQyN01rOLWXXuPQ0Tow4GK12HOlX9VFv8zcyJp+iu2tJOXDDt7Tx3AYPHmItzKx
	7dbzvV0wdo1WnIZTuErpQ5SvHwLkpBqefMR8B2KdIztI+tzkJrLOvAEUpSzLZxr+wTnwh5We+oW
	qc0c/CMScQpfuQiu1UMma1g3rB0wIW6vJ4SB0FetTdwr7i5rMtwgp4s0SaoUdSxft8hoK1xD5/q
	gfvn0gxtd+/IvXVgjlYautfJN1Ex+S71GJc6WaD0jJiLHitARrlTwimyTa5uy5TVtlhZyARbbwq
	P/GTrWa/RHHyseKa/1xkgRUX56Ph6bLAoXewOWpjbJznW8aUscYuWlT+NonF1esP6HLn833GZR
X-Received: by 2002:a05:6000:18a5:b0:43b:9232:1a94 with SMTP id ffacd0b85a97d-43b9ea4a4c3mr4287673f8f.27.1774618456230;
        Fri, 27 Mar 2026 06:34:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:71:7cc0:9f51:a89f:3777:bbea? ([2a01:e0a:71:7cc0:9f51:a89f:3777:bbea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9194311asm16453534f8f.10.2026.03.27.06.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 06:34:15 -0700 (PDT)
Message-ID: <91b36670-30c2-4d67-a57b-c1b8295b5990@freebox.fr>
Date: Fri, 27 Mar 2026 14:34:15 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/19] wifi: cfg80211: move AP HT/VHT/... operation to
 beacon info
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
 <20260327103659.1cdda25b617f.I0d21120b41eed661eefc61d5417dadaae7145845@changeid>
Content-Language: en-US
From: Pablo MG <pmartin-gomez@freebox.fr>
In-Reply-To: <20260327103659.1cdda25b617f.I0d21120b41eed661eefc61d5417dadaae7145845@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-34085-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C33A2345671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Le 27/03/2026 à 10:31, Johannes Berg a écrit :
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The HT/VHT/HE/EHT/UHR operation can change, and might thus be
> updated on each beacon update. Move them to the beacon struct
> and parse them out of the beacon also on updates, not just on
> starting the AP.
> 
> This also fixes checks in two ways:
>   - Regulatory checks in nl80211_validate_ap_phy_operation() are
>     now done also on updates, disallowing enabling HE/EHT/UHR on
>     channels that don't allow that after start. This checks only
>     operation now, but clients can't use it without operation.
>   - NL80211_ATTR_UHR_OPERATION is now required whenever UHR is
>     present in the beacon, and rejected otherwise.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   include/net/cfg80211.h |  17 +++---
>   net/mac80211/cfg.c     |  10 ++--
>   net/wireless/nl80211.c | 117 ++++++++++++++++++++++++++---------------
>   3 files changed, 89 insertions(+), 55 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 8bebf45af95d..f3e46f6d7410 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1396,6 +1396,11 @@ struct cfg80211_rnr_elems {
>    * @he_bss_color: BSS Color settings
>    * @he_bss_color_valid: indicates whether bss color
>    *	attribute is present in beacon data or not.
> + * @ht_required: stations must support HT
> + * @vht_required: stations must support VHT
> + * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
> + * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
> + * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
>    */
>   struct cfg80211_beacon_data {
>   	unsigned int link_id;
> @@ -1420,6 +1425,11 @@ struct cfg80211_beacon_data {
>   	size_t civicloc_len;
>   	struct cfg80211_he_bss_color he_bss_color;
>   	bool he_bss_color_valid;
> +
> +	bool ht_required, vht_required;
> +	const struct ieee80211_he_operation *he_oper;
> +	const struct ieee80211_eht_operation *eht_oper;
> +	const struct ieee80211_uhr_operation *uhr_oper;
>   };
>   
>   struct mac_address {
> @@ -1524,14 +1534,11 @@ struct cfg80211_s1g_short_beacon {
>    * @vht_cap: VHT capabilities (or %NULL if VHT isn't enabled)
>    * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
>    * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
> - * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
> - * @uhr_oper: UHR operation (or %NULL if UHR isn't enabled)
>    * @ht_required: stations must support HT
>    * @vht_required: stations must support VHT
You forgot to remove those from the doc
>    * @twt_responder: Enable Target Wait Time
>    * @flags: flags, as defined in &enum nl80211_ap_settings_flags
>    * @he_obss_pd: OBSS Packet Detection settings
> - * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
>    * @fils_discovery: FILS discovery transmission parameters
>    * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
>    * @mbssid_config: AP settings for multiple bssid
> @@ -1560,11 +1567,7 @@ struct cfg80211_ap_settings {
>   	const struct ieee80211_ht_cap *ht_cap;
>   	const struct ieee80211_vht_cap *vht_cap;
>   	const struct ieee80211_he_cap_elem *he_cap;
> -	const struct ieee80211_he_operation *he_oper;
>   	const struct ieee80211_eht_cap_elem *eht_cap;
> -	const struct ieee80211_eht_operation *eht_oper;
> -	const struct ieee80211_uhr_operation *uhr_oper;
> -	bool ht_required, vht_required;
>   	bool twt_responder;
>   	u32 flags;
>   	struct ieee80211_he_obss_pd he_obss_pd;
[...]

Pablo MG

