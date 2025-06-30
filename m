Return-Path: <linux-wireless+bounces-24675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADFEAEE86A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD987A16E6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3303F9FB;
	Mon, 30 Jun 2025 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYehf/6F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26624E4D4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316101; cv=none; b=r3f8ac/QOxpwrWEn8ngyDl19JFkn8W3bNZAaPxRe0Ty3chghPYy+yGnvMEUvP88CvVDH4iyS9I4/HvYt48BPGOPdUgsmW5fNqxHH6ZAAvQkOiVxTDb3JVitHyeVGbXJKU6Rlv9gyAFd03VNmz5mNY77nfVzdWBAJmFvdfGpDq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316101; c=relaxed/simple;
	bh=zEBQfHMLBUwH/7uzLQ60BwrHOLyqNmfQgkXBcitAr8M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GT0LxGSvytoj7POExfDxfg1wpzh8QU7WK6GO0HOTGbssgaLBx1DQfaE3RNikv0hbGb88JRSKxrlnZLtczv7Bp8OmL4iXKOz8vFpQgQcYZ3oWbtN5ZNyi1hhqt4KVX5AURBeoAJz1PeJfIRnYmR7n0qlktoIXUwaLijOVyyCqkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYehf/6F; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so41203445e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316096; x=1751920896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ktca+rF81AH7G4wq//0alRGrh7/eNAPdNvyKUHc6Zxk=;
        b=WYehf/6FOXre77EaCBS8IjvJteoLT4eTScMAPWyDqniZ9MrfLC3P0Z+8UmHeUyngSO
         b09Ud0zPubmYFYa73qrOvGiZgQpFBuwhDU6WNOIun97LCjDsjZLuNmwtOE3lGehs7MlI
         4qF9GG1HYmfaCXcyK55hTeEdx2fCIzEsRhM+L39Y5HhvzdSkMmMHoAejKLHXvgiGD1Qs
         kVt76OFU3K2ibMDNmEpOknVysUG9PVQZxbsnlrNBRLxMP2sDJzlKiAAm9NG/V5JBz6AU
         3LEwti1MNtMKnZimtUV6fjncTpC8SenfEI2SHxbVr1b1h27CnuGAb9VhRzusvKm15BLS
         MEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316096; x=1751920896;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktca+rF81AH7G4wq//0alRGrh7/eNAPdNvyKUHc6Zxk=;
        b=hKgp5fZ3FZwdyRrS3LtpH7KZ4YTs2dXg24m+JY04p5ZdAHPjk0NK+V2IS3PplFMksF
         spXKAMg0SLE+7oC4cvOWNo3nyp0DhdV/VvPxsXgAPcMduzwU3adNTwgh8o7g/85Pcu+m
         M8jTUXjE/Tl5Cscq0RkqzO+RH8CKbl7a1E5f6F84lcInI+SSE+FUX2z5hL3sFfO9N+Jk
         RquoyoiOXV5S613EBN98A5Y92pIubKLvnfsvyk9bPVZmIJAt63GXeEohGjywi8nHEg3E
         tUFHGwokAUs95mXscxUB1GQjIa35sSQipEKef22EUrFFhcVPvg287zZM4y4cq9NPF1LF
         zN2Q==
X-Gm-Message-State: AOJu0Ywy3t19PKXHyddh3WIOvf6hKc4T+WeOwvqjzJrZl1WBVBbQHwuf
	O5fw6PCbsC6gZluy/m3GjUJAmtRDEhYsHLabqB1OAj3BSTmfAjnUNDGs3dB03A==
X-Gm-Gg: ASbGncuYbzaFp+mQRCFdo12707qJeZBakcb5R7B/PTbuiNrawzCR/epaSL5U67hMQ3Y
	bU83hH1pvC0qI9lz6713TGNCn78J3MZy2VOmlqnb1tZqV2/ysFKN2RPj6nl5xi8EV/ikuUNBXV6
	0mLGuouyNXTwmyIjf5R0FsGiKQ0d885we4oUY80bqe7B4GUcJQrkiPJSzMS03kdsSBH1ei1QexK
	DW0636kDEV1wRaoINC4wCsv2i2KIH6eqP/26GGC0g9v0bv8QjmvjUMaHUCBrUQxSYvfn1GKNEJg
	mXrDXuOUx3eYKaifI/VeXMiS76QJ6yu/ZJTdUJR0wRYgLMBlCNmkUTJIQ6efWy9h4fA9UQ==
