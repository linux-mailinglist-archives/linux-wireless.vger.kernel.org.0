Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6E2B1BF4
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgKMNgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 08:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMNgs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 08:36:48 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF74EC0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 05:36:47 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id i19so13413516ejx.9
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMTVGMGhpulPKDDADjkMmu6x2CZGN2Y/K6LjkuQcuj0=;
        b=R3XQtrLhB99nlHd13qurobJfQnDAF4gG9IQW/VbM0Oc1HxKC9cz6EL84kd5o/K5cZX
         UlhEwuXzsDcY0VTbE/idjgXtYyh5ftRIkXteE3/EpkcaJZ0eM+LnwTTm+CYGb0PKlCUo
         sTyroPSUP7uimmyLDyrTjSuo1/gnRjsJtHoMejtXtuj78nfTYmQjaTH3GQrV6M1TeHuw
         OTMeSBpY8b27LKgJdOSkolZmYoXdSw00fbsHGm2CHWqkiUT4V7HxWTSXL9ISkzincr3r
         WI+7cZ894DrvjmL/gnbVEUzZDVHQ/ZVpHsK2wmTeCFLKyRvH0YaegJoLeN8QP3hQMGeN
         8aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMTVGMGhpulPKDDADjkMmu6x2CZGN2Y/K6LjkuQcuj0=;
        b=adgfnNGNWpaWQI6ezESdlM+q91GGWDR3PvI9xfP5txD7vFGXJ/HjQt9JmOJo916Ba5
         lAE/yfgvrTUNFx6YjbHT4RG3x3zlteeO+BYVs926Y29xHsTXpwaEncpG1S5Efxx/ZV0p
         /LTRvu49Em1pXt/KF3i/8NIpB/rXEdgbaHeXWoKXmLO04VNy8hKPgkN55pvlfiw23wXZ
         jE4znD0IQrgBx99DVELWedIziK1DLN53UmkqNWfSjqH2ZS/8rbFdBhn4auzzZ0DB7VFo
         DUDLrppJZ6pqddDDVa+Jm1Oef9FRK1NjF+xqslGcXKFFplyfa5g+qvHwoHmIhj4bYjzf
         9B/A==
X-Gm-Message-State: AOAM532obdQPh2DLn2jBwWc6HUb7h4RrfjsC5rBtdivIlwNU7PwZLDZP
        9A2PvlovSfcPPysIsdRVbAVkR1ckiydVuVQCtjtPSg==
X-Google-Smtp-Source: ABdhPJwRL4jI/qjAua2cM6o1X+kSqjOszAgHg6nSseCNIXhwTSdO3HTHaiMyiY5CL7XhB56e/jOSrwytLTzG/1oMMxs=
X-Received: by 2002:a17:906:4c41:: with SMTP id d1mr2004932ejw.485.1605274606226;
 Fri, 13 Nov 2020 05:36:46 -0800 (PST)
MIME-Version: 1.0
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz> <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
 <87eekz4s04.fsf@codeaurora.org> <9d307c40-5ea1-8938-819d-f1742cb99945@gmail.com>
 <cd8d1b1d-a646-b9b1-ed2a-4aa7070efe00@redhat.com> <dd24598f-7635-c2e2-9c6d-f320770e3b9e@gmail.com>
 <f1f471905ea99ad9b9c8a8eeae616ff9@codeaurora.org> <3e30ac52-6ad4-fa7b-8817-bca35a80d268@gmail.com>
