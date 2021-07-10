Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD743C2BED
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jul 2021 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGJASv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jul 2021 20:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhGJASu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jul 2021 20:18:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7235BC0613DD
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jul 2021 17:16:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e20so10697929ljn.8
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jul 2021 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Rrc3nU0nhHaWAmztZ48jOguYS+AM4kmahTyZoFtqhpo=;
        b=u/Kc0mACCwDIXRiBNQXFr9FNwvUw7ClR67i7yJ/4jHmFISfgj7E8EVzScYlvqPj64/
         nq2S7qlqfDrOajZIVezZcyA5DDov2E5IF969Cr75DpktOquGRQ+7ZUsS9LZcztAjFAYq
         l5bQV0uwi6wjlTy5Am9GEAkAFe1mNCO/KvYwIDGKoCaloTvTUjGBgCSagolkbtdu/P52
         o7OaHzt39BrpUu18xcPRX70eXWEeKzhCVDj4J/1JkojsJjeR6TJnYQFh5hrNOn7e4+iX
         RDJELFQ90K4H+DfCNEdVCoIq244ElQYGtxMzLiUU4oaYRhhcgSF8hkTF/btVwkv97EPH
         oRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rrc3nU0nhHaWAmztZ48jOguYS+AM4kmahTyZoFtqhpo=;
        b=KRvaF3U9yNB/+ET6K45pIAEkAUbkNnFxWWV0sSrRU5n8OFrNysvkpb7K2j5mnXPl4H
         gAttnS1wvDzNFOFEuopP4eMOvU+YnE/68pJ1RvzXDTcviXuDzkfXNoi6AWgHmRPRaVF1
         B57TToG6h1C9syPr36oS2hc/FQx4yWoCntSzhdpSC0Z1ynL+UkwwNajobYCjvG5QwVx+
         aiONEEFnWpK6cS/j4ylgu+QZbL8Wyzg527+WjjhNPM6bSMwC/hsxXQi7BPvsfuiK1by5
         JOxXr9Ks6XtgWwvSta3vxs5hMoIHl2M7RW9F95xEdI6e83xDmuWdCeKshoPEqPc3iUsk
         80Aw==
X-Gm-Message-State: AOAM532CTX1ZECg170mshcY7S0UFOfTa9bx7vi/O0snFbP8b7+/071pv
        f+J1kgwVBVv2k3S88yh8Egbis+zg4cY=
X-Google-Smtp-Source: ABdhPJz1mwiFYVI29S9vkLAu1LuTV0qcWrA2NyUoPAaDGVuTnistXHWgw4FPgstMWqYLpv6Po9dBWQ==
X-Received: by 2002:a2e:a54a:: with SMTP id e10mr31636499ljn.120.1625876163436;
        Fri, 09 Jul 2021 17:16:03 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id u16sm720429ljj.113.2021.07.09.17.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 17:16:02 -0700 (PDT)
Subject: Re: Unstable WiFi with mt76 on MT7628AN
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <7c96d5ee-86c1-8068-1b58-40db6087a24f@gmail.com>
Message-ID: <297df121-d9d0-d9cd-2614-08c11ca1d748@gmail.com>
Date:   Sat, 10 Jul 2021 02:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <7c96d5ee-86c1-8068-1b58-40db6087a24f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04.07.2021 00:16, Rafał Miłecki wrote:
> I decided to start my adventure with mt76. I bought the cheapest router
> I could find: Xiaomi Mi Router 4C and installed OpenWrt 21.02-rc3 on it.

I found & bought another cheap router with mt76 supported WiFi: Netgear
R6220 with MT7621ST (SoC) + MT7603EN (WiFi) + MT7612EN (WiFi). I even
found some possitive comments on mt76 support for MT7603 but it appears
it's the same story. I decided to focus on 2 GHz (MT7603) for now.

***

First I run vendor's firmware and iperf test for 2 hours. Speeds were
verying between 35 Mb/s and 60 Mb/s but it didn't fail even once:

