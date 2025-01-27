Return-Path: <linux-wireless+bounces-18027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F8A1DA88
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0245C3A847F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45320158858;
	Mon, 27 Jan 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="vyPoN4Og"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B98156C79
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995310; cv=none; b=AsWznS1feQiSRLRpmrUzf+sGNNyWEVgdJ7qySXCb9rcRf3bLUdchyi/km8usTReIGLSzmsN0+7UzKGP5o4WLdfREbcrrO2lNFbf/mnL/NTysdsXHGSaWPOD1Dfy214kkbuw2Uay3uyKMXYJkuBh1XRJbT9AFbq6B5m2hGQy8o9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995310; c=relaxed/simple;
	bh=0hSQuwsn3oHCk2z5sQdHgygazfzOWqU0DtQIn02OqlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0ji+QQsusKBkSz9qTF2ehyxzOyDIQeleLgP6JI5kixJT9zqf6WQq0bnDVp8afaFvaJAZ2j3I7pNsk05m7z0O8juqHDn+gwavePhfhjqhM4Oz7vPZ0jk8PW2vKs/Vs5FYu8r7ig8PWf5TPPbYbK0UilVdZUdQ+dBOYojw085rEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=vyPoN4Og; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995298;
	bh=0hSQuwsn3oHCk2z5sQdHgygazfzOWqU0DtQIn02OqlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vyPoN4Ogm52eDMo8skvJPZ/7MUcKXbe/VjSOirTlP8Ia04+LCU1v+TsflTSgeLKIN
	 s7wh2YXJbHSZOkZm0/64SgkT5pxcyfcMDjlqtsoFwmn8UH21ZOy9buj5rrR6CFFTal
	 QpCAubgBFJeS4FnC531/jozA/DXp99KO0AdTYI3w=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [RFC PATCH 08/13] wifi: mac80211: Call ieee80211_tx_h_select_key only once
Date: Mon, 27 Jan 2025 17:26:20 +0100
Message-ID: <20250127162625.20747-9-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_tx_dequeue() already calls ieee80211_tx_h_select_key() when
needed. Move it from invoke_tx_handlers_early() to invoke_tx_handlers()
to avoid calling it twice for TXQs.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
 net/mac80211/tx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d50ca692f348..748edc3dc63a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1691,7 +1691,6 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
 	CALL_TXH(ieee80211_tx_h_check_assoc);
 	CALL_TXH(ieee80211_tx_h_ps_buf);
 	CALL_TXH(ieee80211_tx_h_check_control_port_protocol);
-	CALL_TXH(ieee80211_tx_h_select_key);
 
  txh_done:
 	if (unlikely(res == TX_DROP)) {
@@ -1759,6 +1758,17 @@ static int invoke_tx_handlers(struct ieee80211_tx_data *tx)
 
 	if (r)
 		return r;
+
+	r = ieee80211_tx_h_select_key(tx);
+	if (unlikely(r != TX_CONTINUE)) {
+		I802_DEBUG_INC(tx->local->tx_handlers_drop);
+		if (tx->skb)
+			ieee80211_free_txskb(&tx->local->hw, tx->skb);
+		else
+			ieee80211_purge_tx_queue(&tx->local->hw, &tx->skbs);
+		return -1;
+	}
+
 	return invoke_tx_handlers_late(tx);
 }
 
-- 
2.48.1


