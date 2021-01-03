Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39D12E8979
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 01:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbhACATh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jan 2021 19:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbhACATg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jan 2021 19:19:36 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF9C061573
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jan 2021 16:18:56 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id s2so12644803vsk.2
        for <linux-wireless@vger.kernel.org>; Sat, 02 Jan 2021 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iv86gO3rBkYocf1UltOAAMVSLuKOs3JdUyWZGZY5TxU=;
        b=B0LdnfNh6eR69i2wigMeJr/R31T3ShGSALRB6Rj1opOKxWQSsnCAnkRRpoB5ZbpI7j
         N434mu+s7ynbX4iL7kB1qxdy7eb4vciN3916oDJNAIDQBP9eljR0bo1qxr0SzRnWH/ik
         1uUQx2Vaa6LFmRbg7IdZdVZuRXzAxfcxbuNAf00VOSVlexoFruRnKJHAyvzxRcpMH5aP
         7kiuWuamnY77HF3CyhWYhw2uguG2WIduyHpVhQ4E27Pejs2Nl+FUVVjS2C59DVSFfzza
         crWQrBaMGduTfHtOeLHzTqmBOBOcfLh3GAkumifb/APZX+0QfeQiWiUvi6PC+P/vzbla
         Lplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iv86gO3rBkYocf1UltOAAMVSLuKOs3JdUyWZGZY5TxU=;
        b=MX6EJvBvBu89wARjDwXmp6TyPV60pLXza/kFEcDoRdyt9fo/XFCnBrLkQgrTZuUyHL
         stABxJiP4pt+/bBn8T6tJF/gddemU4Kn62Bknslk/cYEXePURwL01x7mNqtZJkS7hxrZ
         ha2dlLm47M1PNBqiJnbIhmLrwakkbMeGlMFXbJVil2f2uduy//fFQd0rOxdDqsBUy24D
         u7CPqvHEUqxXL3Fz/wJ/WsVl0AB9FO3NzngNXywvaFKmVQAMr3MkB+D/QtWsP58Ph9t5
         9+OJP/zq7GQA+YOzwmoRf8+d2o5en/138xdGwqx+gF5LdTkq45AjETM/GqLLjGec7eJl
         951w==
X-Gm-Message-State: AOAM5324jG8hSdn+VopsNEsIBhEFDz0tjVr3Vgswp9aDjPsHyxibEiyr
        Nw9SZcwwiNwyNnwWH90LLaVfwU0qO+FL73R7ySI=
X-Google-Smtp-Source: ABdhPJwZp7Z5rQITkz2hkOrodca/xcVR88C3zr6/XJxs3NE2CqLofXTj5sEnYDEPoYvznjW4lU297tFMAIN99Ij74hg=
X-Received: by 2002:a67:32c5:: with SMTP id y188mr38867890vsy.4.1609633135299;
 Sat, 02 Jan 2021 16:18:55 -0800 (PST)
MIME-Version: 1.0
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
 <CA+icZUWcuka-6j139+89pSV5Z-r1fYVriz+wJE0gma4RO_PL9Q@mail.gmail.com>
In-Reply-To: <CA+icZUWcuka-6j139+89pSV5Z-r1fYVriz+wJE0gma4RO_PL9Q@mail.gmail.com>
From:   Luca Versari <veluca93@gmail.com>
Date:   Sun, 3 Jan 2021 01:18:29 +0100
Message-ID: <CAM+r-Rj3y6DGonMPQ_V7qCwWH7v1bgh5x7YmAzMh5-cY68jJiw@mail.gmail.com>
Subject: Re: [BUG] Stacktrace in ath11k_pci
To:     sedat.dilek@gmail.com
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for the quick reply!
Unfortunately, this didn't seem to work - I'm still getting the same
stack trace:

[   23.136891] WARNING: CPU: 7 PID: 534 at
drivers/net/wireless/ath/ath11k/mac.c:5301
ath11k_mac_op_unassign_vif_chanctx+0x1d8/0x2e0 [ath11k]
[   23.136893] Modules linked in: michael_mic snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic qrtr_mhi snd_sof_pci
snd_sof_intel_byt snd_sof_intel_ipc snd_sof_intel_hda_common
snd_soc_hdac_hda snd_sof_xtensa_dsp snd_sof_intel_hda snd_sof
hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer
snd_soc_skl kfifo_buf hid_sensor_iio_common snd_soc_sst_ipc 88x2bu(OE)
industrialio snd_soc_sst_dsp snd_hda_ext_core x86_pkg_temp_thermal
intel_powerclamp qrtr snd_soc_acpi_intel_match ns hid_sensor_hub
snd_soc_acpi ath11k_pci coretemp cros_ec_ishtp joydev cros_ec mousedev
intel_ishtp_loader snd_hda_intel mhi intel_ishtp_hid kvm_intel
snd_intel_dspcfg soundwire_intel soundwire_generic_allocation
nvidia_drm(POE) hid_multitouch soundwire_cadence iTCO_wdt dell_laptop
intel_pmc_bxt 8250_dw nvidia_modeset(POE) ee1004 iTCO_vendor_support
mei_hdcp intel_rapl_msr kvm nls_iso8859_1 ath11k snd_hda_codec
ledtrig_audio dell_wmi dell_smbios snd_hda_core snd_hwdep qmi_helpers
dell_wmi_descriptor
[   23.136989]  irqbypass soundwire_bus wmi_bmof dcdbas
crct10dif_pclmul intel_wmi_thunderbolt crc32_pclmul vfat mac80211
ghash_clmulni_intel hci_uart aesni_intel nvidia(POE) dell_smm_hwmon
i915 fat snd_soc_core crypto_simd btqca cryptd btrtl snd_compress
glue_helper btbcm ac97_bus rapl btintel i2c_algo_bit intel_cstate
snd_pcm_dmaengine cfg80211 intel_uncore bluetooth pcspkr snd_pcm
drm_kms_helper thunderbolt i2c_i801 tpm_crb i2c_smbus snd_timer
libarc4 snd mei_me cec mei soundcore intel_lpss_pci intel_gtt
intel_lpss tpm_tis intel_ish_ipc syscopyarea processor_thermal_device
idma64 tpm_tis_core ucsi_acpi sysfillrect intel_rapl_common typec_ucsi
tpm intel_ishtp sysimgblt fb_sys_fops intel_soc_dts_iosf
intel_pch_thermal typec ecdh_generic rng_core rfkill wmi mac_hid ecc
i2c_hid int3403_thermal int340x_thermal_zone video intel_hid
int3400_thermal acpi_thermal_rel sparse_keymap acpi_tad acpi_pad drm
sg fuse crypto_user agpgart bpf_preload ip_tables x_tables ext4
crc32c_generic crc16 mbcache jbd2
[   23.137125]  rtsx_pci_sdmmc mmc_core crc32c_intel serio_raw
rtsx_pci xhci_pci xhci_pci_renesas
[   23.137141] CPU: 7 PID: 534 Comm: wpa_supplicant Tainted: P
  OE     5.10.4-arch2-1 #1
