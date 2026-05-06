Return-Path: <linux-wireless+bounces-36018-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDaMLtk9+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36018-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6005B4DABFE
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0DC43007895
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F543F076B;
	Wed,  6 May 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="P3ckybdP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9323EF65D
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073047; cv=none; b=X2mjQPnFU+TLPFf8reUqySKc4tfq9v4/0jhZ9iYG9wHdF8E89O3mYytNF96RtZgpXNVEEAdzuTZMOvrKCnVZd8M2JvTYsrSHX3kpmpgZN5L3ERIgp/3kxePvz9VJtJApT6NpWDMTueVzHpLetlV119rH3Tm90yNzJyE1PDiAVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073047; c=relaxed/simple;
	bh=W+0HYqSmtdTs4sKhaO6PNpUoZJjfp3LNw9Vn+vgJPI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKASVvBat/HT7LaD3hV4UIvpG3vZ2JUGj5AD4zHVmx/SAxIK1WfJFLwhotBU6XqM8O0hkDnL2LwIsdKyIkyoGBxh/bZUxvje8WOaxYst3E2wsf068eZbWA90w8dwaCEjC2Znptf9LCujXVKBJfoaV9QopTUl3gCtBHwU3P7pcjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=P3ckybdP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DAhGS21986927, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073043; bh=cbzm1pN73XbiSvhpsCt+c7J4JZd8UpNIRul2HX4Ojxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=P3ckybdPkvqMBPcAE+UaJtVYspDKEqnwLtbkCpZzMEVKvjAeIdcaLxuMSZvA5IQEF
	 IUq/MHH9oQe/ALCmS2Q7B+aBZZe2ZpS+72OGYC/Bg/9buXOjoR6bzv+ATov4rusZKW
	 hoewrgr+shGnU6RdiJHbXfgZUL3JtgRt2yF8jrYk9usuW+TtHaiQHQFY3hYezCBnOu
	 utdmR6bT9hJJLbSJ5u2j2EISTmrWKwBQJ7Wxn7wNapFQ+q0OpFZU0b14lOy7Xo3qHw
	 o8Xn4TFvSzPTDDemY0a2HDhq9ODK6c5kYjLUDFMC0airOrQAomstTlg+0Q1wPAr7PJ
	 ZQBd5DWCK5yuQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DAhGS21986927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:43 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:43 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:43 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 08/14] wifi: rtw89: fill HE-SU/HE-TB/HE-MU/HE-EXT_SU radiotap
Date: Wed, 6 May 2026 21:09:54 +0800
Message-ID: <20260506131000.1706298-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 6005B4DABFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36018-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Fill HE radiotap by PHY status IE-09/IE-10 which contains HE SIG-A/SIG-B
respectively.

