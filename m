Return-Path: <linux-wireless+bounces-11677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323EC95865E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56651F247C2
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AB418FC78;
	Tue, 20 Aug 2024 12:00:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CF18F2C8
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155231; cv=none; b=KOT01JXNYLsYGaDhasiVX2LBtyua9Hc5hmr3xuYCMHo5JN2n6eQ889hNE0psqk4weKaYZ9qZReGcuZ0wnXxgWKIhXAZ72pywuNDjWsFB632n7cApuhDXK+cHm+tMbGlIFBoTTGIBkWF3wMCANvbHjlOzY+oXt9ibEv8q9c8enbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155231; c=relaxed/simple;
	bh=S5zYDxirLfqKRY8VFfa10cqW3syjJTFb8nhA9+uZmg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlFkJ0B5JaEx9SEsQUTyCnji57f7s5H5+j3z0P/7aRz31MIyyX73XGZVOYpHtD4ukoP/paXauyAEHjVHYzsZ0DgWrn/nfiVvSdKfJkvXyWv/DlJhBrwuqWzkSX9XGZI9WKIlh0zzKpLi7HxNMrRW5VvJduHiLOKEeI9u437O2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000td-08; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXF-001lMs-C1; Tue, 20 Aug 2024 14:00:25 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1N;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:42 +0200
Subject: [PATCH 17/31] wifi: mwifiex: fix multiple station handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-17-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=6860;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=S5zYDxirLfqKRY8VFfa10cqW3syjJTFb8nhA9+uZmg0=;
 b=DNW1sPUwO74m7+uVFX750UJwwUTdpa0wPLntRlwhCtCpwke1t+lKoBJQIRVDrUgAOO/7fRlpM
 2ldOq4V/DE5DMU4oKaGVm+y0GvVJ2hme2SrJkG/AC++/yTsTe4ZwJHr
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_is_send_cmd_allowed() and mwifiex_is_tdls_chan_switching() are
called with the first bss in station mode. There can be multiple bss in
station mode and we have to consider all of them, not only the first
one. Instead of the bss priv pass the adapter to these functions and
iterate over the bss as necessary.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 17 +++++----------
 drivers/net/wireless/marvell/mwifiex/main.h |  4 ++--
 drivers/net/wireless/marvell/mwifiex/util.c | 34 +++++++++++++++++------------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index f1f6deaa91122..c1f9b483cb5da 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -330,16 +330,12 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 
 			if ((!adapter->scan_chan_gap_enabled &&
 			     adapter->scan_processing) || adapter->data_sent ||
-			     mwifiex_is_tdls_chan_switching
-			     (mwifiex_get_priv(adapter,
-					       MWIFIEX_BSS_ROLE_STA)) ||
+			     mwifiex_is_tdls_chan_switching(adapter) ||
 			    (mwifiex_wmm_lists_empty(adapter) &&
 			     mwifiex_bypass_txlist_empty(adapter) &&
 			     skb_queue_empty(&adapter->tx_data_q))) {
 				if (adapter->cmd_sent || adapter->curr_cmd ||
-					!mwifiex_is_send_cmd_allowed
-						(mwifiex_get_priv(adapter,
-						MWIFIEX_BSS_ROLE_STA)) ||
+				    !mwifiex_is_send_cmd_allowed(adapter) ||
 				    (!is_command_pending(adapter)))
 					break;
 			}
