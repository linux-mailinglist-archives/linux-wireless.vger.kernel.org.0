Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33BC455841
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 10:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbhKRJwu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 04:52:50 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:41277 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245277AbhKRJwg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 04:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637228976; x=1668764976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wbjRCIJQaE3Scf4DiqQrfYifLF31muA6vchgbkQrHaw=;
  b=W9JZ13ACLnbBm4rvupke5MxDkQ0HOqlh6AbwJeiY2o/5M4sVkLPWp8Ty
   u1My08PaZyWIJxJY9+ROVlN4LZLmOR/E+jjKJeRmjMmQaku9LFNHXAfcz
   2WS6t5uz/8KHdp/4ruW+REAc/SA2twdCa6Ih/MdCtQtbOqddPhdoAfp2g
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Nov 2021 01:49:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 01:49:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 01:49:34 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 01:49:33 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] ath11k: change to treat alpha code na as world wide regdomain
Date:   Thu, 18 Nov 2021 04:48:48 -0500
Message-ID: <20211118094848.7776-1-quic_wgong@quicinc.com>
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

Some firmware versions for WCN6855 report the default regdomain with
alpha code "na" by default when load as a world wide regdomain, ath11k
should treat it as a world wide alpha code.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: rebased to latest ath.git master ath-202111170737

 drivers/net/wireless/ath/ath11k/wmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 614b2f6bcc8e..2e9fb87d8bf6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5927,7 +5927,13 @@ static void ath11k_wmi_htc_tx_complete(struct ath11k_base *ab,
 
 static bool ath11k_reg_is_world_alpha(char *alpha)
 {
-	return alpha[0] == '0' && alpha[1] == '0';
+	if (alpha[0] == '0' && alpha[1] == '0')
+		return true;
+
+	if (alpha[0] == 'n' && alpha[1] == 'a')
+		return true;
+
+	return false;
 }
 
 static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *skb)

base-commit: 63ec871bc50a306aac550e2d85f697ca2d5f5deb
-- 
2.31.1

