Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42A96BE0D9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 06:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCQFzu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 01:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCQFzt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 01:55:49 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0BA54CAE
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 22:55:46 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bh20so3034781oib.9
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679032546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bUoVTLe/+vMIN+DcNQmZSwhPyxH24CnYuwhM8maMY/4=;
        b=bOtVi+bqH5bMSoFqzveLn8igNuDSVTkbipsxo4GmDdNv0r66mTrqa+wO5tlMr5mZ23
         og8OYGc9mDwJ57XtW/1WOnLLyaoRzagdiO8DwSSVnqqWK4g2eM5Hk4i7YBNMuRgguQf8
         ES5GrAsSRGOvorecJNcPuav8YIfGWmHDHV1JPA7ZAskuP3KigxRmteUenPxhlkAvd1uZ
         jidzWOwZfnSZm5m4AYbWc89iH5/xqesVm+2zm6Cup8+xPESGr3d0956PTEW/eWGgzar/
         4viG5LCj2TFAT1SUnM6/ZeB0qVJZY9D4LF2+eiwGUO3qOG3fvB1g5mTymZUme5iZhIMz
         keFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679032546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUoVTLe/+vMIN+DcNQmZSwhPyxH24CnYuwhM8maMY/4=;
        b=wksSakSyGcHD3jtOclyhJ+siSLkjNLqoguXgqzKKPw4qSGyln4IZvUXPEXROSCMtbU
         zuA1ccngXftk+OFueBQ5HlS+CeVc5OEGbck6ZqsuVpL6eaEnB9bKnEL6qEOS2HOvhpC8
         vKUMp5mrVen+2cTv67yOHZ2n862vDbDPpb8eKNDPQFCDfUD6ASILbjqiccu7XHqEf3aC
         yLTzMo2+Urt3DU7IjpY9juzDRdBCT4K48lUi8cWHiR57EFth/5RuVick84efbDu/CU6g
         kvaq/csQ20SxelY/6C6R85bNlbcv9JtlD3Zz7PNWHZj7AIac9ixFJstGKElnsVFt9mvo
         rHuA==
X-Gm-Message-State: AO0yUKWA4wHvCJXUQq0wGmkPFx3qH4lTUQbWw2Smy7muzBzkRRn4La74
        hklE4pQS+gRJMTo0W69wI1g=
X-Google-Smtp-Source: AK7set+03xkd1Vf6VA8v+sD0Yhazlhik5ZO0i3byPqvn22B9v25zricoCGbzkKKbUgsykTiP50LZeg==
X-Received: by 2002:aca:dad5:0:b0:386:8d04:413 with SMTP id r204-20020acadad5000000b003868d040413mr836718oig.27.1679032546108;
        Thu, 16 Mar 2023 22:55:46 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id a11-20020a9d74cb000000b0068bc48c61a5sm658422otl.19.2023.03.16.22.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 22:55:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b4ced875-310f-8469-137f-7cee0c0ea336@lwfinger.net>
Date:   Fri, 17 Mar 2023 00:55:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: New binary rtw8852b_fw.bin not loading firmware not recognized
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
Cc:     rb <rb0171610@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
 <386367223a2547669c60f7d1dcb42b40@realtek.com> <87a60cvu3v.fsf@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87a60cvu3v.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/17/23 00:12, Kalle Valo wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
>>> -----Original Message-----
>>> From: rb <rb0171610@gmail.com>
>>> Sent: Friday, March 17, 2023 6:48 AM
>>> To: linux-wireless@vger.kernel.org
>>> Subject: New binary rtw8852b_fw.bin not loading firmware not recognized
>>>
>>> Briefly,
>>>
>>> I use rtw89_8852be in kernel driver
>>>
>>> HARDWARE:
>>> Network controller [0280]: Realtek Semiconductor Co., Ltd. Device [10ec:b852]
>>>
>>> Lenovo Ideapad 1i
>>>
>>> ISSUE:
>>> Newest version of binary firmware 2023_03_10,
>>> rtw89/rtw8852b_fw.bin, will not load/firmware not recognized on Linux Kernel 6.2.5 (and others):
>>>
>>> [] loading firmare: rwt89/rtw8852b_fw.bin
>>> [] rtw89_8852be 0000:03:00.0: no suitable firmware found
>>> [] rtw89_8852be 0000:03:00.0: failed to recognize firmware
>>>
>>> Issue persists regardless of which 6.2 series kernel is used.
>>>
>>> All previous rwt89/rtw8852b_fw.bin firmware from linux-firmware 2023_02_10 and earlier loads and works
>>> correctly.
>>>
>>> I did file a bug report with the details:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217207
>>>
>>
>> The firmware format is changed, and wireless-next tree or upcoming 6.3 will
>> support it. I will also post this information on the bug.
> 
> We cannot break user space like that, linux-firmware needs to be
> backwards compatible. In other words, anything you submit to
> linux-firmware needs to work with old kernels. Should this new firmware
> be reverted from linux-firmware?
> 
> What about changes in the rtw89 driver? Do they still work with old
> firmware?

Kalle,

This is an unfortunate situation that I did not learn about until this week. As 
you have seen, my download site has the old firmware.

The latest driver will work with either version of the firmware.

Larry


