Return-Path: <linux-wireless+bounces-38909-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zA1pGFkOU2qPWQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38909-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:47:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD7743B95
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:47:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=HXLwucxN;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38909-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38909-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46540301B712
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4305846A;
	Sun, 12 Jul 2026 03:46:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B82AD37
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:46:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783828010; cv=none; b=QP9Y7EcRKQAWymF5pguQ0ZmiR0fqL8QNCbfIKLXAsT97I28T9j4MbP06Ip7nXdWfgdSpCq2d2mj+PWybopWbV2Ea6ZxvekKoDWAnLt+8fDEua67bWDkHQG/wT8U3wBdYhTNS5x2x78AyOp9xVp4Y1yDF4JTcgzFFt2WFDf6Ch34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783828010; c=relaxed/simple;
	bh=+7t+PJcZ2h+uarEoydJ+bYpfwnrHi/B4fLGqTFHVGus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atN/Z4hO4qjIabjfURmIdxQnJnyxSVLXlJf20oUSW4YlyZzjlgFs9H2AWNOPKo5zux0slf/TmeNpS2hGKVcY2bCk6VoOFRXohaIIbxwBwrwpEk123Ws0XkfuF983/GylmuSuGHfVLgJRJpWnDsJDIuAiKjOmDCz7MoPdC+gjYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HXLwucxN; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C3kkO93535715, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783828006; bh=GyKVZDlsZ7Y7ba6duIsTuiIOPz0bha7i3ZBdnuaYO7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HXLwucxNRN4ujQOv8h6yybSARV3K5eM8LSguBACKN6/sxyyqn0pIuWUGBnwPFQS8s
	 IYg+f83lXAa3ixWxN0rDkDXNYPpiZtK74rFiUIJfKtEUxQWgk2mrrHxlTPbmnRaisl
	 HPLjLmnlXqiB6L8SVX6szKYkRKy5bNehcMDAkOOPZL01i2avnbQ3F2Gj38Bmp4uYgr
	 A0m5zUI3IaneHxpqXXnbbqf7yNrhGNNoGe5mSWUzvx9V+hgpHWMezR5zxmFD4k7OTW
	 2GHuftFV6lRxlzSXTUIeG0W9woakL6Qs33VXCTUjjWRaFRJ6r1/o6Eo47DQK4kqON9
	 u+fKRS0bIKrbg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C3kkO93535715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:46:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:46:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:46:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 8/8] wifi: rtw89: debug: add diagnosis for RF
Date: Sun, 12 Jul 2026 11:45:06 +0800
Message-ID: <20260712034506.53209-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712034506.53209-1-pkshih@realtek.com>
References: <20260712034506.53209-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38909-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:echuang@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23CD7743B95

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add debugfs diag_rf and show RFK (RF calibration) diagnosis things for
now. Record channel related info before triggering RFK, and then record
state of each kind of RFK from C2H event report. Besides, in track work,
monitor TSSI status too. Both support history up to 10, and show records
via debugfs.

The following is an example of output.

RFK (next index: 2)
  PHY-X    =    0     0     0     0     0     0     0     0     0     0
  S0-CH    = 0012a 0012a 00000 00000 00000 00000 00000 00000 00000 00000
  S0-CV    = 0032c 0032c 00000 00000 00000 00000 00000 00000 00000 00000
  S0-C5    = 10000 10000 00000 00000 00000 00000 00000 00000 00000 00000
  S1-CH    = 0012a 0012a 00000 00000 00000 00000 00000 00000 00000 00000
  S1-CV    = 0032d 0032d 00000 00000 00000 00000 00000 00000 00000 00000
  S1-C5    = 00000 00000 00000 00000 00000 00000 00000 00000 00000 00000
  PRE_NTFY =    0     0     0     0     0     0     0     0     0     0
  TSSI     =    1     1     0     0     0     0     0     0     0     0
  IQK      =    1     1     0     0     0     0     0     0     0     0
  DPK      =    1     1     0     0     0     0     0     0     0     0
  TXGAPK   =    1     1     0     0     0     0     0     0     0     0
  DACK     =    0     0     0     0     0     0     0     0     0     0
  RX_DCK   =    1     1     0     0     0     0     0     0     0     0
  TX_IQK   =    1     1     0     0     0     0     0     0     0     0
  CIM3k    =    1     1     0     0     0     0     0     0     0     0
TSSI-track (next index: 6)
  S0       =   00e   00e   00c   00d   00d   00e   00d   00d   00d   00e
  S1       =   00a   00b   009   00a   00a   00a   009   009   009   00a

