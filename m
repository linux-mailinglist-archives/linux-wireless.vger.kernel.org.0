Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D61232C5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 17:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfLQQnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 11:43:41 -0500
Received: from nbd.name ([46.4.11.11]:51144 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfLQQnl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 11:43:41 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihFwf-0004wY-J1; Tue, 17 Dec 2019 17:43:37 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 2/2] ath11k: load appropriate board data based on board id
Date:   Tue, 17 Dec 2019 17:43:29 +0100
Message-Id: <20191217164329.4151-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217164329.4151-1-john@phrozen.org>
References: <20191217164329.4151-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

This patch add support to read board id from dts and load
appropriate board data from userland.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 2377895a58ec..e80290c7c9dd 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1712,9 +1712,11 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 
 static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 {
+	struct device *dev = ab->dev;
 	struct qmi_wlanfw_cap_req_msg_v01 req;
 	struct qmi_wlanfw_cap_resp_msg_v01 resp;
 	struct qmi_txn txn = {};
+	unsigned int board_id;
 	int ret = 0;
 
 	memset(&req, 0, sizeof(req));
@@ -1753,10 +1755,14 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 		ab->qmi.target.chip_family = resp.chip_info.chip_family;
 	}
 
-	if (resp.board_info_valid)
+	if (!of_property_read_u32(dev->of_node, "qcom,board_id", &board_id)) {
+		if (board_id != 0xFF)
+			ab->qmi.target.board_id = board_id;
+	} else if (resp.board_info_valid) {
 		ab->qmi.target.board_id = resp.board_info.board_id;
-	else
+	} else {
 		ab->qmi.target.board_id = 0xFF;
+	}
 
 	if (resp.soc_info_valid)
 		ab->qmi.target.soc_id = resp.soc_info.soc_id;
-- 
2.20.1

