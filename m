Return-Path: <linux-wireless+bounces-17823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1B6A18BA4
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0568B169564
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8DB18871F;
	Wed, 22 Jan 2025 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q0ZFyXr6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5B18E361
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525866; cv=none; b=GdjKitATLp4EJMsp9sb+PJ/w4x/5E9oCjRTN20RlDUXtysQZmpqNvGRFSaG9di61x2l7dvayhkPSUFuIl/VHucWiyeRLgwZ/r4CzVsUlvdF6dUO6bbypoZdKVNGsPa7H8B4CgYnvheB9E1fjVlSIgJZldtpJpgn2OIahG1awdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525866; c=relaxed/simple;
	bh=PYxZr56AC9IaGerQ2ye1f/Fs05NMgB6IDtCoqU97eks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZme7yKbWV5thGvFYJp9CKoZlN1CMkMvNLgjfFcggu1pJRhx/i5BCkEe34/sxOyIVZXcbc+ky6NcNtI60HOqjOLQ8TnSwqybY7wpIMHepbTfQjXP3iWLkbTuGdBk9E+z8p/bdXbbwKWKYLGxhHyDbWMxXAbj75gN+8T7HU7+5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q0ZFyXr6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M64MheC2495251, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525862; bh=PYxZr56AC9IaGerQ2ye1f/Fs05NMgB6IDtCoqU97eks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Q0ZFyXr6Zx3oKW2V+arw5mH46HLT5wUQCnSceHmjVrdJm4hAsVeGZTsrvVVyXZPsM
	 WVTewWEoitR7Z2DKkuj5eBgjCFC6bNn1oaKAPkX+0N79qqKGZgnyOzyaOXwUNcVZgc
	 UIsdpFtsn1QUHEljm6mK3O6nyQaBF5I+28pcNlatJz6pNb2E0JnetD8vi2GoY5zdds
	 mqOJu5RMBSxrz/S5VwVxhDvT1H8Vq4eW4toH1QE7dcrGRvVV/GtOMwmg9HwmjBpSw+
	 T42O4qNCEw4woGVWvEzLVC6bEVl2Kda7uRllEqkfo85H9KRq/u5m5vNcvpRrrisxiS
	 1gGwjI5g4XMwA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M64MheC2495251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:04:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:04:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:04:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/10] wifi: rtw89: pci: not assert wiphy_lock to free early_h2c for PCI probe/remove
Date: Wed, 22 Jan 2025 14:03:10 +0800
Message-ID: <20250122060310.31976-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122060310.31976-1-pkshih@realtek.com>
References: <20250122060310.31976-1-pkshih@realtek.com>
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

Except probe/remove flow, the consumers of early_h2c list are interface
start and debugfs. There must be no race between probe/remove flow and
interface start. The failed probe flow is to free early_h2c list as well
as remove flow, at these two moments debugfs doesn't present. Thus, it is
safe to free early_h2c list without held wiphy_lock in these situations.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c   | 11 ++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h   |  1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index df8468cfbbb2..0e8125929297 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4885,7 +4885,7 @@ void rtw89_core_deinit(struct rtw89_dev *rtwdev)
 {
 	rtw89_ser_deinit(rtwdev);
 	rtw89_unload_firmware(rtwdev);
-	rtw89_fw_free_all_early_h2c(rtwdev);
+	__rtw89_fw_free_all_early_h2c(rtwdev);
 
 	destroy_workqueue(rtwdev->txq_wq);
 	mutex_destroy(&rtwdev->rf_mutex);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index dedfd153207f..f20b3a3e7820 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6005,12 +6005,10 @@ void rtw89_fw_send_all_early_h2c(struct rtw89_dev *rtwdev)
 	}
 }
 
-void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev)
+void __rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_early_h2c *early_h2c, *tmp;
 
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
-
 	list_for_each_entry_safe(early_h2c, tmp, &rtwdev->early_h2c_list, list) {
 		list_del(&early_h2c->list);
 		kfree(early_h2c->h2c);
@@ -6018,6 +6016,13 @@ void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev)
 	}
 }
 
+void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev)
+{
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	__rtw89_fw_free_all_early_h2c(rtwdev);
+}
+
 static void rtw89_fw_c2h_parse_attr(struct sk_buff *c2h)
 {
 	const struct rtw89_c2h_hdr *hdr = (const struct rtw89_c2h_hdr *)c2h->data;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 620eeb65ddc1..f45d13918f32 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4654,6 +4654,7 @@ int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      bool rack, bool dack);
 int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len);
 void rtw89_fw_send_all_early_h2c(struct rtw89_dev *rtwdev);
+void __rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev);
 void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			     u8 macid);
-- 
2.25.1


