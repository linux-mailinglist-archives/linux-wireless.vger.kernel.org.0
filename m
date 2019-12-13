Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5911E6A1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfLMPfM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:35:12 -0500
Received: from nbd.name ([46.4.11.11]:54632 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfLMPfL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:35:11 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifmyD-0005ee-Qm; Fri, 13 Dec 2019 16:35:09 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 1/2] ath11k: fix pdev when invoking ath11k_wmi_send_twt_enable_cmd()
Date:   Fri, 13 Dec 2019 16:34:56 +0100
Message-Id: <20191213153457.11946-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

The code currently uses the wrong pdev id when enabling TWT. Fix this by
using the correct ones.

Fixes: e65a616f4e74 ("ath11k: add TWT support")
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index fec268b9b711..b229b0b3e0bd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1917,9 +1917,9 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_TWT) {
 		if (info->twt_requester || info->twt_responder)
-			ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev_idx);
+			ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id);
 		else
-			ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev_idx);
+			ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
 		if (vif->type == NL80211_IFTYPE_AP)
 			ath11k_debugfs_twt(arvif, info->twt_requester);
 	}
-- 
2.20.1