The IE-10 may contain two content channels (if bandwidth is larger than
40MHz), and starting address of second content channel can be calculated by
length of first content channel containing up to 15 user fields with 8-byte
alignment.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 393 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  18 +-
 drivers/net/wireless/realtek/rtw89/txrx.h |  54 +++
 3 files changed, 461 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2a9326335c53..7fa479ce52e2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3220,9 +3220,361 @@ static void rtw89_core_update_radiotap_vht(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_core_update_radiotap_he_su(struct rtw89_dev *rtwdev,
+					     struct sk_buff *skb,
+					     struct ieee80211_rx_status *rx_status,
+					     struct ieee80211_radiotap_he *he,
+					     const struct rtw89_phy_sts_ie09 *ie09)
+{
+	u32 sig_a1, sig_a2;
+	u16 t;
+
+	if (!ie09)
+		return;
+
+	sig_a1 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_HE_SU_SIG_A1_MASK);
+	sig_a2 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK);
+
+	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BEAM_CHANGE_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_UL_DL_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_LDPC_XSYMSEG_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_DOPPLER_KNOWN |
+				 0);
+
+	he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_TXBF_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN |
+				 0);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_SU_SIG_A1_BEAM_CHANGE);
+	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_BEAM_CHANGE);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_SU_SIG_A1_ULDL);
+	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_UL_DL);
+
+	rx_status->he_dcm = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_SU_SIG_A1_DCM);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_SU_SIG_A1_BSS_COLOR);
+	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_SU_SIG_A1_SR);
+	he->data4 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA4_SU_MU_SPTL_REUSE);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_TXOP);
+	he->data6 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA6_TXOP);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_LDPC_XSYMSEG);
+	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_LDPC_XSYMSEG);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_BEAMFORMED);
+	he->data5 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA5_TXBF);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_PREFEC);
+	he->data5 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA5_PRE_FEC_PAD);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_PE);
+	he->data5 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA5_PE_DISAMBIG);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_DOPPLER);
+	he->data6 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA6_DOPPLER);
+}
+
+static void rtw89_core_update_radiotap_he_tb(struct rtw89_dev *rtwdev,
+					     struct sk_buff *skb,
+					     struct ieee80211_rx_status *rx_status,
+					     struct ieee80211_radiotap_he *he,
+					     const struct rtw89_phy_sts_ie09 *sig)
+{
+	u32 sig_a1, sig_a2;
+	u16 t;
+
+	if (!sig)
+		return;
+
+	sig_a1 = le64_get_bits(sig->qw0, RTW89_PHY_STS_IE09_HE_TB_SIG_A1_MASK);
+	sig_a2 = le64_get_bits(sig->qw0, RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK);
+
+	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE2_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE3_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE4_KNOWN);
+
+	he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_TB_SIG_A1_BSS_COLOR);
+	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB1);
+	he->data4 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE1);
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB2);
+	he->data4 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE2);
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB3);
+	he->data4 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE3);
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB4);
+	he->data4 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE4);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_TB_SIG_A2_TXOP);
+	he->data6 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA6_TXOP);
+}
+
+static u8 rtw89_core_he_mu_get_n_user_fields_by_ru_alloc(struct rtw89_dev *rtwdev,
+							 u8 ru_alloc)
+{
+	u8 mu_users;
+
+	if (ru_alloc <= 15) {
+		static const u8 entries_0_15[16] = {
+			9, 8, 8, 7, 8, 7, 7, 6, 8, 7, 7, 6, 7, 6, 6, 5,
+		};
+
+		return entries_0_15[ru_alloc];
+	}
+
+	if (ru_alloc >= 16 && ru_alloc <= 95) {
+		mu_users = ru_alloc & 0x07;
+
+		switch (ru_alloc & 0xF8) {
+		case 16: case 24: return mu_users + 3;
+		case 32: case 64: return mu_users + 6;
+		case 40: case 48: case 72: case 80: return mu_users + 5;
+		case 56: case 88: return mu_users + 4;
+		}
+	}
+
+	if (ru_alloc >= 96 && ru_alloc <= 111) {
+		mu_users = ru_alloc & 0x03;
+		mu_users += ru_alloc >> 2 & 0x03;
+
+		return mu_users + 2;
+	}
+
+	if (ru_alloc == 112)
+		return 4;
+
+	if (ru_alloc >= 113 && ru_alloc <= 115)
+		return 0;
+
+	if (ru_alloc >= 128 && ru_alloc <= 191) {
+		mu_users = ru_alloc & 0x07;
+		mu_users += ru_alloc >> 3 & 0x07;
+
+		return mu_users + 3;
+	}
+
+	if (ru_alloc >= 192 && ru_alloc <= 215)
+		return (ru_alloc & 0x07) + 1;
+
+	return 0;
+}
+
+static int rtw89_core_he_mu_get_n_ru_alloc(struct rtw89_dev *rtwdev, u8 bw)
+{
+	switch (bw) {
+	case 0:
+	case 1:
+		return 1;
+	case 2:
+	case 4:
+	case 5:
+		return 2;
+	case 3:
+	case 6:
+	case 7:
+		return 3;
+	}
+
+	return 0;
+}
+
+static void rtw89_core_he_mu_get_cc_ptr(struct rtw89_dev *rtwdev,
+					const struct rtw89_phy_sts_ie10 *ie10,
+					u8 bw, int n_ru, int n_center_26tone,
+					const u8 **c1, const u8 **c2)
+{
+	const u8 *sigb, *end_sigb;
+	int total_bits, c2_offset;
+	int n_user_fields = 0;
+	const u8 *ptr;
+	int i;
+
+	sigb = &ie10->sigb[0];
+	end_sigb = (const void *)ie10 +
+		   rtw89_core_get_phy_status_ie_len(rtwdev, (const void *)ie10);
+
+	ptr = sigb;
+	if (ptr + n_ru + n_center_26tone >= end_sigb)
+		return;
+	*c1 = ptr;
+
+	if (bw == 0)	/* 20MHz doesn't have content channel 2 */
+		return;
+
+	for (i = 0; i < n_ru; i++)
+		n_user_fields +=
+			rtw89_core_he_mu_get_n_user_fields_by_ru_alloc(rtwdev, (*c1)[i]);
+
+	/* hardware report max 15 recordes, align 8 */
+	n_user_fields = min(n_user_fields, 15);
+
+	total_bits = n_ru * 8 + n_center_26tone + 10 +
+		     n_user_fields * 21 + DIV_ROUND_UP(n_user_fields, 2) * 10;
+	c2_offset = ALIGN(DIV_ROUND_UP(total_bits, 8), 8);
+
+	ptr = &sigb[c2_offset];
+	if (ptr + n_ru + n_center_26tone >= end_sigb)
+		return;
+
+	*c2 = ptr;
+}
+
+static void rtw89_core_update_radiotap_he_mu(struct rtw89_dev *rtwdev,
+					     struct sk_buff *skb,
+					     struct ieee80211_rx_status *rx_status,
+					     struct ieee80211_radiotap_he *he,
+					     struct ieee80211_radiotap_he_mu *he_mu,
+					     const struct rtw89_phy_sts_ie09 *ie09,
+					     const struct rtw89_phy_sts_ie10 *ie10)
+{
+	const u8 *c1 = NULL, *c2 = NULL;
+	int n_center_26tone, n_ru, i;
+	bool doppler, comp;
+	u32 sig_a1, sig_a2;
+	u16 t;
+	u8 bw;
+
+	if (!ie09)
+		return;
+
+	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_UL_DL_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_DOPPLER_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_LDPC_XSYMSEG_KNOWN);
+	he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_MIDAMBLE_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN);
+
+	sig_a1 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_MASK);
+	sig_a2 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_ULDL);
+	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_UL_DL);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_BSS_COLOR);
+	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SR);
+	he->data4 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA4_SU_MU_SPTL_REUSE);
+
+	doppler = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_DOPPLER);
+	he->data6 |= le16_encode_bits(doppler, IEEE80211_RADIOTAP_HE_DATA6_DOPPLER);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_MU_SIG_A2_TXOP);
+	he->data6 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA6_TXOP);
+
+	if (doppler) {
+		t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MID);
+		he->data6 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA6_MIDAMBLE_PDCTY);
+	}
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_MU_SIG_A2_LPDC_XSYMSEG);
+	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_LDPC_XSYMSEG);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_MU_SIG_A2_FEC);
+	he->data5 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA5_PRE_FEC_PAD);
+
+	t = u32_get_bits(sig_a2, RTW89_PHY_STS_IE09_HE_MU_SIG_A2_PE);
+	he->data5 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA5_PE_DISAMBIG);
+
+	he_mu->flags1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS_KNOWN |
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM_KNOWN |
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN |
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_COMP_KNOWN);
+	he_mu->flags2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_MCS);
+	he_mu->flags1 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_DCM);
+	he_mu->flags1 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM);
+
+	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_SYM_USR);
+	he_mu->flags2 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_SYMS_USERS);
+
+	comp = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_COM);
+	he_mu->flags2 |= le16_encode_bits(comp, IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_COMP);
+
+	bw = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_BW);
+	he_mu->flags2 |= le16_encode_bits(bw, IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
+
+	if (comp == 0 && bw <= 5) {
+		u8 punc = clamp_t(int, bw - 3, 0, 2);
+
+		he_mu->flags2 |=
+			cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN);
+		he_mu->flags2 |=
+			le16_encode_bits(punc, IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW);
+	}
+
+	/* the Common field in the HE-SIG-B field is not present */
+	if (comp || !ie10)
+		return;
+
+	n_ru = rtw89_core_he_mu_get_n_ru_alloc(rtwdev, bw);
+	n_center_26tone = bw >= 1;
+
+	rtw89_core_he_mu_get_cc_ptr(rtwdev, ie10, bw, n_ru, n_center_26tone, &c1, &c2);
+	if (!c1)
+		return;
+
+	he_mu->flags1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_RU_KNOWN |
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_RU_KNOWN |
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU_KNOWN |
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_CTR_26T_RU_KNOWN);
+
+	for (i = 0; i < n_ru; i++) {
+		he_mu->ru_ch1[i] = c1[i];
+		if (c2)
+			he_mu->ru_ch2[i] = c2[i];
+	}
+
+	if (n_center_26tone) {
+		u8 ru;
+
+		ru = c1[n_ru] & BIT(0);
+		he_mu->flags1 |=
+			le16_encode_bits(ru, IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU);
+
+		ru = c2 ? c2[n_ru] & BIT(0) : 0;
+		he_mu->flags1 |=
+			le16_encode_bits(ru, IEEE80211_RADIOTAP_HE_MU_FLAGS2_CH2_CTR_26T_RU);
+	}
+}
+
+static u16 rtw89_core_get_radiotap_he_format(struct rtw89_rx_desc_info *desc_info)
+{
+	switch (desc_info->ppdu_type) {
+	case RTW89_RX_PPDU_T_HE_MU:
+		return IEEE80211_RADIOTAP_HE_DATA1_FORMAT_MU;
+	case RTW89_RX_PPDU_T_HE_ERSU:
+		return IEEE80211_RADIOTAP_HE_DATA1_FORMAT_EXT_SU;
+	case RTW89_RX_PPDU_T_HE_TB:
+		return IEEE80211_RADIOTAP_HE_DATA1_FORMAT_TRIG;
+	default:
+		return IEEE80211_RADIOTAP_HE_DATA1_FORMAT_SU;
+	}
+}
+
 static void rtw89_core_update_radiotap_he(struct rtw89_dev *rtwdev,
+					  struct rtw89_rx_desc_info *desc_info,
 					  struct sk_buff *skb,
-					  struct ieee80211_rx_status *rx_status)
+					  struct ieee80211_rx_status *rx_status,
+					  struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
 	static const struct ieee80211_radiotap_he known_he = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
