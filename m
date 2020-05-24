Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB3D1DFF8C
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgEXO6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgEXO6k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 10:58:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BBFC061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 07:58:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bs4so13085091edb.6
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y/UicFuvpcY2Ut5syzHjsj0h3TJzVe57TFkzhdsHkh8=;
        b=d1dfEcltunn5RhfAUawB/4JI0nu1dXp5dzXUBXmljwODwCmVZwtomDVl1Jr75YB1nZ
         4D+gbqqpHycdhu1UPNO2n96mMxtlR1x7kLVwl6UsNrwCqtUzZPjljxxcexozUg8i84Un
         EEFFeEHVtHMgrXVkYFemsaFax32a55JVVxN2sOE9X7SVX/evzbwvOrJ1r8Z7V0GhAZ3P
         6lki8GnGpuiKJwK32AOW1C6BBfQ8WFPAdhiW1x8kcU0J7W/MBRMplBmsLKZf5FoGsAUR
         BXxeEyxdE5e07e1omfsOlc3BehPL9S38IBkzHDFhZhtgBRi5Rm1TQxuecTD6uUOeKHgv
         rucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y/UicFuvpcY2Ut5syzHjsj0h3TJzVe57TFkzhdsHkh8=;
        b=t5DGmplBd9kuBEu3HygJscR3MipRLxQQl2MGz626+oAMXbG3gFjFXd7AxGe0/0HMSD
         R0yr3dueDFyC5nbGIYIvkvx0refn35EbgL+5u5Sl93J794e2fdND/ase+4PM57Xu9HtQ
         HbDITHFIaI3D5xk5GsM0Vml/jepmNlgMJjly7SR99YjFPi5kawMsKF+hQF9MB2s1zpgj
         1W98W3zTFoBQB1vDMEEZUtlw7ZU4oxhIRNJAbnPnmdr2s0Bt0D7ng4WcPVO5MewJ1MWl
         Ki5VRw6rtaCE8afVdyJ17343pUM+5bhBbVuPCF23gt8hWHTjNltfrZRYnnH31C7qQ1BP
         ziPg==
X-Gm-Message-State: AOAM531XdF0GGZn4/yfoWPLf02J/FC3LwQdhXQC4GJqFpbrBjcawandM
        gi4R3bcJ6I0ocp4/UJGzgG8=
X-Google-Smtp-Source: ABdhPJxV5I05JjLMCJZtvjje4+KjsrSq4ae7bPqBHrYqC8pPbSZwnbGSRM1TAjY5x8h2HL+Z79PF6A==
X-Received: by 2002:a05:6402:2213:: with SMTP id cq19mr11355107edb.337.1590332318660;
        Sun, 24 May 2020 07:58:38 -0700 (PDT)
Received: from ?IPv6:2001:16b8:fd4:db00:2db8:f001:5e7a:1a? (200116b80fd4db002db8f0015e7a001a.dip.versatel-1u1.de. [2001:16b8:fd4:db00:2db8:f001:5e7a:1a])
        by smtp.gmail.com with ESMTPSA id d11sm1851565edp.26.2020.05.24.07.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 07:58:38 -0700 (PDT)
Subject: Re: [PATCH v2] mt76: mt7615: add support for MT7611N
To:     DENG Qingfang <dqfext@gmail.com>, linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, kvalo@codeaurora.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
        matthias.bgg@gmail.com, royluo@google.com, ryder.lee@mediatek.com
References: <20200524034110.22576-1-dqfext@gmail.com>
From:   Alexander Schlichte <schlichte.alexander@gmail.com>
Message-ID: <6a490b59-df37-b84b-9455-b9c2873b1f0f@gmail.com>
Date:   Sun, 24 May 2020 16:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200524034110.22576-1-dqfext@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Just some random drive-by nitpicks, so take it with a grain of salt.

On 24.05.20 05:41, DENG Qingfang wrote:
> MT7611N is basically the same as MT7615N, except it only supports 5GHz
> It is used by some TP-Link and Mercury wireless routers
>
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> ---
> v1 -> v2:
> make is_mt7615(&dev->mt76) return true for mt7611
>
>   drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 7 +++++++
>   drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 7 ++++++-
>   drivers/net/wireless/mediatek/mt76/mt7615/pci.c    | 1 +
>   3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> index 6a5ae047c63b..edac37e7847b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> @@ -111,6 +111,12 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
>   		return;
>   	}
>   
> +	if (is_mt7611(&dev->mt76)) {
> +		/* 5GHz only */
> +		dev->mt76.cap.has_5ghz = true;
> +		return;
> +	}
> +
>   	val = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_SEL,
>   			eeprom[MT_EE_WIFI_CONF]);
>   	switch (val) {
> @@ -310,6 +316,7 @@ static void mt7615_cal_free_data(struct mt7615_dev *dev)
>   		mt7622_apply_cal_free_data(dev);
>   		break;
>   	case 0x7615:
> +	case 0x7611:
>   		mt7615_apply_cal_free_data(dev);
>   		break;
>   	}

Maybe sort this alphabetically?
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> index ebdfca64b079..4ce8b379a147 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> @@ -411,7 +411,7 @@ static inline bool is_mt7622(struct mt76_dev *dev)
>   
>   static inline bool is_mt7615(struct mt76_dev *dev)
>   {
> -	return mt76_chip(dev) == 0x7615;
> +	return mt76_chip(dev) == 0x7615 || mt76_chip(dev) == 0x7611;
>   }

Now the function name is a bit confusing because you can't use it to
differentiate between 7611 and 7615. Would it be an option to give it a more
fitting name? Maybe `is_mt761x` or `is_mt7611_or_7615`?

Apart from that you might want to call `is_mt7611` here. That would avoid
duplicating the check and order these is_* functions alphabetically.
>   
>   static inline bool is_mt7663(struct mt76_dev *dev)
> @@ -419,6 +419,11 @@ static inline bool is_mt7663(struct mt76_dev *dev)
>   	return mt76_chip(dev) == 0x7663;
>   }
>   
> +static inline bool is_mt7611(struct mt76_dev *dev)
> +{
> +	return mt76_chip(dev) == 0x7611;
> +}
> +
>   static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
>   {
>   	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> index 88ff14564521..b09d08d0dac9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> @@ -14,6 +14,7 @@
>   static const struct pci_device_id mt7615_pci_device_table[] = {
>   	{ PCI_DEVICE(0x14c3, 0x7615) },
>   	{ PCI_DEVICE(0x14c3, 0x7663) },
> +	{ PCI_DEVICE(0x14c3, 0x7611) },
>   	{ },
>   };

Maybe keep this sorted alphabetically?