X-Google-Smtp-Source: AGHT+IGJvs8GurFsfqnXf51S65htXRYEJEPIn8/hfLhZfVdaKUitw65LvWbFV6S1vnZv1/1veZpXuA==
X-Received: by 2002:a05:600c:3b9a:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-45395177409mr129200295e9.30.1751316095506;
        Mon, 30 Jun 2025 13:41:35 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453a1914d10sm36004775e9.4.2025.06.30.13.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:41:35 -0700 (PDT)
Message-ID: <c9152735-dbc4-4473-ae29-a79625cfbf78@gmail.com>
Date: Mon, 30 Jun 2025 23:41:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 02/14] wifi: rtw89: Make dle_mem in
 rtw89_chip_info an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

USB 2, USB 3, and SDIO will need different sets of values compared to
PCIe.

Add a new dle_type member in struct rtw89_hci_info and make dle_mem in
struct rtw89_chip_info an array to hold the four different sets of
values.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Make dle_mem an array instead of having (eventually) four different
   dle_mem_* members.

v3:
 - Add null check for rtwdev->chip->dle_mem[rtwdev->hci.dle_type].

v4:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/core.h      | 12 +++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c       |  7 ++++---
 drivers/net/wireless/realtek/rtw89/pci.c       |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  |  2 +-
 9 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cdacf100a59a..5771e195429f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -132,6 +132,15 @@ enum rtw89_hci_type {
 	RTW89_HCI_TYPE_SDIO,
 };
 
+enum rtw89_hci_dle_type {
+	RTW89_HCI_DLE_TYPE_PCIE,
+	RTW89_HCI_DLE_TYPE_USB2,
+	RTW89_HCI_DLE_TYPE_USB3,
+	RTW89_HCI_DLE_TYPE_SDIO,
+
+	RTW89_HCI_DLE_TYPE_NUM,
+};
+
 enum rtw89_core_chip_id {
 	RTL8852A,
 	RTL8852B,
@@ -3659,6 +3668,7 @@ struct rtw89_hci_ops {
 struct rtw89_hci_info {
 	const struct rtw89_hci_ops *ops;
 	enum rtw89_hci_type type;
+	enum rtw89_hci_dle_type dle_type;
 	u32 rpwm_addr;
 	u32 cpwm_addr;
 	bool paused;
@@ -4358,7 +4368,7 @@ struct rtw89_chip_info {
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
-	const struct rtw89_dle_mem *dle_mem;
+	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 53628838a7c5..8e7ce45207da 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1717,12 +1717,13 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 						   enum rtw89_qta_mode mode)
 {
 	struct rtw89_mac_info *mac = &rtwdev->mac;
-	const struct rtw89_dle_mem *cfg;
+	const struct rtw89_dle_mem *cfg, *cfgs;
 
-	cfg = &rtwdev->chip->dle_mem[mode];
-	if (!cfg)
+	cfgs = rtwdev->chip->dle_mem[rtwdev->hci.dle_type];
+	if (!cfgs)
 		return NULL;
 
+	cfg = &cfgs[mode];
 	if (cfg->mode != mode) {
 		rtw89_warn(rtwdev, "qta mode unmatch!\n");
 		return NULL;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 204a3748d913..597de632e364 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4486,6 +4486,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rtwdev->pci_info = info->bus.pci;
 	rtwdev->hci.ops = &rtw89_pci_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_PCIE;
+	rtwdev->hci.dle_type = RTW89_HCI_DLE_TYPE_PCIE;
 	rtwdev->hci.rpwm_addr = pci_info->rpwm_addr;
 	rtwdev->hci.cpwm_addr = pci_info->cpwm_addr;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 823c3994fa56..d4744defebe2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2466,7 +2466,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8851b_hfc_param_ini_pcie,
-	.dle_mem		= rtw8851b_dle_mem_pcie,
+	.dle_mem		= {rtw8851b_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 080636e8d0c3..8bf222bdb927 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2185,7 +2185,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852a_dle_mem_pcie,
+	.dle_mem		= {rtw8852a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index c0bf80450acf..a6faae0d031a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -821,7 +821,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852b_dle_mem_pcie,
+	.dle_mem		= {rtw8852b_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 95e088734423..f536181bfb66 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -755,7 +755,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852bt_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852bt_dle_mem_pcie,
+	.dle_mem		= {rtw8852bt_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8f3d0c91a3f8..67db480940b3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3005,7 +3005,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852c_dle_mem_pcie,
+	.dle_mem		= {rtw8852c_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 603212ed4558..09dbe4008b89 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2860,7 +2860,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
 	.hfc_param_ini		= rtw8922a_hfc_param_ini_pcie,
-	.dle_mem		= rtw8922a_dle_mem_pcie,
+	.dle_mem		= {rtw8922a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
-- 
2.49.0


