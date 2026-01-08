Return-Path: <linux-wireless+bounces-30556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6FDD0466C
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8043517F0F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D954984AF;
	Thu,  8 Jan 2026 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="H7pjxHDS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E854984B2
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873869; cv=none; b=kmjtjjAvoX0cjmfzWJHwnwL5K5QR5A17zoHOmAtCv/dWLtoDi0Yo2Tb/bp1MvZVjYM2P6gURoGIDyEQJFQFmTQBsFsJbdftrcLiUsZrPf8ZIeaeSbOKWVMFordf5KyQp4wfCbL7UfLCSPo/9ptwvk4Jyw7jDRurzTQValk/hURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873869; c=relaxed/simple;
	bh=VTqdVjPfSdPwb1A29wP8cTRrjMUfBlaSg+nV8uBE7hQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO1eguHgEYGnPlJwdTbSuPBVzM01hPEkRx+98cBYnOvX10S05zgaH9PekUWSxTIAnHMropjeTzG4Yk/fe/E5O+1QMBw3mfW3W76uVCxliFUrl8If9HQaCrh/jYzAZKCupIhLfC9KPexKrkEAWLQwf4+iDbbhMlgAP2f3WB22ERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=H7pjxHDS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C4MtqC970711, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873862; bh=F4OwUBsjOOPahrp2rBdA9qI9Lx6XlUm+ocL2UWw1bzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=H7pjxHDSv28fQlvwrkq/skpNf/zbzJmPXhoorF4DtgQNnLRs82RffIblobvNH+JWt
	 oMISI9NEAbqON4yKo61cL49makdefuXz9ea+ujqb1ujbRmMLQl5Ia4J4OzYIdeEAsu
	 eImlwtHGuKVHIW1OPGRmaj3x0Zs/Qpu4jOq6KVaRo/ZvqKw3Z8qwsL0zQXsT7/7dGh
	 mLb1v1WvtOwZHUAccjDnUvgKpphrymtnzrBNDsPQ3kdcGhE7nmJAg0Fcxo1tGlTYXG
	 RF+MpkHuN9qPTl/U9DHohJuzkxK1h/5UNKPempMRHSm1u/TsRPUf0qEpEytz/cSoIG
	 OIi+RtcG9ffIA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C4MtqC970711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:04:22 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:04:23 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:04:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 12/13] wifi: rtw89: mac: add an entry to enable MAC function in preinit
Date: Thu, 8 Jan 2026 20:03:19 +0800
Message-ID: <20260108120320.2217402-13-pkshih@realtek.com>
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

The preinit is to initialize partial MAC hardware needed before
downloading firmware, and then does post-init after firmware runs.

