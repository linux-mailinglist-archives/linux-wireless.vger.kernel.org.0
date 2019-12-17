Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C50123351
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 18:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLQRSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 12:18:36 -0500
Received: from nbd.name ([46.4.11.11]:53382 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfLQRSf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 12:18:35 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihGUS-0006xr-Uh; Tue, 17 Dec 2019 18:18:33 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Ritesh Singh <ritesi@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] ath11k: mask out vht beamforming if a fixed rate is set
Date:   Tue, 17 Dec 2019 18:18:27 +0100
Message-Id: <20191217171827.6780-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ritesh Singh <ritesi@codeaurora.org>

After setting a fixed vht-rate we see a FW assert if a STA tries to
(re)assoc with the mu_bfee cap set. This patch masks out the capability
bits if a fixed rate is set.

Reviewed-by: John Crispin <john@phrozen.org>
Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b8be78dc295d..7f17d0e4cb96 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1126,6 +1126,9 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	arg->tx_mcs_set &= ~IEEE80211_VHT_MCS_SUPPORT_0_11_MASK;
 	arg->tx_mcs_set |= IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11;
 
+	if ((arg->tx_mcs_set & 0x3) == 0x3)
+		arg->peer_vht_caps &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+
 	/* TODO:  Check */
 	arg->tx_max_mcs_nss = 0xFF;
 
-- 
2.20.1

