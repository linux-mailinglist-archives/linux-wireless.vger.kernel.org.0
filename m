Return-Path: <linux-wireless+bounces-29886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FA2CCA7BB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2CA3308BDB0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92966163;
	Thu, 18 Dec 2025 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TZwmOxT2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F023EA92
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039531; cv=none; b=aX6RUUrsW91abf5l0uuyp2KtTkBJ+rlHNMthZV9B+/dHkt+2jHDIUGMA3QQhwbw8uONtuA19LL0+2CZ/QpLEKi57BgYUpdtUNDCXrO3toaWs5Ucs4VQDSKQPlAsDxuHYKeAb9sXUjlS3+jfYeXNVLmGQeLgZmeR9PuX25Psu6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039531; c=relaxed/simple;
	bh=anclUerP+D6k4wLYmHC3B3q+GbriuU5Jj7mN/TTIHl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlebNJKi5d6eTLxvSSy2lG1hIDxEFZg7viyd6UehOFqhSAQ1sIyVP5BKAi7yur6GHd0NWoW+uHN5HEBPaY/hVaYzRsn1+qyK5dF1nLuYW+nd7YKc3p7Gr2Ho3YwelzTEO06N2VPn8nZn3MObaRcjg7EmyL92VPObM7bRQW6ngY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TZwmOxT2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6W4K603326245, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039524; bh=fkdWnc9/Pb0Kk6kguf9sH8pTW4t7gyFTpz3d/8gIpKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TZwmOxT2gLtYjFOIdi6TqtVCWBj2xz2U6VjxtCKdYOE4fAtMiMGUWI/X/7fviuHBb
	 ho4KEK7xw4N3RZF9Utb71owDA5Q+XqPGPI4Wk0HV5T1fVw6SVvCeAXQKH8uWXM5EhV
	 Tx/mM5xv9LseoP8ggBcltWYQADfyCUvPGPoQXfA5SlwyqP141CRdtvSTuLzng+ujwM
	 q9tX8tYdc0d9Xg4IYOcjQ2/p6QZ8vZSsjWzFFaAdhuIITxzsP9CMyj4hr1ebKC5pYi
	 ZYAoq47zgRuQYNu3W+fGaBgtrpMfVt9gf6q5nAweoeRQQfzWNXnQ3qmtMG7CdGixVL
	 7ErtBD66zIOcA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6W4K603326245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:32:04 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:32:04 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:32:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 05/12] wifi: rtw89: ser: enable error IMR after recovering from L1
Date: Thu, 18 Dec 2025 14:31:10 +0800
Message-ID: <20251218063117.26278-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218063117.26278-1-pkshih@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
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
index f08b0f25f44c..e0c4503c4ec2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7268,6 +7268,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
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


