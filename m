Return-Path: <linux-wireless+bounces-26155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E9FB1A93F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 20:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C927A17DFBF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB6286D49;
	Mon,  4 Aug 2025 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eox9q3hE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E7140E5F
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333079; cv=none; b=lkmbrHKTjh6K9lRbWI3rymQnddpRZOVQHPcs2K1S5fwuHF0KUAQbdJ3+ncSoHQ5wzLOKbBt88CXDegBBDKvF0dKejbdIKijZGtHYQDhMvrsfitqH9+XVi9GV3fy8CVauAeoTj6GxDUCu73taMKBTuIBRsFbQJJwsxXdyeGHAVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333079; c=relaxed/simple;
	bh=e0xHdqHgFoAizRg9TBvjD/rslXWpiSrKaUZQNcVMsM0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W+hkJXqWqUwUw3d9cicB/SiVVyfsBZI6Z7rSBddqIgH4H/QCXYqrdN4dxFo+rsP6y9ReFxadOB0gielDWvldYeeHujynBYIU1+PNT2Ma8xkMlyOmqrd595hxUDVZGU576LA8hnv+FDV7/SdsHCLMxawDQAVhYEeY7FaYdytCBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eox9q3hE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ddb41539so5060105e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754333074; x=1754937874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Is2PSPt/N9ZSsD/JENbh3MTVkAtn4RNa5t9nPpt03VU=;
        b=Eox9q3hEreZ0zbPGjVWJMzr+yzcZLpMnJBUdZDMX+EI/YfERgJs01PScW8s9yP052O
         X8VbkI9nqc6pVWjatSqbbsh0S7xBiIUSlSvRDGi04z2QRbf8QVpldHSer2gIH1tQomek
         W2hLBj9cEQacHxfciPbVevUu+/OeFGnX5uITLnbvAdT4RstHKBxPMex+lA5B83xzkkPT
         pJSXjQGesMKrwjbkq3ypY+PYHihACNi5x5T+x9qs5OCKMI+WB6+EFvWt/+fowvlRlcP3
         GsAeaxRkyezKGqCp7teVhZsoSR5v78qcksdGnpmBJGVCzebSIT8t+EEOqEEjg9fwAys1
         sz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754333074; x=1754937874;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Is2PSPt/N9ZSsD/JENbh3MTVkAtn4RNa5t9nPpt03VU=;
        b=mMKxdSexKtu7Lbon3numkAs6Ps9UITB1KlCJI7rfcKzDbluA1TMBSQagWmnX3Ydh5t
         ybiYmF53hG7Gk0QJitvAE4j+NYFkMRrjgqD6D9PfWpYVUAQKGQQHKH/w7gr4IK/VEIKl
         D0Ro1UlH1/rTE4TbFrTWAv+ijPHh74VAk09ZnUF+At5wtqciohrxL+05LxekGrzFRrs9
         8wpjbJOr2VL3ro2jfMX1NVXT8S2NPARPqGmEu++mjZTTuJ31H/zjv49eIQMspQG8mTmU
         zSMKLON+UasvQ+zsyth1KMgXMr4vlT4DdLNT3t3Tf57oYUdItxFpbidclRI7e+AjHXrQ
         NfCQ==
X-Gm-Message-State: AOJu0Yw9ZgfX0i495v52c0SEXZAh96t3+CVfsNd9T1pfD972MOAIIa17
	qcfZ0XHxa9iTCPTlRKvSL+YRp7dXM092C5i/vt1A6wt50FcuFDU63nQl/AoxwA==
X-Gm-Gg: ASbGnct4L151XYuyv4sG8sy+ngUsajidqhocAQuh5pmt/Bz4ccYoSakqUqMeW24aZzM
	sIIGAbG4RkKm0/BzACOfnWNO6mGrfOyGu4yFvvy4GvGWOekq8e/hT7yBs7IS5xuR2IhOYq4Iutl
	MgumutlBGiaCjCNzrdUvLoXwbTM2eaAzbR8hvu/ASip3U7zdltC7qBN67hvkLc/rE5sLN+/by7t
	qT0uNfIhjNvicwKryIO7ukDT9uNQ9H6LQJO55r8tncS4jcJwSr9WeXUKYbPrxNaVQYK2GrS6tCE
	hpfM5ullljjdZvHp/4T6ovfUW1N7wl+CMLN6rWaMG0hBK0kJQbJblYzTngcGobwbFocRyVupf+A
	IJIfS8/c2sG3Zt+a46EZaETgGAeWwUPZAGcG1mEln
X-Google-Smtp-Source: AGHT+IEl+NgMWQAKQyUUp4d727sNg3Wzz4m/pUa2Wu0EcDHYPTwU5M5EPIZ4tjr7Eaz7rzQxI/HvhQ==
X-Received: by 2002:a05:600c:3591:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-458bac4e0e1mr83846605e9.2.1754333073892;
        Mon, 04 Aug 2025 11:44:33 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b4a6635asm120130095e9.29.2025.08.04.11.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 11:44:33 -0700 (PDT)
Message-ID: <11f3e864-7509-4e5f-86ed-997f8a9b63e9@gmail.com>
Date: Mon, 4 Aug 2025 21:44:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 01/11] wifi: rtw89: Fix
 rtw89_core_get_ch_dma() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <5b1210f3-499d-44d8-9433-7beac2a2800d@gmail.com>
Content-Language: en-US
In-Reply-To: <5b1210f3-499d-44d8-9433-7beac2a2800d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/08/2025 23:51, Bitterblue Smith wrote:
> It seems RTL8852CU can only use TX channels 0, 2, and 8 (for band 0),
> otherwise the chip stops working after downloading at maximum speed
> for a few seconds.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>  - No change, messed up sending v1.
> ---
>  drivers/net/wireless/realtek/rtw89/txrx.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
> index ec01bfc363da..318fd0ac8726 100644
> --- a/drivers/net/wireless/realtek/rtw89/txrx.h
> +++ b/drivers/net/wireless/realtek/rtw89/txrx.h
> @@ -734,6 +734,25 @@ rtw89_core_get_qsel_mgmt(struct rtw89_dev *rtwdev, struct rtw89_core_tx_request
>  
>  static inline u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
>  {
> +	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB &&
> +	    rtwdev->chip->chip_id == RTL8852C) {
> +		switch (qsel) {
> +		default:
> +			rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n",
> +				   qsel);
> +			fallthrough;
> +		case RTW89_TX_QSEL_BE_0:
> +		case RTW89_TX_QSEL_VO_0:
> +			return RTW89_TXCH_ACH0;
> +		case RTW89_TX_QSEL_BK_0:
> +		case RTW89_TX_QSEL_VI_0:
> +			return RTW89_TXCH_ACH2;
> +		case RTW89_TX_QSEL_B0_MGMT:
> +		case RTW89_TX_QSEL_B0_HI:
> +			return RTW89_TXCH_CH8;
> +		}
> +	}
> +
>  	switch (qsel) {
>  	default:
>  		rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n", qsel);

I see now that RTL8922AU needs the same change. And same in patch 2/11
as well.

