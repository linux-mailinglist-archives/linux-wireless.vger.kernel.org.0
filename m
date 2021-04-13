Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF535E864
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbhDMVja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 17:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346291AbhDMVjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 17:39:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5B5C061574
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 14:39:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so8898632wro.13
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pCtYDJ5/Vnxm2TkVG51PBSFJSYQygxAVNtfSdkAAEAU=;
        b=uCqCkqO9SBudsnWyJb8AEX2KIfinWrX2T/h4zHxIMQZwh1105+Aj4sVqgkhsM2kPRF
         OrjgeJDTaxtHAdP/gQzL8hUx6cudTFp2izdq8yy2tSSeYp8LRyv8Wz5t6rCe/tqH0dCd
         M3Wrf2AkeumE9DSNbRwn43j83+9IZB0V9r849JLua4nZxZxOf210iFNsRxeUQ81z+Q5e
         G3AlmAee5pOTz6piKN3a1+1R4KFhoV+g96ZaDoKU0O9RR6eFi+CJZTuiHIkG/ctG5JFM
         A1dBT3sWbR1BYHZaUCtzx9X3bZdoLTIe8qwK0i2EvsrMJWTZGNuHTVZYD1syeueCb8rb
         d/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pCtYDJ5/Vnxm2TkVG51PBSFJSYQygxAVNtfSdkAAEAU=;
        b=nhLu2JivTfYt6DOdE1dXI0r9BvivFTZY0vYA4IktEUxFDv+Mk3X9Cz2lIEFaGt8HK7
         Tb6Dn60EtQfwphqBnbKAr9nbYRtmhNVhCp7viMVvQD65Niis2n09LpjzSAQwMQIvjNgY
         pR+poTfwEYVJWGH/tVoqjqBxaZvfRTJ2H38qZuIZTxrIuT+TWpnzTClEEEXbHHQXSECN
         m9ito6nhv7g2UVw2YBq9K0aMGmz3AUEFfEs5N8yY76ZOIEjAsW4E+HWKW7ifylaPUYFd
         y/r2sT3Nqh/2/pcqnnC+gXhQIdwC5C8pwXB0ZaEG74qDzJ3U3WojncCgg1GvwZoPLs96
         cLYg==
X-Gm-Message-State: AOAM530OcDW/LHxTSOIlIYEeHC6+/IQmJD90+qEffbLW7jpg4cW3tUXC
        TfmBiLcaPEdCp4GjKZ68/LQLZxSVsu3NWaMvO5BMmg==
X-Google-Smtp-Source: ABdhPJzLiJzws9fQyZNqpEqi0NWS08WzWkPju/ZVdUf9+/gs562N2c0Tm/CtZFA5UcyRq+RnTkw0cs0wkxqaclsCLyQ=
X-Received: by 2002:adf:f506:: with SMTP id q6mr13864452wro.65.1618349943137;
 Tue, 13 Apr 2021 14:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <9fafe866-6ff6-d1c4-0a04-493d863bc9db@redhat.com>
In-Reply-To: <9fafe866-6ff6-d1c4-0a04-493d863bc9db@redhat.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 13 Apr 2021 15:38:47 -0600
Message-ID: <CAJCQCtRFqmioneenXeNEoBXnjGCrOeU-SthZKT60bQoMD84K2w@mail.gmail.com>
Subject: Re: iwlwifi Lockdep warning with 5.12-rc4 on 8086:02f0 (Comet Lake
 PCH-LP CNVi WiFi)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 13, 2021 at 2:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> I'm seeing the following lockdep warning with 5.12-rc4 on 8086:02f0 (Come=
