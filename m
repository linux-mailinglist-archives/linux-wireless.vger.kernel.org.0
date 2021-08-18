Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2F3EF9B7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 06:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhHREyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 00:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbhHREyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 00:54:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE7C061764
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 21:53:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso1545889pjb.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 21:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=P8U5WQJiAdYfDNducQrear0igBlA30OMY5Q6FHihzPA=;
        b=ten3Nzn9bTxm+RZ1riVNtCnANcwueAyOjVPAevqD4tvzbLjiIDm2RwGB1tOE9ipsB1
         mAz8xgA/7RhW8/lZWpbmpnfHFCrFofOAHe/Rs6mUDn8AH7KnyMAXl3wKudSweJhWthFT
         +XaQmKiMqsGcY2a+a0YObotm7delpJ3oElQHqBBXxen2R96/g+y3L/cDiHJ6qV9o54UM
         RvxsoCrk/SXssi9JEmbeMv5/SVdlvEmPgs3fue9kTnarqjQJMibOZqgX6vN72SCEl2AQ
         JmeX8Oplk1DZ1d4VoOsYilh5m+yyc63QeHH8gFIyRwDAFaf+3aXyo45xclFmVOesZJPh
         GgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=P8U5WQJiAdYfDNducQrear0igBlA30OMY5Q6FHihzPA=;
        b=WWWKyiryHjTXBWVirOW0D6ODKJGD11DIPD962ZaO4ZU/1LfZ69RAdL6g7cLug33rPn
         eG/y1ySyM/G2JOq9WfvSLKq6YX3qTtv9fAlL48hHWgbkSx4bU1Ql0Thv+XWCC6e2/Ymj
         ri+JuvTlRMOqxYA7SBewsKYqSLjLnq903Vsyo/SH8MhvHkT1bznnc3PmbXBfcchJqPKh
         76ZCPQgYojvHknj6XIGWoLWnaAZH5qCH8NAPFSEsTPHAMurO375VbaPlvjJf8rIZOdSU
         YNbErcyipLviRE85s6xYOhbfSSh8jbMIMmXv7w43Qr4+YKNnMuyFpKJ6QUOinZYVr9T7
         oFkw==
X-Gm-Message-State: AOAM530HTMoh7G0wFCU4fLl5VdPIM3TuENdZNFYE+8OwnTdLeJIIGvL4
        HgeVj4WWlH1Utoj2cO2ocvk=
X-Google-Smtp-Source: ABdhPJwyF5cy06UYaCF8+k2ff5a+4+qHBYkQZOXF2SCVmASlIMtbr/PD5eDLoOS3FEGgDLpM9Sbp2g==
X-Received: by 2002:a17:902:cec3:b0:12d:92c4:1ea6 with SMTP id d3-20020a170902cec300b0012d92c41ea6mr5653088plg.36.1629262421317;
        Tue, 17 Aug 2021 21:53:41 -0700 (PDT)
Received: from [10.230.42.144] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id w11sm4952030pgk.34.2021.08.17.21.53.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 21:53:40 -0700 (PDT)
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
Date:   Wed, 18 Aug 2021 06:53:31 +0200
Message-ID: <17b579b74f8.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <20210802170904.3116223-1-sean.anderson@seco.com>
References: <20210802170904.3116223-1-sean.anderson@seco.com>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: [PATCH] brcmfmac: Set SDIO workqueue as WQ_HIGHPRI
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 2, 2021 7:11:12 PM Sean Anderson <sean.anderson@seco.com> wrote:

> This puts tasks submitted to the SDIO workqueue at the head of the queue
> and runs them immediately. This gets higher RX throughput with the SDIO
> bus.
>
> This was originally submitted as [1]. The original author Wright Feng
> reports
>
>> throughput result with 43455(11ac) on 1 core 1.6 Ghz platform is
>> Without WQ_HIGGPRI TX/RX: 293/301 (mbps)
>> With    WQ_HIGHPRI TX/RX: 293/321 (mbps)
>
> I tested this with a 43364(11bgn) on a 1 core 800 MHz platform and got
>    Without WQ_HIGHPRI TX/RX: 16/19 (Mbits/sec)
>    With    WQ_HIGHPRI TX/RX: 24/20 (MBits/sec)
>
> [1] 
> https://lore.kernel.org/linux-wireless/1584604406-15452-4-git-send-email-wright.feng@cypress.com/

Not sure if Wright Feng needs to be attributed as you clearly had a good 
look at his patch and the discussion related to it. You can add my ...

Reviewed-by: Arend van Spriel <aspriel@gmail.com>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)


