Return-Path: <linux-wireless+bounces-36197-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CQmGJ1/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36197-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:05:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32A508D76
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B019300B8E9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96130C62E;
	Mon, 11 May 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Wy51FN1j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874E19E839
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482923; cv=none; b=T5AsJIfq/2vDfExoYC36b3PVPc9aw+AJATpTLSBv5bHJQoYo2FhUXbHhE/YAxJYNmZFcrGS4yUgcraA0YCMcvQ0JsuLDTdfACcVQeAUB72+uJ2vey4DuDKd8FcGS9T4DpjwZzKB5bI57du8lm4Az9ZJ2FL4aPV8vVZCeEZZUFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482923; c=relaxed/simple;
	bh=smPXE8ORnjpz4oxNqf6YNmJbth/5s5BpTsvo/Z0P5qo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MX+v+FDBKzJNAMgYZyelp4xoFTYxLYPE6FYiU5uAeS2uLH641GljCWBzfT8KTgp7mWLSiVfgIb3mOIl0HZOWyBEPzZv2KKtKQiMraakMj0uSJzGgjX6U1sUB/TwVErAAjAZP/gyMCSML2hGrBqTrS04mwx44+LYzDkzs2w73lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Wy51FN1j; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B71wDQ22540395, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482918; bh=X/T/xPD6NYGD3iEFOfYwjUP3ChO5URZWbDZ+X4HTmg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Wy51FN1jIQPJjYejP7fr1Do0GutUlhJ5JGx9rztJ+NXkJ2XmR46jypiYfpx+OLuxg
	 wwR9kT/PayjVRJsA33X+MHf4E8zpftUyjvpREpGZ7O7AZ/V/v4+kT9N7D1yhu6JzKW
	 4OGbICxXzfAYusA1S+RUkINNYC0nY/QqHw6rh69+Ybk3kkQmbd5/lIcoYuYUJjpGFY
	 vIlAvj+It3tAX9NCkB8SDYL6iSFAED8jLUgYcZZD1gNACQejtSpmA/KQMe7b/e0ggW
	 Gc9p/m04VEiadtIWOLdMeVhjGsDadCmfdewz98Bh2pfjSkg/iueqqTk3knXA8mAtq8
	 muaNIPGK6UF3A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B71wDQ22540395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:01:58 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:01:58 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:01:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 01/11] wifi: rtw89: phy: define BB wrap data for RTL8922D variants
Date: Mon, 11 May 2026 15:01:38 +0800
Message-ID: <20260511070148.25257-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511070148.25257-1-pkshih@realtek.com>
References: <20260511070148.25257-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 5A32A508D76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36197-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The BB wrap is a hardware block to control TX power. Since RTL8922D has
many variants with different CID and RFE types, prepare flow and dummy
struct adopt to configuration functions for coming patches.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  4 ++
 drivers/net/wireless/realtek/rtw89/core.h     | 13 +++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  3 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 38 +++++++++++++++++++
 10 files changed, 64 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b85728ceb63c..dafe71aa4876 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6778,6 +6778,10 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 	if (ret)
 		goto out;
 
+	ret = rtw89_chip_data_setup(rtwdev);
+	if (ret)
+		goto out;
+
 	rtw89_core_setup_rfe_parms(rtwdev);
 	rtwdev->ps_mode = rtw89_update_ps_mode(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bccfee7535a7..ab9165fcaf7d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -27,6 +27,7 @@ struct rtw89_phy_calc_efuse_gain;
 struct rtw89_debugfs;
 struct rtw89_regd_data;
 struct rtw89_wow_cam_info;
+struct rtw89_bb_wrap_data;
 struct rtw89_fw_cmd_ofld_info;
 
 extern const struct ieee80211_ops rtw89_ops;
@@ -3828,6 +3829,7 @@ struct rtw89_chip_ops {
 			  enum rtw89_efuse_block block);
 	int (*read_phycap)(struct rtw89_dev *rtwdev, u8 *phycap_map);
 	void (*fem_setup)(struct rtw89_dev *rtwdev);
+	int (*data_setup)(struct rtw89_dev *rtwdev);
 	void (*rfe_gpio)(struct rtw89_dev *rtwdev);
 	void (*rfk_hw_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_init)(struct rtw89_dev *rtwdev);
@@ -4574,6 +4576,7 @@ struct rtw89_bb_stat_cfg {
 };
 
 struct rtw89_phy_info {
+	const struct rtw89_bb_wrap_data *bb_wrap_data;
 	struct rtw89_bb_stat_cfg bb_stat_cfg;
 };
 
@@ -7461,6 +7464,16 @@ static inline void rtw89_chip_fem_setup(struct rtw89_dev *rtwdev)
 		chip->ops->fem_setup(rtwdev);
 }
 
