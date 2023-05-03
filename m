Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF26F5A52
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjECOmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjECOmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 10:42:36 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095784EC9
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 07:42:35 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-54cb8d72c0bso873195eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 May 2023 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683124954; x=1685716954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2rusHjEcWq3BS1GB5CQ/lx4TsPz5kUxhNSWkoO6jhIk=;
        b=cbrF6l5vQW9PGU3mPT4IdEZQJDeEwF+cFTs2G6IOcH1nrUYO8Kqj/HZy0RVktFqBWT
         Tg1gRfteeQk+Wj0SuP9yOL7wMdotqwg1IjkQ4g/Vwk72/JrO3gb9AM6eeJeH+9hLdIn+
         ny51omdW/fbVidOOMO2mgOQol853CiLprNlQG97/Ilh2xSxnovP3OxexfZKc9KwzDowf
         SMFhTzzqIVnL4PotXx9jrV3zEnA1DO39RdzNsFJtTG7afgmeh9i2iHT9rkSl5WnzLuOe
         mRYdOkeXekmqNyYNLOyGn3yjbyidF1Q30q1wp5ej/lqjZ82kmxc8zw2T7aqU40ME01xm
         l1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124954; x=1685716954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rusHjEcWq3BS1GB5CQ/lx4TsPz5kUxhNSWkoO6jhIk=;
        b=fJA4e5NTr4yfLqqWk74TtszefEXw8XhiwunR5t7zRwvmkB5I8IHAAEuVE8ChgEe0SX
         Sm+ZXG/og7mDHt0in4mKhtq/Csz1OBInuBXJH18MUwsqk7rBdzCJswHdhGl01Y1C7wjd
         z2o7pSzgMuy6BEwMArqRd0mQme04iBd3nM2Rq2tSBc/pioU26rCCyoV0fkNYO2A7rth7
         nbb8gX6Mlyt9QFMjDM0ipg/lSpVni2+cJwf4MbSxEiXuBE9Tvf1YRgLM4wMgbHIYFiCY
         gXmXg09rAbzdGHyyHl9UJfhfCeArO0nZYFA+fKJGL2AT3VSrQm+iy5FzzkUoN6lkOyj5
         Rbbw==
X-Gm-Message-State: AC+VfDy0xH3Mnlx8oe7oxplAItwCFeMlSYKshjgwN5+lKbUM2VMTf1uE
        ij9H8lgQRk4dtB7HtVS5WC8=
X-Google-Smtp-Source: ACHHUZ5e8Lcg2LCru4e4Ykw/66Fl0vHNjJFVBcVZo4aONfEsEoOxtlxNqCPFhantx1fb45HUMITfdA==
X-Received: by 2002:a05:6820:167:b0:544:e1f8:f990 with SMTP id k7-20020a056820016700b00544e1f8f990mr9898373ood.9.1683124954325;
        Wed, 03 May 2023 07:42:34 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r16-20020a4ad4d0000000b00541cb3cf2d2sm2251324oos.13.2023.05.03.07.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 07:42:33 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b7a59145-37b0-eade-3a9e-b565cc75de35@lwfinger.net>
