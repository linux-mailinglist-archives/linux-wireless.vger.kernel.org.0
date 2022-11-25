Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE23637FA2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiKXT3U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXT3S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:29:18 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998443F078
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:29:14 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t10so2994368ljj.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7GeXFAMKeWIHyn6QkFox6MiekrqL+e1x7VcRzedevzo=;
        b=ITuFLMgy3iV6tWk2TC/ip+QIr5JzJGkxo5321sLB6KrgFF3KG0H15mEi8+hGMumESd
         hlpUYqt7PeN+/0GS/SdWefPnAx9unu0VhJd9oXpIK0ymvDfDff0STZ5M8+wQk11KtWSQ
         XfOXnsenPC5TV2SPXwIsQAlwzVnaMNe5RW7ut50HFgqEgfO+n0GlHIN42jyuOckGqp4Y
         4zt+1W86tdwLE9iT5ej6esJKl0iU26bCdQZcdCweYEBWNEJjRj0tNHsBIS2F+mhR9JVH
         0wCqLQoVtCtI1FODgTHOfiUW+nqeAAkJaVGPiAiMsavDvaHovbbnw2T7LBGPcITJDiPl
         mKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GeXFAMKeWIHyn6QkFox6MiekrqL+e1x7VcRzedevzo=;
        b=iSGjxTaELPCIvP524zdOZAlO0N/MG+IT8ZyMD3rrQlYZHRGEZ/xiZhP3ZDc6GpZSVX
         OinxD6aVOaa5JKk+At3upZvhxQjCHQZtcLcNDaE17j30gHF7dkmE8XQ6du59X2aG4UE1
         hbt6035VI+tvi6qDk6UK5BZYv0ifuQ/A4/fuE4QFnoh20L9Vj9MV3FHbMwrRuTpKUmBf
         YQBT5Rw7yxJQcZH5tiKT3GASPjqzgFkZNuevRGKDs08rJCJIfrnPG+nRq4CtX1GAmMJA
         mJBUlRMrZhCnCNYpQ1NdHGy4fb68yyKiaeYdRIbil5lQIvQHXy6Rbn+vkpufftIR5UY3
         kiBA==
X-Gm-Message-State: ANoB5pmlgHmFUy11pR7RKcocj6D0uj9+fIFIqeBDA1Z0+alg+MVr7tSe
        rv32Gb0XBPA0MvCZqckAaE5cVdNwD3Rty77CHY7OmmWKl+u09g==
X-Google-Smtp-Source: AA0mqf5HhqCeMklc+0wKmFkWk5UH+29f69lY2ib9GGuAWwnmt6e9g9wplO2UtRhDeV5/96S1KssfrPE9H4zt+gAw2Eg=
X-Received: by 2002:a2e:894f:0:b0:279:7c42:9240 with SMTP id
 b15-20020a2e894f000000b002797c429240mr2538468ljk.54.1669318152275; Thu, 24
 Nov 2022 11:29:12 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:28:01 +0200
Message-ID: <CADUzMVYuSw6hgfrFgBKneU7EaAoM+mYg0UGYC3+R+ne3=TNJsg@mail.gmail.com>
Subject: Centrino Advanced-N 6205 Intel WPA3 SSID connection problem #5
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Using the next miniPCIe card on Debian boot I get:
[    9.368112] iwlwifi 0000:02:00.0: can't disable ASPM; OS doesn't
have ASPM control
[    9.452538] iwlwifi 0000:02:00.0: firmware: direct-loading firmware
iwlwifi-6000g2a-6.ucode
[    9.452838] iwlwifi 0000:02:00.0: loaded firmware version
18.168.6.1 6000g2a-6.ucode op_mode iwldvm
[    9.452862] iwlwifi 0000:02:00.0: firmware: failed to load
iwl-debug-yoyo.bin (-2)
[   10.060125] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUG disabled
[   10.060128] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
[   10.060129] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
[   10.060131] iwlwifi 0000:02:00.0: Detected Intel(R) Centrino(R)
Advanced-N 6205 AGN, REV=0xB0
[   10.092372] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[   10.117436] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[  114.194762] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0

