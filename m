Return-Path: <linux-wireless+bounces-6282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9984A8A420D
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 13:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA78281478
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 11:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB8725634;
	Sun, 14 Apr 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfRJoo3N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFE1F941
	for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713094355; cv=none; b=V28REMegCdoyQBShx298nElR4RCF0SW+OVbI6A+60ejdOMKqXNQpAVtCBF9Smj49YXo9k59MiaWXtEV74bpCEUsJdGG7iYdeZk1msE4RaFb9wEY9PK3bhah2BhHQE6E0VmZMGVMOJWXxPsfhDSpLKfxVhNRXvi+st2ccKY96FCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713094355; c=relaxed/simple;
	bh=FjDSaKSB6+XYMhKutS/O+W4AZkNfjwNV/LS/1KWPCPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mz5PrpL4PyLAwBsKhMXmNsAZP64FIAl2aA2onpUNyHwmGOZX0y3wKNxQwEhouOOGrmk8UcFqOhRllAb3lfPXkP5IwLOQoh1PDFbjPo7Maih3QHHjJowrsi7+2dvWIrKamJWynZ+9G0z18fu/K19ZUQE3IfUhW9ofzpBjhLJXMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfRJoo3N; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4155819f710so15454675e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713094351; x=1713699151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JP/cSENjvucnYTCul05SybcWHmvPMdDKZgxdlbCRq4E=;
        b=HfRJoo3NMV9lpY/3gJZW4OSa2pS3P920DchOdSWzM1FpJkmyW85jWiOSOHIdsf+0U0
         l3ZoU2ntyJvSGTMNsbp3IXk7H4CfXU32Qc9ULptNORvXJIXbUxEj5Un0S+xr/tL4fmYL
         7EqlJxW2wzmupYUEW4I0/MFYnEztzavsVJxJzrPD6gIyh5CFlkPpmCfde42c6OcKID2k
         AwnnE/6bT25gamppvSZ5W6xy8m4V1+nJCvKS9W49IlUQyn//DOSoynob7B+eRTOy/6sR
         sesAKUudScJcCiFzu4uywEDJzaGCS0lafy5YIA4PySbgkNuC/VPSsRRJPENHqvjuIuzb
         XtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713094351; x=1713699151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JP/cSENjvucnYTCul05SybcWHmvPMdDKZgxdlbCRq4E=;
        b=H4Z5+lfPX3jcr8cnalLdsUGABmuXn8dLDbXmi12uxCgFCKmyp0ZyxLgoYdlu44cQd3
         9dDzUsXFL4fuP7pNB8zJVMEIRLfPTf9UhAqRi8suRVoF8/VBDbj22zcFHrWvWZzEDZJG
         EsK77+m3mGLgBIIESiZjtRYbpmfg6TUFdoRtgvNagNUfZf02GB43ZL4t158FNllMvGWO
         LbVYUbCLGkAiLW4cdi5esuU8Kw1scoFwZbYseweuz8VK8a2aLFtiqmc7tVpWhyxxD+2I
         IiYydtM/QoaEioGibyBzkrFUMJYQIjobQScJODOKr7jHuRPXvr8900oFdCV3KYG5oAoJ
         RAug==
X-Forwarded-Encrypted: i=1; AJvYcCUyUR8sjKZr4Cm0Dw3EqrsPmPHKSPHXEAsJYQzbvy73lcqwWMlE238rsybXkPGi5SeA6qSKFeek9nN2dYHA8726D8YhSwoSRt6yH/rHIQs=
X-Gm-Message-State: AOJu0YxBCPKCaJnD7LrAdSwn+mNeOY1uB+FYYNKhV9yA5soxWhAV2imd
	rFUMfgCAlAu8WdU73bcWCaGMBNzUnobXtaw1/yMUO+02zqAP3Xej
X-Google-Smtp-Source: AGHT+IEfp3Lq/nAA8uK2md2PLDk7aL81zT+CUYWClsK38cvzoq/mj6LperRv2YJuzRmkGL3LCKrC2Q==
X-Received: by 2002:a05:600c:1e8c:b0:417:fe3d:8ada with SMTP id be12-20020a05600c1e8c00b00417fe3d8adamr5913372wmb.29.1713094350629;
        Sun, 14 Apr 2024 04:32:30 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b004182b87aaacsm4517093wms.14.2024.04.14.04.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 04:32:30 -0700 (PDT)
Message-ID: <fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
Date: Sun, 14 Apr 2024 14:32:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: enable MFP support
To: Martin Kaistra <martin.kaistra@linutronix.de>,
 linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20240314164850.86432-1-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 18:48, Martin Kaistra wrote:
> In order to connect to networks which require 802.11w, add the
> MFP_CAPABLE flag and let mac80211 do the actual crypto in software.
> 
> When a robust management frames is received, rx_dec->swdec is not set,
> even though the HW did not decrypt it. Extend the check and don't set
> RX_FLAG_DECRYPTED for these frames in order to use SW decryption.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 4a49f8f9d80f2..870bd952f5902 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -6473,7 +6473,9 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>  			rx_status->mactime = rx_desc->tsfl;
>  			rx_status->flag |= RX_FLAG_MACTIME_START;
>  
> -			if (!rx_desc->swdec)
> +			if (!rx_desc->swdec &&
> +			    !(_ieee80211_is_robust_mgmt_frame(hdr) &&
> +			      ieee80211_has_protected(hdr->frame_control)))
>  				rx_status->flag |= RX_FLAG_DECRYPTED;
>  			if (rx_desc->crc32)
>  				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
> @@ -6578,7 +6580,9 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>  			rx_status->mactime = rx_desc->tsfl;
>  			rx_status->flag |= RX_FLAG_MACTIME_START;
>  
> -			if (!rx_desc->swdec)
> +			if (!rx_desc->swdec &&
> +			    !(_ieee80211_is_robust_mgmt_frame(hdr) &&
> +			      ieee80211_has_protected(hdr->frame_control)))
>  				rx_status->flag |= RX_FLAG_DECRYPTED;
>  			if (rx_desc->crc32)
>  				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
> @@ -7998,6 +8002,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>  	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
>  	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
>  	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
> +	ieee80211_hw_set(hw, MFP_CAPABLE);
>  
>  	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>  

I ran into this problem recently with rtl8192du:
https://lore.kernel.org/linux-wireless/ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com/

Does the same fix work for you in rtl8xxxu? Checking the "security"
field of the RX descriptor is simpler than calling two functions.
Sorry to bother you when the patch is already applied.

Also, won't you send the patch to the stable tree?

