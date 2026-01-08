Return-Path: <linux-wireless+bounces-30551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E5BD03B59
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87D6B300E429
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08EA483801;
	Thu,  8 Jan 2026 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eiXMDX4d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4A497B2F
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873845; cv=none; b=kjhovfX/4j9F+cCqLZ0v7BFA31VvZ+VtY1AHwRjYAaWvDex/mr7u5lsjM8rujxoCbCodoIlNMXXH9yaPPitkzjMutvIQq1k9UoEmlBDj6PUt674q2Pbhb7n978pAcbY/8Fo5AFyqAMuPkP13JDXBTHSgXjWRw5NAcMsBlYFma3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873845; c=relaxed/simple;
	bh=eMInJVAlihli1mDzUC51PJqIiQrQ6yhKwKnKuTXQJ54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpamWRXndFE16ld2xidvq1BsODcZXlpHm3BPnS5JfL1KGzwUmJBsBgQBNjpNh23b1YwpZjnV2tIFNrfMk6FGgNVsOrKlLMGqzPvdxXhizH8uj32P5kLQB6DkAn17Xyqs7IzobsOz/a5WINnPjGHkR/RfFVqRpmzZBb9M+jSh9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eiXMDX4d; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C3uo46970635, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873836; bh=nwQ6NgiseNAPKAoIYZj808ryM3YG+wzUPHBTcMgKTIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eiXMDX4dGtdhuQeIbw8GA/mgNlSbwECrmWyKN7lBYzoXmQWRf5isgciYzRv+ujn5a
	 YojqbEuN2oMZ/fbhmjSwZKts75I+Cxn+jBUj7kXtlKZ9WRJMCsa7c2OfLKxQ6WWjH2
	 yDNBk0dbxhv6Mx54eVGnLAwZ01ZRJyvKsSYWjJjEu2V11AHyNik2Tz3pia3F/C7wou
	 ub1lk8XmTdQexlfQqzJSjNRYdHxT7LBxO0TkQOFP9zyutcTPFxOFjKFFvs2s27qiYA
	 HRAsnaY9fpXgdYk7f/WMfaGLmeZN3vi8Xr+pvvdwI+I38Ma7jynY/Q7YtZYjY1VQSv
	 vCGZaRMmNjPmg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C3uo46970635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:03:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:57 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:56 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:03:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 07/13] wifi: rtw89: mac: update MPDU quota according to chip DLE definition
Date: Thu, 8 Jan 2026 20:03:14 +0800
Message-ID: <20260108120320.2217402-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

MPDU quota is to define number of memory used to handle packets in DLE
(Data Link Engine). All chips use the same value before, but the RTL8922D
need to use chip specific value.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c    |  1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 12 +++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h    |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 054abb1ea05a..82d295fdd55d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4614,6 +4614,7 @@ enum rtw89_hcifc_mode {
 
 struct rtw89_dle_info {
 	const struct rtw89_rsvd_quota *rsvd_qt;
+	const struct rtw89_dle_input *dle_input;
 	enum rtw89_qta_mode qta_mode;
 	u16 ple_pg_size;
 	u16 ple_free_pg;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b1f313f738b8..35794488a02f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1862,6 +1862,7 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 	}
 
 	mac->dle_info.rsvd_qt = cfg->rsvd_qt;
+	mac->dle_info.dle_input = cfg->dle_input;
 	mac->dle_info.ple_pg_size = cfg->ple_size->pge_size;
 	mac->dle_info.ple_free_pg = cfg->ple_size->lnk_pge_num;
 	mac->dle_info.qta_mode = mode;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index aff9855f184a..0327629d2a5d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -873,7 +873,10 @@ static int sec_eng_init_be(struct rtw89_dev *rtwdev)
 
 static int txpktctrl_init_be(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_mac_info *mac = &rtwdev->mac;
 	struct rtw89_mac_dle_rsvd_qt_cfg qt_cfg;
+	const struct rtw89_dle_input *dle_input;
+	u32 mpdu_info_b1_ofst;
 	u32 val32;
 	int ret;
 
@@ -884,9 +887,16 @@ static int txpktctrl_init_be(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	dle_input = mac->dle_info.dle_input;
+	if (dle_input)
+		mpdu_info_b1_ofst = DIV_ROUND_UP(dle_input->mpdu_info_tbl_b0,
+						 BIT(MPDU_INFO_TBL_FACTOR));
+	else
+		mpdu_info_b1_ofst = MPDU_INFO_B1_OFST;
+
 	val32 = rtw89_read32(rtwdev, R_BE_TXPKTCTL_MPDUINFO_CFG);
 	val32 = u32_replace_bits(val32, qt_cfg.pktid, B_BE_MPDUINFO_PKTID_MASK);
-	val32 = u32_replace_bits(val32, MPDU_INFO_B1_OFST, B_BE_MPDUINFO_B1_BADDR_MASK);
+	val32 = u32_replace_bits(val32, mpdu_info_b1_ofst, B_BE_MPDUINFO_B1_BADDR_MASK);
 	val32 |= B_BE_MPDUINFO_FEN;
 	rtw89_write32(rtwdev, R_BE_TXPKTCTL_MPDUINFO_CFG, val32);
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9ac1c169d25c..e41a6c679d59 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5869,6 +5869,7 @@
 #define B_BE_MPDUINFO_PKTID_MASK GENMASK(27, 16)
 #define B_BE_MPDUINFO_B1_BADDR_MASK GENMASK(5, 0)
 #define MPDU_INFO_B1_OFST 18
+#define MPDU_INFO_TBL_FACTOR 3
 
 #define R_BE_TXPKTCTL_B0_PRELD_CFG0 0x9F48
 #define B_BE_B0_PRELD_FEN BIT(31)
-- 
2.25.1


