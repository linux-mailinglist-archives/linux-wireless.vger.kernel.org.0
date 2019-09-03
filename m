Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F82A7315
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 21:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfICTET (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 15:04:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36291 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICTET (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 15:04:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so18642282wrd.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2019 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wfwp3JK+FPjZ49iIiXdsjhZE22cfwM/PxcQ51JFeaMo=;
        b=U8A96VQ0Ael09tyqVquKZuiyzbCqJGfqEcrt8YSzMcaSklscBid+qPJzcAKvqyrpdV
         SBpLfDBFCpOIBaC4Of4w8+2aYkf7jGIZ39VOa8M2sr61Ekl9hN7lQRsegOrgpJjGleIF
         16t10MI3BD90+ucSIbuPenVTvg4SJgrIwetwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wfwp3JK+FPjZ49iIiXdsjhZE22cfwM/PxcQ51JFeaMo=;
        b=JnXhGfxLn0TDCsXIAfnGYY0K9QI2u8JlEGWcLYfY0RRU31Dtm6oy0ClKF3ynDCL0ct
         W+8iisMsLDlYhu75n/ivN3+89zZwLKajFL42mrv9MpbWNH5jWikRvuJ82LEAJ5s33dsl
         1ElTyz14gP9mizIhoGHPVX9DIU1mnC6OWcbbSWfTQ5ELPdaExVN+fCj6A/WcwC4uCXaT
         wnXqy34Cv/iqQSs2ifDZnxwU0OYvl70qWsa0lxzF39TB3olA0J/3omlrxkesXA29J7tw
         rqZopmi98MKPfnmQ2EKtpc967OicCrnjIGep/TcrhxKncl7Qvc0UKueiFdU0RZGteFUb
         05nA==
X-Gm-Message-State: APjAAAVaIHTnvjjDgHTbEoo4XHAMEfYbbjQmw8wa25XizjG6trghr4Tg
        obN3j7oN9s3G9SlQgx9d6r41ayKu1fb1dg==
X-Google-Smtp-Source: APXvYqxE2yFmxEbdrnN0qUuHOH8sRlCXy0e0dQRAkEMyRxyXNtJ9S0eMTuMxFZTAj4ZCGQNWFaoPIA==
X-Received: by 2002:adf:f543:: with SMTP id j3mr11678557wrp.243.1567537456840;
        Tue, 03 Sep 2019 12:04:16 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id o9sm13117503wrh.46.2019.09.03.12.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:04:16 -0700 (PDT)
Subject: Re: [PATCH 3/3] brcmfmac: don't realloc wiphy during PCIe reset
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190903042928.18621-1-zajec5@gmail.com>
 <20190903042928.18621-4-zajec5@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <bfeebb77-d79a-628e-7515-0a1205811fce@broadcom.com>
Date:   Tue, 3 Sep 2019 21:04:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903042928.18621-4-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/3/2019 6:29 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Providing a new wiphy on every PCIe reset was confusing and was causing
> configuration problems for some users (supplicant and authenticators).
> Sticking to the existing wiphy should make error recovery much simpler
> and more reliable.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
