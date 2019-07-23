Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2598B71A8F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbfGWOiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 10:38:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56514 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfGWOiM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 10:38:12 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hpvve-0007sr-Dp; Tue, 23 Jul 2019 16:38:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 3/3] iwlwifi: mvm: fix a use-after-free bug in iwl_mvm_tx_tso_segment
Date:   Tue, 23 Jul 2019 16:38:03 +0200
Message-Id: <20190723143803.8698-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723143803.8698-1-johannes@sipsolutions.net>
References: <20190723143803.8698-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Accessing the hdr of an skb that was consumed already isn't
a good idea.
First ask if the skb is a QoS packet, then keep that data
on stack, and then consume the skb.
This was spotted by KASAN.

Fixes: 08f7d8b69aaf ("iwlwifi: mvm: bring back mvm GSO code")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index a3e5d88f1c07..6ac114a393cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -831,6 +831,7 @@ iwl_mvm_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
 	unsigned int tcp_payload_len;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
 	bool ipv4 = (skb->protocol == htons(ETH_P_IP));
+	bool qos = ieee80211_is_data_qos(hdr->frame_control);
 	u16 ip_base_id = ipv4 ? ntohs(ip_hdr(skb)->id) : 0;
 
 	skb_shinfo(skb)->gso_size = num_subframes * mss;
@@ -864,7 +865,7 @@ iwl_mvm_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
 		if (tcp_payload_len > mss) {
 			skb_shinfo(tmp)->gso_size = mss;
 		} else {
-			if (ieee80211_is_data_qos(hdr->frame_control)) {
+			if (qos) {
 				u8 *qc;
 
 				if (ipv4)
-- 
2.20.1

