Return-Path: <linux-wireless+bounces-30065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2FCD7F10
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A79E3053B05
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0C82C3252;
	Tue, 23 Dec 2025 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kIEtVzp5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89022C11E7
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459273; cv=none; b=s0KFmP4nh9mmUxgxqTFTomI4iK1JjAkQ3Dvpy3TrfqjQDheaGYrYJlRYNblZGVRgp4vyI8sLaMjleutYBMX+kxSZi83adDXFV4pvinXBbI33PAiE3PgKeCdBvUvAtGEcYctfyC1D/derZ06sllIdAXae7ureZkfxfiIQl/alndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459273; c=relaxed/simple;
	bh=v9Wy6oQLc41I+DZDE9/vkp6gqVIrjeO81DdroC3QNIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qD+6Ga33ANtJ7xUYMfOHwBoKWTnilmV711k/pTjzR1D7q3NaOb+a2zDiQXzOVScO876o7bW0vfkktN1qmuxeLyko9rzfcd8SQpqIlTzqnmT7cfYhZGdHG6Tp4I/rxhxaqeo/zpYGdmR/kCPZQIBVWXq6HPLVZreREfL6xbLd2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kIEtVzp5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN37nB32571253, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766459269; bh=aw53DYMSglVeqK9q5Al/epjlFyT2XSiSvRWZNBdhLRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kIEtVzp5HbOyBpjQIjZtBCJ8N8bJ3Fa1VwHxT1sWD2+L7onFNUXYoUSA47+ki0DKk
	 S883hAgZkHKFxfk5JJ5bDizSg7npOWenBrobTuOo4qn/q3tRpV/Yhmvgh+k8fDkvdo
	 0unuPLFNCGHRlLDv2+7AS19L2HwKca+hnt3s7vT4e8JxyT+LoySGWxQpf8vEAMYBR0
	 44lDzSK5sKmUHLcAKRepquAei8MYstAJ+Rcy1xXa/NCdeL3iAS4oS0L6O9ckgO1hby
	 JwNaKIG12MXgW8BdVcbNCRv0iFF34l236oOYyuk5h7e9tY81lSg81tvgC0QE0HQDuB
	 +BG27Og48gxWw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN37nB32571253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 11:07:49 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:49 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:48 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:07:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v3 08/12] wifi: rtw89: debug: support SER L0/L1 simulation via halt H2C
Date: Tue, 23 Dec 2025 11:06:47 +0800
Message-ID: <20251223030651.480633-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251223030651.480633-1-pkshih@realtek.com>
References: <20251223030651.480633-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Original methods of SER (system error recovery) L0/L1 simulations need
to leave PS mode before working. Introduce new methods to simulate SER
L0/L1 and they can work under PS. Since new methods require FW support,
so add a FW feature flag and configure the supported chips.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  1 +
 drivers/net/wireless/realtek/rtw89/debug.c | 22 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c    |  4 ++++
 drivers/net/wireless/realtek/rtw89/mac.h   |  3 +++
 4 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4c35b968ac36..64e7b241074b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4683,6 +4683,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_BEACON_TRACKING,
 	RTW89_FW_FEATURE_ADDR_CAM_V0,
 	RTW89_FW_FEATURE_SER_L1_BY_EVENT,
+	RTW89_FW_FEATURE_SIM_SER_L0L1_BY_HALT_H2C,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 0d9a158f6df1..2b48ccea27fb 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3538,6 +3538,14 @@ rtw89_debug_priv_early_h2c_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
+static int rtw89_dbg_trigger_ctrl_error_by_halt_h2c(struct rtw89_dev *rtwdev)
+{
+	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
+		return -EBUSY;
+
+	return rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_RESET_FORCE);
+}
+
 static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
@@ -3545,6 +3553,9 @@ static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 	u16 pkt_id;
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(SIM_SER_L0L1_BY_HALT_H2C, &rtwdev->fw))
+		return rtw89_dbg_trigger_ctrl_error_by_halt_h2c(rtwdev);
+
 	rtw89_leave_ps_mode(rtwdev);
 
 	ret = mac->dle_buf_req(rtwdev, 0x20, true, &pkt_id);
@@ -3601,10 +3612,21 @@ static int rtw89_dbg_trigger_mac_error_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_dbg_trigger_mac_error_by_halt_h2c(struct rtw89_dev *rtwdev)
+{
+	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
+		return -EBUSY;
+
+	return rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L0_RESET_FORCE);
+}
+
 static int rtw89_dbg_trigger_mac_error(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
+	if (RTW89_CHK_FW_FEATURE(SIM_SER_L0L1_BY_HALT_H2C, &rtwdev->fw))
+		return rtw89_dbg_trigger_mac_error_by_halt_h2c(rtwdev);
+
 	rtw89_leave_ps_mode(rtwdev);
 
 	switch (chip->chip_gen) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7150892a6274..4e51ffb5be21 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -827,6 +827,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 37, 1, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 41, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 127, 0, SER_L1_BY_EVENT),
+	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 130, 0, SIM_SER_L0L1_BY_HALT_H2C),
 	__CFG_FW_FEAT(RTL8852A, le, 0, 13, 29, 0, OLD_HT_RA_FORMAT),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
@@ -845,6 +846,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 128, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 128, 0, SCAN_OFFLOAD_EXTRA_OP),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 128, 0, BEACON_TRACKING),
+	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 130, 0, SIM_SER_L0L1_BY_HALT_H2C),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER_TYPE_0),
@@ -855,6 +857,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, SER_L1_BY_EVENT),
+	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 130, 0, SIM_SER_L0L1_BY_HALT_H2C),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 0, 0, 0, RFK_NTFY_MCC_V0),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
@@ -867,6 +870,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 129, 1, BEACON_TRACKING),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 29, 94, 0, SER_L1_BY_EVENT),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 29, 130, 0, SIM_SER_L0L1_BY_HALT_H2C),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9941d500bc68..9d0c491f053f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -914,6 +914,9 @@ enum mac_ax_err_info {
 	MAC_AX_ERR_L0_CFG_DIS_NOTIFY = 0x0011,
 	MAC_AX_ERR_L0_CFG_HANDSHAKE = 0x0012,
 	MAC_AX_ERR_L0_RCVY_EN = 0x0013,
+	MAC_AX_ERR_L0_RESET_FORCE = 0x0020,
+	MAC_AX_ERR_L0_RESET_FORCE_C1 = 0x0021,
+	MAC_AX_ERR_L1_RESET_FORCE = 0x0022,
 	MAC_AX_SET_ERR_MAX,
 };
 
-- 
2.25.1


