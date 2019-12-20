Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20B6127A54
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLTL4r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:56:47 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:53956 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfLTL4q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:46 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGtg-0007ip-Gs; Fri, 20 Dec 2019 13:56:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:30 +0200
Message-Id: <20191220115638.1299888-3-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115638.1299888-1-luca@coelho.fi>
References: <20191220115638.1299888-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 02/10] iwlwifi: pcie: move page tracking into get_page_hdr()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Move the tracking that records the page in the SKB for later
free (refcount decrement) into the get_page_hdr() function
for better code reuse.

While at it, also add an assertion that this doesn't overwrite
any existing page pointer in the skb.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  3 ++-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  7 +------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 20 ++++++++++++-------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index a091690f6c79..3688911ce3df 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1082,7 +1082,8 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans);
 void iwl_pcie_free_tso_page(struct iwl_trans_pcie *trans_pcie,
 			    struct sk_buff *skb);
 #ifdef CONFIG_INET
-struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len);
+struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
+				      struct sk_buff *skb);
 #endif
 
 /* common functions that are used by gen3 transport */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 8ca0250de99e..494a8864368d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -246,7 +246,6 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 				     u8 hdr_len, struct iwl_device_cmd *dev_cmd)
 {
 #ifdef CONFIG_INET
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_tx_cmd_gen2 *tx_cmd = (void *)dev_cmd->payload;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
@@ -254,7 +253,6 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 	u16 length, amsdu_pad;
 	u8 *start_hdr;
 	struct iwl_tso_hdr_page *hdr_page;
-	struct page **page_ptr;
 	struct tso_t tso;
 
 	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd),
@@ -270,14 +268,11 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	hdr_page = get_page_hdr(trans, hdr_room);
+	hdr_page = get_page_hdr(trans, hdr_room, skb);
 	if (!hdr_page)
 		return -ENOMEM;
 
-	get_page(hdr_page->page);
 	start_hdr = hdr_page->pos;
-	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
-	*page_ptr = hdr_page->page;
 
 	/*
 	 * Pull the ieee80211 header to be able to use TSO core,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index f21f16ab2a97..2d1758031a0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2052,17 +2052,24 @@ static int iwl_fill_data_tbs(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 #ifdef CONFIG_INET
-struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len)
+struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
+				      struct sk_buff *skb)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans_pcie->tso_hdr_page);
+	struct page **page_ptr;
+
+	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
+
+	if (WARN_ON(*page_ptr))
+		return NULL;
 
 	if (!p->page)
 		goto alloc;
 
 	/* enough room on this page */
 	if (p->pos + len < (u8 *)page_address(p->page) + PAGE_SIZE)
-		return p;
+		goto out;
 
 	/* We don't have enough room on this page, get a new one. */
 	__free_page(p->page);
@@ -2072,6 +2079,9 @@ struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len)
 	if (!p->page)
 		return NULL;
 	p->pos = page_address(p->page);
+out:
+	*page_ptr = p->page;
+	get_page(p->page);
 	return p;
 }
 
@@ -2107,7 +2117,6 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 	u16 length, iv_len, amsdu_pad;
 	u8 *start_hdr;
 	struct iwl_tso_hdr_page *hdr_page;
-	struct page **page_ptr;
 	struct tso_t tso;
 
 	/* if the packet is protected, then it must be CCMP or GCMP */
@@ -2130,14 +2139,11 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr)) + iv_len;
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	hdr_page = get_page_hdr(trans, hdr_room);
+	hdr_page = get_page_hdr(trans, hdr_room, skb);
 	if (!hdr_page)
 		return -ENOMEM;
 
-	get_page(hdr_page->page);
 	start_hdr = hdr_page->pos;
-	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
-	*page_ptr = hdr_page->page;
 	memcpy(hdr_page->pos, skb->data + hdr_len, iv_len);
 	hdr_page->pos += iv_len;
 
-- 
2.24.0

