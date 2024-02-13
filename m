Return-Path: <linux-wireless+bounces-3508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBEE852A20
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CBD2830BB
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 07:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45D1B7E7;
	Tue, 13 Feb 2024 07:36:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE31B273
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809777; cv=none; b=cqI9oPKHzMbduwLftEr1A8bqg9wAO1sRvGZLglgdc6PGyQPk/wPyYhPEegzL1GoJQwjloLIhhNxiH88bKJHB6Ea9dTEQhPRdAZQjzfvQ1wAyZkS30zq4vuReOn8bZVB0qTdQNS4t2iNkQyKseXazgE1ODodgYIZdIKKx23Q4RxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809777; c=relaxed/simple;
	bh=XZ0+Am5xSB3WGt9kvvG4gLCfS2mRjDx+r/zIg9CwSR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGvuBX5NKEOBQNVDNPSIQIV9GtdzWGtyk2t6Rr3JOtkKCchrvUzf0jbSq+RpJRNY9Z3/xmrUM2DN4TKTFI4R8oGTTzXIgcgTpPRq48jdtS8rin3uBdSs6FPyynyaxgmbHoTyX2W70HwOeAfGJGjy8chnjWayixU55QXMzoLi5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41D7a71V11671594, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41D7a71V11671594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:36:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 13 Feb 2024 15:36:08 +0800
Received: from [127.0.1.1] (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 13 Feb
 2024 15:36:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: mac: implement MRC C2H event handling
Date: Tue, 13 Feb 2024 15:35:11 +0800
Message-ID: <20240213073514.23796-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213073514.23796-1-pkshih@realtek.com>
References: <20240213073514.23796-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add handling of MRC (multiple role concurrent) C2H events including
TSF report and status report. Parse report data and then complete the
corresponding H2C commands, which will be implemented in the following.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.h   | 18 +++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 91 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  2 +
 4 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e3913efedc28..6269ae2539b2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3918,7 +3918,7 @@ enum rtw89_host_rpr_mode {
 	RTW89_RPR_MODE_STF
 };
 
-#define RTW89_COMPLETION_BUF_SIZE 24
+#define RTW89_COMPLETION_BUF_SIZE 40
 #define RTW89_WAIT_COND_IDLE UINT_MAX
 
 struct rtw89_completion_data {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 409f62cea0d7..d44df3897dd2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3474,6 +3474,8 @@ struct rtw89_h2c_mrc_del {
 #define RTW89_H2C_MRC_DEL_W0_STOP_SLOT_IDX GENMASK(15, 8)
 #define RTW89_H2C_MRC_DEL_W0_SPECIFIC_ROLE_MACID GENMASK(31, 16)
 
+#define RTW89_MAC_MRC_MAX_REQ_TSF_NUM 2
+
 struct rtw89_h2c_mrc_req_tsf {
 	u8 req_tsf_num;
 	u8 infos[] __counted_by(req_tsf_num);
@@ -3710,6 +3712,13 @@ static_assert(sizeof(struct rtw89_mac_mcc_tsf_rpt) <= RTW89_COMPLETION_BUF_SIZE)
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_HIGH(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 4), GENMASK(31, 0))
 
+struct rtw89_mac_mrc_tsf_rpt {
+	unsigned int num;
+	u64 tsfs[RTW89_MAC_MRC_MAX_REQ_TSF_NUM];
+};
+
+static_assert(sizeof(struct rtw89_mac_mrc_tsf_rpt) <= RTW89_COMPLETION_BUF_SIZE);
+
 struct rtw89_c2h_mrc_tsf_rpt_info {
 	__le32 tsf_low;
 	__le32 tsf_high;
@@ -4129,8 +4138,17 @@ enum rtw89_mrc_h2c_func {
 	H2C_FUNC_MRC_SYNC		= 0x4,
 	H2C_FUNC_MRC_UPD_DURATION	= 0x5,
 	H2C_FUNC_MRC_UPD_BITMAP		= 0x6,
+
+	NUM_OF_RTW89_MRC_H2C_FUNC,
 };
 
+/* can consider MRC's sch_idx as MCC's group */
+#define RTW89_MRC_WAIT_COND(sch_idx, func) \
+	((sch_idx) * NUM_OF_RTW89_MRC_H2C_FUNC + (func))
+
+#define RTW89_MRC_WAIT_COND_REQ_TSF \
+	RTW89_MRC_WAIT_COND(0 /* don't care */, H2C_FUNC_MRC_REQ_TSF)
+
 #define H2C_CAT_OUTSRC			0x2
 
 #define H2C_CL_OUTSRC_RA		0x1
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3ea50d49e12f..908245ac46bd 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5099,6 +5099,84 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
 }
 
+static void
+rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	const struct rtw89_c2h_mrc_tsf_rpt *c2h_rpt;
+	struct rtw89_completion_data data = {};
+	struct rtw89_mac_mrc_tsf_rpt *rpt;
+	unsigned int i;
+
+	c2h_rpt = (const struct rtw89_c2h_mrc_tsf_rpt *)c2h->data;
+	rpt = (struct rtw89_mac_mrc_tsf_rpt *)data.buf;
+	rpt->num = min_t(u8, RTW89_MAC_MRC_MAX_REQ_TSF_NUM,
+			 le32_get_bits(c2h_rpt->w2,
+				       RTW89_C2H_MRC_TSF_RPT_W2_REQ_TSF_NUM));
+
+	for (i = 0; i < rpt->num; i++) {
+		u32 tsf_high = le32_to_cpu(c2h_rpt->infos[i].tsf_high);
+		u32 tsf_low = le32_to_cpu(c2h_rpt->infos[i].tsf_low);
+
+		rpt->tsfs[i] = (u64)tsf_high << 32 | tsf_low;
+
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MRC C2H TSF RPT: index %u> %llu\n",
+			    i, rpt->tsfs[i]);
+	}
+
+	rtw89_complete_cond(wait, RTW89_MRC_WAIT_COND_REQ_TSF, &data);
+}
+
+static void
+rtw89_mac_c2h_mrc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mcc.wait;
+	const struct rtw89_c2h_mrc_status_rpt *c2h_rpt;
+	struct rtw89_completion_data data = {};
+	enum rtw89_mac_mrc_status status;
+	unsigned int cond;
+	bool next = false;
+	u32 tsf_high;
+	u32 tsf_low;
+	u8 sch_idx;
+	u8 func;
+
+	c2h_rpt = (const struct rtw89_c2h_mrc_status_rpt *)c2h->data;
+	sch_idx = le32_get_bits(c2h_rpt->w2, RTW89_C2H_MRC_STATUS_RPT_W2_SCH_IDX);
+	status = le32_get_bits(c2h_rpt->w2, RTW89_C2H_MRC_STATUS_RPT_W2_STATUS);
+	tsf_high = le32_to_cpu(c2h_rpt->tsf_high);
+	tsf_low = le32_to_cpu(c2h_rpt->tsf_low);
+
+	switch (status) {
+	case RTW89_MAC_MRC_START_SCH_OK:
+		func = H2C_FUNC_START_MRC;
+		break;
+	case RTW89_MAC_MRC_STOP_SCH_OK:
+		/* H2C_FUNC_DEL_MRC without STOP_ONLY, so wait for DEL_SCH_OK */
+		func = H2C_FUNC_DEL_MRC;
+		next = true;
+		break;
+	case RTW89_MAC_MRC_DEL_SCH_OK:
+		func = H2C_FUNC_DEL_MRC;
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "invalid MRC C2H STS RPT: status %d\n", status);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MRC C2H STS RPT: sch_idx %d, status %d, tsf %llu\n",
+		    sch_idx, status, (u64)tsf_high << 32 | tsf_low);
+
+	if (next)
+		return;
+
+	cond = RTW89_MRC_WAIT_COND(sch_idx, func);
+	rtw89_complete_cond(wait, cond, &data);
+}
+
 static
 void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 					    struct sk_buff *c2h, u32 len) = {
@@ -5130,6 +5208,13 @@ void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
 };
 
