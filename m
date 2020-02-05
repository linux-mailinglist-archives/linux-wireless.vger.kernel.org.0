Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51C5152472
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 02:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBEBYF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 20:24:05 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:24882 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbgBEBYF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 20:24:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580865844; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0RYLqjb9oi5D3Mt5uUDS9TmjJKL6DXjoYPpbN1inX/U=; b=Ogr6jw6hvpNyQxcJHS68ABcjaGbgAV7roON1EGCtrwhpFincFIUpyjf9EOcMHKrnVmBNITVU
 BFbVmCFbon9B2n8viuGX6WmTQvHtK/0e7RCU1t+yOmrMQjdBc5Vb0dCDLREHd/gL1V4rnVLA
 wHR2TFEwZ42l2hN1oQo40zpJfBU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3a1930.7fa68d3f1490-smtp-out-n03;
 Wed, 05 Feb 2020 01:24:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 570D9C433CB; Wed,  5 Feb 2020 01:23:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTP284781-LIN.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F498C43383;
        Wed,  5 Feb 2020 01:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F498C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: fix warn-on in disassociation
Date:   Wed,  5 Feb 2020 06:53:48 +0530
Message-Id: <1580865828-31330-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In multi AP VAP scenario, when user bring down the interfaces. mac80211 mark
the interface down for the duplicated VAP and removed from the
local->interfaces list. ath11k_mac_get_arvif() is dependent on
ieee80211_iterate_active_interfaces_atomic() API to find the vdev id
in a given radio. In disassociation path, ath11k_mac_get_arvif() not
able to find the given vdev id since that VAP is removed from the
local->interfaces list. since sta_state callback throws error, mac80211 log
the below WARN_ON_ONCE message.

Fixed it by storing the allocated_vdev_map in each radio structure to maintain
the created vdev id bits. so that we can directly mask this against the given
vdev_id to find out the ar from the vdev_id.

WARN LOG:

WARNING: at net/mac80211/sta_info.c:1008
CPU: 2 PID: 2135 Comm: hostapd Not tainted #1
Hardware name: Qualcomm Technologies, Inc. IPQ807x/AP-HK01-C1 (DT)
task: ffffffc03a43d800 ti: ffffffc03a43d800 task.ti: ffffffc03a43d800
PC is at sta_set_sinfo+0x9dc/0xad4 [mac80211]
LR is at sta_set_sinfo+0x9cc/0xad4 [mac80211]
pc : [<ffffffbffce2a008>] lr : [<ffffffbffce29ff8>] pstate: 20000145
sp : ffffffc02cedb5f0
x29: ffffffc02cedb5f0 x28: ffffffc03a43d800
x27: 0000000000000014 x26: 0000000000000001
x25: ffffffc02cfc4000 x24: ffffffc036905508
x23: 0000000000000012 x22: ffffffc02cedb670
x21: ffffffc03bc64880 x20: ffffffc036904f80
x19: ffffffc02ae31000 x18: 00000000b019f3a1
x17: 0000000057f30331 x16: 00000000d8d1998e
x15: 0000000000000066 x14: 393a35383a36343a
x13: 6337203a6e6f6974 x12: 6174732065746169
x11: 636f737361736964 x10: 206f742064656c69
x9 : 6146203a31696669 x8 : 6337203a6e6f6974
x7 : 6174732065746169 x6 : ffffffc0008c33f6
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 0000000000000000 x2 : 00000000ffffff92
x1 : 0000000000000000 x0 : ffffffbffcea1091
---[ end trace 63c4b1c527345d5a ]---
Call trace:
[<ffffffbffce2a008>] sta_set_sinfo+0x9dc/0xad4 [mac80211]
[<ffffffbffce2a2c4>] __sta_info_flush+0xec/0x130 [mac80211]
[<ffffffbffce3dc48>] ieee80211_nan_func_match+0x1a34/0x23e4 [mac80211]
[<ffffffbffcde03e0>] __cfg80211_stop_ap+0x60/0xf0 [cfg80211]
[<ffffffbffcdb6d08>] __cfg80211_leave+0x110/0x150 [cfg80211]
[<ffffffbffcdb6d78>] cfg80211_leave+0x30/0x48 [cfg80211]
[<ffffffbffcdb6fbc>] cfg80211_init_wdev+0x22c/0x808 [cfg80211]
[<ffffffc0000afe28>] notifier_call_chain+0x50/0x84
[<ffffffc0000afefc>] raw_notifier_call_chain+0x14/0x1c
[<ffffffc0004ae94c>] call_netdevice_notifiers_info+0x5c/0x6c
[<ffffffc0004ae96c>] call_netdevice_notifiers+0x10/0x18
[<ffffffc0004aea80>] __dev_close_many+0x54/0xc0
[<ffffffc0004aeb50>] dev_close_many+0x64/0xdc
[<ffffffc0004b0b70>] rollback_registered_many+0x138/0x2f4
[<ffffffc0004b0d4c>] rollback_registered+0x20/0x34
[<ffffffc0004b34b4>] unregister_netdevice_queue+0x68/0xa8
[<ffffffbffce3870c>] ieee80211_if_remove+0x84/0xc0 [mac80211]
[<ffffffbffce3e588>] ieee80211_nan_func_match+0x2374/0x23e4 [mac80211]
[<ffffffbffcdc29e8>] cfg80211_wext_giwscan+0x1000/0x1140 [cfg80211]
[<ffffffbffcb2a87c>] backport_genlmsg_multicast_allns+0x158/0x1b4 [compat]
[<ffffffc0004e0944>] genl_family_rcv_msg+0x258/0x2c0
[<ffffffc0004e09f4>] genl_rcv_msg+0x48/0x6c
[<ffffffc0004dfb50>] netlink_rcv_skb+0x5c/0xc4
[<ffffffc0004e06d8>] genl_rcv+0x34/0x48
[<ffffffc0004df570>] netlink_unicast+0x12c/0x1e0
[<ffffffc0004df9a4>] netlink_sendmsg+0x2bc/0x2dc
[<ffffffc00049a540>] sock_sendmsg+0x18/0x2c
[<ffffffc00049ab94>] ___sys_sendmsg+0x1bc/0x248
[<ffffffc00049ba24>] __sys_sendmsg+0x40/0x68
[<ffffffc00049ba5c>] SyS_sendmsg+0x10/0x20
[<ffffffc000085db0>] el0_svc_naked+0x24/0x28

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 18 +++++++++++-------
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 9e82305..6a30601 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -607,6 +607,7 @@ void ath11k_core_halt(struct ath11k *ar)
 	lockdep_assert_held(&ar->conf_mutex);
 
 	ar->num_created_vdevs = 0;
