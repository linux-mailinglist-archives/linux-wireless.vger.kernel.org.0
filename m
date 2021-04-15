Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300B53608E2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhDOMFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 08:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232276AbhDOMFS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 08:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618488295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5GzKOpk/VYyhi0tDElT89P5ldwyD0jEwAct65Jsrfw0=;
        b=c4qLhwofNI7y0YK64c55KxClrPb6ylGu8RqNiQJ/YXmVmJL0C4arMRV46obcL7e10LySzN
        louyFJVn1Bhq5SCRUDfk+yeiJl3glsn/+ceI1sa9WV8wspe8C591X31OQQ5eJEsdw7qXY+
        0bK9MaUwq9tBUyQQQDGsYBM1xoWqAYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-i6eIvzQ0PYWC0DvgvACGLw-1; Thu, 15 Apr 2021 08:04:51 -0400
X-MC-Unique: i6eIvzQ0PYWC0DvgvACGLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E5541007B30;
        Thu, 15 Apr 2021 12:04:50 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-187.ams2.redhat.com [10.36.112.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A08DD6086F;
        Thu, 15 Apr 2021 12:04:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Chris Murphy <lists@colorremedies.com>
Subject: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()
Date:   Thu, 15 Apr 2021 14:04:47 +0200
Message-Id: <20210415120447.4424-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes the same locking problem fixed by commit 2800aadc18a6 ("iwlwifi:
Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()") but then for
the gen2 variant of enqueue_hcmd().

It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs
disabled (e.g. from LED core). We can't enable BHs in such a situation.

Turn the unconditional BH-enable/BH-disable code into
hardirq-disable/conditional-enable.

This fixes the warning below.

[   36.763543] WARNING: CPU: 6 PID: 1582 at kernel/softirq.c:178 __local_bh=
_enable_ip+0x97/0xd0
[   36.763550] Modules linked in: cmac bnep vfat fat snd_ctl_led snd_soc_sk=
l_hda_dsp snd_soc_hdac_hdmi snd_soc_dmic snd_hda_codec_hdmi snd_hda_codec_r=
ealtek snd_hda_codec_generic snd_sof_pci_intel_cnl snd_sof_intel_hda_common=
 soundwire_intel soundwire_generic_allocation soundwire_cadence snd_sof_int=
el_hda iTCO_wdt mei_wdt snd_sof_pci mei_hdcp intel_pmc_bxt iTCO_vendor_supp=
ort snd_sof snd_sof_xtensa_dsp snd_soc_skl intel_rapl_msr snd_soc_hdac_hda =
snd_hda_ext_core snd_soc_sst_ipc x86_pkg_temp_thermal snd_soc_sst_dsp snd_s=
oc_acpi_intel_match intel_powerclamp snd_soc_acpi coretemp snd_soc_core snd=
_compress ac97_bus cdc_ether kvm_intel usbnet snd_pcm_dmaengine r8152 snd_h=
da_intel mii snd_intel_dspcfg snd_usb_audio snd_intel_sdw_acpi snd_usbmidi_=
lib kvm snd_rawmidi snd_hda_codec irqbypass snd_hda_core snd_hwdep rapl int=
el_cstate snd_seq intel_uncore iwlmvm snd_seq_device pcspkr snd_pcm wmi_bmo=
f intel_wmi_thunderbolt e1000e mac80211 uvcvideo btusb i2c_i801 videobuf2_v=
malloc videobuf2_memops btrtl
[   36.763661]  snd_timer i2c_smbus videobuf2_v4l2 btbcm btintel libarc4 th=
underbolt videobuf2_common bluetooth videodev mei_me iwlwifi mei ecdh_gener=
ic mc ecc nxp_nci_i2c nxp_nci joydev processor_thermal_device ucsi_acpi nci=
 processor_thermal_rfim processor_thermal_mbox cfg80211 typec_ucsi processo=
r_thermal_rapl intel_pch_thermal intel_rapl_common idma64 intel_soc_dts_ios=
f typec nfc int3403_thermal int340x_thermal_zone soc_button_array intel_hid=
 sparse_keymap acpi_pad int3400_thermal acpi_thermal_rel binfmt_misc zram i=
p_tables dm_crypt trusted hid_logitech_hidpp hid_logitech_dj uas usb_storag=
e crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel i915 serio=
_raw nvme nvme_core i2c_algo_bit drm_kms_helper cec hid_multitouch drm wmi =
i2c_hid_acpi i2c_hid thinkpad_acpi ledtrig_audio platform_profile snd sound=
core rfkill drm_privacy_screen_helper video pinctrl_cannonlake i2c_dev fuse
[   36.763775] CPU: 6 PID: 1582 Comm: NetworkManager Not tainted 5.12.0-rc7=
+ #303
[   36.763778] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET24W (=
1.14 ) 10/15/2020
[   36.763780] RIP: 0010:__local_bh_enable_ip+0x97/0xd0
[   36.763783] Code: f3 48 a9 00 ff ff 00 74 36 65 ff 0d b3 02 f3 48 e8 de =
ee 12 00 fb 66 0f 1f 44 00 00 5b 5d c3 65 8b 05 d9 0a f3 48 85 c0 75 9c <0f=
> 0b eb 98 e8 00 ee 12 00 eb a7 48 89 ef e8 16 14 07 00 eb b0 65
[   36.763786] RSP: 0018:ffffbc2e016b72d0 EFLAGS: 00010046
[   36.763790] RAX: 0000000000000000 RBX: 0000000000000201 RCX: 00000000000=
00000
[   36.763792] RDX: 0000000000000003 RSI: 0000000000000201 RDI: ffffffffc0a=
8527b
[   36.763794] RBP: ffffffffc0a8527b R08: 0000000000000000 R09: 00000000000=
00001
[   36.763796] R10: ffffbc2e016b71c0 R11: 0000000000000001 R12: ffffa0570c9=
02c10
[   36.763798] R13: 0000000000000000 R14: 0000000080000000 R15: 00000000000=
00000
[   36.763801] FS:  00007f44b889bbc0(0000) GS:ffffa05a5a580000(0000) knlGS:=
0000000000000000
[   36.763803] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.763805] CR2: 00007fde6d88b8f0 CR3: 0000000142b08005 CR4: 00000000003=
706e0
[   36.763808] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   36.763810] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   36.763812] Call Trace:
[   36.763815]  iwl_pcie_gen2_enqueue_hcmd+0x56b/0x8c0 [iwlwifi]
[   36.763848]  iwl_trans_txq_send_hcmd+0x59/0x440 [iwlwifi]
[   36.763872]  iwl_trans_send_cmd+0x81/0x180 [iwlwifi]
[   36.763890]  iwl_mvm_send_cmd+0x28/0x80 [iwlmvm]
[   36.763910]  iwl_mvm_led_set+0x9c/0xc0 [iwlmvm]
[   36.763933]  ? _raw_read_lock_irqsave+0x88/0xa0
[   36.763938]  led_trigger_event+0x46/0x70
[   36.763945]  ieee80211_do_open+0x4c2/0xa70 [mac80211]
[   36.764006]  ieee80211_open+0x69/0x90 [mac80211]
[   36.764057]  __dev_open+0xd4/0x1a0
[   36.764063]  __dev_change_flags+0x1c8/0x240
[   36.764072]  dev_change_flags+0x21/0x60
[   36.764077]  do_setlink+0x238/0x1110
[   36.764084]  ? cpumask_next+0x17/0x20
[   36.764087]  ? __snmp6_fill_stats64.constprop.0+0x53/0xe0
[   36.764093]  ? __nla_validate_parse+0x4f/0xbf0
[   36.764109]  __rtnl_newlink+0x601/0x9b0
[   36.764116]  ? __lock_acquire+0x389/0x1e10
[   36.764130]  ? lock_acquire+0xb5/0x380
[   36.764134]  ? sock_def_readable+0x5/0x2a0
[   36.764136]  ? lock_is_held_type+0xa5/0x120
[   36.764141]  ? find_held_lock+0x2b/0x80
[   36.764146]  ? sock_def_readable+0xb0/0x2a0
[   36.764148]  ? lock_release+0xba/0x2a0
[   36.764156]  ? netlink_unicast+0x1f7/0x230
[   36.764163]  ? rtnl_getlink+0x364/0x3e0
[   36.764207]  ? rcu_read_lock_sched_held+0x3f/0x80
[   36.764211]  ? kmem_cache_alloc_trace+0x29a/0x2c0
[   36.764220]  rtnl_newlink+0x44/0x70
[   36.764225]  rtnetlink_rcv_msg+0x16e/0x480
[   36.764229]  ? netlink_deliver_tap+0x95/0x3d0
[   36.764236]  ? rtnetlink_put_metrics+0x1c0/0x1c0
[   36.764241]  netlink_rcv_skb+0x50/0xf0
[   36.764251]  netlink_unicast+0x16d/0x230
[   36.764258]  netlink_sendmsg+0x24d/0x480
[   36.764270]  sock_sendmsg+0x5e/0x60
[   36.764274]  ____sys_sendmsg+0x22f/0x270
[   36.764278]  ? import_iovec+0x17/0x20
[   36.764282]  ? sendmsg_copy_msghdr+0x59/0x90
[   36.764290]  ___sys_sendmsg+0x81/0xc0
[   36.764303]  ? lock_is_held_type+0xa5/0x120
[   36.764307]  ? find_held_lock+0x2b/0x80
[   36.764313]  ? __fget_files+0xd0/0x1a0
[   36.764316]  ? lock_release+0xba/0x2a0
[   36.764324]  ? __fget_files+0xef/0x1a0
[   36.764333]  __sys_sendmsg+0x49/0x80
[   36.764342]  ? syscall_enter_from_user_mode+0x27/0x80
[   36.764348]  do_syscall_64+0x33/0x40
[   36.764352]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   36.764355] RIP: 0033:0x7f44b99876fd
[   36.764359] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 fa ee ff =
ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 4e ef ff ff 48
[   36.764361] RSP: 002b:00007ffca4a55940 EFLAGS: 00000293 ORIG_RAX: 000000=
000000002e
[   36.764365] RAX: ffffffffffffffda RBX: 0000000000000014 RCX: 00007f44b99=
876fd
[   36.764368] RDX: 0000000000000000 RSI: 00007ffca4a55980 RDI: 00000000000=
0000c
[   36.764370] RBP: 0000560f3b81d030 R08: 0000000000000000 R09: 00000000000=
00000
[   36.764372] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000=
00000
[   36.764374] R13: 00007ffca4a55ae0 R14: 00007ffca4a55adc R15: 00000000000=
00000
[   36.764390] irq event stamp: 246365
[   36.764391] hardirqs last  enabled at (246363): [<ffffffffb70e7b12>] __l=
ocal_bh_enable_ip+0x82/0xd0
[   36.764395] hardirqs last disabled at (246364): [<ffffffffb7d111c4>] _ra=
w_read_lock_irqsave+0x94/0xa0
[   36.764398] softirqs last  enabled at (246362): [<ffffffffc0a8527b>] iwl=
_pcie_gen2_enqueue_hcmd+0x56b/0x8c0 [iwlwifi]
[   36.764414] softirqs last disabled at (246365): [<ffffffffc0a84dfb>] iwl=
_pcie_gen2_enqueue_hcmd+0xeb/0x8c0 [iwlwifi]

Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Chris Murphy <lists@colorremedies.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/ne=
t/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 4456abb9a074..34bde8c87324 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -40,6 +40,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 	const u8 *cmddata[IWL_MAX_CMD_TBS_PER_TFD];
 	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];
 	struct iwl_tfh_tfd *tfd;