t Lake PCH-LP CNVi WiFi):
>
> [   29.923811] Bluetooth: hci0: Waiting for firmware download to complete
> [   29.925068] Bluetooth: hci0: Firmware loaded in 1912613 usecs
> [   29.925326] Bluetooth: hci0: Waiting for device to boot
> [   29.940698] Bluetooth: hci0: Device booted in 15258 usecs
> [   29.943517] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-=
0-4.ddc
> [   29.945681] Bluetooth: hci0: Applying Intel DDC parameters completed
> [   29.948684] Bluetooth: hci0: Firmware revision 0.0 build 121 week 7 20=
21
> [   30.008640] Bluetooth: hci0: MSFT filter_enable is already on
> [   30.087338] ------------[ cut here ]------------
> [   30.087356] WARNING: CPU: 5 PID: 1481 at kernel/softirq.c:178 __local_=
bh_enable_ip+0x97/0xd0
> [   30.087360] Modules linked in: cmac bnep snd_ctl_led snd_soc_skl_hda_d=
sp(E) snd_soc_hdac_hdmi(E) snd_soc_dmic(E) snd_hda_codec_hdmi snd_hda_codec=
_realtek snd_hda_codec_generic snd_sof_pci_intel_cnl snd_sof_intel_hda_comm=
on vfat fat iTCO_wdt mei_wdt snd_soc_hdac_hda(E) mei_hdcp intel_pmc_bxt sou=
ndwire_intel iTCO_vendor_support soundwire_generic_allocation soundwire_cad=
ence snd_sof_intel_hda snd_sof_pci snd_sof intel_rapl_msr x86_pkg_temp_ther=
mal intel_powerclamp coretemp snd_sof_xtensa_dsp snd_soc_skl kvm_intel snd_=
soc_sst_ipc(E) snd_soc_sst_dsp(E) snd_hda_ext_core(E) snd_soc_acpi_intel_ma=
tch(E) snd_soc_acpi kvm snd_soc_core cdc_ether irqbypass usbnet snd_compres=
s rapl r8152 ac97_bus intel_cstate snd_pcm_dmaengine mii snd_hda_intel inte=
l_uncore snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec snd_usb_au=
dio snd_hda_core(E) snd_usbmidi_lib snd_hwdep iwlmvm snd_rawmidi snd_seq pc=
spkr snd_seq_device mac80211 snd_pcm wmi_bmof i2c_i801 uvcvideo intel_wmi_t=
hunderbolt e1000e i2c_smbus
> [   30.087436]  btusb snd_timer videobuf2_vmalloc btrtl thunderbolt video=
buf2_memops libarc4 btbcm btintel videobuf2_v4l2 bluetooth videobuf2_common=
 iwlwifi videodev mei_me processor_thermal_device processor_thermal_rfim ec=
dh_generic joydev mc mei processor_thermal_mbox ecc processor_thermal_rapl =
cfg80211 idma64 intel_rapl_common ucsi_acpi intel_pch_thermal intel_soc_dts=
_iosf nxp_nci_i2c typec_ucsi nxp_nci nci roles typec nfc int3403_thermal in=
t340x_thermal_zone soc_button_array intel_hid int3400_thermal acpi_thermal_=
rel sparse_keymap acpi_pad binfmt_misc zram ip_tables dm_crypt trusted hid_=
logitech_hidpp hid_logitech_dj uas usb_storage crct10dif_pclmul crc32_pclmu=
l crc32c_intel ghash_clmulni_intel i915 serio_raw nvme i2c_algo_bit nvme_co=
re drm_kms_helper cec hid_multitouch drm wmi i2c_hid_acpi i2c_hid thinkpad_=
acpi ledtrig_audio platform_profile snd soundcore rfkill drm_privacy_screen=
_helper video pinctrl_cannonlake i2c_dev fuse
> [   30.087509] CPU: 5 PID: 1481 Comm: NetworkManager Tainted: G          =
  E     5.12.0-rc4+ #272
> [   30.087511] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET24W=
 (1.14 ) 10/15/2020