Debugfs diag_rf can also be used to manually trigger RFK when written by 1.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |  71 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h  |  32 ++++++
 drivers/net/wireless/realtek/rtw89/debug.c | 115 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c   |  62 +++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h   |   3 +
 drivers/net/wireless/realtek/rtw89/reg.h   |   1 +
 6 files changed, 272 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3950792651c1..5c58ce311c1b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -486,6 +486,37 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	__rtw89_core_set_chip_txpwr(rtwdev, conf.chans[1], RTW89_PHY_1);
 }
 
+static void rtw89_core_rfk_record(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif_link *rtwvif_link,
+				  bool start)
+{
+	struct rtw89_rfk_wait_info *info = &rtwdev->rfk_wait;
+	struct rtw89_rfk_record *record = &info->records[info->record_idx];
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 path_num = min(chip->rf_path_num, RTW89_RFK_RECORD_PATH_NR);
+	int path;
+
+	if (!start)
+		goto end;
+
+	info->record_ptr = record;
+	record->phy_idx = rtwvif_link->phy_idx;
+
+	for (path = 0; path < path_num; path++) {
+		record->ch[path] = rtw89_read_rf(rtwdev, path, RR_CFGCH,
+						 RR_CFGCH_BAND0 | RR_CFGCH_CH);
+		record->cv[path] = rtw89_read_rf(rtwdev, path, RR_VCO,
+						 RR_VCO_SEL | RR_VCO_STS);
+		record->c5[path] = rtw89_read_rf(rtwdev, path, RR_SYNFB, RFREG_MASK);
+	}
+
+	return;
+
+end:
+	info->record_idx = (info->record_idx + 1) % RTW89_RFK_RECORD_HISTORY_NR;
+	info->record_ptr = NULL;
+}
+
 void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
 			    struct rtw89_vif_link *rtwvif_link)
 {
@@ -503,9 +534,14 @@ void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
 		rtw89_set_channel(rtwdev);
 	}
 
-	if (chip->ops->rfk_channel)
+	if (chip->ops->rfk_channel) {
+		rtw89_core_rfk_record(rtwdev, rtwvif_link, true);
+
 		chip->ops->rfk_channel(rtwdev, rtwvif_link);
 
+		rtw89_core_rfk_record(rtwdev, rtwvif_link, false);
+	}
+
 	if (prehdl_link) {
 		rtw89_entity_force_hw(rtwdev, RTW89_PHY_NUM);
 		rtw89_set_channel(rtwdev);
@@ -5274,6 +5310,37 @@ static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_core_rfk_tssi_record(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 path_num = min(chip->rf_path_num, RTW89_RFK_RECORD_PATH_NR);
+	struct rtw89_rfk_wait_info *info = &rtwdev->rfk_wait;
+	int i = info->record_tssi_idx;
+	u32 base;
+	u32 mask;
+	int path;
+
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		return;
+
+	info->record_tssi_idx = (info->record_tssi_idx + 1) %
+				RTW89_RFK_RECORD_HISTORY_NR;
+
+	if (chip->chip_id == RTL8922A) {
+		base = 0x2ee10;
+		mask = 0x7fc00;
+	} else {
+		base = 0x2f918;
+		mask = 0x000001ff;
+	}
+
+	for (path = 0; path < path_num; path++) {
+		u32 addr = base + 0x100 * path;
+
+		info->tssi_code[i][path] = rtw89_read32_mask(rtwdev, addr, mask);
+	}
+}
+
 static void rtw89_core_rfk_track(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_entity_mode mode;
@@ -5283,6 +5350,8 @@ static void rtw89_core_rfk_track(struct rtw89_dev *rtwdev)
 		return;
 
 	rtw89_chip_rfk_track(rtwdev);
+
+	rtw89_core_rfk_tssi_record(rtwdev);
 }
 
 void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4ba6452a7123..6fec9ce59f7a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5728,11 +5728,43 @@ enum rtw89_rfk_report_state {
 	RTW89_RFK_STATE_H2C_CMD_ERR = 0x4,
 };
 
+enum rtw89_rfk_report_types {
+	RTW89_RFK_REPORT_PRE_NTFY,
+	RTW89_RFK_REPORT_TSSI,
+	RTW89_RFK_REPORT_IQK,
+	RTW89_RFK_REPORT_DPK,
+	RTW89_RFK_REPORT_TXGAPK,
+	RTW89_RFK_REPORT_DACK,
+	RTW89_RFK_REPORT_RX_DCK,
+	RTW89_RFK_REPORT_TX_IQK,
+	RTW89_RFK_REPORT_CIM3k,
+
+	NUM_OF_RTW89_RFK_REPORT_TYPES,
+};
+
+#define RTW89_RFK_RECORD_PATH_NR 2
+#define RTW89_RFK_RECORD_HISTORY_NR 10
+
+struct rtw89_rfk_record {
+	u32 ch[RTW89_RFK_RECORD_PATH_NR];
+	u32 cv[RTW89_RFK_RECORD_PATH_NR];
+	u32 c5[RTW89_RFK_RECORD_PATH_NR];
+	enum rtw89_phy_idx phy_idx;
+	enum rtw89_rfk_report_state states[NUM_OF_RTW89_RFK_REPORT_TYPES];
+};
+
 struct rtw89_rfk_wait_info {
 	struct completion completion;
 	ktime_t start_time;
 	enum rtw89_rfk_report_state state;
 	u8 version;
+
+	int record_idx;
+	struct rtw89_rfk_record *record_ptr;
+	struct rtw89_rfk_record records[RTW89_RFK_RECORD_HISTORY_NR];
+
+	int record_tssi_idx;
+	u32 tssi_code[RTW89_RFK_RECORD_HISTORY_NR][RTW89_RFK_RECORD_PATH_NR];
 };
 
 #define RTW89_DACK_PATH_NR 2
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index e42dc5707576..ccfd69271f90 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -93,6 +93,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv beacon_info;
 	struct rtw89_debugfs_priv diag_mac;
 	struct rtw89_debugfs_priv diag_bb;
+	struct rtw89_debugfs_priv diag_rf;
 	struct rtw89_debugfs_priv monitor_opts;
 };
 
