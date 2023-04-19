Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622B26E8164
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjDSSpW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjDSSpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 14:45:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F9E4EE3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 11:45:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so618935e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681929918; x=1684521918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Td2gNjM//DPvC/9Dur2VLR7CaLj8FhO87kSuZcqERw=;
        b=OELpDn8bHJHCJGUt4OGc4oGt1rfD4pQUgYDj6SjfB7Z1wYheR2EEdHCOub1ZoTu3YR
         7G3CdSmrH731MmswuIZEbj1mbjUGHPgU/bDjHpt/OwOJl3F5QIGckE/jI5iKgcky8ADL
         8+RjkHS37cuQ0pE5PulSDQMt0JrTaWj/3SL+QKJIgbz5YAPELhXdclvsCuyhe/UaOLjE
         3ZqnDG8f2+1Jrs0N3XKcexj/u28kJ8oQucGKI86z7/eZAcG8KO0h7f3m9eMh2HWlRChi
         mUWqf3L6ZHdD1IxmGOH1dhc+WZZ0oxATVxpxYq11phKSp0GLYg5vE88IahT2D6YP/612
         eYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681929918; x=1684521918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Td2gNjM//DPvC/9Dur2VLR7CaLj8FhO87kSuZcqERw=;
        b=JbKbAzLDOx03qiX30I0MBo73PYbcXZWf1jVgfkHq0DcEk/D2sksyNrkCsHIsGJSC/C
         dOPWfqiBwmr2jtE4IYtJZ/hJsW0zn9zDq2m7XTe0nreqMomlk2R8mOdmGtllxKxRp6on
         smGGpHvcrVcZbsQ+aBg1dMRntxXa1ggtm+HScVLhdJQu3Tb4psO/7sQAFTH4DPzUDuQZ
         02kEBynYzwwko50POUeO6znik/OwLuQT+s353sZIXfoKRuklu27DObJCqYbQqbtJflc3
         3o+05d8Rg684OQVyVJeXqb8OI7b9tIiDjk/YzAx3pW1cgDyllaA0ons2atgIIJflDEbR
         55Cg==
X-Gm-Message-State: AAQBX9fdkPebaazmc0C8zBYa41ALvpn5Fcq29ZCMcAsLw+uNf1EL4PpJ
        uAHlldCUPw0xYs+93eZRNm4=
X-Google-Smtp-Source: AKy350YDLaerFvi3uYrkhJg3cB3NHX6rHgzKIs92lxLFIOIVReZ9tRg4kaikWdjNOGk8mrBd7RviKg==
X-Received: by 2002:a5d:6881:0:b0:2f8:7cac:101a with SMTP id h1-20020a5d6881000000b002f87cac101amr5455012wru.41.1681929918272;
        Wed, 19 Apr 2023 11:45:18 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id q1-20020adfcd81000000b002ff77b033b1sm1401503wrj.33.2023.04.19.11.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 11:45:17 -0700 (PDT)
Message-ID: <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com>
Date:   Wed, 19 Apr 2023 21:45:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
Content-Language: en-US
To:     Artem Makhutov <artem.makhutov@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
 <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com>
 <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/04/2023 20:52, Artem Makhutov wrote:
> Hi
> 
>> I have also tested the driver from https://github.com/aircrack-ng/rtl8188eus
>>
>> The problem occurs here too, but much less frequently than in the
>> rtl8xxxu driver. The strange thing is that sometimes I have 99% of
>> broken packets with the rtl8xxxu driver, but sometimes only 1%...
>> With the aircrack-ng driver I had maybe about 2% of failures.
> 
> Now I was just able to get the issue using the v5.2.2.4 driver too,
> but not so frequent:
> 

Interesting. Can you try rtl8xxxu with the newer v28 firmware?
You can download it from here:
https://bugzilla.kernel.org/attachment.cgi?id=304160
