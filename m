Return-Path: <linux-wireless+bounces-27623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED883B97B01
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 00:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C4119C6A4A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 22:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96730DEC7;
	Tue, 23 Sep 2025 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3DCCpup"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8C288C8B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665545; cv=none; b=dABw7exVMbpVwnS9xUXEBzk+p74+qoiTMWYpcapUfMip+RMWVcKDJDTLwX+oRxkQnZjf7hcoJEGWJxziL3BzsoDPSla+CM/ESFEtDqAqh4bF7N6M0TBbOYz+YqjwX/eOXuYdTZZkrpvE4k+SXIXAMhpSOBFEr8N8Bcu/vwJNwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665545; c=relaxed/simple;
	bh=tWCqS0/xNW/czes9Czakwbg4BV++k3/9D8l3A7oiYkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLD1jtX0FJSvUID5lfSWE/Mg/bRHvL9c1R0YGjbI/+bJFLjXiYFrWL0x7nNTKVzRhvL0sFbMGf+CRq0KI+q7xCa5XPY9QUSxdYkBwY68kKxRlIWpzMGFhNNF90JQVVGv2xYHXnwUSUKOEEzmsm+9sYt6Tn/lB1ONZ1GzFS8ZmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3DCCpup; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3420358f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758665541; x=1759270341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3cmOvj1z5jQEZahSIP60v1mSfyWicm5Qo/odOnPq7o=;
        b=m3DCCpupXCzoKgu2MBz4HCXJWuIwcQFqzON89k8fwOuq6XHiOiK5lZ9i6t65zPoigj
         jJwKbvzP3+nh/THkz/cvC3Z8NwRAdM2pvn39LVEsJVpjRf6LcltRR3g3j1b/J9ZLMa3s
         Z+q0Lrir0qdoCs1Bty2/MqYYhon81fRS71rth3VkK2HtXG8ltCldTvjX7rejYA5pmAYs
         63gbn1AKMH66eaeMo55cffp+Bwg97b5cwaNfRwXGCyOgTou65Lig9F2aKaQaAXJEINS5
         CVoBQZgxjqn4aAh16dqKwqz5BgnErX3iMBxzHg2ClnEYTeoSjGNbxH3HV0RqksU4c3GH
         kFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758665541; x=1759270341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3cmOvj1z5jQEZahSIP60v1mSfyWicm5Qo/odOnPq7o=;
        b=M2m2i3SizGEWpspoUz9EiY1Cymt7hsnaOsuYEGLfIMywnE7s7M8aG3OqFsAU4zpeI1
         X2yIfR6SWC0TiGYCqK5653lD+3Sw8KB7vbWtExK7UTbFLbSH2PtYtjxo07rOpIXB4A87
         MSdUSDRBj5ibKq1QhfAUUdLc2UJJZxu11FtCOqT8rpEx7hOPq5rHNUYJUedg56eqL6Wj
         3rTDMA4iW7ngSvBq2qacDzEXf43ITThUUwy5qaWnGn5877Z69BHvRZ6OQpUl2dqNLneH
         eMnFC6+Qwuw2BLMVUK7Jgh9TCZLtL6AW56RXtrIM6Rp1tZzBh34twuS8p2+OMmERaGdO
         hdqA==
X-Forwarded-Encrypted: i=1; AJvYcCUe4cdDz0DAseLTMFG4IONzwo5nowsnhaBPyj8eWPwSmzCi5BmWlWICotZD9br47XpLT0WJ8y49amM1EYxjaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvdR3oCi36SNqai8nI5FT3Xgimp+4sp8bynKt8Qj0eB/Jfq83
	3wlKMzOukkDtUedOUM5R6W3ghsMOTqnIRb6zGnfAqlX1n4EML72e67it
X-Gm-Gg: ASbGnct5rNw3BjjONMbHHRYgj2Sw17NbxqEEqv3on2ee+8fAStuQJV7i6RHAIKKkIjs
	OKBfvMvJDiCkPr9psAK/zfShy76Qid3cyK5iTBsmtZymrqyl0PJRq5RYcLeUP5wmSE+WpbzF1YH
	t9l/aL3PvIF17UAkpDurCfKXawe/gKYKYVzTKymq1DtoYn0QG5v+xyZlEOzi7Vlct4xVyNCXeSP
	Sh60d/PNbBQKd7xi+6Z94aodE5jTY35wAnRfCh3FsJXgqTtX74yCAWQFiUIQmCSmH9y+n1Sgloq
	op4bDJx9bQmwNKbQCFZH+C0n0vTjZzk/fzwhv4VoaJNwlIp0AnA7rAes33C7RQ0lmbqI+ZH4G8/
	L914ZPzhYURUVln4orx9yG69+yWp6
