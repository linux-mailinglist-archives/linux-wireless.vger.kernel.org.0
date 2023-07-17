Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20579756E2B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGQUZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGQUZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 16:25:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD83188
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 13:25:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9b52724ccso3498492a34.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689625535; x=1692217535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g0JSh+z2d+zqcPVdUtuAQhMLrDU9xuX3h0UUhD28LEo=;
        b=WptWjU7FJR7ZOx55vnAQVsbFftM7NBRvZuZ5QyjcQTHb9GkGqf7LGBXRi1aasK5LKd
         V/onxEHLW28STCv4umGA+jDJJJfCLFbM2qxX/47PL+NU+Z/D+R5ELsUu3GZlhvc6fllV
         FoGHHNSevqEWR4owsgtynNU9unmlcODEI/iHG/vfkfeeTEdXz50e185BT7O/6TBg0lij
         UnrzencTJOkXHhS4GaQnkjhLG3dJZLcNwX5M9JREnGxMCEAcXbOphQzIgKCDpcQaEGYU
         zEbAdDx0tL+ZPoQZR/p+4+zMBLfWIoQQwafkO6yQ5K0ur7dIADlOpGOpLhcCAMHhVYHG
         Ir2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625535; x=1692217535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0JSh+z2d+zqcPVdUtuAQhMLrDU9xuX3h0UUhD28LEo=;
        b=ZcMfTLl6B04NJLdTUxP3ZSvhaYehghCMeN+ATFZr52YzLmzie8cKdrt+z7uM8+aA1w
         VPqHcNABukgmiecL62dnyu7egF+v2USzvAL0j6JZvpEs+HtkbxG/ve3u3kSkySlTzzSD
         6CAoqUy0u5J8O1K24T1FsGQMR8Rs18ssqFkm7m552nD/YhC+7nkFEsZFDcvymeEn+WFo
         EMHx6ROItXtgXc+gjLt25P/adc4BNaijtRSAyub5FJ9raWuCz9rcHbZmxBgCPF+0hMoe
         FHrarfdcLQlfdcyCH2kksP2HYgrkPxBx6gFY9KwbHa/3b8874xsdoyNN5UU8LeD7GvNA
         4kqQ==
X-Gm-Message-State: ABy/qLa7abA7U8kA48uL8sFK3toKLqZEXPZ6TZ3QkwOMSY0u6GFcEvKk
        IEUprktvoubYJrGFVzG0Cd8=
X-Google-Smtp-Source: APBJJlHJCn2Mo8X1lBE4gfspEHR6GgULO9FSafuRmzBl2Zmc3ZT8tsA/WHDgFV5sgOAIWgGVD7PlWw==
X-Received: by 2002:a05:6870:6194:b0:1b7:8836:95bd with SMTP id a20-20020a056870619400b001b7883695bdmr12661665oah.11.1689625535604;
        Mon, 17 Jul 2023 13:25:35 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w11-20020a9d77cb000000b006b9be9b41e7sm248758otl.68.2023.07.17.13.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:25:35 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <f5e75b2b-14eb-7ffc-6716-70324d2d13c5@lwfinger.net>
Date:   Mon, 17 Jul 2023 15:25:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: rtw89 driver and compressed firmware files
To:     Takashi Iwai <tiwai@suse.de>, Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
References: <87zg3uvawm.wl-tiwai@suse.de>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87zg3uvawm.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/17/23 10:02, Takashi Iwai wrote:
> Hi,
> 
> while debugging a reported rtw89 issue
>    https://bugzilla.suse.com/show_bug.cgi?id=1212808
> we noticed that rtw89 driver didn't load the firmware properly.
> 
> And, this turned out that it's because the driver uses
> request_partial_firmware_into_buf() function with the combination of
> compressed firmware files (that are standard on some distros like
> openSUSE).
> It's a known limitation of the request_partial_firmware_into_buf() API
> function itself; it won't load compressed files, because otherwise
> it'd have to read the full data.  That said, the use of
> request_partial_*() should be only for very limited use cases, and
> this doesn't look fitting well for rtw89.
> (And, as usual, the information is missing in the documentation :-<
> The API document should state it clearly; I'm going to submit a patch
> to add the information.)
> 
> There was already a workaround for CONFIG_SECURIY_LOADPIN_ENFORCE for
> a similar problem, but such a fallback is required in general for all
> cases, as it seems.
> 
> I can cook a hackish patch for the fallback, but I wonder whether it
> still makes sense to keep the use of that API function.  rtw89 is the
> only driver except for bcm-vk (where the API was introduced just for
> this driver), after all...

Takashi,

I am trying to duplicate the OPs problem in boo#1212808. I am currently running 
with an RTW8851BE, thus I must use kernel 6.5-rc2, or the repo at 
https://github.com/lwfinger/rtw89.git, which is the source for the Hardware 
entry at openSUSE. The firmware loading code is common for my chip and the 
RTW8852BE in the bugzilla entry. In my dmesg output, I see the following:

[  160.142412] rtw89_8851be 0000:02:00.0: Direct firmware load for 
rtw89/rtw8851b_fw.bin failed with error -2
[  160.142418] rtw89_8851be 0000:02:00.0: failed to early request firmware: -2
[  160.170098] rtw89_8851be 0000:02:00.0: Firmware version 0.29.41.0, cmd 
version 0, type 5
[  160.170103] rtw89_8851be 0000:02:00.0: Firmware version 0.29.41.0, cmd 
version 0, type 3
[  160.505451] rtw89_8851be 0000:02:00.0: chip rfe_type is 1
[  160.551131] rtw89_8851be 0000:02:00.0 wls1: renamed from wlan0

The first attempt fails, but the second works. The firmware file in question is 
xz compressed. This result was obtained with the in-kernel version of the driver.

All of this was done using Tumbleweed. My next step will be to try Leap 15.5 and 
Leap 15.4. I will report those tests later.

Larry

