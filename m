Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A947A02E
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhLSKSe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:34 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51370 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235597AbhLSKSd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:33 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGw-001O3b-SG; Sun, 19 Dec 2021 12:18:31 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:16 +0200
Message-Id: <iwlwifi.20211219121514.098be12c801e.I1d81733d8a75b84c3b20eb6e0d14ab3405ca6a86@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: mvm: Fix calculation of frame length
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The RADA might include in the Rx frame the MIC and CRC bytes.
These bytes should be removed for non monitor interfaces and
should not be passed to mac80211.

Fix the Rx processing to remove the extra bytes on non monitor
cases.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 5f73717f2f5f..c8b20f202627 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -121,12 +121,39 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct iwl_rx_mpdu_desc *desc = (void *)pkt->data;
 	unsigned int headlen, fraglen, pad_len = 0;
 	unsigned int hdrlen = ieee80211_hdrlen(hdr->frame_control);
+	u8 mic_crc_len = u8_get_bits(desc->mac_flags1,
+				     IWL_RX_MPDU_MFLG1_MIC_CRC_LEN_MASK) << 1;
 
 	if (desc->mac_flags2 & IWL_RX_MPDU_MFLG2_PAD) {
 		len -= 2;
 		pad_len = 2;
 	}
 
+	/*
+	 * For non monitor interface strip the bytes the RADA might not have
+	 * removed. As monitor interface cannot exist with other interfaces
+	 * this removal is safe.
+	 */
+	if (mic_crc_len && !ieee80211_hw_check(mvm->hw, RX_INCLUDES_FCS)) {
+		u32 pkt_flags = le32_to_cpu(pkt->len_n_flags);
+
+		/*
+		 * If RADA was not enabled then decryption was not performed so
+		 * the MIC cannot be removed.
+		 */
+		if (!(pkt_flags & FH_RSCSR_RADA_EN)) {
+			if (WARN_ON(crypt_len > mic_crc_len))
+				return -EINVAL;
+
+			mic_crc_len -= crypt_len;
+		}
+
+		if (WARN_ON(mic_crc_len > len))
+			return -EINVAL;
+
+		len -= mic_crc_len;
+	}
+
 	/* If frame is small enough to fit in skb->head, pull it completely.
 	 * If not, only pull ieee80211_hdr (including crypto if present, and
 	 * an additional 8 bytes for SNAP/ethertype, see below) so that
-- 
2.34.1

