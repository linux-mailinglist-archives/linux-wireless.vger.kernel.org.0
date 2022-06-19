Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626335509B6
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jun 2022 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiFSKhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Jun 2022 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiFSKhN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Jun 2022 06:37:13 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D86B101E2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 03:37:11 -0700 (PDT)
Date:   Sun, 19 Jun 2022 10:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1655635027; x=1655894227;
        bh=11ea3XH08sRKhcBE/7Lq9Po0wpgM/NSZONi8PBPo71k=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=AeYFOwiB0rXaCvbuH2xiEfr6u+XKTMhOw+rhSvQWhBq2mfM/gMr8gA2XBpjh1ux04
         8Ae6UYuRW7xSXP+pcQRxoIn3I2yDo5Fn6C33YGoz86g5BMwQQR9nuykzODYlo/lLb7
         a6SQ3ewlYYVDQWVb/yNvI3gRbauzcKIZ42Fpq4BkksjuKht2qMQSn7sXvZzylqtb5w
         3jC/KIfUKifhYpTL+z38GylcF7WHsOXn+T3H8hGwKU/5XTVG/dXoM38cGZhUXZsNxZ
         3RemjK6NlBlvRCLdYGoOdUj8axJvb7SfuHmkBCmobrddFc/A5F7JqomFK7CEkzRLRu
         KI/blFlqWkFhg==
To:     Larry Finger <Larry.Finger@lwfinger.net>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: Re: rtw88: 8821CE: WARNING firmware failed to ack driver for leaving Deep Power mode
Message-ID: <-74gmtkCiLtE2oAdkR1ehf2xVHnrLR3-zK13GrSsOOrAL4hMsDwAHE8aGSh3DV05f2c3SPhq5rGwulQ5QvGBji1bPOI31drQQ9sUld5jcXM=@protonmail.com>
In-Reply-To: <AddyIjbiK7b1NCW00ISPDaXRRPPNiv4sbHC4h1w2mtpIvNK9f2eSzwxVkVZO34j0QARuVF741IPIsTnBbJCoDKY1z__2lwG4CUR6ZEB5mLQ=@protonmail.com>
References: <V-sIKLj8AVfO-urzfoLZQZsEfGX4TSs9kBvfrw3o8ouYk0sA8zRYMpPEVFAW4lUtLdLtQtVKfvxFaOeXpaFcuAJNgxYfNRzx2t9I4F7EDmk=@protonmail.com> <1f0afd0a-86a4-f676-11c7-458d55e3ac90@lwfinger.net> <AddyIjbiK7b1NCW00ISPDaXRRPPNiv4sbHC4h1w2mtpIvNK9f2eSzwxVkVZO34j0QARuVF741IPIsTnBbJCoDKY1z__2lwG4CUR6ZEB5mLQ=@protonmail.com>
Feedback-ID: 34463299:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sunday, June 12th, 2022 at 12:21 AM, rtl8821cerfe2 <rtl8821cerfe2@proton=
mail.com> wrote:


