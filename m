Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3FE1232F0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 17:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfLQQtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 11:49:24 -0500
Received: from nbd.name ([46.4.11.11]:51564 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfLQQtX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 11:49:23 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihG2D-0005Ih-SL; Tue, 17 Dec 2019 17:49:22 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Bhagavathi Perumal S <bperumal@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] ath11k: set TxBf parameters after vdev start
Date:   Tue, 17 Dec 2019 17:49:17 +0100
Message-Id: <20191217164917.5040-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bhagavathi Perumal S <bperumal@codeaurora.org>

The channel info parameters are required by the firmware to process TxBf
parameters. Currently TxBf is passed prior to the channel info. This patch
moves TxBf setup after the channel setup.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bhagavathi Perumal S <bperumal@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9d0fed4034dd..a8ccb00d6072 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4216,12 +4216,6 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 	}
 
-	ret = ath11k_mac_set_txbf_conf(arvif);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to set txbf conf for vdev %d: %d\n",
-			    arvif->vdev_id, ret);
-	}
-
 	ath11k_dp_vdev_tx_attach(ar, arvif);
 
 	mutex_unlock(&ar->conf_mutex);
@@ -4573,6 +4567,11 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 			   arg.channel.freq, arg.vdev_id);
 	}
 
+	ret = ath11k_mac_set_txbf_conf(arvif);
+	if (ret)
+		ath11k_warn(ab, "failed to set txbf conf for vdev %d: %d\n",
+			    arvif->vdev_id, ret);
+
 	return 0;
 }
 
-- 
2.20.1