First I selected the 5GHz WPA3 SSID but then I could not even
connected to the WPA2,3 2,4GHz SSID:
[   44.120256] rfkill: input handler enabled
[   47.720488] rfkill: input handler disabled
[  114.194762] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  114.492468] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  117.912907] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  118.212709] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  129.882183] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  130.180600] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  130.306291] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  130.604614] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  134.898723] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  135.196614] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  138.498421] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  138.805324] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  145.962610] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  146.260658] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  146.384767] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  146.689322] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  183.309709] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  183.608711] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  186.935214] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  187.232515] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  210.926931] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  211.224516] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  211.347170] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  211.644400] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  214.879202] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  215.180539] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  215.301464] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  215.600924] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  227.163192] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  227.464601] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  227.600393] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  227.900591] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  231.258020] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  231.556637] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  253.748286] iwlwifi 0000:02:00.0: Error sending
REPLY_SCAN_ABORT_CMD: time out after 2000ms.
[  253.748301] iwlwifi 0000:02:00.0: Current CMD queue read_ptr 38 write_ptr 39
[  253.996850] iwlwifi 0000:02:00.0: Loaded firmware version:
18.168.6.1 6000g2a-6.ucode
[  253.996945] iwlwifi 0000:02:00.0: 0x00000000 | OK
[  253.996948] iwlwifi 0000:02:00.0: 0x00000000 | uPc
[  253.996949] iwlwifi 0000:02:00.0: 0x00000000 | branchlink1
[  253.996950] iwlwifi 0000:02:00.0: 0x00000000 | branchlink2
[  253.996951] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink1
[  253.996952] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  253.996953] iwlwifi 0000:02:00.0: 0x00000000 | data1
[  253.996954] iwlwifi 0000:02:00.0: 0x00000000 | data2
[  253.996955] iwlwifi 0000:02:00.0: 0x00000000 | line
[  253.996956] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  253.996957] iwlwifi 0000:02:00.0: 0x00000000 | tsf low
[  253.996958] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  253.996959] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  253.996961] iwlwifi 0000:02:00.0: 0x00000000 | time gp2
[  253.996962] iwlwifi 0000:02:00.0: 0x00000000 | time gp3
[  253.996963] iwlwifi 0000:02:00.0: 0x00000000 | uCode version
[  253.996964] iwlwifi 0000:02:00.0: 0x00000000 | hw version
[  253.996965] iwlwifi 0000:02:00.0: 0x00000000 | board version
[  253.996966] iwlwifi 0000:02:00.0: 0x00000000 | hcmd
[  253.996967] iwlwifi 0000:02:00.0: 0x00000000 | isr0
[  253.996968] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  253.996969] iwlwifi 0000:02:00.0: 0x00000000 | isr2
[  253.996971] iwlwifi 0000:02:00.0: 0x00000000 | isr3
[  253.996972] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  253.996973] iwlwifi 0000:02:00.0: 0x00000000 | isr_pref
[  253.996974] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  253.996975] iwlwifi 0000:02:00.0: 0x00000000 | l2p_control
[  253.996976] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
[  253.996977] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
[  253.996978] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  253.996979] iwlwifi 0000:02:00.0: 0x00000000 | lmpm_pmg_sel
[  253.996980] iwlwifi 0000:02:00.0: 0x00000000 | timestamp
[  253.996981] iwlwifi 0000:02:00.0: 0x00000000 | flow_handler
[  253.997024] iwlwifi 0000:02:00.0: Start IWL Event Log Dump: nothing in log
[  253.997032] iwlwifi 0000:02:00.0: Command REPLY_RXON failed: FW Error
[  253.997033] iwlwifi 0000:02:00.0: Error clearing ASSOC_MSK on BSS (-5)
[  254.009237] ieee80211 phy0: Hardware restart was requested
[  254.022257] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  254.320660] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  254.418213] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  259.668241] iwlwifi 0000:02:00.0: Failed to load firmware chunk!
[  259.668257] iwlwifi 0000:02:00.0: iwlwifi transaction failed,
dumping registers
[  259.668264] iwlwifi 0000:02:00.0: iwlwifi device config registers:
[  259.668470] iwlwifi 0000:02:00.0: 00000000: 00828086 00100406
02800034 00000001 fddfe004 00000000 00000000 00000000
[  259.668479] iwlwifi 0000:02:00.0: 00000020: 00000000 00000000
00000000 13018086 00000000 000000c8 00000000 00000105
[  259.668486] iwlwifi 0000:02:00.0: 00000040: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668493] iwlwifi 0000:02:00.0: 00000060: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668499] iwlwifi 0000:02:00.0: 00000080: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668506] iwlwifi 0000:02:00.0: 000000a0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668513] iwlwifi 0000:02:00.0: 000000c0: 00000000 00000000
c823d001 0d000000 0081e005 fee08004 00000000 00004024
[  259.668520] iwlwifi 0000:02:00.0: 000000e0: 00010010 10008ec0
00190810 0106ec11 10110040 00000000 00000000 00000000
[  259.668527] iwlwifi 0000:02:00.0: 00000100: 14010001 00000000
00000000 00062011 00002000 00002000 00000000 00000000
[  259.668534] iwlwifi 0000:02:00.0: 00000120: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668541] iwlwifi 0000:02:00.0: 00000140: 00010003 ffa5fa80
606720ff 00000000 00000000 00000000 00000000 00000000
[  259.668546] iwlwifi 0000:02:00.0: iwlwifi device memory mapped registers:
[  259.668585] iwlwifi 0000:02:00.0: 00000000: 00488700 00000040
08000000 00000000 00000001 00000000 00000030 00000000
[  259.668592] iwlwifi 0000:02:00.0: 00000020: 00000001 080403c5
000000b0 00000000 90000001 00030001 80008040 00080046
[  259.668599] iwlwifi 0000:02:00.0: iwlwifi device AER capability structure:
[  259.668628] iwlwifi 0000:02:00.0: 00000000: 14010001 00000000
00000000 00062011 00002000 00002000 00000000 00000000
[  259.668633] iwlwifi 0000:02:00.0: 00000020: 00000000 00000000 00000000
[  259.668638] iwlwifi 0000:02:00.0: iwlwifi parent port
(0000:00:04.0) config registers:
[  259.668706] iwlwifi 0000:00:04.0: 00000000: 96041022 00100407
06040000 00010001 00000000 00000000 00020200 2000d1d1
[  259.668713] iwlwifi 0000:00:04.0: 00000020: fdd0fdd0 fdc1fdc1
00000000 00000000 00000000 00000050 00000000 00020105
[  259.668720] iwlwifi 0000:00:04.0: 00000040: 00000000 00000000
00000000 00000000 c8035801 00000000 0142a010 00008020
[  259.668727] iwlwifi 0000:00:04.0: 00000060: 00000910 01300c12
70110040 00240c80 01480000 00010010 00000000 00000000
[  259.668734] iwlwifi 0000:00:04.0: 00000080: 00000000 00000000
00010042 00000000 00000000 00000000 00000000 00000000
[  259.668740] iwlwifi 0000:00:04.0: 000000a0: 0001b005 fee04004
00004021 00000000 0000b80d 96011022 a8030008 00000000
[  259.668747] iwlwifi 0000:00:04.0: 000000c0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668753] iwlwifi 0000:00:04.0: 000000e0: 00000000 ffffffff
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668760] iwlwifi 0000:00:04.0: 00000100: 1101000b 01010001
00000000 00000000 00010002 00000000 00000000 00000000
[  259.668767] iwlwifi 0000:00:04.0: 00000120: 00000001 800000ff
00000000 00000001 00000000 00020000 00000000 00000000
[  259.668774] iwlwifi 0000:00:04.0: 00000140: 00010003 00000000
00000000 00000000 00010001 00000000 00000000 00062030
[  259.668780] iwlwifi 0000:00:04.0: 00000160: 00000000 00002000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668787] iwlwifi 0000:00:04.0: 00000180: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668793] iwlwifi 0000:00:04.0: 000001a0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668800] iwlwifi 0000:00:04.0: 000001c0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668806] iwlwifi 0000:00:04.0: 000001e0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[  259.668811] iwlwifi 0000:00:04.0: 00000200: 00000000 00000000 00000000
[  259.668818] iwlwifi 0000:02:00.0: Could not load the [0] uCode section
[  259.681066] iwlwifi 0000:02:00.0: Failed to run INIT ucode: -110
[  259.681089] iwlwifi 0000:02:00.0: Unable to initialize device.
[  259.681094] ------------[ cut here ]------------
[  259.681096] Hardware became unavailable during restart.
[  259.681240] WARNING: CPU: 3 PID: 193 at net/mac80211/util.c:2349
ieee80211_reconfig+0xd4/0x12a0 [mac80211]
[  259.681242] Modules linked in: exfat snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg soundwire_intel soundwire_generic_allocation
snd_soc_core joydev iwldvm edac_mce_amd kvm_amd snd_compress
soundwire_cadence ccp snd_hda_codec mac80211 snd_hda_core rng_core kvm
snd_hwdep soundwire_bus snd_pcm libarc4 irqbypass iwlwifi snd_timer
snd serio_raw pcspkr evdev cfg80211 sp5100_tco soundcore k10temp
rfkill watchdog sg acpi_cpufreq wmi_bmof msr parport_pc ppdev lp
parport fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache
jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c
crc32c_generic raid1 raid0 multipath linear md_mod hid_generic usbhid
hid sd_mod t10_pi crc_t10dif crct10dif_generic radeon uas usb_storage
crct10dif_common ohci_pci i2c_algo_bit ttm ahci drm_kms_helper libahci
xhci_pci libata xhci_hcd ohci_hcd cec r8169 ehci_pci i2c_piix4
ehci_hcd drm
[  259.681402]  usbcore scsi_mod realtek mdio_devres libphy usb_common
wmi button
[  259.681423] CPU: 3 PID: 193 Comm: kworker/3:2 Not tainted
5.10.0-18-amd64 #1 Debian 5.10.140-1
[  259.681426] Hardware name: Gigabyte Technology Co., Ltd.
GA-880GMA-USB3/GA-880GMA-USB3, BIOS F4e 05/24/2012
[  259.681486] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[  259.681558] RIP: 0010:ieee80211_reconfig+0xd4/0x12a0 [mac80211]
[  259.681564] Code: 16 00 0f 85 48 03 00 00 c6 85 64 05 00 00 00 48
89 ef e8 ff 65 fc ff 41 89 c4 85 c0 74 14 48 c7 c7 20 6d 0b c1 e8 b4
ab 83 d1 <0f> 0b eb c2 88 5c 24 16 48 8b 45 40 44 8b a0 98 00 00 00 e8
e4 d3
[  259.681568] RSP: 0018:ffffaa42804dbdf8 EFLAGS: 00010282
[  259.681573] RAX: 0000000000000000 RBX: ffff9aba08501920 RCX: ffff9abd204dca08
[  259.681576] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9abd204dca00
[  259.681579] RBP: ffff9aba08500800 R08: 0000000000000000 R09: ffffaa42804dbc18
[  259.681582] R10: ffffaa42804dbc10 R11: ffffffff936cb448 R12: 00000000ffffff92
[  259.681585] R13: ffff9aba08500800 R14: ffff9abd204f3a00 R15: 0000000000000000
[  259.681590] FS:  0000000000000000(0000) GS:ffff9abd204c0000(0000)
knlGS:0000000000000000
[  259.681593] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  259.681596] CR2: 0000556cbbe33fa0 CR3: 00000001120ec000 CR4: 00000000000006e0
[  259.681599] Call Trace:
[  259.681615]  ? del_timer_sync+0x67/0xb0
[  259.681673]  ieee80211_restart_work+0xb7/0xe0 [mac80211]
[  259.681683]  process_one_work+0x1b6/0x350
[  259.681691]  worker_thread+0x53/0x3e0
[  259.681698]  ? process_one_work+0x350/0x350
[  259.681704]  kthread+0x11b/0x140
[  259.681710]  ? __kthread_bind_mask+0x60/0x60
[  259.681716]  ret_from_fork+0x22/0x30
[  259.681722] ---[ end trace c773019c9e5684e1 ]---
[  259.681805] ------------[ cut here ]------------
[  259.681809] wlp2s0: Failed check-sdata-in-driver check, flags: 0x0
[  259.681900] WARNING: CPU: 3 PID: 193 at
net/mac80211/driver-ops.c:97 drv_remove_interface+0xe6/0xf0 [mac80211]
[  259.681902] Modules linked in: exfat snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg soundwire_intel soundwire_generic_allocation
snd_soc_core joydev iwldvm edac_mce_amd kvm_amd snd_compress
soundwire_cadence ccp snd_hda_codec mac80211 snd_hda_core rng_core kvm
snd_hwdep soundwire_bus snd_pcm libarc4 irqbypass iwlwifi snd_timer
snd serio_raw pcspkr evdev cfg80211 sp5100_tco soundcore k10temp
rfkill watchdog sg acpi_cpufreq wmi_bmof msr parport_pc ppdev lp
parport fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache
jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c
crc32c_generic raid1 raid0 multipath linear md_mod hid_generic usbhid
hid sd_mod t10_pi crc_t10dif crct10dif_generic radeon uas usb_storage
crct10dif_common ohci_pci i2c_algo_bit ttm ahci drm_kms_helper libahci
xhci_pci libata xhci_hcd ohci_hcd cec r8169 ehci_pci i2c_piix4
ehci_hcd drm
[  259.682043]  usbcore scsi_mod realtek mdio_devres libphy usb_common
wmi button
[  259.682060] CPU: 3 PID: 193 Comm: kworker/3:2 Tainted: G        W
      5.10.0-18-amd64 #1 Debian 5.10.140-1
