Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98712372B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 21:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfLQUVB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 15:21:01 -0500
Received: from nbd.name ([46.4.11.11]:37182 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfLQUVA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 15:21:00 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihJL1-0000pA-0R; Tue, 17 Dec 2019 21:20:59 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [RESEND] ath11k: make sure to also report the RX bandwidth inside radiotap
Date:   Tue, 17 Dec 2019 21:20:57 +0100
Message-Id: <20191217202057.27720-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN to the list of known
fields. Not doing so will result in wireshark not calculating the
bitrate correctly.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 09edf0f05039..c4692cee3af4 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2348,7 +2348,8 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 				      struct sk_buff *msdu)
 {
 	static const struct ieee80211_radiotap_he known = {
-		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN),
+		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
+				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
 		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
 	};
 	struct ieee80211_rx_status *status;
-- 
2.20.1

