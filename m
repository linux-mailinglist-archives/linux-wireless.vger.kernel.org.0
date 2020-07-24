Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E469822BDBB
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 07:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgGXFwO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 01:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgGXFwO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 01:52:14 -0400
Received: from rhcavuit02.kulnet.kuleuven.be (rhcavuit02.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B576C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 22:52:14 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: BB9C4120338.A00A6
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-1.cc.kuleuven.be (icts-p-smtps-1e.kulnet.kuleuven.be [134.58.240.33])
        by rhcavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id BB9C4120338
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 07:52:02 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-1.cc.kuleuven.be (Postfix) with ESMTPSA id 5BBEC40B2;
        Fri, 24 Jul 2020 07:52:01 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [RFC 5/5] ath9k_htc: adhere to the DONT_REORDER transmit flag
Date:   Fri, 24 Jul 2020 09:51:04 +0400
Message-Id: <20200724055104.105675-5-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724055104.105675-1-Mathy.Vanhoef@kuleuven.be>
References: <20200724054724.105520-1-Mathy.Vanhoef@kuleuven.be>
 <20200724055104.105675-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
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
index b353995bd..4cbc62234 100644
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
2.27.0

