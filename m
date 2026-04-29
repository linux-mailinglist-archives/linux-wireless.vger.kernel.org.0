Return-Path: <linux-wireless+bounces-35625-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KumAMgJ8mlXnAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35625-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:38:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27715494F79
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C449306A7CE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183453FD14F;
	Wed, 29 Apr 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OMkDFQYs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8003D1CDF
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469221; cv=none; b=mWLpkG2SIexka0wlNnqB+j9SN5xi7Z72UFdw95nFpMQmh/SZgv2JdI2T1pJdNxpdvJXCtZSEEhuSVnNKsio7r4gnv67sdplOyOkMIAsxXcaG3q0WMMLHJL3XloJwLuKXGn68G6C7xO1tZkg01ShGL3mvW46QrrbdOu8ljpI/joY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469221; c=relaxed/simple;
	bh=f2LFiKvvLskfJEBLxWSDIhU9LRrEpFv4gsrxS3bUU0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDA4yR0lAjScPiXoE8XtG9piFCIxDGlNQy3LgDoXjX+s+AOqbqwTIsgJQvSFSHYVUFF2gsG/d2Fd1V3Cr/C5xKb7VXbYmRIvh8Fu+F3DrAnnKDfYdNK0fnAOEdNhVErp3XKexU/bvrvz3Z0RPvZmG0OoEyKSeRCBnhb5UbQz4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OMkDFQYs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63TDQvmA61223098, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777469217; bh=Bk6apK8teg2MhKlnn6K5uSXgiKTGyZGFzigioZe2uOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OMkDFQYsKH2EXCjOlvYpfK03gYt9jK0LgD1zWOQyv91T9RvysDxckCz7zjNPrSAOd
	 KgEqP4h/mSzQRvwLlqXfLidT4qD4Y5+zGcve9JjMSCf1qNntemVk58dSzYJqPoC0/C
	 R+XtPCoK8UI+jK0Lp9utnYgo+lEn9RD63DRIHnIUucdEXEm7epv1GfZsOen+drA7Wz
	 6gpOE+KExlc+zzExhfTVPssaumoCJ73ZQQawYBq4ELlQQfpsW5qcSjqQ0OFmyxrRF2
	 sygfKJmXJdx6XVhSEpPfEt5Wy1MLa0LQqLRyuJezjlYctn+4MVPPqsrvL51vNRRXDU
	 s0Wqeuw+gQ9MQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63TDQvmA61223098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:26:57 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:57 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 21:26:57 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 21:26:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 6/7] wifi: rtw89: debug: add RX statistics in bb_info
Date: Wed, 29 Apr 2026 21:26:24 +0800
Message-ID: <20260429132625.1659182-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429132625.1659182-1-pkshih@realtek.com>
References: <20260429132625.1659182-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 27715494F79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35625-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Kuan-Chung Chen <damon.chen@realtek.com>

Expand RX packet statistics including coding type, spatial
diversity, and beamforming. These statistics are accumulated
per PHY and displayed in bb_info debugfs.

RX statistics output:

  == RX General
  LDPC: 190, BCC: 0, STBC: 0, SU_NON_BF: 0, SU_BF: 190, MU: 0

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 26 +++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h  | 10 +++++++++
 drivers/net/wireless/realtek/rtw89/debug.c |  8 +++++++
 drivers/net/wireless/realtek/rtw89/txrx.h  |  2 ++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d8f83623e54a..b85728ceb63c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2097,11 +2097,8 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev,
 	u32 t;
 
 	phy_ppdu->chan_idx = le32_get_bits(ie->w0, RTW89_PHY_STS_IE01_W0_CH_IDX);
-
-	if (rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR) {
-		phy_ppdu->ldpc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_LDPC);
-		phy_ppdu->stbc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_STBC);
-	}
+	phy_ppdu->ldpc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_LDPC);
+	phy_ppdu->stbc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_STBC);
 
 	if (!phy_ppdu->hdr_2_en)
 		phy_ppdu->rx_path_en =
@@ -2114,9 +2111,11 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev,
 		return;
 
 	phy_ppdu->rpl_avg = le32_get_bits(ie->w0, RTW89_PHY_STS_IE01_W0_RSSI_AVG_FD);