Date:   Wed, 3 May 2023 09:42:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Slow RTL8822CE 802.11ac PCIe Wireless Network Adapter
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <75906666-df37-988a-c448-a6338b8a1cff@amd.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <75906666-df37-988a-c448-a6338b8a1cff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/3/23 02:13, Alexey Kardashevskiy wrote:
> Hi!
> 
> I am seeing dropouts in 5GHz and 2.5GHz wifi and seeking for help.
> 
> HP laptop with RTL8822CE 802.11ac PCIe Wireless Network Adapter, Fedora36 with 
> 6.2.9-100.fc36.x86_64, the AP is Ubiquity, it is 5m away behind a thin wall, a 
> house in low density area (I do not see neighbors APs in "iw dev scan").
> 
> Pinging a gateway (1gbit ethernet between AP and GW) suddenly goes from 3-5ms to 
>  >1000ms. Good and bad "iw" output is below. Moving laptop by 2cm (or its lid) 
> helps sometime.
> 
> These 2 observation made me suspect the linux driver:
> 
> 1) If I reboot the laptop to Windows10 without moving/touching it after it went 
> bad in linux - there pings are 1-2ms and occasionally may go up to hundreds but 
> for a very short time, feels like the driver notices something and fixes it.
> 
> 2) Two other laptops with Intel Wifi cards on the same spot with the same fedora 
> on the same network do not show the problem at all.
> 
> Changing txpower 10..23dBm (where 2300 is the maximum) does not help, done via 
> "iw dev wlp1s0 set txpower limit 2300", "iw dev wlp1s0 info" confirms that it 
> changes.
> 
> I have these in /etc/modprobe.d/50-rtw88.conf
> options rtw88_core disable_lps_deep=y
> options rtw88_pci disable_aspm=y
> no change either.
> 
> Is there anything else to try? Thanks,
> 
> 
> 64 bytes from _gateway (192.168.10.200): icmp_seq=26 ttl=64 time=6.97 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=27 ttl=64 time=3.68 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=28 ttl=64 time=3.44 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=29 ttl=64 time=3.97 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=30 ttl=64 time=3.68 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=31 ttl=64 time=17.0 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=32 ttl=64 time=33.1 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=33 ttl=64 time=697 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=34 ttl=64 time=1130 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=35 ttl=64 time=114 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=36 ttl=64 time=1796 ms
> 64 bytes from _gateway (192.168.10.200): icmp_seq=37 ttl=64 time=749 ms
> 
> Good status:
> 
> [root@aiemdeew wlp1s0]# iw dev wlp1s0 info ; iw wlp1s0 link
> Interface wlp1s0
>      ifindex 2
>      wdev 0x1
>      addr 50:c2:e8:5d:ba:fd
>      type managed
>      wiphy 0
>      channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
>      txpower 22.00 dBm
>      multicast TXQ:
>          qsz-byt    qsz-pkt    flows    drops    marks    overlmt    hashcol    
> tx-bytes    tx-packets
>          0    0    0    0    0    0    0    0        0
> Connected to f4:92:bf:04:1a:ce (on wlp1s0)
>      SSID: aikhomenet
>      freq: 5180
>      RX: 37035326 bytes (60439 packets)
>      TX: 2880943 bytes (14231 packets)
>      signal: -53 dBm
>      rx bitrate: 130.0 MBit/s VHT-MCS 7 VHT-NSS 2
>      tx bitrate: 390.0 MBit/s VHT-MCS 4 80MHz short GI VHT-NSS 2
> 
>      bss flags:    short-slot-time
>      dtim period:    2
>      beacon int:    100
> 
> 
> Bad status:
> 
> Interface wlp1s0
>          ifindex 2
>          wdev 0x1
>          addr 50:c2:e8:5d:ba:fd
>          type managed
>          wiphy 0
>          channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
>          txpower 22.00 dBm
>          multicast TXQ:
>                  qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol 
> tx-bytes        tx-packets
>                  0    0    0    0    0    0    0    0               0
> Connected to f4:92:bf:04:1a:ce (on wlp1s0)
>          SSID: aikhomenet
>          freq: 5180
>          RX: 38078401 bytes (68758 packets)
>          TX: 3039702 bytes (15006 packets)
>          signal: -62 dBm
>          rx bitrate: 117.0 MBit/s VHT-MCS 6 VHT-NSS 2
>          tx bitrate: 433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1
> 
>          bss flags:    short-slot-time
>          dtim period:    2
>          beacon int:     100
> 

Something certainly changed for your signal strength to drop from -53 to -62 
dBm. The higher value is acceptable, but will not provide high data rates. The 
lower value is marginal.

There are some changes between kernel 6.2 and the current contents of the 
wireless-next repo, which is the code to be found in kernel 6.4 when it is 
released. Could you try the code in https://github.com/lwfinger/rtw88.git? This 
repo has the code found in wireless-next modified to build on older kernels. You 
would need to blacklist rtw88_8822ce. This sequence should do it for you:

sudo dnf install git kernel-headers kernel-devel
sudo dnf group install "C Development Tools and Libraries"
git clone https://github.com/lwfinger/rtw88.git
cd rtw88
make
sudo make install
sudo touch /usr/lib/modprobe.d/50-blacklist-8822ce.conf

As root, using your favorite editor, add the following line to the above file:
blacklist rtw88_8822ce

Then reboot. Report if there are any changes. This way, we will be able to 
determine if the problem has already been fixed.

Larry



