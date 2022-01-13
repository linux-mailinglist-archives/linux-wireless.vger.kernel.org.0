Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFA648D073
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 03:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiAMCcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 21:32:05 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46498 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231731AbiAMCcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 21:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642041124; x=1673577124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zBlat8tQ6bnylReTzE36wcrn+PLIAcSz3jIy/oXAoew=;
  b=SOQegCAVLvvDdD03/mBZRQhsI5dN8OD2zfJiDOClBlb4UE42CtXD3RVR
   9wyZs+VzFU7dvDnnl+NdCAHP8YfauflpJkj/oJxKb7L/kTQ5GUnF40zO1
   j59Z0rB4S2ygutlFEYgHmG0L0PC0Zhgx3x6CFGKTciDhT3zxSspX3/Vzg
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Jan 2022 18:32:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:32:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 12 Jan 2022 18:32:03 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 12 Jan 2022 18:32:02 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: set WMI_PEER_40MHZ while peer assoc for 6 GHz
Date:   Wed, 12 Jan 2022 21:31:45 -0500
Message-ID: <20220113023145.14292-1-quic_wgong@quicinc.com>
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

When station connect to AP of 6 GHz with 40 MHz bandwidth, the TX is
always stay 20 MHz, it is because the flag WMI_PEER_40MHZ is not set
while peer assoc. Add the flag if remote peer is 40 MHz bandwidth.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Fixes: 2cdf2b3cdf54 ("ath11k: add 6ghz params in peer assoc command")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07f499d5ec92..fe4103bcfee3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2319,6 +2319,9 @@ static void ath11k_peer_assoc_h_he_6ghz(struct ath11k *ar,
 	if (!arg->he_flag || band != NL80211_BAND_6GHZ || !sta->he_6ghz_capa.capa)
 		return;
 
+	if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
+		arg->bw_40 = true;
+
 	if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
 		arg->bw_80 = true;
 

base-commit: 69a6130e6ab00306fe1552c73eb0d7a0dd4b4c04
-- 
2.31.1