[  3] 7195.0-7196.0 sec  4.12 MBytes  34.6 Mbits/sec
[  3] 7196.0-7197.0 sec  2.54 MBytes  21.3 Mbits/sec
[  3] 7197.0-7198.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3] 7198.0-7199.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 7199.0-7200.0 sec  5.50 MBytes  46.1 Mbits/sec
[  3]  0.0-7200.3 sec  37.2 GBytes  44.4 Mbits/sec

***

Then I installed OpenWrt 19.07.7 with mt76 from February 2021. It failed
me almost immediately:

[  3]  0.0- 1.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3]  1.0- 2.0 sec  5.38 MBytes  45.1 Mbits/sec
[  3]  2.0- 3.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3]  3.0- 4.0 sec  5.12 MBytes  43.0 Mbits/sec
[  3]  4.0- 5.0 sec  6.38 MBytes  53.5 Mbits/sec
[  3]  5.0- 6.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3]  6.0- 7.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3]  7.0- 8.0 sec  5.88 MBytes  49.3 Mbits/sec
[  3]  8.0- 9.0 sec  6.88 MBytes  57.7 Mbits/sec
[  3]  9.0-10.0 sec  6.12 MBytes  51.4 Mbits/sec
[  3] 10.0-11.0 sec  6.50 MBytes  54.5 Mbits/sec
[  3] 11.0-12.0 sec  5.75 MBytes  48.2 Mbits/sec
[  3] 12.0-13.0 sec  4.38 MBytes  36.7 Mbits/sec
[  3] 13.0-14.0 sec  1.98 MBytes  16.6 Mbits/sec
[  3] 14.0-15.0 sec  1.80 MBytes  15.1 Mbits/sec
[  3] 15.0-16.0 sec  1.74 MBytes  14.6 Mbits/sec
[  3] 16.0-17.0 sec   509 KBytes  4.17 Mbits/sec
[  3] 17.0-18.0 sec   509 KBytes  4.17 Mbits/sec
[  3] 18.0-19.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 19.0-20.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 20.0-21.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 21.0-22.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 22.0-23.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 23.0-24.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 24.0-25.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 25.0-26.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 26.0-27.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 27.0-28.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 28.0-29.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 29.0-30.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 30.0-31.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 31.0-32.0 sec  2.38 MBytes  19.9 Mbits/sec
[  3] 32.0-33.0 sec  5.62 MBytes  47.2 Mbits/sec
[  3] 33.0-34.0 sec  6.75 MBytes  56.6 Mbits/sec
[  3] 34.0-35.0 sec  5.88 MBytes  49.3 Mbits/sec

The most recent OpenWrt with mt76 from June 2021 was no better.

***

Then I focused on iw & station info from MT7603 perspective. That is
where I noticed something interesting. With idle wireless (no real
traffic at all) I could see "rx bitrate" reported by MT7603 for my STA
to drop down to 6 Mbit/s regularly.

 > while [ 1 ]; do date; iw dev wlan0 station dump | grep bitrate; sleep 1; done
Fri Jul  9 16:40:42 UTC 2021
         tx bitrate:     72.2 MBit/s MCS 7 short GI
         rx bitrate:     72.2 MBit/s MCS 7 short GI
Fri Jul  9 16:40:43 UTC 2021
         tx bitrate:     72.2 MBit/s MCS 7 short GI
         rx bitrate:     72.2 MBit/s MCS 7 short GI
Fri Jul  9 16:40:44 UTC 2021
         tx bitrate:     72.2 MBit/s MCS 7 short GI
         rx bitrate:     72.2 MBit/s MCS 7 short GI
Fri Jul  9 16:40:45 UTC 2021
         tx bitrate:     72.2 MBit/s MCS 7 short GI
         rx bitrate:     6.0 MBit/s
Fri Jul  9 16:40:46 UTC 2021
         tx bitrate:     39.0 MBit/s MCS 4
         rx bitrate:     6.0 MBit/s
