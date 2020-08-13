Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7434124406F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 23:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMVan (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 17:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 17:30:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EEDC061757
        for <linux-wireless@vger.kernel.org>; Thu, 13 Aug 2020 14:30:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so7767912ljg.13
        for <linux-wireless@vger.kernel.org>; Thu, 13 Aug 2020 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=//FEs9ogX61SCfZ2UB23DAWGzJP9ukCu9JfAdB6kn/k=;
        b=BJzwsWPBfWvcNkjM4HDGXEAnSDX6aRjcdCMWnh+p1tjAlaBMo/eBfR2pr5Ct6WzMYg
         JZ/bUabIDzkIQFawCNdpPH2eddjpcxpDIvI2iO1Gz5ThkOoLu2RqFDzYs90bEQTO1SHB
         KDqzv/lsBlIgbKcB4Q636zKebPkawu5k3WuDV8b9zIzX9FAKyaUAoksZA5oSGZjOU5WC
         h3w3dGcwmclloMuo5tPL/S4r+8gQMNscJvP/bjKp2QsxLITp0ZSbpLAxFFAqsf21Ait8
         tMgLkvlZJ8D3JxGRgFpuThqf+B9SCo8SQFHPUxRmP9B2yDTwzJc37PoQYwKpVldcDPSz
         yt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//FEs9ogX61SCfZ2UB23DAWGzJP9ukCu9JfAdB6kn/k=;
        b=EiEgtgjDJRbiHOxe9mYfTtJgABxst2lv8oyiL3LzmkOyfPC3/sqJycNVK0Y+AbUISw
         1rUmQGhbLbP+LrxPR4jma760jAKiwAjrYhw5XzogD1CgJKdCWn19Lz0rkGjKYQdk9S12
         iOwb1UwNZ7ldrj3bBGlRfSxfQpeUU7e0+OgizRPRWikzXEkJElyq0ArRmHwOz5gvsaoh
         bHSJxD9eBvr5Wv35uIl1nPR3SjDPGpfVs1eBdi4r1OZcPDjB+bj6taUNw83SPVJ2qvXE
         1q0g8RSVA/ou2t9BPFrHEOfYWXWowftiaSvbL6FEwr3M91yywLhRs5oIIiszBpnV1PYL
         181A==
X-Gm-Message-State: AOAM530AgJ+dq9woBCH68HVeEXq+/m/9RqRq0aO/TtjO2B2XaN6dyNE9
        YJD02FwNR1Uq6qNkhaeA0vcBny7j
X-Google-Smtp-Source: ABdhPJwVjZpbFTDcPQyZk95TknActODkkSiIPPSn0iEM0ZUKa6igPBezeRkCIZ1pSpVbghSs9V1Mrw==
X-Received: by 2002:a05:651c:2004:: with SMTP id s4mr2738512ljo.89.1597354238827;
        Thu, 13 Aug 2020 14:30:38 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id o24sm1331311ljg.69.2020.08.13.14.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 14:30:38 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control
 path
To:     Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-4-chi-hsien.lin@cypress.com>
 <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
 <875z9yr7lg.fsf@codeaurora.org>
 <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com>
 <87a6zapbqp.fsf@codeaurora.org>
 <0923f45f-03e3-a870-3d2a-35f982482e1a@cypress.com>
 <bed18d45-6119-53da-2b9c-d98d121c8298@gmail.com>
 <a7aaf6ac-d6df-ab57-4939-474b542f007c@cypress.com>
 <112956e1-df38-0a35-c2f0-8d9e1568d3c5@gmail.com>
 <725e7a73-6cbf-227e-58ea-2457179a5063@cypress.com>
 <df1c734c-ef7c-19ae-fad0-a5db148e5220@gmail.com>
 <8edbb3bb-a28b-6dae-1318-68c4b0478ad7@cypress.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f4031cd9-edf8-9c7a-90fa-95cac370a656@gmail.com>
Date:   Fri, 14 Aug 2020 00:30:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8edbb3bb-a28b-6dae-1318-68c4b0478ad7@cypress.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

13.08.2020 06:03, Wright Feng пишет:
..
>> Wright, thank you very much for the patch! It fixes the problem!
>>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>
>> The 4329/3 is indeed an older chip, but it's also an "old" device (Acer
>> A500 tablet from 2011/12) that I'm using. Upstream v5.9 kernel just got
>> support for the A500. There are quite a lot of other older devices with
>> 4329/3 in a wild that are still very usable if user can wipe off ancient
>> Android and put a modern Linux distro on them. Today that A500 tablet is
>> still rocking hard running a modern upstream kernel, opensource drivers
>> and KDE Plasma 5. The 15Mbit is a good enough speed for a lot of things,
>> but of course 40Mbit will be better. Would be great if you could try to
>> help with improving the speed :) Please feel free to contact me at any
>> time if you'll have patches to try!
>>
> Dmitry,
> Thanks for the verification. The patch will be submitted to upstream
> within two days.
> And with regards to low THP problem on Acer A500 tablet, I will create
> another mail thread to discuss with you.

Thank you!
