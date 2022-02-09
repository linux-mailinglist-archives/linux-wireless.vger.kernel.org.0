Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53944AEA24
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 07:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiBIGQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 01:16:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbiBIGLc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 01:11:32 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A735C0043F8
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 22:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644386981; x=1675922981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8LUtAfdXN4uBXEVf7VF4kSObYsPKpz31Px0X8lqd4c=;
  b=he81C9Mc6uMd6EnhwpW8+4+PPC94USY43372OhGmki8cf95HIJ6/4ocf
   TIvdL9Lji+kTxLauofnYl6uF7ssPDNpNORtoXHvRPB3HOUrnqwBbQzr9K
   3aDgpx6ruQdJyantyQ9Ev6VxKHYvRCflngiT9hDFuBhqLoMlX9bTcv6Ym
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Feb 2022 22:08:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 22:08:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:08:35 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:08:34 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: fix uninitialized rate_idx in ath11k_dp_tx_update_txcompl()
Date:   Wed, 9 Feb 2022 01:08:16 -0500
Message-ID: <20220209060816.423-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

The rate_idx which passed to ath11k_debugfs_sta_add_tx_stats() by
ath11k_dp_tx_update_txcompl() is not initialized, add initialization
for it.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Fixes: 1b8bb94c0612 ("ath11k: report tx bitrate for iw wlan station dump")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 91d6244b6543..8402961c6688 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -426,7 +426,7 @@ void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts)
 	struct ath11k_sta *arsta;
 	struct ieee80211_sta *sta;
 	u16 rate, ru_tones;
-	u8 mcs, rate_idx, ofdma;
+	u8 mcs, rate_idx = 0, ofdma;
 	int ret;
 
 	spin_lock_bh(&ab->base_lock);

base-commit: 76680d49b5e0e661bc4abcdaf13fb7e124b4ca08
-- 
2.31.1

