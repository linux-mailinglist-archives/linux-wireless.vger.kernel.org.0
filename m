Return-Path: <linux-wireless+bounces-815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA1813B14
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 20:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F89C2814FA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23DE697BC;
	Thu, 14 Dec 2023 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm4uKUfU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD76E599
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4260b657ed5so1530101cf.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 11:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702583607; x=1703188407; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/Nw/PH8S1wxjlLYHgUA+Ypffm5JnPxCBtNSvpU4FfY=;
        b=cm4uKUfUmvuHo7Rzh8AkGk2Zyzj2Zi/hKz3q9ugHr72kjtRO+Hel3Zxleq2z4DZm7L
         9c6Zl+N8w3tCLI8uENC1RvkZjI26l/yc9ss2emIzEYyUmLMR5jKjFQH0uxHGGasFLztD
         tyKGBHwuZs4P9TVrOf05xljEmBMSSgyqPBZLF8Pp5HqugiYkGixfYrFMcMUJbPNBlgrA
         RCk7P+k2rd0cv9du3tJw1jG1xHe/lEUGSLHSu364bStSC/KrAw9p4w5O/ZajSg5PqlQV
         +7TvkeCbf1fDOcPzzbdLQCQp3vNYV+96gyuCE+d5pj8vhKw2Jkysbgwe+XBnnZCKNkUr
         qWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583607; x=1703188407;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m/Nw/PH8S1wxjlLYHgUA+Ypffm5JnPxCBtNSvpU4FfY=;
        b=U7ho4SQx7Hknw3tQBFYY4tXH7MaSRdzvij3rts+aWIUkoRwkyLr0yLxMQ9S9cdeET6
         kzY/7PYNFmrp5SVH8wGSg8fRC6oGj33W1h2eudzll78RqIVa3ugMhUgXfB020kGW9jGu
         Eh5g1ZCh6W5Jl7ctRGbNtppNX5T9I2Rgn5E90gUUQRvze3lD39kzlv/KS5nXULToFhFP
         i4btnmQg4GJoHnP1IpZ7IIB1mGzP8CeiR9010hwTibPgsOfA61R56+PffDG0FIuv/si+
         FiVrzUo+ZASDJDHLV1hXkOOIoERf8x6gxk4fKb3YxpD+lrpUwCq/++XYqie/spkjgM8d
         OLeg==
X-Gm-Message-State: AOJu0Yxbic6VLRF27Jhv0KIz+xDJBaMfmC7tN/vN8oW1Atg08WRxrAbB
	bvMBzNyqsmzgFoh22JzvQD+Mm07Ziis=
X-Google-Smtp-Source: AGHT+IH7dCDvPS4XW5nfLHTt5EcFtdJLqZ0QvQImq3WHnRXq+1lPLDeHT8Hjp6QS1ZFIWs+o0Gu0dg==
X-Received: by 2002:a05:622a:16:b0:423:8287:dc68 with SMTP id x22-20020a05622a001600b004238287dc68mr13119376qtw.52.1702583607021;
        Thu, 14 Dec 2023 11:53:27 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id f17-20020ac84651000000b0042545901450sm6020951qto.72.2023.12.14.11.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:53:26 -0800 (PST)
Message-ID: <abbb7874-7f7f-423b-b67c-6ef850ae5bd6@gmail.com>
Date: Thu, 14 Dec 2023 11:53:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: ath10k@lists.infradead.org
From: James Prestwood <prestwoj@gmail.com>
Subject: Ath10k warn, then 4-way timeout after bringing interface up
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

This seems to be related to to a problem I reported in the past [1] 
where cycling the interface up/down causes a timeout in ath10k. I 
originally thought this was specific to setting power save while the 
interface was down, but I'm now seeing (more rarely) it with PS taken 
out of the equation. I attempted a work around for this in userspace by 
retrying the ifup after it failed. This succeeded and a connection was 
made but ath10k spewed a warning, then no data frames (EAPoL) were being 
passed after that. The device could repeatedly associate to BSS's but 
would timeout on the 4-way handshake. This went on indefinitely. When 
this happens the driver seem to be in a very bad and unrecoverable state.

