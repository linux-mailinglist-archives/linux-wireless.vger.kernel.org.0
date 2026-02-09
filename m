Return-Path: <linux-wireless+bounces-31648-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBUiK3ZOiWlm6QQAu9opvQ
	(envelope-from <linux-wireless+bounces-31648-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 04:03:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C81310B470
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 04:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DBB230097D5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 03:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861012EB860;
	Mon,  9 Feb 2026 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="bZCmoPnr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B122836C;
	Mon,  9 Feb 2026 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606186; cv=none; b=FtkHqLNRerYQkjhga6sV5Elv7FiFcQWHSX9i02pAQ9Jrn+ccWStu+CC63zcYLwJD7ZcXaP7WnZsS6XL423FSo1qBaFUPaRt31q7EEhm8iZyWqcUG5SYSj1xBZOHD7s2na3gvpT4BK8Dm89Cu2HZYPrSs41nUmqkT94gAz4Xa1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606186; c=relaxed/simple;
	bh=yiIjT8QBpch/u0ui/vy8LKtqe7lHi4xzIoxFhBemH7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9m9xmbYxc9XSiVKbYTIXtY+qWpRC6CXHdjsUNsNDUEJq9cQUiSy6QI/YF8NROONed99ulz4+PtlGfsr0SEPUp+fJdgnpqlumQEEbkFNsS5XwmKj91YMYyQ+gHjHU7t1xcsWbl5TPxBWUgIYIt0w6yMZgArcO+TzfPPfLSaafk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=bZCmoPnr; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:190d:0:640:bab5:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 407DBC007A;
	Mon, 09 Feb 2026 06:02:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s2H8uoNGO0U0-mHKt1Oao;
	Mon, 09 Feb 2026 06:02:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770606177; bh=vhPBz7+tj7yd+44S6wLmgT5a0ZZddDSRoKD28qCw7Ps=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=bZCmoPnr/0ZZ5DNdGx5ZUaLOr2AHCQ8Wl5WAAJoXcz6YDM74fJQH9g/4kaVcapoBC
	 7+j3Oal/+vsOwJ6dJVgzFH5SFUgBljoFaWafkqkH+NRCRNVaxypZ5hTdlznaZj+YLu
	 YImDJgkIsWmyzzOGj1stgHvY2Psgd0hNQwaqpvsY=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: m.limarencko@yandex.ru
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Limarenko <m.limarencko@yandex.ru>
Subject: [PATCH ath-next 3/4] wifi: ath12k: sanitize invalid MCS metadata in rx path
Date: Mon,  9 Feb 2026 06:02:42 +0300
Message-ID: <20260209030243.1530075-4-m.limarencko@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209030243.1530075-1-m.limarencko@yandex.ru>
References: <20260209030243.1530075-1-m.limarencko@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,yandex.ru];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31648-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yandex.ru];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.limarencko@yandex.ru,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[yandex.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C81310B470
X-Rspamd-Action: no action

From: Mikhail Limarenko <m.limarencko@yandex.ru>

Malformed or unsupported rate metadata from firmware can carry

invalid MCS values into mac80211 status handling.

This was observed with HE MCS=12 and coincided with

ieee80211_rx_list warnings.

When MCS is out of range, fall back to legacy metadata and use

ratelimited diagnostics.

Tested-on: QCNFA765 (WCN785x), kernel 6.18.5+deb13-amd64
Signed-off-by: Mikhail Limarenko <m.limarencko@yandex.ru>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 39 +++++++++++++++----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 99d29ed..f0c56a9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2534,9 +2534,11 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct ath12k_dp_rx_info *rx_
 	case RX_MSDU_START_PKT_TYPE_11N:
 		rx_status->encoding = RX_ENC_HT;
 		if (rate_mcs > ATH12K_HT_MCS_MAX) {
-			ath12k_warn(ar->ab,
-				    "Received with invalid mcs in HT mode %d\n",
-				     rate_mcs);
+			dev_warn_ratelimited(ar->ab->dev,
+					     "ath12k: invalid HT mcs %u, forcing legacy rate metadata\n",
+					     rate_mcs);
+			rx_status->encoding = RX_ENC_LEGACY;
+			rx_status->rate_idx = 0;
 			break;
 		}
 		rx_status->rate_idx = rate_mcs + (8 * (nss - 1));
@@ -2546,42 +2548,47 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct ath12k_dp_rx_info *rx_
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AC:
 		rx_status->encoding = RX_ENC_VHT;
-		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_VHT_MCS_MAX) {
-			ath12k_warn(ar->ab,
-				    "Received with invalid mcs in VHT mode %d\n",
-				     rate_mcs);
+			dev_warn_ratelimited(ar->ab->dev,
+					     "ath12k: invalid VHT mcs %u, forcing legacy rate metadata\n",
+					     rate_mcs);
+			rx_status->encoding = RX_ENC_LEGACY;
+			rx_status->rate_idx = 0;
 			break;
 		}
+		rx_status->rate_idx = rate_mcs;
 		rx_status->nss = nss;
 		if (sgi)
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		rx_status->bw = ath12k_mac_bw_to_mac80211_bw(bw);
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AX:
-		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_HE_MCS_MAX) {
-			ath12k_warn(ar->ab,
-				    "Received with invalid mcs in HE mode %d\n",
-				    rate_mcs);
+			dev_warn_ratelimited(ar->ab->dev,
+					     "ath12k: invalid HE mcs %u, forcing legacy rate metadata\n",
+					     rate_mcs);
+			rx_status->encoding = RX_ENC_LEGACY;
+			rx_status->rate_idx = 0;
 			break;
 		}
 		rx_status->encoding = RX_ENC_HE;
+		rx_status->rate_idx = rate_mcs;
 		rx_status->nss = nss;
 		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
 		rx_status->bw = ath12k_mac_bw_to_mac80211_bw(bw);
 		break;
 	case RX_MSDU_START_PKT_TYPE_11BE:
-		rx_status->rate_idx = rate_mcs;
-
 		if (rate_mcs > ATH12K_EHT_MCS_MAX) {
-			ath12k_warn(ar->ab,
-				    "Received with invalid mcs in EHT mode %d\n",
-				    rate_mcs);
+			dev_warn_ratelimited(ar->ab->dev,
+					     "ath12k: invalid EHT mcs %u, forcing legacy rate metadata\n",
+					     rate_mcs);
+			rx_status->encoding = RX_ENC_LEGACY;
+			rx_status->rate_idx = 0;
 			break;
 		}
 
 		rx_status->encoding = RX_ENC_EHT;
+		rx_status->rate_idx = rate_mcs;
 		rx_status->nss = nss;
 		rx_status->eht.gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
 		rx_status->bw = ath12k_mac_bw_to_mac80211_bw(bw);
-- 
2.47.3