+static inline int rtw89_chip_data_setup(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!chip->ops->data_setup)
+		return 0;
+
+	return chip->ops->data_setup(rtwdev);
+}
+
 static inline void rtw89_chip_rfe_gpio(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index a6e685654037..e4933bd522b2 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -569,6 +569,9 @@ struct rtw89_phy_rfk_log_fmt {
 	const struct rtw89_fw_element_hdr *elm[RTW89_PHY_C2H_RFK_LOG_FUNC_NUM];
 };
 
+struct rtw89_bb_wrap_data {
+};
+
 struct rtw89_phy_gen_def {
 	u32 cr_base;
 	u32 physt_bmp_start;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e047e716d9e3..2fb54e1fc7ab 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2556,6 +2556,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.read_efuse		= rtw8851b_read_efuse,
 	.read_phycap		= rtw8851b_read_phycap,
 	.fem_setup		= NULL,
+	.data_setup		= NULL,
 	.rfe_gpio		= rtw8851b_rfe_gpio,
 	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8851b_rfk_init,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 686e489d42f2..d3b6e8a7f5bd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2302,6 +2302,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.read_efuse		= rtw8852a_read_efuse,
 	.read_phycap		= rtw8852a_read_phycap,
 	.fem_setup		= rtw8852a_fem_setup,
+	.data_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8852a_rfk_init,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 6ab99f72fda7..989ac38fe359 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -883,6 +883,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.read_efuse		= rtw8852bx_read_efuse,
 	.read_phycap		= rtw8852bx_read_phycap,
 	.fem_setup		= NULL,
+	.data_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8852b_rfk_init,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 83de26273100..b58561e141cb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -729,6 +729,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.read_efuse		= rtw8852bx_read_efuse,
 	.read_phycap		= rtw8852bx_read_phycap,
 	.fem_setup		= NULL,
+	.data_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8852bt_rfk_init,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cc278587b532..9ecd140dcdd5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3091,6 +3091,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
 	.fem_setup		= NULL,
+	.data_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8852c_rfk_init,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index e6f15ee2a86b..07270e83b778 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3086,6 +3086,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_efuse		= rtw8922a_read_efuse,
 	.read_phycap		= rtw8922a_read_phycap,
 	.fem_setup		= NULL,
+	.data_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_hw_init		= rtw8922a_rfk_hw_init,
 	.rfk_init		= rtw8922a_rfk_init,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index b8b75fca0a1b..66b05aedcf11 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -286,6 +286,15 @@ static const struct rtw89_efuse_block_cfg rtw8922d_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
 };
 
+static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7025_default = {
+};
+
+static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_default = {
+};
+
+static const struct rtw89_bb_wrap_data rtw8922d_bb_wrap_data_7090_rfe35_41_44 = {
+};
+
 static void rtw8922d_sel_bt_rx_path(struct rtw89_dev *rtwdev, u8 val,
 				    enum rtw89_rf_path rx_path)
 {
@@ -918,6 +927,34 @@ static void rtw8922d_power_trim(struct rtw89_dev *rtwdev)
 	rtw8922d_pad_bias_trim(rtwdev);
 }
 
+static int rtw8922d_data_setup(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_bb_wrap_data *data;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool rfe35_41_44 = false;
+
+	switch (rtwdev->efuse.rfe_type) {
+	case 35:
+	case 41:
+	case 44:
+		rfe35_41_44 = true;
+		break;
+	}
+
+	if (hal->cid == RTL8922D_CID7025) {
+		data = &rtw8922d_bb_wrap_data_7025_default;
+	} else {
+		if (rfe35_41_44)
+			data = &rtw8922d_bb_wrap_data_7090_rfe35_41_44;
+		else
+			data = &rtw8922d_bb_wrap_data_7090_default;
+	}
+
+	rtwdev->phy_info.bb_wrap_data = data;
+
+	return 0;
+}
+
 static void rtw8922d_set_channel_mac(struct rtw89_dev *rtwdev,
 				     const struct rtw89_chan *chan,
 				     u8 mac_idx)
@@ -2933,6 +2970,7 @@ static const struct rtw89_chip_ops rtw8922d_chip_ops = {
 	.read_efuse		= rtw8922d_read_efuse,
 	.read_phycap		= rtw8922d_read_phycap,
 	.fem_setup		= NULL,
+	.data_setup		= rtw8922d_data_setup,
 	.rfe_gpio		= NULL,
 	.rfk_hw_init		= rtw8922d_rfk_hw_init,
 	.rfk_init		= rtw8922d_rfk_init,
-- 
2.25.1