[  259.682063] Hardware name: Gigabyte Technology Co., Ltd.
GA-880GMA-USB3/GA-880GMA-USB3, BIOS F4e 05/24/2012
[  259.682119] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[  259.682177] RIP: 0010:drv_remove_interface+0xe6/0xf0 [mac80211]
[  259.682182] Code: 75 8e 48 8b 83 80 04 00 00 48 8d b3 a0 04 00 00
48 c7 c7 a0 5d 0b c1 c6 05 14 90 0b 00 01 48 85 c0 48 0f 45 f0 e8 02
41 87 d1 <0f> 0b e9 5f ff ff ff 0f 1f 00 0f 1f 44 00 00 41 57 41 56 49
89 d6
[  259.682186] RSP: 0018:ffffaa42804dbc88 EFLAGS: 00010282
[  259.682190] RAX: 0000000000000000 RBX: ffff9aba003de940 RCX: ffff9abd204dca08
[  259.682194] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9abd204dca00
[  259.682197] RBP: ffff9aba08500800 R08: 0000000000000000 R09: ffffaa42804dbaa8
[  259.682200] R10: ffffaa42804dbaa0 R11: ffffffff936cb448 R12: ffff9aba08500800
[  259.682203] R13: ffff9aba08501050 R14: ffff9aba08500cf0 R15: ffff9aba003df548
[  259.682207] FS:  0000000000000000(0000) GS:ffff9abd204c0000(0000)
knlGS:0000000000000000
[  259.682210] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  259.682213] CR2: 0000556cbbe33fa0 CR3: 00000001120ec000 CR4: 00000000000006e0
[  259.682215] Call Trace:
[  259.682280]  ieee80211_do_stop+0x550/0x8c0 [mac80211]
[  259.682290]  ? dev_reset_queue+0x64/0x90
[  259.682352]  ieee80211_stop+0x16/0x20 [mac80211]
[  259.682359]  __dev_close_many+0x9e/0x110
[  259.682366]  dev_close_many+0x91/0x150
[  259.682372]  dev_close+0x82/0xb0
[  259.682459]  cfg80211_shutdown_all_interfaces+0x71/0xd0 [cfg80211]
[  259.682530]  ieee80211_reconfig+0xa2/0x12a0 [mac80211]
[  259.682537]  ? del_timer_sync+0x67/0xb0
[  259.682594]  ieee80211_restart_work+0xb7/0xe0 [mac80211]
[  259.682602]  process_one_work+0x1b6/0x350
[  259.682610]  worker_thread+0x53/0x3e0
[  259.682616]  ? process_one_work+0x350/0x350
[  259.682621]  kthread+0x11b/0x140
[  259.682626]  ? __kthread_bind_mask+0x60/0x60
[  259.682633]  ret_from_fork+0x22/0x30
[  259.682639] ---[ end trace c773019c9e5684e2 ]---
[  259.682681] ------------[ cut here ]------------
[  259.682739] WARNING: CPU: 3 PID: 193 at
net/mac80211/driver-ops.c:36 drv_stop+0xcc/0xe0 [mac80211]
[  259.682741] Modules linked in: exfat snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg soundwire_intel soundwire_generic_allocation
snd_soc_core joydev iwldvm edac_mce_amd kvm_amd snd_compress
soundwire_cadence ccp snd_hda_codec mac80211 snd_hda_core rng_core kvm
snd_hwdep soundwire_bus snd_pcm libarc4 irqbypass iwlwifi snd_timer
snd serio_raw pcspkr evdev cfg80211 sp5100_tco soundcore k10temp
rfkill watchdog sg acpi_cpufreq wmi_bmof msr parport_pc ppdev lp
parport fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache
jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c
crc32c_generic raid1 raid0 multipath linear md_mod hid_generic usbhid
hid sd_mod t10_pi crc_t10dif crct10dif_generic radeon uas usb_storage
crct10dif_common ohci_pci i2c_algo_bit ttm ahci drm_kms_helper libahci
xhci_pci libata xhci_hcd ohci_hcd cec r8169 ehci_pci i2c_piix4
ehci_hcd drm
[  259.682886]  usbcore scsi_mod realtek mdio_devres libphy usb_common
wmi button
[  259.682902] CPU: 3 PID: 193 Comm: kworker/3:2 Tainted: G        W
      5.10.0-18-amd64 #1 Debian 5.10.140-1
