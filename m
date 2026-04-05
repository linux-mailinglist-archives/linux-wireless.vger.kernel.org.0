Return-Path: <linux-wireless+bounces-34358-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DyN6FjD20WkkRwcAu9opvQ
	(envelope-from <linux-wireless+bounces-34358-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:42:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C3F39D6C3
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFA4B3003717
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 05:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A133537E9;
	Sun,  5 Apr 2026 05:42:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFEA285417
	for <linux-wireless@vger.kernel.org>; Sun,  5 Apr 2026 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367720; cv=none; b=XxfxxpCwWm4PdoGCiir5A2EPzzverWSUkwb83xtSiCLDKNUVttihM1H6/UqoffR15vCm775BiLgpKsVhs4giPjfoQTzMFrCKpSoYFZhs6nScl0/EoM8AX4egw+9+EKYKLYBZ6BAAQeZ+i1VrLGlKIJDnHczpgt0OfkL2rVCwMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367720; c=relaxed/simple;
	bh=e/PME1+4vL7zTH81pEUZRFHZL1DugfE6n+PNr5qux8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpH/KrP6HsaY2q6MPFTuf4HvxXlpdDDBBpCqfRwmJdzseMPOEfqkdukdVTjIb5hV1KTQGIl7B9jrtz/sJn0s3iVSrfEWXgtTKWbmKnNb3MUlFXQv+oBP3ZuxbpwpRUaCqr5xHW9f9mA5WkMQEAeUs2CUysTNYpJHyBKcT4AHQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: linux-wireless@vger.kernel.org
Cc: greearb@candelatech.com,
	miriam.rachel.korenblit@intel.com,
	johannes@sipsolutions.net,
	cole@unwrap.rs
Subject: [PATCH 3/3] wifi: iwlwifi: mld: skip TX when firmware is dead
Date: Sat,  4 Apr 2026 22:41:45 -0700
Message-ID: <20260405054145.1064152-4-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405054145.1064152-1-cole@unwrap.rs>
References: <20260405054145.1064152-1-cole@unwrap.rs>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34358-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49C3F39D6C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mld/tx.c       | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 71a9a72c9ac0..0df3be3089c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -519,6 +519,10 @@ iwl_mld_mac80211_tx(struct ieee80211_hw *hw,
 	u32 link_id = u32_get_bits(info->control.flags,
 				   IEEE80211_TX_CTRL_MLO_LINK);
 
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
 	/* In AP mode, mgmt frames are sent on the bcast station,
 	 * so the FW can't translate the MLD addr to the link addr. Do it here
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 8af58aabcd68..33bd2e336166 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -962,6 +962,9 @@ void iwl_mld_tx_from_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	struct sk_buff *skb = NULL;
 	u8 zero_addr[ETH_ALEN] = {};
 
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status)))
+		return;
+
 	/*
 	 * No need for threads to be pending here, they can leave the first
 	 * taker all the work.
-- 
2.52.0


