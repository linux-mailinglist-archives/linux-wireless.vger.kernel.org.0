Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683362A5E16
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 07:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgKDGTz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 01:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKDGTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 01:19:54 -0500
Received: from rhcavuit02.kulnet.kuleuven.be (rhcavuit02.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272FDC061A4D
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 22:19:54 -0800 (PST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: EE09312032F.A1960
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id EE09312032F
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 07:19:40 +0100 (CET)
Received: from mathy-work.localhost (unknown [92.96.39.204])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 15B76200A1;
        Wed,  4 Nov 2020 07:19:38 +0100 (CET)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 5/5] ath9k_htc: adhere to the DONT_REORDER transmit flag
Date:   Wed,  4 Nov 2020 10:18:23 +0400
Message-Id: <20201104061823.197407-6-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
References: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Assure that frames with the fixed order flag are not reordered
relative to each other. This is accomplished by transmitting them
using a fixed priority independent of their QoS field.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 0bdc4dcb7..8e69e8989 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -297,7 +297,12 @@ static void ath9k_htc_tx_data(struct ath9k_htc_priv *priv,
 		tx_hdr.data_type = ATH9K_HTC_NORMAL;
 	}
 
-	if (ieee80211_is_data_qos(hdr->frame_control)) {
+	/* Transmit all frames that should not be reordered relative
+	 * to each other using the same priority. For other QoS data
+	 * frames extract the priority from the header.
+	 */
+	if (!(tx_info->control.flags & IEEE80211_TX_CTRL_DONT_REORDER) &&
+	    ieee80211_is_data_qos(hdr->frame_control)) {
 		qc = ieee80211_get_qos_ctl(hdr);
 		tx_hdr.tidno = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	}
-- 
2.28.0