In-Reply-To: <3e30ac52-6ad4-fa7b-8817-bca35a80d268@gmail.com>
From:   wi nk <wink@technolu.st>
Date:   Fri, 13 Nov 2020 14:36:35 +0100
Message-ID: <CAHUdJJXnSd614ff+GDOAtUQV_vdUnOkVooFAzp_LA6CbbW=NDA@mail.gmail.com>
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     Pavel Procopiuc <pavel.procopiuc@gmail.com>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        David Hildenbrand <david@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        akpm@linux-foundation.org, ath11k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 13, 2020 at 1:52 PM Pavel Procopiuc
<pavel.procopiuc@gmail.com> wrote:
>
> Op 13.11.2020 om 12:08 schreef Carl Huang:
> > Checked some logs. Looks when the error happens, the physical address are
> > very small. Its' between 20M - 30M.
> >
> > So could you have a try to reserve the memory starting from 20M?
> > Add "memmap=10M\$20M" to your grub.cfg or edit in kernel parameters. so ath11k
> > can't allocate from these address.
> >
> > Or you can try to reserve even larger memory starting from 20M.
>
> That worked, booting with memmap=12M$20M resulted in the working wifi:
>
> $ journalctl -b | grep -iP '05:00|ath11k|Linux version|memmap'
> Nov 13 13:45:34 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
> p6) 2.34.0) #1 SMP Fri Nov 13 13:29:48 CET 2020
> Nov 13 13:45:34 razor kernel: Command line: ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2
> memmap=12M$20M quiet
> Nov 13 13:45:34 razor kernel:   DMA zone: 64 pages used for memmap
> Nov 13 13:45:34 razor kernel:   DMA32 zone: 5165 pages used for memmap
> Nov 13 13:45:34 razor kernel:   Normal zone: 255840 pages used for memmap
> Nov 13 13:45:34 razor kernel: Kernel command line: ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2
> memmap=12M$20M quiet ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2 memmap=12M$20M quiet
> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: MSI vectors: 32
> Nov 13 13:45:35 razor kernel: mhi 0000:05:00.0: Requested to power ON
> Nov 13 13:45:35 razor kernel: mhi 0000:05:00.0: Power on setup success
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[0] 0x2100000 524288 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[1] 0x2180000 524288 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[2] 0x2200000 524288 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[3] 0x2280000 294912 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[4] 0x2300000 524288 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[5] 0x2380000 524288 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[6] 0x2400000 458752 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[7] 0x20c0000 131072 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[8] 0x2480000 524288 4
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[9] 0x2500000 360448 4
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[10] 0x20a4000 16384 1
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50
> fw_build_id
> Nov 13 13:45:37 razor NetworkManager[782]: <info>  [1605271537.1168] rfkill1: found Wi-Fi radio killswitch (at
> /sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0/ieee80211/phy0/rfkill1) (driver ath11k_pci)
> Nov 13 13:45:39 razor ModemManager[722]: <info>  Couldn't check support for device
> '/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0': not supported by any plugin
> Nov 13 13:45:45 razor kernel: ath11k_pci 0000:05:00.0: failed to enqueue rx buf: -28
>
> --
> ath11k mailing list
> ath11k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath11k

