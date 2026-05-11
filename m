Return-Path: <linux-wireless+bounces-36201-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBawJUd/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36201-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:03:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED58508CEC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D83302D51C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277F030EF74;
	Mon, 11 May 2026 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QhftYyaN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847632E12E
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482945; cv=none; b=gVy/U6sKxDd2t4Xy6Kvt0c3SM3rJ1vyqgPuv6QJiiyibYPJyVMO9fHQ4721UGBr4haoaLHxTDhBjCpgC/nMB4rcj5QcvfepUzsJzfcOsE6xpf3mj6CA36C3rPTt1j7wlE1VOfjgcTKjKOCqbZxEmvEpJzE6imSG8M6E1U4P9Zms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482945; c=relaxed/simple;
	bh=34U88T29xeBJ6hJSVpVotyjmIQxJ8JbrQeZNjwH3p0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJmnK92vvOCEGarJkqC9v9rJ9OlFYpnho4CVnXCvKqT/kBVNZld5W7c3JdzpB7L+NLdRrUtr2J2KUzy00f7iiggrX3sKVc8iQYrECj2pKm8an1KYZPHkry/NfOz/ejjjdxJPZY8L7H4vBdjUlqF7NaAKzPWLCJLXMOr8CSW1/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QhftYyaN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B72KaR42540491, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482940; bh=EqwX8V6MCCuYG5bI95rzbb91qFXDTrZO7F4Lj/SK4UY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QhftYyaNxs6DRWqX7H76PF8drSHcrov2AEx3ndyNQvhP+it6JtuRJ46f65d1XaltX
	 o78MyrAVxcS341UdjNgI0B3PzgyqWh77QE8dqldRDy+UueoUXQB8Lh5E5n4Qv4YRV5
	 +Bcz9sBRziv0TkT3mXgGvINy9wUE9hX5oAny1mo6w//UWFOBpwJ8zWxujKkYd1saNB
	 xQOqGO0VG1mEpySQ4osVL4ODQhRjwHi6o2mqpHtBDM5MVOjJQlfG8iZhjxF2rMhSXi
	 Q22QI53p+/UL7Wsd3Qd9aOhQA0o0j39hhC1WNVe4czpSTgXI9kCMWH06JE5ulgPFy0
	 BGQqFh3D0c9qQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B72KaR42540491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 05/11] wifi: rtw89: phy: set BB wrap of QAM threshold
Date: Mon, 11 May 2026 15:01:42 +0800
Message-ID: <20260511070148.25257-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511070148.25257-1-pkshih@realtek.com>
References: <20260511070148.25257-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 0ED58508CEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36201-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

Make hardware to consider which QAM (data rate) to apply BB wrapper
parameters, which are set by other registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      | 12 +++
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 74 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  2 +
 3 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index a3e12590f473..d2f443c98412 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -586,6 +586,17 @@ enum rtw89_oob_dpd_onoff {
 	OOB_DPD_ON = 1,
 };
 
+enum rtw89_rfsi_ctrl_modulation {
+	RFSI_BPSK = 0,
+	RFSI_QPSK = 1,
+	RFSI_16QAM = 2,
+	RFSI_64QAM = 3,
+	RFSI_256QAM = 4,
+	RFSI_1024QAM = 5,
+	RFSI_4096QAM = 6,
+	RFSI_MAX,
+};
+
 #define _8nibble(n0, n1, n2, n3, n4, n5, n6, n7) \
 	((n0) << 0  | (n1) << 4  | (n2) << 8  | (n3) << 12 | \
 	 (n4) << 16 | (n5) << 20 | (n6) << 24 | (n7) << 28)
@@ -594,6 +605,7 @@ struct rtw89_bb_wrap_common_data {
 	struct {
 		u32 rfsi_ct_opt[2];
 	} bands[RFSI_CTRL_BAND_NUM];
+	u8 qam_th[6];
 };
 
 struct rtw89_bb_wrap_data {
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index c52306b9fec4..ca3cfdc90445 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -691,42 +691,52 @@ EXPORT_SYMBOL(rtw89_phy_bb_wrap_set_rfsi_bandedge_ch);
 static void rtw89_phy_bb_wrap_tx_rfsi_qam_comp_th_init(struct rtw89_dev *rtwdev,
 						       enum rtw89_mac_idx mac_idx)
 {
+	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
+	u8 th0, th1, th2;
+
+	if (!d || !d->common)
+		return;
+
+	th0 = d->common->qam_th[0];
+	th1 = d->common->qam_th[1];
+	th2 = d->common->qam_th[2];
+
 	/* TH0 */
-	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_0_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_3_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_1_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_4_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_7_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_0_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_3_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_6_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_0_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_3_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_1_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_4_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_7_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_0_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_3_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_6_BE4, th0, mac_idx);
 	/* TH1 */
-	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_1_BE4, 0x2, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_4_BE4, 0x2, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_2_BE4, 0x2, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_5_BE4, 0x2, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_8_BE4, 0x2, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_1_BE4, 0x2, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_4_BE4, 0x2, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_7_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_1_BE4, th1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_4_BE4, th1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_2_BE4, th1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_5_BE4, th1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_8_BE4, th1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_1_BE4, th1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_4_BE4, th1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_7_BE4, th1, mac_idx);
 	/* TH2 */
-	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_2_BE4, 0x4, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_0_BE4, 0x4, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_3_BE4, 0x4, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_6_BE4, 0x4, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_9_BE4, 0x4, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_2_BE4, 0x4, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_5_BE4, 0x4, mac_idx);
-	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_8_BE4, 0x4, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_2_BE4, th2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_0_BE4, th2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_3_BE4, th2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_6_BE4, th2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_9_BE4, th2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_2_BE4, th2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_5_BE4, th2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_8_BE4, th2, mac_idx);
 	/* DPD 160M */
-	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_0_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_1_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_2_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_3_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_4_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_5_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_6_BE4, 0x1, mac_idx);
-	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_7_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_0_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_1_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_2_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_3_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_4_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_5_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_6_BE4, th0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_7_BE4, th0, mac_idx);
 	/* DPD 20M */
 	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_0_BE4, 0x2, mac_idx);
 	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_1_BE4, 0x2, mac_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 18d75184f82b..a867652907bc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -296,6 +296,7 @@ static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7025
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
 	}},
+	.qam_th = {RFSI_BPSK, RFSI_QPSK, RFSI_256QAM, RFSI_MAX, RFSI_MAX, RFSI_MAX},
 };
 
 static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7090 = {
@@ -308,6 +309,7 @@ static const struct rtw89_bb_wrap_common_data rtw8922d_bb_wrap_common_data_7090
 		.rfsi_ct_opt = {_8nibble(2, 2, 2, 2, 1, 1, 1, 1),
 				_8nibble(2, 2, 2, 2, 1, 1, 1, 1)},
 	}},
+	.qam_th = {RFSI_BPSK, RFSI_QPSK, RFSI_256QAM, RFSI_MAX, RFSI_MAX, RFSI_MAX},
 };
 
 static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7025_default = {
-- 
2.25.1


