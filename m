Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AB113395
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfLDSR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 13:17:58 -0500
Received: from nbd.name ([46.4.11.11]:40920 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbfLDSR5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 13:17:57 -0500
Received: from p5dcfb666.dip0.t-ipconnect.de ([93.207.182.102] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1icZDl-0005Od-4w; Wed, 04 Dec 2019 19:17:53 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 2/9] ath11k: disable PS for STA interfaces by default upon bringup
Date:   Wed,  4 Dec 2019 19:17:38 +0100
Message-Id: <20191204181745.27297-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204181745.27297-1-john@phrozen.org>
References: <20191204181745.27297-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After applying this setting the TX performance issue of STA interfaces is
gone and we can see TX performance go up to ~900mbit on HE80.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 978d8768d68a..d9b4c95019e5 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4097,6 +4097,13 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			goto err_peer_del;
 		}
+
+		ret = ath11k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, false);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to disable vdev %d ps mode: %d\n",
+				    arvif->vdev_id, ret);
+			goto err_peer_del;
+		}
 		break;
 	default:
 		break;
-- 
2.20.1

