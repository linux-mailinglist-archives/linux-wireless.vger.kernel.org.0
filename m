Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7997CC616
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjJQOm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 10:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjJQOm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 10:42:27 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F28FA
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 07:42:26 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7e5dc8573so71080937b3.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697553745; x=1698158545; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/+V+HzRWrHbzNirLagvcEh1b6lCsWL3snQd/v/rxUs=;
        b=aespuE05xbnulpkR0kSpwWOmTSM15t75CrDdQ683rFuU5c5seezFQDoY4BA6JdvFSj
         icJ8CDc0M8DF+xnELoiaxoepIx05s0Kotp0kWeu8CyDtvhgdaV9US14Jo1ryyutvUl8i
         sklbOFErEQxedZ4UurLu+Do+ABDLAVuM9cFdzZhyF9ESmTUbgywTe/i/C8jYhPFqF91W
         yIXRptTxzI/2qMBl9rn6SfZO9dTtqgIqpRgiD7IPdQGkr4FDzsssr6e+V2di60qcKd2j
         xgvxfEMmnVkSIs58RVU93Vacgq5nIvWQUyfqZAfZOAl3vZ6u5GBkU54aMvDHSJPBS6B8
         0fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697553745; x=1698158545;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/+V+HzRWrHbzNirLagvcEh1b6lCsWL3snQd/v/rxUs=;
        b=mqMu/KfViktD1KJFn1XADkh01Ww8rImn0IMJy6A0xGfCOHiHVMcPVgOpQXpFjbB13A
         H8V1AYmh3plgfX6GhhelV09t2Rsgc8tZs8ekQ3tmTAP3Szn+oJOZcdbWNkz+xchjhPGT
         JuS2nyzBexVyKImVna6Tus8eQPZhQlLdsUcE+gRb3qg4+BRt+MQ8GXV4aFAroWA7HeMg
         7AvpQUiFozfJ1cah+xC77dUKjxZ4p8agmtnxThHlKM2UHixyNJChlIQkW1Eu8b97hozQ
         uUXna8zED5sUUbPmRqTvhL5J26h5KWZlh5CdmjWaXalWO3gZB27i9pPag29IgMkXIGNi
         DOzg==
X-Gm-Message-State: AOJu0Yx0Wil5AZJxqeLhfW22e6hdACFWDTbZ71cVKJGKzUkQubZ6vy7O
        UXCH1uhllG3P8Zyf1sFbyFs4GKoT8Os=
X-Google-Smtp-Source: AGHT+IFux1QVFw2hU7WLYjlkgshDlLoLUfHdHWyWsGu7srye3OorhITICj1ffEigVcmacLPyebb5Cw==
X-Received: by 2002:a25:4404:0:b0:d9b:353b:9e24 with SMTP id r4-20020a254404000000b00d9b353b9e24mr2235442yba.11.1697553745488;
        Tue, 17 Oct 2023 07:42:25 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kh13-20020a056214514d00b0065b17b925d0sm602579qvb.38.2023.10.17.07.42.24
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 07:42:25 -0700 (PDT)
Message-ID: <01c99bfb-b87b-4566-a873-38c6b7dbc0d9@gmail.com>
Date:   Tue, 17 Oct 2023 07:42:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
From:   James Prestwood <prestwoj@gmail.com>
Subject: RX multicast action frames (ath10k)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Currently it is not possible to receive multicast action frames (AFAIK) 
unless EXT_FEATURE_MULTICAST_REGISTRATIONS is supported, which is 
currently only ath9k (and hwsim). This was added to support DPP which 
I'm also trying to do on a system using ath10k (potentially ath11k in 
the future). The original change [1] to ath9k was quite simple and just 
set FIF_MCAST_ACTION to the list of filters.

I tried doing this for ath10k with no luck, and looking deeper it 
appears the firmware API (ATH10K_FW_WMI_OP_VERSION_TLV) doesn't have the 
"rx_filter" command. I'm using a QCA6174.

I also noticed the "configure_filter" op for ath10k seems to be monitor 
specific.

So I'm wondering if this is something the firmware needs to support (if 
so I guess I'm SOL unless someone wants to add that). If not I could use 
some guidance on how I could support it if its possible to modify the 
ath10k driver.

Thanks,
James

[1] 
https://lore.kernel.org/linux-wireless/20200426084733.7889-1-jouni@codeaurora.org/
