Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67713C35A4
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jul 2021 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhGJQ4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jul 2021 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhGJQ4b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jul 2021 12:56:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E062C0613DD
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 09:53:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x25so17880794lfu.13
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LEif6MhjuDTToJ6y8srsj32fxT4aTdSBirOdM87TYQc=;
        b=kwuYC1KymC/qQjpuWfBV6lWNGqvCOdVgGVCpQ19zMrRnKcXYxlIjaiBD5nUqLNmTf1
         Y78+529XzYWLKBLjeAN8k58pp/Yov/RDR58t7ptpcrNJtpDuHuLZD/hSiIOGAZrLQcMd
         Ruu/Xp4ZyUWskz3NSmxAkV+i/4hvG9JG494OoyifL25VWHFXYwv6/UN8DIn8CJHZv3AF
         z5AujXE97v2L+Dw+GeWOMYQx2poYGPGqbqW+8dZCwfdmGFz+VPQ24gJwPIWcm+gLpacm
         kiunZCgnMttcFFNM9utv7TTxu5NR9IICSLwEysmm7/Dq8fusp5/y/+3lFvJTPTRHUqKG
         LhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEif6MhjuDTToJ6y8srsj32fxT4aTdSBirOdM87TYQc=;
        b=i1rVmsdQPXBC7GXUbCP+NWxsXmKuzXlG3lqztxqovQGQ4glxtuvwFqjbO+apEsDzai
         R0i/m+X8+HkDEKnnVi/Qll7X+XiL4T6H3KHAv4Daelkd9FSLz5QjviXlyWPo0XO575tP
         EjnXFid5yuszbG4dxi+T/BfUmFdrUm6SBShgK019MbAaLYK2KgRxaI5nnZmcUBirJpau
         /bTa8nIdOAZsRWiMTxTDGb6eQOUt74lmO+IX5L0qKkJyQAniY6cXJVqlL//lCem9iwNJ
         Hxgv2VjEFjRuPQz1QFlIfSauzAs6iGjOrGzqpzSmnqkXBBXs2T6PyeRvJI5tYuV0vnux
         fsCQ==
X-Gm-Message-State: AOAM530NiObRGH3cB0kGuhktTItHYUKqmGlNp2TFWzEDtCZfUsQ+lNar
        d/KLG5Fzl/4/Ac6mY0ekJk0M4xgZfKQ=
X-Google-Smtp-Source: ABdhPJwBWohGuh9cJq0VhVi+p9i9Lb3SS5SbOVp6iY79T/PyY/QhNfDVF4/ouuoDIVBEYKqC0kmTqw==
X-Received: by 2002:a05:6512:3604:: with SMTP id f4mr9938678lfs.187.1625936024648;
        Sat, 10 Jul 2021 09:53:44 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id f18sm745066lfc.251.2021.07.10.09.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 09:53:43 -0700 (PDT)
Subject: Re: Unstable WiFi with mt76 on MT7628AN
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <7c96d5ee-86c1-8068-1b58-40db6087a24f@gmail.com>
 <297df121-d9d0-d9cd-2614-08c11ca1d748@gmail.com>
Message-ID: <59778829-4850-7b16-e81a-afcdc111eaf5@gmail.com>
Date:   Sat, 10 Jul 2021 18:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <297df121-d9d0-d9cd-2614-08c11ca1d748@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10.07.2021 02:16, Rafał Miłecki wrote:
> So it seems there are two problems I managed to narrown down:
> 
> 1. On MT7603 "rx bitrate" of STA drops 72.2 → 6 MBit/s regularly
> 2. When catching up with traffic (after slow down) WiFi occasionally stalls

Today I decided to use my Netgear R6220's 5 GHz (MT7612EN).

On that chipset "rx bitrate" reported for my STA stays between 292 and
390 for most of them time BUT is also regularly drops to 6 Mbps:

 > while [ 1 ]; do date; iw dev wlan1 station dump | grep bitrate; sleep 1; done

Sat Jul 10 15:00:27 UTC 2021
         tx bitrate:     292.5 MBit/s VHT-MCS 7 80MHz VHT-NSS 1
         rx bitrate:     390.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 1
Sat Jul 10 15:00:28 UTC 2021
         tx bitrate:     433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1
         rx bitrate:     390.0 MBit/s VHT-MCS 8 80MHz short GI VHT-NSS 1
Sat Jul 10 15:00:29 UTC 2021
         tx bitrate:     433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1
         rx bitrate:     325.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 1
Sat Jul 10 15:00:30 UTC 2021
         tx bitrate:     390.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 1
         rx bitrate:     6.0 MBit/s
Sat Jul 10 15:00:32 UTC 2021
         tx bitrate:     292.5 MBit/s VHT-MCS 7 80MHz VHT-NSS 1
         rx bitrate:     6.0 MBit/s
Sat Jul 10 15:00:33 UTC 2021
         tx bitrate:     390.0 MBit/s VHT-MCS 8 80MHz short GI VHT-NSS 1
         rx bitrate:     325.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 1
Sat Jul 10 15:00:34 UTC 2021
         tx bitrate:     292.5 MBit/s VHT-MCS 7 80MHz VHT-NSS 1
         rx bitrate:     325.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 1
Sat Jul 10 15:00:35 UTC 2021
         tx bitrate:     390.0 MBit/s VHT-MCS 8 80MHz short GI VHT-NSS 1
         rx bitrate:     325.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 1
