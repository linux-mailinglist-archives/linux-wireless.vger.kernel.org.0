Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7FF3507FA
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 22:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhCaUQX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 16:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbhCaUQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 16:16:21 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE0C061574
        for <linux-wireless@vger.kernel.org>; Wed, 31 Mar 2021 13:16:21 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so641oot.7
        for <linux-wireless@vger.kernel.org>; Wed, 31 Mar 2021 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6AO5YWEfTWc0eZYPBemB6GLQW8owVIaPuv9ArxiWaI=;
        b=lJsk70HSRImrwdF5WGD5tJWYQ9V49za8KQpbWazoi3xfyc0q1Hdd8U5InSksPsxPfB
         fzkGxW0hiLw4KfyC9lQOewPH8zG6oeX9Z5wbucTVfbkokEwnr8pEosIBA8k8l0YqQaAD
         jmJCH+WSV5gowRBLXlh4DAK+2CgNc43JmalNqWGeGv5QP8vQX7FN/1Z4AgGc+y9ydQCx
         fGr2l55UxZsovwnvEAV02Ux77t5WS6QBWQPihUdhrt4pUcJcFI1ev2zRmtWYTeqUnkP8
         G5TIK0yA3A7QTR/WsuuafNHQh/nsUEECztaxc1AlElINIDRk7fPJbYV05mOI3korAoZ/
         MG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6AO5YWEfTWc0eZYPBemB6GLQW8owVIaPuv9ArxiWaI=;
        b=MQdAxFhl2Qwd01tMX+MaDO4qSRXLM6g+4rqQ96nwzQUoUp6vNI78/dJByTEZ7OSz6Q
         0NjBSOLURvedcGkeLHaO5FnpsZvdiJ6q6MUo1S44J5qz3SCVDb6c08QS8hHXYXm2QtKY
         07zBxvWs4Xqf16ttRJEbqnYnDXxBIrwgYgRI5XBo3r0Is4OklcTbK0jIZcoEJ/J3PNkb
         dH4FmmORC4bzgmFYqsqsjylm5eEsU6ThT32yTvd1tYJFEaXWnygk1+5quXZ6uyL7uGcU
         uQe+ACiMkbLEwny5M8RVQhLFYgkUS80C4qCKWLNIpEsC4oG3CJytrd8dEVkn2pO5q+bS
         T3AA==
X-Gm-Message-State: AOAM530SWvsbeT7bITCR59bnes5jTHdm85hJlW4Ku25YzVkpQNQ0WnUt
        Zo5AZaUgV5XEPyBWpmtYn08=
X-Google-Smtp-Source: ABdhPJzf5zhwjH8EgCvspVofNKKFokHJZi7CeRX18VZdEmGKFiZcx7fSnF4iWuqPB2afCg/RWpHnIQ==
X-Received: by 2002:a4a:d553:: with SMTP id q19mr4075531oos.28.1617221775899;
        Wed, 31 Mar 2021 13:16:15 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v195sm639094oia.38.2021.03.31.13.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 13:16:15 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Fwd: rtw88 kernel module error report (UBSAN:
 array-index-out-of-bounds in drivers/net/wireless/realtek/rtw88/phy.c)
To:     =?UTF-8?B?0JHQvtCz0LTQsNC9INCf0LjQu9C40L/QtdC90LrQvg==?= 
        <bogdan.pylypenko107@gmail.com>, linux-wireless@vger.kernel.org
References: <CALw23pC5kFE23g8M97KJY5vK8-eP1dWPj3jze=j4Mi=NjHks0w@mail.gmail.com>
 <YGNS7WKlBmLrM9/d@kroah.com>
 <CALw23pDE4dqjYapETUsxSJ5bhFHraRm3P4nsMq7o+_30rVXKkQ@mail.gmail.com>
 <CALw23pDmLVSTEN4i7tef9a32jDhBVJ5MuAfDP5L5VL0rxi=vow@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <1d2da979-78b0-6b94-8e0e-fb0b3c75bd5a@lwfinger.net>
Date:   Wed, 31 Mar 2021 15:16:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CALw23pDmLVSTEN4i7tef9a32jDhBVJ5MuAfDP5L5VL0rxi=vow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/30/21 11:23 PM, Богдан Пилипенко wrote:
> I think this should be enough to reproduce the bug:
> 1) enable UBSAN and KMEMLEAK kernel modules. Those modules - are debugger 
> subsystems and are switched off by default. And without those modules errors 
> will be suppressed.
> 2) activate hardened kernel optimizations. Many other kernel 
> configuration options are in config file (attached in first email).

Богдан,

Thanks for the instructions for enabling UBSAN. I have had kmemleak enabled for 
several years.

The array overrun occurs in the reference to bw40_base[group] in the following 
snippit:

         if (rate <= DESC_RATE11M)
                 tx_power = pwr_idx_2g->cck_base[group];
         else
                 tx_power = pwr_idx_2g->bw40_base[group];

In main.h, bw40_base found in struct rtw_2g_txpwr_idx, as u8 bw40_base[5]. In 
other code, channel 14 is assigned as group 5, which is where the problem 
happens. Unfortunately, if I change to bw40_base[6], reading the efuse breaks, 
and I get an rfe of 255. I'm still working on why that happens, but there is 
obviously another bug somewhere.

I wrote to the developer, and he has some ideas regarding the memory leak. I 
will tackle that problem once I figure out why increasing the dimension breaks 
efuse readout.

Larry

