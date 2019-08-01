Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB77E069
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 18:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfHAQng (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 12:43:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40218 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfHAQng (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 12:43:36 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so20591669iom.7
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2019 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A1/mKKFDz6Jx5KVy7s5uSxOq3whuQj8KT5EXHEpWgSY=;
        b=eDrHSut54qehbRRkZVeELTP2VZB+zQleP0mDu6MJr5m0opjnoLISebyjV0lVCAYBlB
         HcRAt2/+U+SroeL+OAz0uS1Wt/6if/6snucw+RfYgYUy4uajxLumy7Bfjhbci+9FMGiC
         mneeTnDC7UUhAMwaJDYUpu9HeUOaf5tuBxp+5PT94uMZzm8kcbOAqeFNxw69NqWxCwPU
         E231CmDwGKOzoCST1jESXRpz0ZXG5Aihx8ftGa3z9JKGs0iaCL4/zO407ySr8/UbMvA8
         L5+uuW7MxBl4T6DgGCqk9CCvDXXoqpaS0ybm1dKEm1xmKH3g6EubbvkVxquw33QSchiX
         ffgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A1/mKKFDz6Jx5KVy7s5uSxOq3whuQj8KT5EXHEpWgSY=;
        b=gnsS5iorNaRtV+gMwNxxWMQdQPJ0tHJXYTI0NwQVvviTBSSkthzRLOJ4Qx0HEfGfdZ
         oD8UeokC9RFttVpgAgNueOsd6coqMp0VWST8LOCuopMTGM/CBhcCtNS/D85ElL+JQkhx
         f/mUNr7hLBnIPU0aDltdO32C6avvClb7jLbGiih+ntRPNT6v3HN+gFxTuZhVCX1JoNgY
         +MegU9Z2hSOmoo62xhZFodjWK4++BKf1N12US74zU+76oRooZwXIAJLX2H5s+sBY8Xl5
         wSX6kz9N/zusKR2vRsAVuECTyPSZwqvNykm0wR6DLGTGPfx1RLEm1hZuXNZw6kXjv/qE
         dNWg==
X-Gm-Message-State: APjAAAVCrSa4luNC4Hoxgy2QnpflJkKIGVFMqQcDBQ5zaAvnyXRTcYDH
        K9DadJXiUmMAGTUbKIh9HHNHtWNdnuzCTzM9ams=
X-Google-Smtp-Source: APXvYqyRAt8lBIurzj8znHiLbHxs/km9bpH4jXrYE1Jt5NE6MeGVvEoPhBtWlNVNP6+zEz/rVJzLodXkinskOnQzRzs=
X-Received: by 2002:a5d:8702:: with SMTP id u2mr102072669iom.228.1564677815159;
 Thu, 01 Aug 2019 09:43:35 -0700 (PDT)
MIME-Version: 1.0
From:   Sid Hayn <sidhayn@gmail.com>
Date:   Thu, 1 Aug 2019 12:43:26 -0400
Message-ID: <CAM0KTbCuryuOTV1LdsEF4LkBHV4cPGpLe9nwA68CVCoDQ-6fkA@mail.gmail.com>
Subject: rt2x00usb warning while channel hopping
To:     Stanislaw Gruszka <sgruszka@redhat.com>,
        helmut.schaa@googlemail.com
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While testing wireless-testing kernel for some other fixes, I
encountered this warning.  I have a few different chipsets and drivers
all channel hopping in monitor mode on the test box, but I get this
warning from rt2x00 over and over again (lots).  I am testing two
patches from johill on top of wireless testing, I don't believe they
are causing this, but I'll include them for completeness.

https://patchwork.kernel.org/patch/11063915/
https://patchwork.kernel.org/patch/11069625/

I'm happy to test anything required, although I will be traveling next
week which may cause delays.

Thanks,
Zero

[  170.055276] ------------[ cut here ]------------
[  170.055305] WARNING: CPU: 3 PID: 5777 at
rt2x00lib_config.cold.0+0xc/0x2a [rt2x00lib]
[  170.055306] Modules linked in: mt76x0u mt76x0_common carl9170
mt76x2u mt76x2_common mt76x02_usb mt76_usb mt76x02_lib mt76 mousedev
input_leds rt2800usb rt2x00usb rt2800lib rt2x00lib ath9k_htc
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
ledtrig_audio i915 snd_soc_skl intel_rapl_msr intel_rapl_common
x86_pkg_temp_thermal intel_powerclamp coretemp snd_soc_hdac_hda
snd_hda_ext_core snd_soc_skl_ipc snd_soc_sst_ipc kvm_intel
snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core kvm
ath9k snd_compress snd_pcm_dmaengine ac97_bus snd_hda_intel
ath9k_common ath9k_hw snd_hda_codec ath irqbypass iTCO_wdt
iTCO_vendor_support mxm_wmi drm_kms_helper mei_hdcp mac80211
snd_hda_core crct10dif_pclmul snd_hwdep crc32_pclmul intel_cstate
snd_pcm drm snd_timer intel_uncore e1000e snd intel_rapl_perf
soundcore i2c_i801 ath3k btusb btrtl btbcm btintel cfg80211 intel_gtt
bluetooth syscopyarea sysfillrect sysimgblt fb_sys_fops wmi mei_me
evdev mei intel_pch_thermal
[  170.055343]  intel_xhci_usb_role_switch roles rfkill ixgb ixgbe
samsung_sxgbe tulip cxgb3 cxgb mdio cxgb4 vxge bonding vxlan macvlan
vmxnet3 tg3 sky2 r8169 pcnet32 mii igb i2c_algo_bit dca e1000 bnx2
atl1c qemu_fw_cfg cramfs mtd f2fs xfs jfs dm_verity reed_solomon
dm_thin_pool dm_switch dm_snapshot dm_raid dm_log_writes dm_era
dm_delay dm_cache_smq dm_cache dm_persistent_data dm_bio_prison
firewire_core hid_sunplus hid_sony hid_samsung hid_pl hid_petalynx
hid_monterey hid_microsoft hid_logitech_dj hid_logitech hid_gyration
hid_ezkey hid_cypress hid_chicony hid_cherry hid_belkin hid_apple
hid_a4tech sl811_hcd hid_generic mpt3sas aic94xx libsas lpfc nvmet_fc
qla2xxx megaraid_sas megaraid aacraid sx8 hpsa 3w_9xxx 3w_xxxx 3w_sas
mptsas scsi_transport_sas mptfc mptspi mptscsih mptbase atp870u dc395x
qla1280 imm parport dmx3191d sym53c8xx gdth advansys initio BusLogic
arcmsr aic7xxx aic79xx sg pata_pcmcia pcmcia pcmcia_core nvme_fc
nvme_loop nvmet nvme_rdma rdma_cm iw_cm ib_cm
[  170.055387]  ib_core nvme_fabrics virtio_net net_failover failover
virtio_crypto crypto_engine virtio_mmio virtio_input virtio_balloon
virtio_rng virtio_console virtio_scsi
[  170.055393] CPU: 3 PID: 5777 Comm: kismet_cap_linu Tainted: G
         T 5.3.0-rc1-wt-dirty #2
[  170.055394] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./SBC-331V, BIOS SHIRE-9100_r01 12/07/2017
[  170.055399] RIP: 0010:rt2x00lib_config.cold.0+0xc/0x2a [rt2x00lib]
[  170.055401] Code: 38 48 81 c7 38 01 00 00 e8 65 7e 3e c5 e9 a1 c0
ff ff 48 c7 c7 c6 33 4c c1 e8 4b 4b 88 c5 48 c7 c7 d0 37 4c c1 e8 e0
af ca c4 <0f> 0b 48 8b 45 18 0f b7 40 08 48 6b d0 14 48 03 93 b0 05 00
00 48
[  170.055403] RSP: 0018:ffffb0b6019478e8 EFLAGS: 00010282
[  170.055405] RAX: 0000000000000024 RBX: ffff9983c7b51e00 RCX: 0000000000000000
[  170.055406] RDX: 0000000000000000 RSI: ffff9983f5d97418 RDI: ffff9983f5d97418
[  170.055407] RBP: ffff9983c7b507a0 R08: 0000000000000577 R09: 0000000000000001
[  170.055408] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000040
[  170.055409] R13: 0000000000000040 R14: ffffb0b6019479e0 R15: ffff9983c28f88d0
[  170.055410] FS:  000075e8849a7700(0000) GS:ffff9983f5d80000(0000)
knlGS:0000000000000000
[  170.055411] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  170.055412] CR2: 00007d3750090018 CR3: 0000000445300002 CR4: 00000000003606e0
[  170.055412] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  170.055413] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  170.055414] Call Trace:
[  170.055419]  rt2x00mac_config+0x44/0x80 [rt2x00lib]
[  170.055427]  ieee80211_hw_config+0x80/0x2c0 [mac80211]
[  170.055439]  ieee80211_set_monitor_channel+0xdf/0x110 [mac80211]
[  170.055454]  __nl80211_set_channel+0x1a1/0x1c0 [cfg80211]
[  170.055467]  nl80211_set_wiphy+0x2e1/0x6c0 [cfg80211]
[  170.055470]  genl_family_rcv_msg+0x21d/0x480
[  170.055472]  genl_rcv_msg+0x42/0x90
[  170.055474]  ? genl_family_rcv_msg+0x480/0x480
[  170.055475]  netlink_rcv_skb+0x72/0x140
[  170.055477]  genl_rcv+0x1f/0x30
[  170.055478]  netlink_unicast+0x184/0x210
[  170.055479]  netlink_sendmsg+0x211/0x3d0
[  170.055482]  sock_sendmsg+0x5c/0x60
[  170.055484]  ___sys_sendmsg+0x2fb/0x370
[  170.055487]  __sys_sendmsg+0x85/0xd0
[  170.055490]  do_syscall_64+0x56/0x100
[  170.055492]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  170.055494] RIP: 0033:0x75e8884efa84
[  170.055496] Code: c3 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 23
eb ff ff 41 89 c0 8b 54 24 1c 48 8b 74 24 10 8b 7c 24 08 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 29 48 89 44 24 08 44 89 c7 e8 57 eb ff
ff 48
[  170.055496] RSP: 002b:000075e8849a5ff0 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[  170.055498] RAX: ffffffffffffffda RBX: 000075e87c000ef0 RCX: 000075e8884efa84
[  170.055498] RDX: 0000000000000000 RSI: 000075e8849a6060 RDI: 0000000000000021
[  170.055499] RBP: 00005b2fad909ff0 R08: 0000000000000002 R09: 0000000000001000
[  170.055500] R10: 000075e87c000080 R11: 0000000000000246 R12: 000075e8849a6060
[  170.055500] R13: 00000000000016b7 R14: 0000000000000002 R15: 00000000000016c1
[  170.055502] ---[ end trace 6fadb6fa5ddab1b7 ]---
