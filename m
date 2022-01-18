Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD58F4915EB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 03:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345908AbiARCcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 21:32:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41716 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbiARC2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 21:28:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D6B3B81239;
        Tue, 18 Jan 2022 02:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00665C36AEB;
        Tue, 18 Jan 2022 02:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642472931;
        bh=slkzV2uCi161ff2FMYKOSO9pXjF+rfhmk/CRWGQotis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VW7lUoeEhbJiHwEZ1FSTMAuEsOs5/qThkAi973P8zkYoZUzcbREaju7P0OUu+ymqq
         ytnG7aheSaRvbrRD8fQ+ZfBlZuXsgrtjaa2gFlbb0Eh2kxhtNsa9QWIvtcweGvs2PO
         J5g4pDEk+WhuQyrn1qVobNEzmBdcSAF+U3XkgZydyR4eWqhqUN34KAGNniiyloBUKk
         l6GpCZkAPmhKg1Cv8/ATjJ2zAfrjeXCCGGPeOSWTCw0D7LKHQ1kFeeFN5ZqtStHpeq
         NkFSfM2LJJq781N72CasyYTfZ61+3iC0kMDUBDS191TEBcqe1i6mcc+EYNOzMwu0mA
         0wm+gQYrdEIwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, kuba@kernel.org, johannes.berg@intel.com,
        miriam.rachel.korenblit@intel.com, avraham.stern@intel.com,
        emmanuel.grumbach@intel.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 166/217] iwlwifi: mvm: Fix calculation of frame length
Date:   Mon, 17 Jan 2022 21:18:49 -0500
Message-Id: <20220118021940.1942199-166-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118021940.1942199-1-sashal@kernel.org>
References: <20220118021940.1942199-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 40a0b38d7a7f91a6027287e0df54f5f547e8d27e ]

The RADA might include in the Rx frame the MIC and CRC bytes.
These bytes should be removed for non monitor interfaces and
should not be passed to mac80211.

Fix the Rx processing to remove the extra bytes on non monitor
cases.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20211219121514.098be12c801e.I1d81733d8a75b84c3b20eb6e0d14ab3405ca6a86@changeid
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e0601f802628c..1e2a55ccf1926 100644
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

