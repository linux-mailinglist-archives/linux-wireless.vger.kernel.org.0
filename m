Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098F24EEC60
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbiDAL0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbiDAL0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 07:26:23 -0400
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Apr 2022 04:24:31 PDT
Received: from mxout017.mail.hostpoint.ch (mxout017.mail.hostpoint.ch [IPv6:2a00:d70:0:e::317])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C519533A
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 04:24:30 -0700 (PDT)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1naFFM-000KvB-OV; Fri, 01 Apr 2022 13:15:16 +0200
Received: from 31-10-206-124.static.upc.ch ([31.10.206.124] helo=[10.0.0.134])
        by asmtp013.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1naFFM-000PiL-IW;
        Fri, 01 Apr 2022 13:15:16 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
Message-ID: <d67a480b032523d65da24b77dee163899dc21ac2.camel@pschenker.ch>
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
Date:   Fri, 01 Apr 2022 13:15:16 +0200
In-Reply-To: <CACT4oudAnhBy2X2pbxd0XJ+bffL64oq=ijRaQE8pt_JHKUXkzA@mail.gmail.com>
References: <5077a953487275837e81bdf1808ded00b9676f9f.camel@pschenker.ch>
         <CACT4oudAnhBy2X2pbxd0XJ+bffL64oq=ijRaQE8pt_JHKUXkzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-03-24 at 10:13 +0100, Íñigo Huguet wrote:
> On Wed, Dec 22, 2021 at 12:52 PM Philippe Schenker <dev@pschenker.ch>
> wrote:
> > 
> > Hello
> > 
> > So I received a new notebook recently, this is a Lenovo P14s that
> > has a
> > Mediatek 7961 network controller inside.
> > 
> > -----
> > 
> > 03:00.0 Network controller: MEDIATEK Corp. Device 7961
> >         Subsystem: Lenovo Device e0bc
> >         Physical Slot: 0
> >         Flags: bus master, fast devsel, latency 0, IRQ 91, IOMMU
> > group
> > 13
> >         Memory at 870200000 (64-bit, prefetchable) [size=1M]
> >         Memory at 870300000 (64-bit, prefetchable) [size=16K]
> >         Memory at 870304000 (64-bit, prefetchable) [size=4K]
> >         Capabilities: <access denied>
> >         Kernel driver in use: mt7921e
> >         Kernel modules: mt7921e
> > ------
> > 
> > I have the issue that on 5.16-rc6 kernel (also on other rcs) it is
> > always freezing after I issue a "reboot" command. "poweroff"
> > followed by
> > a normal power-on works always.
> 
> I have a bug report with this same behaviour and almost identical
> kernel logs.: message "Timeout for driver own" followed by traces
> related to mt7921 dma stuff, indicating bad page state with refcount
> -1 and "page dumped because: nonzero _refcount", finally causing a
> crash during boot up, but only after reboot, not after normal power
> on.
> 
> It happens always, even with v5.17. Commit 602cc0c9618a (mt76:
> mt7921e: fix possible probe failure after reboot) doesn't fix the
> issue.
> 
> I hadn't been able to verify where the problem exactly is, but my
> guess is this:
> - In function mt7921_init_hardware, initialization fails because
> mt7921e_driver_own doesn't finish before the timeout (thus we see the
> "Timeout for driver own")
> - Then, before retrying to init, mt7921_init_hardware calls
> mt7921e_init_reset, and the latter calls to mt7921_wpdma_reset
> - That makes a cleanup of the DMA queues before stopping the DMA,
> which had been enabled short before during probe
> - Then, my guess is that in the meanwhile, a DMA event arrives with
> the queues stillI being cleaned up
> 
> Does it make sense?

After your suggestion I went down the rabbit-hole and bisected this
issue. Fortunately I found the commit introducing the issue. Reverting
this commit solves the problem for me on v5.17. It is caused around the
PCIe ASPM feature.

# first bad commit: [bf3747ae2e25dda6a9e6c464a717c66118c588c8] mt76:
mt7921: enable aspm by default

@Felix do I have to report this anywhere else than on here?

Thanks,
Philippe

