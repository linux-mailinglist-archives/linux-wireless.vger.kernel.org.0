Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E034415B0E7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 20:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLTVx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 14:21:53 -0500
Received: from mail.as397444.net ([69.59.18.99]:37860 "EHLO mail.as397444.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgBLTVx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 14:21:53 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 14:21:52 EST
Received: from [IPv6:2620:6e:a000:233::100] (unknown [IPv6:2620:6e:a000:233::100])
        by mail.as397444.net (Postfix) with ESMTPSA id A316A1A3E37
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2020 19:16:29 +0000 (UTC)
To:     linux-wireless@vger.kernel.org
From:   Matt Corallo <linux@bluematt.me>
Subject: v5.4 instability and NULL ptr deref with Intel Corporation
 Wireless-AC 9260 (rev 29)
Message-ID: <71650799-e622-2a33-0299-90d53a38de94@bluematt.me>
Date:   Wed, 12 Feb 2020 19:16:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

First reported at
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=951177 but figured
this was a better place.

Since switching to 5.4.13 from 5.3.15 (IIRC, though I may have been on
5.4.8), my laptop sees lots of issues with wilwifi regularly when
transmitting a bunch of wireguard traffic. I've seen the following
nullptr deref a few times:

Feb 12 13:55:39 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Error sending
STATISTICS_CMD: time out after 2000ms.
Feb 12 13:55:39 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Current CMD queue
read_ptr 223 write_ptr 224
Feb 12 13:55:41 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: HW error,
resetting before reading
Feb 12 13:55:41 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Microcode SW error
detected. Restarting 0xA5A505A2.
Feb 12 13:55:41 BMXPSv3 kernel: BUG: kernel NULL pointer dereference,
address: 0000000000000008
Feb 12 13:55:41 BMXPSv3 kernel: #PF: supervisor read access in kernel mode
Feb 12 13:55:41 BMXPSv3 kernel: #PF: error_code(0x0000) - not-present page
Feb 12 13:55:41 BMXPSv3 kernel: PGD 0 P4D 0
Feb 12 13:55:41 BMXPSv3 kernel: Oops: 0000 [#1] SMP PTI
Feb 12 13:55:41 BMXPSv3 kernel: CPU: 0 PID: 588 Comm: irq/158-iwlwifi
Tainted: G           OE     5.4.0-3-amd64 #1 Debian 5.4.13-1
Feb 12 13:55:41 BMXPSv3 kernel: Hardware name: Dell Inc. Precision
5530/0W8N6V, BIOS 1.8.1 02/01/2019
Feb 12 13:55:42 BMXPSv3 kernel: RIP:
0010:iwl_pcie_irq_msix_handler+0x12f/0x370 [iwlwifi]
Feb 12 13:55:42 BMXPSv3 kernel: Code: 00 41 f6 c6 01 0f 85 a4 00 00 00
48 8b 45 10 44 89 f2 83 e2 02 83 78 10 13 0f 84 2d 01 00 00 85 d2 74 37
48 8b 83 38 72 00 00 <8b> 40 08 3d d3 00 00 00 0f 84 06 02 00 00 3d d0
00 00 00 0f 84 fb
Feb 12 13:55:42 BMXPSv3 kernel: RSP: 0018:ffffb12300d3be60 EFLAGS: 00010202
Feb 12 13:55:42 BMXPSv3 kernel: RAX: 0000000000000000 RBX:
ffff8c84dace0318 RCX: 0000000000000000
Feb 12 13:55:42 BMXPSv3 kernel: RDX: 0000000000000002 RSI:
0000000000000246 RDI: 0000000000000246
Feb 12 13:55:42 BMXPSv3 kernel: RBP: ffff8c84dace0018 R08:
ffff8c84dace8fa8 R09: ffffb12300d3bdf8
Feb 12 13:55:42 BMXPSv3 kernel: R10: ffffb12300d3bb50 R11:
0000000000000000 R12: 00000000a5a505a2
Feb 12 13:55:42 BMXPSv3 kernel: R13: ffff8c84dace907c R14:
0000000024000182 R15: ffff8c84dace7ea4
Feb 12 13:55:42 BMXPSv3 kernel: FS:  0000000000000000(0000)
GS:ffff8c84ec000000(0000) knlGS:0000000000000000
Feb 12 13:55:42 BMXPSv3 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 12 13:55:42 BMXPSv3 kernel: CR2: 0000000000000008 CR3:
000000012ba0a003 CR4: 00000000003606f0
Feb 12 13:55:42 BMXPSv3 kernel: Call Trace:
Feb 12 13:55:42 BMXPSv3 kernel:  ? irq_finalize_oneshot.part.0+0x100/0x100
Feb 12 13:55:42 BMXPSv3 kernel:  irq_thread_fn+0x20/0x60
Feb 12 13:55:42 BMXPSv3 kernel:  irq_thread+0xdc/0x170
Feb 12 13:55:42 BMXPSv3 kernel:  ? irq_forced_thread_fn+0x80/0x80
Feb 12 13:55:42 BMXPSv3 kernel:  kthread+0xf9/0x130
Feb 12 13:55:42 BMXPSv3 kernel:  ? irq_thread_check_affinity+0xd0/0xd0
Feb 12 13:55:42 BMXPSv3 kernel:  ? kthread_park+0x90/0x90
Feb 12 13:55:42 BMXPSv3 kernel:  ret_from_fork+0x35/0x40
Feb 12 13:55:42 BMXPSv3 kernel: Modules linked in: snd_usb_audio
snd_usbmidi_lib snd_rawmidi snd_seq_device sctp ipheth veth
typec_displayport ccm ip6t_REJECT nf_reject_ipv6 sch_fq_codel sch_htb
ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_MASQUERADE xt_nat nft_chain_nat
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 crc32c_generic
nft_counter xt_mark xt_owner nft_compat bridge stp llc wireguard(OE)
ip6_udp_tunnel udp_tunnel wacom usbhid hid_multitouch hid_generic
snd_sof_pci snd_sof_intel_hda_common snd_sof_intel_hda snd_sof_intel_byt
snd_sof_intel_ipc snd_sof snd_sof_xtensa_dsp snd_soc_skl nf_tables
snd_hda_codec_hdmi snd_soc_hdac_hda nfnetlink snd_hda_ext_core
rtsx_pci_sdmmc mei_wdt snd_soc_sst_ipc iTCO_wdt iTCO_vendor_support
dell_rbtn i2c_designware_platform snd_hda_codec_realtek rtsx_pci_ms
snd_soc_sst_dsp snd_soc_acpi_intel_match i2c_designware_core watchdog
mmc_core memstick snd_hda_codec_generic snd_soc_acpi intel_rapl_msr
x86_pkg_temp_thermal intel_powerclamp coretemp snd_soc_core dell_laptop
dell_wmi
Feb 12 13:55:42 BMXPSv3 kernel:  ledtrig_audio kvm_intel snd_compress
dell_smbios iwlmvm snd_hda_intel wmi_bmof intel_wmi_thunderbolt kvm
mac80211 snd_intel_nhlt mxm_wmi btusb btrtl btbcm btintel tpm_crb
irqbypass dell_wmi_descriptor libarc4 snd_hda_codec dcdbas bluetooth
dell_smm_hwmon snd_hda_core crct10dif_pclmul snd_hwdep crc32_pclmul
iwlwifi snd_pcm uvcvideo drbg videobuf2_vmalloc snd_timer
videobuf2_memops ahci videobuf2_v4l2 efi_pstore ghash_clmulni_intel
ansi_cprng snd intel_cstate ecdh_generic libahci videobuf2_common
intel_uncore intel_lpss_pci cfg80211 joydev pcspkr efivars i2c_i801
soundcore mei_me intel_rapl_perf ecc intel_lpss idma64 rtsx_pci libata
rfkill cdc_acm videodev mei ucsi_acpi mfd_core crc16
processor_thermal_device mc typec_ucsi i2c_hid intel_rapl_common
intel_pch_thermal intel_soc_dts_iosf typec hid battery tpm_tis
tpm_tis_core int3403_thermal int340x_thermal_zone dell_smo8800 tpm wmi
intel_hid rng_core acpi_pad sparse_keymap ac int3400_thermal button
acpi_thermal_rel efivarfs
Feb 12 13:55:42 BMXPSv3 kernel:  ip_tables x_tables autofs4 btrfs
libcrc32c xor zstd_decompress zstd_compress raid6_pq ctr dm_crypt dm_mod
algif_skcipher af_alg sd_mod usb_storage scsi_mod i915 crc32c_intel
i2c_algo_bit drm_kms_helper xhci_pci xhci_hcd nvme drm aesni_intel
usbcore psmouse glue_helper crypto_simd cryptd evdev nvme_core serio_raw
usb_common video [last unloaded: acpi_call]
Feb 12 13:55:42 BMXPSv3 kernel: CR2: 0000000000000008
Feb 12 13:55:42 BMXPSv3 kernel: ---[ end trace e4c76f655a7083a1 ]---



as well as hangs regularly like:


Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Queue 10 is
inactive on fifo 2 and stuck for 10000 ms. SW [210, 174] HW [162, 162]
FH TRB=0x0a5a5a5a2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Hardware error
detected. Restarting.
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: HW error,
resetting before reading
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Start IWL Error
Log Dump:
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Status:
0x00000040, count: -507577611
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Loaded firmware
version: 46.a41adfe7.0
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x87B35882 |
ADVANCED_SYSASSERT
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x3A746FE3 |
trm_hw_status0
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x0F6832E3 |
trm_hw_status1
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xFEBC9E3F |
branchlink2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x36D18045 |
interruptlink1
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xB59EB707 |
interruptlink2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x99CA923B | data1
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xBB6715CD | data2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x40802F60 | data3
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x51BBDEF6 |
beacon time
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x1B00F6D4 | tsf low
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x61357AFF | tsf hi
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xC61D87FB | time gp1
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA97AC55B | time gp2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x50929CF9 | uCode
revision type
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x757CEB5E | uCode
version major
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xC8419542 | uCode
version minor
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xE3A777F7 | hw
version
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x0C047A38 | board
version
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x869678C7 | hcmd
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xE755B9DA | isr0
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xB32D57DE | isr1
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x7B1FC4FB | isr2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xBE16425F | isr3
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xDFFE2A35 | isr4
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA38E1736 | last
cmd Id
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xF8B0957A |
wait_event
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x15AA188C |
l2p_control
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xDECF3EF5 |
l2p_duration
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xFB941368 |
l2p_mhvalid
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x55FEB6A6 |
l2p_addr_match
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xED461673 |
lmpm_pmg_sel
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xF82E5779 | timestamp
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x51510013 |
flow_handler
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Start IWL Error
Log Dump:
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Status:
0x00000040, count: 1487817107
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xCBF574B3 |
ADVANCED_SYSASSERT
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xE35C7AA3 | umac
branchlink1
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xC53A411D | umac
branchlink2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xD6AFD273 | umac
interruptlink1
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA351EE30 | umac
interruptlink2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5EB8FB4 | umac
data1
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x460A2DBD | umac
data2
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xFBB42017 | umac
data3
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xFF83A4CB | umac
major
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xE8C5AAAB | umac
minor
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x4DD67A3D | frame
pointer
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xF0ABBF98 | stack
pointer
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xC48CD80C | last
host cmd
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0x94ABACD9 | isr
status reg
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Fseq Registers:
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
FSEQ_ERROR_CODE
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
FSEQ_TOP_INIT_VERSION
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
FSEQ_CNVIO_INIT_VERSION
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
FSEQ_OTP_VERSION
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
FSEQ_TOP_CONTENT_VERSION
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
FSEQ_ALIVE_TOKEN
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
FSEQ_CNVI_ID
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
FSEQ_CNVR_ID
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
CNVI_AUX_MISC_CHIP
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
CNVR_AUX_MISC_CHIP
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: 0xA5A5A5A2 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
Feb 12 14:06:43 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Collecting data:
trigger 2 fired.
Feb 12 14:06:43 BMXPSv3 kernel: ieee80211 phy0: Hardware restart was
requested
Feb 12 14:06:45 BMXPSv3 kernel: perf: interrupt took too long (2747 >
2500), lowering kernel.perf_event_max_sample_rate to 72750
Feb 12 14:07:04 BMXPSv3 kernel: rcu: INFO: rcu_sched detected stalls on
CPUs/tasks:
Feb 12 14:07:04 BMXPSv3 kernel: rcu: 	10-....: (6 ticks this GP)
idle=61a/1/0x4000000000000000 softirq=21140/21140 fqs=2390
Feb 12 14:07:04 BMXPSv3 kernel: 	(detected by 2, t=5252 jiffies,
g=23373, q=33290)
Feb 12 14:07:04 BMXPSv3 kernel: Sending NMI from CPU 2 to CPUs 10:
Feb 12 14:07:04 BMXPSv3 kernel: NMI backtrace for cpu 10
Feb 12 14:07:04 BMXPSv3 kernel: CPU: 10 PID: 621 Comm: kworker/10:2
Tainted: G           OE     5.4.0-3-amd64 #1 Debian 5.4.13-1
Feb 12 14:07:04 BMXPSv3 kernel: Hardware name: Dell Inc. Precision
5530/0W8N6V, BIOS 1.8.1 02/01/2019
Feb 12 14:07:04 BMXPSv3 kernel: Workqueue: events iwl_fw_error_dump_wk
[iwlwifi]
Feb 12 14:07:04 BMXPSv3 kernel: RIP:
0010:iwl_trans_pcie_read32+0x10/0x20 [iwlwifi]
Feb 12 14:07:04 BMXPSv3 kernel: Code: f6 48 03 b7 78 8f 00 00 89 16 c3
66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 89 f6 48 03
b7 78 8f 00 00 8b 06 <c3> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
0f 1f 44 00 00 48
Feb 12 14:07:04 BMXPSv3 kernel: RSP: 0018:ffffb2c8c08cbd58 EFLAGS: 00000082
Feb 12 14:07:04 BMXPSv3 kernel: RAX: 00000000a5a5a5a2 RBX:
ffffb2c8c3ecd7a9 RCX: 0000000000000011
Feb 12 14:07:04 BMXPSv3 kernel: RDX: 0000000000400000 RSI:
ffffb2c8c09dc41c RDI: ffff8b251bb10018
Feb 12 14:07:04 BMXPSv3 kernel: RBP: ffff8b251bb10018 R08:
0000000000003a98 R09: 0000000000000011
Feb 12 14:07:04 BMXPSv3 kernel: R10: 0000000000000000 R11:
00000000000001bf R12: ffffb2c8c3f40169
Feb 12 14:07:04 BMXPSv3 kernel: R13: 0000000000400000 R14:
0000000000000006 R15: ffff8b2517cb2ca8
Feb 12 14:07:04 BMXPSv3 kernel: FS:  0000000000000000(0000)
GS:ffff8b252c280000(0000) knlGS:0000000000000000
Feb 12 14:07:04 BMXPSv3 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 12 14:07:04 BMXPSv3 kernel: CR2: 00007fcd1e9df000 CR3:
0000000126e0a005 CR4: 00000000003606e0
Feb 12 14:07:04 BMXPSv3 kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Feb 12 14:07:04 BMXPSv3 kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Feb 12 14:07:04 BMXPSv3 kernel: Call Trace:
Feb 12 14:07:04 BMXPSv3 kernel:  iwl_trans_pcie_read_mem+0x71/0xc0 [iwlwifi]
Feb 12 14:07:04 BMXPSv3 kernel:  iwl_fw_dump_mem.isra.0.part.0+0x42/0x60
[iwlwifi]
Feb 12 14:07:04 BMXPSv3 kernel:  iwl_fw_dbg_collect_sync+0x592/0x1970
[iwlwifi]
Feb 12 14:07:04 BMXPSv3 kernel:  ? __switch_to+0x80/0x3e0
Feb 12 14:07:04 BMXPSv3 kernel:  iwl_fw_error_dump_wk+0x53/0x80 [iwlwifi]
Feb 12 14:07:04 BMXPSv3 kernel:  process_one_work+0x1b4/0x370
Feb 12 14:07:04 BMXPSv3 kernel:  worker_thread+0x50/0x3c0
Feb 12 14:07:04 BMXPSv3 kernel:  kthread+0xf9/0x130
Feb 12 14:07:04 BMXPSv3 kernel:  ? process_one_work+0x370/0x370
Feb 12 14:07:04 BMXPSv3 kernel:  ? kthread_park+0x90/0x90
Feb 12 14:07:04 BMXPSv3 kernel:  ret_from_fork+0x35/0x40
Feb 12 14:07:06 BMXPSv3 kernel: rcu: INFO: rcu_sched detected expedited
stalls on CPUs/tasks: { 10-... } 5455 jiffies s: 6409 root: 0x400/.
Feb 12 14:07:06 BMXPSv3 kernel: rcu: blocking rcu_node structures:
Feb 12 14:07:06 BMXPSv3 kernel: Task dump for CPU 10:
Feb 12 14:07:06 BMXPSv3 kernel: kworker/10:2    R  running task        0
  621      2 0x80004008
Feb 12 14:07:06 BMXPSv3 kernel: Workqueue: events iwl_fw_error_dump_wk
[iwlwifi]
Feb 12 14:07:06 BMXPSv3 kernel: Call Trace:
Feb 12 14:07:06 BMXPSv3 kernel:  ? iwl_fw_error_dump_wk+0x53/0x80 [iwlwifi]
Feb 12 14:07:06 BMXPSv3 kernel:  ? process_one_work+0x1b4/0x370
Feb 12 14:07:06 BMXPSv3 kernel:  ? worker_thread+0x50/0x3c0
Feb 12 14:07:06 BMXPSv3 kernel:  ? kthread+0xf9/0x130
Feb 12 14:07:06 BMXPSv3 kernel:  ? process_one_work+0x370/0x370
Feb 12 14:07:06 BMXPSv3 kernel:  ? kthread_park+0x90/0x90
Feb 12 14:07:06 BMXPSv3 kernel:  ? ret_from_fork+0x35/0x40
Feb 12 14:07:12 BMXPSv3 kernel: clocksource: timekeeping watchdog on
CPU10: Marking clocksource 'tsc' as unstable because the skew is too large:
Feb 12 14:07:12 BMXPSv3 kernel: clocksource:
'acpi_pm' wd_now: 9c314c wd_last: 9fb334 mask: ffffff
Feb 12 14:07:12 BMXPSv3 kernel: clocksource:                       'tsc'
cs_now: d3ee912c6c cs_last: c52cc1a951 mask: ffffffffffffffff
Feb 12 14:07:12 BMXPSv3 kernel: tsc: Marking TSC unstable due to
clocksource watchdog
Feb 12 14:07:13 BMXPSv3 kernel: TSC found unstable after boot, most
likely due to broken BIOS. Use 'tsc=unstable'.
Feb 12 14:07:13 BMXPSv3 kernel: sched_clock: Marking unstable
(214600819047, -104627019)<-(214537658814, -22448794)
Feb 12 14:07:13 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Failing on timeout
while stopping DMA channel 8 [0xa5a5a5a2]
Feb 12 14:07:13 BMXPSv3 kernel: clocksource: Switched to clocksource acpi_pm
Feb 12 14:07:13 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Applying debug
destination EXTERNAL_DRAM
Feb 12 14:07:13 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: Applying debug
destination EXTERNAL_DRAM
Feb 12 14:07:13 BMXPSv3 kernel: iwlwifi 0000:3b:00.0: FW already
configured (0) - re-configuring
