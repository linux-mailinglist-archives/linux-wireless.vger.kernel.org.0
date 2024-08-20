Return-Path: <linux-wireless+bounces-11686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC19D95866A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA481F259DB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB677190049;
	Tue, 20 Aug 2024 12:00:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9C18F2E3
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155234; cv=none; b=s49htbXfIcIllSFaFih/QIU0C6kt/4OyNdkQd2IRuPSqpKL5qDVfqEqP8QXtZtvRfhRHqWrsLJduvuuCb7tAgEKlLCpJ8fN/0Ar14NobpVAAsyGAj7nL1khpq/iPyNfxirYQy6yS27zPkZeWopeBL+ucc32DZ935ZApA2Gpemnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155234; c=relaxed/simple;
	bh=nx+bPs22PwXrc8rnhbOBr+PJUh6JL5pHUQ7eHrrw8bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shjj2tV7ln7yXJ9DrNiiWbR1zwGLHkqaJgnWkwleeGHOxQnZVNROIXWfq4WmpP9e7bCCb9B5rKnLag+FkVw33n5H8Gl+kRx8zx/i5v/YcsgdqdLD0bTCor/QwL9mTaxVqZbMgsqDuAdYGoJRIUi4WQVMPzXP73U3JTc73kVDVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000w0-TV; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNV-Du; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1H;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:36 +0200
Subject: [PATCH 11/31] wifi: mwifiex: use priv index as bss_num
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-11-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=8804;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=nx+bPs22PwXrc8rnhbOBr+PJUh6JL5pHUQ7eHrrw8bU=;
 b=lqXV3dxDx31AMp7hdOEcF7dz6ovFFpDQ696GEF7Bf0GOpRkuDQL/DchaqF8B8VeZ3b+sMP1Sp
 DP7HJ/+gj2oByNLfr4Ggj0xuuQwelId5ilpRwlnv5xJv718HRDvbNot
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Instead of looking up an unused bss_num each time we add a virtual
interface, associate a fixed bss_num to each priv and for simplicity
just use the array index.

With bss_num unique to each priv mwifiex_get_priv_by_id() doesn't need
the bss_type argument anymore, so it's removed.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c  | 11 ++---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c    |  6 +--
 drivers/net/wireless/marvell/mwifiex/main.c      |  1 +
 drivers/net/wireless/marvell/mwifiex/main.h      | 54 ++++--------------------
 drivers/net/wireless/marvell/mwifiex/sta_event.c |  3 +-
 drivers/net/wireless/marvell/mwifiex/txrx.c      |  9 ++--
 6 files changed, 19 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 784f342a9bf23..d5a2c8f726b9e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -952,8 +952,6 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
 		return -EOPNOTSUPP;
 	}
 
-	priv->bss_num = mwifiex_get_unused_bss_num(adapter, priv->bss_type);
-
 	spin_lock_irqsave(&adapter->main_proc_lock, flags);
 	adapter->main_locked = false;
 	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
@@ -2999,8 +2997,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			return ERR_PTR(-EINVAL);
 		}
 
-		priv = mwifiex_get_unused_priv_by_bss_type(
-						adapter, MWIFIEX_BSS_TYPE_STA);
+		priv = mwifiex_get_unused_priv(adapter);
 		if (!priv) {
 			mwifiex_dbg(adapter, ERROR,
 				    "could not get free private struct\n");
@@ -3029,8 +3026,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			return ERR_PTR(-EINVAL);
 		}
 
-		priv = mwifiex_get_unused_priv_by_bss_type(
-						adapter, MWIFIEX_BSS_TYPE_UAP);
+		priv = mwifiex_get_unused_priv(adapter);
 		if (!priv) {
 			mwifiex_dbg(adapter, ERROR,
 				    "could not get free private struct\n");
@@ -3056,8 +3052,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 			return ERR_PTR(-EINVAL);
 		}
 
