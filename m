Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6956C7D0982
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 09:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376408AbjJTH0x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 03:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376409AbjJTH0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 03:26:51 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC03DD5D
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 00:26:47 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-457cba20cb7so203145137.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697786807; x=1698391607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaOCq5OvBXdVqsUysFyyr6fDVfN6HY9o3v4K1lSZIxM=;
        b=fbTtHs92hP4+DBNeOnv4Ub9Nzi2od4jJgG/77r5jLEMjp709XcX4Z7XW09JsfFuXFH
         bFjHtYWi/JqhEFqznq5zKu2/vAiY/D2dyVXZpf57N1J3/BbPowbBigqbmr+XtJzO4Xfp
         QLzP5jIGqTl8DJxowT379MeNG5ltS6o7rNe0+ZqNGd0Pw0L3U5kSfLkdR2A7JynlOK2u
         IAAZF4ogtsk2QRUGdPIuGZ6rv+rnIMZ8ZRFC282biHUVGDlhH/jJnu0L+h4eTfdMgyko
         5u5QFRVUlpshDsrKNZBrlqIXya76iG0uTXQMlpxva9LNhAENmjqt8ILjRATFxA7uYtxm
         ey+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786807; x=1698391607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaOCq5OvBXdVqsUysFyyr6fDVfN6HY9o3v4K1lSZIxM=;
        b=tBuZ3xVIT+U2EiOwy/hrAjR6GUhgBQTMUG5keKiZbZMn1+IAK9Z6ekAWxyIcD3zTci
         sXOvPqxZVNLsf5B8fvEffIfW0x+T78P+5QJjtBGHYuk/4WE7eFwTtzdd4O7ohx/+uTiv
         iwwRCUmC0rMCcfixKEgZAqX3/87ymWhd/fAUNoYk6frnQT6KzoPtmDfEV/BAVHBmM2my
         w7TTYsEmUXLrmbYbWSLBjqbo8G3jQg6VplHVbxa2TDauT4hlWE++MEhnPFVmTrBdCl0h
         esYRbFoLGS5ztz7Mk8sXn0da+5uU3tm1ltNoqmrb98i5554wP1li8DwFwOlOe71ws1hN
         QRAw==
X-Gm-Message-State: AOJu0Yy7lvFCMQkJDNC8tJHHVMo7LiJVQYBIllw6q9lCzlHFsaIFgQd6
        1sld3w3JW1SZCR94kgPF60cp7pokgMp8X3qiyZxo20vGdaw=
X-Google-Smtp-Source: AGHT+IH800CXeoS570iPmahfMax3yLks61LiLC1tUpRZTfvfrV0gn26abzEQCVhAC/uibBecdn/rMkNw5ZNHSvUFPQ8=
X-Received: by 2002:a05:6102:1051:b0:44e:d6c3:51d4 with SMTP id
 h17-20020a056102105100b0044ed6c351d4mr1188977vsq.18.1697786806523; Fri, 20
 Oct 2023 00:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZtnDFDjMDA-yt8vWTvbcBeiXV7oRP5ntWM3P_QZu3DGyw@mail.gmail.com>
 <9c401bce61608a33fa01cd15a5365bc26adb51fb.camel@intel.com>
