Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9039A7E13EF
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Nov 2023 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjKEOnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Nov 2023 09:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEOnl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Nov 2023 09:43:41 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C0D8
        for <linux-wireless@vger.kernel.org>; Sun,  5 Nov 2023 06:43:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso532950366b.1
        for <linux-wireless@vger.kernel.org>; Sun, 05 Nov 2023 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699195416; x=1699800216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgkps49me2nz4vOcDaNlyU1YRWI/k9yBr4Jv3K759JU=;
        b=ldMeruDgzzujOmqqJNe7s/RAcT8toxCsuOt6ln0/MFpYHN7M4stkb0Cs59YW1JXt6o
         wKYq3FZR2ZItX4TRhyoGb/L8RH0UtK4P6B1oTEoU97L5jI1p3kMFUCIOCftbkhR0K6NC
         dtJ/o1L9dQbotwEKdDuihQ9YE8PJlTl1jk7s8mD+8sIP1fyGd6xkF+rwOWX1AULithuK
         Sg7zdgUiFJvhEkzaCTipyCmQWQKYp2BCWQawgbuTVVWwQZ0GrpJG6LsogfCxNqwX/fTd
         zhsTI2T+/bKwqH9CiBKd2S6IxP0lvny4pQ8Tmu9g2pj+ZOc4uBQgudom2gN5E9TKL1K9
         KJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699195416; x=1699800216;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tgkps49me2nz4vOcDaNlyU1YRWI/k9yBr4Jv3K759JU=;
        b=BMc1EMHvjWyvnbi6KsVbaxQMwqsC76/Imjq+IbvyQxlOyZRuQlGJlcBrzbR5WGgjHM
         qIT6UG1oD7OLmhwYRDfhrlqZDv0CtN4rs7XzSelTvYCbFz64Bu+oMgIFNjbMpq1UCuyD
         3QZO7XtNxyvlWqgLyHmdxMWFfgxoZXjE8KE1xV8tSejN0f+RpCcxjy8cektesl67rus7
         G3ngspSybyTHgSIhbg5XLaBJomCcWWG4N7uzIO76J47Sm7NFQiRnIv0hh0E3sK/Du+DC
         m04NMMoKmymLhBaXBnftVElZEwxLWn47ZsJOso8DPhZrz6xo92Zh+vEcF7m5zYpK3r6B
         lCOg==
X-Gm-Message-State: AOJu0Yx87eFJHJ+hVX0OFzvp4qTZZBLObG4QNCwSbCIeRqVqldbFgAV8
        7iDtAnqRgnjvZorpj1/VKZVbpLuNpxmhlw==
X-Google-Smtp-Source: AGHT+IEFKqTSFuNY9OMgFTGhrYcCdEyLoQpdUyDAI23p5pPKkEb2GozxUG4NXbKF/jMcpwjRGr90zQ==
X-Received: by 2002:a17:906:db0d:b0:9d3:ccd1:a905 with SMTP id xj13-20020a170906db0d00b009d3ccd1a905mr12064281ejb.51.1699195415729;
        Sun, 05 Nov 2023 06:43:35 -0800 (PST)
Received: from ping (dynamic-2a01-0c23-614a-dd00-ee41-07a6-62dd-2930.c23.pool.telefonica.de. [2a01:c23:614a:dd00:ee41:7a6:62dd:2930])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906118d00b009b27d4153c0sm3093586eja.178.2023.11.05.06.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 06:43:35 -0800 (PST)
Date:   Sun, 5 Nov 2023 15:43:32 +0100
From:   Fabian Melzow <fabian.melzow@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Oops related to rtw88: BUG: kernel NULL pointer dereference,
 address: 0000000000000004
Message-ID: <20231105154144.1f983176@ping>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have configured iwd 2.8 on Arch Linux (with latest kernel from
kernel.org) to connect to my encrypted 802.11ac wireless network
automatically when the WLAN USB stick is plugged in.

Then I fast inserted and removed it from the USB Port so it was not
fully initialized some times.

After this I run "iw dev wlan0 scan" from iw 5.19 and it works, but the
second time it failed with:

# iw dev wlan0 scan
command failed: No such device (-19)

