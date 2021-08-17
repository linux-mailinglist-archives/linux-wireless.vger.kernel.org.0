Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A8D3EF0B4
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhHQRRr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHQRRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 13:17:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D81C061764
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 10:17:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mq3so116436pjb.5
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=2Uji9oqOWlvOMWSmAKMCEr7JPSVItGhDMTK0V3Fedos=;
        b=ksSvF4uxgt39L2M6MpuQG/AKy0dEOAvpDbuyao8FFL3qCBzy7qL3rHeeLztKYi/rjc
         xbP/1lzfoLr7EJHMBdlxwQbr/gobovvNmE62Ldeo3K7bJD+J3BY8kbve9A1A5bElaJ2U
         O7xtJibzdmLtUFmYu/1WC6JW0qSS3NKfVid4wZh/uXR4FKaL9lURC+e4OYJuuSJ0m8hC
         nwZGHRMJc2J6urlnD5J5bWAUXQu0f31L2lljBMA55bgd2JSlAdmhOHVdIBrRtbAI3WxN
         27CHQhoEISTP1jMcatx9rxecxuS7sU8IfM1p79j2eymTGvBfmGH1D45QeWhiQFA+z9DB
         Y9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=2Uji9oqOWlvOMWSmAKMCEr7JPSVItGhDMTK0V3Fedos=;
        b=tM2ERXdFHNElSwNJihp7TvBTs3QQC5AkwobFocAXFNvdACQR+ZK/rslTMZSov7tadm
         /nKaL2z2UarYXNp+PvODEW2vturAOe+fsGtzOwIN7vkruO4ErCdkKmOZjYUdWJ7hM0I+
         cxalc99ms9kCmT2UjFRx2n07FLnfwA5ImXQVY4PbsLE+oCki2WRd8bI/TL6WPzmoka6m
         4I/Bx92rrE0JTw4TVgQgPCl836CjYKPNZRXXG603oklfQ6gMm9wJDxW+5FS0MA6A6nQN
         TrcapPk8LIKUEboQOOdE4gdxolFB/cxStkkP9VoR/NVOzptOaxvpTrjQiX8saS08a7Zc
         g+uw==
X-Gm-Message-State: AOAM531W41cB0j52ew5t08iigMGbx0EEvDVGnNsU07FHcyVW2rJOElqo
        1V8IKJiZJbtFcF0tNrZ6RojVAW6SVpOo/OXHgGW/Yg==
X-Google-Smtp-Source: ABdhPJzRUznHbL6LU5nVCwSbg99rGQL+IoF5yLGkBAXZsEq89vNrWYq2GMb9zuuOjxqOu1T/+ro3Wg==
X-Received: by 2002:aa7:8605:0:b0:3e2:89c2:7fa0 with SMTP id p5-20020aa78605000000b003e289c27fa0mr3624713pfn.8.1629220633183;
        Tue, 17 Aug 2021 10:17:13 -0700 (PDT)
Received: from [10.230.42.144] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id l6sm3263468pff.74.2021.08.17.10.17.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 10:17:12 -0700 (PDT)
From:   Arend van Spriel <aspriel@gmail.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@codeaurora.org>
CC:     "Chi-hsien Lin" <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Tejun Heo <tj@kernel.org>, <SHA-cyfmac-dev-list@infineon.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        <brcm80211-dev-list.pdl@broadcom.com>
Date:   Tue, 17 Aug 2021 19:17:00 +0200
Message-ID: <17b551dc6e0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <e6eb89af-b81e-b96e-70a6-c9498eb681fd@seco.com>
References: <20210802170904.3116223-1-sean.anderson@seco.com>
 <e6eb89af-b81e-b96e-70a6-c9498eb681fd@seco.com>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: [PATCH] brcmfmac: Set SDIO workqueue as WQ_HIGHPRI
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 17, 2021 6:50:50 PM Sean Anderson <sean.anderson@seco.com> wrote:

> ping?

Good idea to ping with a top-level post :-p

>
>
> On 8/2/21 1:09 PM, Sean Anderson wrote:
>> This puts tasks submitted to the SDIO workqueue at the head of the queue
>> and runs them immediately. This gets higher RX throughput with the SDIO
>> bus.
>>
>> This was originally submitted as [1]. The original author Wright Feng
>> reports
>>
>>> throughput result with 43455(11ac) on 1 core 1.6 Ghz platform is
>>> Without WQ_HIGGPRI TX/RX: 293/301 (mbps)
>>> With    WQ_HIGHPRI TX/RX: 293/321 (mbps)
>>
>> I tested this with a 43364(11bgn) on a 1 core 800 MHz platform and got
>> Without WQ_HIGHPRI TX/RX: 16/19 (Mbits/sec)
>> With    WQ_HIGHPRI TX/RX: 24/20 (MBits/sec)
>>
>> [1] 
>> https://lore.kernel.org/linux-wireless/1584604406-15452-4-git-send-email-wright.feng@cypress.com/

While I understand the obvious gain it seems like a wrong move to me. What 
if all workqueues in the kernel would start using this flag? I bet the gain 
above would be negated and all are equal in the eyes of .. the kernel

Regards,
Arend


