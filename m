Return-Path: <linux-wireless+bounces-37419-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5/RYO+bDImqfdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37419-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 14:41:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B764840D
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 14:41:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nbd.name header.s=20160729 header.b=BOLZWJsd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37419-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37419-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nbd.name (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E11BB3029C8D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C512533D6;
	Fri,  5 Jun 2026 12:31:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB631D759
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 12:31:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662664; cv=none; b=B+V6L3m/LISXZAyW2AEazymCUqmXV5Pi2rMlZcOYVw6R8S+tDD06dEYqgWC2gtv2so+9QaBknaTDKPPgBuyewoxvwxiGRRwxBY9sj2hHduYUHlB6Fwte73fl+HSc6LPdSESSjmxU7a7qXbtvPA9lEKjBMWqNV9gwkTKE1G30AIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662664; c=relaxed/simple;
	bh=aN7O/9JOkB/W5Sa4kZM/lrcVrMvKrxOWCtuVkdEGxSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sle45hJpx/5QtJKHrhXc7MlM4gqh0LU00+eUSMJD1YqOpHls4/RxYiPJ52oQDi0e1AQG+S4hYqDct2aWnwIwc6za6aB3LzUjxq7Z5p2m9RMLWxjk/9bumohmhNYpxeKBs+zvWoaQ/3dmX7araDjC+ncRAJEflMdABOgL8fI0Mfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=BOLZWJsd; arc=none smtp.client-ip=46.4.11.11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fv6+DUlClQU8LV8EwPunpfEQqxkL+zJsp2cnE+4ryiM=; b=BOLZWJsdw/ODCIwqlbagJdK/Bb
	QAch2jxVez+hkz9OValbbhYjWuAqjHBoJ5xRj+HBD6ltxlpTxTC6cWXwozB6EkcyDPXl6228YSIcP
	7olteb8Y6GoL9DojSIv1o335SArqXck3qnHUlAWNMswJt7DFTqce2Fb7IQA1HXhcEZ9k=;
Received: from p200300cadf03d5009ebf0dfffe00fa2d.dip0.t-ipconnect.de ([2003:ca:df03:d500:9ebf:dff:fe00:fa2d] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1wVThO-0090er-0U;
	Fri, 05 Jun 2026 14:30:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless-next v3 1/4] wifi: mac80211: factor out part of ieee80211_calc_expected_tx_airtime
Date: Fri,  5 Jun 2026 12:30:46 +0000
Message-ID: <20260605123049.1128869-1-nbd@nbd.name>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37419-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nbd.name:-];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nbd.name:mid,nbd.name:from_mime,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 924B764840D

Create ieee80211_rate_expected_tx_airtime helper function, which returns
the expected tx airtime for a given rate and packet length in units of
1/1024 usec, for more accuracy.

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
index 18a101710432..896397e9408f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2916,6 +2916,11 @@ u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
 
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
2.53.0


