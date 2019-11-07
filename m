Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895FEF2DB9
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 12:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfKGLv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 06:51:57 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55138 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727178AbfKGLv5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 06:51:57 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iSgKR-0000wr-3W; Thu, 07 Nov 2019 13:51:55 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  7 Nov 2019 13:51:47 +0200
Message-Id: <20191107115149.10709-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.4 1/3] iwlwifi: pcie: don't consider IV len in A-MSDU
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

From gen2 PN is totally offloaded to hardware (also the space for the
IV isn't part of the skb).  As you can see in mvm/mac80211.c:3545, the
MAC for cipher types CCMP/GCMP doesn't set
IEEE80211_KEY_FLAG_PUT_IV_SPACE for gen2 NICs.

This causes all the AMSDU data to be corrupted with cipher enabled.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 8894027429d6..d80f71f82a6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -251,27 +251,23 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
-	u16 length, iv_len, amsdu_pad;
+	u16 length, amsdu_pad;
 	u8 *start_hdr;
 	struct iwl_tso_hdr_page *hdr_page;
 	struct page **page_ptr;
 	struct tso_t tso;
 
-	/* if the packet is protected, then it must be CCMP or GCMP */
-	iv_len = ieee80211_has_protected(hdr->frame_control) ?
-		IEEE80211_CCMP_HDR_LEN : 0;
-
 	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd),
 			     &dev_cmd->hdr, start_len, 0);
 
 	ip_hdrlen = skb_transport_header(skb) - skb_network_header(skb);
 	snap_ip_tcp_hdrlen = 8 + ip_hdrlen + tcp_hdrlen(skb);
-	total_len = skb->len - snap_ip_tcp_hdrlen - hdr_len - iv_len;
+	total_len = skb->len - snap_ip_tcp_hdrlen - hdr_len;
 	amsdu_pad = 0;
 
 	/* total amount of header we may need for this A-MSDU */
 	hdr_room = DIV_ROUND_UP(total_len, mss) *
-		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr)) + iv_len;
+		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
 	hdr_page = get_page_hdr(trans, hdr_room);
@@ -282,14 +278,12 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 	start_hdr = hdr_page->pos;
 	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
 	*page_ptr = hdr_page->page;
-	memcpy(hdr_page->pos, skb->data + hdr_len, iv_len);
-	hdr_page->pos += iv_len;
 
 	/*
-	 * Pull the ieee80211 header + IV to be able to use TSO core,
+	 * Pull the ieee80211 header to be able to use TSO core,
 	 * we will restore it for the tx_status flow.
 	 */
-	skb_pull(skb, hdr_len + iv_len);
+	skb_pull(skb, hdr_len);
 
 	/*
 	 * Remove the length of all the headers that we don't actually
@@ -364,8 +358,8 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 		}
 	}
 
-	/* re -add the WiFi header and IV */
-	skb_push(skb, hdr_len + iv_len);
+	/* re -add the WiFi header */
+	skb_push(skb, hdr_len);
 
 	return 0;
 
-- 
2.24.0.rc1

