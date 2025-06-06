Return-Path: <linux-wireless+bounces-23788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F5ACFB16
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C4E3A8AF6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 02:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E31C700D;
	Fri,  6 Jun 2025 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GDUiTYAz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53E29A2
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175492; cv=none; b=clmXdk1dOSHMcumqVM118BptQ9z01ojXRirfXsEarVPpfJV+KWZuiTSDJKFFf8ZbRtIat8s6JRenx2mi/YJ15ehLzNsmUEdT0UFfv4ovBl2MRY2KxHso1nKBdCi0FgG4ynWpGIVATxsUZ1CNhhNetGKlckORrTRscP9nzu9jaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175492; c=relaxed/simple;
	bh=axoQ45abh68Oc8HT1ipShqi60BQ+CmfuBR1npRf3wvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H93iSBqqIotHHFaFx3pSJU0UKoEMhRfDcluh+Vl/gvxKIHdfad6oEoJockeBwvTOa+1USTp0vhJp/loI0tYXNf2y3a5/aZoMVi8JkjaIsgGDJSPyItZn64jx0cFhG/SKNvJDrR7/lBzqiila2dteva4XFslFon1+Gijbwofzqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GDUiTYAz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55624nV922621395, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749175489; bh=02A7RTwwgYRQTpN/Ei7c/5kj7qzz8AlRt8jSW3XYwww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GDUiTYAz4vzBwrO8cUkw971Ip3qkzxFAjWNQk72G1yjE/bqcCRdUchLCHhTicmKHQ
	 wEXlb/E4Xg3vbIecUOZoEQSBtdJLBF04iB0EdYrlYwaO/9ueXujOgq7F4IXJFPOrJz
	 CqFSHoduSHj/hIQu0ZGCdt8uQheHd/h1MKXMVmFAlAp5gCZByk1LxRyHYJybwiY1+X
	 pT2kuABMMZ/Wdu9Fvxy6xrM4BhG8NZghp9QxUTEZnEt9jL+oxLa3rbDERC5Hr7zcPI
	 THzjQCfmwYY4w0WqncYPqk89C2v37AT/02zlsDEncM8h3Rg0m4qjltG/D9LrfW3e4g
	 6iwHeEenJqxgw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55624nV922621395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 10:04:49 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 10:04:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Jun
 2025 10:04:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 6/6] wifi: rtw89: 8922a: pass channel information when enter LPS
Date: Fri, 6 Jun 2025 10:04:37 +0800
Message-ID: <20250606020437.17160-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250606020302.16873-1-pkshih@realtek.com>
References: <20250606020302.16873-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

From: Kuan-Chung Chen <damon.chen@realtek.com>

Newer firmware requires the driver to pass channel information
when switching from normal mode to low power mode; otherwise it
will result in poor RX beacon performance.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 59 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |  8 ++++
 drivers/net/wireless/realtek/rtw89/ps.c |  2 +
 3 files changed, 69 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0547eb11d378..95865eafb2cd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5919,6 +5919,65 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_rf_ntfy_mcc);
 
+int rtw89_fw_h2c_rf_ps_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_h2c_rf_ps_info *h2c;
+	const struct rtw89_chan *chan;
+	u32 len = sizeof(*h2c);
+	unsigned int link_id;
+	struct sk_buff *skb;
+	int ret;
+	u8 path;
+	u32 val;
+
+	if (chip->chip_gen != RTW89_CHIP_BE)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c rf ps info\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_rf_ps_info *)skb->data;
+	h2c->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+		path = rtw89_phy_get_syn_sel(rtwdev, rtwvif_link->phy_idx);
+		val = rtw89_chip_chan_to_rf18_val(rtwdev, chan);
+
+		if (path >= chip->rf_path_num) {
+			rtw89_err(rtwdev, "unsupported rf path (%d)\n", path);
+			ret = -ENOENT;
+			goto fail;
+		}
+
+		h2c->rf18[path] = cpu_to_le32(val);
+		h2c->pri_ch[path] = chan->primary_channel;
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_NOTIFY,
+			      H2C_FUNC_OUTSRC_RF_PS_INFO, 0, 0,
+			      sizeof(*h2c));
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtw89_fw_h2c_rf_ps_info);
+
 int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d4815bcce91b..14f55b10be2e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4337,6 +4337,7 @@ enum rtw89_mrc_h2c_func {
 #define H2C_CL_OUTSRC_RF_REG_B		0x9
 #define H2C_CL_OUTSRC_RF_FW_NOTIFY	0xa
 #define H2C_FUNC_OUTSRC_RF_GET_MCCCH	0x2
+#define H2C_FUNC_OUTSRC_RF_PS_INFO	0x10
 #define H2C_CL_OUTSRC_RF_FW_RFK		0xb
 
 enum rtw89_rfk_offload_h2c_func {
@@ -4361,6 +4362,12 @@ struct rtw89_fw_h2c_rf_get_mccch {
 #define NUM_OF_RTW89_FW_RFK_PATH 2
 #define NUM_OF_RTW89_FW_RFK_TBL 3
 
+struct rtw89_h2c_rf_ps_info {
+	__le32 rf18[NUM_OF_RTW89_FW_RFK_PATH];
+	__le32 mlo_mode;
+	u8 pri_ch[NUM_OF_RTW89_FW_RFK_PATH];
+} __packed;
+
 struct rtw89_fw_h2c_rfk_pre_info_common {
 	struct {
 		__le32 ch[NUM_OF_RTW89_FW_RFK_PATH][NUM_OF_RTW89_FW_RFK_TBL];
@@ -4744,6 +4751,7 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page);
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_rf_ps_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 8e4fe73e7d77..c255c2f9b945 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -137,6 +137,8 @@ void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			can_ps_mode = false;
 	}
 
+	rtw89_fw_h2c_rf_ps_info(rtwdev, rtwvif);
+
 	if (RTW89_CHK_FW_FEATURE(LPS_CH_INFO, &rtwdev->fw))
 		rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif);
 	else
-- 
2.25.1


