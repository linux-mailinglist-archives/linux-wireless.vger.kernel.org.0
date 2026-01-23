Return-Path: <linux-wireless+bounces-31092-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLAUDhfScmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31092-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:42:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC46F3AE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF0E3301CAE3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C77037E2E5;
	Fri, 23 Jan 2026 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TOkA+4qM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F5346ADA
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132455; cv=none; b=HFDlILS2oTy2PcxPRcTrg9vDmDlS549g0W2Q/FfBFNjCzzOgrkfJ+sPXwJXy7bhofZXJcUwkFspVdmXfVrXW9Zwq7GDDk1suhM9q0Q030KPzN+b6Kdvh0sfuYytdaaJvQaqeTwa45XGEyiLhZ6N7ajh1N2MHCIi0k/m2iNnULxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132455; c=relaxed/simple;
	bh=Ll53vX0jlUMxP5ipSrDy6Q1PvdAJurbeqRg+E2F1QAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNJl6nD+OQ6Rf5FqXtQO0EaTCzJq1MxE7cnN017oOJ5tqGBMqaTHusXcNVQex8Jk7trs0RKOyE9Xja0AqjJP+WMD9drfSP1UYZSFO3PAXNIl4UTUbUNSI0D73ETOVlMcBMyT//DAikmui0XQgRrbULgVurKpLs+HsJE59Q/044o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TOkA+4qM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1ejQmB2206690, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132445; bh=AV2I2ntcT24a6ct/ai7NniOEzHEXGnPSrKuYs+EjlaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TOkA+4qMnAkM745QOzdIocKj1zSI6BI0CI/1creSxqfB5K6hQpjiXXOwwkhQnCVtE
	 VnZf2xWczkHUDMbuNEVsk9/kPrOcScz9irk3ucApE41eu1R8NDwI0i/D32OxCkTTZA
	 9DPBBXV3Uis8DuotiZ0eHiStKWzPaCPOxuOduZZX9l6PsDujiwrLiIWpcr1OA4fqUb
	 jxmY+jJr2NQRqwqhGJzfqVi1YMoH+Qbhwwhet0MtfwNWHdATw8ajSnWJwtV0l508lZ
	 pICJjIfSeTRLtlKJA9/pePFZDhaOy9KOiEPIt68ouuOY1CNxLDR098c+gkdghZQR2h
	 LXK2Ovjt4iRiA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1ejQmB2206690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:40:45 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:40:45 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:40:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/11] wifi: rtw89: rfk: add to print debug log of TX IQK
Date: Fri, 23 Jan 2026 09:39:48 +0800
Message-ID: <20260123013957.16418-3-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31092-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DFC46F3AE
X-Rspamd-Action: no action

Add report format for TX IQK, which do calibration in firmware and send
a C2H event as debug purpose.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 20 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c | 15 ++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 31402667e155..c3ad473a06f2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5069,6 +5069,26 @@ struct rtw89_c2h_rf_txgapk_rpt_log {
 	u8 rsv1;
 } __packed;
 
+struct rtw89_c2h_rf_txiqk_rpt_log {
+	u8 fw_txiqk_ver;
+	u8 rsvd;
+	u8 iqk_band[2];
+	u8 iqk_ch[2];
+	u8 iqk_bw[2];
+	bool tx_iqk_fail[2];
+	bool is_iqk_init;
+	bool txiqk_en;
+	bool lok_en;
+	bool lok_fail[2];
+	u8 rsvd2;
+	__le32 iqk_times;
+	bool txiqk_nctldone[2];
+	u8 rsvd3[2];
+	__le32 txgain[2][6];
+	__le32 tx_iqc[2][6];
+	__le32 tx_xym[2][6][14];
+} __packed;
+
 struct rtw89_c2h_rfk_report {
 	struct rtw89_c2h_hdr hdr;
 	u8 state; /* enum rtw89_rfk_report_state */
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index fd2e9a472518..215864d1e1c7 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3456,6 +3456,7 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_c2h_rf_txgapk_rpt_log *txgapk;
 	struct rtw89_c2h_rf_rxdck_rpt_log *rxdck;
+	struct rtw89_c2h_rf_txiqk_rpt_log *txiqk;
 	struct rtw89_c2h_rf_dack_rpt_log *dack;
 	struct rtw89_c2h_rf_tssi_rpt_log *tssi;
 	struct rtw89_c2h_rf_dpk_rpt_log *dpk;
@@ -3706,7 +3707,10 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 			goto out;
 
 		rtw89_phy_c2h_rfk_tas_pwr(rtwdev, content);
-
+		return;
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_TXIQK:
+		if (len != sizeof(*txiqk))
+			goto out;
 		return;
 	default:
 		break;
@@ -3843,6 +3847,13 @@ rtw89_phy_c2h_rfk_log_tas_pwr(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 			      RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR, "TAS");
 }
 
+static void
+rtw89_phy_c2h_rfk_log_txiqk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_TXIQK, "TXIQK");
+}
+
 static
 void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 					       struct sk_buff *c2h, u32 len) = {
@@ -3853,6 +3864,7 @@ void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI] = rtw89_phy_c2h_rfk_log_tssi,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK] = rtw89_phy_c2h_rfk_log_txgapk,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR] = rtw89_phy_c2h_rfk_log_tas_pwr,
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_TXIQK] = rtw89_phy_c2h_rfk_log_txiqk,
 };
 
 static
@@ -3941,6 +3953,7 @@ bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
 		case RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK:
 		case RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI:
 		case RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK:
+		case RTW89_PHY_C2H_RFK_LOG_FUNC_TXIQK:
 			return true;
 		default:
 			return false;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 9a15dbf1c318..89e3bc588494 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -150,6 +150,7 @@ enum rtw89_phy_c2h_rfk_log_func {
 	RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI = 4,
 	RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK = 5,
 	RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR = 9,
+	RTW89_PHY_C2H_RFK_LOG_FUNC_TXIQK = 0xc,
 
 	RTW89_PHY_C2H_RFK_LOG_FUNC_NUM,
 };
-- 
2.25.1


