Return-Path: <linux-wireless+bounces-31804-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBJoLAzCjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31804-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BE133397
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49795301D302
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518492517A5;
	Fri, 13 Feb 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LSjrPa2P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F91DA62E
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963465; cv=none; b=kvNt8AXCyWjI91aFnzrDmwqttsxKBd45+GWXkBOYm2o44ic/FXLFlPc5MtxWxZLZB6lEK0m4ZG7oMKcBDXHzruTmLkqT7Q72wKoQK5avjEkCmSK6L2NnRdYiVhxtkrROrBNmSAXZqSZDB/sM6g2gOhHtTWQHq/EcZvNl9mzwB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963465; c=relaxed/simple;
	bh=GNB5UM3mgJzHSuTJ35v/CIPz9DB5Xm0qfhbOxYYLujo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DN5ZkXE8cEPPYhh2KvvtfsKyC2mOO8pGbkMCrXs9ZQ7F5zobfp77P+jW1lU5xMjW5UDtQ+6jhc8ic/TXwuXO98BZJRFuZj6so6A/aaNh7UnrR3iSePqP0LxIkjv4pN94F8OEmcM/C0OYccpYjx7X8al9eUDxVzrINxK0CpiJ++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LSjrPa2P; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6HfLY21419683, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963461; bh=BkLjlLlJ7zu2RD15NXEwjD4DZF8UiNtqOzJW1WQU6DM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LSjrPa2P7XTyAuaFemXoszvEe8xbGrvrOPHmzHRFR13PwsDjZv5auIt4nfH3l6GVK
	 6sj3rB5YWTnraXC3P1bos6NCdCz+gUL/WTOPrv9iGNYfJcQ3FTeHuE/AONSlHS+id4
	 kGb45DaIvf/kFjCK/R8wBoG3SCbuJnX2q3wugsLKP9hHTUWvBakDDzbhow+TwHyzZO
	 dynil2a8du46eMJVVKz82GwwLIXWK+pWJ9AmysQUAiBHsnkF1lEynFwAdyka2+32Zv
	 Z61cf5WoX+k1Ir1XG+KQeJaOTk8NyVyOiZawI1ZiMNupRigtc1sEPWjGkScgRLPofZ
	 a6cMGemL5bOkg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6HfLY21419683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:40 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/12] wifi: rtw89: debug: add SER SW counters to count simulation
Date: Fri, 13 Feb 2026 14:15:50 +0800
Message-ID: <20260213061552.29997-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31804-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F3BE133397
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Some chipsets, e.g. Wi-Fi 7, will not record SER (system error recovery),
which are triggered by simulations, in the HW counters. Their HW counters
only record the SER happen in field. However for verification, it's still
needed to check if simulations are triggered. So, add SW counters to count
any causes that SER happen. But, SW can only count L1 and L2. SW does not
involve L0 SER, so SW cannot count it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  | 7 +++++++
 drivers/net/wireless/realtek/rtw89/debug.c | 6 ++++++
 drivers/net/wireless/realtek/rtw89/ser.c   | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1ad1fd2a1f6f..5d1cec20bc80 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5753,11 +5753,18 @@ enum rtw89_ser_rcvy_step {
 	RTW89_NUM_OF_SER_FLAGS
 };
 
+struct rtw89_ser_count {
+	unsigned int l1;
+	unsigned int l2;
+};
+
 struct rtw89_ser {
 	u8 state;
 	u8 alarm_event;
 	bool prehandle_l1;
 
+	struct rtw89_ser_count sw_cnt;
+
 	struct work_struct ser_hdl_work;
 	struct delayed_work ser_alarm_work;
 	const struct state_ent *st_tbl;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index d46691fa09bc..4cff3d927a69 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3780,6 +3780,7 @@ static ssize_t rtw89_debug_priv_ser_counters_get(struct rtw89_dev *rtwdev,
 						 struct rtw89_debugfs_priv *debugfs_priv,
 						 char *buf, size_t bufsz)
 {
+	const struct rtw89_ser_count *sw_cnt = &rtwdev->ser.sw_cnt;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_dbg_ser_counters cnt = {};
 	char *p = buf, *end = buf + bufsz;
@@ -3797,6 +3798,11 @@ static ssize_t rtw89_debug_priv_ser_counters_get(struct rtw89_dev *rtwdev,
 		return -EOPNOTSUPP;
 	}
 
+	p += scnprintf(p, end - p, "SER L1 SW Count: %u\n", sw_cnt->l1);
+	p += scnprintf(p, end - p, "SER L2 SW Count: %u\n", sw_cnt->l2);
+
+	/* Some chipsets won't record SER simulation in HW cnt. */
+	p += scnprintf(p, end - p, "---\n");
 	p += scnprintf(p, end - p, "SER L0 Count: %d\n", cnt.l0);
 	p += scnprintf(p, end - p, "SER L1 Count: %d\n", cnt.l1);
 	p += scnprintf(p, end - p, "SER L0 promote event: %d\n", cnt.l0_to_l1);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 7fdc69578da3..b2c910cf9587 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -498,6 +498,7 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 	switch (evt) {
 	case SER_EV_STATE_IN:
 		wiphy_lock(wiphy);
+		ser->sw_cnt.l1++;
 		wiphy_delayed_work_cancel(wiphy, &rtwdev->track_work);
 		wiphy_delayed_work_cancel(wiphy, &rtwdev->track_ps_work);
 		wiphy_unlock(wiphy);
@@ -730,6 +731,7 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 	switch (evt) {
 	case SER_EV_STATE_IN:
 		wiphy_lock(rtwdev->hw->wiphy);
+		ser->sw_cnt.l2++;
 		ser_l2_reset_st_pre_hdl(ser);
 		wiphy_unlock(rtwdev->hw->wiphy);
 
-- 
2.25.1


