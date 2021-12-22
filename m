Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3338047CAE5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 02:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbhLVBqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 20:46:02 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:28989 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhLVBqB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 20:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640137561; x=1671673561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VuWM9ykE02hxTRoiyiu1KAiRry+PZiBiSgTc27wTvqM=;
  b=nmpf0eXGRVlNdCkMj2B7YBMVpnlp/Vwkg3vBwUyGDuXeBhJtWb4rQ9jo
   CZphbew6S+aIWCOsclJGS9W+d7Z3cXIjpNfKv1wGaNEi8GhGN7Zya5lgs
   pblq+S9PS/x9PK97lmMSXml23NQDLmGXQq+VtEHGyZJyWlyPeueL4oo2D
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Dec 2021 17:46:01 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 17:46:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 17:46:00 -0800
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 17:45:59 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Fix unexpected return buffer manager error for QCA6390
Date:   Wed, 22 Dec 2021 09:35:35 +0800
Message-ID: <20211222013536.582527-1-quic_bqiang@quicinc.com>
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

We are seeing below error on QCA6390:
...
[70211.671189] ath11k_pci 0000:72:00.0: failed to parse rx error in wbm_rel ring desc -22
[70212.696154] ath11k_pci 0000:72:00.0: failed to parse rx error in wbm_rel ring desc -22
[70213.092941] ath11k_pci 0000:72:00.0: failed to parse rx error in wbm_rel ring desc -22
...

The reason is that, with commit 734223d78428 ("ath11k: change return
buffer manager for QCA6390"), ath11k expects the return buffer manager
(RBM) field of descriptor configured as HAL_RX_BUF_RBM_SW1_BM when
parsing error frames from WBM2SW3_RELEASE ring. This is a wrong change
cause the RBM field is set as HAL_RX_BUF_RBM_SW3_BM.

The same issue also applies to REO2TCL ring though we have not got any
error reported.

Fix it by changing RBM from HAL_RX_BUF_RBM_SW1_BM to HAL_RX_BUF_RBM_SW3_BM
for these two rings.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Fixes: 734223d78428 ("ath11k: change return buffer manager for QCA6390")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 38eeb6e7c6b6..2127ed89956b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3847,7 +3847,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 		ath11k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
 						 &rbm);
 		if (rbm != HAL_RX_BUF_RBM_WBM_IDLE_DESC_LIST &&
-		    rbm != ab->hw_params.hal_params->rx_buf_rbm) {
+		    rbm != HAL_RX_BUF_RBM_SW3_BM) {
 			ab->soc_stats.invalid_rbm++;
 			ath11k_warn(ab, "invalid return buffer manager %d\n", rbm);
 			ath11k_dp_rx_link_desc_return(ab, desc,
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 1e279e99baa8..d5a497369b5f 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -371,7 +371,7 @@ int ath11k_hal_wbm_desc_parse_err(struct ath11k_base *ab, void *desc,
 
 	ret_buf_mgr = FIELD_GET(BUFFER_ADDR_INFO1_RET_BUF_MGR,
 				wbm_desc->buf_addr_info.info1);
-	if (ret_buf_mgr != ab->hw_params.hal_params->rx_buf_rbm) {
+	if (ret_buf_mgr != HAL_RX_BUF_RBM_SW3_BM) {
 		ab->soc_stats.invalid_rbm++;
 		return -EINVAL;
 	}
-- 
2.25.1