Fri Jul  9 16:40:47 UTC 2021
         tx bitrate:     26.0 MBit/s MCS 3
         rx bitrate:     6.0 MBit/s
Fri Jul  9 16:40:48 UTC 2021
         tx bitrate:     72.2 MBit/s MCS 7 short GI
         rx bitrate:     72.2 MBit/s MCS 7 short GI
Fri Jul  9 16:40:49 UTC 2021
         tx bitrate:     72.2 MBit/s MCS 7 short GI
         rx bitrate:     72.2 MBit/s MCS 7 short GI
Fri Jul  9 16:40:50 UTC 2021
         tx bitrate:     72.2 MBit/s MCS 7 short GI
         rx bitrate:     72.2 MBit/s MCS 7 short GI

Then I started iperf and noticed that iperf slows down exactly when "iw"
reports lower (6 Mbit/s) "rx rate".

I decided to run iperf with "-b 20M" and got something like:

[  3] 465.0-466.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 466.0-467.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 467.0-468.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 468.0-469.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 469.0-470.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 470.0-471.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 471.0-472.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 472.0-473.0 sec  1.08 MBytes  9.05 Mbits/sec	← "iw" on MT7603 reported lower "rx bitrate" at that moment
[  3] 473.0-474.0 sec  1.55 MBytes  13.0 Mbits/sec
[  3] 474.0-475.0 sec  1.37 MBytes  11.5 Mbits/sec
[  3] 475.0-476.0 sec  1.18 MBytes  9.90 Mbits/sec
[  3] 476.0-477.0 sec   954 KBytes  7.82 Mbits/sec
[  3] 477.0-478.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 478.0-479.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 479.0-480.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 480.0-481.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 481.0-482.0 sec  1.06 MBytes  8.86 Mbits/sec
[  3] 482.0-483.0 sec   255 KBytes  2.09 Mbits/sec
[  3] 483.0-484.0 sec   954 KBytes  7.82 Mbits/sec
[  3] 484.0-485.0 sec  1.93 MBytes  16.2 Mbits/sec
[  3] 485.0-486.0 sec  3.36 MBytes  28.2 Mbits/sec
[  3] 486.0-487.0 sec  6.96 MBytes  58.4 Mbits/sec
[  3] 487.0-488.0 sec  6.90 MBytes  57.9 Mbits/sec
[  3] 488.0-489.0 sec  6.96 MBytes  58.4 Mbits/sec
[  3] 489.0-490.0 sec  5.78 MBytes  48.5 Mbits/sec
[  3] 490.0-491.0 sec  5.07 MBytes  42.5 Mbits/sec
[  3] 491.0-492.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 492.0-493.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 493.0-494.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 494.0-495.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 495.0-496.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 496.0-497.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 497.0-498.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 498.0-499.0 sec  2.38 MBytes  20.0 Mbits/sec
[  3] 499.0-500.0 sec  2.38 MBytes  20.0 Mbits/sec

For few times iperf speed recovered after slow down (as in above log)
but after few successes it has failed and slow down ended up in a
totally stalled traffic.

Then I decided to run iperf with "-b 10M" and got a kind of success:

[  3] 16590.0-16591.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16591.0-16592.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16592.0-16593.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16593.0-16594.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16594.0-16595.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16595.0-16596.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16596.0-16597.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16597.0-16598.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16598.0-16599.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16599.0-16600.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3] 16600.0-16601.0 sec  1.19 MBytes  10.0 Mbits/sec
[  3]  0.0-16601.3 sec  19.3 GBytes  10.0 Mbits/sec

I had iperf running for 4,5 hours with only 1 slow down but that was
very stable after all and I reached a record of stable WiFi time!

***

So it seems there are two problems I managed to narrown down:

1. On MT7603 "rx bitrate" of STA drops 72.2 → 6 MBit/s regularly
2. When catching up with traffic (after slow down) WiFi occasionally stalls
