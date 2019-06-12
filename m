Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566D242394
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407589AbfFLLLv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 07:11:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43528 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406968AbfFLLLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 07:11:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so6335419wru.10
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 04:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T0cZTEnUTvGGmjw5I8Wkm+xAGTXLp41aRjblrVtvO6s=;
        b=JyatqGuFCTR9C17AwuSyJvET6Y0x6fp6Y5k8x7KKvWEwZhzRSKNY+9DIRrM50+Om9Y
         WpMMP16n48yJ+G5mLjaHbe+AIIJrqRHDZXPYuhpIcfm1VjzPpUdxicueI0SOyL4HBkMt
         3SOxQGDCQ/d0QJLUjQzOMtTSC6rQvOi7rCp94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T0cZTEnUTvGGmjw5I8Wkm+xAGTXLp41aRjblrVtvO6s=;
        b=YMNKJcLDJgutnkYC8LQyKb8v0QbrLKhH1OvB4CFokIVGUai0aYVaAPJS/wEeCrE49j
         xeJTm+RToQ8IzClCG+MRDc5LUIQ02YsXR015WGolm0qBZvnmfR7DCNhLqLJ9oxVj2Chf
         E1zRV0CYQnYcYa19tQngcM7CUFhBBD77Fikfuj4lPaHV55dpBYTmRM6RyQO8Nn+bq4DU
         fezTtsGuXHRFD6NRxs0ubZQMFuMOB6eiOl+EG0gClYC4sRzr0mBgkxp8GlEaAxTXoD8J
         ZHe4aA8kNa6eHrsYpYe10vhPWpn2pq4cx1T+VSNjwbGO+m29Jdbb6Ijeye5ieAka6DGQ
         sIdg==
X-Gm-Message-State: APjAAAWtU/pAzfjuqOHybNpc+nPShSSeMObmVNvZZ7pixlWKEG+ZWxe3
        d64Uj/hLsEanFbNgDkfuMpYbiA==
X-Google-Smtp-Source: APXvYqz8aasOCe6ye7E5FfdTBcDAkR84x/KcKfNBPauTc6i9sI0Ku3jNcSHbU+R9NjuSPf/RBBPEVA==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr40008967wrq.333.1560337909649;
        Wed, 12 Jun 2019 04:11:49 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 5sm5337449wmg.7.2019.06.12.04.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 04:11:48 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] brcmfmac: sdio: Disable auto-tuning around
 commands expected to fail
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        "mka@chromium.org" <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20190607223716.119277-1-dianders@chromium.org>
 <20190607223716.119277-4-dianders@chromium.org>
 <363DA0ED52042842948283D2FC38E4649C52F8A0@IRSMSX106.ger.corp.intel.com>
 <CAD=FV=U8eo78Ee9xjhGXJMv=8YF9o89KLX024GH3iBRnRjCRvQ@mail.gmail.com>
 <CAPDyKFo=QMRTkNYUVSE2AqiZgytkTVRXF0Mvznn6trVT4-cR=Q@mail.gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <c7c6d3f4-ebb1-8964-0616-973fae1ab47d@broadcom.com>
Date:   Wed, 12 Jun 2019 13:11:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo=QMRTkNYUVSE2AqiZgytkTVRXF0Mvznn6trVT4-cR=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/12/2019 12:10 PM, Ulf Hansson wrote:
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:
>>    mmc_set_data_timeout(md, func->card);
>>    mmc_wait_for_req(func->card->host, mr);
> These are not okay, none of these things calls should really be done
> from an SDIO func driver.
> 
> It tells me that the func driver is a doing workaround for something
> that should be managed in a common way.

We are using some low-level functions passing chain of skbuff to the 
device using CMD53 with scatterlist. If I recall correctly Marvell made 
an attempt to have a similar function for it in the mmc stack. Not sure 
if that ever made it in. If so I can rework our driver using that API. 
If not, I can make a new attempt.

Regards,
Arend
