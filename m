Return-Path: <linux-wireless+bounces-34996-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFriNmqg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34996-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F372426933
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE35E300559A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F437CD53;
	Mon, 20 Apr 2026 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZIgzhz5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550D3783D4
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656489; cv=none; b=KvuNhe59zwdkuQmZQMcjkV6VTWcko39pfYqq/AWH7ffwHdNsda8BollzPopulZrt0Hyap8iIXLuJ68+Oi/XndFFm5crVrfng2UsGShClMJK65PIpq+RpnNk2XuUAmoXjILe4/GHpGS4Tn/SqJ9TPHXikMQraPgsIRuMAI8h7OEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656489; c=relaxed/simple;
	bh=slqlEMJvoH81UiZe4JDrbw+WJprKnwtrTCKI9xM2nyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jcqnl2wTt/YFCwYFB9T6BsmRgyatQQ+JBwb3RdAsqU4Fux2hx82cWkx1Ha4nKojHbJuFAQeUKSiyGi/ORqb4dl3kFdI5uBKJrJykRHWRwO2AslXjJftQLpxx+ipIgPfn+rbVbwwKCZCGyr6VJ8w7OahvXXewEFf9wK2CduH6B2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZIgzhz5x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3fPaJ5426706, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656485; bh=zBTiXXB/1ygzZ2G+9iRZiXS3q5oGRW21QZVJCRxJlG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZIgzhz5xFrD/QsWhORawEE5AUNI+oXZsq9Dc9hrIk7t7JlcjtiQ13E5SR21abDOGt
	 MYE2AQj41M9qzpDlFfAwFQOP0H5a27coaq3QXqzn7sqrQLbeBvQ9ikSMAjxYrf49xc
	 Pgg7A5ed8iTZ7UXhP7sSM5MjAGnOXYmb1ShRiWo/iLm4KC1zlZZRi32aFUjDMznHaa
	 cVkx+KSLOU4V1ptRt1Ql1rlIL3uORA2oCAigii6e/UHQjIpXjDx1mPeONaVLM80rKv
	 FXRg6UrWwXO9aZiphbT9lfhaMqtm0WEC+Xs8SKfjZJSJmZEnzfZAetjCxsu4wXlFC7
	 SH/RxmuRzzU6A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3fPaJ5426706
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:25 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 03/16] wifi: rtw89: debug: disable hw_scan for latency-sensitive scenarios
Date: Mon, 20 Apr 2026 11:40:38 +0800
Message-ID: <20260420034051.17666-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-34996-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8F372426933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johnson Tsai <wenjie.tsai@realtek.com>

This helps avoid scan-triggered off-channel activity during
latency-sensitive scenarios.

Add RTW89_DM_HW_SCAN to the disabled_dm bitmap via debugfs and
check it in the hw_scan path. When set, the driver rejects hw_scan
requests and returns -EBUSY.

Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/debug.c    | 1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bbcac7cc207c..4a05a8dbb9ed 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5178,6 +5178,7 @@ enum rtw89_dm_type {
 	RTW89_DM_THERMAL_PROTECT,
 	RTW89_DM_TAS,
 	RTW89_DM_MLO,
+	RTW89_DM_HW_SCAN,
 };
 
 #define RTW89_THERMAL_PROT_LV_MAX 5
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 7d8d22311018..02386d1d07c6 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4347,6 +4347,7 @@ static const struct rtw89_disabled_dm_info {
 	DM_INFO(THERMAL_PROTECT),
 	DM_INFO(TAS),
 	DM_INFO(MLO),
+	DM_INFO(HW_SCAN),
 };
 
 static ssize_t
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 501c3af1da01..9ee2aa225976 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1241,6 +1241,7 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -1248,6 +1249,12 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return 1;
 
+	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_HW_SCAN)) {
+		rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+			    "reject hw scan due to disabled_dm\n");
+		return -EBUSY;
+	}
+
 	if (rtwdev->scanning || rtwvif->offchan)
 		return -EBUSY;
 
-- 
2.25.1


