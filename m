Return-Path: <linux-wireless+bounces-27288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61527B570B7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09793AB490
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AEC2C08AC;
	Mon, 15 Sep 2025 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dLWaT2YE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3D2C1583
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919279; cv=none; b=sBw/73mC2dXH4EE3QJTBqMtvCsOnU2InkQD+WYAvfuuGKVqS1aQLOqcsINC2GEOohlm4N293qyG+8exRlOGy/02PT6wvDn3vccRKaA/NjQvs06ylP2+q9kzmu2ZqIC/usRoyEW8JboYQ3EdWsrgT2jxPQGoEhWdUH4oijky2fgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919279; c=relaxed/simple;
	bh=Qzc+oCIvIxILwlMn4pe1gQWD5NhHZM38Xj8HZkyt9bA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgWw9CLcX3VGWEPE7mlp6VVLZycOPOishStL91fM9S5MG5TNPzTJOrlqZOEoHXvAg+VKrkeCLI1emwn3I0JbyNSMdkEgG4gTeF2ArREIyW5lHX1EOT1ugePE3wHL7Yffc8ZkTVSIfzvvOw10XN0DGk0xkamENXSdNhSabq2SacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dLWaT2YE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6sZID1593525, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919275; bh=5tcsrv9a/sLTr8ZD8RpUOJC1tJ2fSi5JJRgaIURmjHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dLWaT2YEuk8ULtZHn8EioRCjScjguyXfMHqWsHXCLc2I23oeafSJiZvVyPQ+WjSsd
	 2kiY+xya1WLENDrO9Oic8DCUbycAW8S2bXjiYw27N/tSOGaWxRVDDPTybmFDPBJ4/E
	 k6gptR33f9tEmNV7sZg419l+pw154Uv3aGBagCUkk2BMG28lpx78kpIro4D7n4cbvx
	 6X76mzKRq+ncH30CrLrJsKAUZgeM5DQyCNhIRNSdURB4jX4nNuq7PqX7Zr2EDNx3uL
	 DOE37PrVhiy9GbaSlzIq2bLwXQyhYSLKWTh2HLu9rFn5jbY/5gVj6wXivnzAZigCEi
	 IXbzjKNUWAO5w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6sZID1593525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:54:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:54:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:54:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/11] wifi: rtw89: phy: initialize AFE by firmware element table
Date: Mon, 15 Sep 2025 14:53:14 +0800
Message-ID: <20250915065314.38846-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

A power-on sequence table is introduced to initialize AFE (Analogue Front
End) connecting to RF components. Build the sequence in firmware file,
and use a parser to execute the sequences including write/poll/delay
actions.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  2 +
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 15 ++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 36 ++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 85 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h  |  1 +
 6 files changed, 140 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b116f8d718ac..e445fcd02187 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5417,6 +5417,8 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
 	int ret;
 
+	rtw89_phy_init_bb_afe(rtwdev);
+
 	ret = rtw89_mac_init(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "mac init fail, ret:%d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2841ea84bbc0..708132363da3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4690,6 +4690,7 @@ struct rtw89_fw_elm_info {
 	struct rtw89_fw_txpwr_track_cfg *txpwr_trk;
 	struct rtw89_phy_rfk_log_fmt *rfk_log_fmt;
 	const struct rtw89_regd_data *regd;
+	const struct rtw89_fw_element_hdr *afe;
 };
 
 enum rtw89_fw_mss_dev_type {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5f330b625659..0ef3ee44e2f0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1285,6 +1285,18 @@ int rtw89_recognize_regd_from_elm(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static
+int rtw89_build_afe_pwr_seq_from_elm(struct rtw89_dev *rtwdev,
+				     const struct rtw89_fw_element_hdr *elm,
+				     const union rtw89_fw_element_arg arg)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+
+	elm_info->afe = elm;
+
+	return 0;
+}
+
 static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
 					{ .fw_type = RTW89_FW_BBMCU0 }, NULL},
@@ -1370,6 +1382,9 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_REGD] = {
 		rtw89_recognize_regd_from_elm, {}, "REGD",
 	},
+	[RTW89_FW_ELEMENT_ID_AFE_PWR_SEQ] = {
+		rtw89_build_afe_pwr_seq_from_elm, {}, "AFE",
+	},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index fad9d87d3e56..98b187305481 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3984,6 +3984,7 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_2GHZ = 24,
 	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_5GHZ = 25,
 	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_6GHZ = 26,
+	RTW89_FW_ELEMENT_ID_AFE_PWR_SEQ = 27,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
@@ -4089,6 +4090,30 @@ struct rtw89_fw_txpwr_track_cfg {
 	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_N) | \
 	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_P))
 
