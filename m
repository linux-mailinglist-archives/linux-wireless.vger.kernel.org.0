Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE750DF0E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Apr 2022 13:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbiDYLo6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Apr 2022 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiDYLoz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Apr 2022 07:44:55 -0400
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 04:41:47 PDT
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB093F33C
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 04:41:44 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Kn2yN6DxXzMprsk;
        Mon, 25 Apr 2022 13:35:56 +0200 (CEST)
Received: from [10.0.0.141] (unknown [31.10.206.124])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Kn2yN2xDSzlhSMx;
        Mon, 25 Apr 2022 13:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1650886556;
        bh=OT5TNlo/CWXJ+DmRsWLQHTgVt00X/nE/78sNz1GGq40=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=lBrfKtm0Mxg6KikOF5WAyI9lkTCmXQ2yITUTv1RpWEpv5tJ5elabYAbgRr2Xf6Rdl
         R6xg86fz5/jNeBTRxsYuUd6wkMUPkvGLNmjwB4F6sz3G4e60QiFcwZHht9AFQXy86B
         m472twBfuEcU3Qb9X1TwdyKHX7LT28UKR1i9Ft2o=
Message-ID: <ce72d897092b2779073f80fa38d72cb1eed0f112.camel@pschenker.ch>
Subject: Re: MT7921 Causing Kernel to Freeze after Reboot
From:   Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
To:     =?ISO-8859-1?Q?=CD=F1igo?= Huguet <ihuguet@redhat.com>
Cc:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Felix Fietkau <nbd@nbd.name>
Date:   Mon, 25 Apr 2022 13:35:56 +0200
In-Reply-To: <CACT4oufe3XzYqDAs6rnhh7gg8p=uVb-veHoEj=AYY_yPEdOLxA@mail.gmail.com>
References: <5077a953487275837e81bdf1808ded00b9676f9f.camel@pschenker.ch>
         <CACT4oudAnhBy2X2pbxd0XJ+bffL64oq=ijRaQE8pt_JHKUXkzA@mail.gmail.com>
         <CACT4oufe3XzYqDAs6rnhh7gg8p=uVb-veHoEj=AYY_yPEdOLxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-04-25 at 12:38 +0200, Íñigo Huguet wrote:
> On Thu, Mar 24, 2022 at 10:13 AM Íñigo Huguet <ihuguet@redhat.com>
> wrote:
> > 
> > On Wed, Dec 22, 2021 at 12:52 PM Philippe Schenker
> > <dev@pschenker.ch> wrote:
> > > 
> > > Hello
> > > 
> > > So I received a new notebook recently, this is a Lenovo P14s that
> > > has a
> > > Mediatek 7961 network controller inside.
> > > 
> > > -----
> > > 
> > > 03:00.0 Network controller: MEDIATEK Corp. Device 7961
> > >         Subsystem: Lenovo Device e0bc
> > >         Physical Slot: 0
> > >         Flags: bus master, fast devsel, latency 0, IRQ 91, IOMMU
> > > group
> > > 13
> > >         Memory at 870200000 (64-bit, prefetchable) [size=1M]
> > >         Memory at 870300000 (64-bit, prefetchable) [size=16K]
> > >         Memory at 870304000 (64-bit, prefetchable) [size=4K]
> > >         Capabilities: <access denied>
> > >         Kernel driver in use: mt7921e
> > >         Kernel modules: mt7921e
> > > ------
> > > 
> > > I have the issue that on 5.16-rc6 kernel (also on other rcs) it is
> > > always freezing after I issue a "reboot" command. "poweroff"
> > > followed by
> > > a normal power-on works always.
> > 
> > I have a bug report with this same behaviour and almost identical
> > kernel logs.: message "Timeout for driver own" followed by traces
> > related to mt7921 dma stuff, indicating bad page state with refcount
> > -1 and "page dumped because: nonzero _refcount", finally causing a
> > crash during boot up, but only after reboot, not after normal power
> > on.
> > 
> > It happens always, even with v5.17. Commit 602cc0c9618a (mt76:
> > mt7921e: fix possible probe failure after reboot) doesn't fix the
> > issue.
> 
> Hi, a follow up with this. It seems that this commit does fix the
> issue for us.
> 602cc0c9618a (mt76: mt7921e: fix possible probe failure after reboot)
> 
> I don't know what we did wrong, but applying this single patch on top
> of a non working one seems to work.
> 
> We'll test it a bit more to confirm, though.