+	unsigned long flags;
=20
 	copy_size =3D sizeof(struct iwl_cmd_header_wide);
 	cmd_size =3D sizeof(struct iwl_cmd_header_wide);
@@ -108,14 +109,14 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *tran=
s,
 		goto free_dup_buf;
 	}
=20
-	spin_lock_bh(&txq->lock);
+	spin_lock_irqsave(&txq->lock, flags);
=20
 	idx =3D iwl_txq_get_cmd_index(txq, txq->write_ptr);
 	tfd =3D iwl_txq_get_tfd(trans, txq, txq->write_ptr);
 	memset(tfd, 0, sizeof(*tfd));
=20
 	if (iwl_txq_space(trans, txq) < ((cmd->flags & CMD_ASYNC) ? 2 : 1)) {
-		spin_unlock_bh(&txq->lock);
+		spin_unlock_irqrestore(&txq->lock, flags);
=20
 		IWL_ERR(trans, "No space in command queue\n");
 		iwl_op_mode_cmd_queue_full(trans->op_mode);
@@ -250,7 +251,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 	spin_unlock(&trans_pcie->reg_lock);
=20
 out:
-	spin_unlock_bh(&txq->lock);
+	spin_unlock_irqrestore(&txq->lock, flags);
 free_dup_buf:
 	if (idx < 0)
 		kfree(dup_buf);
--=20
2.31.1

