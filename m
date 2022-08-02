Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368DD5881FD
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiHBSoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 14:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHBSo3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 14:44:29 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6597113F97
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 11:44:28 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so12997276fac.7
        for <linux-wireless@vger.kernel.org>; Tue, 02 Aug 2022 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=+XsE+OopyuzztJ+pxpVQQsVY8jaf6eSQz2rL4ugn8Mk=;
        b=edG6+71Wq59ytY6zh1plOog+WHFUHm9oJO5s1k7OWBu3oduz50rlsnRDaNs/mzPcw6
         p6+FUnM0IZum9iagwiq7npDJQxoPmwg2rbNQrxhSNilX5BXsDRm/SrgJwLJnKd/oXC5U
         NpEv0kQ/hkOZMfSrBCecacYLQgWUhcwqIy6xLPLl3ngiOaXziHhue1xEQz73jjqe+OTT
         ZhANqVGeKxZjWUaF8xmOTroDqhC1+pJ0ck0Y3jHXJ/zFS0AQsiuD31LOJf0MEB5piu9X
         RE8FWwotYfB7/4Wb4CJOrDWQ2vWRSwEFKeU5rrnkvQKfcmegZls7ZXbntI5DY5dBDkJC
         Slmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=+XsE+OopyuzztJ+pxpVQQsVY8jaf6eSQz2rL4ugn8Mk=;
        b=5eDGMyu7C3eUnX/H3BRUKl/zrq6wBGJ6p/2ZLG7f5Em6V8ft2k16cQqy36lrlMvsRq
         fRB2msTT/KFlALALD97YfIoi/8kr4Sl+Ceff5DT1boveK7cyFR639nWKjWn7KNi3cJIM
         9+/AJeRIDhBeQ78/EYBTW7G1aA8dAsNn5mlC2CzFiNzLSmifLeK3suU4zgHJXqO/ylXG
         A2thK390no1XlGGbCzZNPkLHXcPrGQsBtngSz7YfHYi9QP5+2lw/WdTgGssOqKpNpF4Q
         oICHpA2w4EHro1OcYuES1h1q/akVvmubBTS8r3tBGhOXuLjaoow9RflS0o0aAk10irW3
         VsfQ==
X-Gm-Message-State: ACgBeo0wWpC4EfkXP6o0UZSngmkJiSR97NkOWv8kjnj/8sEk4sYc8g4d
        aF0w626BP1f9mr9VZn21Fpxt0Uc+I4s=
X-Google-Smtp-Source: AA6agR5NPZl4Fl91MR9jfMbosLPmPDIPiHyQHxMsLez2pOpPbxgmqLx+0yM2qE48UNStjh1qCZ7TtA==
X-Received: by 2002:a05:6870:2191:b0:10e:75b7:4316 with SMTP id l17-20020a056870219100b0010e75b74316mr365345oae.184.1659465867529;
        Tue, 02 Aug 2022 11:44:27 -0700 (PDT)
Received: from [10.62.118.101] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r18-20020a9d7cd2000000b0061d26f894fasm3531719otn.73.2022.08.02.11.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 11:44:26 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <a93c3af3-2102-93f2-79f8-6fc83ca2d5cc@lwfinger.net>
Date:   Tue, 2 Aug 2022 13:44:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Terrible performance form Lenovo Ideapad using RTL8852AE 802.11ax
 on 5.17 kernel (ubuntu)
Content-Language: en-US
To:     Andrew than <linux_kernel_aathan@memeplex.com>,
        linux-wireless@vger.kernel.org
References: <0cdbbf6f-5003-946b-7910-dbfbb83ee31b@memeplex.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <0cdbbf6f-5003-946b-7910-dbfbb83ee31b@memeplex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/2/22 12:53, Andrew than wrote:
> Hello all:
> 
> Please direct me on what additional information I can provide.
> 
> I recently added a Lenovo Ideapad to my wifi network. Two mac hosts on that 
> network experience no issue whatsoever with the network (desktop + macpro laptop).
> 
> A simple scp test between the desktop & macpro vs desktop & lenovo yields a 50% 
> difference in throughput.
> 
> Interactive performance of ssh is horrible vs the lenovo. I looked but didn't 
> find any TCP_NODELAY / Nagel's related settings for sshd. However, the scp 
> performance leads me to believe that's not the issue.
> 
> I've seen other reports of slow performance of these cards/drivers (e.g. 
> https://github.com/lwfinger/rtw89/issues/36)
> 
> Any ideas?
> 
> 
> 
>    *-network
>         description: Wireless interface
>         product: RTL8852AE 802.11ax PCIe Wireless Network Adapter
>         vendor: Realtek Semiconductor Co., Ltd.
>         physical id: 0
>         bus info: pci@0000:03:00.0
>         logical name: wlo1
>         version: 00
>         serial: 14:5a:fc:01:c2:xx
>         width: 64 bits
>         clock: 33MHz
>         capabilities: pm msi pciexpress bus_master cap_list ethernet physical 
> wireless
>         configuration: broadcast=yes driver=rtw89_pci 
> driverversion=5.17.0-1014-oem firmware=N/A ip=192.168.x.x latency=0 link=yes 
> multicast=yes wireless=IEEE 802.11
>         resources: irq:64 ioport:2000(size=256) memory:d1600000-d16fffff
> 

I reported this at the GitHub repo, but I will put it here for others to see.

I tried your scp test with a 204 MB file. Using the 5G band on a wifi5 router 
(AC1900), I got 49.2 MBps (399 Mbps) for uploads and 64.0 MBps (511 Mbps) for 
downloads. The other end was a desktop connected to the network via a wire. 
Using my local speedtest, I got 587 Mbps down and 481 Mbps up. With file reads 
and writes, scp should be a little slower than speedtest. My signal reported by 
'iw dev ... scan' is -45 dBm.

You did not tell me what your kernel is, but from the name (rtw89_pci), I see 
that you are using the in-kernel version. The one from this repo, which I am 
using, would be rtw89pci with no underscore.

Larry

