Return-Path: <linux-wireless+bounces-12828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C87977932
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC5928547E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DCD1BB6A2;
	Fri, 13 Sep 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qb3MbbW5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988852AE9F
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211675; cv=none; b=BZ73yMEbJiBhlWa2BZtjiL5s/vK7QuL9X+M42OXPB6zqEwRY0f5JdVl8wSkREGuIlZeo9DtxvwddQZ5s+lB5Un+wgRPreVDm7hf8NlVxeIKBt4AtTO3WiirI+CePrFUYI16owNp19j+F7jh1nOpObCKjmy+6RUDmu6+7VCu4e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211675; c=relaxed/simple;
	bh=NAEH5+kgUvl+SzvtVtE8O4wq7Zo7XVBdeLDgrsoZvRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsKs8AdshhCRP0JYQA/QZskjUDEKF2JbRHtAWBPIW9E8Q6iHTiNs+CFBff0kOv6uTaeL/0LhhX+yYK2Pyf/XXMoZrhqlLEVDI1fXadXW+F4Xf/z+A8ZkFdYqYJV5wOXfSzUiql0YHB95/J4dxpg5mdzsyCVWRc8siOncyck9IqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qb3MbbW5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D7ESj842542233, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726211668; bh=NAEH5+kgUvl+SzvtVtE8O4wq7Zo7XVBdeLDgrsoZvRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qb3MbbW5WngmGEhWs11s9uInsIxlbVCAJ+2qL6k7PVbAnNDrW7PFu2x6HxEq01Vk0
	 UNKXvauxCjevO3V1DI7rVJyrj7EeXgwt2DoFMQy8Fth8HPotMTDBVHD1vkRaLTEkVB
	 Ncu6Bfr8Qov+9TbIClxpE8a/N14WN7FzW5FXpCgyE8OXoPs+na/Mqyf0arroATQtm/
	 M7qEnCD/f8lRUWB2w3Ox2AqAET+Hgm6XBjPkv2V2DV9BJZm7yRX53PRferwGn371ux
	 iHlSbSWBIpnaRi2ZbCWKaMqLY6ae7bT5hK7qdF546fUu8sZ9CHTSy/1fS9rLZnJfVV
	 cm7jsaIQvDNUQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D7ESj842542233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:14:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:14:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 13 Sep
 2024 15:14:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: rfk: add firmware debug log of IQK
Date: Fri, 13 Sep 2024 15:13:39 +0800
Message-ID: <20240913071340.41822-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913071340.41822-1-pkshih@realtek.com>
References: <20240913071340.41822-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Print out IQ signal calibration log from firmware C2H events.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 36 ++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c | 74 ++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4980a7041fb8..bbf62950182a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4318,6 +4318,42 @@ struct rtw89_c2h_rf_run_log {
 	__le32 arg[4];
 } __packed;
 
+struct rtw89_c2h_rf_iqk_rpt_log {
+	bool iqk_tx_fail[2];
+	bool iqk_rx_fail[2];
+	bool is_iqk_init;
+	bool is_reload;
+	bool is_wb_txiqk[2];
+	bool is_wb_rxiqk[2];
+	bool is_nbiqk;
+	bool txiqk_en;
+	bool rxiqk_en;
+	bool lok_en;
+	bool iqk_xym_en;
+	bool iqk_sram_en;
+	bool iqk_fft_en;
+	bool is_fw_iqk;
+	bool is_iqk_enable;
+	bool iqk_cfir_en;
+	bool thermal_rek_en;
+	u8 iqk_band[2];
+	u8 iqk_ch[2];
+	u8 iqk_bw[2];
+	u8 iqk_times;
+	u8 version;
+	u8 phy;
+	u8 fwk_status;
+	u8 rsvd;
+	__le32 reload_cnt;
+	__le32 iqk_fail_cnt;
+	__le32 lok_idac[2];
+	__le32 lok_vbuf[2];
+	__le32 rftxgain[2][4];
+	__le32 rfrxgain[2][4];
+	__le32 tx_xym[2][4];
+	__le32 rx_xym[2][4];
+} __packed;
+
 struct rtw89_c2h_rf_dpk_rpt_log {
 	u8 ver;
 	u8 idx[2];
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c2116c2987fd..ae404ca4e2ee 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2694,9 +2694,83 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 	struct rtw89_c2h_rf_dack_rpt_log *dack;
 	struct rtw89_c2h_rf_tssi_rpt_log *tssi;
 	struct rtw89_c2h_rf_dpk_rpt_log *dpk;
+	struct rtw89_c2h_rf_iqk_rpt_log *iqk;
 	int i, j, k;
 
 	switch (func) {
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_IQK:
+		if (len != sizeof(*iqk))
+			goto out;
+
+		iqk = content;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->is_iqk_init = %x\n", iqk->is_iqk_init);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->is_reload = %x\n", iqk->is_reload);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->is_nbiqk = %x\n", iqk->is_nbiqk);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->txiqk_en = %x\n", iqk->txiqk_en);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->rxiqk_en = %x\n", iqk->rxiqk_en);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->lok_en = %x\n", iqk->lok_en);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->iqk_xym_en = %x\n", iqk->iqk_xym_en);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->iqk_sram_en = %x\n", iqk->iqk_sram_en);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->iqk_fft_en = %x\n", iqk->iqk_fft_en);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->is_fw_iqk = %x\n", iqk->is_fw_iqk);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->is_iqk_enable = %x\n", iqk->is_iqk_enable);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->iqk_cfir_en = %x\n", iqk->iqk_cfir_en);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->thermal_rek_en = %x\n", iqk->thermal_rek_en);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->version = %x\n", iqk->version);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->phy = %x\n", iqk->phy);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK] iqk->fwk_status = %x\n", iqk->fwk_status);
+
+		for (i = 0; i < 2; i++) {
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[IQK] ======== Path %x  ========\n", i);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->iqk_band[%d] = %x\n",
+				    i, iqk->iqk_band[i]);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->iqk_ch[%d] = %x\n",
+				    i, iqk->iqk_ch[i]);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->iqk_bw[%d] = %x\n",
+				    i, iqk->iqk_bw[i]);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->lok_idac[%d] = %x\n",
+				    i, le32_to_cpu(iqk->lok_idac[i]));
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->lok_vbuf[%d] = %x\n",
+				    i, le32_to_cpu(iqk->lok_vbuf[i]));
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->iqk_tx_fail[%d] = %x\n",
+				    i, iqk->iqk_tx_fail[i]);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->iqk_rx_fail[%d] = %x\n",
+				    i, iqk->iqk_rx_fail[i]);
+			for (j = 0; j < 4; j++)
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[IQK] iqk->rftxgain[%d][%d] = %x\n",
+					    i, j, le32_to_cpu(iqk->rftxgain[i][j]));
+			for (j = 0; j < 4; j++)
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[IQK] iqk->tx_xym[%d][%d] = %x\n",
+					    i, j, le32_to_cpu(iqk->tx_xym[i][j]));
+			for (j = 0; j < 4; j++)
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[IQK] iqk->rfrxgain[%d][%d] = %x\n",
+					    i, j, le32_to_cpu(iqk->rfrxgain[i][j]));
+			for (j = 0; j < 4; j++)
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[IQK] iqk->rx_xym[%d][%d] = %x\n",
+					    i, j, le32_to_cpu(iqk->rx_xym[i][j]));
+		}
+		return;
 	case RTW89_PHY_C2H_RFK_LOG_FUNC_DPK:
 		if (len != sizeof(*dpk))
 			goto out;
-- 
2.25.1


