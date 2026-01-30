Return-Path: <linux-wireless+bounces-31371-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CEyB3XFfGm+OgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31371-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:51:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D0BBC09
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11CFC30097DB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC60322C6D;
	Fri, 30 Jan 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="NO/wOCtE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AC31BC95
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784690; cv=none; b=T92yH5L028eoBamKpsvCdtW37xeV4yDItjPZOJVF06Dr0UjqOI/7mLjb2oM+zqeGWT2uvi0a40j/1rPsaDDyo5h3weyMxKTsHCYQFYRYcGSSq2Uyr9aZsKkoNoirzPyzkU46wSVQbQeKxGHJFMHbIv7hDsrbz59SKsvck4WZelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784690; c=relaxed/simple;
	bh=2U1sxipaEn5dm7JFezouLaaVCzWB2OCOwD/7Brp25rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXkPJrKbpgtOj8Ch2t9BtWKECX2mVjLDwH8iW8b4OnvRjxh92ZvJuchogsENPQHrG7YuDBzLoDTe6bWIlzDHOnHV2a9mxtxqIY4kD5f+8gpEtRFpxwFFZw76Dr4gLpfRLs2mq5G8Ib1VvVlxW5bNqGDmJSDFneA8N8xIP3vGVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=NO/wOCtE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso18736185e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 06:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769784687; x=1770389487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRt0GeybgNu8ZSx8GmOx9phoRbW/Z90F3hfrFzShS8E=;
        b=NO/wOCtEbRs0me3Vcc+msaeUaJKtqbAcjL/gMWHCifSatPDarq5LrcdgzSTBcbkaNO
         wpIZhgY6SrUsiVEQ2uwN1z/fGU8Sk71/jMP0KcW8FwuIp/ZcsB5qtp8+EGEcLuU53CiA
         DTxBNx1VP1+mNYJCCgahW1W1zNDFU0u1kdlB9MtcmASOFzUL+o8ur5xSzB0GCM8Yd1lw
         cvcK7+tZBGXA+voit3g7wtCqEg8tND+wEzxFg73u/7eOoHd0PLIcRVkHRS4gDuw73h13
         dvJ2p+LzcmMwSWmM1C28gDRfwjj72+cCJMbwT97NrXc+Xy1Y0ZnUTczrrprTwc7FqTCc
         cmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769784687; x=1770389487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRt0GeybgNu8ZSx8GmOx9phoRbW/Z90F3hfrFzShS8E=;
        b=YzVIN54PhR1qkg+rTCKF+/6AwH1AsHg1rJ/v/ok5daZMg9KlBAAHB33nnBno3D1tRS
         OzWKTXMl0KvXpTFgsBFM+XlYslG4CGau3kwHxZHayCXgpD8QZf02HG+L2/CKhp+GnJRX
         gp6b0mk9wI9+yzJOQK/hm/A+4mM9eZaG53w1xLw5pYAwMhecb7izMFZUelcT18vTL7Vo
         hhYlIWHDwGTEXWs96T66O2F+VGuADEoWxIVnJGfCrNpnfAQCGuEIRONYXNAoH/Vgr6YD
         RS1q/c2T2EFD8EHbYe3aBBNSR38CjwBKsXSrOKmSpsgcFR3OnQX4q7JtGcWqYMGx1KO9
         aFIA==
X-Forwarded-Encrypted: i=1; AJvYcCUvBOzKye6tXRombLelJebq61t5oD++rmbcGM+oh4AKLxgFMyecqT7znnLn30QZUnKVoqWtzJ4NtNBqnCzGnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DTLylDI0frqfLFaG28q32MWL6UJQHs4UKBEy7Ysb4i7GPw4d
	R3s4Lm7y8BVdHvU1TtGipzPIPadkj+yE8IwapmSRs3ben91CJwfK63xJmUjyafVLAn8=
X-Gm-Gg: AZuq6aIp0EsMbGEsXzO+qMk5DFYq0oHUh/Egub6fdwuelPTp4jSRGWoLUfNwy4DS2b6
	UZCITG81OJ44hH0bLeziO1zvTVJzUL8AWk9Tf7H4nBPAHjJzIAfbbGoymSmoXEf1Iab2r6ByLuK
	5Kdok6Vt/Wa0ex/snydHvqhAylxFZGasnhGNcBU6yBdFQOt4nYgGt5C4DPH6LP+FjsrVel4uwA7
	rkS41v3hqPSHsOlqK4jK9W418i5UUupNQMNtBVcvxqlVD+iWMvnRGE/5s6hyqMvgNxKfpCyxSoc
	Fm96zrhLV3Z+G66VNiJXlPfD3S8aY+2iOUMo0zkAFN7wYg6HsnaJDgIbn+R5wgVetTM4YZJhWA8
	gvMORnIcB9w3J+6aaI3YySzFQKj2en68QCwKQgvQrx/Peh88H4EZZq6mjZiyBgMJcxtdzlC5WkI
	dnJ74ZfaKO2OYUD9J82xkXEBxdLh7mciQcL6ab3BZLLpellJEzt0aa
X-Received: by 2002:a05:600c:4506:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-482db448862mr43189065e9.1.1769784686682;
        Fri, 30 Jan 2026 06:51:26 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c4f3edsm260174715e9.15.2026.01.30.06.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 06:51:26 -0800 (PST)
Message-ID: <45714517-8388-4c1c-9004-0bd0826706db@freebox.fr>
Date: Fri, 30 Jan 2026 15:51:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v7 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260130142019.bd561c0eae91.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
 <20260130142019.69d59a4538d6.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260130142019.69d59a4538d6.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31371-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 719D0BBC09
X-Rspamd-Action: no action

On 30/01/2026 14:20, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Add initial support for making UHR connections (or suppressing
> that), adding UHR capable stations on the AP side, encoding
> and decoding UHR MCSes (except rate calculation for the new
> MCSes 17, 19, 20 and 23) as well as regulatory support.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
> @@ -1698,11 +1700,64 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
>   	tmp *= rate->nss;
>   	do_div(tmp, 8);
>   
> +	/* and handle interference mitigation - 0.9x */
> +	if (rate->flags & RATE_INFO_FLAGS_UHR_IM) {
> +		if (WARN(rate->nss != 1 || rate->mcs != 15,
I forgot this remark... We have to warn if `rate->mcs == 15` not if its 
different (it's done correctly for function `ieee80211_rx_list`)
> +			 "invalid NSS or MCS for UHR IM\n"))
> +			return 0;
> +		tmp *= 9000;
> +		do_div(tmp, 10000);
> +	}
> +
>   	result = tmp;
>   
>   	return result / 10000;
>   }
>   

Pablo