+static
+void (* const rtw89_mac_c2h_mrc_handler[])(struct rtw89_dev *rtwdev,
+					   struct sk_buff *c2h, u32 len) = {
+	[RTW89_MAC_C2H_FUNC_MRC_TSF_RPT] = rtw89_mac_c2h_mrc_tsf_rpt,
+	[RTW89_MAC_C2H_FUNC_MRC_STATUS_RPT] = rtw89_mac_c2h_mrc_status_rpt,
+};
+
 static void rtw89_mac_c2h_scanofld_rsp_atomic(struct rtw89_dev *rtwdev,
 					      struct sk_buff *skb)
 {
@@ -5180,6 +5265,8 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		}
 	case RTW89_MAC_C2H_CLASS_MCC:
 		return true;
+	case RTW89_MAC_C2H_CLASS_MRC:
+		return true;
 	}
 }
 
@@ -5202,6 +5289,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MCC)
 			handler = rtw89_mac_c2h_mcc_handler[func];
 		break;
+	case RTW89_MAC_C2H_CLASS_MRC:
+		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MRC)
+			handler = rtw89_mac_c2h_mrc_handler[func];
+		break;
 	case RTW89_MAC_C2H_CLASS_FWDBG:
 		return;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 12318d850475..db95509fad2f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -409,6 +409,8 @@ enum rtw89_mac_c2h_mcc_func {
 enum rtw89_mac_c2h_mrc_func {
 	RTW89_MAC_C2H_FUNC_MRC_TSF_RPT = 0,
 	RTW89_MAC_C2H_FUNC_MRC_STATUS_RPT = 1,
+
+	NUM_OF_RTW89_MAC_C2H_FUNC_MRC,
 };
 
 enum rtw89_mac_c2h_class {
-- 
2.25.1


