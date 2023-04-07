Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547E86DB356
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Apr 2023 20:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjDGSs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Apr 2023 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjDGSsS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Apr 2023 14:48:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F3CA09
        for <linux-wireless@vger.kernel.org>; Fri,  7 Apr 2023 11:47:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id kx12so1783953plb.12
        for <linux-wireless@vger.kernel.org>; Fri, 07 Apr 2023 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680893265;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMeiSNuKI6ZdRR8Umoqzj9UR8r3FyJDFU2fogvFEC5w=;
        b=ogILU0F6zo1DGDAnixSGBkWOWpqiiiYgB7kJM53SX5zKgTL716syLuF6Rq44NmeH9X
         6J7XgFg0cuMOhxckc4J/DknN/8gmGBWGXq0wbSmw8nSZJFS+D9coLm+jw4/kIgckcQKL
         2xbm22NDlpD9Uge3WF26gGqaJOJz1UX+Q2qUtE2yWEjmyqLhdjT1E7PU5Kh89plV/Rz3
         JO5EyhprStu+4QE79mfAY//4iAnfPacCuohKR2fEVe/V9mBFiWN5BCki96Zbdk7sonKO
         dE2KJYko7c1ZZhZIqq3KvU558NPdAPhJE6XIVOFoOzkxT33hCXsOpvM6vLdSOFdpjRGh
         /nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680893265;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lMeiSNuKI6ZdRR8Umoqzj9UR8r3FyJDFU2fogvFEC5w=;
        b=uDU9Z8pMS0Zkpv4oHTmrN2n9QrzOwlqZRvOptx3um9c+aIVdwwFUCEBvySpro7GpyR
         spzjfMQhZGNu0HOMwfmsKVqIOXHSFbL2lRa9wzYzc6KJU6QY2C2K46vkxTz/SUeDRMrk
         9uLMoCjuzxBiyiRhF/LffcX/hcDUvxC5Zzd5PP/3xnO0zEm3Nk6w4rJXdC5yTKb8nGWD
         kbAC2e+bEIwVcRkJIFtKKSYf5NgKB2bX2p87hdOS73hctxzc0mhdjNMLcRyecBMqNwyJ
         m61W6TlrgsJnw0mYnnF815od9erEDOjsWkSgrJAZfwQmh2RIIIpDQapwGsveZgOLD73+
         evjg==
X-Gm-Message-State: AAQBX9cDf+3gyHHwQpyVnouGU6JtkO92LqIxZuIoLduGcUn9fP0HKOo5
        YkQJ4jn9DYTeG18o2bMK4GbKjnqnqTN72Q==
X-Google-Smtp-Source: AKy350bv0MJS6J8C0pkFoCVZI95b4IHHMgn7tIxLngOkBJ5hL80KMrSZOtxp+WPiakYg9WrxMEAFiQ==
X-Received: by 2002:a17:902:c942:b0:19e:8688:86fe with SMTP id i2-20020a170902c94200b0019e868886femr4169921pla.42.1680893264995;
        Fri, 07 Apr 2023 11:47:44 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b0019edcc30d9bsm3265140plb.155.2023.04.07.11.47.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 11:47:44 -0700 (PDT)
Message-ID: <6d3869e9-6d8f-f7cf-2fe9-b8188a02d086@gmail.com>
Date:   Fri, 7 Apr 2023 11:47:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
From:   James Prestwood <prestwoj@gmail.com>
Subject: CMD_REMAIN_ON_CHANNEL vs CMD_FRAME (offchannel)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm having an issue with CMD_REMAIN_ON_CHANNEL taking a full second to 
become ready versus CMD_FRAME (offchannel_ok=1) which is quite fast. 
Under the hood it looks like both commands call 
ieee80211_start_roc_work() so its curious why one would take so long. 
I'm running this in UML so I shouldn't be hitting scheduling problems 
(at least that's how I understand UML).

This happens during the DPP auth exchange, I can include a full log if 
desired, but this is the sequence:

- Start ROC on 2417mhz
- Wait for ROC event indicating we are offchannel
- Receive DPP presence announcement from enrollee
- Send DPP auth request, request enrollee switches to 2412mhz
- Send Cancel ROC (and wait for confirmation)

- Start ROC on 2412mhz
- Oddly, receive the enrollees auth response before ROC event. So the 
driver _did_ switch channels.
- ROC event comes about a second later, and enrollee has timed out

So the driver is in fact going offchannel to 2412 and even receiving a 
frame. But for whatever reason it doesn't send the ROC event for a full 
second. Any idea why the ROC event is so delayed here?

Thanks,
James
