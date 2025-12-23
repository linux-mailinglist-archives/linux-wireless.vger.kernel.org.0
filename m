Return-Path: <linux-wireless+bounces-30062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D6CD7F07
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E933030FD8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CCB2C1590;
	Tue, 23 Dec 2025 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="U4TSrere"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444132BCF4A
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459255; cv=none; b=LutSBbE5OyfDKuBQjbsxMibz3KFAfk0hn0/9yYJ0S5rqR/d8uw16MfvyiIs+nDRAiaIbwK7lY/LBPtabwfrb5XxLkTHviLeY5csSjUuzjXya5GNjHcXfAJIkYImqJKcCcis9Z0oT2rTGCwFPy0bkRddvkxVSLINTj+lYyH2oZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459255; c=relaxed/simple;
	bh=F+xTsO3635/LGTVIUcshYXO3CM+eJQdSBgKRnq0SGUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fa3MLzIt5lciO2/00tDxXkklM7U5nZdI+3f7JVfQmwsI8U04FJ/tum5P5jo304UyZDgoASPuWno2GsXf8LoZ098YFyY6snst5ua99i/0ndU+AboYr8qb3zi3Lclr7BzxgOnFPXmAklGkM9d2CujXnIEVc1lFPLQcjFVZImXMs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=U4TSrere; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN37VRD0571203, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766459251; bh=nlCBGkpj3i4NFeW5FLaiIEIbpwqmCPWyCJamLz+/QJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=U4TSrereH96vSBgVmtXiGXBYvl58ErBshqYSf/0+4A+h5Ftl7fkWLh7G0nK9im1q8
	 iaVtuu16vfVgKd8yhDPHVtuwkoTbDIS925MK5/u+A2QWCARgyuvVFagtLmA6f18gW0
	 2VD31/IkN+YtlVfLGaAjOGZfz3La7Kw7auGslogg6q+qadCzULmFiLxJpHb0tjBWNt
	 NyRh898VF2m+zxgM0UNLhhLr5qPpAKR5DjcllwebVB5WK3+3hokz6wKpuphaRncLCX
	 t1efFu3uVQLpkKJR58x2YNAuRevxxmzyeJ86aUO0GThltfjVMCEFfoAHRcriu5QtNO
	 3OmWDHNLtQOXA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN37VRD0571203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 11:07:31 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:31 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:30 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:07:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v3 05/12] wifi: rtw89: ser: enable error IMR after recovering from L1
Date: Tue, 23 Dec 2025 11:06:44 +0800
Message-ID: <20251223030651.480633-6-pkshih@realtek.com>
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

After recovering from L1, explicitly enable error IMR to ensure next
L1 SER (system error recovery) can work normally.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  1 +
 drivers/net/wireless/realtek/rtw89/mac.h    |  1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c    | 10 ++++++++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0cea01e322c6..acd95d55ae27 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7204,6 +7204,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.check_mac_en = rtw89_mac_check_mac_en_ax,
 	.sys_init = sys_init_ax,
 	.trx_init = trx_init_ax,
+	.err_imr_ctrl = err_imr_ctrl_ax,
 	.hci_func_en = rtw89_mac_hci_func_en_ax,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_ax,
 	.dle_func_en = dle_func_en_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9ec70729e9e1..9941d500bc68 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1019,6 +1019,7 @@ struct rtw89_mac_gen_def {
 			    enum rtw89_mac_hwmod_sel sel);
 	int (*sys_init)(struct rtw89_dev *rtwdev);
 	int (*trx_init)(struct rtw89_dev *rtwdev);
+	void (*err_imr_ctrl)(struct rtw89_dev *rtwdev, bool en);
 	void (*hci_func_en)(struct rtw89_dev *rtwdev);
 	void (*dmac_func_pre_en)(struct rtw89_dev *rtwdev);
 	void (*dle_func_en)(struct rtw89_dev *rtwdev, bool enable);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 65c0c0de3a30..2bc329c13443 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2730,6 +2730,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.check_mac_en = rtw89_mac_check_mac_en_be,
 	.sys_init = sys_init_be,
 	.trx_init = trx_init_be,
+	.err_imr_ctrl = err_imr_ctrl_be,
 	.hci_func_en = rtw89_mac_hci_func_en_be,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_be,
 	.dle_func_en = dle_func_en_be,
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index f99e179f7ff9..7fdc69578da3 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -431,6 +431,14 @@ static void hal_send_m4_event(struct rtw89_ser *ser)
 	rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_RCVY_EN);
 }
 
+static void hal_enable_err_imr(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	mac->err_imr_ctrl(rtwdev, true);
+}
+
 /* state handler */
 static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 {
@@ -552,6 +560,8 @@ static void ser_do_hci_st_hdl(struct rtw89_ser *ser, u8 evt)
 		break;
 
 	case SER_EV_MAC_RESET_DONE:
+		hal_enable_err_imr(ser);
+
 		ser_state_goto(ser, SER_IDLE_ST);
 		break;
 
-- 
2.25.1


