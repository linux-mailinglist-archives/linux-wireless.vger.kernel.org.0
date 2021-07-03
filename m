Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11B3BAA86
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jul 2021 00:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhGCWVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Jul 2021 18:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhGCWVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Jul 2021 18:21:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A912DC061762
        for <linux-wireless@vger.kernel.org>; Sat,  3 Jul 2021 15:19:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q18so25188291lfc.7
        for <linux-wireless@vger.kernel.org>; Sat, 03 Jul 2021 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FtibRfyROtBzthClqwf8DBFw51O6T2jP1B/HiPBaxmQ=;
        b=N9lAll0hhAcSd+pqNzhFFSxE1yVtUVUJkX/FiLy7/gqCLD8xvWXzQv0IPHjDcJoJq5
         1OJKvRjlnXxX5l6M+Fqq7fmsdZJdCamB3hQpKqNiDR0MukJnB9HNnflrzeQyxidiymNC
         B8e66+gYabefeMubFbuss+7ZUQLsjbOOR8K3pc6vPHd5QS+n3srrg2ohvpVhL8WDNSjn
         s08I2ppS1ypaR8QFqJWHmewjBI5JsGYRIXtpxny3C8CLyxG/8XNSzLndDDSkg/0CaSVL
         aZFKVFq+32s9LKyewBAGyuLdK4PPF3O7+Qy5hSPZH0eTSLhgbHjzeVJZOqrLTh826jqY
         eJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FtibRfyROtBzthClqwf8DBFw51O6T2jP1B/HiPBaxmQ=;
        b=AW473caDudFo22Xq6FkAkT+xwkduIY7ma2xX8W8y9Eq1pNSktWkoQCVrp9lgyLXOXX
         jO2MmawzfG9RKrI1COxzHRKstqaJdR0ruT/erOGbqvcHROCK+GHthRjz9UvDLkZSDEBU
         NCsjZd+m6P7vQegw5dgALovBIRfBMGsGnEucUaWzjirAtLQgrdiVZzpMe8xThMe3FAll
         safsea1hfag3/hdBYXCI3eGThmgw2XjFmSPLbkFzMqvUy7C+tqYgXP8Fet3JBiV68QS8
         Y4CyKcgr3Q588FoNJCO093OG1txuMwUktEdQFLagNGnN0xHCJPZeWaQjbaSwBQh0AVad
         NgAQ==
X-Gm-Message-State: AOAM53357oGU+KxGGkoMSY1bB+nU7aURBic9ijCYo1D5ejWQwSpROG3w
        s7t8ZjbMaJawWBhn8xnT8P9afptpDjY=
X-Google-Smtp-Source: ABdhPJzEoR2S2TMrEdhtibXub285vz9EUEmH7pYztAl2sLxDUHb+ePFb29RP9c3el7qAjRlNMYxgGQ==
X-Received: by 2002:a05:6512:1506:: with SMTP id bq6mr4783548lfb.12.1625350752761;
        Sat, 03 Jul 2021 15:19:12 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id w13sm871552ljd.27.2021.07.03.15.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 15:19:12 -0700 (PDT)
