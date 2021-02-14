Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4186F31B310
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Feb 2021 23:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBNWgP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Feb 2021 17:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBNWgN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Feb 2021 17:36:13 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3BBC061574
        for <linux-wireless@vger.kernel.org>; Sun, 14 Feb 2021 14:35:31 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m17so5022043ioy.4
        for <linux-wireless@vger.kernel.org>; Sun, 14 Feb 2021 14:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=idCJHwbJGKGW6iWFPFOyLBR2Vkpy/wtcmDWNMZF2FH8=;
        b=pGcBZrhOknv2HNc/ARhoNzC2xxBKsOzXHU4Pe+w2xCp47PJdKBg/P98GRz3Pn2BsHc
         fQLVqJyAoz/Wi9SwT3xob/+OQ7fge7NIW38u8PvtnHXaLUaW0nJMOnKX8MdZNYomS+1P
         /Tw3KMvTigEWLy3WTjgn8Oktigm3usJsfBHGcibFti24eMARLJql5fmHAHx9ZtNxouHi
         uNGGjkU9ZJF9vsgbrR2wNjTwKx+g3/5lKCZtIpoGLZcwJy+dhZAcLhlY6Gm9qjrFH22D
         7/U4Er4rXVZTJ42FefKC+aPq6PgglmqRSlzEldpxX+GjrVfsqQbqtiurmC+X4rxPJZn4
         STqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=idCJHwbJGKGW6iWFPFOyLBR2Vkpy/wtcmDWNMZF2FH8=;
        b=iJspYay2nwiXoRr/7ELK2WosrXonwjYIm2QH3jLpybi8wIZDihyiUHd7+em5ioHNex
         m5YmmNcfc4xyrhP8AuS7zDwC1q4UqGzBEHezLUaoyMyCR+b5T+McS5g1+sqF5MSVbde8
         4F0zvPm1PQqz0i8dPwWHAAG0qi6lbrH5HLyhRQMYB/XWNfXaMTkLImKenWSECf5PSclU
         5Oq2K9syMUwJp9gc1At/CKntALHnzkTrqtrN9eX7W9fplRw7Ztd/S8neQRsek0M+mwt8
         IKElgoKOLpVeML+Vao2+XBcV43hkGEMYAVjYGVRy7GOUqkMV34DWC45N4TmtTislI7KT
         gFmQ==
X-Gm-Message-State: AOAM5310sg97WhU9IaFe6biZgmuF+w7NenUP+DI2sPIHbDl0n1MChcH6
        6A9RPeyyMkNav5iJppdEdqaA0eimmCNxnPtyZ2o=
X-Google-Smtp-Source: ABdhPJyW1R9hAuLmowP7PTG/RuF5EIMIWpCeLM9LCPaSZfOHshrbOBdIvtAJXVV6wfG9OX6UMtS3YweVWqs2r9506VM=
X-Received: by 2002:a05:6638:3795:: with SMTP id w21mr12745137jal.65.1613342130931;
 Sun, 14 Feb 2021 14:35:30 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 14 Feb 2021 23:35:20 +0100
Message-ID: <CA+icZUVhNPbfyph07dq55NrX_0uRvjG0eF2mFH0hXY2DiX6MvA@mail.gmail.com>
Subject: iwlwifi: Command REPLY_RXON failed: FW Error
To:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

irregularly I see some traces when doing deauth/reauth.
This is with Linux v5.11-rc7+ compiled/linked with LLVM/Clang v12.0.0-rc1.

[ dmesg ]

iwlwifi 0000:01:00.0: Detected Intel(R) Centrino(R) Advanced-N 6230
AGN, REV=0xB0

iwlwifi 0000:01:00.0: loaded firmware version 18.168.6.1
6000g2b-6.ucode op_mode iwldvm

[ lsmod ]

# lsmod | grep iwl
iwldvm                151552  0
iwlwifi               299008  1 iwldvm
mac80211              983040  1 iwldvm
cfg80211              970752  3 iwldvm,iwlwifi,mac80211

I needed to `modprobe -r -v iwldvm` and `modprobe -v iwldvm` to
re-establish an Internet connection via WLAN.

The call-trace looks like this:

[So Feb 14 23:21:04 2021] wlp1s0: deauthenticating from
f6:f5:24:2e:54:f5 by local choice (Reason: 3=DEAUTH_LEAVING)
[So Feb 14 23:21:25 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:25 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:25 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:26 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: Error sending
REPLY_SCAN_ABORT_CMD: time out after 2000ms.
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: Current CMD queue
read_ptr 36 write_ptr 37
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: Loaded firmware
version: 18.168.6.1 6000g2b-6.ucode
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | OK
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | uPc
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | branchlink1
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | branchlink2
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | interruptlink1
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | interruptlink2
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | data1
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | data2
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | line
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | tsf low
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | time gp2
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | time gp3
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | uCode version
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | hw version
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | board version
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | hcmd
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr0
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr2
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr3
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | isr_pref
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | wait_event
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | lmpm_pmg_sel
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: 0x00000000 | flow_handler
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: Start IWL Event Log
Dump: nothing in log
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: Command REPLY_RXON
failed: FW Error
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: Error clearing
ASSOC_MSK on BSS (-5)
[So Feb 14 23:21:36 2021] ieee80211 phy0: Hardware restart was requested
[So Feb 14 23:21:36 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:37 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:37 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: Failed to load firmware chunk!
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: iwlwifi transaction
failed, dumping registers
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: iwlwifi device config registers:
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000000: 00918086
00100406 02800034 00000010 f0600004 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000020: 00000000
00000000 00000000 52018086 00000000 000000c8 00000000 0000010b
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000040: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000060: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000080: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 000000a0: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 000000c0: 00000000
00000000 c823d001 0d000000 0081e005 fee04004 00000000 00000025
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 000000e0: 00010010
10008ec0 00190810 0006ec11 10110143 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000100: 14010001
00000000 00000000 00062011 00002000 00002000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000120: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000140: 00010003
ffacc312 88532eff 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: iwlwifi device memory
mapped registers:
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000000: 00488700
00000040 08000000 00000000 00000001 00000000 00000030 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000020: 00000001
080403c5 000000b0 00000000 90000801 00030001 80008040 00080046
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: iwlwifi device AER
capability structure:
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000000: 14010001
00000000 00000000 00062011 00002000 00002000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: 00000020: 00000000
00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: iwlwifi parent port
(0000:00:1c.0) config registers:
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000000: 1c108086
00100407 060400b4 00810010 00000000 00000000 00010100 200000f0
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000020: f060f060
0001fff1 00000000 00000000 00000000 00000040 00000000 0002010b
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000040: 01428010
00008000 00100000 01123c12 70110042 0004b200 01400000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000060: 00000000
00000016 00000000 00000000 00010002 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000080: 00019005
fee04004 00000021 00000000 0000a00d c0c7144d 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 000000a0: c8020001
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 000000c0: 00000000
00000000 00000000 00000000 01000000 00000b02 81118000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 000000e0: 00003f00
00000000 00000001 00000000 00000000 00000000 08060f87 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000100: 00000000
00000000 00000000 00060011 00000000 00002000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000120: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000140: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000160: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000180: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 000001a0: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 000001c0: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 000001e0: 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:00:1c.0: 00000200: 00000000
00000000 00000000
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: Could not load the [0]
uCode section
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: Unable to initialize device.
[So Feb 14 23:21:42 2021] ------------[ cut here ]------------
[So Feb 14 23:21:42 2021] Hardware became unavailable during restart.
[So Feb 14 23:21:42 2021] WARNING: CPU: 2 PID: 10366 at
net/mac80211/util.c:2345 ieee80211_reconfig+0x494/0xc20 [mac80211]
[So Feb 14 23:21:42 2021] Modules linked in: ctr(E) ccm(E) bnep(E)
option(E) cdc_ether(E) usb_wwan(E) usbserial(E) usbnet(E) mii(E)
snd_hda_codec_hdmi(E) intel_rapl_msr(E) snd_hda_codec_realtek(E)
intel_rapl_common(E) snd_hda_codec_generic(E) x86_pkg_temp_thermal(E)
uvcvideo(E) ledtrig_audio(E) snd_hda_intel(E) intel_powerclamp(E)
btusb(E) videobuf2_vmalloc(E) snd_intel_dspcfg(E) videobuf2_memops(E)
coretemp(E) videobuf2_v4l2(E) kvm_intel(E) btrtl(E) i915(E)
videobuf2_common(E) soundwire_intel(E) videodev(E) snd_soc_core(E)
btintel(E) kvm(E) btbcm(E) iwldvm(E) bluetooth(E) mac80211(E)
snd_compress(E) lz4(E) mc(E) zram(E) soundwire_generic_allocation(E)
jitterentropy_rng(E) drbg(E) irqbypass(E) soundwire_cadence(E)
ansi_cprng(E) ecdh_generic(E) libarc4(E) ecc(E) zsmalloc(E)
ghash_clmulni_intel(E) snd_hda_codec(E) aesni_intel(E) iwlwifi(E)
snd_hda_core(E) libaes(E) snd_hwdep(E) drm_kms_helper(E)
crypto_simd(E) cryptd(E) soundwire_bus(E) mei_me(E) cfg80211(E)
iTCO_wdt(E) intel_pmc_bxt(E) mei(E) cec(E)
[So Feb 14 23:21:42 2021]  snd_pcm(E) iTCO_vendor_support(E)
watchdog(E) rapl(E) intel_cstate(E) i2c_algo_bit(E) samsung_laptop(E)
joydev(E) intel_uncore(E) at24(E) evdev(E) serio_raw(E) sg(E)
snd_timer(E) snd(E) rfkill(E) soundcore(E) pcspkr(E) button(E) ac(E)
binfmt_misc(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) drm(E)
fuse(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E)
mbcache(E) crc16(E) jbd2(E) btrfs(E) xor(E) sr_mod(E) cdrom(E)
raid6_pq(E) libcrc32c(E) crc32c_generic(E) sd_mod(E) t10_pi(E)
crc_t10dif(E) crct10dif_generic(E) hid_generic(E) usbhid(E) hid(E)
uas(E) usb_storage(E) crct10dif_pclmul(E) crct10dif_common(E)
crc32_pclmul(E) crc32c_intel(E) ahci(E) libahci(E) xhci_pci(E)
ehci_pci(E) xhci_hcd(E) ehci_hcd(E) libata(E) r8169(E) realtek(E)
mdio_devres(E) i2c_i801(E) psmouse(E) scsi_mod(E) libphy(E) fan(E)
i2c_smbus(E) lpc_ich(E) usbcore(E) battery(E) video(E) wmi(E)
[So Feb 14 23:21:42 2021] CPU: 2 PID: 10366 Comm: kworker/2:1 Tainted:
G            E     5.11.0-rc7-12-amd64-clang12-ias
#12~bullseye+dileks1
[So Feb 14 23:21:42 2021] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
[So Feb 14 23:21:42 2021] Workqueue: events_freezable
ieee80211_restart_work [mac80211]
[So Feb 14 23:21:42 2021] RIP: 0010:ieee80211_reconfig+0x494/0xc20 [mac80211]
[So Feb 14 23:21:42 2021] Code: 98 04 00 00 01 00 00 00 74 dc 4c 89 ff
48 89 de e8 51 51 fc ff 48 8b 4c 24 08 eb ca 48 c7 c7 4b c3 12 c1 31
c0 e8 cc 6e 7a e3 <0f> 0b 4c 89 ff e8 12 08 00 00 65 48 8b 04 25 28 00
00 00 48 3b 44
[So Feb 14 23:21:42 2021] RSP: 0018:ffffad1c82707e00 EFLAGS: 00010246
[So Feb 14 23:21:42 2021] RAX: c09a63dc9fc99f00 RBX: ffff971e04e99900
RCX: 0000000000000027
[So Feb 14 23:21:42 2021] RDX: 00000000ffffefff RSI: 0000000000000004
RDI: ffff971f17a98908
[So Feb 14 23:21:42 2021] RBP: ffff971e04e99d78 R08: 0000000000000000
R09: ffffffffa5e703e0
[So Feb 14 23:21:42 2021] R10: 0000000000000000 R11: ffffad1c82707c28
R12: 00000000ffffff92
[So Feb 14 23:21:42 2021] R13: 0000000000000000 R14: 0000000000000000
R15: ffff971e04e987e0
[So Feb 14 23:21:42 2021] FS:  0000000000000000(0000)
GS:ffff971f17a80000(0000) knlGS:0000000000000000
[So Feb 14 23:21:42 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[So Feb 14 23:21:42 2021] CR2: 000005a308977000 CR3: 000000014a80a001
CR4: 00000000000606e0
[So Feb 14 23:21:42 2021] Call Trace:
[So Feb 14 23:21:42 2021]  ? rcu_exp_sel_wait_wake+0xa20/0xa20
[So Feb 14 23:21:42 2021]  ieee80211_restart_work+0xb8/0xe0 [mac80211]
[So Feb 14 23:21:42 2021]  process_one_work+0x204/0x3e0
[So Feb 14 23:21:42 2021]  worker_thread+0x2a0/0x470
[So Feb 14 23:21:42 2021]  ? process_one_work+0x3e0/0x3e0
[So Feb 14 23:21:42 2021]  kthread+0x129/0x140
[So Feb 14 23:21:42 2021]  ? kthread_blkcg+0x30/0x30
[So Feb 14 23:21:42 2021]  ret_from_fork+0x22/0x30
[So Feb 14 23:21:42 2021] ---[ end trace 2686bfdefc26c61d ]---
[So Feb 14 23:21:42 2021] ------------[ cut here ]------------
[So Feb 14 23:21:42 2021] wlp1s0: Failed check-sdata-in-driver check, flags: 0x4
[So Feb 14 23:21:42 2021] WARNING: CPU: 2 PID: 10366 at
net/mac80211/driver-ops.c:97 drv_remove_interface+0x8a/0x100
[mac80211]
[So Feb 14 23:21:42 2021] Modules linked in: ctr(E) ccm(E) bnep(E)
option(E) cdc_ether(E) usb_wwan(E) usbserial(E) usbnet(E) mii(E)
snd_hda_codec_hdmi(E) intel_rapl_msr(E) snd_hda_codec_realtek(E)
intel_rapl_common(E) snd_hda_codec_generic(E) x86_pkg_temp_thermal(E)
uvcvideo(E) ledtrig_audio(E) snd_hda_intel(E) intel_powerclamp(E)
btusb(E) videobuf2_vmalloc(E) snd_intel_dspcfg(E) videobuf2_memops(E)
coretemp(E) videobuf2_v4l2(E) kvm_intel(E) btrtl(E) i915(E)
videobuf2_common(E) soundwire_intel(E) videodev(E) snd_soc_core(E)
btintel(E) kvm(E) btbcm(E) iwldvm(E) bluetooth(E) mac80211(E)
snd_compress(E) lz4(E) mc(E) zram(E) soundwire_generic_allocation(E)
jitterentropy_rng(E) drbg(E) irqbypass(E) soundwire_cadence(E)
ansi_cprng(E) ecdh_generic(E) libarc4(E) ecc(E) zsmalloc(E)
ghash_clmulni_intel(E) snd_hda_codec(E) aesni_intel(E) iwlwifi(E)
snd_hda_core(E) libaes(E) snd_hwdep(E) drm_kms_helper(E)
crypto_simd(E) cryptd(E) soundwire_bus(E) mei_me(E) cfg80211(E)
iTCO_wdt(E) intel_pmc_bxt(E) mei(E) cec(E)
[So Feb 14 23:21:42 2021]  snd_pcm(E) iTCO_vendor_support(E)
watchdog(E) rapl(E) intel_cstate(E) i2c_algo_bit(E) samsung_laptop(E)
joydev(E) intel_uncore(E) at24(E) evdev(E) serio_raw(E) sg(E)
snd_timer(E) snd(E) rfkill(E) soundcore(E) pcspkr(E) button(E) ac(E)
binfmt_misc(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) drm(E)
fuse(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E)
mbcache(E) crc16(E) jbd2(E) btrfs(E) xor(E) sr_mod(E) cdrom(E)
raid6_pq(E) libcrc32c(E) crc32c_generic(E) sd_mod(E) t10_pi(E)
crc_t10dif(E) crct10dif_generic(E) hid_generic(E) usbhid(E) hid(E)
uas(E) usb_storage(E) crct10dif_pclmul(E) crct10dif_common(E)
crc32_pclmul(E) crc32c_intel(E) ahci(E) libahci(E) xhci_pci(E)
ehci_pci(E) xhci_hcd(E) ehci_hcd(E) libata(E) r8169(E) realtek(E)
mdio_devres(E) i2c_i801(E) psmouse(E) scsi_mod(E) libphy(E) fan(E)
i2c_smbus(E) lpc_ich(E) usbcore(E) battery(E) video(E) wmi(E)
[So Feb 14 23:21:42 2021] CPU: 2 PID: 10366 Comm: kworker/2:1 Tainted:
G        W   E     5.11.0-rc7-12-amd64-clang12-ias
#12~bullseye+dileks1
[So Feb 14 23:21:42 2021] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
[So Feb 14 23:21:42 2021] Workqueue: events_freezable
ieee80211_restart_work [mac80211]
[So Feb 14 23:21:42 2021] RIP: 0010:drv_remove_interface+0x8a/0x100 [mac80211]
[So Feb 14 23:21:42 2021] Code: 9e 0a 00 01 48 8b 83 80 04 00 00 48 81
c3 a0 04 00 00 48 85 c0 48 0f 45 d8 48 c7 c7 2c 8b 12 c1 48 89 de 31
c0 e8 06 1d 7e e3 <0f> 0b eb cb 65 8b 05 73 e3 f5 3e 89 c0 48 0f a3 05
49 93 fa e4 73
[So Feb 14 23:21:42 2021] RSP: 0018:ffffad1c82707c68 EFLAGS: 00010246
[So Feb 14 23:21:42 2021] RAX: c09a63dc9fc99f00 RBX: ffff971e037a8000
RCX: 0000000000000027
[So Feb 14 23:21:42 2021] RDX: 00000000ffffefff RSI: 0000000000000004
RDI: ffff971f17a98908
[So Feb 14 23:21:42 2021] RBP: ffff971e04e99960 R08: 0000000000000000
R09: ffffffffa5e703e0
[So Feb 14 23:21:42 2021] R10: 0000000000000000 R11: ffffad1c82707a98
R12: ffff971e04e99960
[So Feb 14 23:21:42 2021] R13: ffff971e037a9520 R14: ffff971e04e987e0
R15: 0000000000000286
[So Feb 14 23:21:42 2021] FS:  0000000000000000(0000)
GS:ffff971f17a80000(0000) knlGS:0000000000000000
[So Feb 14 23:21:42 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[So Feb 14 23:21:42 2021] CR2: 000005a308977000 CR3: 000000014a80a001
CR4: 00000000000606e0
[So Feb 14 23:21:42 2021] Call Trace:
[So Feb 14 23:21:42 2021]  ieee80211_do_stop+0x70c/0x7e0 [mac80211]
[So Feb 14 23:21:42 2021]  ? dev_reset_queue+0x66/0x80
[So Feb 14 23:21:42 2021]  ieee80211_stop+0x16/0x20 [mac80211]
[So Feb 14 23:21:42 2021]  __dev_close_many+0x133/0x180
[So Feb 14 23:21:42 2021]  dev_close_many+0x37/0x1a0
[So Feb 14 23:21:42 2021]  dev_close+0x6e/0xb0
[So Feb 14 23:21:42 2021]  cfg80211_shutdown_all_interfaces+0x55/0xc0 [cfg80211]
[So Feb 14 23:21:42 2021]  ieee80211_reconfig+0x49e/0xc20 [mac80211]
[So Feb 14 23:21:42 2021]  ? rcu_exp_sel_wait_wake+0xa20/0xa20
[So Feb 14 23:21:42 2021]  ieee80211_restart_work+0xb8/0xe0 [mac80211]
[So Feb 14 23:21:42 2021]  process_one_work+0x204/0x3e0
[So Feb 14 23:21:42 2021]  worker_thread+0x2a0/0x470
[So Feb 14 23:21:42 2021]  ? process_one_work+0x3e0/0x3e0
[So Feb 14 23:21:42 2021]  kthread+0x129/0x140
[So Feb 14 23:21:42 2021]  ? kthread_blkcg+0x30/0x30
[So Feb 14 23:21:42 2021]  ret_from_fork+0x22/0x30
[So Feb 14 23:21:42 2021] ---[ end trace 2686bfdefc26c61e ]---
[So Feb 14 23:21:42 2021] ------------[ cut here ]------------
[So Feb 14 23:21:42 2021] WARNING: CPU: 2 PID: 10366 at
net/mac80211/driver-ops.c:36 drv_stop+0x73/0xe0 [mac80211]
[So Feb 14 23:21:42 2021] Modules linked in: ctr(E) ccm(E) bnep(E)
option(E) cdc_ether(E) usb_wwan(E) usbserial(E) usbnet(E) mii(E)
snd_hda_codec_hdmi(E) intel_rapl_msr(E) snd_hda_codec_realtek(E)
intel_rapl_common(E) snd_hda_codec_generic(E) x86_pkg_temp_thermal(E)
uvcvideo(E) ledtrig_audio(E) snd_hda_intel(E) intel_powerclamp(E)
btusb(E) videobuf2_vmalloc(E) snd_intel_dspcfg(E) videobuf2_memops(E)
coretemp(E) videobuf2_v4l2(E) kvm_intel(E) btrtl(E) i915(E)
videobuf2_common(E) soundwire_intel(E) videodev(E) snd_soc_core(E)
btintel(E) kvm(E) btbcm(E) iwldvm(E) bluetooth(E) mac80211(E)
snd_compress(E) lz4(E) mc(E) zram(E) soundwire_generic_allocation(E)
jitterentropy_rng(E) drbg(E) irqbypass(E) soundwire_cadence(E)
ansi_cprng(E) ecdh_generic(E) libarc4(E) ecc(E) zsmalloc(E)
ghash_clmulni_intel(E) snd_hda_codec(E) aesni_intel(E) iwlwifi(E)
snd_hda_core(E) libaes(E) snd_hwdep(E) drm_kms_helper(E)
crypto_simd(E) cryptd(E) soundwire_bus(E) mei_me(E) cfg80211(E)
iTCO_wdt(E) intel_pmc_bxt(E) mei(E) cec(E)
[So Feb 14 23:21:42 2021]  snd_pcm(E) iTCO_vendor_support(E)
watchdog(E) rapl(E) intel_cstate(E) i2c_algo_bit(E) samsung_laptop(E)
joydev(E) intel_uncore(E) at24(E) evdev(E) serio_raw(E) sg(E)
snd_timer(E) snd(E) rfkill(E) soundcore(E) pcspkr(E) button(E) ac(E)
binfmt_misc(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) drm(E)
fuse(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E)
mbcache(E) crc16(E) jbd2(E) btrfs(E) xor(E) sr_mod(E) cdrom(E)
raid6_pq(E) libcrc32c(E) crc32c_generic(E) sd_mod(E) t10_pi(E)
crc_t10dif(E) crct10dif_generic(E) hid_generic(E) usbhid(E) hid(E)
uas(E) usb_storage(E) crct10dif_pclmul(E) crct10dif_common(E)
crc32_pclmul(E) crc32c_intel(E) ahci(E) libahci(E) xhci_pci(E)
ehci_pci(E) xhci_hcd(E) ehci_hcd(E) libata(E) r8169(E) realtek(E)
mdio_devres(E) i2c_i801(E) psmouse(E) scsi_mod(E) libphy(E) fan(E)
i2c_smbus(E) lpc_ich(E) usbcore(E) battery(E) video(E) wmi(E)
[So Feb 14 23:21:42 2021] CPU: 2 PID: 10366 Comm: kworker/2:1 Tainted:
G        W   E     5.11.0-rc7-12-amd64-clang12-ias
#12~bullseye+dileks1
[So Feb 14 23:21:42 2021] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
[So Feb 14 23:21:42 2021] Workqueue: events_freezable
ieee80211_restart_work [mac80211]
[So Feb 14 23:21:42 2021] RIP: 0010:drv_stop+0x73/0xe0 [mac80211]
[So Feb 14 23:21:42 2021] Code: 1f 84 00 00 00 00 00 48 f7 83 98 05 00
00 02 00 00 00 75 f3 f0 83 44 24 fc 00 f0 ff 8b a0 05 00 00 c6 83 64
05 00 00 00 5b c3 <0f> 0b 5b c3 65 8b 05 6a e6 f5 3e 89 c0 48 0f a3 05
40 96 fa e4 73
[So Feb 14 23:21:42 2021] RSP: 0018:ffffad1c82707c70 EFLAGS: 00010297
[So Feb 14 23:21:42 2021] RAX: 0000000000000000 RBX: ffff971e04e987e0
RCX: ffff971eaaafb000
[So Feb 14 23:21:42 2021] RDX: 0000000000000000 RSI: 0000000000000292
RDI: ffff971e04e987e0
[So Feb 14 23:21:42 2021] RBP: ffff971e04e99960 R08: 0000000000000000
R09: ffffffffa5e703e0
[So Feb 14 23:21:42 2021] R10: 0000000000000000 R11: ffffffffc11b5d00
R12: ffff971e04e99960
[So Feb 14 23:21:42 2021] R13: ffff971e037a9520 R14: ffff971e037a8940
R15: 0000000000000286
[So Feb 14 23:21:42 2021] FS:  0000000000000000(0000)
GS:ffff971f17a80000(0000) knlGS:0000000000000000
[So Feb 14 23:21:42 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[So Feb 14 23:21:42 2021] CR2: 000005a308977000 CR3: 000000014a80a001
CR4: 00000000000606e0
[So Feb 14 23:21:42 2021] Call Trace:
[So Feb 14 23:21:42 2021]  ieee80211_do_stop+0x773/0x7e0 [mac80211]
[So Feb 14 23:21:42 2021]  ? dev_reset_queue+0x66/0x80
[So Feb 14 23:21:42 2021]  ieee80211_stop+0x16/0x20 [mac80211]
[So Feb 14 23:21:42 2021]  __dev_close_many+0x133/0x180
[So Feb 14 23:21:42 2021]  dev_close_many+0x37/0x1a0
[So Feb 14 23:21:42 2021]  dev_close+0x6e/0xb0
[So Feb 14 23:21:42 2021]  cfg80211_shutdown_all_interfaces+0x55/0xc0 [cfg80211]
[So Feb 14 23:21:42 2021]  ieee80211_reconfig+0x49e/0xc20 [mac80211]
[So Feb 14 23:21:42 2021]  ? rcu_exp_sel_wait_wake+0xa20/0xa20
[So Feb 14 23:21:42 2021]  ieee80211_restart_work+0xb8/0xe0 [mac80211]
[So Feb 14 23:21:42 2021]  process_one_work+0x204/0x3e0
[So Feb 14 23:21:42 2021]  worker_thread+0x2a0/0x470
[So Feb 14 23:21:42 2021]  ? process_one_work+0x3e0/0x3e0
[So Feb 14 23:21:42 2021]  kthread+0x129/0x140
[So Feb 14 23:21:42 2021]  ? kthread_blkcg+0x30/0x30
[So Feb 14 23:21:42 2021]  ret_from_fork+0x22/0x30
[So Feb 14 23:21:42 2021] ---[ end trace 2686bfdefc26c61f ]---
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:42 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:49 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:49 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:21:52 2021] wlp1s0: authenticate with f6:f5:24:2e:54:f5
[So Feb 14 23:21:52 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 1/3)
[So Feb 14 23:21:53 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 2/3)
[So Feb 14 23:21:54 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 3/3)
[So Feb 14 23:21:55 2021] wlp1s0: authentication with
f6:f5:24:2e:54:f5 timed out
[So Feb 14 23:21:59 2021] wlp1s0: authenticate with f6:f5:24:2e:54:f5
[So Feb 14 23:21:59 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 1/3)
[So Feb 14 23:21:59 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 2/3)
[So Feb 14 23:22:00 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 3/3)
[So Feb 14 23:22:01 2021] wlp1s0: authentication with
f6:f5:24:2e:54:f5 timed out
[So Feb 14 23:22:05 2021] wlp1s0: authenticate with f6:f5:24:2e:54:f5
[So Feb 14 23:22:05 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 1/3)
[So Feb 14 23:22:06 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 2/3)
[So Feb 14 23:22:07 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 3/3)
[So Feb 14 23:22:08 2021] wlp1s0: authentication with
f6:f5:24:2e:54:f5 timed out
[So Feb 14 23:22:12 2021] wlp1s0: authenticate with f6:f5:24:2e:54:f5
[So Feb 14 23:22:12 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 1/3)
[So Feb 14 23:22:13 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 2/3)
[So Feb 14 23:22:14 2021] wlp1s0: send auth to f6:f5:24:2e:54:f5 (try 3/3)
[So Feb 14 23:22:15 2021] wlp1s0: aborting authentication with
f6:f5:24:2e:54:f5 by local choice (Reason: 3=DEAUTH_LEAVING)
[So Feb 14 23:22:15 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0
[So Feb 14 23:22:15 2021] iwlwifi 0000:01:00.0: Radio type=0x1-0x2-0x0

Thanks.

Regards,
- Sedat -
