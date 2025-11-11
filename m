Return-Path: <linux-wireless+bounces-28821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01586C4B348
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD11D1892FFF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E0347BCA;
	Tue, 11 Nov 2025 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nSPs3YvB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF02BCF43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827941; cv=none; b=I56YCNNfEIN7ZDw/2+DGNbOwJd5JgVve+tll9KezMS+qz51UezgtgGQMMZrSEs7B+NPiWiLQI05oY9dbB9gK15fkDDdb8vGoEj2yyQt4PPMrWvA4xoGh4m5b7E3K85Kt0mLKFExEym7GeVIeWDAGedodWsboThIF1fNjLKEI5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827941; c=relaxed/simple;
	bh=6FH58xl08wZ7zIUUnsdFvZXRMAwOyqDMEf1uc7Dv1t0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDeTBp/iv8vQMGD7R8QuUF1svcY7halbS+kd3Zr8fB+R40oR3F6HQKO2nA0tygHwl18V4XupjVmVnBNc7gIUCwYtF8zYYZvXdBd10r1+qK8oSAbErQxx/ENb8RFVTfpBqL1hjHHkeQ88gDaP25yuGmjj83G5gAq+3rWkm44/QoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nSPs3YvB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2Pa0yA2922192, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827936; bh=TpPq+AV1AYIdEpPiKW6thP6BmLQcB0f90IWyVaxuOZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nSPs3YvBMwMHJyOH5g82SKZp3f6kImEUtQGsQzch0PSzQxb9jP70eh1k/mfyfFP2/
	 VSq7a9RweL0XVjx8MDw6X/vbDcWHzLGtQhuw36w6DgxE8HOhwtjhfgfvMQGRTStebK
	 O8QRmcORlXF6E27FWhHJWZ7WuzkZ3khpsBSa1uSuWA/OM5c9lUgAUB3bZ9RAE9hfb/
	 LQhyDWarrBFsmRW8AA5d4F1K1ryuLG0qxZVlKeG5tADNn0+yirwTQ/VIJduTD6gGkG
	 vzSmAxB+fahqr0/9z7AtLShaRRfwHY27VHTSUBA1HZ0kSHprIvAZcDllyr3PZ1PaLE
	 JjxGRa3famPdg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2Pa0yA2922192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:25:36 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:25:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH v2 rtw-next 2/8] wifi: rtw89: fw: parse firmware element of DIAG_MAC
Date: Tue, 11 Nov 2025 10:24:46 +0800
Message-ID: <20251111022452.28093-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251111022452.28093-1-pkshih@realtek.com>
References: <20251111022452.28093-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The firmware element ID 28 is a set of rules to diagnose if MAC get
abnormal. The latter patch will use these rules via debugfs to know
the status.

The element contains rules with their textual messages shown as below:

   +------------------------------------+
   |                                    |
   |                +-----------+       |
   |                | rule_size |-------|----------+
   +----------------+-----------+-------+ --       |
   |             rule[0]                |   \      |
   |             rule[1]                |   |  <---+
   |                :                   |   /
   +------------------------------------+ --
   | msg[0]      msg[1]                 |  each msg has variable length
   |        msg[2]    msg[3] ...        |  (with address align 2)
   | ...                                |
   +------------------------------------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e6584462f6c0..34c135269627 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4728,6 +4728,7 @@ struct rtw89_fw_elm_info {
 	struct rtw89_phy_rfk_log_fmt *rfk_log_fmt;
 	const struct rtw89_regd_data *regd;
 	const struct rtw89_fw_element_hdr *afe;
+	const struct rtw89_fw_element_hdr *diag_mac;
 };
 
 enum rtw89_fw_mss_dev_type {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 96f0463e66d6..515e9f098380 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1298,6 +1298,18 @@ int rtw89_build_afe_pwr_seq_from_elm(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static
+int rtw89_recognize_diag_mac_from_elm(struct rtw89_dev *rtwdev,
+				      const struct rtw89_fw_element_hdr *elm,
+				      const union rtw89_fw_element_arg arg)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+
+	elm_info->diag_mac = elm;
+
+	return 0;
+}
+
 static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
 					{ .fw_type = RTW89_FW_BBMCU0 }, NULL},
@@ -1386,6 +1398,9 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_AFE_PWR_SEQ] = {
 		rtw89_build_afe_pwr_seq_from_elm, {}, "AFE",
 	},
+	[RTW89_FW_ELEMENT_ID_DIAG_MAC] = {
+		rtw89_recognize_diag_mac_from_elm, {}, NULL,
+	},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 310580206368..6620256e3f22 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4026,6 +4026,7 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_5GHZ = 25,
 	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_6GHZ = 26,
 	RTW89_FW_ELEMENT_ID_AFE_PWR_SEQ = 27,
+	RTW89_FW_ELEMENT_ID_DIAG_MAC = 28,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
@@ -4203,6 +4204,11 @@ struct rtw89_fw_element_hdr {
 				__le32 val;
 			} __packed infos[];
 		} __packed afe;
+		struct {
+			__le32 rule_size;
+			u8 rsvd[4];
+			u8 rules_and_msgs[];
+		} __packed diag_mac;
 		struct __rtw89_fw_txpwr_element txpwr;
 		struct __rtw89_fw_regd_element regd;
 	} __packed u;
-- 
2.25.1