+	ar->allocated_vdev_map = 0;
 
 	ath11k_mac_scan_finish(ar);
 	ath11k_mac_peer_cleanup_all(ar);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 25cdcf7..987f62b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -486,6 +486,7 @@ struct ath11k {
 	int max_num_peers;
 	u32 num_started_vdevs;
 	u32 num_created_vdevs;
+	unsigned long long allocated_vdev_map;
 
 	struct idr txmgmt_idr;
 	/* protects txmgmt_idr data */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6640662..78f20ba 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -369,8 +369,10 @@ struct ath11k_vif *ath11k_mac_get_arvif(struct ath11k *ar, u32 vdev_id)
 						   flags,
 						   ath11k_get_arvif_iter,
 						   &arvif_iter);
-	if (!arvif_iter.arvif)
+	if (!arvif_iter.arvif) {
+		ath11k_warn(ar->ab, "No VIF found for vdev %d\n", vdev_id);
 		return NULL;
+	}
 
 	return arvif_iter.arvif;
 }
@@ -398,14 +400,12 @@ struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id)
 {
 	int i;
 	struct ath11k_pdev *pdev;
-	struct ath11k_vif *arvif;
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = rcu_dereference(ab->pdevs_active[i]);
 		if (pdev && pdev->ar) {
-			arvif = ath11k_mac_get_arvif(pdev->ar, vdev_id);
-			if (arvif)
-				return arvif->ar;
+			if (pdev->ar->allocated_vdev_map & (1LL << vdev_id))
+				return pdev->ar;
 		}
 	}
 
@@ -3874,6 +3874,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	ar->num_started_vdevs = 0;
 	ar->num_created_vdevs = 0;
 	ar->num_peers = 0;
+	ar->allocated_vdev_map = 0;
 
 	/* Configure monitor status ring with default rx_filter to get rx status
 	 * such as rssi, rx_duration.
@@ -4112,8 +4113,9 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ar->num_created_vdevs++;
-
+	ar->allocated_vdev_map |= 1LL << arvif->vdev_id;
 	ab->free_vdev_map &= ~(1LL << arvif->vdev_id);
+
 	spin_lock_bh(&ar->data_lock);
 	list_add(&arvif->list, &ar->arvifs);
 	spin_unlock_bh(&ar->data_lock);
@@ -4227,6 +4229,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 err_vdev_del:
 	ath11k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
+	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_map |= 1LL << arvif->vdev_id;
 	spin_lock_bh(&ar->data_lock);
 	list_del(&arvif->list);
@@ -4263,7 +4266,6 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "mac remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
-	ab->free_vdev_map |= 1LL << (arvif->vdev_id);
 	spin_lock_bh(&ar->data_lock);
 	list_del(&arvif->list);
 	spin_unlock_bh(&ar->data_lock);
@@ -4281,6 +4283,8 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 
 	ar->num_created_vdevs--;
+	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
+	ab->free_vdev_map |= 1LL << (arvif->vdev_id);
 
 	ath11k_peer_cleanup(ar, arvif->vdev_id);
 
-- 
1.9.1
