Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019DB3D18F6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGUUkh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59079 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhGUUkh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902473; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IOzVKTra53k3y9fOG1lZymHWkL1mjhNTc3RzAyYv2XY=; b=LXEIZ30AE8t72W9gnZ7JselpR37qdtys9LEGWgkqGBZge56/JduupGcWYhE760e18ZuAOxAc
 3Fl2oN9dI5QL8Chx+FmtkJ28Dgev/BYVtGiVz6mFghLQIehe6iiSD+3mxJhMzzf278wEpmvT
 U0qFGTDyzFWdVUp32XZ+85dQf6A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60f88fbb1dd16c8788c379c4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:20:59
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54BEDC43146; Wed, 21 Jul 2021 21:20:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EC74C4338A;
        Wed, 21 Jul 2021 21:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EC74C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 07/12] ath11k: Fix crash during firmware recovery on reo cmd ring access
Date:   Thu, 22 Jul 2021 00:20:24 +0300
Message-Id: <20210721212029.142388-7-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <srirrama@codeaurora.org>

In scenario when a peer is disassociating, there could be
multiple places where a reo cmd ring is accessed, such as
during aggregation teardown, tid queue cleanup, etc.

When this happens during firmware recovery where accessing of FW/HW
resources/registers is not recommended, accessing reo cmd ring in
this case could lead to crash or undefined behaviour.

Hence avoid this by checking for corresponding flag to avoid
accessing reo cmd ring during firmware recovery.

Sample crash:

[ 3936.456050] Unhandled fault: imprecise external abort (0x1c06) at 0x54bb842a
[ 3936.456411] WARN: Access Violation!!!, Run "cat /sys/kernel/debug/qcom_debug_logs/tz_log" for more details
[ 3936.467997] pgd = b4474000
[ 3936.477440] [54bb842a] *pgd=6fa61831, *pte=7f95d59f, *ppte=7f95de7e
<snip>
[ 3937.177436] [<8030ab10>] (_raw_spin_unlock_bh) from [<7f5e9eb8>] (ath11k_hal_reo_cmd_send+0x440/0x458 [ath11k])
[ 3937.185730] [<7f5e9eb8>] (ath11k_hal_reo_cmd_send [ath11k]) from [<7f601c4c>] (ath11k_dp_tx_send_reo_cmd+0x2c/0xcc [ath11k])
[ 3937.195524] [<7f601c4c>] (ath11k_dp_tx_send_reo_cmd [ath11k]) from [<7f602f10>] (ath11k_peer_rx_tid_reo_update+0x84/0xbc [ath11k])
[ 3937.206984] [<7f602f10>] (ath11k_peer_rx_tid_reo_update [ath11k]) from [<7f605a9c>] (ath11k_dp_rx_ampdu_stop+0xa8/0x130 [ath11k])
[ 3937.218532] [<7f605a9c>] (ath11k_dp_rx_ampdu_stop [ath11k]) from [<7f5f6730>] (ath11k_mac_op_ampdu_action+0x6c/0x98 [ath11k])
[ 3937.230250] [<7f5f6730>] (ath11k_mac_op_ampdu_action [ath11k]) from [<c7b6e890>] (___ieee80211_stop_rx_ba_session+0x98/0x144 [mac80211])
[ 3937.241499] [<c7b6e890>] (___ieee80211_stop_rx_ba_session [mac80211]) from [<c7b6cdd8>] (ieee80211_sta_tear_down_BA_sessions+0x4c/0xf4 [)
[ 3937.253833] [<c7b6cdd8>] (ieee80211_sta_tear_down_BA_sessions [mac80211]) from [<c7b63460>] (ieee80211_sta_eosp+0x5b8/0x960 [mac80211])
[ 3937.266764] [<c7b63460>] (ieee80211_sta_eosp [mac80211]) from [<c7b66da8>] (__sta_info_flush+0x9c/0x134 [mac80211])
[ 3937.278826] [<c7b66da8>] (__sta_info_flush [mac80211]) from [<c7b7bd00>] (ieee80211_stop_ap+0x14c/0x28c [mac80211])
[ 3937.289240] [<c7b7bd00>] (ieee80211_stop_ap [mac80211]) from [<7f509cf0>] (__cfg80211_stop_ap+0x4c/0xd8 [cfg80211])
[ 3937.299629] [<7f509cf0>] (__cfg80211_stop_ap [cfg80211]) from [<7f4dddec>] (cfg80211_leave+0x24/0x30 [cfg80211])
[ 3937.310041] [<7f4dddec>] (cfg80211_leave [cfg80211]) from [<7f4de03c>] (cfg80211_netdev_notifier_call+0x174/0x48c [cfg80211])
[ 3937.320457] [<7f4de03c>] (cfg80211_netdev_notifier_call [cfg80211]) from [<80339928>] (notifier_call_chain+0x40/0x68)
[ 3937.331636] [<80339928>] (notifier_call_chain) from [<803399a8>] (raw_notifier_call_chain+0x14/0x1c)
[ 3937.342221] [<803399a8>] (raw_notifier_call_chain) from [<8073bb00>] (call_netdevice_notifiers+0xc/0x14)

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01240-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 2f21e3378ae1..b00e78de36bc 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -622,6 +622,9 @@ int ath11k_dp_tx_send_reo_cmd(struct ath11k_base *ab, struct dp_rx_tid *rx_tid,
 	struct hal_srng *cmd_ring;
 	int cmd_num;
 
+	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
+		return -ESHUTDOWN;
+
 	cmd_ring = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
 	cmd_num = ath11k_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
 
-- 
2.25.1

