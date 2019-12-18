Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87058125190
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 20:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLRTMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 14:12:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36994 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLRTMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 14:12:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id u17so3379606lja.4;
        Wed, 18 Dec 2019 11:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PUaCVt65eGbtZOQrA+QrYkS8a6/lLOGisIvBVA/ZJC0=;
        b=e5wQfexmU8qJfdDza+PnA1p/FWjmVF9ZYSkyWXOMvEDUedGuMMdY4Zpaf60SpcKALh
         LfrQSukE+CqeUl1wPp7RXz56dceESGiJoZAjJxj/tGlVv/+igQ523G5vM/H/CrhWNpTF
         F36r4pBD2CNSLclh0NCEJUEdRwQWveCdKg3Hxf1LYhycXT+luAa7mSC5y0x46TDC55qO
         nExSW/habOFwscnxqz8wVZa9LzSJYBCNKdRvyo0K7OPanok6oPhxNc88V66nUvTQU+Ku
         jYktcc3JPQTJrcUW131LkTm45dXgul0lvNLiW8uv88ZALoDGX3lOIDvr+Pj2PAl16HgV
         z5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PUaCVt65eGbtZOQrA+QrYkS8a6/lLOGisIvBVA/ZJC0=;
        b=q3wHa9XkLPw4pi1KhKDwtnvo7qTNiOgZDOEnhegjRXpMvKwhlmBAy14/sfBZsuuNiy
         f8YOoVJIiOanzH1ocYM48HNwVgyxoQV3pv2UivyxNqURdHQKUB6TlGBnm811NPpnIwrS
         2sTcf5H/bn3AmecTsTmRxvJymIJ3NUek6G9YcmCd+mYTAADuHda9GsXllLPiKHPZhqap
         fPDibd8EoIN84A+KCgD1YwXRGcETU2+IsdjtyfIkLSjZHI7FRSq/kZ08xdGx3PeylbNb
         v8bFvn56pQN4BrJe7nEOT3OFSrpi1Uz4nIDW+BOaFfk6ixdu6WofKHWg9tqmh4MY/Cp5
         bP8g==
X-Gm-Message-State: APjAAAVnQm+2kWScMgAT8CmtmOJzOk5oUWb9KtpB0VlH3YYjidtLnP/f
        apvSgCGnulnqzEW+EP3vuCLDteV/
X-Google-Smtp-Source: APXvYqw2y9P6Ouu8BJzJfFLZAORzaiRusYivNM0101yYJDujl7PAWWZoiDpwqyv9yeC/CoHLSEDUbA==
X-Received: by 2002:a2e:9b9a:: with SMTP id z26mr2964181lji.181.1576696319508;
        Wed, 18 Dec 2019 11:11:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id t6sm1609391ljj.62.2019.12.18.11.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:11:59 -0800 (PST)
Subject: Re: [PATCH v1] brcmfmac: Keep OOB wake-interrupt disabled when it
 shouldn't be enabled
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191215184224.11827-1-digetx@gmail.com>
 <20191218190920.C0B97C4479F@smtp.codeaurora.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9217d183-69ec-8be1-217e-0e4d67710743@gmail.com>
Date:   Wed, 18 Dec 2019 22:11:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218190920.C0B97C4479F@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

18.12.2019 22:09, Kalle Valo пишет:
> Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> NVIDIA Tegra SoCs do not like when OOB wake is enabled and WiFi interface
>> is in DOWN state during suspend. This results in a CPU hang on programming
>> OOB wake-up state of the GPIO controller during of system's suspend.
>>
>> The solution is trivial: don't enable wake for the OOB interrupt when it
>> should be disabled.
>>
>> This fixes hang on Tegra20 (Acer A500) and Tegra30 (Nexus 7) devices which
>> are using BCM4329 and BCM4330 WiFi chips respectively.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Patch applied to wireless-drivers-next.git, thanks.
> 
> a32de68edab7 brcmfmac: Keep OOB wake-interrupt disabled when it shouldn't be enabled
> 

Thank you very much!
