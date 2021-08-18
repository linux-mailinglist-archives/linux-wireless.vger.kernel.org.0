Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD73F0A4C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhHRRbU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhHRRbO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 13:31:14 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959CFC061764
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 10:30:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u25so4412555oiv.5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X1JvNj6TPH+OCZuoL+69d7aXsqVTanSmq4nlChB91RM=;
        b=UfclXNE6fS2NX0zaGPyHaQ9Sf51yRwlF1tIwR0Nlt7IrrO8SDVjg6xc4bfNPGdnGJL
         rG2kvtG5zfJgWqRJGgUr7iIkkC/97HU/n2ou4jDX4Z4lzRDeylPLrCvmuUFF43PVzEUS
         JgU/6dhsSBUgN3Dzg4wAy6HOVxpzz0G1c/Kp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X1JvNj6TPH+OCZuoL+69d7aXsqVTanSmq4nlChB91RM=;
        b=dscteOkIqehRG/YVgkCTU1MDlbgOXBw3F629swLtagVOOFMN8owzXO99DNOzk1whuC
         zGvpYmo3V6wsi4+px97Fnm9Zr9WjAmm8doiak9be1Zt/LjLAW3nxUF9b/JdSeRo6YE0j
         CEmpBa4DKItvKxwtpPmPi7iTGwvRsdb4M8q4E/IY8BMtjFNuk/8hcgiTCbB4gm99AyQ1
         hXNrGsV0t2WXxRJhV2bGSlADiZQa+8YxYHTtQmkHq4ZODq9D7IrbN/U3ZQw33+krsu9r
         wZFWETSizxpSzmpIi75VXyuzGCHE3ibXd29ertcJ8BsroOwQaDHKsHIAMiRGnyegBS+z
         ECng==
X-Gm-Message-State: AOAM5304msGSh1BonHlrRBYe1g/6Xr7WikW1uZSEf0r7sES/hPf04baG
        IModbsNiJK/4PbSrSmLF8UCYoA==
X-Google-Smtp-Source: ABdhPJxcxzje4axs4isWBNvSoYF1FO1zc5wsEp46nT2W663U4WNanGxKa8wkDVSmcAAWpvRqcj6/Iw==
X-Received: by 2002:aca:b608:: with SMTP id g8mr7959112oif.66.1629307837970;
        Wed, 18 Aug 2021 10:30:37 -0700 (PDT)
Received: from ?IPv6:2600:1700:38c5:675f:4c90:f673:77ac:78b3? ([2600:1700:38c5:675f:4c90:f673:77ac:78b3])
        by smtp.gmail.com with ESMTPSA id c16sm124828otp.59.2021.08.18.10.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 10:30:37 -0700 (PDT)
Subject: Re: [PATCH] ath10k: Do not call dma_alloc_coherent() for SDIO and USB
To:     Arend van Spriel <aspriel@gmail.com>,
        Fabio Estevam <festevam@denx.de>, kvalo@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        hch@lst.de, erik.stromdahl@gmail.com
References: <20210818150943.1630199-1-festevam@denx.de>
 <17b5a29d098.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <369c1f89-df33-455b-773e-a2e0dbf582ff@eero.com>
Date:   Wed, 18 Aug 2021 10:30:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <17b5a29d098.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>> Fix the problem by not calling dma_alloc_coherent() when the device
>> is not DMA capable, such as SDIO and USB.
>>
ath10k calls dma_alloc_coherent multiple places including 
ath10k_htt_rx_alloc.

Do SDIO and USB not use such data path function at all?

Thanks,

Peter