When I attempt to boot my 5.10rc2 kernel with that memmap option, my
machine immediately hangs.  That said, it seems to have done something
bizarre, as immediately afterwards, if I remove that option and let
5.10 boot normally, it seems to boot and bring up the wifi adapter ok
(which didn't happen before).  Now that I've managed to boot 5.10
twice, the first time after a couple of minutes my video started going
nuts and displaying all sorts of artifacts[1].  This time things seem
to be functioning nominally (wifi is online and the machine is
behaving properly).  I may just never turn it off again :D.

[1] - Here is what dmesg reported as that was occuring:

[   16.158464] ath11k_pci 0000:55:00.0 wlp85s0: renamed from wlan0
[   16.266416] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you
need this.
[   16.267385] Bridge firewalling registered
[   16.415304] Initializing XFRM netlink socket
[   16.587820] process 'docker/tmp/qemu-check645322819/check' started
with executable stack
[   16.806205] Bluetooth: hci0: QCA Downloading qca/htnv20.bin
[   17.000375] Bluetooth: hci0: QCA setup on UART is completed
[   17.022058] NET: Registered protocol family 38
[   18.149182] rfkill: input handler disabled
[   30.403700] Bluetooth: RFCOMM TTY layer initialized
[   30.403704] Bluetooth: RFCOMM socket layer initialized
[   30.403707] Bluetooth: RFCOMM ver 1.11
[   30.613483] rfkill: input handler enabled
[   31.928415] rfkill: input handler disabled
[   45.130209] ath11k_pci 0000:55:00.0: failed to receive scan abort
comple: timed out
[   45.130219] ath11k_pci 0000:55:00.0: failed to abort scan: -110
[   48.202259] ath11k_pci 0000:55:00.0: wmi command 12289 timeout
[   48.202264] ath11k_pci 0000:55:00.0: failed to send WMI_START_SCAN_CMDID
[   48.202269] ath11k_pci 0000:55:00.0: failed to start hw scan: -11
[   48.220668] wlp85s0: authenticate with ec:08:6b:27:01:ea
[   51.274151] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
[   51.274153] ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[   51.274155] ath11k_pci 0000:55:00.0: failed to recalc txpower limit
24 using pdev param 3: -11
[   54.346271] ath11k_pci 0000:55:00.0: wmi command 20488 timeout
[   54.346276] ath11k_pci 0000:55:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
[   54.346283] ath11k_pci 0000:55:00.0: Failed to set beacon interval
for VDEV: 0
[   57.418158] ath11k_pci 0000:55:00.0: wmi command 20488 timeout
[   57.418161] ath11k_pci 0000:55:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
[   57.418163] ath11k_pci 0000:55:00.0: failed to set mgmt tx rate -11
[   60.490264] ath11k_pci 0000:55:00.0: wmi command 20488 timeout
[   60.490268] ath11k_pci 0000:55:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
[   60.490273] ath11k_pci 0000:55:00.0: failed to set beacon tx rate -11
[   63.562154] ath11k_pci 0000:55:00.0: wmi command 24577 timeout
[   63.562157] ath11k_pci 0000:55:00.0: failed to submit WMI_PEER_CREATE cmd
[   63.562159] ath11k_pci 0000:55:00.0: failed to send peer create
vdev_id 0 ret -11
[   63.562161] ath11k_pci 0000:55:00.0: Failed to add peer:
ec:08:6b:27:01:ea for VDEV: 0
[   63.562163] ath11k_pci 0000:55:00.0: Failed to add station:
ec:08:6b:27:01:ea for VDEV: 0
[   63.562196] wlp85s0: failed to insert STA entry for the AP (error -11)
[   63.562226] ------------[ cut here ]------------
[   63.562235] WARNING: CPU: 1 PID: 1036 at
drivers/net/wireless/ath/ath11k/mac.c:5287
ath11k_mac_op_unassign_vif_chanctx+0x1e3/0x2e0 [ath11k]
[   63.562236] Modules linked in: rfcomm cmac algif_hash
algif_skcipher af_alg xt_conntrack xt_MASQUERADE nf_conntrack_netlink
xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat nft_chain_nat
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c
nfnetlink br_netfilter bridge stp llc snd_soc_skl_hda_dsp
snd_soc_hdac_hdmi qrtr_mhi bnep overlay snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic snd_sof_pci
snd_sof_intel_byt snd_sof_intel_ipc snd_sof_intel_hda_common
snd_soc_hdac_hda snd_sof_xtensa_dsp snd_sof_intel_hda snd_sof
snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core
snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg
snd_hda_codec snd_hda_core snd_hwdep snd_pcm qrtr ns snd_seq_midi
ath11k_pci snd_seq_midi_event mhi snd_rawmidi ath11k snd_seq
nls_iso8859_1 qmi_helpers joydev mei_hdcp dell_laptop snd_seq_device
snd_timer ledtrig_audio uvcvideo intel_rapl_msr videobuf2_vmalloc
videobuf2_memops dell_wmi
[   63.562269]  x86_pkg_temp_thermal intel_powerclamp videobuf2_v4l2
dell_smm_hwmon mac80211 hci_uart dell_smbios videobuf2_common coretemp
btqca kvm_intel hid_sensor_als hid_sensor_trigger
industrialio_triggered_buffer kfifo_buf kvm hid_sensor_iio_common
mousedev cfg80211 snd dcdbas btrtl input_leds videodev serio_raw
efi_pstore wmi_bmof intel_cstate dell_wmi_descriptor libarc4 mc
hid_multitouch industrialio btbcm soundcore 8250_dw btintel bluetooth
mei_me mei cros_ec_ishtp cros_ec processor_thermal_device ucsi_acpi
ecdh_generic typec_ucsi intel_rapl_common typec intel_soc_dts_iosf ecc
int3403_thermal int340x_thermal_zone mac_hid acpi_pad intel_hid
int3400_thermal acpi_thermal_rel sparse_keymap acpi_tad sch_fq_codel
parport_pc ppdev lp parport ip_tables x_tables autofs4 dm_crypt
hid_sensor_hub intel_ishtp_loader intel_ishtp_hid hid_generic
i2c_designware_platform i2c_designware_core i915 nvme crct10dif_pclmul
crc32_pclmul i2c_algo_bit rtsx_pci_sdmmc nvme_core ghash_clmulni_intel
[   63.562306]  drm_kms_helper aesni_intel syscopyarea sysfillrect
crypto_simd sysimgblt fb_sys_fops cryptd glue_helper cec psmouse
i2c_i801 rc_core i2c_smbus rtsx_pci intel_lpss_pci drm vmd intel_lpss
thunderbolt intel_ish_ipc idma64 intel_ishtp virt_dma xhci_pci
xhci_pci_renesas wmi i2c_hid hid video backlight pinctrl_tigerlake
[   63.562323] CPU: 1 PID: 1036 Comm: wpa_supplicant Tainted: G
W I       5.10.0-rc2+ #1
[   63.562324] Hardware name: Dell Inc. XPS 13 9310/0F7M4C, BIOS 1.1.1
10/05/2020
[   63.562328] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1e3/0x2e0 [ath11k]
[   63.562329] Code: 8b 83 e0 02 00 00 4c 89 e9 be 10 00 00 00 4c 89
e7 48 c7 c2 e8 c2 cb c0 e8 2a 5b 01 00 80 bb 98 03 00 00 00 0f 85 6d
fe ff ff <0f> 0b e9 66 fe ff ff f0 41 80 a6 d8 16 00 00 fe f6 05 16 67
04 00
[   63.562330] RSP: 0018:ffffa63580bcf760 EFLAGS: 00010246
[   63.562331] RAX: 0000000000000000 RBX: ffff8e2c1c891588 RCX: 0000000000000000
[   63.562332] RDX: ffff8e2c2516dac0 RSI: ffff8e2c1c891588 RDI: ffff8e2c1e3c35f8
[   63.562332] RBP: ffffa63580bcf798 R08: ffff8e2c1c890980 R09: ffffa63580bcf4f8
[   63.562333] R10: ffffa63580bcf4f0 R11: ffffffff8d152ca8 R12: ffff8e2c27c60000
[   63.562333] R13: ffff8e2c1a9214d8 R14: 0000000000000000 R15: ffff8e2c1e3c35f8
[   63.562334] FS:  00007fa314f19800(0000) GS:ffff8e2c4f440000(0000)
knlGS:0000000000000000
[   63.562335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.562336] CR2: 00007f222eefcaf8 CR3: 0000000860cdc001 CR4: 0000000000770ee0
[   63.562336] PKRU: 55555554
[   63.562337] Call Trace:
[   63.562360]  ieee80211_assign_vif_chanctx+0x8f/0x410 [mac80211]
[   63.562370]  __ieee80211_vif_release_channel+0x54/0x140 [mac80211]
[   63.562380]  ieee80211_vif_release_channel+0x3e/0x60 [mac80211]
[   63.562391]  ieee80211_mgd_auth+0x213/0x3e0 [mac80211]
[   63.562405]  ? cfg80211_get_bss+0x1d9/0x2a0 [cfg80211]
[   63.562414]  ieee80211_auth+0x18/0x20 [mac80211]
[   63.562423]  cfg80211_mlme_auth+0x104/0x1e0 [cfg80211]
[   63.562431]  nl80211_authenticate+0x29d/0x2f0 [cfg80211]
[   63.562435]  genl_family_rcv_msg_doit+0xe7/0x150
[   63.562437]  genl_rcv_msg+0xe2/0x1e0
[   63.562444]  ? nl80211_parse_key+0x310/0x310 [cfg80211]
[   63.562445]  ? genl_get_cmd+0xd0/0xd0
[   63.562446]  netlink_rcv_skb+0x55/0x100
[   63.562447]  genl_rcv+0x29/0x40
[   63.562448]  netlink_unicast+0x221/0x330
[   63.562449]  netlink_sendmsg+0x233/0x460
[   63.562451]  sock_sendmsg+0x65/0x70
[   63.562452]  ____sys_sendmsg+0x257/0x2a0
[   63.562454]  ? import_iovec+0x31/0x40
[   63.562455]  ? sendmsg_copy_msghdr+0x7e/0xa0
[   63.562456]  ___sys_sendmsg+0x82/0xc0
[   63.562458]  ? __check_object_size+0x4d/0x150
[   63.562459]  ? _copy_to_user+0x31/0x50
[   63.562460]  ? sock_getsockopt+0x1a1/0xcd0
[   63.562462]  ? unix_ioctl+0x5f/0x70
[   63.562463]  ? sock_do_ioctl+0x40/0x140
[   63.562465]  ? __cgroup_bpf_run_filter_setsockopt+0xb8/0x2e0
[   63.562467]  __sys_sendmsg+0x62/0xb0
[   63.562468]  __x64_sys_sendmsg+0x1f/0x30
[   63.562470]  do_syscall_64+0x38/0x90
[   63.562471]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   63.562472] RIP: 0033:0x7fa31537c777
[   63.562473] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74
24 10
[   63.562474] RSP: 002b:00007ffdcaf17988 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[   63.562475] RAX: ffffffffffffffda RBX: 0000560dc75336e0 RCX: 00007fa31537c777
[   63.562475] RDX: 0000000000000000 RSI: 00007ffdcaf179c0 RDI: 0000000000000006
[   63.562476] RBP: 0000560dc75758c0 R08: 0000000000000004 R09: 0000560dc756e760
[   63.562476] R10: 00007ffdcaf17a94 R11: 0000000000000246 R12: 0000560dc75335f0
[   63.562477] R13: 00007ffdcaf179c0 R14: 00007ffdcaf17a94 R15: 0000560dc756e760
[   63.562478] CPU: 1 PID: 1036 Comm: wpa_supplicant Tainted: G
W I       5.10.0-rc2+ #1
[   63.562479] Hardware name: Dell Inc. XPS 13 9310/0F7M4C, BIOS 1.1.1
10/05/2020
[   63.562479] Call Trace:
[   63.562481]  dump_stack+0x70/0x8b
[   63.562485]  ? ath11k_mac_op_unassign_vif_chanctx+0x1e3/0x2e0 [ath11k]
[   63.562487]  __warn.cold+0x24/0x77
[   63.562489]  ? ath11k_mac_op_unassign_vif_chanctx+0x1e3/0x2e0 [ath11k]
[   63.562491]  report_bug+0xa1/0xc0
[   63.562493]  handle_bug+0x3e/0xa0
[   63.562494]  exc_invalid_op+0x19/0x70
[   63.562495]  asm_exc_invalid_op+0x12/0x20
[   63.562497] RIP: 0010:ath11k_mac_op_unassign_vif_chanctx+0x1e3/0x2e0 [ath11k]
[   63.562498] Code: 8b 83 e0 02 00 00 4c 89 e9 be 10 00 00 00 4c 89
e7 48 c7 c2 e8 c2 cb c0 e8 2a 5b 01 00 80 bb 98 03 00 00 00 0f 85 6d
fe ff ff <0f> 0b e9 66 fe ff ff f0 41 80 a6 d8 16 00 00 fe f6 05 16 67
04 00
[   63.562498] RSP: 0018:ffffa63580bcf760 EFLAGS: 00010246
[   63.562499] RAX: 0000000000000000 RBX: ffff8e2c1c891588 RCX: 0000000000000000
[   63.562499] RDX: ffff8e2c2516dac0 RSI: ffff8e2c1c891588 RDI: ffff8e2c1e3c35f8
[   63.562500] RBP: ffffa63580bcf798 R08: ffff8e2c1c890980 R09: ffffa63580bcf4f8
[   63.562500] R10: ffffa63580bcf4f0 R11: ffffffff8d152ca8 R12: ffff8e2c27c60000
[   63.562501] R13: ffff8e2c1a9214d8 R14: 0000000000000000 R15: ffff8e2c1e3c35f8
[   63.562511]  ieee80211_assign_vif_chanctx+0x8f/0x410 [mac80211]
[   63.562520]  __ieee80211_vif_release_channel+0x54/0x140 [mac80211]
[   63.562528]  ieee80211_vif_release_channel+0x3e/0x60 [mac80211]
[   63.562538]  ieee80211_mgd_auth+0x213/0x3e0 [mac80211]
[   63.562545]  ? cfg80211_get_bss+0x1d9/0x2a0 [cfg80211]
[   63.562554]  ieee80211_auth+0x18/0x20 [mac80211]
[   63.562562]  cfg80211_mlme_auth+0x104/0x1e0 [cfg80211]
[   63.562570]  nl80211_authenticate+0x29d/0x2f0 [cfg80211]
[   63.562571]  genl_family_rcv_msg_doit+0xe7/0x150
[   63.562573]  genl_rcv_msg+0xe2/0x1e0
[   63.562580]  ? nl80211_parse_key+0x310/0x310 [cfg80211]
[   63.562581]  ? genl_get_cmd+0xd0/0xd0
[   63.562582]  netlink_rcv_skb+0x55/0x100
[   63.562583]  genl_rcv+0x29/0x40
[   63.562583]  netlink_unicast+0x221/0x330
[   63.562584]  netlink_sendmsg+0x233/0x460
[   63.562585]  sock_sendmsg+0x65/0x70
[   63.562586]  ____sys_sendmsg+0x257/0x2a0
[   63.562587]  ? import_iovec+0x31/0x40
[   63.562588]  ? sendmsg_copy_msghdr+0x7e/0xa0
[   63.562589]  ___sys_sendmsg+0x82/0xc0
[   63.562590]  ? __check_object_size+0x4d/0x150
[   63.562591]  ? _copy_to_user+0x31/0x50
[   63.562592]  ? sock_getsockopt+0x1a1/0xcd0
[   63.562593]  ? unix_ioctl+0x5f/0x70
[   63.562594]  ? sock_do_ioctl+0x40/0x140
[   63.562595]  ? __cgroup_bpf_run_filter_setsockopt+0xb8/0x2e0
[   63.562596]  __sys_sendmsg+0x62/0xb0
[   63.562597]  __x64_sys_sendmsg+0x1f/0x30
[   63.562598]  do_syscall_64+0x38/0x90
[   63.562599]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   63.562600] RIP: 0033:0x7fa31537c777
[   63.562601] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74
24 10
[   63.562601] RSP: 002b:00007ffdcaf17988 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[   63.562602] RAX: ffffffffffffffda RBX: 0000560dc75336e0 RCX: 00007fa31537c777
[   63.562602] RDX: 0000000000000000 RSI: 00007ffdcaf179c0 RDI: 0000000000000006
[   63.562603] RBP: 0000560dc75758c0 R08: 0000000000000004 R09: 0000560dc756e760
[   63.562603] R10: 00007ffdcaf17a94 R11: 0000000000000246 R12: 0000560dc75335f0
[   63.562604] R13: 00007ffdcaf179c0 R14: 00007ffdcaf17a94 R15: 0000560dc756e760
[   63.562605] ---[ end trace fa93bfa591439000 ]---
[   66.634150] ath11k_pci 0000:55:00.0: wmi command 20486 timeout
[   66.634152] ath11k_pci 0000:55:00.0: failed to submit WMI_VDEV_STOP cmd
[   66.634155] ath11k_pci 0000:55:00.0: failed to stop WMI vdev 0: -11
[   66.634156] ath11k_pci 0000:55:00.0: failed to stop vdev 0: -11
[   69.962250] ath11k_pci 0000:55:00.0: wmi command 12289 timeout
[   69.962255] ath11k_pci 0000:55:00.0: failed to send WMI_START_SCAN_CMDID
[   69.962259] ath11k_pci 0000:55:00.0: failed to start hw scan: -11
[   74.058210] ath11k_pci 0000:55:00.0: wmi command 12289 timeout
[   74.058212] ath11k_pci 0000:55:00.0: failed to send WMI_START_SCAN_CMDID
[   74.058214] ath11k_pci 0000:55:00.0: failed to start hw scan: -11
[   77.130191] ath11k_pci 0000:55:00.0: wmi command 12289 timeout
[   77.130193] ath11k_pci 0000:55:00.0: failed to send WMI_START_SCAN_CMDID
[   77.130196] ath11k_pci 0000:55:00.0: failed to start hw scan: -11
[   80.202147] ath11k_pci 0000:55:00.0: wmi command 12289 timeout
[   80.202148] ath11k_pci 0000:55:00.0: failed to send WMI_START_SCAN_CMDID
[   80.202150] ath11k_pci 0000:55:00.0: failed to start hw scan: -11
[   83.274164] ath11k_pci 0000:55:00.0: wmi command 12289 timeout
[   83.274168] ath11k_pci 0000:55:00.0: failed to send WMI_START_SCAN_CMDID
[   83.274173] ath11k_pci 0000:55:00.0: failed to start hw scan: -11
[   86.346167] ath11k_pci 0000:55:00.0: wmi command 12289 timeout
<snip>