[  259.682905] Hardware name: Gigabyte Technology Co., Ltd.
GA-880GMA-USB3/GA-880GMA-USB3, BIOS F4e 05/24/2012
[  259.682961] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[  259.683019] RIP: 0010:drv_stop+0xcc/0xe0 [mac80211]
[  259.683024] Code: 3e 89 c0 48 0f a3 05 93 22 83 d2 73 89 48 8b 05
ca 01 0c 00 48 85 c0 74 0c 48 8b 78 08 48 89 de e8 09 0f 04 00 e9 6c
ff ff ff <0f> 0b 5b c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90
0f 1f
[  259.683027] RSP: 0018:ffffaa42804dbc90 EFLAGS: 00010246
[  259.683031] RAX: 0000000000000000 RBX: ffff9aba08500800 RCX: 0000000000000000
[  259.683034] RDX: ffff9aba136b4380 RSI: 0000000000000296 RDI: ffff9aba08500800
[  259.683037] RBP: ffff9aba08501980 R08: ffff9aba00050c00 R09: ffffffff936538b8
[  259.683040] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9aba08500800
[  259.683043] R13: ffff9aba08501050 R14: ffff9aba08500cf0 R15: ffff9aba003df548
[  259.683047] FS:  0000000000000000(0000) GS:ffff9abd204c0000(0000)
knlGS:0000000000000000
[  259.683050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  259.683053] CR2: 0000556cbbe33fa0 CR3: 00000001120ec000 CR4: 00000000000006e0
[  259.683055] Call Trace:
[  259.683118]  ieee80211_do_stop+0x588/0x8c0 [mac80211]
[  259.683126]  ? dev_reset_queue+0x64/0x90
[  259.683188]  ieee80211_stop+0x16/0x20 [mac80211]
[  259.683194]  __dev_close_many+0x9e/0x110
[  259.683200]  dev_close_many+0x91/0x150
[  259.683206]  dev_close+0x82/0xb0
[  259.683271]  cfg80211_shutdown_all_interfaces+0x71/0xd0 [cfg80211]
[  259.683339]  ieee80211_reconfig+0xa2/0x12a0 [mac80211]
[  259.683345]  ? del_timer_sync+0x67/0xb0
[  259.683402]  ieee80211_restart_work+0xb7/0xe0 [mac80211]
[  259.683410]  process_one_work+0x1b6/0x350
[  259.683417]  worker_thread+0x53/0x3e0
[  259.683423]  ? process_one_work+0x350/0x350
[  259.683428]  kthread+0x11b/0x140
[  259.683434]  ? __kthread_bind_mask+0x60/0x60
[  259.683440]  ret_from_fork+0x22/0x30
[  259.683445] ---[ end trace c773019c9e5684e3 ]---
[  259.739162] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  260.036591] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  263.332858] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  263.633430] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  313.117376] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  313.416688] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  313.538501] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  313.836711] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  354.040246] iwlwifi 0000:02:00.0: Error sending
REPLY_SCAN_ABORT_CMD: time out after 2000ms.
[  354.040262] iwlwifi 0000:02:00.0: Current CMD queue read_ptr 34 write_ptr 35
[  354.288819] iwlwifi 0000:02:00.0: Loaded firmware version:
18.168.6.1 6000g2a-6.ucode
[  354.288915] iwlwifi 0000:02:00.0: 0x00000000 | OK
[  354.288916] iwlwifi 0000:02:00.0: 0x00000000 | uPc
[  354.288918] iwlwifi 0000:02:00.0: 0x00000000 | branchlink1
[  354.288922] iwlwifi 0000:02:00.0: HCMD_ACTIVE already clear for
command REPLY_SCAN_ABORT_CMD
[  354.288925] iwlwifi 0000:02:00.0: 0x00000000 | branchlink2
[  354.288926] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink1
[  354.288927] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  354.288928] iwlwifi 0000:02:00.0: 0x00000000 | data1
[  354.288929] iwlwifi 0000:02:00.0: 0x00000000 | data2
[  354.288930] iwlwifi 0000:02:00.0: 0x00000000 | line
[  354.288931] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  354.288932] iwlwifi 0000:02:00.0: 0x00000000 | tsf low
[  354.288933] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  354.288934] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  354.288935] iwlwifi 0000:02:00.0: 0x00000000 | time gp2
[  354.288936] iwlwifi 0000:02:00.0: 0x00000000 | time gp3
[  354.288938] iwlwifi 0000:02:00.0: 0x00000000 | uCode version
[  354.288939] iwlwifi 0000:02:00.0: 0x00000000 | hw version
[  354.288940] iwlwifi 0000:02:00.0: 0x00000000 | board version
[  354.288941] iwlwifi 0000:02:00.0: 0x00000000 | hcmd
[  354.288942] iwlwifi 0000:02:00.0: 0x00000000 | isr0
[  354.288943] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  354.288944] iwlwifi 0000:02:00.0: 0x00000000 | isr2
[  354.288945] iwlwifi 0000:02:00.0: 0x00000000 | isr3
[  354.288946] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  354.288947] iwlwifi 0000:02:00.0: 0x00000000 | isr_pref
[  354.288948] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  354.288949] iwlwifi 0000:02:00.0: 0x00000000 | l2p_control
[  354.288950] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
[  354.288952] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
[  354.288953] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  354.288954] iwlwifi 0000:02:00.0: 0x00000000 | lmpm_pmg_sel
[  354.288955] iwlwifi 0000:02:00.0: 0x00000000 | timestamp
[  354.288956] iwlwifi 0000:02:00.0: 0x00000000 | flow_handler
[  354.288999] iwlwifi 0000:02:00.0: Start IWL Event Log Dump: nothing in log
[  354.289012] iwlwifi 0000:02:00.0: Command REPLY_RXON failed: FW Error
[  354.289013] iwlwifi 0000:02:00.0: Error clearing ASSOC_MSK on BSS (-5)
[  354.301229] ieee80211 phy0: Hardware restart was requested
[  354.314267] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  354.612640] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  354.709574] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  359.764224] iwlwifi 0000:02:00.0: Failed to load firmware chunk!
[  359.764240] iwlwifi 0000:02:00.0: Could not load the [0] uCode section
[  359.776231] iwlwifi 0000:02:00.0: Failed to run INIT ucode: -110
[  359.776253] iwlwifi 0000:02:00.0: Unable to initialize device.
[  359.776271] ------------[ cut here ]------------
[  359.776273] Hardware became unavailable during restart.
[  359.776418] WARNING: CPU: 0 PID: 139 at net/mac80211/util.c:2349
ieee80211_reconfig+0xd4/0x12a0 [mac80211]
[  359.776420] Modules linked in: exfat snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg soundwire_intel soundwire_generic_allocation
snd_soc_core joydev iwldvm edac_mce_amd kvm_amd snd_compress
soundwire_cadence ccp snd_hda_codec mac80211 snd_hda_core rng_core kvm
snd_hwdep soundwire_bus snd_pcm libarc4 irqbypass iwlwifi snd_timer
snd serio_raw pcspkr evdev cfg80211 sp5100_tco soundcore k10temp
rfkill watchdog sg acpi_cpufreq wmi_bmof msr parport_pc ppdev lp
parport fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache
jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c
crc32c_generic raid1 raid0 multipath linear md_mod hid_generic usbhid
hid sd_mod t10_pi crc_t10dif crct10dif_generic radeon uas usb_storage
crct10dif_common ohci_pci i2c_algo_bit ttm ahci drm_kms_helper libahci
xhci_pci libata xhci_hcd ohci_hcd cec r8169 ehci_pci i2c_piix4
ehci_hcd drm
[  359.776585]  usbcore scsi_mod realtek mdio_devres libphy usb_common
wmi button
[  359.776611] CPU: 0 PID: 139 Comm: kworker/0:2 Tainted: G        W
      5.10.0-18-amd64 #1 Debian 5.10.140-1
