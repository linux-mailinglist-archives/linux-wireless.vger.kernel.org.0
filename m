Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A82274BB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 05:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfEWDT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 May 2019 23:19:28 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33049 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfEWDT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 May 2019 23:19:27 -0400
Received: by mail-qk1-f172.google.com with SMTP id p18so2958835qkk.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 May 2019 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xmW5apI85DgLL96z/PDrzoL4PWIbPRLZE1y1qJctUtg=;
        b=yOkzIOXnGbt0IxO6mmgAcOqFs5KiGjD4vxeChKq8DTijJgwnb4vpRxXVyHgF+1WkS8
         6+f6I6XhvcPvPKUqZZS1KjmoR5a6gElHXx503RZkg+yLvrLQ4+NduxbMdJI0et6obEUI
         UnaqDWS5UfAhVk56vLNnWjn0Y3lhij82oeCmUdDs8YHXMqX8YqQNc4avZ+awroy6PEDB
         8moclnVvU08MJEunDThdkkeBMPbJD1/tBmGstAnSqCnrVRb/g8JTAfXeio/QOsVg9rBF
         SC1UhIsyL7SLWP+lLJgbZsNOCZsI37x6eHHxIf8bTwrW3OaUnG4JevxK3tKU4aiICxC8
         37pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xmW5apI85DgLL96z/PDrzoL4PWIbPRLZE1y1qJctUtg=;
        b=UrwCrrXMVK12SKw75+Q1wsINXlw5kwgvHY17ejcgR7ubfGLikMchakDUdjcwY/ZMtO
         wUOnTSaypbysuJDR2fe3090xrhmnTLSkGjHEDqexGUqVXHhVQOODeM8HfD66JbBt+ShY
         XVKYu2BQsSbXfCOUGsj78CC62VLibcHa2bv1bhjbsvZD0MXHKshOHWED7g02ZL0J6ZK+
         4U11WmWWjuB/aqpvlgJ+/QFW6H6rllKUaLjp04hZ8oZST9VmrGTN9GeIV0Vzb8QpMtZ2
         D6A3PzDg1APqI6tDzK9Z45E92XI+Q0rovSxkg2zTRgckFLaKL4LdhDU2NDaGq+zNVBry
         dl6w==
X-Gm-Message-State: APjAAAWMwDvyyjDhnDx/OYFmgWv+MHdaqiM/mdMP4kU9+SZ23n3xQCEg
        iiJOMVzCUo/vcv99SF5x+mYhEoJ9ygOUqbVpd2Q9PA==
X-Google-Smtp-Source: APXvYqzvM1RyWJGf8lhP9VjkDd1UHz+XSh8aiXRGQHTtMxdyEBuBNx/ATvlesbEOIsLIU1Kj/YY6OJ5V2ZRTQahFZJA=
X-Received: by 2002:ae9:c106:: with SMTP id z6mr10931075qki.65.1558581566479;
 Wed, 22 May 2019 20:19:26 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 22 May 2019 21:19:14 -0600
Message-ID: <CAD8Lp45wxQ3vL_ttq-yKYDxscjn2KyJVCx_vJBCn+u8Yc5QtOQ@mail.gmail.com>
Subject: ath10k QCA9377 firmware crashes and fails to recover
To:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

We are experiencing failures with QCA9377 wifi, using Linux 4.18 and
Linux 5.0 with the latest firmware version:

