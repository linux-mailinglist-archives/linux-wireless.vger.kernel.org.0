Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF466BE0D1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 06:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCQFxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 01:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCQFxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 01:53:30 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0E1630E
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 22:53:29 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-176261d7f45so4631134fac.11
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679032408;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sm+b198sDYM1ShdWCuZiS0wMQAyz/L0pEBQOjp3IjDI=;
        b=Mhqt+DC2hbskWhZLje7D1BCVuHEp47m0xK/RxC5ceXwKDIw+2uggDZenaSt0AhyS+c
         CPE6XjhGiVxCy8xCbmZDbNYK5oy9pLrQG/lYEzMcJmqJhCdvpHgTF8Wt8fgzNW4MJklf
         jkQSQHdWM3X0SjULa8VDVqMEaWfNnWtb7sGPP02yHDTDNvxjjwt1gILzkteEoZuSiFJ2
         4Rem/cACarzyWjTKpN+TRikXNAUjdM0lyILyKjYIso+GCRAHucxnncUyoZpWTNwwGfp8
         tGK0UTdx33uaQ+ahx0+/TBgIB78CJKu4IyDxe988bo2a5DmnCd2GnW3sCMgbGhLtwtu4
         1JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679032408;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm+b198sDYM1ShdWCuZiS0wMQAyz/L0pEBQOjp3IjDI=;
        b=54e//FHjr4Og+0XZU/3SmmPkGVksOYeFaJrvOVJeq2PoVDmJe+zOJ9GYUI3ymJPZC6
         gNamTE8m5vebA5BJefhIbQP/3t0Wh4HpqqsbSncCEErHw70JBtIPfHGBKefD3m6Ioghm
         vuvidwiyWnJ/LmeFA1jTDSWnv94DV2rPt4RuD0HwNaInq1Go8DcVWICtySAEa2Xz05mN
         1GLqvlIpRqNQL2MMAxYJE/j3NESD0u5Tpiqwcfy1vkwdGU+Qi4ozuKSWywx3ak/Ysup4
         2IpZwLDjsdzeLI0rOkPd2ft4hUhozqlEVvc/a5gcp5gr/KaQOoiBUnbaJphKRdyc+Ikg
         Cy9w==
X-Gm-Message-State: AO0yUKWJHUjR0fhEsi2lQpwIAaNK2i+UH1BTrKjX6rIin0QO9aj+wWae
        VanDGCrq2lY6Tt6BlbvHwO2dOngeohE=
X-Google-Smtp-Source: AK7set/LJfDZHKQuklU+6ucbjzemd9w7aHAJndVp2nwbOqMSM4rqBBIZj2qWVVTTk7s91+6OXyojag==
X-Received: by 2002:a05:6870:fba3:b0:17a:ccda:5c0b with SMTP id kv35-20020a056870fba300b0017accda5c0bmr5033308oab.6.1679032408475;
        Thu, 16 Mar 2023 22:53:28 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id eh1-20020a056808274100b00383ece4c29bsm556097oib.6.2023.03.16.22.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 22:53:28 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <1e708cdf-f132-301b-0514-203275581bc9@lwfinger.net>
Date:   Fri, 17 Mar 2023 00:53:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: New binary rtw8852b_fw.bin not loading firmware not recognized
Content-Language: en-US
To:     rb <rb0171610@gmail.com>, linux-wireless@vger.kernel.org
References: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_CSS_A autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/16/23 17:47, rb wrote:
> Briefly,
> 
> I use rtw89_8852be in kernel driver
> 
> HARDWARE:
> Network controller [0280]: Realtek Semiconductor Co., Ltd. Device [10ec:b852]
> 
> Lenovo Ideapad 1i
> 
> ISSUE:
> Newest version of binary firmware 2023_03_10,
> rtw89/rtw8852b_fw.bin, will not load/firmware not recognized on Linux Kernel 
> 6.2.5 (and others):
> 
> [] loading firmare: rwt89/rtw8852b_fw.bin
> [] rtw89_8852be 0000:03:00.0: no suitable firmware found
> [] rtw89_8852be 0000:03:00.0: failed to recognize firmware
> 
> Issue persists regardless of which 6.2 series kernel is used.
> 
> All previous rwt89/rtw8852b_fw.bin firmware from linux-firmware 2023_02_10 and 
> earlier loads and works correctly.
> 
> I did file a bug report with the details:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217207

There are two workarounds.

1. Copy the 0.27.x firmware from my download site and install it using the 
following:
wget lwfinger.com/download/rtw8852b_fw.bin
sudo cp rtw8852b_fw.bin /lib/firmware/rtw89/.

2. Implement the driver found at https://github.com/lwfinger/rtw89.git.
That version can handle version 0.27.x or 0.29.x of the firmware.

Larry


