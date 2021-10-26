Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157443AACF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 05:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJZDot (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 23:44:49 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:1740 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhJZDos (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 23:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635219746; x=1666755746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tgjIXkcJNIgcCKFxZBM8JWNb2fyc5Xq+lQuSFXBsnmA=;
  b=tICUEALXfhzfcvr/yo3INTTmd6d/BsUly3h0YnejiEs5UenE2aCLVEFP
   lQ68seugNs0N5kBDf4oQbQ8vQ3mZI5qQJtOpb2QfvwpS+smsxvh2LE8KT
   WP1WhgzGvdnf/zitFHMQ2xRYCRy2ghkQu/3TWiikeyiyuv1AIiCPUnAzL
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 20:42:26 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 20:42:25 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 20:42:23 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: calculate the correct NSS of peer for HE capabilities
Date:   Mon, 25 Oct 2021 23:42:11 -0400
Message-ID: <20211026034211.27650-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When connected to 6G mode AP, it does not have VHT/HT capabilities,
so the NSS is not set, then it is 1 by default.

This patch is to calculate the NSS with supported HE-MCS and NSS set
of HE capabilities.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01280-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 40 +++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2fc5a1b29d34..212c73fedec4 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1458,13 +1458,49 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 				   struct peer_assoc_params *arg)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
-	u8 ampdu_factor;
-	u16 v;
+	u8 ampdu_factor, max_nss, rx_mcs_80, rx_mcs_160;
+	u16 v, mcs_160_map, mcs_80_map;
+	int i;
+	bool support_160;
 
 	if (!he_cap->has_he)
 		return;
 
 	arg->he_flag = true;
+	support_160 = !!(he_cap->he_cap_elem.phy_cap_info[0] &
+		  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G);
+
+	/* Supported HE-MCS and NSS Set of peer he_cap is intersection with self he_cp */
+	mcs_160_map =
+		le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
+	mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
+
+	if (support_160) {
+		for (i = 7; i >= 0; i--) {
+			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
+
+			if (mcs_160 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+				rx_mcs_160 = i + 1;
+				break;
+			}
+		}
+	}
+
+	for (i = 7; i >= 0; i--) {
+		u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
+
+		if (mcs_80 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+			rx_mcs_80 = i + 1;
+			break;
+		}
+	}
+
+	if (support_160)
+		max_nss = min(rx_mcs_80, rx_mcs_160);
+	else
+		max_nss = rx_mcs_80;
+
+	arg->peer_nss = min(sta->rx_nss, max_nss);
 
 	memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
 	       sizeof(arg->peer_he_cap_macinfo));
-- 
2.31.1