@@ -5397,6 +5398,118 @@ rtw89_debug_priv_diag_bb_get(struct rtw89_dev *rtwdev,
 	return p - buf;
 }
 
+static ssize_t
+rtw89_debug_priv_diag_rf_get(struct rtw89_dev *rtwdev,
+			     struct rtw89_debugfs_priv *debugfs_priv,
+			     char *buf, size_t bufsz)
+{
+	struct rtw89_rfk_wait_info *info = &rtwdev->rfk_wait;
+	char *p = buf, *end = buf + bufsz;
+	int i, j;
+
+	p += scnprintf(p, end - p, "RFK (next index: %d)\n", info->record_idx);
+
+	p += scnprintf(p, end - p, "  PHY-X    =");
+	for (i = 0; i < RTW89_RFK_RECORD_HISTORY_NR; i++) {
+		struct rtw89_rfk_record *record = &info->records[i];
+
+		p += scnprintf(p, end - p, " %4d ", record->phy_idx);
+	}
+	p += scnprintf(p, end - p, "\n");
+
+	for (j = 0; j < RTW89_RFK_RECORD_PATH_NR; j++) {
+		p += scnprintf(p, end - p, "  S%d-CH    =", j);
+		for (i = 0; i < RTW89_RFK_RECORD_HISTORY_NR; i++) {
+			struct rtw89_rfk_record *record = &info->records[i];
+
+			p += scnprintf(p, end - p, " %05x", record->ch[j]);
+		}
+		p += scnprintf(p, end - p, "\n");
+
+		p += scnprintf(p, end - p, "  S%d-CV    =", j);
+		for (i = 0; i < RTW89_RFK_RECORD_HISTORY_NR; i++) {
+			struct rtw89_rfk_record *record = &info->records[i];
+
+			p += scnprintf(p, end - p, " %05x", record->cv[j]);
+		}
+		p += scnprintf(p, end - p, "\n");
+
+		p += scnprintf(p, end - p, "  S%d-C5    =", j);
+		for (i = 0; i < RTW89_RFK_RECORD_HISTORY_NR; i++) {
+			struct rtw89_rfk_record *record = &info->records[i];
+
+			p += scnprintf(p, end - p, " %05x", record->c5[j]);
+		}
+		p += scnprintf(p, end - p, "\n");
+	}
+
+	for (j = 0; j < NUM_OF_RTW89_RFK_REPORT_TYPES; j++) {
+		p += scnprintf(p, end - p, "  %-8s =", rtw89_rfk_report_names[j]);
+		for (i = 0; i < RTW89_RFK_RECORD_HISTORY_NR; i++) {
+			struct rtw89_rfk_record *record = &info->records[i];
+
+			p += scnprintf(p, end - p, " %4d ", record->states[j]);
+		}
+		p += scnprintf(p, end - p, "\n");
+	}
+
+	p += scnprintf(p, end - p, "TSSI-track (next index: %d)\n", info->record_tssi_idx);
+
+	for (j = 0; j < RTW89_RFK_RECORD_PATH_NR; j++) {
+		p += scnprintf(p, end - p, "  S%d       =", j);
+		for (i = 0; i < RTW89_RFK_RECORD_HISTORY_NR; i++)
+			p += scnprintf(p, end - p, "   %03x", info->tssi_code[i][j]);
+		p += scnprintf(p, end - p, "\n");
+	}
+
+	return p - buf;
+}
+
+static void rtw89_dbg_diag_rf_set_rfk(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
+
+	list_for_each_entry(rtwvif, &mgnt->active_list, mgnt_entry)
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
+			rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
+}
+
+enum rtw89_dbg_diag_rf_type {
+	RTW89_DBG_DIAG_RF_RSVD = 0,
+	RTW89_DBG_DIAG_RF_RFK = 1,
+};
+
+static ssize_t
+rtw89_debug_priv_diag_rf_set(struct rtw89_dev *rtwdev,
+			     struct rtw89_debugfs_priv *debugfs_priv,
+			     const char *buf, size_t count)
+{
+	u8 type;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &type);
+	if (ret)
+		return -EINVAL;
+
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	switch (type) {
+	case RTW89_DBG_DIAG_RF_RFK:
+		rtw89_dbg_diag_rf_set_rfk(rtwdev);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return count;
+}
+
 static ssize_t
 rtw89_debug_priv_monitor_opts_get(struct rtw89_dev *rtwdev,
 				  struct rtw89_debugfs_priv *debugfs_priv,
@@ -5509,6 +5622,7 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.beacon_info = rtw89_debug_priv_get(beacon_info),
 	.diag_mac = rtw89_debug_priv_get(diag_mac, RSIZE_16K, RLOCK),
 	.diag_bb = rtw89_debug_priv_get(diag_bb, RSIZE_8K, RLOCK),
+	.diag_rf = rtw89_debug_priv_set_and_get(diag_rf, RWLOCK),
 	.monitor_opts = rtw89_debug_priv_set_and_get(monitor_opts, RWLOCK),
 };
 
