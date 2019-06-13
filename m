Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDED344769
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392832AbfFMQ7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 12:59:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:59080 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbfFMASn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 20:18:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 17:18:42 -0700
X-ExtLoop1: 1
Received: from jprestwo-test.jf.intel.com ([10.54.74.49])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2019 17:18:42 -0700
Message-ID: <4eb4f622d2ee2aa79219fb256eb171379613a009.camel@linux.intel.com>
Subject: iwlwifi/brcmfmac public action frames crash
From:   James Prestwood <james.prestwood@linux.intel.com>
To:     linux-wireless@vger.kernel.org
Date:   Wed, 12 Jun 2019 17:18:27 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Both iwlwifi/brcmfmac seem to be unable to send public action frames to
an unassociated AP. I am attempting to do a GAS ANQP request with a
public action frame (via CMD_FRAME). Immediately after CMD_FRAME any of
the following happens depending on the card:

Intel 7260 (iwlwifi) - System lockup freeze (must hard reboot)
Intel 3160 (iwlwifi) - CMD_FRAME returns -EINVAL
BCM43602 (brcmfmac) - Kernel crash (below)
AR9462 (ath9k) - works
Random USB adapter (rt2800usb) - works

iwlwifi (on 7260) completely locks the system, where the only way to
recover is hard reboot. I have reproduced this on two separate systems,
both with a 7260. I *have* seen it not lock the system once although
lately it seems to happen every time. The 3160 did not cause a hang
with my limited testing, though it did not accept CMD_FRAME which is
likely why it never hung.

Not sure how I can get any more info about the iwlwifi problem as the
system is completely hung, but if there is a way I'll be happy to do
that.

Here is the brcmfmac crash:

[19735.643941] BUG: unable to handle kernel NULL pointer dereference at
0000000000000000
[19735.643965] PGD 80000001874aa067 P4D 80000001874aa067 PUD 2735fe067
PMD 0
[19735.643984] Oops: 0000 [#1] SMP PTI
[19735.643993] CPU: 7 PID: 5051 Comm: iwd Tainted: G        W
I       4.19.0-rc2-custom #27
[19735.644002] Hardware name: System manufacturer System Product
Name/SABERTOOTH X58, BIOS 1402    08/09/2012
[19735.644027] RIP: 0010:brcmf_p2p_send_action_frame+0x23a/0x850
[brcmfmac]
[19735.644037] Code: 41 c7 86 e0 00 00 00 00 00 00 00 f0 41 80 66 20 bf
f0 41 80 66 20 7f 49 8b 46 48 b9 24 07 00 00 48 89 da 48 c7 c6 3d 00 8f
c0 <48> 8b 38 e8 3e d7 ff ff 85 c0 41 89 c5 0f 85 c4 00 00 00 8b 03 49
[19735.644051] RSP: 0018:ffffa879c8477a00 EFLAGS: 00010246
[19735.644059] RAX: 0000000000000000 RBX: ffff954a2e059000 RCX:
0000000000000724
[19735.644067] RDX: ffff954a2e059000 RSI: ffffffffc08f003d RDI:
0000000000000002
[19735.644075] RBP: ffffa879c8477a50 R08: 000000000000001c R09:
0000000000000999
[19735.644083] R10: ffff954b157a2f00 R11: ffffffffc0720000 R12:
ffff954c32f26021
[19735.644091] R13: ffff954a2e059000 R14: ffff954c32f26000 R15:
00000000ffffffff
[19735.644099] FS:  00007f8d5aa30740(0000) GS:ffff954c369c0000(0000)
knlGS:0000000000000000
[19735.644108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19735.644115] CR2: 0000000000000000 CR3: 00000001845c8000 CR4:
00000000000006e0
[19735.644123] Call Trace:
[19735.644133]  ? _cond_resched+0x19/0x40
[19735.644153]  brcmf_cfg80211_mgmt_tx+0x170/0x2f0 [brcmfmac]
[19735.644192]  cfg80211_mlme_mgmt_tx+0x115/0x2f0 [cfg80211]
[19735.644219]  nl80211_tx_mgmt+0x24d/0x3d0 [cfg80211]
[19735.644228]  genl_family_rcv_msg+0x1fe/0x3f0
[19735.644237]  ? nlmon_xmit+0x2c/0x30
[19735.644246]  ? dev_hard_start_xmit+0xa8/0x210
[19735.644254]  genl_rcv_msg+0x4c/0x90
[19735.644261]  ? genl_family_rcv_msg+0x3f0/0x3f0
[19735.644268]  netlink_rcv_skb+0x54/0x130
[19735.644275]  genl_rcv+0x28/0x40
[19735.644281]  netlink_unicast+0x1ab/0x250
[19735.644288]  netlink_sendmsg+0x2d1/0x3d0
[19735.644297]  sock_sendmsg+0x3e/0x50
[19735.644304]  __sys_sendto+0x13f/0x180
[19735.644313]  ? do_epoll_wait+0xb0/0xc0
[19735.644321]  __x64_sys_sendto+0x28/0x30
[19735.644329]  do_syscall_64+0x5a/0x120
[19735.644336]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[19735.644344] RIP: 0033:0x7f8d5a352c4d
[19735.644350] Code: ff ff ff ff eb b6 0f 1f 80 00 00 00 00 48 8d 05 c1
dc 2c 00 41 89 ca 8b 00 85 c0 75 20 45 31 c9 45 31 c0 b8 2c 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 6b f3 c3 66 0f 1f 84 00 00 00 00 00 41 56 41
[19735.644365] RSP: 002b:00007ffc9a618048 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[19735.644374] RAX: ffffffffffffffda RBX: 00000000007077d0 RCX:
00007f8d5a352c4d
[19735.644382] RDX: 0000000000000068 RSI: 000000000072bc40 RDI:
0000000000000004
[19735.644390] RBP: 0000000000733510 R08: 0000000000000000 R09:
0000000000000000
[19735.644397] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffc9a618094
[19735.644405] R13: 00007ffc9a61809c R14: 0000000000000000 R15:
0000000000000000
[19735.644414] Modules linked in: ccm algif_aead snd_hda_codec_realtek
snd_hda_codec_generic snd_hda_codec_hdmi binfmt_misc arc4 nouveau
gpio_ich ath9k mxm_wmi ath9k_common video rt2800usb intel_powerclamp
snd_hda_intel ath9k_hw rt2x00usb iwlmvm rt2800lib snd_hda_codec
rt2x00lib ath snd_seq_midi snd_seq_midi_event coretemp ttm mac80211
snd_hda_core brcmfmac snd_hwdep snd_rawmidi iwlwifi intel_cstate
drm_kms_helper brcmutil snd_seq drm snd_pcm input_leds serio_raw
lpc_ich cfg80211 snd_seq_device i2c_algo_bit snd_timer fb_sys_fops
syscopyarea sysfillrect snd sysimgblt i5500_temp wmi asus_atk0110
soundcore mac_hid i7core_edac sch_fq_codel kvm_intel kvm vfio_pci
vfio_virqfd irqbypass vfio_iommu_type1 vfio pci_stub parport_pc ppdev
lp parport ip_tables x_tables autofs4 pata_acpi hid_generic usbhid hid
firewire_ohci
[19735.644521]  realtek psmouse firewire_core crc_itu_t r8169 i2c_i801
ahci libahci
[19735.644538] CR2: 0000000000000000
[19735.653612] ---[ end trace 30dbecd734da3b73 ]---
[19735.653641] RIP: 0010:brcmf_p2p_send_action_frame+0x23a/0x850
[brcmfmac]
[19735.653651] Code: 41 c7 86 e0 00 00 00 00 00 00 00 f0 41 80 66 20 bf
f0 41 80 66 20 7f 49 8b 46 48 b9 24 07 00 00 48 89 da 48 c7 c6 3d 00 8f
c0 <48> 8b 38 e8 3e d7 ff ff 85 c0 41 89 c5 0f 85 c4 00 00 00 8b 03 49
[19735.653659] RSP: 0018:ffffa879c8477a00 EFLAGS: 00010246
[19735.653672] RAX: 0000000000000000 RBX: ffff954a2e059000 RCX:
0000000000000724
[19735.653680] RDX: ffff954a2e059000 RSI: ffffffffc08f003d RDI:
0000000000000002
[19735.653688] RBP: ffffa879c8477a50 R08: 000000000000001c R09:
0000000000000999
[19735.653697] R10: ffff954b157a2f00 R11: ffffffffc0720000 R12:
ffff954c32f26021
[19735.653705] R13: ffff954a2e059000 R14: ffff954c32f26000 R15:
00000000ffffffff
[19735.653714] FS:  00007f8d5aa30740(0000) GS:ffff954c369c0000(0000)
knlGS:0000000000000000
[19735.653725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19735.653731] CR2: 0000000000000000 CR3: 00000001845c8000 CR4:
00000000000006e0

Thanks,
James

