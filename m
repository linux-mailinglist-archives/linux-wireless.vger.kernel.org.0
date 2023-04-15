Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A026E32E0
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDORXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Apr 2023 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDORXC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Apr 2023 13:23:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B9186
        for <linux-wireless@vger.kernel.org>; Sat, 15 Apr 2023 10:23:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q1so335824oiw.6
        for <linux-wireless@vger.kernel.org>; Sat, 15 Apr 2023 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681579380; x=1684171380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=INxjp0OdNezsX2He+Faw3hfwvAwS2bu7O0bLh04EWdQ=;
        b=rX+adHecGY8OscCcC9rwMMylJKhr+6+WeKwohjvo9IjLbS+X8cMoSt+oSRcdCxp8sg
         PP/BbWwaWje7eLWdXtEco98fR9UFQyCz88LdIzPjSUVzjJ+GMZy4pNKW63MWDSEzcfi3
         PJtiWqufMKn+krOBwX2JDJWPa2h80O+c2Z6R6EBIg9bxTdBS3+Ty7TmKvegqzE0W+GXf
         UH6dJlVkyDWx9X4EqP8rhQDf30je+jIr1QoCQBVwLqrmJ+El3vDo/QmnyJ/Fi/lHW4AZ
         Os8kqDX6veASMOQgcCq1caFt/yO8s7NcDRzJSmu2014GqY6vLxjli3yRSek3Jxd40f6s
         eo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681579380; x=1684171380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INxjp0OdNezsX2He+Faw3hfwvAwS2bu7O0bLh04EWdQ=;
        b=ZO9TnOoMLB2uJvzBqpPYPeT8bYtlfO1ZLD6B3GwFng5GruwKVswo4ZhtenUOVsG0/m
         S90urBfabSURBy9wRC5OjOAKIqEmWzOZuwO0jNeXlvwoUjngA7o0WRF8FkP7zELSu1Gd
         mTQysKU0FR8lRb9pElexYlPyuuciF7Rmq6oi1wNJ663lrv74J57uDiwHshxm+nbYjik2
         EEt+Uf9EB+E2ZneWdfkRRpIQ1/fT5godzvFabjFMaqkjdBiGSsD1GBy0li/LsFcvtdPr
         xUS9EyeXuJLMLUux+2mSW+k70+CJlsudSLUwWHbdthPasOmflyHmR1IDZQjk0NjdAjqD
         /IQQ==
X-Gm-Message-State: AAQBX9dLSx2S/qMnZaGTTY2ZNHnprj1dmY/GkQLbtP90If0PGPvvlwBp
        Cv0XfzcgWbKsOdA6W1IswBfYLwQN8P4=
X-Google-Smtp-Source: AKy350av+LYRKT4xxGxBcvyM+BHKHdYXFieLKX4cW3IxdvbaZZq6p/SEEN/hyhYtCDsCdo12zWTIYw==
X-Received: by 2002:a05:6808:4d7:b0:38b:3ba2:ecd8 with SMTP id a23-20020a05680804d700b0038b3ba2ecd8mr4490643oie.15.1681579380228;
        Sat, 15 Apr 2023 10:23:00 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r7-20020acada07000000b003895430852dsm2863012oig.54.2023.04.15.10.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 10:22:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c8d4b1e0-1fb4-4bcd-cff0-c108e9ee1e7a@lwfinger.net>
Date:   Sat, 15 Apr 2023 12:22:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Question about rtw88 patches
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
References: <3aaaceb0-1518-49b6-ca18-f7c46c35c65c@lwfinger.net>
 <e8e70392bb38ee44f29fd0dc2522daa8340cf609.camel@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <e8e70392bb38ee44f29fd0dc2522daa8340cf609.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/14/23 23:00, Ping-Ke Shih wrote:
> On Fri, 2023-04-14 at 14:50 -0500, Larry Finger wrote:
>>
>> Kalle,
>>
>> Has something gone wrong with Sasha's rtw88 patches to fix the hardware queue
>> selection in rtw88 [1], and the corresponding rfe field width fix [2]. These two
>> patches are included in my GitHub repo for rtw88, and they fix the ubiquitous
>> "timed out to flush queue" warnings.
>>
>> Larry
>>
>> [1]
>> https://lore.kernel.org/linux-wireless/20230404072508.578056-2-s.hauer@pengutronix.de/
>> [2]
>> https://lore.kernel.org/linux-wireless/20230404072508.578056-3-s.hauer@pengutronix.de/
>>
> 
> Hi Larry,
> 
> I think this is because I have some suggestions of [2] to improve further.
> Do you think we can take this temporary version in advance?
> 

Ping-Ke,

I think these two should be applied as soon as possible.  Any further 
improvements should be made on top of [2]. The log spamming that happens without 
these patches is extreme.

Larry