> [   30.087512] RIP: 0010:__local_bh_enable_ip+0x97/0xd0
> [   30.087514] Code: f2 45 a9 00 ff ff 00 74 36 65 ff 0d 33 d7 f2 45 e8 2=
e 2c 13 00 fb 66 0f 1f 44 00 00 5b 5d c3 65 8b 05 59 df f2 45 85 c0 75 9c <=
0f> 0b eb 98 e8 50 2b 13 00 eb a7 48 89 ef e8 76 28 07 00 eb b0 65
> [   30.087516] RSP: 0018:ffffbc1240e471b0 EFLAGS: 00010046
> [   30.087518] RAX: 0000000000000000 RBX: 0000000000000201 RCX: 000000000=
0000000
> [   30.087520] RDX: 0000000000000003 RSI: 0000000000000201 RDI: ffffffffc=
0bd54db
> [   30.087521] RBP: ffffffffc0bd54db R08: 0000000000000000 R09: 000000000=
0000001
> [   30.087522] R10: ffffbc1240e470a0 R11: 0000000000000001 R12: ffff9817c=
578ac10
> [   30.087523] R13: 0000000000000000 R14: 0000000080000000 R15: 000000000=
0000000
> [   30.087525] FS:  00007f308dbbdbc0(0000) GS:ffff981b1a540000(0000) knlG=
S:0000000000000000
> [   30.087526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   30.087528] CR2: 00007f659c013038 CR3: 00000001420bc002 CR4: 000000000=
03706e0
> [   30.087529] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   30.087530] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   30.087531] Call Trace:
> [   30.087534]  iwl_pcie_gen2_enqueue_hcmd+0x56b/0x8c0 [iwlwifi]
> [   30.087551]  iwl_trans_txq_send_hcmd+0x59/0x470 [iwlwifi]
> [   30.087564]  iwl_trans_send_cmd+0x81/0x180 [iwlwifi]
> [   30.087572]  ? lock_acquire+0xe2/0x3b0
> [   30.087576]  iwl_mvm_send_cmd+0x28/0x80 [iwlmvm]
> [   30.087587]  iwl_mvm_led_set+0x9c/0xc0 [iwlmvm]
> [   30.087600]  ? _raw_read_lock_irqsave+0x7f/0xa0
> [   30.087602]  ? _raw_read_lock_irqsave+0x88/0xa0
> [   30.087605]  led_trigger_event+0x46/0x70
> [   30.087609]  ieee80211_do_open+0x4c2/0xa70 [mac80211]
> [   30.087642]  ieee80211_open+0x69/0x90 [mac80211]
> [   30.087666]  __dev_open+0xe5/0x1b0
> [   30.087670]  __dev_change_flags+0x1c8/0x240
> [   30.087676]  dev_change_flags+0x21/0x60
> [   30.087682]  do_setlink+0x2a9/0x1290
> [   30.087690]  ? __lock_acquire+0x389/0x1e10
> [   30.087707]  ? lock_is_held_type+0xa5/0x120
> [   30.087713]  __rtnl_newlink+0x66d/0xa20
> [   30.087753]  rtnl_newlink+0x44/0x70
> [   30.087756]  rtnetlink_rcv_msg+0x181/0x4b0
> [   30.087761]  ? rtnetlink_put_metrics+0x1e0/0x1e0
> [   30.087763]  netlink_rcv_skb+0x5b/0x100
> [   30.087769]  netlink_unicast+0x175/0x240
> [   30.087773]  netlink_sendmsg+0x24d/0x480
> [   30.087779]  sock_sendmsg+0x5e/0x60
> [   30.087782]  ____sys_sendmsg+0x25b/0x2a0
> [   30.087784]  ? import_iovec+0x17/0x20
> [   30.087790]  ___sys_sendmsg+0xa3/0xf0
> [   30.087804]  __sys_sendmsg+0x73/0xb0
> [   30.087811]  do_syscall_64+0x33/0x40
> [   30.087815]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   30.087817] RIP: 0033:0x7f308eca96fd
> [   30.087819] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 fa ee f=
f ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 4e ef ff ff 48
> [   30.087820] RSP: 002b:00007fff70b4af40 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000002e
> [   30.087823] RAX: ffffffffffffffda RBX: 0000000000000014 RCX: 00007f308=
eca96fd
> [   30.087824] RDX: 0000000000000000 RSI: 00007fff70b4af80 RDI: 000000000=
000000c
> [   30.087825] RBP: 0000565535afe030 R08: 0000000000000000 R09: 000000000=
0000000
> [   30.087826] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000=
0000000
> [   30.087827] R13: 00007fff70b4b0e0 R14: 00007fff70b4b0dc R15: 000000000=
0000000
> [   30.087835] irq event stamp: 242153
> [   30.087836] hardirqs last  enabled at (242151): [<ffffffffba0ea692>] _=
_local_bh_enable_ip+0x82/0xd0
> [   30.087838] hardirqs last disabled at (242152): [<ffffffffbad3f794>] _=
raw_read_lock_irqsave+0x94/0xa0
> [   30.087840] softirqs last  enabled at (242150): [<ffffffffc0bd54db>] i=
wl_pcie_gen2_enqueue_hcmd+0x56b/0x8c0 [iwlwifi]
> [   30.087850] softirqs last disabled at (242153): [<ffffffffc0bd505b>] i=
wl_pcie_gen2_enqueue_hcmd+0xeb/0x8c0 [iwlwifi]
> [   30.087857] ---[ end trace aa0b171b4415a1fe ]---
>


Looks like this:
https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2103021125430.12405@=
cbobk.fhfr.pm/

I tested that patch on rc6 and it worked so far.

--=20
Chris Murphy
