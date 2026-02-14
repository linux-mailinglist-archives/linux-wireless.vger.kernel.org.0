Return-Path: <linux-wireless+bounces-31835-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GMOLuC7kGm8cgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31835-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 19:16:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E413CC9D
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 19:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9BDF3007F41
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9722FCC06;
	Sat, 14 Feb 2026 18:12:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC330F951
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092746; cv=none; b=FA3iTNQFLxkTPfiPYm1r9rFlRsm1cDYfBVC8N/4yILOLHN2af3tlksFlD/inqG2kbljOo7ncNKk2/KDEs2a38TINxzdNzCJRvFlkbfmRRfUyYzsqN+me5GtuodMunIqIuywyaTWP4qHxrhNZMyPKXq40Zz+oG7CnC96qqosiKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092746; c=relaxed/simple;
	bh=fjkLe8IFueXZBa21euR8KzjUKUPP5F1qeoHYl2cK2bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4AdnJ/p1YbwSOe17brQMG2dEPDiKNJMYTUezC7u1zlxh0XmFYcHef3TZEDeClrcEWU04vWtK3o5R3/czXDpgdxxrvwMswPLq4VMZGW/VE0ZL58UMM0nfEuShrKo+gtOpqH6CyjxkTdsFokTdnhmb80jpsijGniqZzcEdvJ5g68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
From: Cole Leavitt <cole@unwrap.rs>
To: greearb@candelatech.com,
	johannes.berg@intel.com,
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Cole Leavitt <cole@unwrap.rs>
Subject: [PATCH] wifi: iwlwifi: prevent NAPI processing after firmware error
Date: Sat, 14 Feb 2026 11:10:18 -0700
Message-ID: <20260214181018.6091-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <c6f886d4-b9ed-48a6-9723-a738af055b64@candelatech.com>
References: <c6f886d4-b9ed-48a6-9723-a738af055b64@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31835-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 1D2E413CC9D
X-Rspamd-Action: no action

After a firmware error is detected and STATUS_FW_ERROR is set, NAPI can
still be actively polling or get scheduled from a prior interrupt. The
NAPI poll functions (both legacy and MSIX variants) have no check for
STATUS_FW_ERROR and will continue processing stale RX ring entries from
dying firmware. This can dispatch TX completion notifications containing
corrupt SSN values to iwl_mld_handle_tx_resp_notif(), which passes them
to iwl_trans_reclaim(). If the corrupt SSN causes reclaim to walk TX
queue entries that were already freed by a prior correct reclaim, the
result is an skb use-after-free or double-free.

The race window opens when the MSIX IRQ handler schedules NAPI (lines
2319-2321 in rx.c) before processing the error bit (lines 2382-2396),
or when NAPI is already running on another CPU from a previous interrupt
when STATUS_FW_ERROR gets set on the current CPU.

Add STATUS_FW_ERROR checks to both NAPI poll functions to prevent
processing stale RX data after firmware error, and add early-return
guards in the TX response and compressed BA notification handlers as
defense-in-depth. Each check uses WARN_ONCE to log if the race is
actually hit, which aids diagnosis of the hard-to-reproduce skb
use-after-free reported on Intel BE200.

Note that _iwl_trans_pcie_gen2_stop_device() already calls
iwl_pcie_rx_napi_sync() to quiesce NAPI during device teardown, but that
runs much later in the restart sequence. These checks close the window
between error detection and device stop.

Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---
Tested on Intel BE200 (FW 101.6e695a70.0) by forcing NMI via debugfs.
The WARN_ONCE fires reliably:

  iwlwifi: NAPI MSIX poll[0] invoked after FW error
  WARNING: drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c:1058
           at iwl_pcie_napi_poll_msix+0xff/0x130 [iwlwifi], CPU#22

Confirming NAPI poll is invoked after STATUS_FW_ERROR is set. Without
this patch, that poll processes stale RX ring data from dead firmware.

 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 19 ++++++++++++++++++
 .../wireless/intel/iwlwifi/pcie/gen1_2/rx.c   | 20 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 3b4b575aadaa..3e99f3ded9bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -1071,6 +1071,18 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 	bool mgmt = false;
 	bool tx_failure = (status & TX_STATUS_MSK) != TX_STATUS_SUCCESS;
 
+	/* Firmware is dead — the TX response may contain corrupt SSN values
+	 * from a dying firmware DMA. Processing it could cause
+	 * iwl_trans_reclaim() to free the wrong TX queue entries, leading to
+	 * skb use-after-free or double-free.
+	 */
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
+		WARN_ONCE(1,
+			  "iwlwifi: TX resp notif (sta=%d txq=%d) after FW error\n",
+			  sta_id, txq_id);
+		return;
+	}
+
 	if (IWL_FW_CHECK(mld, tx_resp->frame_count != 1,
 			 "Invalid tx_resp notif frame_count (%d)\n",
 			 tx_resp->frame_count))
@@ -1349,6 +1361,13 @@ void iwl_mld_handle_compressed_ba_notif(struct iwl_mld *mld,
 	u8 sta_id = ba_res->sta_id;
 	struct ieee80211_link_sta *link_sta;
 
+	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
+		WARN_ONCE(1,
+			  "iwlwifi: BA notif (sta=%d) after FW error\n",
+			  sta_id);
+		return;
+	}
+
 	if (!tfd_cnt)
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
index 619a9505e6d9..ba18d35fa55d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
@@ -1015,6 +1015,18 @@ static int iwl_pcie_napi_poll(struct napi_struct *napi, int budget)
 	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
 	trans = trans_pcie->trans;
 
+	/* Stop processing RX if firmware has crashed. Stale notifications
+	 * from dying firmware (e.g. TX completions with corrupt SSN values)
+	 * can cause use-after-free in reclaim paths.
+	 */
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
+		WARN_ONCE(1,
+			  "iwlwifi: NAPI poll[%d] invoked after FW error\n",
+			  rxq->id);
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
 
 	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n",
@@ -1042,6 +1054,14 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
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


