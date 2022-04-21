Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED850958A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 05:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383998AbiDUDsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 23:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiDUDsj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 23:48:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30274AE69
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 20:45:50 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11C113F1BA
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 03:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650512748;
        bh=2f878bmi4JxnBjaZ2FfqMVkNzpe8ionbFp3Pao0b0Yg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=BMMhHoruZofAc/YaiIt+oeAdQ194TjAHQ5TPBz8qe3pTZ38NBbUR7ln52cV8NmQiP
         zgln+K+FY7K0cJnDtnccfb+Hs4/2SYcK13DbuUCGWz/jf/NEuRQI/+UhQWKyZ8oN1R
         1bELNLpQuacYOSOZXHII+wWoUq36hk4xp4HT08t2thyPSa2Gss47lWYZLEfTNASlHC
         DEfb4Yc/xLSAo6xD3YSBP5c27bHMgp688wTBpiZWPYWyImD1+QLnw2cvKLco4ZZL8w
         YXj+p8jKsCKc8fdEYxrsS5VGk+texpDgLc/5WQcSDZFEu0dIb8/3XvId7jc42BIVmS
         bV/oi4COn5VJg==
Received: by mail-pf1-f199.google.com with SMTP id d5-20020a62f805000000b0050566b4f4c0so2279793pfh.11
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 20:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2f878bmi4JxnBjaZ2FfqMVkNzpe8ionbFp3Pao0b0Yg=;
        b=3O2lYRulIH98vUlTOHJ1NdsHPxp9TNJa53MHTLjDbeps9c0lQyb90kE1alI/EEjoq5
         620AhyT34iGt0BD3X5ds+BIX7nWRHKAjSSqb9MG89EK+OTmMT0xu+CcEBpLlbwbeopXZ
         QAupQIhyfUnLCAO1g28Ja3WwcTVL5V6aI2U/aK5JRZizMCWQ5t198WvJlyAlnf6o/eFC
         ygc9c34uwa/yeT7ZjjN27bzRv1raf9hdu53ReEzU2g4Z60o7f+JifJrXnPkoKXvDMeHk
         dUgZco2E3xjCIt86zIHUPLhA3TpvI6jL9h4QCPZPBuuvwx0oUjZDAkHDY9RSe/UFy3D6
         l/Wg==
X-Gm-Message-State: AOAM533CcPrn+ZXBmiINgU6MzgR3OL+fXpWR8Jry1w/xsyCCRRylaGIl
        Dnua30ssAPA7DslHvOjuS5dObA300ru90CyKhgEkM90pEmRwSRt6BHEe8AlEV1LiulEMgtwpWrv
        okIsmEoWhg0Ae6QCSGTaXGSobx4khPK/bml0juAUZ+ssJ
X-Received: by 2002:a17:90a:8c8e:b0:1c9:c81d:9e13 with SMTP id b14-20020a17090a8c8e00b001c9c81d9e13mr7941075pjo.123.1650512746414;
        Wed, 20 Apr 2022 20:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Xp7HQ6Hs/QOzCyci14ZeH/ae1kO7dg80oIteJcz1hnJ1eoV7qtQLGtxFhiyFZHZ0jvRrqw==
X-Received: by 2002:a17:90a:8c8e:b0:1c9:c81d:9e13 with SMTP id b14-20020a17090a8c8e00b001c9c81d9e13mr7941047pjo.123.1650512746077;
        Wed, 20 Apr 2022 20:45:46 -0700 (PDT)
Received: from [192.168.0.18] (59-115-201-204.dynamic-ip.hinet.net. [59.115.201.204])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a7e8100b001d2edf4b513sm697253pjl.56.2022.04.20.20.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 20:45:45 -0700 (PDT)
Message-ID: <aef304a3-beab-71f4-7967-a8a5fa8e1371@canonical.com>
Date:   Thu, 21 Apr 2022 11:45:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] rtw88: pci: 8821c: Disable 21ce completion timeout
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, tony0620emma@gmail.com,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, phhuang@realtek.com
References: <20220420093058.31646-1-pkshih@realtek.com>
 <20220420093058.31646-2-pkshih@realtek.com>
From:   Chris Chiu <chris.chiu@canonical.com>
In-Reply-To: <20220420093058.31646-2-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2022/4/20 17:30, Ping-Ke Shih wrote:
> From: Po-Hao Huang <phhuang@realtek.com>
>
> Disable this capability to avoid timeout errors on certain platforms.
> Without it, pci bus might stuck and leads to disconnection.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---

Tested-by: Chris Chiu <chris.chiu@canonical.com>

>   drivers/net/wireless/realtek/rtw88/pci.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> index 33042b63a151e..3ef0de70af328 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -1482,12 +1482,15 @@ static void rtw_pci_interface_cfg(struct rtw_dev *rtwdev)
>   
>   static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
>   {
> +	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
>   	struct rtw_chip_info *chip = rtwdev->chip;
> +	struct pci_dev *pdev = rtwpci->pdev;
>   	const struct rtw_intf_phy_para *para;
>   	u16 cut;
>   	u16 value;
>   	u16 offset;
>   	int i;
> +	int ret;
>   
>   	cut = BIT(0) << rtwdev->hal.cut_version;
>   
> @@ -1520,6 +1523,15 @@ static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
>   	}
>   
>   	rtw_pci_link_cfg(rtwdev);
> +
> +	/* Disable 8821ce completion timeout by default */
> +	if (chip->id == RTW_CHIP_TYPE_8821C) {
> +		ret = pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
> +					       PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
> +		if (ret)
> +			rtw_err(rtwdev, "failed to set PCI cap, ret = %d\n",
> +				ret);
> +	}
>   }
>   
>   static int __maybe_unused rtw_pci_suspend(struct device *dev)