Sat Jul 10 15:00:36 UTC 2021
         tx bitrate:     390.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 1
         rx bitrate:     325.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 1

Whenever it drops to 6 MBit/s I can see iperf slowing down from 150 -
180 Mb/s down to 100 - 130 Mb/s;

[  3] 19148.0-19149.0 sec  19.1 MBytes   160 Mbits/sec
[  3] 19149.0-19150.0 sec  21.9 MBytes   184 Mbits/sec
[  3] 19150.0-19151.0 sec  18.6 MBytes   156 Mbits/sec
[  3] 19151.0-19152.0 sec  21.2 MBytes   178 Mbits/sec
[  3] 19152.0-19153.0 sec  15.6 MBytes   131 Mbits/sec ← "iw" on MT7612EN reported 6 Mb/s "rx bitrate" at that moment
[  3] 19153.0-19154.0 sec  18.8 MBytes   157 Mbits/sec
[  3] 19154.0-19155.0 sec  20.0 MBytes   168 Mbits/sec
[  3] 19155.0-19156.0 sec  20.4 MBytes   171 Mbits/sec
[  3] 19156.0-19157.0 sec  19.6 MBytes   165 Mbits/sec
[  3] 19157.0-19158.0 sec  20.2 MBytes   170 Mbits/sec
[  3] 19158.0-19159.0 sec  21.6 MBytes   181 Mbits/sec

(...)

[  3] 19207.0-19208.0 sec  18.4 MBytes   154 Mbits/sec
[  3] 19208.0-19209.0 sec  18.1 MBytes   152 Mbits/sec
[  3] 19209.0-19210.0 sec  17.6 MBytes   148 Mbits/sec
[  3] 19210.0-19211.0 sec  18.6 MBytes   156 Mbits/sec
[  3] 19211.0-19212.0 sec  22.2 MBytes   187 Mbits/sec
[  3] 19212.0-19213.0 sec  15.1 MBytes   127 Mbits/sec ← "iw" on MT7612EN reported 6 Mb/s "rx bitrate" at that moment
[  3] 19213.0-19214.0 sec  16.9 MBytes   142 Mbits/sec
[  3] 19214.0-19215.0 sec  17.1 MBytes   144 Mbits/sec
[  3] 19215.0-19216.0 sec  20.2 MBytes   170 Mbits/sec
[  3] 19216.0-19217.0 sec  21.1 MBytes   177 Mbits/sec
[  3] 19217.0-19218.0 sec  21.6 MBytes   181 Mbits/sec

(...)

[  3] 19267.0-19268.0 sec  15.9 MBytes   133 Mbits/sec
[  3] 19268.0-19269.0 sec  18.2 MBytes   153 Mbits/sec
[  3] 19269.0-19270.0 sec  17.2 MBytes   145 Mbits/sec
[  3] 19270.0-19271.0 sec  17.0 MBytes   143 Mbits/sec
[  3] 19271.0-19272.0 sec  18.2 MBytes   153 Mbits/sec
[  3] 19272.0-19273.0 sec  15.2 MBytes   128 Mbits/sec ← "iw" on MT7612EN reported 6 Mb/s "rx bitrate" at that moment
[  3] 19273.0-19274.0 sec  14.0 MBytes   117 Mbits/sec ← "iw" on MT7612EN reported 6 Mb/s "rx bitrate" at that moment
[  3] 19274.0-19275.0 sec  18.9 MBytes   158 Mbits/sec
[  3] 19275.0-19276.0 sec  16.9 MBytes   142 Mbits/sec
[  3] 19276.0-19277.0 sec  18.6 MBytes   156 Mbits/sec
[  3] 19277.0-19278.0 sec  16.2 MBytes   136 Mbits/sec
[  3] 19278.0-19279.0 sec  23.9 MBytes   200 Mbits/sec
[  3] 19279.0-19280.0 sec  21.1 MBytes   177 Mbits/sec

(...)

[  3] 19297.0-19298.0 sec  21.6 MBytes   181 Mbits/sec
[  3] 19298.0-19299.0 sec  19.9 MBytes   167 Mbits/sec
[  3] 19299.0-19300.0 sec  22.9 MBytes   192 Mbits/sec
[  3] 19300.0-19301.0 sec  21.4 MBytes   179 Mbits/sec
[  3] 19301.0-19302.0 sec  19.6 MBytes   165 Mbits/sec

[  3] 19302.0-19303.0 sec  15.0 MBytes   126 Mbits/sec ← "iw" on MT7612EN reported 6 Mb/s "rx bitrate" at that moment
[  3] 19303.0-19304.0 sec  11.0 MBytes  92.3 Mbits/sec
[  3] 19304.0-19305.0 sec  11.2 MBytes  94.4 Mbits/sec

[  3] 19305.0-19306.0 sec  20.1 MBytes   169 Mbits/sec
[  3] 19306.0-19307.0 sec  18.4 MBytes   154 Mbits/sec
[  3] 19307.0-19308.0 sec  21.1 MBytes   177 Mbits/sec
[  3] 19308.0-19309.0 sec  22.6 MBytes   190 Mbits/sec
[  3] 19309.0-19310.0 sec  21.5 MBytes   180 Mbits/sec
[  3] 19310.0-19311.0 sec  20.0 MBytes   168 Mbits/sec

In 5 GHz case however mt76 successfully recovers from all those slow
downs. Traffic didn't stop for good not even once. I had it running
for over 5 hours:

[  3]  0.0-19330.1 sec   352 GBytes   157 Mbits/sec
