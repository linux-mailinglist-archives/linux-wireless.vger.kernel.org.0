Return-Path: <linux-wireless+bounces-31206-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLKHN0J9eGkFqQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31206-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:54:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6275291525
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B2353067073
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F42DB7A4;
	Tue, 27 Jan 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Nvsc6q10"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A42D663D
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503892; cv=none; b=RUNZLFIHL7CGIsYsnlvJD+wsJD5JLOz187txPbiCeruqxWiteL8YBneKJEUS6w+evO/fR48YHGuIfWXY0AJt8fSjneHvFXjVINN50BdOqqDjv9GPoBTDc96HOcKbzU4/KvRXkDfCfEJ5DPI7jzewxd/wqx1QcQbmHq4/f92RtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503892; c=relaxed/simple;
	bh=w2NHDza0iYfQPNp9ZUPfFxjWV5MhIgKBOMjzY9v1Dkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXQx7qCjClO3hQRhos92rQbcT7DNlY3Li0PZ5bKmuzRaes5jmTvUAAo4JCtpY91JOc6kTMLrUTAnrUmmvNr+kMRalY2jaKKwFD0y6YO4AkmgcvKmnq2vZ0pwS5nzzbQpyQtRD8yQl/I5A7iBlisy968Kd8flJg9H1m4b+bbb7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Nvsc6q10; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60R8pRu352655460, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769503888; bh=4nyP++6Jj7m8TNcgzQhsq81LtLfNs1QhiIxiCVRVgG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Nvsc6q10AP4jZLm5JfpP2lxr8LRc3QxZg8jpedfJA8Mf6V+FDudWb4IupvMIlgy0N
	 En6+ckFStrSe6Uf3j0fA6wBV5QBEOBZIiSzo3SkEUsVIIH/gXktwSVM1aAGK5+AmPx
	 NVZugKkMBv3UXdGivE2ZgFvUqBHPiXVVX9eqYilqsxXewajwU4b7zBxhW2J6+r08pz
	 dPiMKeC9qmnrNS5+qK1SmnywllDPrmuHqi09v+tc1NioZ7Zu3qNW15O6N8hPqloOM/
	 bN/Nj0RvsYYUVpmfXR6dPgvROL0qB+vVKvUjygrwDodtMROpHA78VuHP9LGWHe2q0w
	 lFEwnrC5a99DA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60R8pRu352655460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 16:51:27 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 27 Jan 2026 16:51:28 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 27 Jan 2026 16:51:22 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 16:51:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 1/6] wifi: rtw89: debug: rename mac/ctrl error to L0/L1 error
Date: Tue, 27 Jan 2026 16:50:31 +0800
Message-ID: <20260127085036.44060-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260127085036.44060-1-pkshih@realtek.com>
References: <20260127085036.44060-1-pkshih@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31206-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6275291525
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Sync Realtek terms on SER (system error recovery) simulation.

No logic is changed.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 969b9c7e35a3..56b52e780dac 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3538,7 +3538,7 @@ rtw89_debug_priv_early_h2c_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
-static int rtw89_dbg_trigger_ctrl_error_by_halt_h2c(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l1_error_by_halt_h2c(struct rtw89_dev *rtwdev)
 {
 	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
 		return -EBUSY;
@@ -3546,7 +3546,7 @@ static int rtw89_dbg_trigger_ctrl_error_by_halt_h2c(struct rtw89_dev *rtwdev)
 	return rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_RESET_FORCE);
 }
 
-static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l1_error(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_cpuio_ctrl ctrl_para = {0};
@@ -3554,7 +3554,7 @@ static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 	int ret;
 
 	if (RTW89_CHK_FW_FEATURE(SIM_SER_L0L1_BY_HALT_H2C, &rtwdev->fw))
-		return rtw89_dbg_trigger_ctrl_error_by_halt_h2c(rtwdev);
+		return rtw89_dbg_trigger_l1_error_by_halt_h2c(rtwdev);
 
 	rtw89_leave_ps_mode(rtwdev);
 
@@ -3576,7 +3576,7 @@ static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_dbg_trigger_mac_error_ax(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l0_error_ax(struct rtw89_dev *rtwdev)
 {
 	u16 val16;
 	u8 val8;
@@ -3598,7 +3598,7 @@ static int rtw89_dbg_trigger_mac_error_ax(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_dbg_trigger_mac_error_be(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l0_error_be(struct rtw89_dev *rtwdev)
 {
 	int ret;
 
@@ -3612,7 +3612,7 @@ static int rtw89_dbg_trigger_mac_error_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_dbg_trigger_mac_error_by_halt_h2c(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l0_error_by_halt_h2c(struct rtw89_dev *rtwdev)
 {
 	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
 		return -EBUSY;
@@ -3620,20 +3620,20 @@ static int rtw89_dbg_trigger_mac_error_by_halt_h2c(struct rtw89_dev *rtwdev)
 	return rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L0_RESET_FORCE);
 }
 
-static int rtw89_dbg_trigger_mac_error(struct rtw89_dev *rtwdev)
+static int rtw89_dbg_trigger_l0_error(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (RTW89_CHK_FW_FEATURE(SIM_SER_L0L1_BY_HALT_H2C, &rtwdev->fw))
-		return rtw89_dbg_trigger_mac_error_by_halt_h2c(rtwdev);
+		return rtw89_dbg_trigger_l0_error_by_halt_h2c(rtwdev);
 
 	rtw89_leave_ps_mode(rtwdev);
 
 	switch (chip->chip_gen) {
 	case RTW89_CHIP_AX:
-		return rtw89_dbg_trigger_mac_error_ax(rtwdev);
+		return rtw89_dbg_trigger_l0_error_ax(rtwdev);
 	case RTW89_CHIP_BE:
-		return rtw89_dbg_trigger_mac_error_be(rtwdev);
+		return rtw89_dbg_trigger_l0_error_be(rtwdev);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3653,8 +3653,8 @@ rtw89_debug_priv_fw_crash_get(struct rtw89_dev *rtwdev,
 
 enum rtw89_dbg_crash_simulation_type {
 	RTW89_DBG_SIM_CPU_EXCEPTION = 1,
-	RTW89_DBG_SIM_CTRL_ERROR = 2,
-	RTW89_DBG_SIM_MAC_ERROR = 3,
+	RTW89_DBG_SIM_L1_ERROR = 2,
+	RTW89_DBG_SIM_L0_ERROR = 3,
 };
 
 static ssize_t
@@ -3679,11 +3679,11 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 			return -EOPNOTSUPP;
 		sim = rtw89_fw_h2c_trigger_cpu_exception;
 		break;
-	case RTW89_DBG_SIM_CTRL_ERROR:
-		sim = rtw89_dbg_trigger_ctrl_error;
+	case RTW89_DBG_SIM_L1_ERROR:
+		sim = rtw89_dbg_trigger_l1_error;
 		break;
-	case RTW89_DBG_SIM_MAC_ERROR:
-		sim = rtw89_dbg_trigger_mac_error;
+	case RTW89_DBG_SIM_L0_ERROR:
+		sim = rtw89_dbg_trigger_l0_error;
 
 		/* Driver SER flow won't get involved; only FW will. */
 		announce = false;
-- 
2.25.1


