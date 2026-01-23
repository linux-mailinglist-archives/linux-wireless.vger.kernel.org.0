Return-Path: <linux-wireless+bounces-31093-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA3cFsPRcmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31093-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A46F318
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E9BC3012CDF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200154654;
	Fri, 23 Jan 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Sg44hvoH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B216298991
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132464; cv=none; b=Kfk24W8DLLVIkRNrIHxCX34LlB+4YpTvE6QDqPlWUFKSRFdUb1mjuIAX3yOCwWYv2J49U4jT70e33VQkCNbDsmLQmm/aGobtc/iMMTF84H8Q4DWOPlUWguQNuWuKU3f57FBhBLkmjsUtFnpYiP7mFCsPOXxbT/vpMe36UyDV2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132464; c=relaxed/simple;
	bh=wDbb/PR3dh26tGuwUGJqtDBPVto/QoiHSOnl5/VD+pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQbUAGWYuiXdsp3vdpT0Sm5WipbXw6a0PxNqKzbM1LocpX2dQyP0nQKUB8B7ni0GUVD4YGj4iMPBPPW0w5z60D+w4s7f2d3fxhzEruQK6zu8ech/t5fqP0bKlRQnoyGpF/gn2UC3zO+/6ND8Kr3SX0dI/642Him/mNMzSNuePvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Sg44hvoH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1evuZ72206793, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132457; bh=gqBOSgppTQPLwclGsNpRLNWxklHcrAcTCQO8l/XPM6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Sg44hvoHp8GUh4Gtw9gVgGQ0e0aqYlWPddMQDcbC70RV94T1TmPYWK9BlxNgbazV5
	 IUhy2Vq0oId9H0J0nkkmiBwFr25+zzge/SyjWEgEqvjrmyG46cBoFL7HM96jK3vklH
	 6e5q05vBvvUwYRAV1lw8q5GfXwsi/nnxSHzV0+AXV5GZgk42B006dfC8dq+cQN0Dtf
	 p93E99jAdOuKnIA48xIeRjTG8F2Mhk8FO/hcdAmbKUDakwt4JSUuAU2Q+/likA58c9
	 3E3cELrqMqob/nPXVMUvWExXJbW1FDmak+5Lb7Rp3paxPn9uVw+5TQz0kzEkZ8DlJx
	 GMd090lBdQYww==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1evuZ72206793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:40:57 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:40:55 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:40:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/11] wifi: rtw89: rfk: add to print debug log of CIM3K
Date: Fri, 23 Jan 2026 09:39:50 +0800
Message-ID: <20260123013957.16418-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123013957.16418-1-pkshih@realtek.com>
References: <20260123013957.16418-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31093-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: CA4A46F318
X-Rspamd-Action: no action

Add calibration report of CIM3K, which does calibration in firmware and
send a C2H event as debug purpose.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 27 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c | 13 ++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h |  1 +
 3 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2f04138148b7..4fa982cbac49 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5102,6 +5102,33 @@ struct rtw89_c2h_rf_txiqk_rpt_log {
 	__le32 tx_xym[2][6][14];
 } __packed;
 
+struct rtw89_c2h_rf_cim3k_rpt_log {
+	u8 cim3k_band[2];
+	u8 cim3k_ch[2];
+	u8 cim3k_bw[2];
+	u8 su_path_ok[2];
+	u8 ru_path_ok[2];
+	u8 txagc_cim3k[2];
+	u8 ther_cim3k[2];
+	u8 cim3k_gs[2];
+	__le16 cim3k_pwsf[2];
+	bool cim3k_nctldone[2];
+	u8 rsvd[2];
+	__le32 cim3k_rxiqc[2];
+	__le32 cim3k_su_coef[2][3];
+	__le16 dc_i[2];
+	__le16 dc_q[2];
+	u8 corr_val[2];
+	u8 corr_idx[2];
+	u8 rxbb_ov[2];
+	u8 cim3k_txiqc[2];
+	u8 kidx[2];
+	u8 fw_cim3k_ver;
+	bool su_cim3k_en[2];
+	bool ru_cim3k_en[2];
+	u8 rsvd1;
+} __packed;
+
 struct rtw89_c2h_rfk_report {
 	struct rtw89_c2h_hdr hdr;
 	u8 state; /* enum rtw89_rfk_report_state */
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 5f6854b7550d..11f45e30d76d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3457,6 +3457,7 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 	struct rtw89_c2h_rf_txgapk_rpt_log *txgapk;
 	struct rtw89_c2h_rf_rxdck_rpt_log *rxdck;
 	struct rtw89_c2h_rf_txiqk_rpt_log *txiqk;
+	struct rtw89_c2h_rf_cim3k_rpt_log *cim3k;
 	struct rtw89_c2h_rf_dack_rpt_log *dack;
 	struct rtw89_c2h_rf_tssi_rpt_log *tssi;
 	struct rtw89_c2h_rf_dpk_rpt_log *dpk;
@@ -3712,6 +3713,10 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 		if (len != sizeof(*txiqk))
 			goto out;
 		return;
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_CIM3K:
+		if (len != sizeof(*cim3k))
+			goto out;
+		return;
 	default:
 		break;
 	}
@@ -3854,6 +3859,13 @@ rtw89_phy_c2h_rfk_log_txiqk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 l
 			      RTW89_PHY_C2H_RFK_LOG_FUNC_TXIQK, "TXIQK");
 }
 
+static void
+rtw89_phy_c2h_rfk_log_cim3k(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_CIM3K, "CIM3K");
+}
+
 static
 void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 					       struct sk_buff *c2h, u32 len) = {
@@ -3865,6 +3877,7 @@ void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK] = rtw89_phy_c2h_rfk_log_txgapk,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR] = rtw89_phy_c2h_rfk_log_tas_pwr,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TXIQK] = rtw89_phy_c2h_rfk_log_txiqk,
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_CIM3K] = rtw89_phy_c2h_rfk_log_cim3k,
 };
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 5e04bdcef4e9..a587f83b8d67 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -151,6 +151,7 @@ enum rtw89_phy_c2h_rfk_log_func {
 	RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK = 5,
 	RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR = 9,
 	RTW89_PHY_C2H_RFK_LOG_FUNC_TXIQK = 0xc,
+	RTW89_PHY_C2H_RFK_LOG_FUNC_CIM3K = 0xe,
 
 	RTW89_PHY_C2H_RFK_LOG_FUNC_NUM,
 };
-- 
2.25.1


