Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673373903B7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhEYOSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 10:18:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53004 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbhEYOST (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 10:18:19 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llXrS-0000az-RF
        for linux-wireless@vger.kernel.org; Tue, 25 May 2021 14:16:47 +0000
Received: by mail-vs1-f72.google.com with SMTP id v15-20020a67c00f0000b029023607a23f3dso12623415vsi.10
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 07:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CEFj1RvEdb/WJRzoXO6FeLVMZWd50iSXAawAzIpq6pM=;
        b=pLTfTBKzU5aPGQayRf03mvj77HqPmho2VfGmK10DLHOXib2Q5ApezTKegSTm41Ci17
         PkU7QRjxnail6QCSBuCjAM0xOxwP83QRT0vxDV++2r+NAN+H4BKJY+F8DwCXFyXcrQSY
         J58yFf4aFmOHfCFUFY8+UGkqH2c+bKuMNyxdavfWeZljtuvGd7Vh8RMWAbVMsorh9rV9
         itCumXY/dxcspKcvVC0FB9I9lhUo5Cq4rHoAmCAFiR+6x/dkHbjr1MUrNYn/uWMW7OgC
         IKEVJojGwVgGGKHPdXUZMDhcZGgXdVbeKPtqfUC1GicVLq8568RBShSMZ5lAJlgcUa9m
         L5OA==
X-Gm-Message-State: AOAM532/bcTCP8FzN1rEbIT6XY7gsJIzhzOqcBsIgoL0ge4IO0SEyuIh
        XSgjW7B9QPQ2Myq2Tuh/FMoOvt9bH6fsNa4pXuRO3BffplRPTGBLmrHnBAMSDyklbbozXTkc3E/
        tI954XXOm77+uIpQvzjxgJvpTI8snUS7y1XjbOtY2O2Cu
X-Received: by 2002:ab0:778c:: with SMTP id x12mr11204818uar.88.1621952205937;
        Tue, 25 May 2021 07:16:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGfLbNM1XKLM9CsGz7reNvREjkXh2l7hNJj0Pm2hGhox76uNxcWs9cOdYZhobM7V1TkjbWpQ==
X-Received: by 2002:ab0:778c:: with SMTP id x12mr11204793uar.88.1621952205824;
        Tue, 25 May 2021 07:16:45 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id s11sm1572166vsi.27.2021.05.25.07.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 07:16:45 -0700 (PDT)
Subject: Re: [PATCH] iwlwifi: add new pci id for 6235
To:     Alex Hung <alex.hung@canonical.com>, luciano.coelho@intel.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        matti.gottlieb@intel.com, ihab.zhaika@intel.com,
        johannes.berg@intel.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20210322071121.265584-1-alex.hung@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e51b79ff-74fb-966a-cc5e-45b50bc19f04@canonical.com>
Date:   Tue, 25 May 2021 10:16:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322071121.265584-1-alex.hung@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/03/2021 03:11, Alex Hung wrote:
> lspci output:
> Network controller [0280]: Intel Corporation Centrino Advanced-N6235
>  [8086:088f] (rev 24)
>  Subsystem: Intel Corporation Centrino Advanced-N 6235 [8086:526a]
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