[  359.776615] Hardware name: Gigabyte Technology Co., Ltd.
GA-880GMA-USB3/GA-880GMA-USB3, BIOS F4e 05/24/2012
[  359.776674] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[  359.776746] RIP: 0010:ieee80211_reconfig+0xd4/0x12a0 [mac80211]
[  359.776752] Code: 16 00 0f 85 48 03 00 00 c6 85 64 05 00 00 00 48
89 ef e8 ff 65 fc ff 41 89 c4 85 c0 74 14 48 c7 c7 20 6d 0b c1 e8 b4
ab 83 d1 <0f> 0b eb c2 88 5c 24 16 48 8b 45 40 44 8b a0 98 00 00 00 e8
e4 d3
[  359.776756] RSP: 0018:ffffaa4280243df8 EFLAGS: 00010282
[  359.776761] RAX: 0000000000000000 RBX: ffff9aba08501920 RCX: ffff9abd2041ca08
[  359.776764] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9abd2041ca00
[  359.776767] RBP: ffff9aba08500800 R08: 0000000000000000 R09: ffffaa4280243c18
[  359.776770] R10: ffffaa4280243c10 R11: ffffffff936cb448 R12: 00000000ffffff92
[  359.776773] R13: ffff9aba08500800 R14: ffff9abd20433a00 R15: 0000000000000000
[  359.776778] FS:  0000000000000000(0000) GS:ffff9abd20400000(0000)
knlGS:0000000000000000
[  359.776781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  359.776785] CR2: 00007f2ef449c004 CR3: 0000000120816000 CR4: 00000000000006f0
[  359.776787] Call Trace:
[  359.776805]  ? del_timer_sync+0x67/0xb0
[  359.776863]  ieee80211_restart_work+0xb7/0xe0 [mac80211]
[  359.776873]  process_one_work+0x1b6/0x350
[  359.776881]  worker_thread+0x53/0x3e0
[  359.776887]  ? process_one_work+0x350/0x350
[  359.776893]  kthread+0x11b/0x140
[  359.776898]  ? __kthread_bind_mask+0x60/0x60
[  359.776905]  ret_from_fork+0x22/0x30
[  359.776911] ---[ end trace c773019c9e5684e4 ]---
[  359.777038] ------------[ cut here ]------------
[  359.777099] WARNING: CPU: 0 PID: 139 at
net/mac80211/driver-ops.c:36 drv_stop+0xcc/0xe0 [mac80211]
[  359.777101] Modules linked in: exfat snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg soundwire_intel soundwire_generic_allocation
snd_soc_core joydev iwldvm edac_mce_amd kvm_amd snd_compress
soundwire_cadence ccp snd_hda_codec mac80211 snd_hda_core rng_core kvm
snd_hwdep soundwire_bus snd_pcm libarc4 irqbypass iwlwifi snd_timer
snd serio_raw pcspkr evdev cfg80211 sp5100_tco soundcore k10temp
rfkill watchdog sg acpi_cpufreq wmi_bmof msr parport_pc ppdev lp
parport fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache
jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c
crc32c_generic raid1 raid0 multipath linear md_mod hid_generic usbhid
hid sd_mod t10_pi crc_t10dif crct10dif_generic radeon uas usb_storage
crct10dif_common ohci_pci i2c_algo_bit ttm ahci drm_kms_helper libahci
xhci_pci libata xhci_hcd ohci_hcd cec r8169 ehci_pci i2c_piix4
ehci_hcd drm
[  359.777243]  usbcore scsi_mod realtek mdio_devres libphy usb_common
wmi button
[  359.777260] CPU: 0 PID: 139 Comm: kworker/0:2 Tainted: G        W
      5.10.0-18-amd64 #1 Debian 5.10.140-1