Hello,

I also found that out in the meantime, sorry for not mentioning that
here. This issue was caused by

Commit bf3747ae2e25dd ("mt76: mt7921: enable aspm by default")

After finding this out I sent a revert, from which I was pointed to the
commit (602cc0c9618a) which fixes it also for me.

https://lore.kernel.org/linux-wireless/20220412090415.17541-1-dev@pschenker.ch/

> 
> > 
> > I hadn't been able to verify where the problem exactly is, but my
> > guess is this:
> > - In function mt7921_init_hardware, initialization fails because
> > mt7921e_driver_own doesn't finish before the timeout (thus we see
> > the
> > "Timeout for driver own")
> > - Then, before retrying to init, mt7921_init_hardware calls
> > mt7921e_init_reset, and the latter calls to mt7921_wpdma_reset
> > - That makes a cleanup of the DMA queues before stopping the DMA,
> > which had been enabled short before during probe
> > - Then, my guess is that in the meanwhile, a DMA event arrives with
> > the queues stillI being cleaned up
> > 
> > Does it make sense?
> > 
> > > 
> > > Since it freezes and showing multiple Call Traces I included 4
> > > logs in
> > > the attachment, it certainly points always to mt76_dma functions.
> > > 
> > > One of the traces included down below. I would appreciate any help
> > > on
> > > how to proceed in debugging this, I figure I ask first on here
> > > maybe
> > > someone already has some good hints on where this is leading.
> > > 
> > > Philippe
> > > 
> > > -----
> > > 
> > > 
> > > [   11.195349] Modules linked in: 8021q garp mrp stp llc qrtr cmac
> > > algif_hash algif_skcipher af_alg bnep wireguard curve25519_x86_64
> > > libchacha20poly1305 chacha_x86_64 poly1305_x86_64 libblake2s
> > > blake2s_x86_64 libcurve25519_generic libchacha libblake2s_generic
> > > ip6_udp_tunnel udp_tunnel uvcvideo btusb btrtl videobuf2_vmalloc
> > > joydev
> > > videobuf2_memops btbcm mousedev videobuf2_v4l2 btintel
> > > videobuf2_common
> > > bluetooth videodev mc ecdh_generic intel_rapl_msr mt7921e(+)
> > > mt7921_common mt76_connac_lib intel_rapl_common mt76 snd_acp3x_rn
> > > snd_soc_dmic snd_acp3x_pdm_dma snd_soc_core edac_mce_amd psmouse
> > > snd_ctl_led serio_raw kvm_amd snd_hda_codec_realtek snd_compress
> > > atkbd
> > > libps2 snd_hda_codec_generic snd_hda_codec_hdmi ac97_bus
> > > snd_pcm_dmaengine kvm amdgpu mac80211 snd_hda_intel irqbypass
> > > snd_intel_dspcfg crct10dif_pclmul snd_intel_sdw_acpi think_lmi
> > > crc32_pclmul firmware_attributes_class wmi_bmof
> > > ghash_clmulni_intel
> > > snd_hda_codec libarc4 aesni_intel snd_hda_core crypto_simd
> > > snd_hwdep
> > > cryptd vfat fat
> > > [   11.195370]  rapl cfg80211 pcspkr thinkpad_acpi snd_pcm
> > > sdhci_pci
> > > tpm_crb cqhci ucsi_acpi sp5100_tco ledtrig_audio r8169 snd_timer
> > > gpu_sched sdhci k10temp platform_profile typec_ucsi snd_pci_acp5x
> > > i2c_piix4 snd drm_ttm_helper typec snd_rn_pci_acp3x i8042 xhci_pci
> > > mmc_core ccp ttm snd_pci_acp3x xhci_pci_renesas rfkill realtek
> > > roles
> > > soundcore wmi serio tpm_tis tpm_tis_core i2c_scmi video tpm
> > > mac_hid
> > > acpi_cpufreq pinctrl_amd rng_core nfsd auth_rpcgss nfs_acl lockd
> > > grace
> > > sunrpc ipmi_devintf ipmi_msghandler sg crypto_user fuse ip_tables
> > > x_tables ext4 crc32c_generic crc32c_intel crc16 mbcache jbd2
> > > ftdi_sio
> > > [   11.195388] CPU: 9 PID: 391 Comm: systemd-udevd Tainted: G    B
> > > D W
> > > OE     5.16.0-1-MANJARO #1
> > > e53f5ca75f8033ff8736c17597ec46c465c565c0
> > > [   11.195390] Hardware name: LENOVO 21A0CTO1WW/21A0CTO1WW, BIOS
> > > R1MET43W (1.13 ) 11/05/2021
> > > [   11.195391] Call Trace:
> > > [   11.195392]  <TASK>
> > > [   11.195393]  dump_stack_lvl+0x48/0x66
> > > [   11.195395]  bad_page.cold+0x63/0x94
> > > [   11.195397]  free_pcppages_bulk+0x1f2/0x380
> > > [   11.195400]  free_unref_page+0xbd/0x140
> > > [   11.195402]  mt76_dma_rx_cleanup+0x94/0x120 [mt76
> > > 38914422533eea8f7de7062b22740222ae6696aa]
> > > [   11.195406]  mt7921_wpdma_reset+0xbc/0x1c0 [mt7921e
> > > c9c5ddc0c86616f123c90aadf837c5b1ca6179c1]
> > > [   11.195410]  mt7921_register_device+0x32b/0x5e0 [mt7921_common
> > > de62e6211a822ebe8196f9a6a704d937124a5fd7]
> > > [   11.195413]  mt7921_pci_probe+0x1f1/0x230 [mt7921e
> > > c9c5ddc0c86616f123c90aadf837c5b1ca6179c1]
> > > [   11.195416]  ? __pm_runtime_resume+0x58/0x80
> > > [   11.195418]  local_pci_probe+0x45/0x90
> > > [   11.195419]  ? pci_match_device+0xdf/0x140
> > > [   11.195421]  pci_device_probe+0xcf/0x1c0
> > > [   11.195422]  really_probe+0x203/0x400
> > > [   11.195424]  __driver_probe_device+0x112/0x190
> > > [   11.195426]  driver_probe_device+0x1e/0x90
> > > [   11.195427]  __driver_attach+0xc8/0x1e0
> > > [   11.195428]  ? __device_attach_driver+0xf0/0xf0
> > > [   11.195430]  ? __device_attach_driver+0xf0/0xf0
> > > [   11.195431]  bus_for_each_dev+0x8d/0xe0
> > > [   11.195432]  bus_add_driver+0x154/0x200
> > > [   11.195434]  driver_register+0x8f/0xf0
> > > [   11.195435]  ? 0xffffffffc05d1000
> > > [   11.195436]  do_one_initcall+0x57/0x220
> > > [   11.195438]  do_init_module+0x5c/0x270
> > > [   11.195440]  load_module+0x25d7/0x27a0
> > > [   11.195443]  ? __do_sys_init_module+0x12e/0x1b0
> > > [   11.195444]  __do_sys_init_module+0x12e/0x1b0
> > > [   11.195446]  do_syscall_64+0x5c/0x90
> > > [   11.195448]  ? exc_page_fault+0x72/0x180
> > > [   11.195451]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [   11.195453] RIP: 0033:0x7f765370732e
> > > [   11.195454] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8
> > > ff c3
> > > 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
> > > 00 0f
> > > 0[   12.234716] mt7921e 0000:03:00.0: Timeout for driver own
> > > 
> > > 
> > 
> > 
> > --
> > Íñigo Huguet
> 
> 
> 

