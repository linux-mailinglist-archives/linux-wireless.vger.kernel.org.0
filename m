Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A874CF7A7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiCGJrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 04:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbiCGJpq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 04:45:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE3673DD;
        Mon,  7 Mar 2022 01:42:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CA5DB810B2;
        Mon,  7 Mar 2022 09:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C686C340E9;
        Mon,  7 Mar 2022 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646646121;
        bh=Qv3CsfTqHITeNsEUEDuHNtUcskJy/YkGKsJ6nmZsq8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0u7/ifEPGJJfeNUagnXroGYmSyHr0XDQp1zN9FFy6/RhImIl8mEjY8982eiNRP+N
         4IL0bo9J2YBxQyHU31guV/1ph0J9yZ9L1kLvx5aT52L8BYNnDjZB4MaXEcqJx0gBRO
         iVqnBN2IsaZY/TrGmrlabAO8s0kdDttUDpYhZAWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.15 141/262] iwlwifi: mvm: check debugfs_dir ptr before use
Date:   Mon,  7 Mar 2022 10:18:05 +0100
Message-Id: <20220307091706.428077733@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307091702.378509770@linuxfoundation.org>
References: <20220307091702.378509770@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

commit 5a6248c0a22352f09ea041665d3bd3e18f6f872c upstream.

When "debugfs=off" is used on the kernel command line, iwiwifi's
mvm module uses an invalid/unchecked debugfs_dir pointer and causes
a BUG:

 BUG: kernel NULL pointer dereference, address: 000000000000004f
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP
 CPU: 1 PID: 503 Comm: modprobe Tainted: G        W         5.17.0-rc5 #7
 Hardware name: Dell Inc. Inspiron 15 5510/076F7Y, BIOS 2.4.1 11/05/2021
 RIP: 0010:iwl_mvm_dbgfs_register+0x692/0x700 [iwlmvm]
 Code: 69 a0 be 80 01 00 00 48 c7 c7 50 73 6a a0 e8 95 cf ee e0 48 8b 83 b0 1e 00 00 48 c7 c2 54 73 6a a0 be 64 00 00 00 48 8d 7d 8c <48> 8b 48 50 e8 15 22 07 e1 48 8b 43 28 48 8d 55 8c 48 c7 c7 5f 73
 RSP: 0018:ffffc90000a0ba68 EFLAGS: 00010246
 RAX: ffffffffffffffff RBX: ffff88817d6e3328 RCX: ffff88817d6e3328
 RDX: ffffffffa06a7354 RSI: 0000000000000064 RDI: ffffc90000a0ba6c
 RBP: ffffc90000a0bae0 R08: ffffffff824e4880 R09: ffffffffa069d620
 R10: ffffc90000a0ba00 R11: ffffffffffffffff R12: 0000000000000000
 R13: ffffc90000a0bb28 R14: ffff88817d6e3328 R15: ffff88817d6e3320
 FS:  00007f64dd92d740(0000) GS:ffff88847f640000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000004f CR3: 000000016fc79001 CR4: 0000000000770ee0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? iwl_mvm_mac_setup_register+0xbdc/0xda0 [iwlmvm]
  iwl_mvm_start_post_nvm+0x71/0x100 [iwlmvm]
  iwl_op_mode_mvm_start+0xab8/0xb30 [iwlmvm]
  _iwl_op_mode_start+0x6f/0xd0 [iwlwifi]
  iwl_opmode_register+0x6a/0xe0 [iwlwifi]
  ? 0xffffffffa0231000
  iwl_mvm_init+0x35/0x1000 [iwlmvm]
  ? 0xffffffffa0231000
  do_one_initcall+0x5a/0x1b0
  ? kmem_cache_alloc+0x1e5/0x2f0
  ? do_init_module+0x1e/0x220
  do_init_module+0x48/0x220
  load_module+0x2602/0x2bc0
  ? __kernel_read+0x145/0x2e0
  ? kernel_read_file+0x229/0x290
  __do_sys_finit_module+0xc5/0x130
  ? __do_sys_finit_module+0xc5/0x130
  __x64_sys_finit_module+0x13/0x20
  do_syscall_64+0x38/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f64dda564dd
 Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1b 29 0f 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffdba393f88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f64dda564dd
 RDX: 0000000000000000 RSI: 00005575399e2ab2 RDI: 0000000000000001
 RBP: 000055753a91c5e0 R08: 0000000000000000 R09: 0000000000000002
 R10: 0000000000000001 R11: 0000000000000246 R12: 00005575399e2ab2
 R13: 000055753a91ceb0 R14: 0000000000000000 R15: 000055753a923018
  </TASK>
 Modules linked in: btintel(+) btmtk bluetooth vfat snd_hda_codec_hdmi fat snd_hda_codec_realtek snd_hda_codec_generic iwlmvm(+) snd_sof_pci_intel_tgl mac80211 snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation soundwire_cadence soundwire_bus snd_sof_intel_hda snd_sof_pci snd_sof snd_sof_xtensa_dsp snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core btrfs snd_compress snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec raid6_pq iwlwifi snd_hda_core snd_pcm snd_timer snd soundcore cfg80211 intel_ish_ipc(+) thunderbolt rfkill intel_ishtp ucsi_acpi wmi i2c_hid_acpi i2c_hid evdev
 CR2: 000000000000004f
 ---[ end trace 0000000000000000 ]---

Check the debugfs_dir pointer for an error before using it.

Fixes: 8c082a99edb9 ("iwlwifi: mvm: simplify iwl_mvm_dbgfs_register")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20220223030630.23241-1-rdunlap@infradead.org
[change to make both conditional]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #include <linux/vmalloc.h>
+#include <linux/err.h>
 #include <linux/ieee80211.h>
 #include <linux/netdevice.h>
 
@@ -2044,7 +2045,6 @@ void iwl_mvm_sta_add_debugfs(struct ieee
 void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 {
 	struct dentry *bcast_dir __maybe_unused;
-	char buf[100];
 
 	spin_lock_init(&mvm->drv_stats_lock);
 
@@ -2140,6 +2140,11 @@ void iwl_mvm_dbgfs_register(struct iwl_m
 	 * Create a symlink with mac80211. It will be removed when mac80211
 	 * exists (before the opmode exists which removes the target.)
 	 */
-	snprintf(buf, 100, "../../%pd2", mvm->debugfs_dir->d_parent);
-	debugfs_create_symlink("iwlwifi", mvm->hw->wiphy->debugfsdir, buf);
+	if (!IS_ERR(mvm->debugfs_dir)) {
+		char buf[100];
+
+		snprintf(buf, 100, "../../%pd2", mvm->debugfs_dir->d_parent);
+		debugfs_create_symlink("iwlwifi", mvm->hw->wiphy->debugfsdir,
+				       buf);
+	}
 }