For RTL8922D, initialize some DMAC and CMAC at this step.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  8 +++
 drivers/net/wireless/realtek/rtw89/mac.h    |  1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 73 +++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f142d3f80e95..f484e81d6595 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4223,12 +4223,19 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 
 int rtw89_mac_preinit(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
 	ret = rtw89_mac_pwr_on(rtwdev);
 	if (ret)
 		return ret;
 
+	if (mac->mac_func_en) {
+		ret = mac->mac_func_en(rtwdev);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -7292,6 +7299,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.trx_init = trx_init_ax,
 	.preload_init = preload_init_set_ax,
 	.err_imr_ctrl = err_imr_ctrl_ax,
+	.mac_func_en = NULL,
 	.hci_func_en = rtw89_mac_hci_func_en_ax,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_ax,
 	.dle_func_en = dle_func_en_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 7254a653c220..c5630ec88383 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1040,6 +1040,7 @@ struct rtw89_mac_gen_def {
 	int (*preload_init)(struct rtw89_dev *rtwdev, u8 mac_idx,
 			    enum rtw89_qta_mode mode);
 	void (*err_imr_ctrl)(struct rtw89_dev *rtwdev, bool en);
+	int (*mac_func_en)(struct rtw89_dev *rtwdev);
 	void (*hci_func_en)(struct rtw89_dev *rtwdev);
 	void (*dmac_func_pre_en)(struct rtw89_dev *rtwdev);
 	void (*dle_func_en)(struct rtw89_dev *rtwdev, bool enable);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index ef4de64d8661..35c16bcca3b7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -751,6 +751,37 @@ static int rtw89_fwdl_check_path_ready_be(struct rtw89_dev *rtwdev,
 
 static int dmac_func_en_be(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->chip_id == RTL8922A)
+		return 0;
+
+	rtw89_write32_set(rtwdev, R_BE_DMAC_FUNC_EN,
+			  B_BE_MAC_FUNC_EN | B_BE_DMAC_FUNC_EN |
+			  B_BE_MPDU_PROC_EN | B_BE_WD_RLS_EN |
+			  B_BE_DLE_WDE_EN | B_BE_TXPKT_CTRL_EN |
+			  B_BE_STA_SCH_EN | B_BE_DLE_PLE_EN |
+			  B_BE_PKT_BUF_EN | B_BE_DMAC_TBL_EN |
+			  B_BE_PKT_IN_EN | B_BE_DLE_CPUIO_EN |
+			  B_BE_DISPATCHER_EN | B_BE_BBRPT_EN |
+			  B_BE_MAC_SEC_EN | B_BE_H_AXIDMA_EN |
+			  B_BE_DMAC_MLO_EN | B_BE_PLRLS_EN |
+			  B_BE_P_AXIDMA_EN | B_BE_DLE_DATACPUIO_EN);
+
+	return 0;
+}
+
+static int cmac_share_func_en_be(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->chip_id == RTL8922A)
+		return 0;
+
+	rtw89_write32_set(rtwdev, R_BE_CMAC_SHARE_FUNC_EN,
+			  B_BE_CMAC_SHARE_EN | B_BE_RESPBA_EN |
+			  B_BE_ADDRSRCH_EN | B_BE_BTCOEX_EN);
+
 	return 0;
 }
 
@@ -865,6 +896,10 @@ static int sys_init_be(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	ret = cmac_share_func_en_be(rtwdev);
+	if (ret)
+		return ret;
+
 	ret = cmac_pwr_en_be(rtwdev, RTW89_MAC_0, true);
 	if (ret)
 		return ret;
@@ -880,6 +915,43 @@ static int sys_init_be(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+static int mac_func_en_be(struct rtw89_dev *rtwdev)
+{
+	u32 val;
+	int ret;
+
+	ret = dmac_func_en_be(rtwdev);
+	if (ret)
+		return ret;
+
+	ret = cmac_share_func_en_be(rtwdev);
+	if (ret)
+		return ret;
+
+	val = rtw89_read32(rtwdev, R_BE_FEN_RST_ENABLE);
+	if (val & B_BE_CMAC0_FEN) {
+		ret = cmac_pwr_en_be(rtwdev, RTW89_MAC_0, true);
+		if (ret)
+			return ret;
+
+		ret = cmac_func_en_be(rtwdev, RTW89_MAC_0, true);
+		if (ret)
+			return ret;
+	}
+
+	if (val & B_BE_CMAC1_FEN) {
+		ret = cmac_pwr_en_be(rtwdev, RTW89_MAC_1, true);
+		if (ret)
+			return ret;
+
+		ret = cmac_func_en_be(rtwdev, RTW89_MAC_1, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int sta_sch_init_be(struct rtw89_dev *rtwdev)
 {
 	u32 p_val;
@@ -2911,6 +2983,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.trx_init = trx_init_be,
 	.preload_init = preload_init_be,
 	.err_imr_ctrl = err_imr_ctrl_be,
+	.mac_func_en = mac_func_en_be,
 	.hci_func_en = rtw89_mac_hci_func_en_be,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_be,
 	.dle_func_en = dle_func_en_be,
-- 
2.25.1


