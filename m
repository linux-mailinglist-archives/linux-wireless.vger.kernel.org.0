Return-Path: <linux-wireless+bounces-26873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28032B3C379
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23CDA7A88BB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708D22B584;
	Fri, 29 Aug 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icvpnx3y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0B23C8C5;
	Fri, 29 Aug 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497445; cv=none; b=hL8uk4Eqna+60qVU4e46cn1TSnhRD7uGBWlJ21uTtP/YEfXQgk0RlYpL30WpAP2JMfL5Q/G2qykAUUQ95CoeBRPj3aFHevU5NrL33BEnJ93shPNE7gBPhy/L5cNOhUFOfx3i93qDfKdmYttbbHoUhT8mN84vlVfJUsE0vidyF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497445; c=relaxed/simple;
	bh=vATrWzOzdcANlASK38m3reqnEHzHjB1Hu40omQ+rShQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kZJZxgPL9LZJ3cjWsjXiT0HSjX5+uMBVtfLzL9p+EBwo+LwZu9MztXIc9d3d2cHCL1gUW/x3XUXBgtrnW/XaP/vFOiOgshHynnf0uKuhEfLYhwYlHugnpTA1K+xqBKNfbAlj7JB4zkUnnPp/3l/0TjrZDVVbTylZP4elsTTi0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icvpnx3y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b627ea5f3so10097915e9.1;
        Fri, 29 Aug 2025 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756497440; x=1757102240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aw3WdH2CEzADUuzx3c1qqTHGdhX4SbAIpE927IzUiIE=;
        b=icvpnx3yHZg86B1BuG72stIKyIMpidB2bA8bsHjVGO4jVpIHGFag6sMaW6YAyrd9Tt
         lnkOGQSsnOLRHz8AgQMW2djDdXx4j33SHPGVfTbfHjH2CPJxtBDGX+Yxne4bcs7CRRJC
         n78Kfen/dsJZBIpW6zmk2nLHj7CtKlQ6lYCUxzbkWjHUeWfTNVP2FvE0kU4PockxzDmw
         wprmSpH+2ktvX3b5uDkjW5mZ3CDPCFuM0ZGdzYKNOOvBCO5sGlJRWhKb+nTBvTrfRDuH
         FqUNcrYtwJsIm1gQGXAKYZjHnLXzSJR7fD3vIE854MlKyJqFp7moplZzaq8ZAEhs/cAM
         07tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756497440; x=1757102240;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aw3WdH2CEzADUuzx3c1qqTHGdhX4SbAIpE927IzUiIE=;
        b=RVmFJ+qYCVnjxePJvumaSdgcI6KVz4bH4L2BX4O0Du+gRzOHkKYoNxTzcAmovGoTcf
         C+0eB/5oGc6hpvg3ujxlbGSN4bXq+IcK6ch1kkcfmqjukGHfbYqFw3mNIUfPjSn5fNX1
         ZG1cuY376ws6J0o+c32sovn9NvM1jHcPZfzzIaO/sXG4PCXFempjX7PFq9MqBbmm43sh
         nLrsmQoOT2l2itlSEZM0VO3P+zmaN6VifwaBoHdCc64dwcwtH6CtNWdfVyhYwvpVNh5e
         UGmI6M7OblZ//bWeY1cw5VDOtOIMPxdEAKU+75GlvTPgrs7FcaSdH4zNSKFhGh3OuB7D
         dxqA==
X-Forwarded-Encrypted: i=1; AJvYcCUBisxhgM5vyQNpXP1QyGoIFiNDB9dgG8KPLcSdOmGFZAwr63xvrKFoPH9xOsKbJv4gbVA4URqcFkQ+O94=@vger.kernel.org, AJvYcCXUVR/eGFO37piR84knczzhk/VDRbJ1niRhu5udWkdpRiaSub4ST6DGtEBLkiM/WF5A443T073sLqNjLBONB2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhphbkWlB1pFh/cn41PJF0yvWuG9wB/b904q5cxPdNOIdo4M1
	XjgAummV+FJ9ZdqZNqcbppLBn2r0lRsbd1kOd7MpqR3lFHa5Ik+tWxoSJYCzLQ==
