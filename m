Return-Path: <linux-wireless+bounces-19059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E5DA37CE8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DB4170A4E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9897B155C82;
	Mon, 17 Feb 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="KhowLB+l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5581A23AC
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780260; cv=none; b=EvN1S9Xie8/Ew873XO/TRJLonLNYzsXi1dDTCuAJXWmsfjkPJkWfJixiYl0799klwVAblEeG0SV4CiV/Zq0/PEZ9oYORJ68CbhTyy5EnIBrOd92F2N815Pl0Drvhj2nLjTp+pw5f29IrIMPhQlgP8ljXjC7coYhqna3PPDDE77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780260; c=relaxed/simple;
	bh=aNSm7Mu/wy9S1gyovVo7Ek0mpfaboW8OKnRRpYUi9Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1T4LmeA1rPyVqERhfQJyJwtAjP3bIjuYLNiAP5Dj02fPgydeeGYML18KyDdgPffXpg4nNEMGTiDC1rxJdDZfYccrD+uX7jj+n+jmmRedSysVzFFUfK2ezBeAUhByxnuE70Zv+Ki2GDQO5QVcqrcm5PgWXxZmRWwDblxOJwHJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=KhowLB+l; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739780252;
	bh=aNSm7Mu/wy9S1gyovVo7Ek0mpfaboW8OKnRRpYUi9Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KhowLB+lzhxQcbLr1enhQ1X6J9Tb/CEDX+h2/EWJ4A2K4FXRN1iIFLVjMvgg18x7t
	 MsEJrPl3uiD5HyY3zuyAOK4TF72Ja3oO7YLuQqnwo6pfQDs5hD2ftUtfHfcuzM9t3G
	 68X9w56XTAB26ezo9M48wsSvwAmCnK2ZsvNcripM=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH v2 06/10] wifi: mac80211: Call ieee80211_tx_h_select_key only once
Date: Mon, 17 Feb 2025 09:17:17 +0100
Message-ID: <20250217081721.45110-7-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217081721.45110-1-Alexander@wetzel-home.de>
References: <20250217081721.45110-1-Alexander@wetzel-home.de>
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
index db66deae69a4..7c269d8e5dcf 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1693,7 +1693,6 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
 	CALL_TXH(ieee80211_tx_h_check_assoc);
 	CALL_TXH(ieee80211_tx_h_ps_buf);
 	CALL_TXH(ieee80211_tx_h_check_control_port_protocol);
-	CALL_TXH(ieee80211_tx_h_select_key);
 
  txh_done:
 	if (unlikely(res == TX_DROP)) {
@@ -1761,6 +1760,17 @@ static int invoke_tx_handlers(struct ieee80211_tx_data *tx)
 
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


