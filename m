Return-Path: <linux-wireless+bounces-16008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04279E8A3B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90588281ED9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C4B157466;
	Mon,  9 Dec 2024 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Wy+9duaq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86039156F41
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718105; cv=none; b=euZbFl0EoAqj7KdZNlMvDGTVP+JVej+ggQEzB8wTyKJ5ibeIiiu0SfsVUalsD2XzvA3P8TTc9PPuWHVDMjbO30Iz0xiNAWWPw3WMLHuCeTHIAEf/MKL7bKxJV36BVdnyY0eIZkcSD5dvMIlnlOvB62kcR8wh/kIqWAfjBl9rsjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718105; c=relaxed/simple;
	bh=/Hk7iP86e7Qa9MC7PM7F/GvRzk6G4YEK0EfVJ+lVML8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mNZInLk09ZEnCQ29RjC2N3mJCYlT6fRnCVM4AoSZzYgagS3C746Xnqfp/C4SJRxhLZ7E+aUga8hlhP+SciDTi8NdgLNLMp3IMSVHfsYsSIBUMi83kvKOW/dfySmn5q5r9lsL4hqY90h7Zz3LWI87m6YMQ0pL8a3igM0Doy5rFF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Wy+9duaq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B94LdCpA008673, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733718099; bh=/Hk7iP86e7Qa9MC7PM7F/GvRzk6G4YEK0EfVJ+lVML8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Wy+9duaqkgQG1nTus2AcMcSmwFuJAg7Iy0Sv4RqYh+3FR8k38bbpIO3yhts+MVGtm
	 vv98IrHkfBYt630qnefANwFCR6oAi86tGYmeEr/FJs4NbzIJ6niFHm8wbyNPXWBDG4
	 tAgwUjs0E6DZ4SGanBXgNLuCQ5IWJ59ZvxRVut72H+9cBVKD1aqGbx91MdGCbgZBiM
	 +9qJ7tMFgb5L3/TGI00E57QktnkZfeOMgXS4NRpp1rW9luX5GUb+MNc+RL/9jqp7El
	 XTTKBZ9vbzYCGK0iRMGJ51NuEmZ5r8Cl7dXBaUyuom8h8shwi8MHry2WMmNXoUne8m
	 u1kUS77VpTwBA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B94LdCpA008673
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 9 Dec 2024 12:21:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 12:21:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 9 Dec
 2024 12:21:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: phy: add dummy C2H event handler for report of TAS power
Date: Mon, 9 Dec 2024 12:21:27 +0800
Message-ID: <20241209042127.21424-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The newer firmware, lik RTL8852C version 0.27.111.0, will notify driver
report of TAS (Time Averaged SAR) power by new C2H events. This is to
assist in higher accurate calculation of TAS.

For now, driver doesn't use the report yet, so add a dummy handler to
avoid it throws info like:
   rtw89_8852ce 0000:03:00.0: c2h class 9 func 6 not support

Also add "MAC" and "PHY" to the message to disambiguate the source of
C2H event.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c |  4 ++--
 drivers/net/wireless/realtek/rtw89/phy.c | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index bb4f58118e05..c78066fd4504 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5558,11 +5558,11 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case RTW89_MAC_C2H_CLASS_FWDBG:
 		return;
 	default:
-		rtw89_info(rtwdev, "c2h class %d not support\n", class);
+		rtw89_info(rtwdev, "MAC c2h class %d not support\n", class);
 		return;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "c2h class %d func %d not support\n", class,
+		rtw89_info(rtwdev, "MAC c2h class %d func %d not support\n", class,
 			   func);
 		return;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 8d36bf962732..b4bcac79e5d8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3436,10 +3436,16 @@ rtw89_phy_c2h_rfk_report_state(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u3
 		    (int)(len - sizeof(report->hdr)), &report->state);
 }
 
+static void
+rtw89_phy_c2h_rfk_log_tas_pwr(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
 static
 void (* const rtw89_phy_c2h_rfk_report_handler[])(struct rtw89_dev *rtwdev,
 						  struct sk_buff *c2h, u32 len) = {
 	[RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE] = rtw89_phy_c2h_rfk_report_state,
+	[RTW89_PHY_C2H_RFK_LOG_TAS_PWR] = rtw89_phy_c2h_rfk_log_tas_pwr,
 };
 
 bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
@@ -3493,11 +3499,11 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			return;
 		fallthrough;
 	default:
-		rtw89_info(rtwdev, "c2h class %d not support\n", class);
+		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
 		return;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "c2h class %d func %d not support\n", class,
+		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
 			   func);
 		return;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index e6d06f0a6c09..a32477a480d8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -151,6 +151,7 @@ enum rtw89_phy_c2h_rfk_log_func {
 
 enum rtw89_phy_c2h_rfk_report_func {
 	RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE = 0,
+	RTW89_PHY_C2H_RFK_LOG_TAS_PWR = 6,
 };
 
 enum rtw89_phy_c2h_dm_func {
-- 
2.25.1


