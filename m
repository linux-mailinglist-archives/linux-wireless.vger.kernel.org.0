Return-Path: <linux-wireless+bounces-18335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5186A269CF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 02:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AF57A35B9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0542D8635C;
	Tue,  4 Feb 2025 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lhUlg8rx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DC3BBC1;
	Tue,  4 Feb 2025 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738632326; cv=none; b=sxJqvWuFFrkpXbV2e6tLyCBnix0I3iKwyP+ywFGa6h/RYIlpWqr0XO6+Rgyb7l4NMWprU2sxwFTzSjbIM8E3gyei0URrXXnvv3j1GglH1tdrBZZX/RRjo23eR8QYlhL8n/572aV3DclWbHkUuFm9Ti9cR6Hs3ohY+8XyDQM6Xkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738632326; c=relaxed/simple;
	bh=fuYIapzo7q+Y+EmF18p2XpIoz5LCXXhWBhYZS0d3MSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=to6egABVvJYqOp6yfBliCeXKuoREeBUUwfOpxkLuh2E6XfNN1mV7ka2Co4GsC6b+hKdI+PdzcoIxZZHz3No9p5LBIzFcXWk1/foCewrAcnE18fTZqztsb1jvaYofxIMr64V0iLbw9PKCVe/YNrNmR4qV/MF1+2E+sYW6lZP9kkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=lhUlg8rx; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=3okuBbqTLDNlW8g7GCyvjkszQB62i6TRc8dfHbos6PI=; b=lhUlg8rxXdl3JHZH
	0R3iAfzrYGPePcf7pkTl8uJCM77giH0Pneh72TDQAC4fQKUL9zsPpXcs8H+5s8dWpXbKEha5bPCB/
	+QJFrIPd8AOwDBPDVVSt5pD1l6PjxIhLqqZRRu/zO57Dt9s9MkKLB8OCtTZ014w7ao7pnTYJsWWc9
	2X84MpMViuxVQyOlIhBvFpbnOtUlA3Wug08kR/SVtzpC0G5gBeahVUup76d8HJVNA1BGlx7ePTUir
	VcI33kWBLOvY0Wgvt2jB2AiR7rHBRzySQ1YyiiAeg8WqSqjQkpF7L9xuRnRGO659+Mthss8RGAyAd
	T64Ty38t8gbDAMveYw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tf7gf-00DQ0b-0m;
	Tue, 04 Feb 2025 01:25:13 +0000
From: linux@treblig.org
To: briannorris@chromium.org,
	francesco@dolcini.it,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] mwifiex: Remove unused mwifiex_uap_del_sta_data
Date: Tue,  4 Feb 2025 01:25:12 +0000
Message-ID: <20250204012512.390209-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of mwifiex_uap_del_sta_data() was removed in 2014 by
commit dda9ddeb2638 ("mwifiex: do not delete station entries in del_sta
handler")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/marvell/mwifiex/main.h      |  2 --
 drivers/net/wireless/marvell/mwifiex/uap_event.c | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 0674dcf7a537..0e6eff72e54b 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1571,8 +1571,6 @@ void mwifiex_uap_set_channel(struct mwifiex_private *priv,
 			     struct cfg80211_chan_def chandef);
 int mwifiex_config_start_uap(struct mwifiex_private *priv,
 			     struct mwifiex_uap_bss_param *bss_cfg);
-void mwifiex_uap_del_sta_data(struct mwifiex_private *priv,
-			      struct mwifiex_sta_node *node);
 
 void mwifiex_config_uap_11d(struct mwifiex_private *priv,
 			    struct cfg80211_beacon_data *beacon_data);
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 58ef5020a46a..245cb99a3daa 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -325,19 +325,3 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 
 	return 0;
 }
-
-/* This function deletes station entry from associated station list.
- * Also if both AP and STA are 11n enabled, RxReorder tables and TxBA stream
- * tables created for this station are deleted.
- */
-void mwifiex_uap_del_sta_data(struct mwifiex_private *priv,
-			      struct mwifiex_sta_node *node)
-{
-	if (priv->ap_11n_enabled && node->is_11n_enabled) {
-		mwifiex_11n_del_rx_reorder_tbl_by_ta(priv, node->mac_addr);
-		mwifiex_del_tx_ba_stream_tbl_by_ra(priv, node->mac_addr);
-	}
-	mwifiex_del_sta_entry(priv, node->mac_addr);
-
-	return;
-}
-- 
2.48.1