Subject: Re: Unstable WiFi with mt76 on MT7628AN
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <7c96d5ee-86c1-8068-1b58-40db6087a24f@gmail.com>
Message-ID: <88dfb184-7f14-d31a-5e07-668f90c909d8@gmail.com>
Date:   Sun, 4 Jul 2021 00:19:09 +0200
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
> My problem is unstable WiFi (as vague as this description is). I often
> experience stalls (I can't even see beacons) and sometimes some slow
> downs. I started using this device about 6 hours ago and experienced 3
> or 4 traffic stops with no beacons.

It may be worth mentioning I found 1 WARNING in my dmesg. I can't tell
if that has happened during any slow down / stall or not. Unforunately I
don't have symbols in my backtrace.

[ 3245.170684] ------------[ cut here ]------------
[ 3245.175434] WARNING: CPU: 0 PID: 627 at target-mipsel_24kc_musl/linux-ramips_mt76x8/mt76-2021-05-15-9d736545/mt7603/mac.c:206 0x835e44ac [mt7603e@bb8c9e4c+0x9520]
[ 3245.190168] Modules linked in: pppoe ppp_async iptable_nat xt_state xt_nat xt_conntrack xt_REDIRECT xt_MASQUERADE xt_FLOWOFFLOAD xt_CT pppox ppp_generic nf_nat nf_flow_table_hw nf_flow_table nf_conntrack mt7603e mt76 mac80211 ipt_REJECT cfg80211 xt_time xt_tcpudp xt_multiport xt_mark xt_mac xt_limit xt_comment xt_TCPMSS xt_LOG slhc nf_reject_ipv4 nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter ip_tables crc_ccitt compat nf_log_ipv6 nf_log_common ip6table_mangle 
ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 leds_gpio gpio_button_hotplug
[ 3245.241986] CPU: 0 PID: 627 Comm: kworker/u3:1 Not tainted 5.4.124 #0
[ 3245.248532] Workqueue: napi_workq 0x80353380
[ 3245.252871] Stack : 805a0000 834ff700 80505c80 835e44ac 00000000 00000000 00000000 00000000
[ 3245.261358]         00000000 00000000 00000000 00000000 00000000 00000001 83629bb8 985d1d7f
[ 3245.269844]         83629c50 00000000 00000000 00000000 00000038 804eb7e4 616e203a 775f6970
[ 3245.278337]         00000000 000000a1 00000000 0003cad4 00000000 83629b98 00000000 835e44ac
[ 3245.286827]         00000009 00000002 00000002 835f0000 00000003 802b8bdc 00000000 806f0000
[ 3245.295314]         ...
[ 3245.297802] Call Trace:
[ 3245.297833] [<835e44ac>] 0x835e44ac [mt7603e@bb8c9e4c+0x9520]
[ 3245.306164] [<804eb7e4>] 0x804eb7e4
[ 3245.309725] [<835e44ac>] 0x835e44ac [mt7603e@bb8c9e4c+0x9520]
[ 3245.315571] [<802b8bdc>] 0x802b8bdc
[ 3245.319131] [<80009790>] 0x80009790
[ 3245.322680] [<80009798>] 0x80009798
[ 3245.326227] [<800236d0>] 0x800236d0
[ 3245.329783] [<835e44ac>] 0x835e44ac [mt7603e@bb8c9e4c+0x9520]
[ 3245.335623] [<80023778>] 0x80023778
[ 3245.339181] [<835e44ac>] 0x835e44ac [mt7603e@bb8c9e4c+0x9520]
[ 3245.345018] [<80351c4c>] 0x80351c4c
[ 3245.348594] [<835e4644>] 0x835e4644 [mt7603e@bb8c9e4c+0x9520]
[ 3245.354440] [<835d598c>] 0x835d598c [mt76@879d366c+0x93a0]
[ 3245.360021] [<835d3538>] 0x835d3538 [mt76@879d366c+0x93a0]
[ 3245.365614] [<835e1a1c>] 0x835e1a1c [mt7603e@bb8c9e4c+0x9520]
[ 3245.371470] [<835d47d0>] 0x835d47d0 [mt76@879d366c+0x93a0]
[ 3245.377089] [<835d153c>] 0x835d153c [mt76@879d366c+0x93a0]
[ 3245.382669] [<804f0cc8>] 0x804f0cc8
[ 3245.386216] [<803533a4>] 0x803533a4
[ 3245.389786] [<803532b0>] 0x803532b0
[ 3245.393342] [<803533a4>] 0x803533a4
[ 3245.396899] [<803533c0>] 0x803533c0
[ 3245.400447] [<804ec9c0>] 0x804ec9c0
[ 3245.403988] [<8003ac64>] 0x8003ac64
[ 3245.407547] [<8003b02c>] 0x8003b02c
[ 3245.411095] [<8003aec4>] 0x8003aec4
[ 3245.414642] [<804ecbf8>] 0x804ecbf8
[ 3245.418202] [<8003aec4>] 0x8003aec4
[ 3245.421750] [<8003fd68>] 0x8003fd68
[ 3245.425298] [<8003fc30>] 0x8003fc30
[ 3245.428852] [<8003fc30>] 0x8003fc30
[ 3245.432407] [<800050b8>] 0x800050b8
[ 3245.435945]
[ 3245.437468] ---[ end trace 9c6fbf57c9d56e22 ]---