+	phy_ppdu->su = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_SU);
 	phy_ppdu->ofdm.avg_snr = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_AVG_SNR);
 	phy_ppdu->ofdm.evm_max = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_EVM_MAX);
 	phy_ppdu->ofdm.evm_min = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_EVM_MIN);
+	phy_ppdu->bf = le32_get_bits(ie->w3, RTW89_PHY_STS_IE01_W3_BF);
 	phy_ppdu->ofdm.has = true;
 
 	/* sign conversion for S(12,2) */
@@ -3062,6 +3061,23 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	if (desc_info->data_rate < RTW89_HW_RATE_NR)
 		pkt_stat->rx_rate_cnt[desc_info->data_rate]++;
 
+	if (phy_ppdu && phy_ppdu->ofdm.has) {
+		if (phy_ppdu->ldpc)
+			pkt_stat->rx.ldpc++;
+		else
+			pkt_stat->rx.bcc++;
+
+		if (phy_ppdu->stbc)
+			pkt_stat->rx.stbc++;
+
+		if (!phy_ppdu->su)
+			pkt_stat->rx.mu++;
+		else if (phy_ppdu->bf)
+			pkt_stat->rx.su_bf++;
+		else
+			pkt_stat->rx.su_non_bf++;
+	}
+
 	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, false, false);
 
 out:
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e8b03716d41e..c0e176c4c3a6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -855,8 +855,10 @@ struct rtw89_rx_phy_ppdu {
 	} ofdm;
 	bool has_data;
 	bool has_bcn;
+	bool su;
 	bool ldpc;
 	bool stbc;
+	bool bf;
 	bool to_self;
 	bool valid;
 	bool hdr_2_en;
@@ -5378,6 +5380,14 @@ struct rtw89_pkt_stat {
 	u8 beacon_rate;
 	u32 beacon_len;
 	u32 rx_rate_cnt[RTW89_HW_RATE_NR];
+	struct {
+		u32 ldpc;
+		u32 bcc;
+		u32 stbc;
+		u32 su_bf;
+		u32 su_non_bf;
+		u32 mu;
+	} rx;
 };
 
 #define RTW89_BCN_TRACK_STAT_NR 32
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index d9a5bbae11f2..103948aee5cb 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4303,6 +4303,7 @@ static int rtw89_get_bb_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
 			     char *buf, size_t bufsz)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	struct rtw89_pkt_stat *pkt_stat = &bb->last_pkt_stat;
 	const struct rtw89_physts_regs *physts = phy->physts;
 	struct rtw89_pmac_stat_info *pmac = &bb->pmac_stat;
 	struct rtw89_tx_stat_info *tx_stat = &bb->tx_stat;
@@ -4384,6 +4385,13 @@ static int rtw89_get_bb_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
 			       tx_stat->common_ctrl[i], (i < reg_nr - 1) ? ", " : "");
 	p += scnprintf(p, end - p, "]\n\n");
 
+	p += scnprintf(p, end - p, "== RX General\n");
+	p += scnprintf(p, end - p,
+		       "LDPC: %d, BCC: %d, STBC: %d, SU_NON_BF: %d, SU_BF: %d, MU: %d\n\n",
+		       pkt_stat->rx.ldpc, pkt_stat->rx.bcc,
+		       pkt_stat->rx.stbc, pkt_stat->rx.su_non_bf,
+		       pkt_stat->rx.su_bf, pkt_stat->rx.mu);
+
 	p += scnprintf(p, end - p, "== RSSI/RX Rate\n");
 	p += rtw89_get_rx_pkt_stat(rtwdev, bb, p, end - p);
 
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index b69a2529aefc..125ba2a9f145 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -634,8 +634,10 @@ struct rtw89_phy_sts_ie01 {
 #define RTW89_PHY_STS_IE01_W2_AVG_SNR GENMASK(5, 0)
 #define RTW89_PHY_STS_IE01_W2_EVM_MAX GENMASK(15, 8)
 #define RTW89_PHY_STS_IE01_W2_EVM_MIN GENMASK(23, 16)
+#define RTW89_PHY_STS_IE01_W2_SU BIT(27)
 #define RTW89_PHY_STS_IE01_W2_LDPC BIT(28)
 #define RTW89_PHY_STS_IE01_W2_STBC BIT(30)
+#define RTW89_PHY_STS_IE01_W3_BF BIT(8)
 
 struct rtw89_phy_sts_ie01_v2 {
 	__le32 w0;
-- 
2.25.1


