Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC35353B911
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jun 2022 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiFBMmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jun 2022 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiFBMmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jun 2022 08:42:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1B22168D
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654173721; x=1685709721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vI3dykq+/nxLcaJ8BRdrfh9jOZK5Imea8Cf6WRjmGFs=;
  b=ctf9i/7j9YaGy++pWqjnUkWoEMl4SodbERk4zM2xM6PMIg52ubvjFfKB
   U73uoFMzCMY4NH0tvQQAYp2Ayfs/NiRd1y+umzYS07lGqRxwmigh9bHXB
   c/Rk02ISFB2fd84qvv3wAMW1qCls0zKIywbAKH2J/WaI5QfVbfTVR6Q4j
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Jun 2022 05:42:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:42:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 05:42:00 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 05:41:58 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] ath11k: Fix LDPC config in set_bitrate_mask hook
Date:   Thu, 2 Jun 2022 18:11:42 +0530
Message-ID: <20220602124142.29909-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently ar->ht_cap_info is not set anywhere in the code, this could
result in LDPC config computed wrongly in the set_bitrate_mask() hook
and eventually sending wrong config to the target. Fix this by checking
the LDPC support from the band HT capabilities of the radio instead.

Furthermore, it looks like firmwares running on the ath11k hardware
do not set WMI_HT_CAP_LDPC for advertising the TX LDPC capability,
WMI_HT_CAP_TX_LDPC is set instead and this should be checked for
getting hardware's TX LDPC support. This is true for QCA6390, WCN6855
& WCN6750 hardware.

Also, remove unused variables ht_cap_info & vht_cap_info from
struct ath11k{}.

Found this during code review.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 2 --
 drivers/net/wireless/ath/ath11k/mac.c  | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index ea31016437b0..2bd5eb9df4d4 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -582,8 +582,6 @@ struct ath11k {
 	struct ath11k_pdev_wmi *wmi;
 	struct ath11k_pdev_dp dp;
 	u8 mac_addr[ETH_ALEN];
-	u32 ht_cap_info;
-	u32 vht_cap_info;
 	struct ath11k_he ar_he;
 	enum ath11k_state state;
 	bool supports_6ghz;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f11956163822..6b3d7a014847 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7800,6 +7800,7 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 {
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	struct cfg80211_chan_def def;
+	struct ath11k_pdev_cap *cap;
 	struct ath11k *ar = arvif->ar;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -7820,10 +7821,11 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		return -EPERM;
 
 	band = def.chan->band;
+	cap = &ar->pdev->cap;
 	ht_mcs_mask = mask->control[band].ht_mcs;
 	vht_mcs_mask = mask->control[band].vht_mcs;
 	he_mcs_mask = mask->control[band].he_mcs;
-	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
+	ldpc = !!(cap->band[band].ht_cap_info & WMI_HT_CAP_TX_LDPC);
 
 	sgi = mask->control[band].gi;
 	if (sgi == NL80211_TXRATE_FORCE_LGI)
-- 
2.35.1

