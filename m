Return-Path: <linux-wireless+bounces-31318-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKfMG/JHe2kdDQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31318-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:43:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA73AFC0F
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A09AA3021E8A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D6387358;
	Thu, 29 Jan 2026 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="nmvpaekE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85C29C321
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686984; cv=none; b=VcPCypwAxTMEHwfoW6kCLIslSA+kkcVR3QU5QWdTx6cm7trfR28gsj1vIIcQJaWhYh/FF1GD5pJb2d4oy6jyZT/Qa7gz9cbJYQ0WSnKb7kgoK7Qjrdbs6XnFnS8VNx+91EuqoY26jxKZNE0s+2kFCZ04kWygfcvhpXjQuQNV2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686984; c=relaxed/simple;
	bh=eJDG3GOqE5bTpBnRtUnVfSrHuBE+d/thY08OLxUZes0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Epw4OnFPNfqBF3ztb/MG29/G8KA38BJH42DQEbKAZgksnt/pTxKdoBO/JEYh1XocoWDs+mEtFid7MHVNmV7phnnHH+pmCW9Bn6MgWLqKOsOFe8U8/RAdBGYw+sTnX0mfmIBv3cIk2YIwRWQGU5Z1R2SZpFG/7mvuhwGbP+v++aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=nmvpaekE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee0291921so7794635e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 03:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769686979; x=1770291779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpWFd7tpSMogy00aGpFXcaSPdYLyrDxSaXl5DqlY+AQ=;
        b=nmvpaekEtghqGkj37QApVJv/rPrMHm30L70I7bHqPJYzpnTSIUX1NBIM4Nv790a1af
         CRzNSakyoAlgPWj9YoFLJnfYdqqhnyXPqqKY3rCks0kLDz1OvMF4+LBbq9uIMp84oSE1
         VlWlp+QMnkZ+ACyGRLOgNvztrdfCX4IA90lnlS8Hfhrv7s7feQyEvrhehOiOv4UeFDs0
         3SpFHH+UDyUuwFRsKwvgVkx2nzBZDgtQaKxGZ7tLeqHad0OWQks1uA7JaMuPk4UOVE/n
         e/q1lmG7W1Fuo4KKK7TwuNeA/95AqQ/OJtVRTBC2v+new31YUOIvFudVtRaVZ8fK+cXz
         yM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769686979; x=1770291779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpWFd7tpSMogy00aGpFXcaSPdYLyrDxSaXl5DqlY+AQ=;
        b=kvr3ZeU7dckePKQiKELvATKEZHCu0+UMIO8H1Zy721no+qJaHDNPxQbXQRQ/zc+4p9
         TqsZfesdGvp+BVuL02LTp4D9hJvXP3arwVxEK9zzvjP6HxerjOTvZcqi2OvyaVbddzAD
         qOkPoocWx5Q7zMqERltHSaUOgZEioOYiGMs0XIsTXECKERezq80puT//+J/Coy/O/sy6
         7Z66pklrVAyDLrBxAhjxFIul5ab0dGfe/aqwmNQL5JPiD2gwU++Dn3Xi7LAuQKBGddz3
         SE7AO7misGwFMmO/IN6dzmLGWSgD8bcbQ04/Y6fpY6Hc7hZ4ScwRx2vOOn1CLvyRpAog
         yfZA==
X-Forwarded-Encrypted: i=1; AJvYcCUUYtjbKtCSG33C5yeNoKr8ED/1TIz6entxzGsi5ThkSA89Ou8fBtyo7RLn5g/ugOwETxOuoWuQ3D+SI4tCAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjmZGfMy2jH73hkcSBFgvBtR+8O5+tcb81c02aUVrHoV7+MR1W
	KoO4zk1UNKEIAtm6Fcbx8XZoJhYG5xem7rBypovgRquensxLxAtWaPCVjoeMhvcAnk9CoJYw2Q7
	x+ahh
X-Gm-Gg: AZuq6aJuO0YiFCn2CLMjZArNeaIyElZODjscRIqo05TjCu5lJ8uDh2UjTyapGKI4G3I
	DKkmnC4C0sAZw7G6DNQBXcARO+x15PHgkX0UxPgd2BfRQpbpW3jj5mUAbr//Du5Eq8/B5xYZbPh
	A49h09USLxIzWsJNv/3zHLL1iiQhOvC5wGG2oyqxUUn49zgu7meXdwoc/dzjZInzTDshOIerlaM
	N8W2YHt5B8TLI8xARgBIhjljmRr0n2NB+mHgD/4H/DfVRnp6b0b8hUfFFyvsGlW0c9whwUiWhEM
	ZOCAQbqRKZ9VrkVVo1awb92ryrsXirr8Pu0fef4LoRzwnmtrlIs5gQ6UR9eFqx0HDH8FQ3n2AYE
	PB0YgSqp/u3CPgqzBJU/60Js+M+qIuvscObtno78rq0YfIv6uGRBm+VMxfKA/XlKgSMD2LqFR/Y
	xBpezi4kj2OJMUNyKAfhIBseWx4LxiS8lO4TAsmy5Zxw1T2E9Ea71B
X-Received: by 2002:a05:600c:4748:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-48069c4096amr107996515e9.5.1769686979222;
        Thu, 29 Jan 2026 03:42:59 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d582d5sm2022845e9.7.2026.01.29.03.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 03:42:58 -0800 (PST)
Message-ID: <0037ce8a-64ca-4986-a937-e35ef92289ab@freebox.fr>
Date: Thu, 29 Jan 2026 12:42:58 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v5 1/3] wifi: ieee80211: add some initial
 UHR definitions
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260129092039.53d7f326bc8f.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260129092039.53d7f326bc8f.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31318-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MSBL_EBL_FAIL(0.00)[johannes.berg@intel.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,freebox.fr:mid,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1DA73AFC0F
X-Rspamd-Action: no action

On 29/01/2026 09:20, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> This is based on Draft P802.11bn_D1.2, but that's still very
> incomplete, so don't handle a number of things and make some
> local decisions such as using 40 bits for MAC capabilities
> and 8 bits for PHY capabilities.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
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
> +
> +static inline bool ieee80211_uhr_capa_size_ok(const u8 *data, u8 len, bool ap)
> +{
> +	const struct ieee80211_uhr_capa *cap = (const void *)data;
> +	size_t needed = sizeof(*cap) + sizeof(struct ieee80211_uhr_capa_phy);
> +
> +	if (len < needed)
> +		return false;
> +
> +	/*
> +	 * A non-AP STA does not include the DBE Capability Parameters field
> +	 * in the UHR MAC Capabilities Information field.
> +	 */
> +	if (ap && cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
> +		u8 dbe;
> +
> +		needed += 1;
> +		if (len < needed)
> +			return false;
> +
> +		dbe = cap->variable[0];
> +
> +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
> +			needed += 3;
> +
> +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
> +			needed += 3;
> +	}
> +
> +	return len >= needed;
> +}
> +
> +static inline const struct ieee80211_uhr_capa_phy *
> +ieee80211_uhr_phy_cap(const struct ieee80211_uhr_capa *cap)
> +{
> +	u8 offs = 0;
> +
> +	if (cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
Shouldn't we check for 'ap' here too?
> +		u8 dbe = cap->variable[0];
> +
> +		offs += 1;
> +
> +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
> +			offs += 3;
> +
> +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
> +			offs += 3;
> +	}
> +
> +	return (const void *)&cap->variable[offs];
> +}
> +

[...]

Pablo