-		priv = mwifiex_get_unused_priv_by_bss_type(
-						adapter, MWIFIEX_BSS_TYPE_P2P);
+		priv = mwifiex_get_unused_priv(adapter);
 		if (!priv) {
 			mwifiex_dbg(adapter, ERROR,
 				    "could not get free private struct\n");
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 4f814110f750e..d91351384c6bb 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -496,8 +496,7 @@ int mwifiex_process_event(struct mwifiex_adapter *adapter)
 							(u16) eventcause;
 
 	/* Get BSS number and corresponding priv */
-	priv = mwifiex_get_priv_by_id(adapter, EVENT_GET_BSS_NUM(eventcause),
-				      EVENT_GET_BSS_TYPE(eventcause));
+	priv = mwifiex_get_priv_by_id(adapter, EVENT_GET_BSS_NUM(eventcause));
 	if (!priv)
 		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
 
@@ -847,8 +846,7 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 
 	/* Get BSS number and corresponding priv */
 	priv = mwifiex_get_priv_by_id(adapter,
-			     HostCmd_GET_BSS_NO(le16_to_cpu(resp->seq_num)),
-			     HostCmd_GET_BSS_TYPE(le16_to_cpu(resp->seq_num)));
+			     HostCmd_GET_BSS_NO(le16_to_cpu(resp->seq_num)));
 	if (!priv)
 		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
 	/* Clear RET_BIT from HostCmd */
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 7cb90a6a8ccab..888f2801d6f2a 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -85,6 +85,7 @@ static int mwifiex_register(void *card, struct device *dev,
 		if (!adapter->priv[i])
 			goto error;
 
+		adapter->priv[i]->bss_num = i;
 		adapter->priv[i]->adapter = adapter;
 		adapter->priv_num++;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 541bc50a9561c..2938e55a38d79 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1297,20 +1297,12 @@ mwifiex_copy_rates(u8 *dest, u32 pos, u8 *src, int len)
  * upon the BSS type and BSS number.
  */
 static inline struct mwifiex_private *
-mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
-		       u8 bss_num, u8 bss_type)
+mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter, u8 bss_num)
 {
-	int i;
-
-	for (i = 0; i < adapter->priv_num; i++) {
-		if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
-			continue;
+	if (bss_num >= MWIFIEX_MAX_BSS_NUM)
+		return NULL;
 
-		if ((adapter->priv[i]->bss_num == bss_num) &&
-		    (adapter->priv[i]->bss_type == bss_type))
-			break;
-	}
-	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
+	return adapter->priv[bss_num];
 }
 
 /*
@@ -1332,47 +1324,19 @@ mwifiex_get_priv(struct mwifiex_adapter *adapter,
 	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
 }
 
-/*
- * This function checks available bss_num when adding new interface or
- * changing interface type.
- */
-static inline u8
-mwifiex_get_unused_bss_num(struct mwifiex_adapter *adapter, u8 bss_type)
-{
-	u8 i, j;
-	int index[MWIFIEX_MAX_BSS_NUM];
-
-	memset(index, 0, sizeof(index));
-	for (i = 0; i < adapter->priv_num; i++)
-		if (adapter->priv[i]->bss_type == bss_type &&
-		    !(adapter->priv[i]->bss_mode ==
-		      NL80211_IFTYPE_UNSPECIFIED)) {
-			index[adapter->priv[i]->bss_num] = 1;
-		}
-	for (j = 0; j < MWIFIEX_MAX_BSS_NUM; j++)
-		if (!index[j])
-			return j;
-	return -1;
-}
-
 /*
  * This function returns the first available unused private structure pointer.
  */
 static inline struct mwifiex_private *
-mwifiex_get_unused_priv_by_bss_type(struct mwifiex_adapter *adapter,
-				    u8 bss_type)
+mwifiex_get_unused_priv(struct mwifiex_adapter *adapter)
 {
-	u8 i;
+	int i;
 
 	for (i = 0; i < adapter->priv_num; i++)
-		if (adapter->priv[i]->bss_mode ==
-		   NL80211_IFTYPE_UNSPECIFIED) {
-			adapter->priv[i]->bss_num =
-			mwifiex_get_unused_bss_num(adapter, bss_type);
-			break;
-		}
+		if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
+			return adapter->priv[i];
 
-	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
+	return NULL;
 }
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index b5f3821a6a8f2..15f057d010a3d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -456,8 +456,7 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
 		for (i = 0; i < intf_num; i++) {
 			bss_type = grp_info->bss_type_numlist[i] >> 4;
 			bss_num = grp_info->bss_type_numlist[i] & BSS_NUM_MASK;
-			intf_priv = mwifiex_get_priv_by_id(adapter, bss_num,
-							   bss_type);
+			intf_priv = mwifiex_get_priv_by_id(adapter, bss_num);
 			if (!intf_priv) {
 				mwifiex_dbg(adapter, ERROR,
 					    "Invalid bss_type bss_num\t"
diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
index f44e22f245110..21cfee3290377 100644
--- a/drivers/net/wireless/marvell/mwifiex/txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/txrx.c
@@ -31,8 +31,7 @@ int mwifiex_handle_rx_packet(struct mwifiex_adapter *adapter,
 
 	local_rx_pd = (struct rxpd *) (skb->data);
 	/* Get the BSS number from rxpd, get corresponding priv */
-	priv = mwifiex_get_priv_by_id(adapter, local_rx_pd->bss_num &
-				      BSS_NUM_MASK, local_rx_pd->bss_type);
+	priv = mwifiex_get_priv_by_id(adapter, local_rx_pd->bss_num & BSS_NUM_MASK);
 	if (!priv)
 		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
 
@@ -165,8 +164,7 @@ static int mwifiex_host_to_card(struct mwifiex_adapter *adapter,
 	struct mwifiex_txinfo *tx_info;
 
 	tx_info = MWIFIEX_SKB_TXCB(skb);
-	priv = mwifiex_get_priv_by_id(adapter, tx_info->bss_num,
-				      tx_info->bss_type);
+	priv = mwifiex_get_priv_by_id(adapter, tx_info->bss_num);
 	if (!priv) {
 		mwifiex_dbg(adapter, ERROR,
 			    "data: priv not found. Drop TX packet\n");
@@ -281,8 +279,7 @@ int mwifiex_write_data_complete(struct mwifiex_adapter *adapter,
 		return 0;
 
 	tx_info = MWIFIEX_SKB_TXCB(skb);
-	priv = mwifiex_get_priv_by_id(adapter, tx_info->bss_num,
-				      tx_info->bss_type);
+	priv = mwifiex_get_priv_by_id(adapter, tx_info->bss_num);
 	if (!priv)
 		goto done;
 

-- 
2.39.2


