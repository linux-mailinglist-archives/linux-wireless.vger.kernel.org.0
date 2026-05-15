Return-Path: <linux-wireless+bounces-36441-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJzZKOR6BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36441-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:46:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A7454885B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAD7030597AF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7866336EDE;
	Fri, 15 May 2026 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jGULe087"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314862C08AB
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809495; cv=none; b=e1EA9wKomWYL+Ve0GvhNu67r6PVrKR+HzeIPSOX4QJ8XC86RBKglCdvdSq1cQxnO4Vl2z9gqj8GGwS5XX6FcZuqN9/TTtT4FIE2HF1nKKnt83b/W9DUYZoNl0kuXEfj82sE3LuWUnqycbhR5uQ4cWPOiwBWJJJFZhbDmFEOhjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809495; c=relaxed/simple;
	bh=q/FeiYcNj/QR8bcV9cyccYLaw03ngsnTnpmcVvj2a08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5RrfIJ3i4bMSHmOF6SpPDAKQ4eTB0QWtVLOzgtaJ/B/K2gB/ITR09rvl1bSBB0anfUqstnFWLoIcbFgT/FUN0Seb2c5oSAcPixGKXLz0li1D8hlTrG8LDQ8qnWgDlWkU0nYWTLFw16gSvuNIP/MNqupIj75qH6bTbhFGNCEnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jGULe087; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1iqmN72587077, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809492; bh=t8vq6N2NhRUuKKd+jAQud93n4ZYl4mU0vJbEQcdsNLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jGULe087FV2bT4eQlw53Bd+LpE7S3fB+wQVRGW3xEOL05TFE8PTmSFnEPhbafd3p5
	 jwgMHd4hfnV3U/wO1a5edAHdAWke3rHMW7w78atKP6b1KvAyYI/kdl0/zdM1esJRKi
	 EP2FSwDq9tAd9Lg/mPUL4b4Ju2qHdEEwxvFZXLdy/dY23hENW095STgySX2Yc3IsJu
	 q0W+m1dmMRYK4rV7tHaHfTX8uAP3ZH5SA1SYGDwXrfoW41Ey6vilUe4f+8TrbhHVRs
	 tMyxTdqIZwVh9QDs4pFYSLbbSoieCNPf6yRb7BBZd+aXNI/Y7fd/e7BGmH7y7GGaqG
	 eCgXz6w/CHP7w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1iqmN72587077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:44:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:44:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:44:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/13] wifi: rtw89: debug: Wi-Fi 7 update simulation of SER L0/L1 by halt H2C command
Date: Fri, 15 May 2026 09:44:22 +0800
Message-ID: <20260515014433.16168-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 42A7454885B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36441-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Wi-Fi 7 FW fixes support of triggering SER L0/L1 simulation via halt H2C
command on v0.35.108.0. After that, the halt H2C command trigger for
Wi-Fi 6 and Wi-Fi 7 can be the same. Update FW feature table and share the
halt H2C command trigger function between Wi-Fi 6 and Wi-Fi 7.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 101 +++++++++------------
 drivers/net/wireless/realtek/rtw89/fw.c    |   2 +-
 2 files changed, 45 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index e5976b8e7056..c0fbb016cea4 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3543,20 +3543,38 @@ rtw89_debug_priv_early_h2c_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
-static int rtw89_dbg_trigger_l1_error_by_halt_h2c_ax(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l1_error_ax(struct rtw89_dev *rtwdev)
 {
-	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
-		return -EBUSY;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	struct rtw89_cpuio_ctrl ctrl_para = {};
+	u16 pkt_id;
+	int ret;
 
-	return rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_RESET_FORCE);
+	ret = mac->dle_buf_req(rtwdev, 0x20, true, &pkt_id);
+	if (ret)
+		return ret;
+
+	/* intentionally, enqueue two pkt, but has only one pkt id */
+	ctrl_para.cmd_type = CPUIO_OP_CMD_ENQ_TO_HEAD;
+	ctrl_para.start_pktid = pkt_id;
+	ctrl_para.end_pktid = pkt_id;
+	ctrl_para.pkt_num = 1; /* start from 0 */
+	ctrl_para.dst_pid = WDE_DLE_PORT_ID_WDRLS;
+	ctrl_para.dst_qid = WDE_DLE_QUEID_NO_REPORT;
+
+	if (mac->set_cpuio(rtwdev, &ctrl_para, true))
+		return -EFAULT;
+
+	return 0;
 }
 
