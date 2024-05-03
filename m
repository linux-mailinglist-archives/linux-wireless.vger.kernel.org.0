Return-Path: <linux-wireless+bounces-7152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A618BB1EA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 19:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E591C20F1B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DFE23CB;
	Fri,  3 May 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id2lUXS4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B6481D1
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758455; cv=none; b=mnQg1CgZcxXkzLiLn6XOJb1YzHPmlMDtOZcIoqU9ZUK+QUAkdYimo3VrXQ8A2elrdBoJ1D6o6v20UE6S14aQAN4bbGhocioHcbcGcUt+BnJ/CD/nNfWiZh4YrF5ajFHD09O2Vcm9B1qUP3MwyXeiMH4fWUG/EJh2EgNvvMbAIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758455; c=relaxed/simple;
	bh=MVV8+UaMpXYZgOnoAimyyKAbi+gSMicY83cmeXF+a5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRCirpWDTBEi78jjH1PGlbyZbASWGbi+SaZVla3E3lavWdHp0qXX3tXlj7OvkKQmX9mCczL1axFO8wr61NwuGuAi0JGtxMzKzxrE2F2dVt3fIUCvGMpX3IG0fhqqqt+4Z0axcisFJdsTUc/vkKNNbCJiI12QxKbrkBaUP8AQwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id2lUXS4; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23e78ef3de7so321400fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 May 2024 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714758453; x=1715363253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qcAVLbiFIkNm0FXsR6QtwGfyL/MOypgXNcuzEe7ryAg=;
        b=Id2lUXS4DB10QZmqzp1UC6U3t+GZyfhwPoXbuvd50/jtWevBM2IREVOSjgCs2b7jLe
         qGMfQ5ZlOxAU8xQXbedgP8XNDo/q4sSgSVboMF1prU8TVRYiMx7JWPBBee8sd5ydPMbi
         eUIxGTaN7dVCMb0H4TTKkkyj3ArN0WtWJNgnUbpj9G9lT18FNN3/N+gSjMpdMJiGfbmU
         dXUYOscjBDfssxCYPmFcFoS2ouK5SOJLakO6jIokPBGLFa42K5E4JUc/XNZWnEmzn2Ck
         tgOiMQJX7ZK//IEYtkDMClDjkKspJGZ+hRfCQSLN2009EaJvWT26cKGOPJ0n0ngSu3MP
         BWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714758453; x=1715363253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcAVLbiFIkNm0FXsR6QtwGfyL/MOypgXNcuzEe7ryAg=;
        b=WzHx7OcpNO7My4VbyFaHsu0IJASjZOqCF9OaLlIFDd2cqO4be1y97oM+L1ngc0AMm1
         9cw/0A0B3niluU9EjQXu4PHWfPjuBad4SiZz2ohfqeoWiTUeExr8Gr6yqpVL81O0c06v
         xsqZ//QWCruQwH5DasnjHuoLOQxnKwjY9rrTBX8iwESRjL5mnV9ZmZSjP6aMYltsWLAu
         Xi7dqNQ/1vcVq895TvseNXc9zOo6WkLwPgX6krHbtW5J9zMjfCw+pLECTtBLDwiHD3i+
         jv1ng6Sh1tYf2sQtjK18EAA9SHsPFHrgnf9sCfvRDCuCRXlVBc9+oTDd0S2DvVaqxhN4
         LCQw==
X-Forwarded-Encrypted: i=1; AJvYcCXIgONVIm4ZJxHuk303aTUMM+vaCQwsJ5n8JTQERf3N652A5QOmslIxMLUl7zWMvC1VNyFIxHb4F0rKDl9+biC29lm3cTUugc2yVzbV6t8=
X-Gm-Message-State: AOJu0YxRtxaXyEzvKjGndCVOwr5/ROyDoNSNWIIzv9eIdQcA8JXd6Bs/
	2+XW1af6cCzDNHy3lSa+LnF0/eBFF9UZJhPjbyqluB5XboDH//vE
X-Google-Smtp-Source: AGHT+IFQekfVQo6HmLPZ5PFIM4jI1L/1CW7xzhffFuDRVUbiSaKlgVD76VjL2/k+lpSspB+cQ7aL8Q==
X-Received: by 2002:a05:6870:d1ca:b0:23d:79c3:5627 with SMTP id b10-20020a056870d1ca00b0023d79c35627mr3979453oac.36.1714758452924;
        Fri, 03 May 2024 10:47:32 -0700 (PDT)
Received: from [192.168.0.189] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id mm17-20020a0568700e9100b0023bd97fa06bsm687696oab.43.2024.05.03.10.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 10:47:32 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6af77250-505c-430d-901b-dec4e7e3d009@lwfinger.net>
Date: Fri, 3 May 2024 12:47:23 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtw88: usb: Simplify rtw_usb_write_data
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <2479507e-3946-492f-857e-83e54969aad2@gmail.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <2479507e-3946-492f-857e-83e54969aad2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/24 5:53 AM, Bitterblue Smith wrote:
> The skb created in this function always has the same headroom,
> the chip's TX descriptor size. (pkt_info->offset is set by
> rtw_usb_write_data_rsvd_page() to chip->tx_pkt_desc_sz.) Use
> chip->tx_pkt_desc_sz directly.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>   - Don't touch rtw_usb_write_data_rsvd_page(). It needs to set
>     pkt_info.offset after all, otherwise RTL8822BU and RTL8821CU fail
>     to upload the firmware:
> 
> ---
>   drivers/net/wireless/realtek/rtw88/usb.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 1dfe7c6ae4ba..a28f35a03b26 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -440,23 +440,21 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
>   {
>   	const struct rtw_chip_info *chip = rtwdev->chip;
>   	struct sk_buff *skb;
> -	unsigned int desclen, headsize, size;
> +	unsigned int size;
>   	u8 qsel;
>   	int ret = 0;
>   
>   	size = pkt_info->tx_pkt_size;
>   	qsel = pkt_info->qsel;
> -	desclen = chip->tx_pkt_desc_sz;
> -	headsize = pkt_info->offset ? pkt_info->offset : desclen;
>   
> -	skb = dev_alloc_skb(headsize + size);
> +	skb = dev_alloc_skb(chip->tx_pkt_desc_sz + size);
>   	if (unlikely(!skb))
>   		return -ENOMEM;
>   
> -	skb_reserve(skb, headsize);
> +	skb_reserve(skb, chip->tx_pkt_desc_sz);
>   	skb_put_data(skb, buf, size);
> -	skb_push(skb, headsize);
> -	memset(skb->data, 0, headsize);
> +	skb_push(skb, chip->tx_pkt_desc_sz);
> +	memset(skb->data, 0, chip->tx_pkt_desc_sz);
>   	rtw_tx_fill_tx_desc(pkt_info, skb);
>   	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, skb->data);
>   

This one works with the 8822bu.

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry


