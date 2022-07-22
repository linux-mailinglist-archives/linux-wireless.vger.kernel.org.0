Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4A57D819
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 03:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiGVBuC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jul 2022 21:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGVBuB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jul 2022 21:50:01 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF0972D8
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jul 2022 18:49:59 -0700 (PDT)
Date:   Fri, 22 Jul 2022 01:49:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=z7stl6zkmnhrfhcp2axdpkokwa.protonmail; t=1658454594; x=1658713794;
        bh=CbITnMjkqqKnsfO+DLnsAndgAOJubbFkLcp66wvYH6E=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=XR8KZgZ4wPC1r0jYRoK6sWqihAiKJcKCzn53HIXXux3ddRNVSS5IG+M7xEghByg/h
         qxr/Hyudrg5brZJRglQI8GhKCmrSv67aAtLLSNluFawybJNEfQfq7pWMoftXw5vq34
         w/CWpGcmTPRgxQBo53wY2mEtZ9B89cZneMEFAZt4D3At7Ipj2EPscYfFtXn2zY3yYU
         8yYI0OLssCl0X6VK2f2WEdrVrJMnZ4EEmvf0jd3fmpNI5N9myBK/O7jiNqljfW01b9
         Gg38GstnhDBDaiNFbJHLlo25aSz2atg0NfFOPyf0QFf0vaRh29akChr+SdV/3hNs17
         NBta5NnheZ68Q==
To:     "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
From:   leadrdrk <LeadRDRK@proton.me>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Reply-To: leadrdrk <LeadRDRK@proton.me>
Subject: mt7921e: MT7921K randomly disconnects itself
Message-ID: <JkcUgyYl9g8c4XmHMqTi1vC594vlX9LfkfZxEToH2Spl9OevhKqxktPbJiWmQUrWaqF1KptUJ2-iIUO9A84f1CG-5WxHFpnje3ehXYzuOsU=@proton.me>
Feedback-ID: 51250809:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,HK_RANDOM_REPLYTO,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, I got a brand new MSI Bravo 15 B5DD that comes with a MediaTek MT7921K =
(RZ608). It works without any issues on Windows, but on Linux, it randomly =
disconnects itself multiple times until it fails.

After it crashes, booting into BIOS immediately would reveal that the syste=
m couldn't detect the WiFi module. I have to wait a few minutes before boot=
ing the machine back up for it to come back.

This problem is=C2=A0reproducible on another Bravo 15 as I had 2 of them. I=
 don't know exactly how it's triggered, but just using them for a while cou=
ld cause the issue to occur.

I'm using kernel version=C2=A05.18.12 on Arch Linux.

Kernel logs:

[12706.121643] ------------[ cut here ]------------
[12706.121645] WARNING: CPU: 8 PID: 19353 at kernel/kthread.c:659 kthread_p=
ark+0x7f/0x90
[12706.121659] Modules linked in: ccm algif_aead cbc des_generic libdes ecb=
 algif_skcipher cmac md4 algif_hash af_alg hid_sensor_gyro_3d hid_sensor_ac=
cel_3d hid_sensor_magn_3d hid_sensor_als hid_sensor_prox hid_sensor_trigger=
 industrialio_triggered_buffer kfifo_buf hid_sensor_iio_common industrialio=
 intel_rapl_msr joydev hid_sensor_hub uvcvideo videobuf2_vmalloc intel_rapl=
_common videobuf2_memops snd_acp3x_rn snd_soc_dmic snd_acp3x_pdm_dma moused=
ev hid_multitouch videobuf2_v4l2 videobuf2_common wmi_bmof edac_mce_amd msi=
_wmi sparse_keymap videodev kvm_amd mc gpio_keys kvm irqbypass crct10dif_pc=
lmul snd_sof_amd_renoir crc32_pclmul ghash_clmulni_intel snd_sof_amd_acp sn=
d_sof_pci aesni_intel mt7921e snd_sof crypto_simd snd_hda_codec_realtek cry=
ptd mt7921_common snd_sof_utils rapl snd_hda_codec_generic mt76_connac_lib =
pcspkr btusb ledtrig_audio snd_hda_codec_hdmi psmouse snd_soc_core btrtl sn=
d_hda_intel mt76 btbcm snd_compress snd_intel_dspcfg amdgpu ac97_bus snd_pc=
m_dmaengine
[12706.121748] =C2=A0snd_intel_sdw_acpi btintel mac80211 k10temp amd_sfh sn=
d_acp_pci snd_hda_codec btmtk libarc4 snd_pci_acp6x tpm_crb bluetooth snd_p=
ci_acp5x r8169 snd_hda_core snd_rn_pci_acp3x cfg80211 tpm_tis snd_hwdep rea=
ltek snd_acp_config tpm_tis_core vfat snd_pcm gpu_sched snd_soc_acpi mdio_d=
evres sp5100_tco drm_ttm_helper snd_timer snd_pci_acp3x ecdh_generic usbhid=
 fat snd ttm drm_dp_helper rfkill soundcore ccp libphy i2c_piix4 mac_hid wm=
i tpm video i2c_hid_acpi rng_core amd_pmc soc_button_array i2c_hid pinctrl_=
amd acpi_cpufreq pkcs8_key_parser crypto_user fuse bpf_preload ip_tables x_=
tables ext4 crc32c_generic crc16 mbcache jbd2 serio_raw atkbd libps2 vivald=
i_fmap nvme xhci_pci crc32c_intel i8042 nvme_core xhci_pci_renesas serio
[12706.121834] CPU: 8 PID: 19353 Comm: kworker/u32:4 Not tainted 5.18.12-ar=
ch1-1 #1 96418c890ae0efcbf26c551e98cb3d72a56d7da8
[12706.121840] Hardware name: Micro-Star International Co., Ltd. Bravo 15 B=
5DD/MS-158K, BIOS E158KAMS.10F 11/22/2021
[12706.121844] Workqueue: mt76 mt7921_mac_reset_work [mt7921_common]
[12706.121857] RIP: 0010:kthread_park+0x7f/0x90
[12706.121863] Code: 89 df e8 d4 76 01 00 48 85 c0 74 27 31 c0 5b 5d c3 cc =
0f 0b 48 8b ab d0 06 00 00 a8 04 74 af 0f 0b b8 da ff ff ff 5b 5d c3 cc <0f=
> 0b b8 f0 ff ff ff eb db 0f 0b eb d5 0f 1f 40 00 f3 0f 1e fa 0f
[12706.121866] RSP: 0018:ffffa6a187333e00 EFLAGS: 00010202
[12706.121870] RAX: 0000000000000004 RBX: ffff8af55c22c100 RCX: 00000000000=
00000
[12706.121873] RDX: 0000000000000003 RSI: 0000000000000003 RDI: ffff8af55c2=
2c100
[12706.121875] RBP: ffff8af5441d2200 R08: ffff8af54f4a24a0 R09: 00000000fff=
ffff0
[12706.121877] R10: 0000000000000003 R11: ffffffffb6ecaa08 R12: ffff8af54f4=
a08e0
[12706.121878] R13: ffff8af54f4a20e0 R14: ffff8af54f4a8610 R15: ffff8af54f4=
a2430
[12706.121881] FS: =C2=A00000000000000000(0000) GS:ffff8af666600000(0000) k=
nlGS:0000000000000000
[12706.121884] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12706.121886] CR2: 0000163e00375000 CR3: 000000015d33a000 CR4: 00000000007=
50ee0
[12706.121888] PKRU: 55555554
[12706.121890] Call Trace:
[12706.121893] =C2=A0<TASK>
[12706.121897] =C2=A0mt7921e_mac_reset+0xa2/0x2e0 [mt7921e 0dcda7569a383081=
0bad886efce3a88657007fb3]
[12706.121908] =C2=A0mt7921_mac_reset_work+0xa3/0x14e [mt7921_common d24f52=
02d3fe775650f5e1ae1d7ca1dd557c1030]
[12706.121918] =C2=A0process_one_work+0x1c7/0x380
[12706.121924] =C2=A0worker_thread+0x51/0x380
[12706.121928] =C2=A0? rescuer_thread+0x3a0/0x3a0
[12706.121931] =C2=A0kthread+0xde/0x110
[12706.121937] =C2=A0? kthread_complete_and_exit+0x20/0x20
[12706.121942] =C2=A0ret_from_fork+0x22/0x30
[12706.121951] =C2=A0</TASK>
[12706.121952] ---[ end trace 0000000000000000 ]---

Before crashing there were also these messages which are repeated several t=
imes from the driver resetting:

[12487.289769] mt7921e 0000:05:00.0: driver own failed
[12487.555608] mt7921e 0000:05:00.0: chip reset
[12487.652848] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time:=
 20220311230842a

[12487.681787] mt7921e 0000:05:00.0: WM Firmware Version: ____010000, Build=
 Time: 20220311230931
[12489.381806] wlan0: Driver requested disconnection from AP bc:62:0e:1b:5c=
:c8
[12489.720414] audit: type=3D1130 audit(1658209453.908:141): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatche=
r comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dsuccess'
[12489.863063] wlan0: authenticate with bc:62:0e:1b:5c:c8
[12489.863076] wlan0: bad VHT capabilities, disabling VHT
[12489.863077] wlan0: Invalid HE elem, Disable HE
[12489.875548] wlan0: send auth to bc:62:0e:1b:5c:c8 (try 1/3)
[12489.879368] wlan0: authenticated
[12489.881651] wlan0: associate with bc:62:0e:1b:5c:c8 (try 1/3)
[12489.886851] wlan0: RX AssocResp from bc:62:0e:1b:5c:c8 (capab=3D0x1411 s=
tatus=3D0 aid=3D3)
[12489.933933] wlan0: associated
[12489.942173] wlan0: Limiting TX power to 30 (30 - 0) dBm as advertised by=
 bc:62:0e:1b:5c:c8
[12490.080217] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[12499.730833] audit: type=3D1131 audit(1658209463.918:142): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatche=
r comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dsuccess'
[12702.628081] mt7921e 0000:05:00.0: driver own failed
[12702.628106] mt7921e 0000:05:00.0: chip reset
[12703.834315] mt7921e 0000:05:00.0: driver own failed
[12703.835973] mt7921e 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT do=
main=3D0x0010 address=3D0xaec50000 flags=3D0x0020]
[12704.927705] mt7921e 0000:05:00.0: Timeout for driver own
[12706.121628] mt7921e 0000:05:00.0: driver own failed
