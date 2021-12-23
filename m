Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5F47DE36
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 05:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbhLWELV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 23:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346298AbhLWELS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 23:11:18 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C6BC061574
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 20:11:18 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j13so3378223plx.4
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=35lwvniqTSHSwmJi+0cDX/Xir/6t9JTkCVMcqbEH+ko=;
        b=Ng9G7Iy9ZBkiolC2QZHTzNJRqzos1cdxfMK1DbiQpi9ck06JSW0Auc311tgzpAnBMo
         l8sd8t/B2aUAhXCw3cYx0B082pmV05H4QIQ7tih+wm9erq01ua8vIk8qoQZBl+z3L6et
         6jLvZHs7NhTL8lykG5jCks2iZV0knty4Kolzv9yOjgqwvTEbhINoNpurbnkDDOFj/pl2
         b699WJNdweQNp4EUYehx40H8Flf88qk0ss855rtOtdHUtgJNpZqwKSx+6I0tdtGx6jLq
         IxwaKwfHzmdmOpjT256PTwLbN/7xsLDLS6pbPjNDo3Swphe93xS++1BNb+NpM6wGxrql
         Ejrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=35lwvniqTSHSwmJi+0cDX/Xir/6t9JTkCVMcqbEH+ko=;
        b=edALRthQDfFBWMhsjZVB6em7U4jQPFp5Pca/+gi3AROTYO3fpQkE70OPYAiSVrbGU9
         rDspk7qr7FwoSzSw5xclfLWcS+Qq+yewD7GAjTz4eb3kt+fHg9Q+eSEwEHoRzJQQ/wbp
         AQ9JwvxK0HVwBc0TBmXNWpGqjnkETn2A6dHLcxiy+lkBbYJOz0odsx3eRHme9aBPQnQt
         A77DmW+JPOJ5kizTgRfXJn38cfvAm8K54SCr0EVlAwloh3eGfZpazKOjYLgC2zJDHlhj
         Za+r5t6nH7+mKNvdUjdY5B7aoOrvkkK6C2oN3jlyn954aI+ELw1vxVSm7OpP7obqy15S
         jTXA==
X-Gm-Message-State: AOAM5306ruzICVQQ+30r9UoXA1JlihTKByPJyqjuB95a3IlNhbeOCWk/
        78lr7C6dPI58F+XaLZckanVAQ8IRzpE=
X-Google-Smtp-Source: ABdhPJyBtLX8W564hJetGV9geIoumIqzugxSruDs+fXhjBNg3MwlDkFJTlp0GzWGyG4MJ6Mm2ThvpQ==
X-Received: by 2002:a17:90b:4d91:: with SMTP id oj17mr1054395pjb.224.1640232677529;
        Wed, 22 Dec 2021 20:11:17 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id b15sm4405845pfl.118.2021.12.22.20.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 20:11:17 -0800 (PST)
Message-ID: <2f6de5b7-65ac-ee6a-e0ef-4635f1808379@gmail.com>
Date:   Wed, 22 Dec 2021 20:11:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH wireless-drivers-next] bcma: get SoC device struct & copy
 its DMA params to the subdevices
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20190121101121.24555-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20190121101121.24555-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/21/2019 2:11 AM, RafaB MiBecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> For bus devices to be fully usable it's required to set their DMA
> parameters.
> 
> For years it has been missing and remained unnoticed because of
> mips_dma_alloc_coherent() silently handling the empty coherent_dma_mask.
> Kernel 4.19 came with a lot of DMA changes and caused a regression on
> the bcm47xx. Starting with the commit f8c55dc6e828 ("MIPS: use generic
> dma noncoherent ops for simple noncoherent platforms") DMA coherent
> allocations just fail. Example:
> [    1.114914] bgmac_bcma bcma0:2: Allocation of TX ring 0x200 failed
> [    1.121215] bgmac_bcma bcma0:2: Unable to alloc memory for DMA
> [    1.127626] bgmac_bcma: probe of bcma0:2 failed with error -12
> [    1.133838] bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
> 
> This change fixes above regression in addition to the MIPS bcm47xx
> commit 321c46b91550 ("MIPS: BCM47XX: Setup struct device for the SoC").
> 
> It also fixes another *old* GPIO regression caused by a parent pointing
> to the NULL:
> [    0.157054] missing gpiochip .dev parent pointer
> [    0.157287] bcma: bus0: Error registering GPIO driver: -22
> introduced by the commit 74f4e0cc6108 ("bcma: switch GPIO portions to
> use GPIOLIB_IRQCHIP").
> 
> Fixes: f8c55dc6e828 ("MIPS: use generic dma noncoherent ops for simple noncoherent platforms")
> Fixes: 74f4e0cc6108 ("bcma: switch GPIO portions to use GPIOLIB_IRQCHIP")
> Cc: linux-mips@linux-mips.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> While this patch is a regression fix, it depends on a change present in
> the wireless-drivers-next.git:
> bcma: keep a direct pointer to the struct device

Rafal, there was supposed to be a v2, but I could not find one, this is 
the regression that prevented bgmac_bcma from loading while testing 
upstream, did you have a v2 ready already to be submitted somehow?

Thanks!
-- 
Florian
