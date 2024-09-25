Return-Path: <linux-wireless+bounces-13131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EC9850AB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 03:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D341F23BEE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 01:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B932914830A;
	Wed, 25 Sep 2024 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BDrsceFH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75F147C9B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228392; cv=none; b=pnnWqNyn+zDZmtOh2lv7ZoHsnHVR+QlmyzqbLccMlpl3B0BXH4yMyX1wD6IENDFiHnLEGd7RDbkCG8VsvWhW8bPU9YtL9lMejNE+7KsxDf59qJaxBSDhRFlaHr8z3tYvj+RUtpbJsIGvyK/CgqjYnHk5aNfok06ILR6jQMWcrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228392; c=relaxed/simple;
	bh=G/+kjgqHhe3AWYKAJv3XqfQwio2QPcppm+O5WrXuPv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mepjxW0OMr8OdNe73Wru5+XKwultfp4svfx0bLUdXkRqbZdQPmz0WFaBBTDXv7Xr7VJg9BA88XVnu7R9elPblAiPOP03okGve8HPxTNMj3Bnm03G3MGudvhMkNtpM0FO3+emL+hla//joZv8oCvRptd5wxsl8G9+0ApCMIeYCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BDrsceFH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P1dmL433834583, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727228388; bh=G/+kjgqHhe3AWYKAJv3XqfQwio2QPcppm+O5WrXuPv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BDrsceFHJnzxri5YI0A1apE0y5u4zMATvid92yvPfaHJ8qGX7Yh1TEB+H9bwqjWtj
	 Is6dwvzSbYdiDpm9kvSBSjrzMiir28UGfFvtvOJqFNcFOGC8WztzrZTBudUeOhlcC3
	 RrhxLlP57wzR9Zxnzpmilh1IzlOh8fDrpmsPFJ/BnfSkTH16r+b4PDQJuqsaA2JxLB
	 WsnEzEYHcj4BxguE7wNiIPt0FujfP04goSYXAThY3VXasnbldOnlLGEHKmyoUqDZ4K
	 1UrJav2B3DPpGpBraaB5Q0bi9KoBGi2iHJ5/+qt/PWUfu7jEyEdnqrU4vZ3T4YZy1A
	 ovO1UglzRGHGQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P1dmL433834583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 09:39:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:39:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Sep
 2024 09:39:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: pci: consolidate PCI basic configurations for probe and resume
Date: Wed, 25 Sep 2024 09:38:58 +0800
Message-ID: <20240925013901.9835-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925013901.9835-1-pkshih@realtek.com>
References: <20240925013901.9835-1-pkshih@realtek.com>
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

The PCI settings aren't always persistent after chip suspends, so
reconfigure the settings after chip resumes. Since most of these settings
are the same, consolidate them into a function to avoid missing somewhere.

Fix the missing case of 8922AE resume flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 23 +++++++++++++--------
 drivers/net/wireless/realtek/rtw89/pci.h    |  1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c |  2 ++
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 02afeb3acce4..5733192cf380 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4188,6 +4188,17 @@ static void rtw89_pci_l2_hci_ldo(struct rtw89_dev *rtwdev)
 				    RTW89_PCIE_BIT_CFG_RST_MSTATE);
 }
 
+void rtw89_pci_basic_cfg(struct rtw89_dev *rtwdev, bool resume)
+{
+	if (resume)
+		rtw89_pci_cfg_dac(rtwdev);
+
+	rtw89_pci_disable_eq(rtwdev);
+	rtw89_pci_filter_out(rtwdev);
+	rtw89_pci_link_cfg(rtwdev);
+	rtw89_pci_l1ss_cfg(rtwdev);
+}
+
 static int __maybe_unused rtw89_pci_resume(struct device *dev)
 {
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
@@ -4209,11 +4220,8 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 				  B_AX_SEL_REQ_ENTR_L1);
 	}
 	rtw89_pci_l2_hci_ldo(rtwdev);
-	rtw89_pci_disable_eq(rtwdev);
-	rtw89_pci_cfg_dac(rtwdev);
-	rtw89_pci_filter_out(rtwdev);
-	rtw89_pci_link_cfg(rtwdev);
-	rtw89_pci_l1ss_cfg(rtwdev);
+
+	rtw89_pci_basic_cfg(rtwdev, true);
 
 	return 0;
 }
@@ -4345,10 +4353,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_clear_resource;
 	}
 
-	rtw89_pci_disable_eq(rtwdev);
-	rtw89_pci_filter_out(rtwdev);
-	rtw89_pci_link_cfg(rtwdev);
-	rtw89_pci_l1ss_cfg(rtwdev);
+	rtw89_pci_basic_cfg(rtwdev, false);
 
 	ret = rtw89_core_napi_init(rtwdev);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 48c3ab735db2..f101bd932f62 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1600,6 +1600,7 @@ struct pci_device_id;
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw89_pci_remove(struct pci_dev *pdev);
+void rtw89_pci_basic_cfg(struct rtw89_dev *rtwdev, bool resume);
 void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev);
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en);
 int rtw89_pci_ltr_set_v1(struct rtw89_dev *rtwdev, bool en);
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 7cc328222965..c1415a7b18ff 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -584,6 +584,8 @@ static int __maybe_unused rtw89_pci_resume_be(struct device *dev)
 	rtw89_write32_set(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
 	rtw89_write32_set(rtwdev, R_BE_REG_PL1_MASK, B_BE_SER_PM_MASTER_IMR);
 
+	rtw89_pci_basic_cfg(rtwdev, true);
+
 	return 0;
 }
 
-- 
2.25.1


