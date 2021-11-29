Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A45C4611ED
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhK2KTo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 05:19:44 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:55072 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhK2KRn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 05:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638180867; x=1669716867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eghArX8uLVAeCkugUgFj1dfdhI9ykBs3dPHaiS6PlT4=;
  b=J1afd3g1AosvfSQ8FrCM1m+9bTvGUVspsz9xsCT2HlWso/jCHHhb8QPX
   9cRUBmVoPhwNVHwJAqgeQqhaYYmztcj1dMvBPqzDiEnpRK7Jlp69btwdW
   KEsuJHrVUh1aphBlqMG/SVfJ3UyeCF0ovLkJIi/HJPTWVVYsSOhu8heIK
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 29 Nov 2021 02:14:26 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 02:14:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 02:13:25 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 02:13:24 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
Date:   Mon, 29 Nov 2021 05:13:09 -0500
Message-ID: <20211129101309.2931-1-quic_wgong@quicinc.com>
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

Currently mac80211 will send 3 scan request for each scan of WCN6855,
they are 2.4 GHz/5 GHz/6 GHz band scan. Firmware of WCN6855 will
cache the RNR IE(Reduced Neighbor Report element) which exist in the
beacon of 2.4 GHz/5 GHz of the AP which is co-located with 6 GHz,
and then use the cache to scan in 6 GHz band scan if the 6 GHz scan
is in the same scan with the 2.4 GHz/5 GHz band, this will helpful to
search more AP of 6 GHz. Also it will decrease the time cost of scan
because firmware will use dual-band scan for the 2.4 GHz/5 GHz, it
means the 2.4 GHz and 5 GHz scans are doing simultaneously.

Set the flag IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855 since
it supports 2.4 GHz/5 GHz/6 GHz and it is single pdev which means
all the 2.4 GHz/5 GHz/6 GHz exist in the same wiphy/ieee80211_hw.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 06d20658586a..8218ea52f285 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7915,6 +7915,9 @@ static int __ath11k_mac_register(struct ath11k *ar)
 
 	ar->hw->wiphy->interface_modes = ab->hw_params.interface_modes;
 
+	if (ab->hw_params.single_pdev_only && ar->supports_6ghz)
+		ieee80211_hw_set(ar->hw, SINGLE_SCAN_ON_ALL_BANDS);
+
 	ieee80211_hw_set(ar->hw, SIGNAL_DBM);
 	ieee80211_hw_set(ar->hw, SUPPORTS_PS);
 	ieee80211_hw_set(ar->hw, SUPPORTS_DYNAMIC_PS);
-- 
2.31.1

