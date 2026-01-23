Return-Path: <linux-wireless+bounces-31128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMvuNf2+c2mjyQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 19:33:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE0079AE9
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D753015A4C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282419067C;
	Fri, 23 Jan 2026 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="inJ4YQPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C013B58C
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769193211; cv=none; b=C8shNVatDU1W1l2nqk1J6GJxna/nfIoHVXqWt/FqIrgRpy3g/f0x95Kw41bfiG3umsuBU35joERA1DIU49fOPi5Q0YndWsoSlAwDDAmc0QWubkKCgYYeJkdzbw5uMWwslFSwpqzWDFDiyqgEVFKSixL80oy7b5IvaJ+U+2SkyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769193211; c=relaxed/simple;
	bh=K56drsMV4WPaf1EGc4Qwe7QOuDyniBruHimQvdW2xh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpAj6BNp/WA4f++PcAKakx6SUGnBwWHN94Ux5luuZOB0M2uoLAAlOQ3N4PlUYs/vdWBRP9I93XgSLVoZ/OEnJ1Hh/fNb1Ob4BHOfsRr4mkI4b6uvLu3N6EVUbjCJ+D/45+vLKetE22k+ykYnpxCM5fgcXXPCCXjrch8VuZCaxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=inJ4YQPI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so19021145e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769193207; x=1769798007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KegYK2vZBZviGaRge3JiqfwLGVWHhhcV3h3kEHEJt98=;
        b=inJ4YQPIKGMK0ACMrR+03i+TNSRoa/jsLuhPqueqAMYxr/yFCTP+XAp4ZAdl96EWMI
         LUCZKHQ1CycVsRE4B7cai+1v9Hd/lJVNTJSuI9cVz6rCauBGI8w8grbQWFTlOrGw7RDf
         bEkDiJnYgc7tPl+8ZKwJV0BwZW1CEYQ4Fznm24X704Jj9l9kgl38YvQS2PeeqIdFcsOj
         E2Beqk94oMk4WxL6pEkdhrqsX7FvtolXMC+JK/nn5DWrfie2EXZE8/goeLGibveG+zJV
         tCnj3dvZo3IiAdsZIwjI7fnGmF7m5W0schJPnB8GnRjttpXI+VDnc2S/066FtxahyIWR
         VEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769193207; x=1769798007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KegYK2vZBZviGaRge3JiqfwLGVWHhhcV3h3kEHEJt98=;
        b=K/Hr/u87Okr9og9g/FfTdNV4jtxX+ap2AgLHn2tvvw+atA8MJeELP9AkvORdyK4GgY
         BiAV0VTM0nCPNAk3WL9pWKADkCgDNXKZIlvfiO74f7vst4UuqBQZQ5zgdm2YTn0oVdWN
         aOXA6KQOn17lbJ2iiRqi+e+UJogp4Y1lgx2T6vVGAfGjpKxbvAiCWtawt6HlcwEgnhet
         +O4HQtkoT9AU7CFVsJ2leEHrWaB7BayGYnJvRHKaZv57bpG410URc93KQBUaWiG17EDa
         1FjkKrEjQw2m0SRZSfjecQ2IhPzyN58jSLGKcjlDknAf99ACSHgx3DKxFnMeUB6QWGxt
         URkA==
X-Gm-Message-State: AOJu0YxeaR3vPAPb2C8n0G5hIB2wMCp5lfqhfbvk6f/RvjcJVBEK/S9e
	Ngvc/5BE2BGjympyvtCQb/jiOT0JJrJN38CrrLe23mML6FW75RWElLyhsHtp4lg5yRDD4qgtVJx
	YSLGo
X-Gm-Gg: AZuq6aKTi9VuOfe394WGD1qio11wrl4X0PDgyVB+ImJfz2bIJ5y58WvEcTM3/M9D5JG
	IOSkRJCrjq6ncgzG49kgiHSa/gSD01ETj1A1+vVWOv0rLxmV94Tfv+tFa3KF2qAJmA7pj6eMxL6
	wRoacfrzRyIZoOHeDnSYRiPgABGPPbT1QKw7p+tDuMf/iAvmzPFO44WyCb3IQIz3+XAeXzvnFzW
	q1wlF/UnVwGaKWGGNq6AXU0CJBbF3Lee52kxg5vjzM94/CIsl0uF7kehdsLnZKI94XTyGFXu0XZ
	t5T0X+FBa5uF1cGpqD3jIAhSkHm8TFIMCnSTp6FouwMdo71FTqX5789cvWSr9evEmftUDNpbV/Z
	8OgcxrDJpBtiT4fY3rh0upza14kj/RDd2lPMLoodE99jZG30b0gdibMA2yKPnIzk3d6IXx0jNga
	ZL+8DiZElUDp2BnnV2VjccsAriLhtBxFxg6qtTBvnOLcQXAMtdgxN6
X-Received: by 2002:a05:600c:a016:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-4804c9c144fmr69060155e9.31.1769193206911;
        Fri, 23 Jan 2026 10:33:26 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbb6315sm28860395e9.4.2026.01.23.10.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 10:33:26 -0800 (PST)
Message-ID: <d26ee979-b5d5-4f50-b423-f8783122f603@freebox.fr>
Date: Fri, 23 Jan 2026 19:33:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid setting 320MHZ support on
 non 6GHz band
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260123144224.2216923-1-nico.escande@gmail.com>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260123144224.2216923-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31128-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4BE0079AE9
X-Rspamd-Action: no action

Hello,

On 23/01/2026 15:42, Nicolas Escande wrote:
> On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
> realated features on the 5GHz band while it should not:
>
>      Wiphy phy1
>      [...]
>          Band 2:
>      [...]
>              EHT Iftypes: managed
>      [...]
>                  EHT PHY Capabilities: (0xe2ffdbe018778000):
>                      320MHz in 6GHz Supported
>      [...]
>                      Beamformee SS (320MHz): 7
>      [...]
>                      Number Of Sounding Dimensions (320MHz): 3
>      [...]
>                  EHT MCS/NSS: (0x22222222222222222200000000):
>
> This is also reflected in the beacons sent by a mesh interface started on
> that band. They erroneously advertise 320MHZ support too.
>
> This should not happen as the spec at section 9.4.2.323.3 says we should
> not set the 320MHz related fields when not operating on a 6GHz band.
> For example it says about Bit 0 "Support For 320 MHz In 6 GHz"
>
>    "Reserved if the EHT Capabilities element is indicating capabilities for
>     the 2.4 GHz or 5 GHz bands."
>
> Fix this by clearing the related bits when converting from WMI eht phy
> capabilities to mac80211 phy capabilities, for bands other than 6GHz.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 84c29e4896a4..14947fdb9813 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -4888,6 +4888,7 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
>   				       __le32 cap_info_internal)
>   {
>   	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
> +	u8 *phy_cap = (u8 *)&cap_band->eht_cap_phy_info[0];
>   	u32 support_320mhz;
>   	u8 i;
>   
> @@ -4901,8 +4902,14 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
>   	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
>   		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
>   
> -	if (band == NL80211_BAND_6GHZ)
> +	if (band == NL80211_BAND_6GHZ) {
>   		cap_band->eht_cap_phy_info[0] |= support_320mhz;
> +	} else {
> +		phy_cap[0] &= ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
> +		phy_cap[1] &= ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
> +		phy_cap[2] &= ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
> +		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
> +	}
If you want to clear all 320 MHz fields, you'll also have to clear 
IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ and 
IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ (not sure why it is not done 
in mac80211)
>   
>   	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
>   	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);

Best regards,

Pablo MG


