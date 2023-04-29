Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864E16F2560
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjD2RDV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Apr 2023 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD2RDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Apr 2023 13:03:20 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CD171C
        for <linux-wireless@vger.kernel.org>; Sat, 29 Apr 2023 10:03:19 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-541f2112f82so391522eaf.1
        for <linux-wireless@vger.kernel.org>; Sat, 29 Apr 2023 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682787796; x=1685379796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T3+G6ZWCIVNK2XuUsz0UiHCcvWSvAylc8cD0NX8Cq3A=;
        b=QzC5C+zGUX1x6ib9+JCIJaAayaKHYygPeUaCB+/e3NmEPlreETvMR6Km9JnORcrb9t
         5pF9xOvMZbNOqufFzoF3RM0lK7PjL5V7EK/Nn7R9bhC17V1UGsKuNWiVyNmZ0w38O7S5
         Y2vkXnrPUrpyWjA3SdKzHhCRJiRtUBaYliMAgqPsM4YNAUWzQM+/87ESs2UauTCmGSGu
         1rnKQm82htf8QXpEa9b5LgmPrYWkY5N8DWYDuad7drrQEbLvBzBvkHvxiT+9QmDa4zF9
         IuL8S6p9YoJWyLHooMbPU1MIHSDKcep+Ukei5JziJP6+1yRlMKJLrNgZdsmgeY4rU6r2
         /0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682787796; x=1685379796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3+G6ZWCIVNK2XuUsz0UiHCcvWSvAylc8cD0NX8Cq3A=;
        b=hRTvcxM8AKACMRyYxVIVdFwB5yMXHLPUy0m62QirIPdZEZdZjqxpOfHwETF95rsksJ
         qvRgUa4sIH1RrBbhVqfgcgCYbf5nGHn6VMMHjO68JpAdvpNDFDYXY7rxDmHIP+SAeTH1
         hkGg+UZ+KOSQnd/D28hyK6jgjgjvKjxG1zBeVdDgBN5UA0n9bzWW/lFeeOVkBJ26YrUe
         l7IwHj6+ZLwHWFbUfM2MHAtTQ8zBfyXpCb9pK5jcmYqHVWbkNEhvUdpkreDMaf+IzPFq
         EDBZtfebiyZDeAMrrMdjGaoRNhXz/7fNzJuhm/cGKljHB+E/ai/agUcR8lV75G7xGxpT
         dYWA==
X-Gm-Message-State: AC+VfDzEtCWrm/ja0JLjkV//GPUFQ1RDL3HH948hJ5nAN3gdrmaZbvMT
        lbBkZHHqqmJBQqlcCLfwxDReUhRY1d8=
X-Google-Smtp-Source: ACHHUZ7lVm0lgpUfV6r5QZPLp7gQwCPRFzNNFXuw/X1Er84GRFSA397iBVjmdDyC2+L/XVhbwXzNkA==
X-Received: by 2002:a4a:e847:0:b0:547:4fe2:bd17 with SMTP id m7-20020a4ae847000000b005474fe2bd17mr4867856oom.9.1682787796508;
        Sat, 29 Apr 2023 10:03:16 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id v68-20020a4a5a47000000b00541b5963069sm10880559ooa.20.2023.04.29.10.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 10:03:16 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <53260a3b-9256-07a2-1d66-553e865362b7@lwfinger.net>
Date:   Sat, 29 Apr 2023 12:03:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Remove driver
Content-Language: en-US
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230428182933.19157-1-Larry.Finger@lwfinger.net>
 <cab66a9d-9a66-7cd1-408b-91e8cd9d8a9c@linutronix.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <cab66a9d-9a66-7cd1-408b-91e8cd9d8a9c@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/29/23 04:42, Martin Kaistra wrote:
> Am 28.04.23 um 20:29 schrieb Larry Finger:
>> The functionality of these devices has been replaced by the rtl8xxxu
>> driver, thus the version under rtlwifi can be removed.
>>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> Things to keep in mind:
> - rtlwifi offers AP mode support for rtl8192cu devices, rtl8xxxu doesn't (yet) 
> do that. Should be relatively easy to add that on top of [1], though.
> - The rtl8192cu devices are currently hidden behind CONFIG_RTL8XXXU_UNTESTED in 
> the rtl8xxxu driver with the comment "Still supported by rtlwifi".
> 
> 
> [1] 
> https://lore.kernel.org/linux-wireless/20230428150833.218605-1-martin.kaistra@linutronix.de/

Kalle,

I failed to consider this point. Please drop my patch. Instead, I will submit 
one to remove that configuration parameter that says the rtl8192cu is "untested".

Larry

