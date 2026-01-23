Return-Path: <linux-wireless+bounces-31131-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OejHT3Kc2mQygAAu9opvQ
	(envelope-from <linux-wireless+bounces-31131-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:21:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B06B7A1A7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92D953008D33
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD7208961;
	Fri, 23 Jan 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="lKcI3tPn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE814EC73
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196084; cv=none; b=RjL5wm66efuvdCbszThFTnQQP28d5JSu35WtyIN0TWosJsyK6b6/GHZv815dMjtRUZocs5JcygZU2grI6y+9PPdgrDlDuohNyjhRIKKvMZZcaYdoat+luOYzy0WXiv9loaHjgOwzFEd9j5T33xpWPjTwWyTlamsnxh+F2WT4v9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196084; c=relaxed/simple;
	bh=9tyUy/qUVIUBcO1+fXUGEXhAv+z4k9i55Et8NHcWF3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gei/yrJghxOcgcZaTR/n200LNM+zzCTExa//tQ1iaiO8oJGagroxuYyFrYtFi/I5b2QOy+QTSc1g9B3azjlB9sfTnpfKurosi472LTIxQBzbftJyr5OX99p2aj7TJjZb4+46reJUX1QS3Kk7h802f90fTJuCY4mv2HsjlPSdqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=lKcI3tPn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee07570deso19843975e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 11:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769196081; x=1769800881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFVEzYQ9QBCmXSWgFwr2qvywTgAFN6gJkTVIK9KbJ5U=;
        b=lKcI3tPn75DQkvff7hfQemZvhB1TwMRWb4By1AYjVfvu48r1pyQrzOhx0bATvT5Wpp
         DJViLVXFEV2/HvVsBbd97NZ42TLOc+HFObU04Xh7X89asCNTjpat5P4VTM9hIRkJY4pR
         +XYB+g+CTOpTZChP4XIn33V2+n2bTLAfCe9kjjLne6qRUn6BzFXCBoAQnxao4r6ZXpjX
         I8f0EF+oRgPAZNgUvVyw2/rBdhX/HU028CPy5Fg+kzx92IF01+ylkMLHkDnc58zjgupj
         18LSki6F+cZI9gb5YAY8yTYLRgbCwE75LP6wRAMy7wWOwCPNOMa/yta9f/lFOaylSGBe
         nrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196081; x=1769800881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFVEzYQ9QBCmXSWgFwr2qvywTgAFN6gJkTVIK9KbJ5U=;
        b=wfifCf5fdsBD6GOKDcnU/m+QOCZgEGGlV2A73WhZ67S/kH3l2MrUCC8FF+4hQ1XPWe
         qZTwMVfgIgjpuPQnIc63Z501Mytfb8xbbH+PY/FWZbPkYH9ueb67fDjvRURVbe4abVVN
         BKynzlqrEv/dhSFG7vqHWGR6sZKHfuCMEhwDqGrRPUEM6j6rHOd0ASVzRxhumg50Id34
         0EhuhMupe7uOtJjtaN77vi9xDVpYJveXI5MEFWqnhNtv8gEbHfWM+tNloKX9ObV/ZUbW
         m3Gbi4/ZPpUy96atBdey4pPbQkPP3UW2XPQnI6/cdGCwRFOxSk4kEssQOV2hBBjplVxC
         d/Tg==
X-Gm-Message-State: AOJu0YydzHUyFKusN6fbCEjxi2EWWi3dz2b9siBjqhEG8fXkM4SKGIDm
	0PMn26aB4al3VNHwe21DDBtAicvAhLCi1Vb8cOPTd0H8LaTZS1iuhcAVqFuZod8nd9Y=
X-Gm-Gg: AZuq6aJDcsd29sMEdtmwYUHz3P9g8vBuwoSO79sIkZK1wBb8tVmSCmvZjv2A3SavgXt
	e6M0Kp5BqkqItz4zqGO0KsWlxC06ml0ApjzwFxK/vu9zOrJynMf+Oh3oMNx3j3tvszfzBAgpl1X
	94PDdY2oNTxLX8v0mZ4VmAhzHcrjLWG6v3K0MDC+kHqLuC6aHX8uDQSWX3TvNLovmuLrrGy+dzX
	d6jtjBg1LTWM8Z6r1qg3EfTEgbZYcj3mGMLOGNs3MyPRCt4pHugkX7uN75OhrOpDMYrVfNLSIBn
	o4Ydj1jPozHj/hcqpzORNnhJEEyQf4b2+YgwXOci0vunMohatfDDD2zKBKVVqiJgYLuhKy0HXWM
	s55UDagwCuqdZJ+xSKuoNeQNZeKq/za66XCTdG0MZGESTpVIIuXCP1kE6cw6usSAkPANiE73Sic
	kiWxwdL87zmP+x5q1SbDeDibX7U5ty4vzMTcHCfqZGLg==
X-Received: by 2002:a05:600c:c16b:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-4804c9b2113mr68277445e9.22.1769196081134;
        Fri, 23 Jan 2026 11:21:21 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804db8da59sm29516845e9.5.2026.01.23.11.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:21:20 -0800 (PST)
Message-ID: <b0e79f6c-36d7-4e49-9d43-8e305a598201@freebox.fr>
Date: Fri, 23 Jan 2026 20:21:20 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid setting 320MHZ support on
 non 6GHz band
To: Johannes Berg <johannes@sipsolutions.net>,
 Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260123144224.2216923-1-nico.escande@gmail.com>
 <d26ee979-b5d5-4f50-b423-f8783122f603@freebox.fr>
 <bfed10db742d29f0609acb04d3354695f87b24e2.camel@sipsolutions.net>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <bfed10db742d29f0609acb04d3354695f87b24e2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31131-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4B06B7A1A7
X-Rspamd-Action: no action

On 23/01/2026 20:08, Johannes Berg wrote:
> On Fri, 2026-01-23 at 19:33 +0100, Pablo MARTIN-GOMEZ wrote:
>>> @@ -4901,8 +4902,14 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
>>>    	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
>>>    		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
>>>    
>>> -	if (band == NL80211_BAND_6GHZ)
>>> +	if (band == NL80211_BAND_6GHZ) {
>>>    		cap_band->eht_cap_phy_info[0] |= support_320mhz;
>>> +	} else {
>>> +		phy_cap[0] &= ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
>>> +		phy_cap[1] &= ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
>>> +		phy_cap[2] &= ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
>>> +		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
>>> +	}
>> If you want to clear all 320 MHz fields, you'll also have to clear
>> IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ and
>> IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ (not sure why it is not done
>> in mac80211)
>>
> This is, effectively, a firmware workaround. It doesn't belong into
> mac80211. All other drivers just have their capabilities managed in the
> driver anyway.
>
> johannes

I wasn't talking about putting this patch in mac80211 (I've seen the 
discussion on the patch Nicolas sent on linux-wireless), I'm talking 
about the function `ieee80211_put_eht_cap` clearing the Beamformee SS 
and Sounding Dimension fields but not the Non-OFDMA UL MU-MIMO and MU 
Beamformer fields for each bandwidth.

Pablo


