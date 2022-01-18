Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEAC491C8B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 04:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350271AbiARDQN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 22:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354456AbiARDGH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 22:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7CEC01F009;
        Mon, 17 Jan 2022 18:48:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BEAE61346;
        Tue, 18 Jan 2022 02:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330C6C36AEF;
        Tue, 18 Jan 2022 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642474108;
        bh=1Qg4OYv91lGRhtfStxqbwAGY3ECUEntVoppTLd+0S4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfnuumY7C2PMl3s4Qh+sYwEXeHNm/EEk5plC1mcjI8sCJB4vMSlaHIRVU4puqxf+G
         1YR+VaknoTBUDf3ldcvLDZwCndpe4dSjZrK/AqHMVhEsWXM8QdRtHigj/bN01/2MD0
         aCbWGHWjKRn/Y7wKqgdeNI9FLLI7rxuwSk+vvc/KFe3N31JCzobAPL0LeblWq9mIP0
         cSzY7rR3MK/o+JapL6hgry/AwkFED6DTBR1lhXV9ZmtrLjqnhMsTXYj8u1g34zkNSy
         noPk3YcvpUXLASCoiyrGSEj4sxYOO0cKevB9jTskmgSlT5ERp/DT2qDrDwtV1PLHpc
         XnfPqENBSIaQA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, kuba@kernel.org, johannes.berg@intel.com,
        miriam.rachel.korenblit@intel.com, emmanuel.grumbach@intel.com,
        dan.carpenter@oracle.com, avraham.stern@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 39/59] iwlwifi: mvm: Fix calculation of frame length
Date:   Mon, 17 Jan 2022 21:46:40 -0500
Message-Id: <20220118024701.1952911-39-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024701.1952911-1-sashal@kernel.org>
References: <20220118024701.1952911-1-sashal@kernel.org>
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
index 77e3694536421..9a4848d69e9e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -151,12 +151,39 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
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