@@ -387,8 +383,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 		}
 
 		if (!adapter->cmd_sent && !adapter->curr_cmd &&
-		    mwifiex_is_send_cmd_allowed
-		    (mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA))) {
+		    mwifiex_is_send_cmd_allowed(adapter)) {
 			if (mwifiex_exec_next_cmd(adapter) == -1) {
 				ret = -1;
 				break;
@@ -424,8 +419,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 		     !adapter->scan_processing) &&
 		    !adapter->data_sent &&
 		    !mwifiex_bypass_txlist_empty(adapter) &&
-		    !mwifiex_is_tdls_chan_switching
-			(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA))) {
+		    !mwifiex_is_tdls_chan_switching(adapter)) {
 			if (adapter->hs_activated_manually) {
 				mwifiex_cancel_hs(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY),
 						  MWIFIEX_ASYNC_CMD);
@@ -443,8 +437,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 		if ((adapter->scan_chan_gap_enabled ||
 		     !adapter->scan_processing) &&
 		    !adapter->data_sent && !mwifiex_wmm_lists_empty(adapter) &&
-		    !mwifiex_is_tdls_chan_switching
-			(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA))) {
+		    !mwifiex_is_tdls_chan_switching(adapter)) {
 			if (adapter->hs_activated_manually) {
 				mwifiex_cancel_hs(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY),
 						  MWIFIEX_ASYNC_CMD);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 0f75d69ada924..d3c04402a4f22 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1565,8 +1565,8 @@ struct mwifiex_sta_node *
 mwifiex_add_sta_entry(struct mwifiex_private *priv, const u8 *mac);
 struct mwifiex_sta_node *
 mwifiex_get_sta_entry(struct mwifiex_private *priv, const u8 *mac);
-u8 mwifiex_is_tdls_chan_switching(struct mwifiex_private *priv);
-u8 mwifiex_is_send_cmd_allowed(struct mwifiex_private *priv);
+u8 mwifiex_is_tdls_chan_switching(struct mwifiex_adapter *adapter);
+u8 mwifiex_is_send_cmd_allowed(struct mwifiex_adapter *adapter);
 int mwifiex_send_tdls_data_frame(struct mwifiex_private *priv, const u8 *peer,
 				 u8 action_code, u8 dialog_token,
 				 u16 status_code, const u8 *extra_ies,
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index ea28d604ee69c..078877161ab7c 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -634,13 +634,19 @@ mwifiex_get_sta_entry(struct mwifiex_private *priv, const u8 *mac)
 }
 
 static struct mwifiex_sta_node *
-mwifiex_get_tdls_sta_entry(struct mwifiex_private *priv, u8 status)
+mwifiex_get_tdls_sta_entry(struct mwifiex_adapter *adapter, u8 status)
 {
+	struct mwifiex_private *priv;
 	struct mwifiex_sta_node *node;
+	int i;
 
-	list_for_each_entry(node, &priv->sta_list, list) {
-		if (node->tdls_status == status)
-			return node;
+	for (i = 0; i < adapter->priv_num; i++) {
+                priv = adapter->priv[i];
+
+		list_for_each_entry(node, &priv->sta_list, list) {
+			if (node->tdls_status == status)
+				return node;
+		}
 	}
 
 	return NULL;
@@ -649,28 +655,28 @@ mwifiex_get_tdls_sta_entry(struct mwifiex_private *priv, u8 status)
 /* If tdls channel switching is on-going, tx data traffic should be
  * blocked until the switching stage completed.
  */
-u8 mwifiex_is_tdls_chan_switching(struct mwifiex_private *priv)
+u8 mwifiex_is_tdls_chan_switching(struct mwifiex_adapter *adapter)
 {
 	struct mwifiex_sta_node *sta_ptr;
 
-	if (!priv || !ISSUPP_TDLS_ENABLED(priv->adapter->fw_cap_info))
+	if (!ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
 		return false;
 
-	sta_ptr = mwifiex_get_tdls_sta_entry(priv, TDLS_CHAN_SWITCHING);
+	sta_ptr = mwifiex_get_tdls_sta_entry(adapter, TDLS_CHAN_SWITCHING);
 	if (sta_ptr)
 		return true;
 
 	return false;
 }
 
-static u8 mwifiex_is_tdls_off_chan(struct mwifiex_private *priv)
+static u8 mwifiex_is_tdls_off_chan(struct mwifiex_adapter *adapter)
 {
 	struct mwifiex_sta_node *sta_ptr;
 
-	if (!priv || !ISSUPP_TDLS_ENABLED(priv->adapter->fw_cap_info))
+	if (!ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
 		return false;
 
-	sta_ptr = mwifiex_get_tdls_sta_entry(priv, TDLS_IN_OFF_CHAN);
+	sta_ptr = mwifiex_get_tdls_sta_entry(adapter, TDLS_IN_OFF_CHAN);
 	if (sta_ptr)
 		return true;
 
@@ -680,13 +686,13 @@ static u8 mwifiex_is_tdls_off_chan(struct mwifiex_private *priv)
 /* If tdls channel switching is on-going or tdls operate on off-channel,
  * cmd path should be blocked until tdls switched to base-channel.
  */
-u8 mwifiex_is_send_cmd_allowed(struct mwifiex_private *priv)
+u8 mwifiex_is_send_cmd_allowed(struct mwifiex_adapter *adapter)
 {
-	if (!priv || !ISSUPP_TDLS_ENABLED(priv->adapter->fw_cap_info))
+	if (!ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
 		return true;
 
-	if (mwifiex_is_tdls_chan_switching(priv) ||
-	    mwifiex_is_tdls_off_chan(priv))
+	if (mwifiex_is_tdls_chan_switching(adapter) ||
+	    mwifiex_is_tdls_off_chan(adapter))
 		return false;
 
 	return true;

-- 
2.39.2