@@ -5566,6 +5680,7 @@ void rtw89_debugfs_add_sec2(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_r(beacon_info);
 	rtw89_debugfs_add_r(diag_mac);
 	rtw89_debugfs_add_r(diag_bb);
+	rtw89_debugfs_add_rw(diag_rf);
 	rtw89_debugfs_add_rw(monitor_opts);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 30d5741da87e..c78107e92206 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3968,6 +3968,23 @@ void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_CIM3K] = rtw89_phy_c2h_rfk_log_cim3k,
 };
 
+#define NAME_RTW89_RFK_REPORT(type) \
+	[RTW89_RFK_REPORT_ ## type] = #type
+
+const char * const rtw89_rfk_report_names[] = {
+	NAME_RTW89_RFK_REPORT(PRE_NTFY),
+	NAME_RTW89_RFK_REPORT(TSSI),
+	NAME_RTW89_RFK_REPORT(IQK),
+	NAME_RTW89_RFK_REPORT(DPK),
+	NAME_RTW89_RFK_REPORT(TXGAPK),
+	NAME_RTW89_RFK_REPORT(DACK),
+	NAME_RTW89_RFK_REPORT(RX_DCK),
+	NAME_RTW89_RFK_REPORT(TX_IQK),
+	NAME_RTW89_RFK_REPORT(CIM3k),
+};
+
+static_assert(ARRAY_SIZE(rtw89_rfk_report_names) == NUM_OF_RTW89_RFK_REPORT_TYPES);
+
 static
 void rtw89_phy_rfk_report_prep(struct rtw89_dev *rtwdev)
 {
@@ -3979,8 +3996,8 @@ void rtw89_phy_rfk_report_prep(struct rtw89_dev *rtwdev)
 }
 
 static
-int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
-			      unsigned int ms)
+int ____rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
+				  unsigned int ms)
 {
 	struct rtw89_rfk_wait_info *wait = &rtwdev->rfk_wait;
 	unsigned long time_left;
@@ -4017,6 +4034,29 @@ int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
 	return 0;
 }
 
