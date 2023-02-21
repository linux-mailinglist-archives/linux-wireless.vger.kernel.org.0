Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF969EB27
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 00:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBUXWL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 18:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBUXWK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 18:22:10 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AAD32E4C
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 15:22:06 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1724d65d002so781780fac.4
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 15:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhCoFYSUMMqc3HXw6HXYEIvg+3pjW+HroIc1/DHLh6Q=;
        b=fpS0hFl3OgnfnTZrjavWnEJolfVGP8Rr+L+exQDLVVb0en2+uMx1uVEKkHeL2D01Q8
         jvmumDEp7irW3kcsQ4pvqqqp0gixBFCU62HRJaJE8uc0vQo+VoCmZqDoZAA4ghQPJzGe
         h2ZlZbO1mOSCmpujnjUXIC0JFOQS7KVyvjy6R/KvCtgsG6V1z5k/vtzQfVqRyNIjkq6m
         zF7kL5Z+hjYRzMpIw+nCcGqniXj+CH3dapWbnCIjnfVhQW7aolAJeilOMT319DCrghZo
         f6V3I9hJR2+ytNNqtI/w7Ox4V1IxWiYVQDvYshztfWFSTpmodlQgmabOPd3tIDSBWak0
         0atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhCoFYSUMMqc3HXw6HXYEIvg+3pjW+HroIc1/DHLh6Q=;
        b=S3ZjX9owPnZbj7J4ykldMiT3pRBg1JWZ1a+zm0T3C45mTeMjz94LgpvSLcdtN9w0Q6
         EfiqjfUgDM2jGoCCsIvgnOZ9aRkx5zqAgq0C4UNtiY4dJy4IUkdI1jhdD2s8sSxy2NqT
         c//+8fg+gqlRlRrHKsHHnFRNAIt9nW1HiNSffYGdjZvNj8PIyUZA9xpR4jU11dMgKhhc
         444qDDDOwvJF8UeD9aNPHAyqcNZ4RJzkNzHvz5hMXJILuSvTQbkZftVsoQuBkg5wUb4a
         WTyaaWWYi48I+Fm99QCRES4R6jhzF4nc2fClh03o2RX3jFxGLpCy8gBrMV0ICJgMUPBL
         MMng==
X-Gm-Message-State: AO0yUKUoqI6HU9iRtVsoy6YFGJuED0JKDpeVa9IFDmbmJePWAwi9aKDi
        ek6b9fsQtepW9VLHcAql66NoilFyeu0=
X-Google-Smtp-Source: AK7set8TE7cW8OpIvwmh6hKlXOd91naeebnTSw8gwqui9ig9rrlOItZx1ptN6jbjsf4nO23qxA2t2g==
X-Received: by 2002:a05:6870:a693:b0:171:a73f:71bc with SMTP id i19-20020a056870a69300b00171a73f71bcmr7456330oam.39.1677021725838;
        Tue, 21 Feb 2023 15:22:05 -0800 (PST)
Received: from [192.168.7.108] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id k4-20020a056870d38400b0016ddd5c2484sm5720732oag.5.2023.02.21.15.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 15:22:05 -0800 (PST)
Message-ID: <1d26172f-348e-6fdf-92f2-217aea26281c@gmail.com>
Date:   Tue, 21 Feb 2023 17:22:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] rtw88 / 8821cu driver missing firmware
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Ingo Saitz <ingo@hannover.ccc.de>,
        linux-wireless@vger.kernel.org
References: <Y6Bnc+UUY3R/nc6L@spatz.zoo>
 <8b86edab-5bd6-cab0-f8f8-f5c6bc757988@lwfinger.net>
From:   "Alex G." <mr.nuke.me@gmail.com>
In-Reply-To: <8b86edab-5bd6-cab0-f8f8-f5c6bc757988@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
On 12/19/22 16:53, Larry Finger wrote:
> On 12/19/22 07:30, Ingo Saitz wrote:
>> I saw the 8821cu chipset being merged for linus' next kernel release and
>> decided to give it a try. I have been running 8821cu from
>> https://github.com/morrownr/8821cu-20210118  succeffully, so I know my
>> hardware works.
>>
>> The driver as merged in commit 07cef03b8d44dee7488de3d1585387e603c78676
>> to git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> can't find any firmware for the driver, and the card does not work. At
>> boot it repeatedly logged failures to my kernel.log:
>>
>> 2022-12-16T19:20:21.563669+01:00 pinguin kernel: [    7.823614] rtw_8821cu 2-11:1.0: Firmware version 24.11.0, H2C version 12

That means that firmware 24.11.0 was loaded, which is the latest in 
linux-firmware as of this writing.

>> 2022-12-16T19:20:21.563670+01:00 pinguin kernel: [    7.906497] usbcore: registered new interface driver rtw_8821cu
>> 2022-12-16T19:20:21.563670+01:00 pinguin kernel: [    7.930657] rtw_8821cu 2-11:1.0 wlx1cbfcefeb2a3: renamed from wlan0
>> 2022-12-16T19:20:59.576907+01:00 pinguin kernel: [  631.847796] rtw_8821cu 2-11:1.0: failed to download firmware
>> 2022-12-16T19:20:59.576910+01:00 pinguin kernel: [  631.849195] rtw_8821cu 2-11:1.0: leave idle state failed
>> 2022-12-16T19:20:59.580239+01:00 pinguin kernel: [  631.851635] rtw_8821cu 2-11:1.0: failed to leave ips state
>> 2022-12-16T19:20:59.580241+01:00 pinguin kernel: [  631.851636] rtw_8821cu 2-11:1.0: failed to leave idle state
>> 2022-12-16T19:21:08.563579+01:00 pinguin kernel: [  640.833372] rtw_8821cu 2-11:1.0: error beacon valid
>> 2022-12-16T19:21:08.563590+01:00 pinguin kernel: [  640.833480] rtw_8821cu 2-11:1.0: failed to download rsvd page
>> 2022-12-16T19:21:08.563591+01:00 pinguin kernel: [  640.833640] rtw_8821cu 2-11:1.0: failed to download firmware
>> 2022-12-16T19:21:08.563591+01:00 pinguin kernel: [  640.835040] rtw_8821cu 2-11:1.0: leave idle state failed
>> 2022-12-16T19:21:08.566911+01:00 pinguin kernel: [  640.837510] rtw_8821cu 2-11:1.0: failed to leave ips state
>> 2022-12-16T19:21:08.566915+01:00 pinguin kernel: [  640.837513] rtw_8821cu 2-11:1.0: failed to leave idle state
>> 2022-12-16T19:21:17.550263+01:00 pinguin kernel: [  649.820641] rtw_8821cu 2-11:1.0: error beacon valid
>> 2022-12-16T19:21:17.550288+01:00 pinguin kernel: [  649.820759] rtw_8821cu 2-11:1.0: failed to download rsvd page
>>

I have noticed the same messages on an 8821cu based adapter. There is 
something wrong with the driver as opposed to missing firmware.

Alex

>> There is no mention of what firmware would be needed in the source code
>> itself, yet the repositoryhttps://github.com/ulli-kroll/rtl8821cu
>> includes a file firmware/rtl8821cufw.bin.
> 
> The firmware that is needed is the same as for the PCIe nersion, namely 
> /lib/firmware/rtw88/rtw8821c_fw.bin. Your distro should have that 
> firmware in package firmware-realtek, or in linux-firmware-realtek. If 
> they do not, you can get it by 'git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git. 
> The firware will be in directory rtw88.
> 
> Larry
> 
> 
