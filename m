Return-Path: <linux-wireless+bounces-35094-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGKgLy1m5mlmvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35094-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 19:45:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36701432010
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 19:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67D183024282
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499433A758B;
	Mon, 20 Apr 2026 17:44:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E11355F35;
	Mon, 20 Apr 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707058; cv=none; b=BVfK00QYrLvD6Np3gjWYxZnrnPSL0qyMgWgWZRlTvzNsw/aI4fCxPYOlgGWeqOjPDWNCz1/NlZ4dg2mJDk8UKNx+AumR2NGzJf9vEHes8CIHivOoXefn2XkHCg4rf7jsHiAtNeBEH/eGzckax2864mmcv81pLSRFufzEnf/ja9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707058; c=relaxed/simple;
	bh=OL8S95UzA5AQbkJJTlTPyxJdS4Grcv4Xh3n1WHpvDkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh1eXuwjuZKSj6y8xF+XY6+FcSXLByxRT53/WTYx/H5k8preprzRWSKFm7QR8o5qxAlD8i1JueVicyrnmjurGZ0J6lcU6NVYM2RJTuC2/bhdCVYwfaQBxDbl8vuslWjXD9gOj6+UdOf/G3RaVOOQALA1/U6brhv96xe1WxWTynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: linux-wireless@vger.kernel.org
Cc: greearb@candelatech.com,
	miriam.rachel.korenblit@intel.com,
	johannes@sipsolutions.net,
	cole@unwrap.rs,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] wifi: iwlwifi: add STATUS_FW_ERROR guards to NAPI/TX-notif paths
Date: Mon, 20 Apr 2026 10:44:04 -0700
Message-ID: <20260420174406.128254-2-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420174406.128254-1-cole@unwrap.rs>
References: <20260420174406.128254-1-cole@unwrap.rs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-35094-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,unwrap.rs:mid,unwrap.rs:email]
X-Rspamd-Queue-Id: 36701432010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After firmware error is detected and STATUS_FW_ERROR is set, NAPI may
still be in-flight from a prior interrupt or get scheduled by the MSIX
IRQ handler before the error bit is processed.  The NAPI poll functions
have no STATUS_FW_ERROR check and will continue processing stale RX ring
entries from dying firmware.

iwl_trans_reclaim() already early-returns on STATUS_FW_ERROR, so any
TX-response notification that makes it through to reclaim is a no-op.
What remains is:

  * CPU spent parsing stale RX inside iwl_pcie_rx_handle() before
    dispatching to the op_mode.
  * No signal in the logs when the race fires, making the
    post-FW-error sequence harder to debug.

Add STATUS_FW_ERROR early-returns with WARN_ONCE() in four places:

  * iwl_pcie_napi_poll()        (legacy NAPI poll)
  * iwl_pcie_napi_poll_msix()   (MSIX NAPI poll)
  * iwl_mld_handle_tx_resp_notif()
  * iwl_mld_handle_compressed_ba_notif()

Rationale:

  1. Stop NAPI from consuming any more RX budget once firmware is
     declared dead; the restart path will re-initialise the rings.
  2. Provide a single, one-shot log line via WARN_ONCE so we can tell
     from a user's dmesg whether the post-error race actually fired in
     their configuration, which has been hard to reproduce outside
     Ben Greear's test rig.

_iwl_trans_pcie_gen2_stop_device() already calls iwl_pcie_rx_napi_sync()
to quiesce NAPI during device teardown, but that runs much later in the
restart sequence; these checks close the window between error detection
and device stop.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Tested-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c       | 19 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 546d09a38dab..e341d12e5233 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -1082,6 +1082,15 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 	bool mgmt = false;
 	bool tx_failure = (status & TX_STATUS_MSK) != TX_STATUS_SUCCESS;
 
+	/* iwl_trans_reclaim() already guards on STATUS_FW_ERROR, but
+	 * bail out earlier (and log once) so we can tell from dmesg
+	 * whether this race actually fires in the field.
+	 */
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
+		WARN_ONCE(1, "iwlwifi: TX resp notif (sta=%d txq=%d) after FW error\n",
+			  sta_id, txq_id);
+		return;
+	}
 	if (IWL_FW_CHECK(mld, tx_resp->frame_count != 1,
 			 "Invalid tx_resp notif frame_count (%d)\n",
 			 tx_resp->frame_count))
@@ -1360,6 +1369,16 @@ void iwl_mld_handle_compressed_ba_notif(struct iwl_mld *mld,
 	u8 sta_id = ba_res->sta_id;
 	struct ieee80211_link_sta *link_sta;
 
+	/* Same rationale as iwl_mld_handle_tx_resp_notif: redundant with
+	 * iwl_trans_reclaim()'s own STATUS_FW_ERROR check, but fails fast
+	 * and logs via WARN_ONCE when the race is actually hit.
+	 */
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
+		WARN_ONCE(1, "iwlwifi: BA notif (sta=%d) after FW error\n",
+			  sta_id);
+		return;
+	}
+
 	if (!tfd_cnt)
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
index fe263cdc2e4f..554c22777ec1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
@@ -1012,6 +1012,15 @@ static int iwl_pcie_napi_poll(struct napi_struct *napi, int budget)
 	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
 	trans = trans_pcie->trans;
 
+	/* Don't process RX for dying firmware; the restart path will
+	 * re-init the rings.  WARN_ONCE helps surface whether this race
+	 * actually fires in user dmesg.
+	 */
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
+		WARN_ONCE(1, "iwlwifi: NAPI poll[%d] invoked after FW error\n",
+			  rxq->id);
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
 
 	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n",
@@ -1039,6 +1048,15 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
 	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
 	trans = trans_pcie->trans;
 
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
+		WARN_ONCE(1,
+			  "iwlwifi: NAPI MSIX poll[%d] invoked after FW error\n",
+			  rxq->id);
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
 	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n", rxq->id, ret,
 		      budget);
-- 
2.52.0