X-Gm-Gg: ASbGncspyZHRGD6N38f/pWe7Hken31QdzQHsIrrC3EwJ6YHv5ImwwOcGNG7lWd7JNR8
	RkI/TqSyg5zPBc1xZfKHS/jpALqH+zPuZtPi3SO2TFj0tA8f2MP40mQkyIrl4Qx7QMyMFB3bmzT
	XvDK4fzuiRQnPrOwlPwYwRnvsXG/j0JLIZOR/V0jl1BDFc+czAxePUB5clGHlZmULBuRq729rLo
	IWCVGTxjao6etwjba4XjAcFHcHryx5OyHfMpdefGAFg1ZTfGaei1WnzouC4eU+Sw1nTVH2eaJnf
	owqwDtOqBkia2fzZGYr55LXJzpJUxWU72WCY3cNPYmLJNGQ4z8/sDVDcveVCMCGWshyyF32R93y
	nC0FTxpfTo6FU8HC/G836vACuf81V4ZGnMPaElc0=
X-Google-Smtp-Source: AGHT+IHAw2ZX4hdx5d081RUkuMEuAXLxa/F4DCXmmagOjlPfHhg1FiyiJkx+VhUIvVI6dBTAKiSgcQ==
X-Received: by 2002:a05:600c:1c07:b0:45b:7ffa:1bf8 with SMTP id 5b1f17b1804b1-45b7ffa1d60mr30012585e9.23.1756497439678;
        Fri, 29 Aug 2025 12:57:19 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add4f2sm4494200f8f.41.2025.08.29.12.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:57:19 -0700 (PDT)
Message-ID: <bc1857a0-86d9-40aa-a1ab-f4bc83adf6fa@gmail.com>
Date: Fri, 29 Aug 2025 22:57:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw v3 3/5] wifi: rtw89: perform tx_wait completions for
 USB part
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>,
 Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Po-Hao Huang <phhuang@realtek.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20250828211245.178843-1-pchelkin@ispras.ru>
 <20250828211245.178843-4-pchelkin@ispras.ru>
Content-Language: en-US
In-Reply-To: <20250828211245.178843-4-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2025 00:11, Fedor Pchelkin wrote:
> There is no completion signaling for tx_wait skbs on USB part. This means
> rtw89_core_tx_kick_off_and_wait() always returns with a timeout.
> 
> Moreover, recent rework of tx_wait objects lifecycle handling made the
> driver be responsible for freeing the associated skbs, not the core
> ieee80211 stack. Lack of completion signaling would cause those objects
> being kept in driver internal tx_waits queue until rtw89_hci_reset()
> occurs, and then a double free would happen.
> 
> Extract TX status handling into a separate function, like its
> rtw89_pci_tx_status() counterpart. Signal completion from there.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> 
> New series iteration -> new nuances found.
> 
> It seems the two previous patches from the series would not be too great
> in USB case because there is no completion signaling for tx_wait skbs
> there.
> 
> I don't have this hardware so *the patch is compile tested only*. It'd
> be nice if someone gave it a run on top of two previous patches of the
> series, thanks!
> 

I tested your first three patches with RTL8851BU for a few hours. It's
looking good, no explosion yet.

The USB side doesn't have real TX ACK status reporting yet. I only
learned recently how to do that. It looks like it will work about the
same as in rtw88.

>  drivers/net/wireless/realtek/rtw89/usb.c | 36 +++++++++++++++---------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
> index 6cf89aee252e..10fe19bd5166 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -188,11 +188,32 @@ static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
>  	}
>  }
>  
> +static void rtw89_usb_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb,
> +				int status)
> +{
> +	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
> +	struct ieee80211_tx_info *info;
> +
> +	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, status == 0))
> +		return;
> +
> +	info = IEEE80211_SKB_CB(skb);
> +	ieee80211_tx_info_clear_status(info);
> +
> +	if (status == 0) {
> +		if (info->flags & IEEE80211_TX_CTL_NO_ACK)
> +			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
> +		else
> +			info->flags |= IEEE80211_TX_STAT_ACK;
> +	}
> +
> +	ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
> +}
> +
>  static void rtw89_usb_write_port_complete(struct urb *urb)
>  {
>  	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
>  	struct rtw89_dev *rtwdev = txcb->rtwdev;
> -	struct ieee80211_tx_info *info;
>  	struct rtw89_txwd_body *txdesc;
>  	struct sk_buff *skb;
>  	u32 txdesc_size;
> @@ -214,18 +235,7 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
>  			txdesc_size += rtwdev->chip->txwd_info_size;
>  
>  		skb_pull(skb, txdesc_size);
> -
> -		info = IEEE80211_SKB_CB(skb);
> -		ieee80211_tx_info_clear_status(info);
> -
> -		if (urb->status == 0) {
> -			if (info->flags & IEEE80211_TX_CTL_NO_ACK)
> -				info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
> -			else
> -				info->flags |= IEEE80211_TX_STAT_ACK;
> -		}
> -
> -		ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
> +		rtw89_usb_tx_status(rtwdev, skb, urb->status);
>  	}
>  
>  	switch (urb->status) {