> 
> > 
> > Since it freezes and showing multiple Call Traces I included 4 logs
> > in
> > the attachment, it certainly points always to mt76_dma functions.
> > 
> > One of the traces included down below. I would appreciate any help
> > on
> > how to proceed in debugging this, I figure I ask first on here maybe
> > someone already has some good hints on where this is leading.
> > 
> > Philippe
> > 
> > -----
> > 
> > 
> > [   11.195349] Modules linked in: 8021q garp mrp stp llc qrtr cmac
> > algif_hash algif_skcipher af_alg bnep wireguard curve25519_x86_64
> > libchacha20poly1305 chacha_x86_64 poly1305_x86_64 libblake2s
> > blake2s_x86_64 libcurve25519_generic libchacha libblake2s_generic
> > ip6_udp_tunnel udp_tunnel uvcvideo btusb btrtl videobuf2_vmalloc
> > joydev
> > videobuf2_memops btbcm mousedev videobuf2_v4l2 btintel
> > videobuf2_common
> > bluetooth videodev mc ecdh_generic intel_rapl_msr mt7921e(+)
> > mt7921_common mt76_connac_lib intel_rapl_common mt76 snd_acp3x_rn
> > snd_soc_dmic snd_acp3x_pdm_dma snd_soc_core edac_mce_amd psmouse
> > snd_ctl_led serio_raw kvm_amd snd_hda_codec_realtek snd_compress
> > atkbd
> > libps2 snd_hda_codec_generic snd_hda_codec_hdmi ac97_bus
> > snd_pcm_dmaengine kvm amdgpu mac80211 snd_hda_intel irqbypass
> > snd_intel_dspcfg crct10dif_pclmul snd_intel_sdw_acpi think_lmi
> > crc32_pclmul firmware_attributes_class wmi_bmof ghash_clmulni_intel
> > snd_hda_codec libarc4 aesni_intel snd_hda_core crypto_simd snd_hwdep
> > cryptd vfat fat
> > [   11.195370]  rapl cfg80211 pcspkr thinkpad_acpi snd_pcm sdhci_pci
> > tpm_crb cqhci ucsi_acpi sp5100_tco ledtrig_audio r8169 snd_timer
> > gpu_sched sdhci k10temp platform_profile typec_ucsi snd_pci_acp5x
> > i2c_piix4 snd drm_ttm_helper typec snd_rn_pci_acp3x i8042 xhci_pci
> > mmc_core ccp ttm snd_pci_acp3x xhci_pci_renesas rfkill realtek roles
> > soundcore wmi serio tpm_tis tpm_tis_core i2c_scmi video tpm mac_hid
> > acpi_cpufreq pinctrl_amd rng_core nfsd auth_rpcgss nfs_acl lockd
> > grace
> > sunrpc ipmi_devintf ipmi_msghandler sg crypto_user fuse ip_tables
> > x_tables ext4 crc32c_generic crc32c_intel crc16 mbcache jbd2
> > ftdi_sio
> > [   11.195388] CPU: 9 PID: 391 Comm: systemd-udevd Tainted: G    B D
> > W
> > OE     5.16.0-1-MANJARO #1 e53f5ca75f8033ff8736c17597ec46c465c565c0
> > [   11.195390] Hardware name: LENOVO 21A0CTO1WW/21A0CTO1WW, BIOS
> > R1MET43W (1.13 ) 11/05/2021
> > [   11.195391] Call Trace:
> > [   11.195392]  <TASK>
> > [   11.195393]  dump_stack_lvl+0x48/0x66
> > [   11.195395]  bad_page.cold+0x63/0x94
> > [   11.195397]  free_pcppages_bulk+0x1f2/0x380
> > [   11.195400]  free_unref_page+0xbd/0x140
> > [   11.195402]  mt76_dma_rx_cleanup+0x94/0x120 [mt76
> > 38914422533eea8f7de7062b22740222ae6696aa]
> > [   11.195406]  mt7921_wpdma_reset+0xbc/0x1c0 [mt7921e
> > c9c5ddc0c86616f123c90aadf837c5b1ca6179c1]
> > [   11.195410]  mt7921_register_device+0x32b/0x5e0 [mt7921_common
> > de62e6211a822ebe8196f9a6a704d937124a5fd7]
> > [   11.195413]  mt7921_pci_probe+0x1f1/0x230 [mt7921e
> > c9c5ddc0c86616f123c90aadf837c5b1ca6179c1]
> > [   11.195416]  ? __pm_runtime_resume+0x58/0x80
> > [   11.195418]  local_pci_probe+0x45/0x90
> > [   11.195419]  ? pci_match_device+0xdf/0x140
> > [   11.195421]  pci_device_probe+0xcf/0x1c0
> > [   11.195422]  really_probe+0x203/0x400
> > [   11.195424]  __driver_probe_device+0x112/0x190
> > [   11.195426]  driver_probe_device+0x1e/0x90
> > [   11.195427]  __driver_attach+0xc8/0x1e0
> > [   11.195428]  ? __device_attach_driver+0xf0/0xf0
> > [   11.195430]  ? __device_attach_driver+0xf0/0xf0
> > [   11.195431]  bus_for_each_dev+0x8d/0xe0
> > [   11.195432]  bus_add_driver+0x154/0x200
> > [   11.195434]  driver_register+0x8f/0xf0
> > [   11.195435]  ? 0xffffffffc05d1000
> > [   11.195436]  do_one_initcall+0x57/0x220
> > [   11.195438]  do_init_module+0x5c/0x270
> > [   11.195440]  load_module+0x25d7/0x27a0
> > [   11.195443]  ? __do_sys_init_module+0x12e/0x1b0
> > [   11.195444]  __do_sys_init_module+0x12e/0x1b0
> > [   11.195446]  do_syscall_64+0x5c/0x90
> > [   11.195448]  ? exc_page_fault+0x72/0x180
> > [   11.195451]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   11.195453] RIP: 0033:0x7f765370732e
> > [   11.195454] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff
> > c3
> > 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00
> > 0f
> > 0[   12.234716] mt7921e 0000:03:00.0: Timeout for driver own
> > 
> > 
> 
> 

