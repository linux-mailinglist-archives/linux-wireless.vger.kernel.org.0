Return-Path: <linux-wireless+bounces-32814-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABW2KhPQr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32814-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:02:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC6246DD5
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 087D0300D1C4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA33ECBD2;
	Tue, 10 Mar 2026 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vcvnwsZc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1628640C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129744; cv=none; b=BpTeWZj6x2DO/I5tuT0N5qmRuP158w2qZgUCmc+ahpiLcazMBNjKlahMRPiZvBY7tTxaCTSgucMsuQ2DZ5WdsK1jq1vIWsqPqMVdDg/7t1vJ1+x6S0PamRbxZF1jfsE4VKFOkQwmqzNyooa0Y5Hz6c78bEY8dZOVUMrgQyM1TsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129744; c=relaxed/simple;
	bh=5yrYmyc2iVEYmi6wSFQF4FdaYdMMsdmUPNtIROyjIBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMj3V3Sr2bFBz9DGj8c26Gb9uFKyoLjV4ZjljF0U59Ae7wd+IUmbtEZcPnsSbERICs/TsUvRv9kVCOrmCFCyCCcm9u6qoMTu2S4RDcYUnlWjx+Z9fW9ZBAgR+ElUyL/KHD/U6z5Sc+0g/hL8GGjFelDYRAI8UY0ikt8sl7RNvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vcvnwsZc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A82LGn82209838, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129741; bh=XyckWn/3XHh7fxCILCmMoCP6baapRXLF1WYX/ePuyAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vcvnwsZcLcQe6s1UXo0lRgRjyZCFFjD7NO7zn88oc/Q+0x7trCMB47HOZ8OdpBDMB
	 /GpsrdiUUcvQH/kmipelkygQMLfpolSQ2omzkRviPtNNju3w7wp1xbyqe/FPAvfkMe
	 905GP/RotKiAZA+gFIJ1KiTCae3BFjWPMtqeL9imDequjfdN1p1j2QNlC09AgON3x/
	 bwBNes0IL6e72t9V3mtFh/19bdG0DmOaEsiD1o/8FBmNjgK7Qb/hRUJfwhV0F+0EbA
	 V8ibrvbJ7TibkEVnxn+wL/pE1Z1vChuhKV4wSlmtPLl5u3eB4bFbKcqtjDAEeqcaeI
	 GS0QVYc7sSCTg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A82LGn82209838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:21 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:21 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/13] wifi: rtw89: move disabling dynamic mechanism functions to core
Date: Tue, 10 Mar 2026 16:01:38 +0800
Message-ID: <20260310080146.31113-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 94EC6246DD5
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32814-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Some dynamic mechanism (DM) may need to be disabled during some normal
processes rather than debugging. For example, should not do MLSR switch
during SCAN/ROC or even MCC. So, move the disabling DM functions to core
for impending uses.

No logic changes.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 29 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h  |  3 ++
 drivers/net/wireless/realtek/rtw89/debug.c | 35 ++--------------------
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 9d9b91570989..81004ef18168 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4713,6 +4713,35 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 		rtw89_enter_lps_track(rtwdev);
 }
 
+void rtw89_core_dm_disable_cfg(struct rtw89_dev *rtwdev, u32 new)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 old = hal->disabled_dm_bitmap;
+
+	if (new == old)
+		return;
+
+	hal->disabled_dm_bitmap = new;
+
+	rtw89_debug(rtwdev, RTW89_DBG_STATE, "Disable DM: 0x%x -> 0x%x\n", old, new);
+}
+
+void rtw89_core_dm_disable_set(struct rtw89_dev *rtwdev, enum rtw89_dm_type type)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 cur = hal->disabled_dm_bitmap;
+
+	rtw89_core_dm_disable_cfg(rtwdev, cur | BIT(type));
+}
+
+void rtw89_core_dm_disable_clr(struct rtw89_dev *rtwdev, enum rtw89_dm_type type)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 cur = hal->disabled_dm_bitmap;
+
+	rtw89_core_dm_disable_cfg(rtwdev, cur & ~BIT(type));
+}
+
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size)
 {
 	unsigned long bit;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cf0cc718f41c..05f8ad6d3034 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7862,5 +7862,8 @@ void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev,
 void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event);
 int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   unsigned int link_id);
+void rtw89_core_dm_disable_cfg(struct rtw89_dev *rtwdev, u32 new);
+void rtw89_core_dm_disable_set(struct rtw89_dev *rtwdev, enum rtw89_dm_type type);
+void rtw89_core_dm_disable_clr(struct rtw89_dev *rtwdev, enum rtw89_dm_type type);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 3e16ed2c4570..aee0f25e036a 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4333,35 +4333,6 @@ static ssize_t rtw89_debug_priv_stations_get(struct rtw89_dev *rtwdev,
 	return p - buf;
 }
 
-static void rtw89_debug_disable_dm_cfg_bmap(struct rtw89_dev *rtwdev, u32 new)
-{
-	struct rtw89_hal *hal = &rtwdev->hal;
-	u32 old = hal->disabled_dm_bitmap;
-
-	if (new == old)
-		return;
-
-	hal->disabled_dm_bitmap = new;
-
-	rtw89_debug(rtwdev, RTW89_DBG_STATE, "Disable DM: 0x%x -> 0x%x\n", old, new);
-}
-
-static void rtw89_debug_disable_dm_set_flag(struct rtw89_dev *rtwdev, u8 flag)
-{
-	struct rtw89_hal *hal = &rtwdev->hal;
-	u32 cur = hal->disabled_dm_bitmap;
-
-	rtw89_debug_disable_dm_cfg_bmap(rtwdev, cur | BIT(flag));
-}
-
-static void rtw89_debug_disable_dm_clr_flag(struct rtw89_dev *rtwdev, u8 flag)
-{
-	struct rtw89_hal *hal = &rtwdev->hal;
-	u32 cur = hal->disabled_dm_bitmap;
-
-	rtw89_debug_disable_dm_cfg_bmap(rtwdev, cur & ~BIT(flag));
-}
-
 #define DM_INFO(type) {RTW89_DM_ ## type, #type}
 
 static const struct rtw89_disabled_dm_info {
@@ -4412,7 +4383,7 @@ rtw89_debug_priv_disable_dm_set(struct rtw89_dev *rtwdev,
 	if (ret)
 		return -EINVAL;
 
-	rtw89_debug_disable_dm_cfg_bmap(rtwdev, conf);
+	rtw89_core_dm_disable_cfg(rtwdev, conf);
 
 	return count;
 }
@@ -4475,7 +4446,7 @@ rtw89_debug_priv_mlo_mode_set(struct rtw89_dev *rtwdev,
 	if (num != 2)
 		return -EINVAL;
 
-	rtw89_debug_disable_dm_set_flag(rtwdev, RTW89_DM_MLO);
+	rtw89_core_dm_disable_set(rtwdev, RTW89_DM_MLO);
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "Set MLO mode to %x\n", mlo_mode);
 
@@ -4485,7 +4456,7 @@ rtw89_debug_priv_mlo_mode_set(struct rtw89_dev *rtwdev,
 		break;
 	default:
 		rtw89_debug(rtwdev, RTW89_DBG_STATE, "Unsupported MLO mode\n");
-		rtw89_debug_disable_dm_clr_flag(rtwdev, RTW89_DM_MLO);
+		rtw89_core_dm_disable_clr(rtwdev, RTW89_DM_MLO);
 
 		return -EOPNOTSUPP;
 	}
-- 
2.25.1


