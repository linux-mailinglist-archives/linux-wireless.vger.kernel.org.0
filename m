Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB45A390D6E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 May 2021 02:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhEZAlu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 20:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhEZAlu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 20:41:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A6C061756
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 17:40:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v8so43837203lft.8
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ypVMTn6I7nsagousMXgHvo+LlfnyFeUFfmChgDMMp1A=;
        b=j3MZryKZPjJpMCTmfi00Q8OPFtMaRd6sIvLyIr/my6dmWSLbb9tfGi9WM0i8tJF5TG
         Ws7LaWQ+bIF5cXIr/FjCnYtAPe0v6/GX+YanyF1jr/5hV1q995pJEEK9ORjTSynOb/t8
         o0/b6eA4jbnHdH5ACDpMJi7QPoXlfRFP43ZnxcTdjb6Eve2kClYtPSsqPa9avWxpDv2Q
         i/Cg1cy/L13LY+ku4KmtxC0R/f0BFAou204y+zkAqw4EgnAAU8vXYKpkeMM3vJxaY5fd
         ZFB7DSQLwXdOAoN1B7DY6zXRfaxb6Xar996ydW0HoA9PVWOJ4RMfZqHngG3Lc+fDU3vH
         OeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ypVMTn6I7nsagousMXgHvo+LlfnyFeUFfmChgDMMp1A=;
        b=rESWeodwgmLz4i376zXxTW1gq2lXJGjxbEl6b0Nx4j5GAm1n9vTZWMtXZv59Qmtmdk
         OVAQpIsP2KRPz03kES1ZSkU3GobaZtthQngCvZmnQ4Zwf+6xE+z5KgCaEcSGRU0gl0UQ
         wcnpJ72XapeMK7l8yhkrFBPzjA6FoLKZmA9b7lVxRcb6FOAFdsdor6IV8+9NfQRYQ2Lk
         TM+Qh4IuMjB1MmmEiYYedJChkUDoqDwWzKLH4UFSnAVEn0YP5/p1Cas8Xi1HC0099vjw
         uzA2T3Oa3s1RsfnWp2NcExQ6A+PPnu6ALDWZEncSKVLrYhSIGDZk0mN2vTu9TKaQM1vo
         gYDQ==
X-Gm-Message-State: AOAM530g8km9b4R5zR/0EHg0aY36C/HIFXgfZ0LxPHHmfFXaOxREFl11
        sTXZp4bjyXy8wTSQyQsZkKc/JcZv60tOAfIOpeA=
X-Google-Smtp-Source: ABdhPJz87YSsBwtBaFfNRE1dUxbbpX1EeVZk2axI1UZgH2m6pnnVivmKVu+jb/vFl60qRO6zkveiRjPjqdJ18roeKiA=
X-Received: by 2002:a05:6512:1191:: with SMTP id g17mr210922lfr.500.1621989616610;
 Tue, 25 May 2021 17:40:16 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 May 2021 21:40:05 -0300
Message-ID: <CAOMZO5DPAr0XPHefewjF2fx7UL+7RvycAYLZdfosOUT6bwWHBA@mail.gmail.com>
Subject: ath10k_sdio: Long time for loading firmware and RCU errors
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>, gerg@kernel.org,
        erik.stromdahl@gmail.com, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am using the QCA9377 chip on an imx6dl-pico-pi board running kernel
5.10.37 and I noticed that the firmware takes a long time to load
(more than 3 minutes after boot):

[  192.544227] ath10k_sdio mmc1:0001:1: qca9377 hw1.1 sdio target
0x05020001 chip_id 0x00000000 sub 0000:0000
[  192.554451] ath10k_sdio mmc1:0001:1: kconfig debug 0 debugfs 0
tracing 0 dfs 0 testmode 0
[  192.566465] ath10k_sdio mmc1:0001:1: firmware ver
WLAN.TF.1.1.1-00061-QCATFSWPZ-1 api 5 features ignore-otp crc32
7746e551
[  192.765756] ath10k_sdio mmc1:0001:1: failed to fetch board data for
bus=sdio,vendor=0271,device=0701,subsystem-vendor=0000,subsystem-device=0000
from ath10k/QCA9377/hw1.0/board-2.bin
[  192.784424] ath10k_sdio mmc1:0001:1: board_file api 1 bmi_id N/A
crc32 544289f7
[  194.081698] ath10k_sdio mmc1:0001:1: htt-ver 3.32 wmi-op 4 htt-op 3
cal otp max-sta 32 raw 0 hwcrypto 1
[  194.160101] mmc1: queuing unknown CIS tuple 0x01 (3 bytes)
[  194.177321] mmc1: queuing unknown CIS tuple 0x1a (5 bytes)
[  194.187873] mmc1: queuing unknown CIS tuple 0x1b (8 bytes)
[  194.194279] mmc1: queuing unknown CIS tuple 0x14 (0 bytes)

And then when I try to use it the following RCU messages are seen:

# wpa_supplicant  -iwlan0 -c /etc/wpa.conf &
# Successfully initialized wpa_supplicant
[  234.360447] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.390478] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.409903] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.461811] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.513919] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.566124] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.669870] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.721845] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.773752] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  234.877801] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
wlan0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN

# wlan0: SME: Trying to authenticate wit[  239.203438] wlan0:
authenticate with xx:xx:xx:xx:xx:xx
h d4:b9:2f:2a:f8:64 (SSID='FABIOHOUSE' freq=2412 MHz)
[  239.264154] wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
[  239.280319] wlan0: authenticated
wlan0: Trying to associate with xx:xx:xx:xx:xx:xx(SSID='FABIOHOUSE'
freq=2412 MHz)
[  239.296632] wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
[  239.309133] wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx(capab=0x411
status=0 aid=4)
[  239.336270] wlan0: associated
wlan0: Associated with xx:xx:xx:xx:xx:xx
wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
wlan0: WPA: Key negotiation completed
[  239.553262] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
with xx:xx:xx:xx:xx:xx [PTK=CCMP GTK=CCMP]
wlan0: CTRL-EVENT-CONNECTED - Connection to xx:xx:xx:xx:xx:xx
completed [id=0 id_str=]

Despite the two problems reported above the Wifi connection works:

# udhcpc -i wlan0
udhcpc: started, v1.33.0
udhcpc: sending discover
udhcpc: sending select for 192.168.0.19
udhcpc: lease of 192.168.0.19 obtained, lease time 86400
deleting routers
adding dns x.y.z.w
adding dns x.y.z.w

# ping google.com
PING google.com (172.217.29.110): 56 data bytes
64 bytes from a.b.c.d: seq=0 ttl=113 time=27.756 ms
64 bytes from a.b.c.d: seq=1 ttl=113 time=32.397 ms
64 bytes from a.b.c.d: seq=2 ttl=113 time=31.407 ms
64 bytes from a.b.c.d seq=3 ttl=113 time=30.491 ms

Does anyone have any suggestions for fixing these two issues? I have
also tested 5.12.4 with the same results. Using the QCA9377 firmware
from the latest linux-firmware tree.

Thanks,

Fabio Estevam