In between the rtw88 driver has crashed.

Oops and messages from dmesg:

[  530.746306] usb 1-4: new high-speed USB device number 3 using xhci_hcd
[  530.982343] usb 1-4: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
[  530.982350] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  530.982352] usb 1-4: Product: USB3.0 802.11ac 1200M Adapter
[  530.982355] usb 1-4: Manufacturer: Realtek
[  530.982357] usb 1-4: SerialNumber: 123456
[  531.295974] rtw_8822bu 1-4:1.0: Firmware version 27.2.0, H2C version 13
[  539.640303] usbcore: registered new interface driver rtw_8822bu
[  552.465091] warning: `Qt bearer threa' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[  567.997296] wlan0: authenticate with 80:ef:68:15:52:13
[  580.974768] wlan0: send auth to 80:ef:68:15:52:13 (try 1/3)
[  580.975505] wlan0: authenticated
[  580.979863] wlan0: associate with 80:ef:68:15:52:13 (try 1/3)
[  580.983130] wlan0: RX AssocResp from 80:ef:68:15:52:13 (capab=0x11 status=0 aid=1)
[  581.306888] wlan0: associated
[  581.407079] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised by 80:ef:68:15:52:13
[  719.143502] usb 1-4: USB disconnect, device number 3
[  719.169983] wlan0: deauthenticating from 80:ef:68:15:52:13 by local choice (Reason: 3=DEAUTH_LEAVING)
[  720.199785] rtw_8822bu 1-4:1.0: timed out to flush queue 0
[  720.346449] rtw_8822bu 1-4:1.0: timed out to flush queue 2
[  720.479810] rtw_8822bu 1-4:1.0: timed out to flush queue 3
[  745.666393] usb 1-4: new high-speed USB device number 4 using xhci_hcd
[  745.902978] usb 1-4: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
[  745.902986] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  745.902990] usb 1-4: Product: USB3.0 802.11ac 1200M Adapter
[  745.902994] usb 1-4: Manufacturer: Realtek
[  745.902997] usb 1-4: SerialNumber: 123456
[  745.930783] rtw_8822bu 1-4:1.0: Firmware version 27.2.0, H2C version 13
[  782.610881] wlan0: authenticate with 80:ef:68:15:52:13
[  795.597399] wlan0: send auth to 80:ef:68:15:52:13 (try 1/3)
[  795.598371] wlan0: authenticated
[  795.602920] wlan0: associate with 80:ef:68:15:52:13 (try 1/3)
[  795.605612] wlan0: RX AssocResp from 80:ef:68:15:52:13 (capab=0x11 status=0 aid=1)
[  795.929461] wlan0: associated
[  796.010541] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised by 80:ef:68:15:52:13
[ 4561.441133] usb 1-4: USB disconnect, device number 4
[ 4561.457838] wlan0: deauthenticating from 80:ef:68:15:52:13 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 4562.061131] rtw_8822bu 1-4:1.0: timed out to flush queue 0
[ 4562.201137] rtw_8822bu 1-4:1.0: timed out to flush queue 1
[ 4562.444469] rtw_8822bu 1-4:1.0: timed out to flush queue 0
[ 4562.871122] rtw_8822bu 1-4:1.0: timed out to flush queue 0
[ 4563.011105] rtw_8822bu 1-4:1.0: timed out to flush queue 1
[ 4563.147774] rtw_8822bu 1-4:1.0: timed out to flush queue 2
[ 4563.291117] rtw_8822bu 1-4:1.0: timed out to flush queue 0
[ 4563.461112] rtw_8822bu 1-4:1.0: timed out to flush queue 2
[ 4563.847784] usb 1-4: new high-speed USB device number 5 using xhci_hcd
[ 4564.081111] usb 1-4: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
[ 4564.081119] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 4564.081123] usb 1-4: Product: USB3.0 802.11ac 1200M Adapter
[ 4564.081126] usb 1-4: Manufacturer: Realtek
[ 4564.081129] usb 1-4: SerialNumber: 123456
[ 4564.109882] rtw_8822bu 1-4:1.0: Firmware version 27.2.0, H2C version 13
[ 4592.989039] usb 1-4: USB disconnect, device number 5
[ 4592.991071] rtw_8822bu 1-4:1.0: write register 0x81c failed with -71
[ 4593.458222] rtw_8822bu 1-4:1.0: failed to do USB write, ret=-19
[ 4593.458228] rtw_8822bu 1-4:1.0: failed to send h2c packet
[ 4593.458232] rtw_8822bu 1-4:1.0: failed to do USB write, ret=-19
[ 4593.458235] rtw_8822bu 1-4:1.0: failed to send h2c packet
[ 4593.654585] rtw_8822bu 1-4:1.0: timed out to flush queue 1
[ 4593.867749] rtw_8822bu 1-4:1.0: timed out to flush queue 1
[ 4594.001089] rtw_8822bu 1-4:1.0: timed out to flush queue 2
[ 4594.134419] rtw_8822bu 1-4:1.0: timed out to flush queue 3
[ 4594.361085] rtw_8822bu 1-4:1.0: timed out to flush queue 1
[ 4594.494422] rtw_8822bu 1-4:1.0: timed out to flush queue 2
[ 4614.717721] usb 1-4: new high-speed USB device number 6 using xhci_hcd
[ 4615.363747] usb 1-4: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
[ 4615.363757] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 4615.363762] usb 1-4: Product: USB3.0 802.11ac 1200M Adapter
[ 4615.363766] usb 1-4: Manufacturer: Realtek
[ 4615.363770] usb 1-4: SerialNumber: 123456
[ 4615.391519] rtw_8822bu 1-4:1.0: Firmware version 27.2.0, H2C version 13
[ 4616.928159] rtw_8822bu 1-4:1.0: read register 0x1208 failed with -71
[ 4616.931186] rtw_8822bu 1-4:1.0: write register 0x1200 failed with -71
[ 4616.934189] rtw_8822bu 1-4:1.0: write register 0x1204 failed with -71
[ 4616.937189] rtw_8822bu 1-4:1.0: write register 0x1208 failed with -71
[ 4616.940190] rtw_8822bu 1-4:1.0: read register 0x1208 failed with -71
[ 4616.946195] rtw_8822bu 1-4:1.0: read register 0x101 failed with -71
[ 4616.952190] rtw_8822bu 1-4:1.0: read register 0x422 failed with -71
[ 4617.291203] rtw_8822bu 1-4:1.0: invalid fw checksum
[ 4617.303203] rtw_8822bu 1-4:1.0: failed to download firmware
[ 4617.420252] rtw_8822bu 1-4:1.0: failed to setup chip efuse info
[ 4617.420257] rtw_8822bu 1-4:1.0: failed to setup chip information
[ 4617.422210] rtw_8822bu: probe of 1-4:1.0 failed with error -22
[ 4617.422829] usb 1-4: USB disconnect, device number 6
[ 4617.681061] usb 1-4: new high-speed USB device number 7 using xhci_hcd
[ 4617.914046] usb 1-4: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
[ 4617.914055] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 4617.914059] usb 1-4: Product: USB3.0 802.11ac 1200M Adapter
[ 4617.914063] usb 1-4: Manufacturer: Realtek
[ 4617.914066] usb 1-4: SerialNumber: 123456
[ 4617.941929] rtw_8822bu 1-4:1.0: Firmware version 27.2.0, H2C version 13
[ 4654.804993] wlan0: authenticate with 80:ef:68:15:52:13
[ 4667.749888] wlan0: send auth to 80:ef:68:15:52:13 (try 1/3)
[ 4667.750624] wlan0: authenticated
[ 4667.750955] wlan0: associate with 80:ef:68:15:52:13 (try 1/3)
[ 4667.753377] wlan0: RX AssocResp from 80:ef:68:15:52:13 (capab=0x11 status=0 aid=1)
[ 4668.076596] wlan0: associated
[ 4668.178652] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised by 80:ef:68:15:52:13
[ 4766.794644] usb 1-4: USB disconnect, device number 7
[ 4766.811066] wlan0: deauthenticating from 80:ef:68:15:52:13 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 4767.184141] rtw_8822bu 1-4:1.0: timed out to flush queue 1
[ 4767.967451] rtw_8822bu 1-4:1.0: timed out to flush queue 0
[ 4768.107450] rtw_8822bu 1-4:1.0: timed out to flush queue 1
[ 4768.240791] rtw_8822bu 1-4:1.0: timed out to flush queue 2
[ 4768.688092] usb 1-4: new high-speed USB device number 8 using xhci_hcd
[ 4769.027522] usb 1-4: device descriptor read/64, error -71
[ 4769.780670] usb 1-4: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
[ 4769.780680] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 4769.780685] usb 1-4: Product: USB3.0 802.11ac 1200M Adapter
[ 4769.780689] usb 1-4: Manufacturer: Realtek
[ 4769.780693] usb 1-4: SerialNumber: 123456
[ 4769.809544] rtw_8822bu 1-4:1.0: Firmware version 27.2.0, H2C version 13
[ 4769.809665] BUG: kernel NULL pointer dereference, address: 0000000000000004
[ 4769.809672] #PF: supervisor read access in kernel mode
[ 4769.809676] #PF: error_code(0x0000) - not-present page
[ 4769.809680] PGD 0 P4D 0 
[ 4769.809687] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 4769.809692] CPU: 2 PID: 6226 Comm: kworker/u64:0 Not tainted 6.6.0 #1 2541fa3655206eeff03f862dc5d28439a5284800
[ 4769.809700] Hardware name: System manufacturer System Product Name/PRIME X470-PRO, BIOS 5861 08/10/2021
[ 4769.809704] Workqueue: rtw88_usb: rx wq rtw_usb_rx_handler [rtw88_usb]
[ 4769.809719] RIP: 0010:rtw_rx_fill_rx_status+0x59/0x260 [rtw88_core]
[ 4769.809749] Code: 48 89 44 24 20 31 c0 48 83 e7 f8 48 c7 01 00 00 00 00 48 c7 41 28 00 00 00 00 48 29 f9 83 c1 30 c1 e9 03 f3 48 ab 48 8b 42 18 <8b> 48 04 0f b7 43 1c 66 81 e1 ff 1f 66 25 00 e0 09 c8 66 89 43 1c
[ 4769.809754] RSP: 0018:ffffbabb8b11bd48 EFLAGS: 00010216
[ 4769.809760] RAX: 0000000000000000 RBX: ffffbabb8b11bdb0 RCX: 0000000000000000
[ 4769.809764] RDX: ffff9631c01a0900 RSI: ffffbabb8b11bde0 RDI: ffffbabb8b11bde0
[ 4769.809769] RBP: ffffbabb8b11bde0 R08: ffff9631da490018 R09: 0000000000001ffc
[ 4769.809773] R10: 0000000000000005 R11: 0000000000000005 R12: ffff9631c01a20a0
[ 4769.809777] R13: ffff9631da490038 R14: ffffffffc1f5a360 R15: ffff9631d6bbf600
[ 4769.809781] FS:  0000000000000000(0000) GS:ffff96388ea80000(0000) knlGS:0000000000000000
[ 4769.809785] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4769.809789] CR2: 0000000000000004 CR3: 0000000135bfe000 CR4: 00000000003506e0
[ 4769.809793] Call Trace:
[ 4769.809798]  <TASK>
[ 4769.809803]  ? __die+0x23/0x70
[ 4769.809811]  ? page_fault_oops+0x171/0x4e0
[ 4769.809819]  ? ext4_inode_csum+0x20b/0x290 [ext4 595a7774d6e70d2ebf3fc507ee5372dbe5490181]
[ 4769.809883]  ? exc_page_fault+0x7f/0x180
[ 4769.809891]  ? asm_exc_page_fault+0x26/0x30
[ 4769.809903]  ? rtw_rx_fill_rx_status+0x59/0x260 [rtw88_core 55e3c2ca2972d86783c11e796adcd19f5c570629]
[ 4769.809931]  ? srso_return_thunk+0x5/0x10
[ 4769.809937]  ? rtw8822b_query_rx_desc+0x2b3/0x330 [rtw88_8822b 32facf94f0e45251c19322dbfd1876c920b6656f]
[ 4769.809950]  rtw_usb_rx_handler+0xc4/0x1e0 [rtw88_usb 70ecabcf53c09704b3de973c4717d4dff6b7dd53]
[ 4769.809968]  process_one_work+0x174/0x340
[ 4769.809978]  worker_thread+0x27b/0x3a0
[ 4769.809987]  ? __pfx_worker_thread+0x10/0x10
[ 4769.809993]  kthread+0xe8/0x120
[ 4769.809999]  ? __pfx_kthread+0x10/0x10
[ 4769.810006]  ret_from_fork+0x34/0x50
[ 4769.810012]  ? __pfx_kthread+0x10/0x10
[ 4769.810018]  ret_from_fork_asm+0x1b/0x30
[ 4769.810032]  </TASK>
[ 4769.810034] Modules linked in: rtw88_8822bu rtw88_usb rtw88_8822b rtw88_core mac80211 libarc4 ccm algif_aead crypto_null cbc des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_limit nft_ct nf_conntrack cfg80211 nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc nf_tables libcrc32c nfnetlink intel_rapl_msr intel_rapl_common edac_mce_amd kvm_amd snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi nls_iso8859_1 snd_hda_intel vfat kvm fat snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core irqbypass crct10dif_pclmul polyval_clmulni snd_hwdep polyval_generic asus_wmi_sensors eeepc_wmi joydev gf128mul igb snd_pcm asus_ec_sensors asus_wmi ghash_clmulni_intel mousedev ledtrig_audio sparse_keymap snd_timer platform_profile rapl sp5100_tco dca rfkill snd ccp wmi_bmof pcspkr gpio_amdpt acpi_cpufreq soundcore k10temp i2c_piix4 gpio_generic mac_hid usbip_host usbip_core pkcs8_key_parser dm_multip
 ath dm_mod fuse i2c_dev sg crypto_user
[ 4769.810181]  loop ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 hid_logitech_hidpp hid_logitech_dj amdgpu uas usb_storage usbhid drm_exec amdxcp drm_buddy gpu_sched video i2c_algo_bit drm_suballoc_helper drm_ttm_helper crc32_pclmul ttm crc32c_intel nvme sha512_ssse3 drm_display_helper aesni_intel nvme_core mxm_wmi crypto_simd sr_mod cryptd cec xhci_pci nvme_common cdrom xhci_pci_renesas wmi
[ 4769.810248] CR2: 0000000000000004
[ 4769.810252] ---[ end trace 0000000000000000 ]---
[ 4769.810256] RIP: 0010:rtw_rx_fill_rx_status+0x59/0x260 [rtw88_core]
[ 4769.810281] Code: 48 89 44 24 20 31 c0 48 83 e7 f8 48 c7 01 00 00 00 00 48 c7 41 28 00 00 00 00 48 29 f9 83 c1 30 c1 e9 03 f3 48 ab 48 8b 42 18 <8b> 48 04 0f b7 43 1c 66 81 e1 ff 1f 66 25 00 e0 09 c8 66 89 43 1c
[ 4769.810285] RSP: 0018:ffffbabb8b11bd48 EFLAGS: 00010216
[ 4769.810290] RAX: 0000000000000000 RBX: ffffbabb8b11bdb0 RCX: 0000000000000000
[ 4769.810294] RDX: ffff9631c01a0900 RSI: ffffbabb8b11bde0 RDI: ffffbabb8b11bde0
[ 4769.810297] RBP: ffffbabb8b11bde0 R08: ffff9631da490018 R09: 0000000000001ffc
[ 4769.810301] R10: 0000000000000005 R11: 0000000000000005 R12: ffff9631c01a20a0
[ 4769.810304] R13: ffff9631da490038 R14: ffffffffc1f5a360 R15: ffff9631d6bbf600
[ 4769.810308] FS:  0000000000000000(0000) GS:ffff96388ea80000(0000) knlGS:0000000000000000
[ 4769.810312] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4769.810315] CR2: 0000000000000004 CR3: 0000000135bfe000 CR4: 00000000003506e0
[ 4769.810320] note: kworker/u64:0[6226] exited with irqs disabled