@@ -3231,11 +3583,45 @@ static void rtw89_core_update_radiotap_he(struct rtw89_dev *rtwdev,
 				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
 		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
 	};
+	struct ieee80211_radiotap_he_mu *he_mu = NULL;
+	const struct rtw89_phy_sts_ie09 *ie09;
+	const struct rtw89_phy_sts_ie10 *ie10;
 	struct ieee80211_radiotap_he *he;
+	u16 he_format;
+
+	he_format = rtw89_core_get_radiotap_he_format(desc_info);
+
+	/* Radiotap of HE-MU must be placed after HE (skb_push ahead) */
+	if (he_format == IEEE80211_RADIOTAP_HE_DATA1_FORMAT_MU) {
+		rx_status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+		he_mu = skb_push(skb, sizeof(*he_mu));
+		memset(he_mu, 0, sizeof(*he_mu));
+	}
 
 	rx_status->flag |= RX_FLAG_RADIOTAP_HE;
 	he = skb_push(skb, sizeof(*he));
 	*he = known_he;
+
+	he->data1 |= le16_encode_bits(he_format, IEEE80211_RADIOTAP_HE_DATA1_FORMAT_MASK);
+
+	if (!phy_ppdu)
+		return;
+
+	ie09 = phy_ppdu->ie09;
+	ie10 = phy_ppdu->ie10;
+
+	switch (he_format) {
+	case IEEE80211_RADIOTAP_HE_DATA1_FORMAT_MU:
+		rtw89_core_update_radiotap_he_mu(rtwdev, skb, rx_status, he, he_mu,
+						 ie09, ie10);
+		break;
+	case IEEE80211_RADIOTAP_HE_DATA1_FORMAT_TRIG:
+		rtw89_core_update_radiotap_he_tb(rtwdev, skb, rx_status, he, ie09);
+		break;
+	default:
+		rtw89_core_update_radiotap_he_su(rtwdev, skb, rx_status, he, ie09);
+		break;
+	}
 }
 
 static const u8 rx_status_bw_to_radiotap_eht_usig[] = {
@@ -3309,6 +3695,7 @@ static void rtw89_core_update_radiotap_eht(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
+				       struct rtw89_rx_desc_info *desc_info,
 				       struct sk_buff *skb,
 				       struct ieee80211_rx_status *rx_status,
 				       struct rtw89_rx_phy_ppdu *phy_ppdu)
@@ -3319,7 +3706,7 @@ static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
 	if (rx_status->encoding == RX_ENC_VHT)
 		rtw89_core_update_radiotap_vht(rtwdev, skb, rx_status, phy_ppdu);
 	else if (rx_status->encoding == RX_ENC_HE)
-		rtw89_core_update_radiotap_he(rtwdev, skb, rx_status);
+		rtw89_core_update_radiotap_he(rtwdev, desc_info, skb, rx_status, phy_ppdu);
 	else if (rx_status->encoding == RX_ENC_EHT)
 		rtw89_core_update_radiotap_eht(rtwdev, skb, rx_status);
 }
