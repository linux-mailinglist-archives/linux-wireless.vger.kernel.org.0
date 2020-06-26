Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7320B8B4
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 20:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgFZSyN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 14:54:13 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:45294 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgFZSyM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 14:54:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593197651; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=rSs+ouLYYDVpbn6T9dkhsaPEslLkHE3W4vsy8p+seok=; b=DeaVT61jQxo8a7abhbfsAVNFne8QZ9/LzrM4CIhSCy/IRz5T6B2VWjodAXjCGzCF6sdAE5/u
 i36pRDQl6r8ZVgbhPhtuzNE8tDfz0xKZZzB5oXQPJMcCG5BhIMZJN1dYIc4tKWvGyz+kQGvN
 fVEkqbIm1UdjgrQCPd3g7RrDJ4o=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ef6444c4c9690533a7881cb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 18:54:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A111C433CA; Fri, 26 Jun 2020 18:54:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3818EC433C8;
        Fri, 26 Jun 2020 18:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3818EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v2 2/2] ath10k: Skip wait for delete response if firmware is down
Date:   Sat, 27 Jun 2020 00:23:53 +0530
Message-Id: <1593197633-9014-3-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593197633-9014-1-git-send-email-pillair@codeaurora.org>
References: <1593197633-9014-1-git-send-email-pillair@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently the driver waits for response from the
firmware for all the delete cmds, eg: vdev_delete,
peer delete. If the firmware is down, these wait
will always timeout and return an error.

Also during subsytems recovery, any attempt to
send a WMI cmd to the FW will return the -ESHUTDOWN
status, which when returned to mac80211, can cause
unnecessary warnings to be printed on to the console,
as shown below

[ 2559.529565] Call trace:
[ 2559.532214]  __sta_info_destroy_part2+0x160/0x168 [mac80211]
[ 2559.538157]  __sta_info_flush+0x124/0x180 [mac80211]
[ 2559.543402]  ieee80211_set_disassoc+0x130/0x2c0 [mac80211]
[ 2559.549172]  ieee80211_mgd_deauth+0x238/0x25c [mac80211]
[ 2559.554764]  ieee80211_deauth+0x24/0x30 [mac80211]
[ 2559.559860]  cfg80211_mlme_deauth+0x258/0x2b0 [cfg80211]
[ 2559.565446]  nl80211_deauthenticate+0xe4/0x110 [cfg80211]
[ 2559.571064]  genl_rcv_msg+0x3a0/0x440
[ 2559.574888]  netlink_rcv_skb+0xb4/0x11c
[ 2559.578877]  genl_rcv+0x34/0x48
[ 2559.582162]  netlink_unicast+0x14c/0x1e4
[ 2559.586235]  netlink_sendmsg+0x2f0/0x360
[ 2559.590317]  sock_sendmsg+0x44/0x5c
[ 2559.593951]  ____sys_sendmsg+0x1c8/0x290
[ 2559.598029]  ___sys_sendmsg+0xa8/0xfc
[ 2559.601840]  __sys_sendmsg+0x8c/0xd0
[ 2559.605572]  __arm64_compat_sys_sendmsg+0x2c/0x38
[ 2559.610468]  el0_svc_common+0xa8/0x160
[ 2559.614372]  el0_svc_compat_handler+0x2c/0x38
[ 2559.618905]  el0_svc_compat+0x8/0x10

Skip the wait for delete response from the
firmware if the firmware is down. Also return
success to the mac80211 calls when the peer delete
cmd fails with return status -ESHUTDOWN.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index dc7befc..6882fcc 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -701,7 +701,8 @@ static void ath10k_wait_for_peer_delete_done(struct ath10k *ar, u32 vdev_id,
 	unsigned long time_left;
 	int ret;
 
-	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map)) {
+	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map) &&
+	    !test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)) {
 		ret = ath10k_wait_for_peer_deleted(ar, vdev_id, addr);
 		if (ret) {
 			ath10k_warn(ar, "failed wait for peer deleted");
@@ -841,7 +842,8 @@ static int ath10k_peer_delete(struct ath10k *ar, u32 vdev_id, const u8 *addr)
 	if (ret)
 		return ret;
 
-	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map)) {
+	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map) &&
+	    !test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)) {
 		unsigned long time_left;
 
 		time_left = wait_for_completion_timeout
@@ -5673,7 +5675,8 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
 		ath10k_warn(ar, "failed to delete WMI vdev %i: %d\n",
 			    arvif->vdev_id, ret);
 
-	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map)) {
+	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map) &&
+	    !test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)) {
 		time_left = wait_for_completion_timeout(&ar->vdev_delete_done,
 							ATH10K_VDEV_DELETE_TIMEOUT_HZ);
 		if (time_left == 0) {
@@ -6110,6 +6113,11 @@ static int ath10k_hw_scan(struct ieee80211_hw *hw,
 		goto exit;
 	}
 
+	if (test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)) {
+		ret = -ESHUTDOWN;
+		goto exit;
+	}
+
 	spin_lock_bh(&ar->data_lock);
 	switch (ar->scan.state) {
 	case ATH10K_SCAN_IDLE:
@@ -6758,7 +6766,9 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		}
 
 		ret = ath10k_peer_delete(ar, arvif->vdev_id, sta->addr);
-		if (ret)
+		if (ret == -ESHUTDOWN)
+			ret = 0;
+		else if (ret)
 			ath10k_warn(ar, "failed to delete peer %pM for vdev %d: %i\n",
 				    sta->addr, arvif->vdev_id, ret);
 
-- 
2.7.4