+enum rtw89_fw_afe_action {
+	RTW89_FW_AFE_ACTION_WRITE = 0,
+	RTW89_FW_AFE_ACTION_DELAY = 1,
+	RTW89_FW_AFE_ACTION_POLL = 2,
+};
+
+enum rtw89_fw_afe_cat {
+	RTW89_FW_AFE_CAT_BB = 0,
+	RTW89_FW_AFE_CAT_BB1 = 1,
+	RTW89_FW_AFE_CAT_MAC = 2,
+	RTW89_FW_AFE_CAT_MAC1 = 3,
+	RTW89_FW_AFE_CAT_AFEDIG = 4,
+	RTW89_FW_AFE_CAT_AFEDIG1 = 5,
+};
+
+enum rtw89_fw_afe_class {
+	RTW89_FW_AFE_CLASS_P0 = 0,
+	RTW89_FW_AFE_CLASS_P1 = 1,
+	RTW89_FW_AFE_CLASS_P2 = 2,
+	RTW89_FW_AFE_CLASS_P3 = 3,
+	RTW89_FW_AFE_CLASS_P4 = 4,
+	RTW89_FW_AFE_CLASS_CMN = 5,
+};
+
 struct rtw89_fw_element_hdr {
 	__le32 id; /* enum rtw89_fw_element_id */
 	__le32 size; /* exclude header size */
@@ -4126,6 +4151,17 @@ struct rtw89_fw_element_hdr {
 			u8 rsvd1[3];
 			__le16 offset[];
 		} __packed rfk_log_fmt;
+		struct {
+			u8 rsvd[8];
+			struct rtw89_phy_afe_info {
+				__le32 action; /* enum rtw89_fw_afe_action */
+				__le32 cat; /* enum rtw89_fw_afe_cat */
+				__le32 class; /* enum rtw89_fw_afe_class */
+				__le32 addr;
+				__le32 mask;
+				__le32 val;
+			} __packed infos[];
+		} __packed afe;
 		struct __rtw89_fw_txpwr_element txpwr;
 		struct __rtw89_fw_regd_element regd;
 	} __packed u;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 0e9cb0558eb3..45823c9e9448 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1702,6 +1702,91 @@ void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev)
 	rtw89_phy_bb_reset(rtwdev);
 }
 
+void rtw89_phy_init_bb_afe(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	const struct rtw89_fw_element_hdr *afe_elm = elm_info->afe;
+	const struct rtw89_phy_afe_info *info;
+	u32 action, cat, class;
+	u32 addr, mask, val;
+	u32 poll, rpt;
+	u32 n, i;
+
+	if (!afe_elm)
+		return;
+
+	n = le32_to_cpu(afe_elm->size) / sizeof(*info);
+
+	for (i = 0; i < n; i++) {
+		info = &afe_elm->u.afe.infos[i];
+
+		class = le32_to_cpu(info->class);
+		switch (class) {
+		case RTW89_FW_AFE_CLASS_P0:
+		case RTW89_FW_AFE_CLASS_P1:
+		case RTW89_FW_AFE_CLASS_CMN:
+			/* Currently support two paths */
+			break;
+		case RTW89_FW_AFE_CLASS_P2:
+		case RTW89_FW_AFE_CLASS_P3:
+		case RTW89_FW_AFE_CLASS_P4:
+		default:
+			rtw89_warn(rtwdev, "unexpected AFE class %u\n", class);
+			continue;
+		}
+
+		addr = le32_to_cpu(info->addr);
+		mask = le32_to_cpu(info->mask);
+		val = le32_to_cpu(info->val);
+		cat = le32_to_cpu(info->cat);
+		action = le32_to_cpu(info->action);
+
+		switch (action) {
+		case RTW89_FW_AFE_ACTION_WRITE:
+			switch (cat) {
+			case RTW89_FW_AFE_CAT_MAC:
+			case RTW89_FW_AFE_CAT_MAC1:
+				rtw89_write32_mask(rtwdev, addr, mask, val);
+				break;
+			case RTW89_FW_AFE_CAT_AFEDIG:
+			case RTW89_FW_AFE_CAT_AFEDIG1:
+				rtw89_write32_mask(rtwdev, addr, mask, val);
+				break;
+			case RTW89_FW_AFE_CAT_BB:
+				rtw89_phy_write32_idx(rtwdev, addr, mask, val, RTW89_PHY_0);
+				break;
+			case RTW89_FW_AFE_CAT_BB1:
+				rtw89_phy_write32_idx(rtwdev, addr, mask, val, RTW89_PHY_1);
+				break;
+			default:
+				rtw89_warn(rtwdev,
+					   "unexpected AFE writing action %u\n", action);
+				break;
+			}
+			break;
+		case RTW89_FW_AFE_ACTION_POLL:
+			for (poll = 0; poll <= 10; poll++) {
+				/*
+				 * For CAT_BB, AFE reads register with mcu_offset 0,
+				 * so both CAT_MAC and CAT_BB use the same method.
+				 */
+				rpt = rtw89_read32_mask(rtwdev, addr, mask);
+				if (rpt == val)
+					goto poll_done;
+
+				fsleep(1);
+			}
+			rtw89_warn(rtwdev, "failed to poll AFE cat=%u addr=0x%x mask=0x%x\n",
+				   cat, addr, mask);
+poll_done:
+			break;
+		case RTW89_FW_AFE_ACTION_DELAY:
+			fsleep(addr);
+			break;
+		}
+	}
+}
+
 static u32 rtw89_phy_nctl_poll(struct rtw89_dev *rtwdev)
 {
 	rtw89_phy_write32(rtwdev, 0x8080, 0x4);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 1184b3c16d6f..674397c4b9a9 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -829,6 +829,7 @@ bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 bool rtw89_phy_write_rf_v2(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			   u32 addr, u32 mask, u32 data);
 void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev);
+void rtw89_phy_init_bb_afe(struct rtw89_dev *rtwdev);
 void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio);
 void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 				const struct rtw89_reg2_def *reg,
-- 
2.25.1