@@ -3531,7 +3918,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 	rtw89_core_hw_to_sband_rate(rx_status);
 	rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
 	rtw89_core_update_rx_status_by_ppdu(rtwdev, rx_status, phy_ppdu);
-	rtw89_core_update_radiotap(rtwdev, skb_ppdu, rx_status, phy_ppdu);
+	rtw89_core_update_radiotap(rtwdev, desc_info, skb_ppdu, rx_status, phy_ppdu);
 	rtw89_core_validate_rx_signal(rx_status);
 	rtw89_core_update_rx_freq_from_ie(rtwdev, skb_ppdu, rx_status);
 	rtw89_core_correct_mcc_chan(rtwdev, desc_info, rx_status, phy_ppdu);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d1cd5997cf97..b85d7fa4296a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -59,7 +59,8 @@ extern const struct ieee80211_ops rtw89_ops;
 #define DELTA_SWINGIDX_SIZE 30
 
 #define RTW89_RADIOTAP_ROOM_VHT sizeof(struct ieee80211_radiotap_vht)
-#define RTW89_RADIOTAP_ROOM_HE sizeof(struct ieee80211_radiotap_he)
+#define RTW89_RADIOTAP_ROOM_HE (sizeof(struct ieee80211_radiotap_he) + \
+				sizeof(struct ieee80211_radiotap_he_mu))
 #define RTW89_RADIOTAP_ROOM_EHT \
 	(sizeof(struct ieee80211_radiotap_tlv) + \
 	 ALIGN(struct_size((struct ieee80211_radiotap_eht *)0, user_info, 1), 4) + \
@@ -955,6 +956,21 @@ enum rtw89_bandwidth {
 	RTW89_CHANNEL_WIDTH_10 = 7,
 };
 
+enum rtw89_rx_ppdu_type {
+	RTW89_RX_PPDU_T_LCCK = 0,
+	RTW89_RX_PPDU_T_SCCK = 1,
+	RTW89_RX_PPDU_T_OFDM = 2,
+	RTW89_RX_PPDU_T_HT = 3,
+	RTW89_RX_PPDU_T_HTGF = 4,
+	RTW89_RX_PPDU_T_VHT_SU = 5,
+	RTW89_RX_PPDU_T_VHT_MU = 6,
+	RTW89_RX_PPDU_T_HE_SU = 7,
+	RTW89_RX_PPDU_T_HE_ERSU = 8,
+	RTW89_RX_PPDU_T_HE_MU = 9,
+	RTW89_RX_PPDU_T_HE_TB = 10,
+	RTW89_RX_PPDU_T_UNKNOWN = 15,
+};
+
 enum rtw89_ps_mode {
 	RTW89_PS_MODE_NONE	= 0,
 	RTW89_PS_MODE_RFOFF	= 1,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index ddf8742d6712..4a567d3fe3f7 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -687,6 +687,60 @@ struct rtw89_phy_sts_ie09 {
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_SUMU_CODE3 GENMASK(7, 4)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_BF BIT(8)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_RSVD3 BIT(9)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_MASK GENMASK_ULL(47, 22) /* HE SU SIG-A1 */
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_FORMAT BIT(0)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_BEAM_CHANGE BIT(1)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_ULDL BIT(2)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_MCS GENMASK(6, 3)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_DCM BIT(7)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_BSS_COLOR GENMASK(13, 8)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_RSVD1 BIT(14)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_SR GENMASK(18, 15)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_BW GENMASK(20, 19)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_GILTF GENMASK(22, 21)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_NSTS GENMASK(25, 23)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK GENMASK_ULL(63, 48) /* HE SU SIG-A2 */
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_TXOP GENMASK(6, 0)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_CODING BIT(7)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_LDPC_XSYMSEG BIT(8)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_STBC BIT(9)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_BEAMFORMED BIT(10)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_PREFEC GENMASK(12, 11)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_PE BIT(13)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_RSVD2 BIT(14)
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_DOPPLER BIT(15)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_MASK GENMASK_ULL(47, 22) /* HE TB SIG-A1 */
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_FORMAT BIT(0)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_BSS_COLOR GENMASK(6, 1)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB1 GENMASK(10, 7)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB2 GENMASK(14, 11)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB3 GENMASK(18, 15)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB4 GENMASK(22, 19)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_RSVD1 BIT(23)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_BW GENMASK(25, 24)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK GENMASK_ULL(63, 48) /* HE TB SIG-A2 */
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A2_TXOP GENMASK(6, 0)
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A2_RSVD1 GENMASK(15, 7)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_MASK GENMASK_ULL(47, 22) /* HE MU SIG-A1 */
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_ULDL BIT(0)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_MCS GENMASK(3, 1)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_DCM BIT(4)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_BSS_COLOR GENMASK(10, 5)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SR GENMASK(14, 11)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_BW GENMASK(17, 15)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_SYM_USR GENMASK(21, 18)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_COM BIT(22)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_GI_LTF GENMASK(24, 23)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_DOPPLER BIT(25)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK GENMASK_ULL(63, 48) /* HE MU SIG-A2 */
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_TXOP GENMASK(6, 0)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_RSVD BIT(7)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_LTF_MID GENMASK(10, 8)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MID BIT(10)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_LPDC_XSYMSEG BIT(11)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_STBC BIT(12)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_FEC GENMASK(14, 13)
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_PE BIT(15)
 
 struct rtw89_phy_sts_ie10 {
 	__le64 qw0;
-- 
2.25.1