In-Reply-To: <9c401bce61608a33fa01cd15a5365bc26adb51fb.camel@intel.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri, 20 Oct 2023 09:26:35 +0200
Message-ID: <CAA85sZtxyyOKiS4A7x600VKRTXVqZ=J6ZSxLmpTNPuD4t1Ohjg@mail.gmail.com>
Subject: Re: Issues with iwlwifi on 6.5.4
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 19, 2023 at 4:52=E2=80=AFPM Greenman, Gregory
<gregory.greenman@intel.com> wrote:
>
> Hi,
>
> On Thu, 2023-10-19 at 15:31 +0200, Ian Kumlien wrote:
> > This keeps happening, unloading and reloading the driver fixes it...
> > Is it an issue with kernel and firmware being out of sync?
> >
> > [1490807.324601] ------------[ cut here ]------------
> > [1490807.324606] WARNING: CPU: 6 PID: 3954455 at
> > net/mac80211/scan.c:423 __ieee80211_scan_completed+0x345/0x370
> > [mac80211]
> > [1490807.324900] Modules linked in: r8153_ecm cdc_ether usbnet r8152
> > mii isofs iwlmvm iwlwifi snd_usb_audio snd_usbmidi_lib snd_ump ufs
> > qnx4 hfsplus hfs minix ntfs msdos jfs xfs cpuid uas usb_storage usbhid
> > rfcomm ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter ipt_REJECT
> > nf_reject_ipv4 xt_conntrack ccm ip6table_raw ip6table_security
> > iptable_mangle iptable_raw iptable_security ip6table_nat
> > ip6table_mangle xt_MASQUERADE ip_set nf_tables cmac nfnetlink
> > algif_hash algif_skcipher ip6table_filter af_alg xt_mark
> > iptable_filter ip6_tables iptable_nat nf_nat nf_conntrack
> > nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp bnep nls_iso8859_1 snd_ctl_led
> > snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_common snd_sof_probes
> > snd_soc_hdac_hdmi snd_hda_codec_hdmi snd_hda_codec_realtek
> > snd_hda_codec_generic ledtrig_audio snd_soc_dmic snd_sof_pci_intel_tgl
> > snd_sof_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink
> > soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
> > snd_sof snd_sof_utils snd_soc_hdac_hda snd_hda_ext_core
> > [1490807.325124]  snd_soc_acpi_intel_match snd_soc_acpi
> > soundwire_generic_allocation soundwire_bus snd_soc_core snd_compress
> > ac97_bus snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg
> > snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd_pcm
> > x86_pkg_temp_thermal uvcvideo snd_seq_midi intel_powerclamp
> > snd_seq_midi_event videobuf2_vmalloc btusb uvc pmt_telemetry joydev
> > btrtl kvm_intel videobuf2_memops videobuf2_v4l2 btbcm mei_pxp mei_hdcp
> > intel_rapl_msr mac80211 snd_rawmidi pmt_class btintel videodev
> > processor_thermal_device_pci_legacy kvm libarc4 hid_sensor_als
> > processor_thermal_device videobuf2_common btmtk processor_thermal_rfim
> > irqbypass snd_seq hid_sensor_trigger processor_thermal_mbox bluetooth
> > binfmt_misc rapl snd_seq_device processor_thermal_rapl hp_wmi
> > industrialio_triggered_buffer cmdlinepart intel_cstate mc input_leds
> > snd_timer platform_profile spi_nor kfifo_buf ecdh_generic ucsi_acpi
> > ee1004 typec_ucsi serio_raw wmi_bmof ecc hid_sensor_iio_common snd
> > intel_rapl_common mei_me mtd cfg80211 hid_multitouch
> > [1490807.325261]  soundcore industrialio mei igen6_edac
> > intel_soc_dts_iosf intel_vsec typec int3403_thermal
> > int340x_thermal_zone mac_hid int3400_thermal intel_hid
> > acpi_thermal_rel acpi_pad sparse_keymap wireless_hotkey sch_fq_codel
> > coretemp msr parport_pc ppdev lp parport ramoops reed_solomon
> > pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs
> > blake2b_generic xor raid6_pq libcrc32c dm_crypt hid_sensor_hub
> > intel_ishtp_hid i915 drm_buddy i2c_algo_bit ttm crct10dif_pclmul
> > hid_generic crc32_pclmul drm_display_helper polyval_clmulni
> > polyval_generic ghash_clmulni_intel mhi_wwan_ctrl cec aesni_intel
> > mhi_wwan_mbim rc_core crypto_simd drm_kms_helper nvme cryptd nvme_core
> > mhi_pci_generic i2c_i801 video mhi nvme_common spi_intel_pci
> > intel_ish_ipc drm i2c_smbus intel_lpss_pci i2c_hid_acpi thunderbolt
> > intel_lpss intel_ishtp spi_intel i2c_hid idma64 vmd xhci_pci
> > xhci_pci_renesas hid wmi pinctrl_tigerlake [last unloaded: iwlwifi]
> > [1490807.325454] CPU: 6 PID: 3954455 Comm: kworker/u16:1 Tainted: G
> >     W          6.5.4-060504-generic #202309191142
> > [1490807.325459] Hardware name: HP HP EliteBook 840 Aero G8 Notebook
> > PC/880D, BIOS T76 Ver. 01.13.01 03/30/2023
> > [1490807.325463] Workqueue: phy10 ieee80211_scan_work [mac80211]
> > [1490807.325578] RIP: 0010:__ieee80211_scan_completed+0x345/0x370 [mac8=
0211]
> > [1490807.325688] Code: 0f 00 48 85 c0 74 0c 48 8b 78 08 4c 89 e6 e8 f2
> > 2c 05 00 65 ff 0d 93 be 6f 3e 0f 85 99 fe ff ff 0f 1f 44 00 00 e9 8f
> > fe ff ff <0f> 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2
> > 31 c9
> > [1490807.325693] RSP: 0018:ffffa4866bc07da0 EFLAGS: 00010246
> > [1490807.325697] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > 0000000000000001
> > [1490807.325751] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
> > ffff8de4a0998900
> > [1490807.325754] RBP: ffffa4866bc07dd8 R08: 0000000000000000 R09:
> > 0000000000000000
> > [1490807.325757] R10: 0000000000000000 R11: 0000000000000000 R12:
> > ffff8de4a0998900
> > [1490807.325759] R13: ffff8de4a0998900 R14: 0000000000000000 R15:
> > ffff8de41418e840
> > [1490807.325762] FS:  0000000000000000(0000) GS:ffff8deb8f980000(0000)
> > knlGS:0000000000000000
> > [1490807.325766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [1490807.325769] CR2: 000056372917a7d8 CR3: 0000000798e3a004 CR4:
> > 0000000000770ee0
> > [1490807.325773] PKRU: 55555554
> > [1490807.325775] Call Trace:
> > [1490807.325778]  <TASK>
> > [1490807.325825]  ? show_regs+0x6d/0x80
> > [1490807.325836]  ? __warn+0x89/0x160
> > [1490807.325844]  ? __ieee80211_scan_completed+0x345/0x370 [mac80211]
> > [1490807.325958]  ? report_bug+0x17e/0x1b0
> > [1490807.325969]  ? handle_bug+0x51/0xa0
> > [1490807.325977]  ? exc_invalid_op+0x18/0x80
> > [1490807.325985]  ? asm_exc_invalid_op+0x1b/0x20
> > [1490807.325995]  ? __ieee80211_scan_completed+0x345/0x370 [mac80211]
> > [1490807.326130]  ieee80211_scan_work+0x16b/0x630 [mac80211]
> > [1490807.326239]  ? __schedule+0x2d4/0x770
> > [1490807.326247]  process_one_work+0x220/0x440
> > [1490807.326256]  worker_thread+0x4d/0x3f0
> > [1490807.326262]  ? _raw_spin_lock_irqsave+0xe/0x20
> > [1490807.326269]  ? __pfx_worker_thread+0x10/0x10
> > [1490807.326275]  kthread+0xef/0x120
> > [1490807.326284]  ? __pfx_kthread+0x10/0x10
> > [1490807.326292]  ret_from_fork+0x44/0x70
> > [1490807.326327]  ? __pfx_kthread+0x10/0x10
> > [1490807.326334]  ret_from_fork_asm+0x1b/0x30
> > [1490807.326344]  </TASK>
> > [1490807.326356] ---[ end trace 0000000000000000 ]---
> > [1490827.865301] usb 3-7: reset full-speed USB device number 3 using xh=
ci_hcd
> > [1490828.197078] usb 3-7: reset full-speed USB device number 3 using xh=
ci_hcd
> > [1490832.559636] kauditd_printk_skb: 119 callbacks suppressed
> > [1490832.559641] audit: type=3D1400 audit(1697721892.306:16690):
> > apparmor=3D"ALLOWED" operation=3D"open" class=3D"file"
> > profile=3D"/usr/sbin/sssd" name=3D"/run/systemd/users/124529" pid=3D398=
5015
> > comm=3D"krb5_child" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D0 ou=
id=3D0
> > [1490865.670160] audit: type=3D1400 audit(1697721925.418:16691):
> > apparmor=3D"ALLOWED" operation=3D"open" class=3D"file"
> > profile=3D"/usr/sbin/sssd" name=3D"/run/systemd/users/124529" pid=3D398=
5299
> > comm=3D"krb5_child" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D0 ou=
id=3D0
> > [1490870.299262] iwlwifi 0000:00:14.3: Microcode SW error detected.
> > Restarting 0x0.
> > [1490870.299375] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> > [1490870.299379] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, va=
lid: 6
> > [1490870.299384] iwlwifi 0000:00:14.3: Loaded firmware version:
> > 71.058653f6.0 QuZ-a0-hr-b0-71.ucode
> > [1490870.299389] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_=
FATAL
> > [1490870.299394] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
> > [1490870.299398] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
> > [1490870.299401] iwlwifi 0000:00:14.3: 0x004CBE06 | branchlink2
> > [1490870.299405] iwlwifi 0000:00:14.3: 0x0001545C | interruptlink1
> > [1490870.299408] iwlwifi 0000:00:14.3: 0x0001545C | interruptlink2
> > [1490870.299411] iwlwifi 0000:00:14.3: 0x004C3E98 | data1
> > [1490870.299415] iwlwifi 0000:00:14.3: 0x00001000 | data2
> > [1490870.299418] iwlwifi 0000:00:14.3: 0x00000000 | data3
> > [1490870.299421] iwlwifi 0000:00:14.3: 0x003D83D8 | beacon time
> > [1490870.299424] iwlwifi 0000:00:14.3: 0x03B874DC | tsf low
> > [1490870.299427] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
> > [1490870.299431] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
> > [1490870.299434] iwlwifi 0000:00:14.3: 0x03B8D1BE | time gp2
> > [1490870.299437] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
> > [1490870.299440] iwlwifi 0000:00:14.3: 0x00000047 | uCode version major
> > [1490870.299444] iwlwifi 0000:00:14.3: 0x058653F6 | uCode version minor
> > [1490870.299447] iwlwifi 0000:00:14.3: 0x00000351 | hw version
> > [1490870.299450] iwlwifi 0000:00:14.3: 0x18489001 | board version
> > [1490870.299454] iwlwifi 0000:00:14.3: 0x804DFF02 | hcmd
> > [1490870.299457] iwlwifi 0000:00:14.3: 0x00020000 | isr0
> > [1490870.299460] iwlwifi 0000:00:14.3: 0x60000000 | isr1
> > [1490870.299463] iwlwifi 0000:00:14.3: 0x18F84002 | isr2
> > [1490870.299466] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
> > [1490870.299469] iwlwifi 0000:00:14.3: 0x00000000 | isr4
> > [1490870.299472] iwlwifi 0000:00:14.3: 0x001F0103 | last cmd Id
> > [1490870.299475] iwlwifi 0000:00:14.3: 0x004C3E98 | wait_event
> > [1490870.299479] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
> > [1490870.299482] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
> > [1490870.299485] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
> > [1490870.299488] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
> > [1490870.299491] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
> > [1490870.299495] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
> > [1490870.299497] iwlwifi 0000:00:14.3: 0x00002064 | flow_handler
> > [1490870.299916] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> > [1490870.299919] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, va=
lid: 7
> > [1490870.299922] iwlwifi 0000:00:14.3: 0x20103600 | ADVANCED_SYSASSERT
> > [1490870.299926] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
> > [1490870.299930] iwlwifi 0000:00:14.3: 0x80455B7C | umac branchlink2
> > [1490870.299933] iwlwifi 0000:00:14.3: 0x010661B8 | umac interruptlink1
> > [1490870.299936] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
> > [1490870.299940] iwlwifi 0000:00:14.3: 0x000000FF | umac data1
> > [1490870.299943] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data2
> > [1490870.299946] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
> > [1490870.299949] iwlwifi 0000:00:14.3: 0x00000047 | umac major
> > [1490870.299952] iwlwifi 0000:00:14.3: 0x058653F6 | umac minor
> > [1490870.299955] iwlwifi 0000:00:14.3: 0x03B8D1B8 | frame pointer
> > [1490870.299958] iwlwifi 0000:00:14.3: 0xC0886C18 | stack pointer
> > [1490870.299962] iwlwifi 0000:00:14.3: 0x0024010D | last host cmd
> > [1490870.299965] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
> > [1490870.300072] iwlwifi 0000:00:14.3: IML/ROM dump:
> > [1490870.300075] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
> > [1490870.300184] iwlwifi 0000:00:14.3: 0x00005805 | IML/ROM data1
> > [1490870.300202] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_K=
EY_0
> > [1490870.300255] iwlwifi 0000:00:14.3: Fseq Registers:
> > [1490870.300280] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
> > [1490870.300308] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSI=
ON
> > [1490870.300336] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VER=
SION
> > [1490870.300372] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
> > [1490870.300408] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VE=
RSION
> > [1490870.300444] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
> > [1490870.300480] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
> > [1490870.300516] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
> > [1490870.300552] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
> > [1490870.300590] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
> > [1490870.300628] iwlwifi 0000:00:14.3: 0x05B0905B |
> > CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> > [1490870.300693] iwlwifi 0000:00:14.3: 0x0000025B |
> > CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> > [1490870.300739] iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_PREV_CNVIO_INI=
T_VERSION
> > [1490870.300781] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_WIFI_FSEQ_VERS=
ION
> > [1490870.300823] iwlwifi 0000:00:14.3: 0x00290033 | FSEQ_BT_FSEQ_VERSIO=
N
> > [1490870.300863] iwlwifi 0000:00:14.3: 0x000000EB | FSEQ_CLASS_TP_VERSI=
ON
> > [1490870.301372] iwlwifi 0000:00:14.3: WRT: Collecting data: ini
> > trigger 4 fired (delay=3D0ms).
> > [1490870.301384] ieee80211 phy10: Hardware restart was requested
> > [1490870.301501] iwlwifi 0000:00:14.3: FW error in SYNC CMD SCAN_REQ_UM=
AC
> > [1490870.301512] CPU: 2 PID: 900 Comm: wpa_supplicant Tainted: G
> >  W          6.5.4-060504-generic #202309191142
> > [1490870.301519] Hardware name: HP HP EliteBook 840 Aero G8 Notebook
> > PC/880D, BIOS T76 Ver. 01.13.01 03/30/2023
> > [1490870.301522] Call Trace:
> > [1490870.301526]  <TASK>
> > [1490870.301538]  dump_stack_lvl+0x48/0x70
> > [1490870.301549]  dump_stack+0x10/0x20
> > [1490870.301557]  iwl_trans_txq_send_hcmd_sync+0x1d5/0x370 [iwlwifi]
> > [1490870.301639]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [1490870.301651]  iwl_trans_txq_send_hcmd+0xb8/0x170 [iwlwifi]
> > [1490870.301723]  iwl_trans_send_cmd+0x81/0x110 [iwlwifi]
> > [1490870.301785]  iwl_mvm_send_cmd+0x38/0xa0 [iwlmvm]
> > [1490870.301880]  iwl_mvm_reg_scan_start+0x30a/0x420 [iwlmvm]
> > [1490870.301985]  iwl_mvm_mac_hw_scan+0x50/0x80 [iwlmvm]
> > [1490870.302052]  drv_hw_scan+0xbc/0x180 [mac80211]
> > [1490870.302196]  __ieee80211_start_scan+0x28e/0x6a0 [mac80211]
> > [1490870.302311]  ieee80211_request_scan+0x30/0x60 [mac80211]
> > [1490870.302422]  ieee80211_scan+0x6b/0xf0 [mac80211]
> > [1490870.302564]  rdev_scan+0x2a/0xe0 [cfg80211]
> > [1490870.302685]  cfg80211_scan+0xd8/0x140 [cfg80211]
> > [1490870.302792]  nl80211_trigger_scan+0x3f4/0xa90 [cfg80211]
> > [1490870.302917]  genl_family_rcv_msg_doit.isra.0+0xe5/0x150
> > [1490870.302938]  genl_family_rcv_msg+0x17b/0x240
> > [1490870.302943]  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211]
> > [1490870.303051]  ? __pfx_nl80211_trigger_scan+0x10/0x10 [cfg80211]
> > [1490870.303181]  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211]
> > [1490870.303297]  genl_rcv_msg+0x4c/0xb0
> > [1490870.303303]  ? __pfx_genl_rcv_msg+0x10/0x10
> > [1490870.303308]  netlink_rcv_skb+0x5a/0x110
> > [1490870.303320]  genl_rcv+0x28/0x50
> > [1490870.303327]  netlink_unicast+0x244/0x390
> > [1490870.303336]  netlink_sendmsg+0x25e/0x4e0
> > [1490870.303348]  sock_sendmsg+0xac/0xc0
> > [1490870.303361]  ____sys_sendmsg+0x2a9/0x350
> > [1490870.303374]  ___sys_sendmsg+0x9a/0xf0
> > [1490870.303391]  __sys_sendmsg+0x89/0xf0
> > [1490870.303403]  __x64_sys_sendmsg+0x1d/0x30
> > [1490870.303411]  do_syscall_64+0x59/0x90
> > [1490870.303421]  ? syscall_exit_to_user_mode+0x37/0x60
> > [1490870.303432]  ? do_syscall_64+0x68/0x90
> > [1490870.303437]  ? do_syscall_64+0x68/0x90
> > [1490870.303442]  ? do_syscall_64+0x68/0x90
> > [1490870.303447]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [1490870.303456] RIP: 0033:0x7f3cd0d2e5e7
> > [1490870.303548] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> > 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74
> > 24 10
> > [1490870.303553] RSP: 002b:00007ffcaea65a48 EFLAGS: 00000246 ORIG_RAX:
> > 000000000000002e
> > [1490870.303560] RAX: ffffffffffffffda RBX: 0000560ec73eb650 RCX:
> > 00007f3cd0d2e5e7
> > [1490870.303564] RDX: 0000000000000000 RSI: 00007ffcaea65a80 RDI:
> > 0000000000000006
> > [1490870.303567] RBP: 0000560ec73eb560 R08: 0000000000000004 R09:
> > 00007f3cd0dfab80
> > [1490870.303570] R10: 00007ffcaea65b54 R11: 0000000000000246 R12:
> > 0000560ec73e8a50
> > [1490870.303573] R13: 00007ffcaea65a80 R14: 00007ffcaea65b54 R15:
> > 0000560ec7437310
> > [1490870.303582]  </TASK>
> > [1490870.303586] iwlwifi 0000:00:14.3: Scan failed! ret -5
> > [1490870.303673] ------------[ cut here ]------------
>
> Yes, this problem was reported some time ago, it is related to a driver b=
ug
> when working with older firmware versions. We already sent a fix for that=
, so
> to solve it there're two options - either take the latest firmware from [=
1] or
> apply a driver fix from [2].

Thanks, and good to know that it's been handled already =3D)

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmwa=
re.git
> [2] https://patchwork.kernel.org/project/linux-wireless/patch/20230926165=
546.086e635fbbe6.Ia660f35ca0b1079f2c2ea92fd8d14d8101a89d03@changeid/