-static int rtw89_dbg_trigger_l1_error_by_halt_h2c_be(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l1_error_be(struct rtw89_dev *rtwdev)
 {
-	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
-		return -EBUSY;
+	int ret;
 
-	rtw89_leave_ps_mode(rtwdev);
+	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
+	if (ret)
+		return ret;
 
 	rtw89_write32_set(rtwdev, R_BE_FW_TRIGGER_IDCT_ISR,
 			  B_BE_DMAC_FW_TRIG_IDCT | B_BE_DMAC_FW_ERR_IDCT_IMR);
@@ -3565,47 +3583,35 @@ static int rtw89_dbg_trigger_l1_error_by_halt_h2c_be(struct rtw89_dev *rtwdev)
 }
 
 static int rtw89_dbg_trigger_l1_error_by_halt_h2c(struct rtw89_dev *rtwdev)
+{
+	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
+		return -EBUSY;
+
+	return rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_RESET_FORCE);
+}
+
+static int rtw89_dbg_trigger_l1_error(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	int (*sim_l1)(struct rtw89_dev *rtwdev);
 
 	switch (chip->chip_gen) {
 	case RTW89_CHIP_AX:
-		return rtw89_dbg_trigger_l1_error_by_halt_h2c_ax(rtwdev);
+		sim_l1 = rtw89_dbg_trigger_l1_error_ax;
+		break;
 	case RTW89_CHIP_BE:
-		return rtw89_dbg_trigger_l1_error_by_halt_h2c_be(rtwdev);
+		sim_l1 = rtw89_dbg_trigger_l1_error_be;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-}
-
-static int rtw89_dbg_trigger_l1_error(struct rtw89_dev *rtwdev)
-{
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	struct rtw89_cpuio_ctrl ctrl_para = {0};
-	u16 pkt_id;
-	int ret;
 
 	if (RTW89_CHK_FW_FEATURE(SIM_SER_L0L1_BY_HALT_H2C, &rtwdev->fw))
 		return rtw89_dbg_trigger_l1_error_by_halt_h2c(rtwdev);
 
 	rtw89_leave_ps_mode(rtwdev);
 
-	ret = mac->dle_buf_req(rtwdev, 0x20, true, &pkt_id);
-	if (ret)
-		return ret;
-
-	/* intentionally, enqueue two pkt, but has only one pkt id */
-	ctrl_para.cmd_type = CPUIO_OP_CMD_ENQ_TO_HEAD;
-	ctrl_para.start_pktid = pkt_id;
-	ctrl_para.end_pktid = pkt_id;
-	ctrl_para.pkt_num = 1; /* start from 0 */
-	ctrl_para.dst_pid = WDE_DLE_PORT_ID_WDRLS;
-	ctrl_para.dst_qid = WDE_DLE_QUEID_NO_REPORT;
-
-	if (mac->set_cpuio(rtwdev, &ctrl_para, true))
-		return -EFAULT;
-
-	return 0;
+	return sim_l1(rtwdev);
 }
 
 static int rtw89_dbg_trigger_l0_error_ax(struct rtw89_dev *rtwdev)
@@ -3632,22 +3638,19 @@ static int rtw89_dbg_trigger_l0_error_ax(struct rtw89_dev *rtwdev)
 
 static int rtw89_dbg_trigger_l0_error_be(struct rtw89_dev *rtwdev)
 {
-	u8 val8;
 	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
 	if (ret)
 		return ret;
 
-	val8 = rtw89_read8(rtwdev, R_BE_CMAC_FUNC_EN);
-	rtw89_write8(rtwdev, R_BE_CMAC_FUNC_EN, val8 & ~B_BE_TMAC_EN);
-	mdelay(1);
-	rtw89_write8(rtwdev, R_BE_CMAC_FUNC_EN, val8);
+	rtw89_write32_set(rtwdev, R_BE_CMAC_FW_TRIGGER_IDCT_ISR,
+			  B_BE_CMAC_FW_TRIG_IDCT | B_BE_CMAC_FW_ERR_IDCT_IMR);
 
 	return 0;
 }
 
-static int rtw89_dbg_trigger_l0_error_by_halt_h2c_ax(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l0_error_by_halt_h2c(struct rtw89_dev *rtwdev)
 {
 	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
 		return -EBUSY;
@@ -3655,32 +3658,16 @@ static int rtw89_dbg_trigger_l0_error_by_halt_h2c_ax(struct rtw89_dev *rtwdev)
 	return rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L0_RESET_FORCE);
 }
 
-static int rtw89_dbg_trigger_l0_error_by_halt_h2c_be(struct rtw89_dev *rtwdev)
-{
-	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
-		return -EBUSY;
-
-	rtw89_leave_ps_mode(rtwdev);
-
-	rtw89_write32_set(rtwdev, R_BE_CMAC_FW_TRIGGER_IDCT_ISR,
-			  B_BE_CMAC_FW_TRIG_IDCT | B_BE_CMAC_FW_ERR_IDCT_IMR);
-
-	return 0;
-}
-
 static int rtw89_dbg_trigger_l0_error(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	int (*sim_l0_by_halt_h2c)(struct rtw89_dev *rtwdev);
 	int (*sim_l0)(struct rtw89_dev *rtwdev);
 
 	switch (chip->chip_gen) {
 	case RTW89_CHIP_AX:
-		sim_l0_by_halt_h2c = rtw89_dbg_trigger_l0_error_by_halt_h2c_ax;
 		sim_l0 = rtw89_dbg_trigger_l0_error_ax;
 		break;
 	case RTW89_CHIP_BE:
-		sim_l0_by_halt_h2c = rtw89_dbg_trigger_l0_error_by_halt_h2c_be;
 		sim_l0 = rtw89_dbg_trigger_l0_error_be;
 		break;
 	default:
@@ -3688,7 +3675,7 @@ static int rtw89_dbg_trigger_l0_error(struct rtw89_dev *rtwdev)
 	}
 
 	if (RTW89_CHK_FW_FEATURE(SIM_SER_L0L1_BY_HALT_H2C, &rtwdev->fw))
-		return sim_l0_by_halt_h2c(rtwdev);
+		return rtw89_dbg_trigger_l0_error_by_halt_h2c(rtwdev);
 
 	rtw89_leave_ps_mode(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ff3914a16b81..c5a598a507f4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -931,8 +931,8 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, RFK_PRE_NOTIFY_MCC_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 84, 0, ADDR_CAM_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 92, 0, TX_HISTORY_V1),
-	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 97, 0, SIM_SER_L0L1_BY_HALT_H2C),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 100, 0, SER_POST_RECOVER_DMAC),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 108, 0, SIM_SER_L0L1_BY_HALT_H2C),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
-- 
2.25.1