ath10k_pci 0000:02:00.0: firmware crashed! (guid
54a4649a-1240-4459-9442-9d498c49de79)
ath10k_pci 0000:02:00.0: qca9377 hw1.1 target 0x05020001 chip_id
0x003821ff sub 1a3b:2b31
ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
ath10k_pci 0000:02:00.0: firmware ver WLAN.TF.1.0-00002-QCATFSWPZ-5
api 5 features ignore-otp crc32 c3e0d04f
ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
ath10k_pci 0000:02:00.0: htt-ver 3.44 wmi-op 4 htt-op 3 cal otp
max-sta 32 raw 0 hwcrypto 1
ath10k_pci 0000:02:00.0: firmware register dump:
ath10k_pci 0000:02:00.0: [00]: 0x05020001 0x00000000 0x1D008136 0x00000000
ath10k_pci 0000:02:00.0: [04]: 0x1D008136 0x00060330 0x00000004 0x00000000
ath10k_pci 0000:02:00.0: [08]: 0x00000001 0x0042B0EC 0x0040E84C 0x00433E18
ath10k_pci 0000:02:00.0: [12]: 0x00000000 0xFFFFFFFF 0x00952F6C 0x00952F77
ath10k_pci 0000:02:00.0: [16]: 0x0127099E 0x7DBF8AE8 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [20]: 0x0000013C 0x00433E18 0x0040E7E8 0x00436ED0
ath10k_pci 0000:02:00.0: [24]: 0x800B1A0B 0x0040E7E8 0x00433E18 0x00436FA0
ath10k_pci 0000:02:00.0: [28]: 0x00000001 0x00433E18 0x00436FA0 0x00429558
ath10k_pci 0000:02:00.0: [32]: 0x00000000 0x00433E18 0x00400000 0x000000F4
ath10k_pci 0000:02:00.0: [36]: 0x809ED9B2 0x0040E898 0x00000201 0x0040E900
ath10k_pci 0000:02:00.0: [40]: 0x00800000 0x00000000 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [44]: 0x00000000 0x00000000 0x00000001 0x00000000
ath10k_pci 0000:02:00.0: [48]: 0x00000018 0x00436FA0 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [52]: 0x004089D0 0x00000000 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [56]: 0x00000127 0x00000000 0x00000040 0x80168040
ath10k_pci 0000:02:00.0: Copy Engine register dump:
ath10k_pci 0000:02:00.0: [00]: 0x00034400   2   2   3   3
ath10k_pci 0000:02:00.0: [01]: 0x00034800  21  21  98  99
ath10k_pci 0000:02:00.0: [02]: 0x00034c00  12  12  75  76
ath10k_pci 0000:02:00.0: [03]: 0x00035000   7   7   9   7
ath10k_pci 0000:02:00.0: [04]: 0x00035400 7033 7033 253 190
ath10k_pci 0000:02:00.0: [05]: 0x00035800   0   0  64   0
ath10k_pci 0000:02:00.0: [06]: 0x00035c00   8   8   0   0
ath10k_pci 0000:02:00.0: [07]: 0x00036000   1   1   1   1
ieee80211 phy0: Hardware restart was requested
ath10k_pci 0000:02:00.0: firmware crashed! (guid
4f81011e-ff0e-42d1-8f97-74a576157bc7)
ath10k_pci 0000:02:00.0: qca9377 hw1.1 target 0x05020001 chip_id
0x003821ff sub 1a3b:2b31
ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
ath10k_pci 0000:02:00.0: firmware ver WLAN.TF.1.0-00002-QCATFSWPZ-5
api 5 features ignore-otp crc32 c3e0d04f
ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
ath10k_pci 0000:02:00.0: htt-ver 3.44 wmi-op 4 htt-op 3 cal otp
max-sta 32 raw 0 hwcrypto 1
ath10k_pci 0000:02:00.0: firmware register dump:
ath10k_pci 0000:02:00.0: [00]: 0x05020001 0x00000000 0x809FF705 0x00000000
ath10k_pci 0000:02:00.0: [04]: 0x809FF705 0x0040EA78 0x0043DA00 0x0042C514
ath10k_pci 0000:02:00.0: [08]: 0x004301B0 0x004301C0 0x00000064 0x00000000
ath10k_pci 0000:02:00.0: [12]: 0x809B140B 0x004301C0 0x004301C8 0x00000064
ath10k_pci 0000:02:00.0: [16]: 0x00000000 0x0040EABC 0x00000064 0x0040EAB0
ath10k_pci 0000:02:00.0: [20]: 0x000FFFFF 0x0040EAE8 0x00000011 0x004041E4
ath10k_pci 0000:02:00.0: [24]: 0x00020000 0x00020000 0x00400000 0x00000001
ath10k_pci 0000:02:00.0: [28]: 0x809FCDD8 0x0040EA98 0x0043DA00 0x00000001
ath10k_pci 0000:02:00.0: [32]: 0x00000001 0x004122C0 0x00426BD0 0x00035428
ath10k_pci 0000:02:00.0: [36]: 0x00000000 0x00000000 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [40]: 0x00000000 0x00000000 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [44]: 0x00000000 0x00000000 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [48]: 0x00000000 0x00000000 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [52]: 0x00000000 0x00000000 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: [56]: 0x00000000 0x00000000 0x00000000 0x00000000
ath10k_pci 0000:02:00.0: Copy Engine register dump:
ath10k_pci 0000:02:00.0: [00]: 0x00034400   2   2   3   3
ath10k_pci 0000:02:00.0: [01]: 0x00034800   3   3  16  17
ath10k_pci 0000:02:00.0: [02]: 0x00034c00   1   1   0   1
ath10k_pci 0000:02:00.0: [03]: 0x00035000   1   1   2   1
ath10k_pci 0000:02:00.0: [04]: 0x00035400  14  14  64   6
ath10k_pci 0000:02:00.0: [05]: 0x00035800   0   0   0   0
ath10k_pci 0000:02:00.0: [06]: 0x00035c00   0   0   0   0
ath10k_pci 0000:02:00.0: [07]: 0x00036000   1   1   1   1
ath10k_pci 0000:02:00.0: wmi unified ready event not received
ath10k_pci 0000:02:00.0: device has crashed during init
ath10k_pci 0000:02:00.0: device has crashed during init
ath10k_pci 0000:02:00.0: failed to wait for target init: -70
ath10k_pci 0000:02:00.0: Could not init core: -110
------------[ cut here ]------------
Hardware became unavailable during restart.
ath10k_pci 0000:02:00.0: cannot restart a device that hasn't been started
WARNING: CPU: 2 PID: 316 at
/usr/src/packages/BUILD/net/mac80211/util.c:1907
ieee80211_reconfig+0x235/0xf70 [mac80211]
Modules linked in: uas usb_storage ccm rfcomm arc4 joydev cmac bnep
hid_multitouch hid_generic spi_pxa2xx_platform 8250_dw intel_rapl
intel_telemetry_pltdrv intel_punit_ipc intel_telemetry_core
intel_pmc_ipc x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
snd_soc_skl kvm irqbypass crct10dif_pclmul snd_soc_skl_ipc
snd_soc_sst_ipc snd_soc_sst_dsp crc32_pclmul snd_hda_ext_core
snd_hda_codec_hdmi ghash_clmulni_intel snd_soc_acpi pcbc snd_soc_core
snd_hda_codec_realtek snd_hda_codec_generic snd_compress uvcvideo
videobuf2_vmalloc ac97_bus aesni_intel videobuf2_memops videobuf2_v4l2
aes_x86_64 snd_pcm_dmaengine crypto_simd videobuf2_common cryptd
glue_helper videodev snd_hda_intel ath10k_pci intel_cstate
snd_hda_codec intel_rapl_perf media ath10k_core snd_hda_core snd_hwdep
btusb btrtl
 btbcm btintel ath snd_pcm asus_nb_wmi asus_wmi mac80211 snd_timer