[  359.777263] Hardware name: Gigabyte Technology Co., Ltd.
GA-880GMA-USB3/GA-880GMA-USB3, BIOS F4e 05/24/2012
[  359.777319] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[  359.777377] RIP: 0010:drv_stop+0xcc/0xe0 [mac80211]
[  359.777383] Code: 3e 89 c0 48 0f a3 05 93 22 83 d2 73 89 48 8b 05
ca 01 0c 00 48 85 c0 74 0c 48 8b 78 08 48 89 de e8 09 0f 04 00 e9 6c
ff ff ff <0f> 0b 5b c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90
0f 1f
[  359.777386] RSP: 0018:ffffaa4280243c90 EFLAGS: 00010246
[  359.777391] RAX: 0000000000000000 RBX: ffff9aba08500800 RCX: 0000000000000000
[  359.777394] RDX: ffff9abaad8d9680 RSI: 0000000000000296 RDI: ffff9aba08500800
[  359.777397] RBP: ffff9aba08501980 R08: ffff9aba00050c00 R09: ffffffff936538b8
[  359.777400] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9aba08500800
[  359.777403] R13: ffff9aba08501050 R14: ffff9aba08500cf0 R15: ffff9aba003df548
[  359.777407] FS:  0000000000000000(0000) GS:ffff9abd20400000(0000)
knlGS:0000000000000000
[  359.777410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  359.777413] CR2: 00007f2ef449c004 CR3: 0000000120816000 CR4: 00000000000006f0
[  359.777415] Call Trace:
[  359.777480]  ieee80211_do_stop+0x588/0x8c0 [mac80211]
[  359.777490]  ? dev_reset_queue+0x64/0x90
[  359.777553]  ieee80211_stop+0x16/0x20 [mac80211]
[  359.777560]  __dev_close_many+0x9e/0x110
[  359.777567]  dev_close_many+0x91/0x150
[  359.777573]  dev_close+0x82/0xb0
[  359.777662]  cfg80211_shutdown_all_interfaces+0x71/0xd0 [cfg80211]
[  359.777732]  ieee80211_reconfig+0xa2/0x12a0 [mac80211]
[  359.777740]  ? del_timer_sync+0x67/0xb0
[  359.777796]  ieee80211_restart_work+0xb7/0xe0 [mac80211]
[  359.777804]  process_one_work+0x1b6/0x350
[  359.777811]  worker_thread+0x53/0x3e0
[  359.777817]  ? process_one_work+0x350/0x350
[  359.777823]  kthread+0x11b/0x140
[  359.777828]  ? __kthread_bind_mask+0x60/0x60
[  359.777834]  ret_from_fork+0x22/0x30
[  359.777840] ---[ end trace c773019c9e5684e5 ]---
[  377.015189] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  377.312589] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  380.683222] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  380.980982] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  388.216302] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  388.512591] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  388.636310] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  388.936615] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  421.776665] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  422.077038] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  422.205835] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  422.505043] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  442.702927] wlp2s0: authenticate with c6:27:28:**:**:**
[  442.705593] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  443.945783] wlp2s0: send auth to c6:27:28:**:**:** (try 2/3)
[  444.916208] wlp2s0: send auth to c6:27:28:**:**:** (try 3/3)
[  445.940265] wlp2s0: authentication with c6:27:28:**:**:** timed out
[  449.249823] wlp2s0: authenticate with c6:27:28:**:**:**
[  449.251524] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  449.940263] wlp2s0: send auth to c6:27:28:**:**:** (try 2/3)
[  450.900264] wlp2s0: send auth to c6:27:28:**:**:** (try 3/3)
[  451.892252] wlp2s0: authentication with c6:27:28:**:**:** timed out
[  455.595963] wlp2s0: authenticate with c6:27:28:**:**:**
[  455.597892] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  456.916258] wlp2s0: send auth to c6:27:28:**:**:** (try 2/3)
[  457.908290] wlp2s0: send auth to c6:27:28:**:**:** (try 3/3)
[  458.932249] wlp2s0: authentication with c6:27:28:**:**:** timed out
[  463.182384] wlp2s0: authenticate with c6:27:28:**:**:**
[  463.184379] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  463.892262] wlp2s0: send auth to c6:27:28:**:**:** (try 2/3)
[  464.884237] wlp2s0: send auth to c6:27:28:**:**:** (try 3/3)
[  465.004645] wlp2s0: aborting authentication with c6:27:28:**:**:**
by local choice (Reason: 3=DEAUTH_LEAVING)
[  465.034571] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  465.332723] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  468.745246] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  469.045473] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  472.399646] wlp2s0: authenticate with c6:27:28:**:**:**
[  472.402198] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  472.920255] wlp2s0: send auth to c6:27:28:**:**:** (try 2/3)
[  473.876251] wlp2s0: send auth to c6:27:28:**:**:** (try 3/3)
[  474.932247] wlp2s0: authentication with c6:27:28:**:**:** timed out
[  484.151567] wlp2s0: authenticate with c6:27:28:**:**:**
[  484.153420] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  484.884199] wlp2s0: send auth to c6:27:28:**:**:** (try 2/3)
[  485.930424] wlp2s0: send auth to c6:27:28:**:**:** (try 3/3)
[  486.932242] wlp2s0: authentication with c6:27:28:**:**:** timed out