X-Google-Smtp-Source: AGHT+IGFrIIZXO1zswRAIHb7gc+ZZRDOxJth0jbcat9a/81MjMfuhhVTWMtbDkgz9QHyM29FFrSbqg==
X-Received: by 2002:a05:6000:2c10:b0:3ee:13ba:e138 with SMTP id ffacd0b85a97d-405c5cccfdfmr4150418f8f.26.1758665541282;
        Tue, 23 Sep 2025 15:12:21 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f4f3csm24511801f8f.2.2025.09.23.15.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 15:12:20 -0700 (PDT)
Message-ID: <5316222e-5d9d-4cb8-b161-06ba311bdc2d@gmail.com>
Date: Wed, 24 Sep 2025 01:12:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 3/6] wifi: rtw89: implement C2H TX report handler
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, Po-Hao Huang
 <phhuang@realtek.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-4-pchelkin@ispras.ru>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20250920132614.277719-4-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/09/2025 16:26, Fedor Pchelkin wrote:
> rtw89 has several ways of handling TX status report events.  The first one
> is based on RPP feature which is used by PCIe HCI.  The other one depends
> on firmware sending a corresponding C2H message, quite similar to what
> rtw88 has.
> 
> Toggle a bit in the TX descriptor and place skb in a queue to wait for a
> message from the firmware.  Do this according to the vendor driver for
> RTL8851BU.
> 
> It seems the only way to implement TX status reporting for rtw89 USB.
> This will allow handling TX wait skbs and the ones flagged with
> IEEE80211_TX_CTL_REQ_TX_STATUS correctly.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 12 +++++++++++-
>  drivers/net/wireless/realtek/rtw89/core.h |  2 ++
>  drivers/net/wireless/realtek/rtw89/fw.h   |  5 +++++
>  drivers/net/wireless/realtek/rtw89/mac.c  | 23 +++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/mac.h  |  9 +++++++++
>  drivers/net/wireless/realtek/rtw89/txrx.h |  2 ++
>  6 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> index 917b2adede61..d2a559ddfa2e 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1420,11 +1420,20 @@ static __le32 rtw89_build_txwd_info2_v1(struct rtw89_tx_desc_info *desc_info)
>  	return cpu_to_le32(dword);
>  }
>  
> +static __le32 rtw89_build_txwd_info3(struct rtw89_tx_desc_info *desc_info)
> +{
> +	bool rpt_en = desc_info->report;
> +	u32 dword = FIELD_PREP(RTW89_TXWD_INFO3_SPE_RPT, rpt_en);
> +
> +	return cpu_to_le32(dword);
> +}
> +
>  static __le32 rtw89_build_txwd_info4(struct rtw89_tx_desc_info *desc_info)
>  {
>  	bool rts_en = !desc_info->is_bmc;
>  	u32 dword = FIELD_PREP(RTW89_TXWD_INFO4_RTS_EN, rts_en) |
> -		    FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1);
> +		    FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1) |
> +		    FIELD_PREP(RTW89_TXWD_INFO4_SW_DEFINE, desc_info->sn);
>  
>  	return cpu_to_le32(dword);
>  }
> @@ -1447,6 +1456,7 @@ void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
>  	txwd_info->dword0 = rtw89_build_txwd_info0(desc_info);
>  	txwd_info->dword1 = rtw89_build_txwd_info1(desc_info);
>  	txwd_info->dword2 = rtw89_build_txwd_info2(desc_info);
> +	txwd_info->dword3 = rtw89_build_txwd_info3(desc_info);
>  	txwd_info->dword4 = rtw89_build_txwd_info4(desc_info);
>  
>  }
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
> index 928c8c84c964..2362724323a9 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -1167,6 +1167,8 @@ struct rtw89_tx_desc_info {
>  	u8 ampdu_density;
>  	u8 ampdu_num;
>  	bool sec_en;
> +	bool report;
> +	u8 sn;
>  	u8 addr_info_nr;
>  	u8 sec_keyid;
>  	u8 sec_type;
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
> index ddebf7972068..f196088a8316 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.h
> +++ b/drivers/net/wireless/realtek/rtw89/fw.h
> @@ -3747,6 +3747,11 @@ struct rtw89_c2h_scanofld {
>  #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
>  	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
>  
> +#define RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h) \
> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 6))
> +#define RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h) \
> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(12, 8))

This is only 4 bits:

#define TXCCXRPT_SW_DEFINE_SH		8
#define TXCCXRPT_SW_DEFINE_MSK		0xf


The rest of the series looks good to me. (I don't know much about
the RCU stuff.) I will test this tomorrow.

> +
>  struct rtw89_mac_mcc_tsf_rpt {
>  	u32 macid_x;
>  	u32 macid_y;
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index fd11b8fb3c89..01afdcd5f36c 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5457,6 +5457,17 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
>  	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
>  }
>  
> +static void
> +rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
> +{
> +	u8 sw_define = RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
> +	u8 tx_status = RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
> +
> +	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> +		    "C2H TX RPT: sn %d, tx_status %d\n",
> +		    sw_define, tx_status);
> +}
> +
>  static void
>  rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
>  {
> @@ -5691,6 +5702,12 @@ void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
>  	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
>  };
>  
> +static
> +void (* const rtw89_mac_c2h_misc_handler[])(struct rtw89_dev *rtwdev,
> +					    struct sk_buff *c2h, u32 len) = {
> +	[RTW89_MAC_C2H_FUNC_TX_REPORT] = rtw89_mac_c2h_tx_rpt,
> +};
> +
>  static
>  void (* const rtw89_mac_c2h_mlo_handler[])(struct rtw89_dev *rtwdev,
>  					   struct sk_buff *c2h, u32 len) = {
> @@ -5777,6 +5794,8 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
>  		}
>  	case RTW89_MAC_C2H_CLASS_MCC:
>  		return true;
> +	case RTW89_MAC_C2H_CLASS_MISC:
> +		return true;
>  	case RTW89_MAC_C2H_CLASS_MLO:
>  		return true;
>  	case RTW89_MAC_C2H_CLASS_MRC:
> @@ -5812,6 +5831,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>  		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MCC)
>  			handler = rtw89_mac_c2h_mcc_handler[func];
>  		break;
> +	case RTW89_MAC_C2H_CLASS_MISC:
> +		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MISC)
> +			handler = rtw89_mac_c2h_misc_handler[func];
> +		break;
>  	case RTW89_MAC_C2H_CLASS_MLO:
>  		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MLO)
>  			handler = rtw89_mac_c2h_mlo_handler[func];
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
> index 25fe5e5c8a97..632b85aed032 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -432,6 +432,14 @@ enum rtw89_mac_c2h_mcc_func {
>  	NUM_OF_RTW89_MAC_C2H_FUNC_MCC,
>  };
>  
> +enum rtw89_mac_c2h_misc_func {
> +	RTW89_MAC_C2H_FUNC_WPS_RPT,
> +	RTW89_MAC_C2H_FUNC_TX_REPORT,
> +	RTW89_MAC_C2H_FUNC_BF_SENS_FEEDBACK = 0x4,
> +
> +	NUM_OF_RTW89_MAC_C2H_FUNC_MISC,
> +};
> +
>  enum rtw89_mac_c2h_mlo_func {
>  	RTW89_MAC_C2H_FUNC_MLO_GET_TBL			= 0x0,
>  	RTW89_MAC_C2H_FUNC_MLO_EMLSR_TRANS_DONE		= 0x1,
> @@ -470,6 +478,7 @@ enum rtw89_mac_c2h_class {
>  	RTW89_MAC_C2H_CLASS_WOW = 0x3,
>  	RTW89_MAC_C2H_CLASS_MCC = 0x4,
>  	RTW89_MAC_C2H_CLASS_FWDBG = 0x5,
> +	RTW89_MAC_C2H_CLASS_MISC = 0x9,
>  	RTW89_MAC_C2H_CLASS_MLO = 0xc,
>  	RTW89_MAC_C2H_CLASS_MRC = 0xe,
>  	RTW89_MAC_C2H_CLASS_AP = 0x18,
> diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
> index 984c9fdbb018..d7259e6d798e 100644
> --- a/drivers/net/wireless/realtek/rtw89/txrx.h
> +++ b/drivers/net/wireless/realtek/rtw89/txrx.h
> @@ -139,8 +139,10 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
>  #define RTW89_TXWD_INFO2_SEC_CAM_IDX GENMASK(7, 0)
>  
>  /* TX WD INFO DWORD 3 */
> +#define RTW89_TXWD_INFO3_SPE_RPT BIT(10)
>  
>  /* TX WD INFO DWORD 4 */
> +#define RTW89_TXWD_INFO4_SW_DEFINE GENMASK(3, 0)
>  #define RTW89_TXWD_INFO4_RTS_EN BIT(27)
>  #define RTW89_TXWD_INFO4_HW_RTS_EN BIT(31)
>  