I'm using a 6.2 debian kernel (single patch applied [2]). I also found a 
report of this on the arch forums [3], seems like identical behavior, 
under a 5.17 kernel

[1] 
https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=63b896629353157e8ca77cabdfab340b5c69ca59

[3] https://bbs.archlinux.org/viewtopic.php?id=276259

Dec 14 18:36:45 iwd[1571924]: src/manager.c:manager_interface_dump_done()
Dec 14 18:36:45 iwd[1571924]: src/manager.c:manager_create_interfaces() 
creating wlan0
Dec 14 18:36:45 iwd[1571924]: src/manager.c:manager_create_interfaces() 
creating wlan0-p2p
Dec 14 18:36:45 iwd[1571924]: src/wiphy.c:wiphy_update_reg_domain() New 
reg domain country code for phy0 is 99
Dec 14 18:36:45 iwd[1571924]: src/manager.c:manager_config_notify() 
Notification of command New Interface(7)
Dec 14 18:36:45 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:45 iwd[1571924]: 
src/manager.c:manager_new_station_interface_cb()
Dec 14 18:36:45 iwd[1571924]: src/netdev.c:netdev_create_from_genl() 
Created interface wlan0[14 14]
Dec 14 18:36:45 iwd[1571924]: src/manager.c:manager_config_notify() 
Notification of command New Interface(7)
Dec 14 18:36:45 iwd[1571924]: src/manager.c:manager_new_p2p_interface_cb()
Dec 14 18:36:45 iwd[1571924]: src/p2p.c:p2p_device_update_from_genl() 
Created P2P device 15
#
# Issue bringing the interface up, retried and succeeded
#
Dec 14 18:36:50 kernel: ath10k_pci 0000:02:00.0: wmi service ready event 
not received
Dec 14 18:36:50 iwd[1571924]: Error bringing interface 14 up: Connection 
timed out, retrying in 1s
Dec 14 18:36:50 kernel: ath10k_pci 0000:02:00.0: Could not init core: -110
Dec 14 18:36:51 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:51 iwd[1571924]: src/netdev.c:netdev_set_4addr() netdev: 14 
use_4addr: 0
Dec 14 18:36:51 iwd[1571924]: src/netdev.c:netdev_initial_up_cb() 
Interface 14 initialized
Dec 14 18:36:51 iwd[1571924]: src/netconfig.c:netconfig_new() Creating 
netconfig for interface: 14
Dec 14 18:36:51 iwd[1571924]: src/station.c:station_enter_state() Old 
State: disconnected, new state: autoconnect_quick
Dec 14 18:36:51 iwd[1571924]: src/wiphy.c:wiphy_radio_work_insert() 
Inserting work item 1
Dec 14 18:36:51 iwd[1571924]: src/wiphy.c:wiphy_radio_work_next() 
Starting work item 1
Dec 14 18:36:51 iwd[1571924]: src/rrm.c:rrm_add_frame_watches()
Dec 14 18:36:51 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:51 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:51 iwd[1571924]: src/manager.c:manager_config_notify() 
Notification of command Set Interface(6)
Dec 14 18:36:51 iwd[1571924]: src/scan.c:scan_notify() Scan notification 
Trigger Scan(33)
Dec 14 18:36:51 iwd[1571924]: src/scan.c:scan_request_triggered() Active 
scan triggered for wdev 14
Dec 14 18:36:51 iwd[1571924]: 
src/station.c:station_quick_scan_triggered() Quick scan triggered for wlan0
Dec 14 18:36:51 iwd[1571924]: src/wiphy.c:wiphy_reg_notify() 
Notification of command Reg Beacon Hint(42)
Dec 14 18:36:51 iwd[1571924]: src/wiphy.c:wiphy_reg_notify() 
Notification of command Reg Beacon Hint(42)
Dec 14 18:36:52 iwd[1571924]: src/wiphy.c:wiphy_reg_notify() 
Notification of command Reg Beacon Hint(42)
Dec 14 18:36:52 iwd[1571924]: src/scan.c:scan_notify() Scan notification 
New Scan Results(34)
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
#
# Removed scan results for privacy
#
Dec 14 18:36:52 iwd[1571924]: src/station.c:station_autoconnect_start()
Dec 14 18:36:52 iwd[1571924]: src/station.c:station_autoconnect_next() 
autoconnect: Trying SSID: <ssid>
Dec 14 18:36:52 iwd[1571924]: src/station.c:station_autoconnect_next() 
autoconnect: 'aa:bb:cc:dd:ee:ff' freq: 5220, rank: 1576, strength: -5600
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_cqm_rssi_update()
Dec 14 18:36:52 iwd[1571924]: src/wiphy.c:wiphy_radio_work_insert() 
Inserting work item 2
Dec 14 18:36:52 iwd[1571924]: src/station.c:__station_connect_network() 
connecting to BSS aa:bb:cc:dd:ee:ff
Dec 14 18:36:52 iwd[1571924]: src/station.c:station_enter_state() Old 
State: autoconnect_quick, new state: connecting (auto)
Dec 14 18:36:52 iwd[1571924]: src/scan.c:scan_cancel() Trying to cancel 
scan id 1 for wdev 14
Dec 14 18:36:52 iwd[1571924]: src/wiphy.c:wiphy_radio_work_done() Work 
item 1 done
Dec 14 18:36:52 iwd[1571924]: src/wiphy.c:wiphy_radio_work_next() 
Starting work item 2
Dec 14 18:36:52 kernel: wlan0: authenticate with aa:bb:cc:dd:ee:ff
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_mlme_notify() MLME 
notification New Station(19)
Dec 14 18:36:52 iwd[1571924]: src/station.c:station_netdev_event() 
Associating
Dec 14 18:36:52 kernel: wlan0: send auth to aa:bb:cc:dd:ee:ff (try 1/3)
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_mlme_notify() MLME 
notification Authenticate(37)
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_authenticate_event()
Dec 14 18:36:52 kernel: wlan0: authenticated
Dec 14 18:36:52 kernel: wlan0: associate with aa:bb:cc:dd:ee:ff (try 1/3)
Dec 14 18:36:52 kernel: wlan0: RX AssocResp from aa:bb:cc:dd:ee:ff 
(capab=0x1511 status=0 aid=3)
Dec 14 18:36:52 kernel: ------------[ cut here ]------------
Dec 14 18:36:52 kernel: WARNING: CPU: 5 PID: 0 at 
drivers/net/wireless/ath/ath10k/htt_rx.c:38 
ath10k_htt_rx_pop_paddr+0xcf/0xf0 [ath10k_core]
Dec 14 18:36:52 kernel: Modules linked in: tls nft_chain_nat xt_nat 
xt_MASQUERADE nf_nat xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 nft_compat nf_tables libcrc32c nfnetlink ccm algif_aead 
des_generic libdes algif_skcipher bnep cmac md4 algif_hash af_alg 
snd_sof_pci_intel_cnl snd_sof_intel_hda_common soundwire_intel 
soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda 
snd_sof_pci snd_sof_xtensa_dsp snd_hda_codec_hdmi snd_sof snd_sof_utils 
snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_intel_match 
snd_hda_codec_realtek snd_soc_acpi soundwire_bus snd_hda_codec_generic 
ledtrig_audio snd_soc_core snd_compress ac97_bus >
Dec 14 18:36:52 kernel:  mac80211 irqbypass snd_timer videobuf2_v4l2 
bluetooth snd videodev rapl ecdh_generic ee1004 wmi_bmof soundcore 
libarc4 intel_cstate videobuf2_common ecc mei_me mc mei 
intel_pch_thermal mac_hid acpi_pad acpi_tad cfg80211 pkcs8_key_parser 
ramoops pstore_blk reed_solomon pstore_zone efi_pstore ip_tables 
x_tables autofs4 overlay hid_generic usbhid hid i915 drm_buddy ttm 
drm_display_helper cec rc_core crct10dif_pclmul crc32_pclmul 
drm_kms_helper polyval_clmulni polyval_generic ghash_clmulni_intel 
syscopyarea sha512_ssse3 sysfillrect aesni_intel sysimgblt crypto_simd 
drm igb cryptd e1000e xhci_pci dca video ahci i2c_i801 intel_lp>
Dec 14 18:36:52 kernel: CPU: 5 PID: 0 Comm: swapper/5 Not tainted 
6.2.0-37-generic #38~22.04.1
Dec 14 18:36:52 kernel: Hardware name: <removed> QP-8565B-S4/MWHU7AS-S4, 
BIOS F2 10/25/2021
Dec 14 18:36:52 kernel: RIP: 0010:ath10k_htt_rx_pop_paddr+0xcf/0xf0 
[ath10k_core]
Dec 14 18:36:52 kernel: Code: 00 00 48 8b 30 45 31 c0 b9 02 00 00 00 e8 
a9 bb 0e c9 4c 89 e0 4c 8b 65 f8 c9 31 d2 31 c9 31 f6 31 ff 45 31 c0 c3 
cc cc cc cc <0f> 0b 45 31 e4 4c 89 e0 4c 8b 65 f8 c9 31 d2 31 c9 31 f6 
31 ff 45
Dec 14 18:36:52 kernel: RSP: 0018:ffffac9f80260ce0 EFLAGS: 00010246
Dec 14 18:36:52 kernel: RAX: 0000000000000000 RBX: ffff950486b72150 RCX: 
ffff9505856b2080
Dec 14 18:36:52 kernel: RDX: ffffac9f80260d70 RSI: 0000000006b1cf80 RDI: 
ffff9505856b2cf8
Dec 14 18:36:52 kernel: RBP: ffffac9f80260ce8 R08: ffff9505856b2cf8 R09: 
0000000000000000
Dec 14 18:36:52 kernel: R10: ffffac9f80260e00 R11: 0000000000000000 R12: 
0000000000000001
Dec 14 18:36:52 kernel: R13: ffff9505856b2080 R14: ffff9505856b2cf8 R15: 
ffffac9f80260d70
Dec 14 18:36:52 kernel: FS:  0000000000000000(0000) 
GS:ffff9508cbd40000(0000) knlGS:0000000000000000
Dec 14 18:36:52 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 14 18:36:52 kernel: CR2: 00007f4742b11e68 CR3: 00000001107a8001 CR4: 
00000000003706e0
Dec 14 18:36:52 kernel: Call Trace:
Dec 14 18:36:52 kernel:  <IRQ>
Dec 14 18:36:52 kernel:  ? show_regs+0x72/0x90
Dec 14 18:36:52 kernel:  ? ath10k_htt_rx_pop_paddr+0xcf/0xf0 [ath10k_core]
Dec 14 18:36:52 kernel:  ? __warn+0x8d/0x160
Dec 14 18:36:52 kernel:  ? ath10k_htt_rx_pop_paddr+0xcf/0xf0 [ath10k_core]
Dec 14 18:36:52 kernel:  ? report_bug+0x1bb/0x1d0
Dec 14 18:36:52 kernel:  ? handle_bug+0x46/0x90
Dec 14 18:36:52 kernel:  ? exc_invalid_op+0x19/0x80
Dec 14 18:36:52 kernel:  ? asm_exc_invalid_op+0x1b/0x20
Dec 14 18:36:52 kernel:  ? ath10k_htt_rx_pop_paddr+0xcf/0xf0 [ath10k_core]
Dec 14 18:36:52 kernel:  ath10k_htt_rx_pop_paddr32_list+0x96/0x300 
[ath10k_core]
Dec 14 18:36:52 kernel:  ath10k_htt_rx_in_ord_ind+0x112/0x330 [ath10k_core]
Dec 14 18:36:52 kernel:  ath10k_htt_txrx_compl_task+0x9a/0x2c0 [ath10k_core]
Dec 14 18:36:52 kernel:  ? ath10k_htt_txrx_compl_task+0x9a/0x2c0 
[ath10k_core]
Dec 14 18:36:52 kernel:  ? ath10k_ce_per_engine_service+0x6b/0xb0 
[ath10k_core]
Dec 14 18:36:52 kernel:  ? ath10k_bus_pci_read32+0xd7/0x130 [ath10k_pci]
Dec 14 18:36:52 kernel:  ath10k_pci_napi_poll+0x5a/0x160 [ath10k_pci]
Dec 14 18:36:52 kernel:  ? mod_timer+0x10/0x20
Dec 14 18:36:52 kernel:  __napi_poll+0x30/0x1f0
Dec 14 18:36:52 kernel:  net_rx_action+0x185/0x2d0
Dec 14 18:36:52 kernel:  ? __napi_schedule+0x71/0xa0
Dec 14 18:36:52 kernel:  __do_softirq+0xda/0x330
Dec 14 18:36:52 kernel:  __irq_exit_rcu+0xa2/0xd0
Dec 14 18:36:52 kernel:  irq_exit_rcu+0xe/0x20
Dec 14 18:36:52 kernel:  common_interrupt+0xa4/0xb0
Dec 14 18:36:52 kernel:  </IRQ>
Dec 14 18:36:52 kernel:  <TASK>
Dec 14 18:36:52 kernel:  asm_common_interrupt+0x27/0x40
Dec 14 18:36:52 kernel: RIP: 0010:cpuidle_enter_state+0xde/0x6f0
Dec 14 18:36:52 kernel: Code: 4f 31 74 e8 94 1a 45 ff 8b 53 04 49 89 c7 
0f 1f 44 00 00 31 ff e8 92 f8 43 ff 80 7d d0 00 0f 85 e8 00 00 00 fb 0f 
1f 44 00 00 <45> 85 f6 0f 88 0f 02 00 00 4d 63 ee 49 83 fd 09 0f 87 c4 
04 00 00
Dec 14 18:36:52 kernel: RSP: 0018:ffffac9f80143e28 EFLAGS: 00000246
Dec 14 18:36:52 kernel: RAX: 0000000000000000 RBX: ffffcc9f7fd40000 RCX: 
0000000000000000
Dec 14 18:36:52 kernel: RDX: 0000000000000005 RSI: 0000000000000000 RDI: 
0000000000000000
Dec 14 18:36:52 kernel: RBP: ffffac9f80143e78 R08: 0000000000000000 R09: 
0000000000000000
Dec 14 18:36:52 kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 
ffffffff8d4c2f80
Dec 14 18:36:52 kernel: R13: 0000000000000001 R14: 0000000000000001 R15: 
000043051b8b1781
Dec 14 18:36:52 kernel:  ? cpuidle_enter_state+0xce/0x6f0
Dec 14 18:36:52 kernel:  cpuidle_enter+0x2e/0x50
Dec 14 18:36:52 kernel:  cpuidle_idle_call+0x14f/0x1e0
Dec 14 18:36:52 kernel:  do_idle+0x82/0x110
Dec 14 18:36:52 kernel:  cpu_startup_entry+0x20/0x30
Dec 14 18:36:52 kernel:  start_secondary+0x138/0x170
Dec 14 18:36:52 kernel:  secondary_startup_64_no_verify+0xe5/0xeb
Dec 14 18:36:52 kernel:  </TASK>
Dec 14 18:36:52 kernel: ---[ end trace 0000000000000000 ]---
Dec 14 18:36:52 kernel: ath10k_pci 0000:02:00.0: failed to pop paddr 
list: -2
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_mlme_notify() MLME 
notification Associate(38)
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_associate_event()
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_mlme_notify() MLME 
notification Connect(46)
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_connect_event()
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_connect_event() 
aborting and ignore_connect_event not set, proceed
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_connect_event() 
expect_connect_failure not set, proceed
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:parse_request_ies()
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_connect_event() 
Request / Response IEs parsed
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_get_oci()
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:52 iwd[1571924]: src/wiphy.c:wiphy_reg_notify() 
Notification of command Reg Change(36)
Dec 14 18:36:52 iwd[1571924]: src/wiphy.c:wiphy_update_reg_domain() New 
reg domain country code for (global) is US
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_get_oci_cb() Obtained 
OCI: freq: 5220, width: 1, center1: 5220, center2: 0
Dec 14 18:36:52 iwd[1571924]: src/eapol.c:eapol_start()
Dec 14 18:36:52 kernel: wlan0: associated
Dec 14 18:36:52 kernel: ath: EEPROM regdomain: 0x8348
Dec 14 18:36:52 kernel: ath: EEPROM indicates we should expect a country 
code
Dec 14 18:36:52 kernel: ath: doing EEPROM country->regdmn map search
Dec 14 18:36:52 kernel: ath: country maps to regdmn code: 0x3a
Dec 14 18:36:52 kernel: ath: Country alpha2 being used: US
Dec 14 18:36:52 kernel: ath: Regpair used: 0x3a
Dec 14 18:36:52 kernel: ath: regdomain 0x8348 dynamically updated by 
country element
Dec 14 18:36:52 kernel: wlan0: Limiting TX power to 30 (30 - 0) dBm as 
advertised by aa:bb:cc:dd:ee:ff
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_mlme_notify() MLME 
notification Notify CQM(64)
Dec 14 18:36:52 iwd[1571924]: src/netdev.c:netdev_cqm_event() Signal 
change event (above=1 signal=-61)
Dec 14 18:36:55 iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 
on ifindex 14
Dec 14 18:36:55 kernel: wlan0: deauthenticated from aa:bb:cc:dd:ee:ff 
(Reason: 15=4WAY_HANDSHAKE_TIMEOUT)
Dec 14 18:36:55 iwd[1571924]: src/netdev.c:netdev_mlme_notify() MLME 
notification Del Station(20)
Dec 14 18:36:55 iwd[1571924]: src/netdev.c:netdev_mlme_notify() MLME 
notification Deauthenticate(39)
Dec 14 18:36:55 iwd[1571924]: src/netdev.c:netdev_deauthenticate_event()
Dec 14 18:36:55 iwd[1571924]: src/netdev.c:netdev_mlme_notify() MLME 
notification Disconnect(48)
Dec 14 18:36:55 iwd[1571924]: src/netdev.c:netdev_disconnect_event()
Dec 14 18:36:55 iwd[1571924]: Received Deauthentication event, reason: 
15, from_ap: true
Dec 14 18:36:55 iwd[1571924]: src/wiphy.c:wiphy_radio_work_done() Work 
item 2 done
Dec 14 18:36:55 iwd[1571924]: src/station.c:station_disconnect_event() 14
Dec 14 18:36:55 iwd[1571924]: src/station.c:station_connect_cb() 14, 
result: 3
Dec 14 18:36:55 iwd[1571924]: src/netdev.c:netdev_cqm_rssi_update()
Dec 14 18:36:55 iwd[1571924]: src/wiphy.c:wiphy_radio_work_insert() 
Inserting work item 3
Dec 14 18:36:55 iwd[1571924]: src/wiphy.c:wiphy_radio_work_next() 
Starting work item 3
#
# 4-way handshake timeouts repeated on every connection attempt. The AP 
showed that it was sending
# the 1/4 message, but got no response.
#
Dec 14 18:36:55 iwd[1571924]: src/station.c:__station_connect_network() 
connecting to BSS ff:ee:dd:cc:bb:aa

Thanks,

James