+static
+int __rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev,
+				enum rtw89_rfk_report_types rfk_type,
+				enum rtw89_phy_idx phy_idx,
+				const struct rtw89_chan *chan,
+				unsigned int ms)
+{
+	const char *rfk_name = rtw89_rfk_report_names[rfk_type];
+	struct rtw89_rfk_wait_info *wait = &rtwdev->rfk_wait;
+	struct rtw89_rfk_record *record = wait->record_ptr;
+	int ret;
+
+	ret = ____rtw89_phy_rfk_report_wait(rtwdev, rfk_name, ms);
+
+	if (record)
+		record->states[rfk_type] = wait->state;
+
+	return ret;
+}
+
+#define rtw89_phy_rfk_report_wait(rtwdev, type, phy_idx, chan, ms) \
+	__rtw89_phy_rfk_report_wait(rtwdev, RTW89_RFK_REPORT_ ## type, phy_idx, chan, ms)
+
 static void
 rtw89_phy_c2h_rfk_report_state(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
@@ -4122,7 +4162,7 @@ int rtw89_phy_rfk_pre_ntfy_and_wait(struct rtw89_dev *rtwdev,
 	if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw)) {
 		rtw89_phy_rfk_report_prep(rtwdev);
 		rtw89_fw_h2c_rf_pre_ntfy(rtwdev, phy_idx);
-		ret = rtw89_phy_rfk_report_wait(rtwdev, "PRE_NTFY", ms);
+		ret = rtw89_phy_rfk_report_wait(rtwdev, PRE_NTFY, phy_idx, NULL, ms);
 		if (ret)
 			return ret;
 	}
@@ -4152,7 +4192,7 @@ int rtw89_phy_rfk_tssi_and_wait(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "TSSI", ms);
+	return rtw89_phy_rfk_report_wait(rtwdev, TSSI, phy_idx, chan, ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_tssi_and_wait);
 
@@ -4169,7 +4209,7 @@ int rtw89_phy_rfk_iqk_and_wait(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "IQK", ms);
+	return rtw89_phy_rfk_report_wait(rtwdev, IQK, phy_idx, chan, ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_iqk_and_wait);
 
@@ -4186,7 +4226,7 @@ int rtw89_phy_rfk_dpk_and_wait(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "DPK", ms);
+	return rtw89_phy_rfk_report_wait(rtwdev, DPK, phy_idx, chan, ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_dpk_and_wait);
 
@@ -4203,7 +4243,7 @@ int rtw89_phy_rfk_txgapk_and_wait(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "TXGAPK", ms);
+	return rtw89_phy_rfk_report_wait(rtwdev, TXGAPK, phy_idx, chan, ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_txgapk_and_wait);
 
@@ -4220,7 +4260,7 @@ int rtw89_phy_rfk_dack_and_wait(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "DACK", ms);
+	return rtw89_phy_rfk_report_wait(rtwdev, DACK, phy_idx, chan, ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_dack_and_wait);
 
@@ -4237,7 +4277,7 @@ int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "RX_DCK", ms);
+	return rtw89_phy_rfk_report_wait(rtwdev, RX_DCK, phy_idx, chan, ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_rxdck_and_wait);
 
@@ -4254,7 +4294,7 @@ int rtw89_phy_rfk_txiqk_and_wait(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "TX_IQK", ms);
+	return rtw89_phy_rfk_report_wait(rtwdev, TX_IQK, phy_idx, chan, ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_txiqk_and_wait);
 
@@ -4271,7 +4311,7 @@ int rtw89_phy_rfk_cim3k_and_wait(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "CIM3k", ms);
+	return rtw89_phy_rfk_report_wait(rtwdev, CIM3k, phy_idx, chan, ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_cim3k_and_wait);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index b0c82bac72f0..0963cdfb1594 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -1150,6 +1150,9 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func);
 void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
+
+extern const char * const rtw89_rfk_report_names[];
+
 int rtw89_phy_rfk_pre_ntfy_and_wait(struct rtw89_dev *rtwdev,
 				    enum rtw89_phy_idx phy_idx,
 				    unsigned int ms);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 4d2117de798b..3bf2865b81ab 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8763,6 +8763,7 @@
 #define RR_VCO 0xb2
 #define RR_VCO_VAL GENMASK(18, 14)
 #define RR_VCO_SEL GENMASK(9, 8)
+#define RR_VCO_STS GENMASK(7, 0)
 #define RR_VCI 0xb3
 #define RR_VCI_ON BIT(7)
 #define RR_LPF 0xb7
-- 
2.25.1


