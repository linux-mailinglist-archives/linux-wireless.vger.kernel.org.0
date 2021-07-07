Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA93BF119
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jul 2021 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhGGU4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jul 2021 16:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhGGU43 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jul 2021 16:56:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B07C061574
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jul 2021 13:53:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t17so7844337lfq.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jul 2021 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6Wp8xx1y13zDv9+ptI8UgWi/fuXwVxT7bTMwaSgknCI=;
        b=HRqY3NwXYMp/7k9uzipTPVp40AirgtiJsS7sB0HoH/1/E7P5wpz9jDBjTuUz+PdmDy
         bdI3sncjwzbTdcNURukKOsBeAUopnXHkmRXW/N4FrUoUnbIrWUzyy8oR01SpiQg3nSUv
         JWUYMB2Ya7NQPXRhq5bTXnQ7QTcsEnkTGzt9PBY1fW5nbRGf4P+dXsOZ1I1D9pdtgAmQ
         uyXP9q3mjsLmeflori4dUMw1RXs7LMrwUHhO6if4Vcfp8woQw2QcEl/8rrZ6bkaHFtcf
         WUHYINYALnV2SIq8mAMxBJ1/Oy8CoG0KqouVPmFNARBTXQlX/mPGhc/QT51XZePZ5eQn
         9HMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Wp8xx1y13zDv9+ptI8UgWi/fuXwVxT7bTMwaSgknCI=;
        b=TNjRl1DMbyz1S2viLsDAi6TSw0cEtbNw3yZcEE7EjC5OTggPl9EFlqH0XyWBRkDUB7
         s3P5UowDEqN48aTitRql/o+JurVE4VhFdI/Ry8kVakXg9GEwdTZB3om02dN8a84/raCa
         7RLLiSa07YiI84p8hWQMtcIwx6Kfu2iWuSV9Xijq1XUV0PgemmjdsKFIjnnLZHY5MZ83
         zBsTIowXndb4C7p6rfkmwkOvvNTrbf64u5dV+/ofz33UxcbYyCvCwQn4sPJvNFFAuc5+
         tmAmrb5IfCfQhzKOvVvcvQOkZHAYzr0Ba3TXdM7jj+qIde+ShZ71v3DagmA9kkQtuA9d
         4wow==
X-Gm-Message-State: AOAM530f8D3GAY5B9jcnsj+/X6UZqtOAfxXHrClDJ9Fod0DaleAHzb/H
        h25rtcMifomxo+Z4In0EfTI=
X-Google-Smtp-Source: ABdhPJzOr/pWWdU6/w7teufg+IjiSjFoLhovNeC7TKbtUreCBIdM4eIomM4VSn0j04ZE7uZ3K2s+Sw==
X-Received: by 2002:a19:e05c:: with SMTP id g28mr20784386lfj.299.1625691227031;
        Wed, 07 Jul 2021 13:53:47 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id s17sm11044ljg.28.2021.07.07.13.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 13:53:46 -0700 (PDT)
Subject: Re: Unstable WiFi with mt76 on MT7628AN
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <7c96d5ee-86c1-8068-1b58-40db6087a24f@gmail.com>
 <88dfb184-7f14-d31a-5e07-668f90c909d8@gmail.com>
Message-ID: <14d485fc-eed4-a65c-747b-a83478da5d8f@gmail.com>
Date:   Wed, 7 Jul 2021 22:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <88dfb184-7f14-d31a-5e07-668f90c909d8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04.07.2021 00:19, Rafał Miłecki wrote:
> It may be worth mentioning I found 1 WARNING in my dmesg. I can't tell
> if that has happened during any slow down / stall or not. Unforunately I
> don't have symbols in my backtrace.
> 
> [ 3245.170684] ------------[ cut here ]------------
> [ 3245.175434] WARNING: CPU: 0 PID: 627 at target-mipsel_24kc_musl/linux-ramips_mt76x8/mt76-2021-05-15-9d736545/mt7603/mac.c:206 0x835e44ac [mt7603e@bb8c9e4c+0x9520]

I've installed OpenWrt snapshot with debug symbols included. I
reproduced the WARNING. It doesn't seem to be related to slow downs /
stalls / no beacons.

[ 3090.333926] ------------[ cut here ]------------
[ 3090.338714] WARNING: CPU: 0 PID: 118 at target-mipsel_24kc_musl/linux-ramips_mt76x8/mt76-2021-06-06-22b69033/mt7603/mac.c:206 mt7603_filter_tx+0x16c/0x174 [mt7603e]
[ 3090.353623] Modules linked in: pppoe ppp_async iptable_nat xt_state xt_nat xt_conntrack xt_REDIRECT xt_MASQUERADE xt_FLOWOFFLOAD xt_CT pppox ppp_generic nf_nat nf_flow_table_hw nf_flow_table nf_conntrack mt7603e mt76 mac80211 ipt_REJECT cfg80211 xt_time xt_tcpudp xt_multiport xt_mark xt_mac xt_limit xt_comment xt_TCPMSS xt_LOG slhc nf_reject_ipv4 nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter ip_tables crc_ccitt compat nf_log_ipv6 nf_log_common ip6table_mangle 
ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 sha256_generic libsha256 seqiv jitterentropy_rng drbg hmac ghash_generic gf128mul gcm ctr cmac ccm leds_gpio gpio_button_hotplug aead cryptomgr crypto_null crypto_hash
[ 3090.417635] CPU: 0 PID: 118 Comm: kworker/u3:0 Not tainted 5.4.128 #0
[ 3090.424186] Workqueue: napi_workq napi_workfn
[ 3090.428616] Stack : 80589abc 835744ac 00000009 00000000 00000000 8005b100 83d64cc0 00000000
[ 3090.437106]         00000017 83c98dbc 8057a6b8 83de5bec 80620000 00000001 83de5bc0 601c1e37
[ 3090.445583]         00000000 00000000 806393c0 00000000 716b726f 000000a0 6f775f69 6e666b72
[ 3090.454070]         00000000 00000099 00000000 000678fa 00000000 00000009 00000000 835744ac
[ 3090.462557]         00000009 00000000 00000000 83580000 00000000 802bbac8 00000000 80780000
[ 3090.471046]         ...
[ 3090.473522] Call Trace:
[ 3090.476017] [<80009c90>] show_stack+0x30/0x100
[ 3090.480542] [<80023ba0>] __warn+0xc0/0x10c
[ 3090.484693] [<80023c48>] warn_slowpath_fmt+0x5c/0xac
[ 3090.489754] [<835744ac>] mt7603_filter_tx+0x16c/0x174 [mt7603e]
[ 3090.495767] [<83574644>] mt7603_wtbl_set_ps+0x12c/0x134 [mt7603e]
[ 3090.501973] [<83571a1c>] mt7603_sta_ps+0x38/0x428 [mt7603e]
[ 3090.507669] [<835547f4>] mt76_rx_poll_complete+0x2e0/0x5b0 [mt76]
[ 3090.513860] [<8355153c>] mt76_dma_rx_poll+0x3d8/0xefc [mt76]
[ 3090.519634] [<8035b3dc>] __napi_poll+0x3c/0x10c
[ 3090.524227] [<8035b4ec>] napi_workfn+0x40/0x90
[ 3090.528751] [<8003b0e8>] process_one_work+0x220/0x480
[ 3090.533878] [<8003b4b0>] worker_thread+0x168/0x5c8
[ 3090.538759] [<800401ec>] kthread+0x138/0x140
[ 3090.543088] [<80005178>] ret_from_kernel_thread+0x14/0x1c
[ 3090.548577] ---[ end trace 068a759ed1654b52 ]---