[   23.137143] Hardware name: Dell Inc. XPS 15 9500/0XWT2F, BIOS 1.4.0
08/14/2020
[   23.137159] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1d8/0x2e0 [ath11k]
[   23.137164] Code: 8b 85 e0 02 00 00 4c 89 e9 be 10 00 00 00 4c 89
e7 48 c7 c2 c0 d2 e5 c2 e8 a5 52 01 00 80 bd 98 03 00 00 00 0f 85 71
fe ff ff <0f> 0b e9 6a fe ff ff f0 80 a3 d8 16 00 00 fe f6 05 c2 34 05
00 10
[   23.137167] RSP: 0018:ffffb14780f3b808 EFLAGS: 00010246
[   23.137171] RAX: 0000000000000000 RBX: ffff952fc4bfc480 RCX: 0000000000000000
[   23.137173] RDX: ffff952fc4de9f80 RSI: ffff952fc60bd548 RDI: ffff952fd72fb5f8
[   23.137175] RBP: ffff952fc60bd548 R08: ffff952fc60bc940 R09: ffffb14780f3b648
[   23.137177] R10: ffffb14780f3b640 R11: ffffffff948cb1e8 R12: ffff952fd8900000
[   23.137179] R13: ffff952fc4bfc4d8 R14: ffff952fd72f9ee0 R15: ffff952fd72fb5f8
[   23.137183] FS:  00007f633f0fccc0(0000) GS:ffff953f1b7c0000(0000)
knlGS:0000000000000000
[   23.137186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.137188] CR2: 00007f0d803b6000 CR3: 000000011ac62001 CR4: 00000000007706e0
[   23.137190] PKRU: 55555554
[   23.137192] Call Trace:
[   23.137259]  ieee80211_assign_vif_chanctx+0x81/0x440 [mac80211]
[   23.137309]  __ieee80211_vif_release_channel+0x4f/0x130 [mac80211]
[   23.137355]  ieee80211_vif_release_channel+0x3a/0x50 [mac80211]
[   23.137411]  ieee80211_mgd_auth.cold+0x10a/0x160 [mac80211]
[   23.137467]  cfg80211_mlme_auth+0x127/0x240 [cfg80211]
[   23.137505]  nl80211_authenticate+0x2ac/0x300 [cfg80211]
[   23.137518]  genl_family_rcv_msg_doit+0xfd/0x160
[   23.137525]  genl_rcv_msg+0xef/0x1e0
[   23.137561]  ? nl80211_parse_key+0x310/0x310 [cfg80211]
[   23.137566]  ? genl_get_cmd+0xd0/0xd0
[   23.137570]  netlink_rcv_skb+0x5b/0x100
[   23.137575]  genl_rcv+0x24/0x40
[   23.137578]  netlink_unicast+0x242/0x340
[   23.137583]  netlink_sendmsg+0x243/0x480
[   23.137589]  sock_sendmsg+0x5e/0x60
[   23.137594]  ____sys_sendmsg+0x25a/0x2a0
[   23.137598]  ? copy_msghdr_from_user+0x6e/0xa0
[   23.137604]  ___sys_sendmsg+0x97/0xe0
[   23.137614]  __sys_sendmsg+0x81/0xd0
[   23.137622]  do_syscall_64+0x33/0x40
[   23.137627]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   23.137631] RIP: 0033:0x7f633f54b7e7
[   23.137637] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74
24 10
[   23.137640] RSP: 002b:00007ffe8dcb2f48 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[   23.137644] RAX: ffffffffffffffda RBX: 000055e801b10780 RCX: 00007f633f54b7e7
[   23.137646] RDX: 0000000000000000 RSI: 00007ffe8dcb2f80 RDI: 0000000000000006
[   23.137648] RBP: 000055e801b10690 R08: 0000000000000004 R09: 00007f633f60ca60
[   23.137650] R10: 00007ffe8dcb3054 R11: 0000000000000246 R12: 000055e801b49130
[   23.137653] R13: 00007ffe8dcb2f80 R14: 00007ffe8dcb3054 R15: 000055e801b50a90

On Sun, 3 Jan 2021 at 00:48, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Jan 3, 2021 at 12:27 AM Luca Versari <veluca93@gmail.com> wrote:
> >
> > Hi all,
> > I recently updated to kernel 5.10.3, which has the module for my WiFi
> > card (QCA6390 - Hardware name: Dell Inc. XPS 15 9500/0XWT2F, BIOS
> > 1.4.0 08/14/2020).
>
> I have no ath11k hardware but looking at the commit logs:
>
> $ git log --oneline v5.10.3..v5.10.4 | grep 'ath11k:'
> 6003ff9ca725 ath11k: Fix incorrect tlvs in scan start command
> 01c0691ead1e ath11k: Fix an error handling path
> 08c7e5615496 ath11k: Reset ath11k_skb_cb before setting new flags
> 345511c3f496 ath11k: Don't cast ath11k_skb_cb to ieee80211_tx_info.control
> 7688ca1121ba ath11k: Fix the rx_filter flag setting for peer rssi stats
> 00f7592609c9 ath11k: Handle errors if peer creation fails
> 8a8fe3e58c3e ath11k: fix wmi init configuration
> e3f640e6a085 ath11k: Fix number of rules in filtered ETSI regdomain
> ce79baf7b3eb ath11k: Initialize complete alpha2 for regulatory change
>
> Upgrade to Linux v5.10.4 and check again?
>
> - Sedat -