> On Saturday, June 11th, 2022 at 7:46 PM, Larry Finger Larry.Finger@lwfing=
er.net wrote:
>
>
>
> > On 6/11/22 10:22, rtl8821cerfe2 wrote:
> >
> > > Hi!
> > >
> > > I saw this warning today:
> > >
> > > Jun 11 15:43:38 home kernel: ------------[ cut here ]------------
> > > Jun 11 15:43:38 home kernel: firmware failed to ack driver for leavin=
g Deep Power mode
> > > Jun 11 15:43:38 home kernel: WARNING: CPU: 3 PID: 66361 at drivers/ne=
t/wireless/realtek/rtw88/ps.c:104 rtw_power_mode_change+0x107/0x120 [rtw88_=
core]
> > > Jun 11 15:43:38 home kernel: Modules linked in: ccm snd_seq_dummy snd=
_hrtimer snd_seq snd_seq_device rfcomm snd_soc_skl snd_soc_hdac_hda snd_hda=
_ext_core snd_hda_codec_hdmi snd_soc_sst_ipc intel_tcc_cooling snd_soc_sst_=
dsp x86_pkg_temp_thermal snd_soc_acpi_intel_match snd_soc_acpi intel_powerc=
lamp snd_soc_core coretemp snd_compress snd_hda_codec_realtek kvm_intel ac9=
7_bus snd_hda_codec_generic ledtrig_audio snd_pcm_dmaengine kvm snd_hda_int=
el snd_intel_dspcfg irqbypass cmac snd_intel_sdw_acpi crct10dif_pclmul algi=
f_hash rtw88_8821ce iTCO_wdt crc32_pclmul hp_wmi joydev snd_hda_codec algif=
_skcipher rtw88_8821c intel_pmc_bxt af_alg ghash_clmulni_intel mousedev qrt=
r aesni_intel bnep crypto_simd ee1004 mei_hdcp cryptd iTCO_vendor_support m=
ei_pxp intel_wmi_thunderbolt intel_rapl_msr wmi_bmof platform_profile snd_h=
da_core rapl rtw88_pci rtw88_core btusb snd_hwdep intel_cstate uvcvideo snd=
_pcm btrtl intel_uncore mac80211 pcspkr snd_timer btbcm videobuf2_vmalloc p=
smouse btintel i2c_i801
> > > Jun 11 15:43:38 home kernel: processor_thermal_device_pci_legacy snd =
r8169 btmtk libarc4 i915 videobuf2_memops processor_thermal_device i2c_smbu=
s videobuf2_v4l2 processor_thermal_rfim soundcore realtek mei_me mdio_devre=
s bluetooth processor_thermal_mbox videobuf2_common cfg80211 libphy ecdh_ge=
neric mei drm_buddy processor_thermal_rapl rfkill videodev ttm intel_rapl_c=
ommon nls_iso8859_1 intel_pch_thermal intel_xhci_usb_role_switch drm_dp_hel=
per int340x_thermal_zone vfat mc roles intel_gtt intel_soc_dts_iosf wmi fat=
 kxcjk_1013 intel_vbtn industrialio_triggered_buffer sparse_keymap cm32181 =
kfifo_buf video industrialio int3400_thermal acpi_thermal_rel wireless_hotk=
ey acpi_pad acpi_tad mac_hid dm_multipath dm_mod crypto_user fuse bpf_prelo=
ad ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 serio_raw atkb=
d libps2 vivaldi_fmap xhci_pci crc32c_intel xhci_pci_renesas i8042 serio
> > > Jun 11 15:43:38 home kernel: CPU: 3 PID: 66361 Comm: kworker/u8:1 Tai=
nted: G W 5.18.0-arch1-1 #1 b71a70fe104889aac2f32556bc52f649da2881d2
> > > Jun 11 15:43:38 home kernel: Hardware name: HP HP 250 G7 Notebook PC/=
84A6, BIOS F.19 05/06/2019
> > > Jun 11 15:43:38 home kernel: Workqueue: phy0 ieee80211_beacon_connect=
ion_loss_work [mac80211]
> > > Jun 11 15:43:38 home kernel: RIP: 0010:rtw_power_mode_change+0x107/0x=
120 [rtw88_core]
> > > Jun 11 15:43:38 home kernel: Code: 9f 43 f3 e5 44 30 e0 78 23 45 84 e=
d 48 c7 c0 0f b7 0d c1 48 c7 c6 18 b7 0d c1 48 c7 c7 e0 98 0d c1 48 0f 45 f=
0 e8 a1 43 c7 e5 <0f> 0b 5b 5d 41 5c 41 5d c3 cc 66 66 2e 0f 1f 84 00 00 00=
 00 00 0f