Here is what iw recorded:
1669322331.272129: wlp2s0 (phy #0): scan started
1669322334.460704: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322334.951763: wlp2s0 (phy #0): scan started
1669322338.149331: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322343.154556: wlp2s0 (phy #0): scan started
1669322346.459222: wlp2s0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322351.920799: wlp2s0 (phy #0): scan started
1669322355.043580: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322355.552643: wlp2s0 (phy #0): scan started
1669322358.834408: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322374.848589: wlp2s0 (phy #0): scan started
1669322377.983805: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+3" ""
1669322382.988829: wlp2s0 (phy #0): scan started
1669322386.175943: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+3" ""
1669322391.178441: wlp2s0 (phy #0): scan started
1669322394.367960: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+3" ""
1669322399.374361: wlp2s0 (phy #0): scan started
1669322399.886750: wlp2s0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+3" ""
1669322400.333062: wlp2s0 (phy #0): scan started
1669322403.479718: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322403.968837: wlp2s0 (phy #0): scan started
1669322407.168194: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322412.173228: wlp2s0 (phy #0): scan started
1669322415.360459: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322420.364103: wlp2s0 (phy #0): scan started
1669322423.552560: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322428.320295: wlp2s0 (phy #0): scan started
1669322431.456557: wlp2s0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322432.341177: wlp2s0 (phy #0): scan started
1669322435.533491: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322440.536238: wlp2s0 (phy #0): scan started
1669322443.741077: wlp2s0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322444.625085: wlp2s0 (phy #0): scan started
1669322447.835035: wlp2s0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322448.272822: wlp2s0 (phy #0): scan started
1669322451.403768: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""


Started later on:
1669322454.783015: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322454.996122: wlp2s0 (phy #0): scan started
1669322458.162313: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322459.596838: wlp2s0 (phy #0): scan started
1669322462.770408: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322464.206923: wlp2s0 (phy #0): scan started
1669322467.378373: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322467.587393: wlp2s0 (phy #0): scan started
1669322470.588750: wlp2s0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322476.744768: wlp2s0 (phy #0): scan started
1669322479.871414: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322543.011673: wlp2s0 (phy #0): scan started
1669322546.229764: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+3" ""
1669322551.233549: wlp2s0 (phy #0): scan started
1669322554.422053: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+3" ""
1669322559.428485: wlp2s0 (phy #0): scan started
1669322562.614030: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+3" ""
1669322567.620427: wlp2s0 (phy #0): scan started
1669322570.880714: wlp2s0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AIR-2+3" ""
1669322594.073962: wlp2s0 (phy #0): scan started
1669322597.223845: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322597.735979: wlp2s0 (phy #0): scan started
1669322600.912274: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+3" ""
1669322605.648765: wlp2s0 (phy #0): scan started
1669322608.897565: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322615.535642: wlp2s0 (phy #0): scan started
1669322618.730136: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322623.732224: wlp2s0 (phy #0): scan started
1669322626.927439: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322631.930785: wlp2s0 (phy #0): scan started
1669322635.114445: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-5+3" ""
1669322656.030495: wlp2s0 (phy #0): scan started
1669322659.281356: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+23" ""
1669322659.297013: wlp2s0: new station c6:27:28:**:**:**
1669322662.559712: wlp2s0: del station c6:27:28:**:**:**
1669322662.561646: wlp2s0 (phy #0): auth: timed out
1669322662.663351: wlp2s0 (phy #0): scan started
1669322665.835223: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+23" ""
1669322665.842944: wlp2s0: new station c6:27:28:**:**:**
1669322668.499733: wlp2s0: del station c6:27:28:**:**:**
1669322668.501630: wlp2s0 (phy #0): auth: timed out
1669322669.003493: wlp2s0 (phy #0): scan started
1669322672.184044: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+23" ""
1669322672.189286: wlp2s0: new station c6:27:28:**:**:**
1669322675.539741: wlp2s0: del station c6:27:28:**:**:**
1669322675.541628: wlp2s0 (phy #0): auth: timed out
1669322676.544172: wlp2s0 (phy #0): scan started
1669322679.761919: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+23" ""
1669322679.775614: wlp2s0: new station c6:27:28:**:**:**
1669322681.596258: wlp2s0: del station c6:27:28:**:**:**
1669322681.598231: wlp2s0 (phy #0): deauth 60:67:20:a5:fa:80 ->
c6:27:28:**:**:** reason 3: Deauthenticated because sending station is
leaving (or has left) the IBSS or ESS
1669322682.046570: wlp2s0 (phy #0): scan started
1669322685.289356: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, ""
1669322685.786061: wlp2s0 (phy #0): scan started
1669322688.978031: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+23" ""
1669322688.993605: wlp2s0: new station c6:27:28:**:**:**
^[[A1669322691.543733: wlp2s0: del station c6:27:28:**:**:**
1669322691.545635: wlp2s0 (phy #0): auth: timed out
1669322696.552111: wlp2s0 (phy #0): scan started
1669322699.730232: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700
5745 5765 5785 5805 5825, "AI-2+23" ""
1669322700.744827: wlp2s0: new station c6:27:28:**:**:**
1669322703.539729: wlp2s0: del station c6:27:28:**:**:**
1669322703.541638: wlp2s0 (phy #0): auth: timed out


Then I rebooted but was not able to connect at the combo WPA2,3 2,4
GHz SSID so something is broken:
[  115.674732] wlp2s0: authenticate with c6:27:28:**:**:**
[  115.677393] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  115.820131] wlp2s0: authenticate with c6:27:28:**:**:**
[  115.820143] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  115.936630] wlp2s0: authenticated
[  119.258077] wlp2s0: authenticate with c6:27:28:**:**:**
[  119.258090] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  119.400184] wlp2s0: authenticate with c6:27:28:**:**:**
[  119.400195] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  119.516707] wlp2s0: authenticated
[  123.251203] wlp2s0: authenticate with c6:27:28:**:**:**
[  123.251215] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  123.398251] wlp2s0: authenticate with c6:27:28:**:**:**
[  123.398263] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  123.516859] wlp2s0: authenticated
[  127.756935] wlp2s0: authenticate with c6:27:28:**:**:**
[  127.756952] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  127.900340] wlp2s0: authenticate with c6:27:28:**:**:**
[  127.900353] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  128.016617] wlp2s0: authenticated
[  138.033465] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  138.332437] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  141.616233] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  141.916495] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  145.166642] wlp2s0: authenticate with c6:27:28:**:**:**
[  145.168466] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  145.317628] wlp2s0: authenticate with c6:27:28:**:**:**
[  145.317642] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  145.426413] wlp2s0: authenticated
[  158.585692] wlp2s0: authenticate with c6:27:28:**:**:**
[  158.587506] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  158.731140] wlp2s0: authenticate with c6:27:28:**:**:**
[  158.731152] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  158.836980] wlp2s0: authenticated
[  167.032299] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  167.334619] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  170.594218] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  170.891982] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  174.240122] wlp2s0: authenticate with c6:27:28:**:**:**
[  174.242127] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  174.388445] wlp2s0: authenticate with c6:27:28:**:**:**
[  174.388462] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  174.494075] wlp2s0: authenticated
[  187.662796] wlp2s0: authenticate with c6:27:28:**:**:**
[  187.664720] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  187.811860] wlp2s0: authenticate with c6:27:28:**:**:**
[  187.811873] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  187.921997] wlp2s0: authenticated
[  196.032507] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  196.332160] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  199.783770] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  200.084903] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  200.752791] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  201.056256] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  212.822622] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  213.120314] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  233.744502] wlp2s0: authenticate with c6:27:28:**:**:**
[  233.746328] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  233.892983] wlp2s0: authenticate with c6:27:28:**:**:**
[  233.892995] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  233.996272] wlp2s0: authenticated
[  233.999705] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  234.007257] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  234.007271] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  247.250300] wlp2s0: authenticate with c6:27:28:**:**:**
[  247.251962] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  247.254882] wlp2s0: authenticated
[  247.256050] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  247.261389] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  247.261402] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  247.297560] wlp2s0: authenticate with c6:27:28:**:**:**
[  247.299373] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  247.443255] wlp2s0: authenticate with c6:27:28:**:**:**
[  247.443267] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  247.561184] wlp2s0: authenticated
[  247.563682] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  247.568506] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  247.568520] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  256.329385] r8169 0000:05:00.0 enp5s0: Link is Down
[  259.252419] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  259.552071] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  312.859824] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full -
flow control rx/tx
[  369.290608] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  369.588003] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  436.458634] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  436.756940] iwlwifi 0000:02:00.0: Radio type=0x1-0x2-0x0
[  452.930831] wlp2s0: authenticate with c6:27:28:**:**:**
[  452.932668] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  453.072105] wlp2s0: authenticate with c6:27:28:**:**:**
[  453.072118] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  453.177459] wlp2s0: authenticated
[  453.179640] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  453.184284] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  453.184291] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  456.503790] wlp2s0: authenticate with c6:27:28:**:**:**
[  456.505486] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  456.508178] wlp2s0: authenticated
[  456.511705] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  456.516377] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  456.516383] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  456.564943] wlp2s0: authenticate with c6:27:28:**:**:**
[  456.566713] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  456.712124] wlp2s0: authenticate with c6:27:28:**:**:**
[  456.712136] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  456.819126] wlp2s0: authenticated
[  456.823666] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  456.857340] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  456.857358] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  460.552939] wlp2s0: authenticate with c6:27:28:**:**:**
[  460.554963] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  460.557440] wlp2s0: authenticated
[  460.563632] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  460.569013] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  460.569027] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  460.599837] wlp2s0: authenticate with c6:27:28:**:**:**
[  460.601536] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  460.742195] wlp2s0: authenticate with c6:27:28:**:**:**
[  460.742208] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  460.845930] wlp2s0: authenticated
[  460.847683] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  460.852317] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  460.852329] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  465.105353] wlp2s0: authenticate with c6:27:28:**:**:**
[  465.107182] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  465.109613] wlp2s0: authenticated
[  465.111650] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  465.116412] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  465.116426] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  465.161417] wlp2s0: authenticate with c6:27:28:**:**:**
[  465.163258] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  465.302404] wlp2s0: authenticate with c6:27:28:**:**:**
[  465.302416] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  465.412375] wlp2s0: authenticated
[  465.415707] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  465.420504] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  465.420517] wlp2s0: c6:27:28:**:**:** denied association (code=31)

