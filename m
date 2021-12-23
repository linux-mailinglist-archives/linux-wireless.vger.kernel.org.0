Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C4047E190
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 11:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347757AbhLWKiF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 05:38:05 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40908 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347758AbhLWKiF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 05:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640255885; x=1671791885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QYRlgldjCKzZ8Ggxua9DjI69vJbVYjPEQ4lPwiop5SM=;
  b=oxEVzynl69P4jvQF7cXP2LrnMGtAlhyu9J8irct+KDmcZ1jFsbTiydWi
   MhwvmKhaXZEQY3ZB0GtE5JTBrfFkURMxDVDypyzxtn4PLZQcQGI/8mcMS
   MTLgtEezKzy8k1aN/9PxTCv8WtQwwUKkpLeI7SS6bq3qTdtjTk7qXPbP2
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Dec 2021 02:38:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 02:38:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 02:38:04 -0800
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 02:38:03 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Reconfigure hardware rate for WCN6855 after vdev is started
Date:   Thu, 23 Dec 2021 18:37:28 +0800
Message-ID: <20211223103728.85022-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is an issue that WCN6855 tries to connect to an AP using
a hardware rate of 1Mb/s , even though the AP has announced
expected rates as [24, 36, 48, 54] in Probe Response frame.

The reason is that WCN6855 firmware clears hardware rate info
of management frames when vdev starts and uses 1Mb/s as default.
To solve it, reconfigure the rate after vdev is started.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0103cfd0508d..18740cf2dc44 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -587,6 +587,7 @@ struct ath11k {
 #endif
 	bool dfs_block_radar_events;
 	struct ath11k_thermal thermal;
+	int hw_rate_code;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0050e2c84888..d1c51010e55a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2760,6 +2760,11 @@ static void ath11k_recalculate_mgmt_rate(struct ath11k *ar,
 	if (ret)
 		ath11k_warn(ar->ab, "failed to set mgmt tx rate %d\n", ret);
 
+	/* For WCN6855, firmware will clear this param when vdev starts, hence
+	 * cache it here so that we can reconfigure it once vdev starts.
+	 */
+	ar->hw_rate_code = hw_rate_code;
+
 	vdev_param = WMI_VDEV_PARAM_BEACON_RATE;
 	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, vdev_param,
 					    hw_rate_code);
@@ -6595,6 +6600,19 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 		return ret;
 	}
 
+	/* Reconfigure hardware rate code since it is cleared by firmware.
+	 */
+	if (ar->hw_rate_code > 0) {
+		u32 vdev_param = WMI_VDEV_PARAM_MGMT_RATE;
+
+		ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, vdev_param,
+						    ar->hw_rate_code);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set mgmt tx rate %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, 0, ar->mac_addr);
 		if (ret) {
-- 
2.25.1

