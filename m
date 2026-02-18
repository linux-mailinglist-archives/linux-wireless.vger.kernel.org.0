Return-Path: <linux-wireless+bounces-31963-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJVjNifKlWlfUwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31963-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 15:18:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37977156FF3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 15:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C683017014
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856C330D36;
	Wed, 18 Feb 2026 14:18:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4B22D4DC;
	Wed, 18 Feb 2026 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424293; cv=none; b=pBgDJjc3seYw//CXvSoRfhnu2e0rwVU+M40yV6IcO/vnyMy+ND/T57RKUPfnvBX6mbRPUUkcI/F1bUBQnzrJ+sIQi0KD63qYBNOAX4PkzfW9n3fTkY3visALWh8icqfSv83hgmMFVor8M6CIVCGY4+f/npRgvbKjDosCD5yDDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424293; c=relaxed/simple;
	bh=TH8ye9hyu8OpPmalyyIMAr7/zcFIBRL2aCvYHETHGnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPrwVyVIKFpEENuORoYKoUESzJSI+os7oF4wkp1NwhbYsE29tA0UL7uKdeINkS8iOkmaQemQk2ncSXnHepu6/TJCo2ljX76Uy7ZtbRqXMFnBJL8+Lb5GO1mPSZotbKQ8YtQz/VCosaHILFqsupJMO84tRzrhoSQw7Lg0ZB2NdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	miriam.rachel.korenblit@intel.com,
	greearb@candelatech.com,
	linux-kernel@vger.kernel.org,
	Cole Leavitt <cole@unwrap.rs>
Subject: [PATCH v2] wifi: iwlwifi: mld: skip TX when firmware is dead
Date: Wed, 18 Feb 2026 07:17:58 -0700
Message-ID: <20260218141758.25929-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214060716.16394-1-cole@unwrap.rs>
References: <20260214060716.16394-1-cole@unwrap.rs>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_FROM(0.00)[bounces-31963-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,unwrap.rs:mid,unwrap.rs:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org]
X-Rspamd-Queue-Id: 37977156FF3
X-Rspamd-Action: no action

When firmware encounters an error, STATUS_FW_ERROR is set but the
mac80211 TX path continues pulling frames from TXQs. Each frame
fails at iwl_trans_tx() which checks STATUS_FW_ERROR and returns
-EIO, but iwl_mld_tx_from_txq() keeps looping over every queued
frame. This burns CPU in a tight loop on dead firmware and can
cause soft lockups during firmware error recovery.

Add a STATUS_FW_ERROR check at the top of iwl_mld_tx_from_txq()
to stop pulling frames from mac80211 TXQs when firmware is dead.
Also guard iwl_mld_mac80211_tx() which bypasses the TXQ path
entirely and would otherwise continue feeding frames to dead
firmware.

Once STATUS_FW_ERROR is cleared during firmware restart, TX
resumes naturally with no explicit wake needed.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---
v2:
 - Replace ieee80211_stop_queues()/wake_queues() with STATUS_FW_ERROR
   checks in the TX pull path, per Johannes Berg's feedback that
   stop/wake_queues doesn't interact well with TXQ-based APIs.
 - Guard both iwl_mld_tx_from_txq() (TXQ pull path) and
   iwl_mld_mac80211_tx() (direct mac80211 TX path).
 - Drop all changes to mld.c (no stop/wake in error/restart flows).

 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/tx.c       | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 3414b04a6953..1bd8411965f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -519,6 +519,11 @@ iwl_mld_mac80211_tx(struct ieee80211_hw *hw,
 	u32 link_id = u32_get_bits(info->control.flags,
 				   IEEE80211_TX_CTRL_MLO_LINK);
 
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+
 	/* In AP mode, mgmt frames are sent on the bcast station,
 	 * so the FW can't translate the MLD addr to the link addr. Do it here
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 7c6a4b4e5523..fbb672f4d8c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -970,6 +970,14 @@ void iwl_mld_tx_from_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	struct sk_buff *skb = NULL;
 	u8 zero_addr[ETH_ALEN] = {};
 
+	/* Firmware is dead - don't pull frames from mac80211 TXQs.
+	 * Packets dequeued here would fail at iwl_trans_tx() anyway,
+	 * but looping over every queued frame burns CPU and causes
+	 * soft lockups during firmware error recovery.
+	 */
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status)))
+		return;
+
 	/*
 	 * No need for threads to be pending here, they can leave the first
 	 * taker all the work.
-- 
2.52.0


