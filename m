Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D95439B25
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 18:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhJYQG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 12:06:26 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:52579 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhJYQGZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 12:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635177844; x=1666713844;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=pJT5c83KDeRLLFfz0Qz0svZYTZQIRxLG7zjBLv4uO64=;
  b=JQnUI3jIvBrEHuDd/7+oMkYVvDxwOJXpIr5rBArUNMJu0cpx3/Rba2CY
   jt6zCb29l5gUYIBuE/bk0H+CUmlv4bUzdRlIRyC/xR5/sIFNQQAAj5hpw
   PvMBwu8GZViyHkeCccykgJVFOv81zDVc2hoH7wh50I22XKD49qQACmhNa
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 09:04:03 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 09:04:03 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 09:04:01 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: [PATCH] ath11k: Clear auth flag only for actual association in security mode
Date:   Mon, 25 Oct 2021 21:33:06 +0530
Message-ID: <1635177786-20854-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AUTH flag is needed when peer assoc command is sent from host in
security mode for non-assoc cases. Firmware will handle AUTH flag
when client is associating as AUTH flag will be set after key exchange.
For internally provided peer assoc commands from host, there won't be
any key exchange, so AUTH flag is expected to be set in host.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Co-developed-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 +++
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 drivers/net/wireless/ath/ath11k/wmi.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1cc5560..3ae5193 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2418,6 +2418,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 
 	rcu_read_unlock();
 
+	peer_arg.is_assoc = true;
 	ret = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
@@ -3685,6 +3686,7 @@ static int ath11k_station_assoc(struct ath11k *ar,
 
 	ath11k_peer_assoc_prepare(ar, vif, sta, &peer_arg, reassoc);
 
+	peer_arg.is_assoc = true;
 	ret = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
@@ -3896,6 +3898,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 			ath11k_peer_assoc_prepare(ar, arvif->vif, sta,
 						  &peer_arg, true);
 
+			peer_arg.is_assoc = false;
 			err = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 			if (err)
 				ath11k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5ae2ef4..2c940ed 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1762,7 +1762,7 @@ ath11k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 		cmd->peer_flags |= WMI_PEER_AUTH;
 	if (param->need_ptk_4_way) {
 		cmd->peer_flags |= WMI_PEER_NEED_PTK_4_WAY;
-		if (!hw_crypto_disabled)
+		if (!hw_crypto_disabled && param->is_assoc)
 			cmd->peer_flags &= ~WMI_PEER_AUTH;
 	}
 	if (param->need_gtk_2_way)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0584e68..f395937 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3617,6 +3617,7 @@ struct peer_assoc_params {
 	u32 peer_he_tx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];
 	bool twt_responder;
 	bool twt_requester;
+	bool is_assoc;
 	struct ath11k_ppe_threshold peer_ppet;
 };
 
-- 
2.7.4

