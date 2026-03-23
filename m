Return-Path: <linux-wireless+bounces-33704-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOrjNDUUwWnkQQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33704-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:21:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E92EFEB2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5C13301A7BF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD638B7A4;
	Mon, 23 Mar 2026 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="YKxCwqj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302938C2C7
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261201; cv=none; b=llzaH6e9X7AoenuVzXmXW9m4oYzkrNh3HOQi5xrRxntYCiHrIjEVyhczUVpGYHwRMfgJqsorQk+erLYNx9NSDIVYuQHlcR2EPUriow2iRNWM1QysziRcg1QMYuqFqhWmU7cxbROYGplBpf0w1Q+8qLB6aS3bhjl9+PIOj16tsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261201; c=relaxed/simple;
	bh=7J/ZGoE9WalnOJXlcDFsF7bBKBjpV9X4lLisT3gkY7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=leiLai/JPy0RepdfkGuQvig5tMJNymLz4ra+H3Y/fqQaF5iCSWNSSlqUpcEwZW4GsixMcuK7MBP9vSsLuJhVovU6+cKKRHqJKGFbyzWYzYT9OPMARf3ueep8WiL7SkcksMR/h+uSWvCQjxdF3bzBj0x7uIwSAG+w1XGsra1YSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=YKxCwqj9; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Qh3QWMjsVj42x7CjrtGVxV/fENELE1KjGrLxML2Apgs=; b=YKxCwqj9A4mGITqWbwOchBzqWD
	oT6nBcSmh6lONCbTDUm7VLWbGWoS4ZiGkgN9hOKhR7SifKAsEVlHT56IWAHBOE9mice3M/1uC0DmC
	g8L8RmL1GAUX0rPaylCMHEU7awpJLryxXMSuqJOJJbkG/iMVlZQ4jy4Ljwif+Xi3eC8I=;
Received: from p200300cadf30ee00000000000000085c.dip0.t-ipconnect.de ([2003:ca:df30:ee00::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w4cO4-00ALUX-2J;
	Mon, 23 Mar 2026 11:19:56 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 1/4] wifi: mac80211: factor out part of ieee80211_calc_expected_tx_airtime
Date: Mon, 23 Mar 2026 10:19:51 +0000
Message-ID: <20260323101954.874299-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33704-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.818];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C04E92EFEB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Create ieee80211_rate_expected_tx_airtime helper function, which returns
the expected tx airtime for a given rate and packet length in units of
1024 usec, for more accuracy.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/airtime.c     | 87 ++++++++++++++++++++++----------------
 net/mac80211/ieee80211_i.h |  5 +++
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index c61df637232a..0c54cdbd753c 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -685,7 +685,7 @@ static int ieee80211_fill_rx_status(struct ieee80211_rx_status *stat,
 	if (ieee80211_fill_rate_info(hw, stat, band, ri))
 		return 0;
 
-	if (!ieee80211_rate_valid(rate))
+	if (!rate || !ieee80211_rate_valid(rate))
 		return -1;
 
 	if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
@@ -753,6 +753,53 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(ieee80211_calc_tx_airtime);
 
+u32 ieee80211_rate_expected_tx_airtime(struct ieee80211_hw *hw,
+				       struct ieee80211_tx_rate *tx_rate,
+				       struct rate_info *ri,
+				       enum nl80211_band band,
+				       bool ampdu, int len)
+{
+	struct ieee80211_rx_status stat;
+	u32 duration, overhead;
+	u8 agg_shift;
+
+	if (ieee80211_fill_rx_status(&stat, hw, tx_rate, ri, band, len))
+		return 0;
+
+	if (stat.encoding == RX_ENC_LEGACY || !ampdu)
+		return ieee80211_calc_rx_airtime(hw, &stat, len) * 1024;
+
+	duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
+
+	/*
+	 * Assume that HT/VHT transmission on any AC except VO will
+	 * use aggregation. Since we don't have reliable reporting
+	 * of aggregation length, assume an average size based on the
+	 * tx rate.
+	 * This will not be very accurate, but much better than simply
+	 * assuming un-aggregated tx in all cases.
+	 */
+	if (duration > 400 * 1024) /* <= VHT20 MCS2 1S */
+		agg_shift = 1;
+	else if (duration > 250 * 1024) /* <= VHT20 MCS3 1S or MCS1 2S */
+		agg_shift = 2;
+	else if (duration > 150 * 1024) /* <= VHT20 MCS5 1S or MCS2 2S */
+		agg_shift = 3;
+	else if (duration > 70 * 1024) /* <= VHT20 MCS5 2S */
+		agg_shift = 4;
+	else if (stat.encoding != RX_ENC_HE ||
+		 duration > 20 * 1024) /* <= HE40 MCS6 2S */
+		agg_shift = 5;
+	else
+		agg_shift = 6;
+
+	duration *= len;
+	duration /= AVG_PKT_SIZE;
+	duration += (overhead * 1024 >> agg_shift);
+
+	return duration;
+}
+
 u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *pubsta,
@@ -775,45 +822,13 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 	if (pubsta) {
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
 						    sta);
-		struct ieee80211_rx_status stat;
 		struct ieee80211_tx_rate *tx_rate = &sta->deflink.tx_stats.last_rate;
 		struct rate_info *ri = &sta->deflink.tx_stats.last_rate_info;
-		u32 duration, overhead;
-		u8 agg_shift;
+		u32 duration;
 
-		if (ieee80211_fill_rx_status(&stat, hw, tx_rate, ri, band, len))
-			return 0;
-
-		if (stat.encoding == RX_ENC_LEGACY || !ampdu)
-			return ieee80211_calc_rx_airtime(hw, &stat, len);
-
-		duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
-		/*
-		 * Assume that HT/VHT transmission on any AC except VO will
-		 * use aggregation. Since we don't have reliable reporting
-		 * of aggregation length, assume an average size based on the
-		 * tx rate.
-		 * This will not be very accurate, but much better than simply
-		 * assuming un-aggregated tx in all cases.
-		 */
-		if (duration > 400 * 1024) /* <= VHT20 MCS2 1S */
-			agg_shift = 1;
-		else if (duration > 250 * 1024) /* <= VHT20 MCS3 1S or MCS1 2S */
-			agg_shift = 2;
-		else if (duration > 150 * 1024) /* <= VHT20 MCS5 1S or MCS2 2S */
-			agg_shift = 3;
-		else if (duration > 70 * 1024) /* <= VHT20 MCS5 2S */
-			agg_shift = 4;
-		else if (stat.encoding != RX_ENC_HE ||
-			 duration > 20 * 1024) /* <= HE40 MCS6 2S */
-			agg_shift = 5;
-		else
-			agg_shift = 6;
-
-		duration *= len;
-		duration /= AVG_PKT_SIZE;
+		duration = ieee80211_rate_expected_tx_airtime(hw, tx_rate, ri,
+							      band, true, len);
 		duration /= 1024;
-		duration += (overhead >> agg_shift);
 
 		return max_t(u32, duration, 4);
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d71e0c6d2165..b0dc93399e95 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2834,6 +2834,11 @@ u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
 
 extern const struct ethtool_ops ieee80211_ethtool_ops;
 
+u32 ieee80211_rate_expected_tx_airtime(struct ieee80211_hw *hw,
+				       struct ieee80211_tx_rate *tx_rate,
+				       struct rate_info *ri,
+				       enum nl80211_band band,
+				       bool ampdu, int len);
 u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *pubsta,
-- 
2.51.0


