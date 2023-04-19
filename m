Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7896E82CC
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjDSUfR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjDSUfQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 16:35:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B865B89
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 13:35:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-953343581a4so13396766b.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681936513; x=1684528513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLR0tk5vDHaSn0GfQde7FRG4eoSbdEvKW23EjYbw81Y=;
        b=lwxC/VeSwJiPvd0a113T5A68M3o8P6u/eq/yJ+X2jCcB0ZaeJqE3t4s4Pf8B2nvckL
         5xjyPPNctvy3EPJZfPAWV86je31/Hg8GkcWGwi8DXCoEGsA+EvBHcoy1IBFIPCBY5OkA
         DaixF76av4RzOv4pTz1m0mPLpVd7m9W5ET0P+PGVwASb+1zHVek7AVrDmhFbzMFDTcw4
         QSszuWChScnfAibc2BsLCWGIyjnYZgdTBG2dVmtQ0C1bBGePzEJ5PB52o8ik3e9tnDbM
         DVeMhv1c+druqSfAr5Dm5gug8OgTAM93YZtziJMEkD06yioTLPIsQ7RYATLzKzfVUlyy
         PVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681936513; x=1684528513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLR0tk5vDHaSn0GfQde7FRG4eoSbdEvKW23EjYbw81Y=;
        b=l56wcIxtzvDjAn0KbsBYrpwgcb7NRlp5F2xXlgnN/rUx3LIHfHjMM9AObPQlrLd6yx
         VKfyHJWaXGiyp/20d0uTwCQ5kX8IJ2H/EiUqFMB+8kW6SXyVc2brqYrBb/dkry3lVl/h
         K0LPtj7ODkXX07OJ4G/OypQ4GYTwpnHp3GClFtrhZd8wKczQHdPdfFuUOqnhmNw1mrmr
         M5Pbs0uWhrnTxxdkx3qIhskxHFl8VlFydcv+MrBXpxVJr37tPDNaxb1Vxc4nNPcZqQQA
         f/CMZEBIl33tFEL7ZexZRpo+0roDgvSZUg6E3iPJkiF4I7xJ4pgWDrl8TOmf+ZqjqgUX
         OKjw==
X-Gm-Message-State: AAQBX9eBXGrUzPphB4KXCECXB8f4esTLDqRW53nLRDMIJWK57fXEYu1Y
        xXH8wOYM4l+SrDDYnvOnmcWhC1hWhTQ=
X-Google-Smtp-Source: AKy350ZljyP12uU9C5xl2SQyhM+YooL4S+qvIOSdeb5MBOFkm8Pa6P1auZS3sGdUKn3z5y9SwkjZ4A==
X-Received: by 2002:aa7:dbc9:0:b0:504:a360:e611 with SMTP id v9-20020aa7dbc9000000b00504a360e611mr6373786edt.13.1681936513038;
        Wed, 19 Apr 2023 13:35:13 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402078f00b00505034c27b9sm8405502edy.28.2023.04.19.13.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 13:35:12 -0700 (PDT)
Message-ID: <002e3ba2-16c7-844c-14f4-d4c14dfedd34@gmail.com>
Date:   Wed, 19 Apr 2023 23:35:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20230419100145.159191-1-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/04/2023 13:01, Martin Kaistra wrote:
> This series intends to bring AP mode support to the rtl8xxxu driver,
> more specifically for the 8188f, because this is the HW I have.
> The work is based on the vendor driver as I do not have access to
> datasheets.
> 
> Also while doing some measurements with iperf3 to compare with the
> vendor driver, I saw, that TCP traffic from AP to STA is slower than in
> the vendor driver. For UDP it looks fine. I hope I can get some help to
> fix this.
> 
> * vendor driver:
> 
>   without 802.11n:
>     UDP (AP -> STA): 27 Mbits/sec
>     UDP (STA -> AP): 33 Mbits/sec
>     TCP (AP -> STA): 24 Mbits/sec
>     TCP (STA -> AP): 26 Mbits/sec
> 
>   with 802.11n:
>     UDP (AP -> STA): 51 Mbits/sec
>     UDP (STA -> AP): 35 Mbits/sec
>     TCP (AP -> STA): 40 Mbits/sec
>     TCP (STA -> AP): 36 Mbits/sec
> 
> * rtl8xxxu:
> 
>   without 802.11n:
>     UDP (AP -> STA): 25 Mbits/sec
>     UDP (STA -> AP): 31 Mbits/sec
>     TCP (AP -> STA):  3 Mbits/sec !
>     TCP (STA -> AP): 25 Mbits/sec
> 
>   with 802.11n:
>     UDP (AP -> STA): 41 Mbits/sec
>     UDP (STA -> AP): 36 Mbits/sec
>     TCP (AP -> STA):  3 Mbits/sec !
>     TCP (STA -> AP): 32 Mbits/sec
> 
> Thanks,
>   Martin
> 
> v2 changelog:
> - dropped RFC prefix
> - rebase patches to newest wireless-next
> - add some R-bs
> - new patch: "Add parameter force to rtl8xxxu_refresh_rate_mask"
> - new patch: "Remove usage of ieee80211_get_tx_rate()"
> - new patch: "Remove usage of tx_info->control.rates[0].flags"
> - new patch: "Set maximum number of supported stations"
> - add macro for broadcast/multicast frames macid
> - add more explanation about beacon queue in commit message of patch 2
> - add macros for bit definitions for beacon functions
> - implement enable_beacon = false case
> - fix beacon valid loop so that error condition is actually reached
> - add more explanation about setting mac address register in add_interface
>   in commit message of patch 6
> - rename role macros for connect report h2c
> - use bitmap for assigning macids
> - add helper function for looking up assigned macids
> - move patch 7 so we can use rtl8xxxu_get_macid helper
> - add sta_remove callback
> - do things in sta_add only in AP mode
> - use IEEE80211_TX_CTL_ASSIGN_SEQ flag to determine when to use HW sequence
>   numbers
> - add priv->vif null pointer check in configure_filter, rework setting
>   BSSID_BEACON/BSSID_MATCH in RCR
> 
> v1: https://lore.kernel.org/linux-wireless/20230322171905.492855-1-martin.kaistra@linutronix.de/
> 

The system didn't freeze with v2!

Also the download speed I got on the phone at speedtest.net
was around 35 megabits/second, which is normal. Did you test
v2 with iperf3?

I saw a few of these in the journal:

usb 1-2: rtl8xxxu_send_beacon_frame: Failed to read beacon valid bit

I'm not sure what caused that.