Here is the device:
02:00.0 Network controller [0280]: Intel Corporation Centrino
Advanced-N 6205 [Taylor Peak] [8086:0082] (rev 34)
    Subsystem: Intel Corporation Centrino Advanced-N 6205 AGN [8086:1301]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 4 bytes
    Interrupt: pin A routed to IRQ 39
    NUMA node: 0
    Region 0: Memory at fddfe000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee08004  Data: 4024
    Capabilities: [e0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 0.000W
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
        AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
            MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
        HeaderLog: 00000000 00000000 00000000 00000000
    Capabilities: [140 v1] Device Serial Number 60-67-20-ff-**-**-**-**
    Kernel driver in use: iwlwifi
    Kernel modules: iwlwifi
00: 86 80 82 00 06 04 10 00 34 00 80 02 01 00 00 00
10: 04 e0 df fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 01 13
30: 00 00 00 00 c8 00 00 00 00 00 00 00 05 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 23 c8 00 00 00 0d
d0: 05 e0 81 00 04 80 e0 fe 00 00 00 00 24 40 00 00
e0: 10 00 01 00 c0 8e 00 10 10 08 19 00 11 ec 06 01
f0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
100: 01 00 01 14 00 00 00 00 00 00 00 00 11 20 06 00
110: 00 20 00 00 00 20 00 00 00 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