sparse_keymap bluetooth input_leds wmi_bmof bfq snd soundcore
ecdh_generic rtsx_pci_ms memstick cfg80211 idma64 virt_dma
intel_lpss_pci intel_lpss mei_me processor_thermal_device mei
intel_soc_dts_iosf mac_hid int3400_thermal int3403_thermal
acpi_thermal_rel int340x_thermal_zone pinctrl_geminilake asus_wireless
zram ip_tables x_tables mmc_block rtsx_pci_sdmmc i915 i2c_algo_bit
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops serio_raw
ahci sdhci_pci rtsx_pci drm cqhci sdhci libahci wmi i2c_hid hid video
CPU: 2 PID: 316 Comm: kworker/2:5 Not tainted 4.18.0-15-generic
#16+dev706.ddb1008beos3.5.2
Hardware name: ASUSTeK COMPUTER INC. VivoBook_ASUS Laptop
E406MA_E406MA/E406MA, BIOS E406MA.311 03/14/2019
Workqueue: events_freezable ieee80211_restart_work [mac80211]
RIP: 0010:ieee80211_reconfig+0x235/0xf70 [mac80211]
Code: c6 45 d6 00 c6 83 94 04 00 00 00 48 89 df e8 f2 a9 fc ff 85 c0
41 89 c6 0f 84 40 01 00 00 48 c7 c7 b8 b1 a6 c0 e8 fb b4 c6 dc <0f> 0b
e9 48 fe ff ff 4c 89 e7 e8 dc 09 02 00 e9 13 ff ff ff c6 83
RSP: 0018:ffffad7c80a57de8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8870af2b0760 RCX: 0000000000000006
RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff8870bfd16540
RBP: ffffad7c80a57e30 R08: 0000000000000001 R09: 00000000000003a9
R10: 00000000000000c9 R11: 00000000000003a9 R12: ffff8870af2b0f90
R13: ffff8870af2b13a0 R14: 00000000ffffff92 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8870bfd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00003eb20551d000 CR3: 0000000150908000 CR4: 0000000000340ee0
Call Trace:
 ieee80211_restart_work+0xbc/0xf0 [mac80211]
 process_one_work+0x1fa/0x3f0
 worker_thread+0x4d/0x410
 kthread+0x105/0x140
 ? rescuer_thread+0x370/0x370
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x1f/0x40
---[ end trace bfb7f12d31b47270 ]---

followed by many more similar warnings.

This problem can be easily reproduced by playing youtube videos for a
few minutes. When it happens, the system does not recover and the wifi
is unusable til reboot.

We have confirmed that this problem only affects specific cards. Other
identical-looking QCA9377 cards found in other instances of the same
laptop products do not suffer the problem. If we move an affected card
to another laptop, the problem will then readily occur on that laptop
too, i.e. the problem follows the card.

Having seen multiple cards that follow this pattern, it does not
appear to be a one-off.

It also does not appear to be an actual defect with the hardware
because we've tested the same cards extensively under Windows 10 and
no problems are seen there.

Any suggestions for further debugging?

We would be happy to ship affected devices to Qualcomm engineers if that helps.

Thanks
Daniel