> > > Jun 11 15:43:38 home kernel: RSP: 0018:ffffb7c0c158bd88 EFLAGS: 00010=
282
> > > Jun 11 15:43:38 home kernel: RAX: 0000000000000000 RBX: ffff923e949a2=
0e0 RCX: 0000000000000027
> > > Jun 11 15:43:38 home kernel: RDX: ffff923fe6da16a8 RSI: 0000000000000=
001 RDI: ffff923fe6da16a0
> > > Jun 11 15:43:38 home kernel: RBP: 000025cf57441865 R08: 0000000000000=
000 R09: ffffb7c0c158bb98
> > > Jun 11 15:43:38 home kernel: R10: 0000000000000003 R11: ffffffffa7eca=
a08 R12: 00000000c05ea080
> > > Jun 11 15:43:38 home kernel: R13: 0000000000000000 R14: ffff923ef3fbf=
3c0 R15: 0000000000000010
> > > Jun 11 15:43:38 home kernel: FS: 0000000000000000(0000) GS:ffff923fe6=
d80000(0000) knlGS:0000000000000000
> > > Jun 11 15:43:38 home kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> > > Jun 11 15:43:38 home kernel: CR2: 00007f662824487c CR3: 000000016a010=
002 CR4: 00000000003706e0
> > > Jun 11 15:43:38 home kernel: Call Trace:
> > > Jun 11 15:43:38 home kernel: <TASK>
> > > Jun 11 15:43:38 home kernel: rtw_pci_deep_ps+0xaa/0xd0 [rtw88_pci 5c3=
473c65c1ef2d2a75611035c99d8c7ddd975f7]
> > > Jun 11 15:43:38 home kernel: rtw_ops_config+0x42/0x100 [rtw88_core c9=
8e023d541cb3d50ab10ce0e14b1134c5e44008]
> > > Jun 11 15:43:38 home kernel: ieee80211_hw_config+0x201/0x3f0 [mac8021=
1 05293841fc04d80013efc49f47d5dec34a8b2f08]
> > > Jun 11 15:43:38 home kernel: ieee80211_recalc_ps.part.0+0x14e/0x1c0 [=
mac80211 05293841fc04d80013efc49f47d5dec34a8b2f08]
> > > Jun 11 15:43:38 home kernel: ieee80211_mgd_probe_ap.part.0+0xc2/0x160=
 [mac80211 05293841fc04d80013efc49f47d5dec34a8b2f08]
> > > Jun 11 15:43:38 home kernel: process_one_work+0x1c7/0x380
> > > Jun 11 15:43:38 home kernel: worker_thread+0x51/0x380
> > > Jun 11 15:43:38 home kernel: ? rescuer_thread+0x3a0/0x3a0
> > > Jun 11 15:43:38 home kernel: kthread+0xde/0x110
> > > Jun 11 15:43:38 home kernel: ? kthread_complete_and_exit+0x20/0x20
> > > Jun 11 15:43:38 home kernel: ret_from_fork+0x22/0x30
> > > Jun 11 15:43:38 home kernel: </TASK>
> > > Jun 11 15:43:38 home kernel: ---[ end trace 0000000000000000 ]---
> > >
> > > I attached part of journalctl for context.
> > >
> > > The laptop is HP 250 G7.
> > > The RTL8821CE wifi card is RFE 2 type.
> > > The kernel version is 5.18-arch1-1 from Arch Linux.
> > > The wifi firmware version is 24.11.0.
> > > The access point is Fiberhome HG6544C.
> > > The NetworkManager version is 1.38.0.
> > > The wpa_supplicant version is 2.10.
> > > I passed disable_aspm=3D1 to rtw88_pci to avoid the new freezes [0].
> > >
> > > I hope this helps.
> > >
> > > [0] https://lore.kernel.org/linux-wireless/Te_PJvJjKCi-lK28Zu0d8VQG0A=
GdwTl6cJydYEETLbc3gN0l8liXH1DSOZnKxUHYGxavLBCs1sqos2e6jeiRzzO0RLRSISdWvTiiP=
p0v9kM=3D@protonmail.com/
> >
> > Since deep-power mode is mentioned, have you tried the 'disable_lps_dee=
p=3Dy' for
> > rtw88_core?
> >
> > Larry
>
>
> I imagine disable_lps_deep=3Dy will stop the warning. I will try it.

Yes, disable_lps_deep=3Dy did stop the warning.
