Return-Path: <linux-wireless+bounces-24295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42162AE2291
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 20:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB2216B928
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188327E040;
	Fri, 20 Jun 2025 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGu1OniY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657EF1FBEA6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445660; cv=none; b=UEsSdUygLS49De1nOtXjlYRdYr2lXy1mzxWYkmPhnrGgk+vg0AhoiJp7EzQNovqjESGoK48DaGRgabuEY5Ou6fbrc4dp+DoomJBaUjwabpXIaPb37sjt/YeMcr38fwKIQT5UD1828ZkjDeIGs3Lle8ppBsnON9GrZurUQKPofp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445660; c=relaxed/simple;
	bh=LwR9qb/qk02mKROsZJe7jq2CbKF0r9YP9+J2nPbNKDc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gOIFrkB6AXoYScAlgFjP2JG1jhQjL4boxTOuFxu1Vyeh6D4jSpmG/vPU/mSURkh53SLEpMIR7pcgzJHPKy8RyAtTrGV5TnLt2/RamFo7YHGH3IrH9aXRWavAoJJvQKNoFSFnDlW6myPY+8g23ejFKluHnV1R/ByLjhB8MFyhvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGu1OniY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso1824688f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445656; x=1751050456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=91QnH3wvJaeHyXpnvK9rkQ6c5Kz4xtsaasAUKQbSGuU=;
        b=XGu1OniYYeroXq3kf2f367ipvbRQVkY3HCsY/WxavY0b8sUA4HJ8lnV2Y6dgLaH6zX
         6RojWHq4sxsRa0EHu3+yjeuHfVbaQsq2RXaH4bd/7sFTrUcNuJhh0SpDuNx4+9V/LS1P
         msHXHrbyOSdM/mTC3bBj3qRBbdqTYHDyQB0BvMGP2bsGT/9v36qsAu5rFlym5hRmEHYc
         Q72Jw+LdjZXmNklBaznc71ctOCNT//nwerEdm4STXixOLdgev7BKTqLYNtpqHFwJ++LA
         pwC9fRl7T61xqIBdOM53hMcyVkg4gLeUmUd5nJ/eVbZsOCHk5zmvwQAWwDp+ioZJnU+i
         OZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445656; x=1751050456;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91QnH3wvJaeHyXpnvK9rkQ6c5Kz4xtsaasAUKQbSGuU=;
        b=VlyqR12qqHEFkHKy58GKM15D0yhFh2/pcdZPbrBFO0KLzMh+YaYLsBSkxoK8tGVyuI
         ndKkDJyU4j8h5GDCpo/wY/hreS1nzAKPBvJUAmqPPTJ4ct+YVb73CO19Eiyq5vpL0ltJ
         6lTiFCjiC6vpXnhqEvuxoAAfzA4dQZQ2jYA5bE/3vXsJR/BRiw5ir/kudaNFcdU3cyzk
         zVdZtVegnGH4BBpXCoT8p5EWkRGxAPzQNvgM3tWWZgBhUp7CLf8eUqSgDbRW5EILDMBT
         sYNkmgdut9gwN6Jo6TTneNk+b9xGf2Or9Kjk4jbhNFQUOasuWzMbthgJ16cTVJAzbOal
         LBmQ==
X-Gm-Message-State: AOJu0YyR7YKMcC+U0Rz2nDECho9WgYSgkZ0nY2lQ6zTvvi8MoypODCZC
	FXnsuv5DyphdlBHFrfBPH+1er22RGLFr4+sauKsRZjxZ0ko0sWnx88BVzfnxTg==
X-Gm-Gg: ASbGncvyOsRPnQFPv+XYllPPxmqU1K0GQot8qbnOMhmeDhMfe2m0tYsvs8tDWj6RA8n
	TC9kMm4P9oaZZRwu85z4zAd662O4qlH1agDgXM7VPDhmUpwsUSr6/R1BquD6CGDtCJBIUfB32uC
	tJABZ2IU+TWihlrdEyqQwQEDi9MEzLNHOOEyu2XZpd24JhtmZoCFY+VEic32NDe95OTLk2sXmug
	KeoqwkIWyxVWDO2ykWYMUzu1QgCuME84ZuDvEOK7JeBJ1PG4usyAW8B49Ym7wxS7ucZD15JQ6v+
	+taMRJzpsqITw8zNPn33v5SDXABiXE0Oqcir6gOONmELgSdDM+oRtZiwrn5sc3fs24lvww==
X-Google-Smtp-Source: AGHT+IF5SkTq0LSfKL3n5aZn8OLEhTwni/fDeoWC0KVdapbYwSFMiyFxxqYZNq9v4mYfGPkmNFnMMg==
X-Received: by 2002:a5d:5f09:0:b0:3a5:1c3c:8d8d with SMTP id ffacd0b85a97d-3a6d1326267mr3256544f8f.55.1750445655593;
        Fri, 20 Jun 2025 11:54:15 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1d168sm2723071f8f.40.2025.06.20.11.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 11:54:15 -0700 (PDT)
Message-ID: <62339c51-87c8-4064-ae9c-9f34127632e5@gmail.com>
Date: Fri, 20 Jun 2025 21:54:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 02/14] wifi: rtw89: Make dle_mem in
 rtw89_chip_info an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

USB 2, USB 3, and SDIO will need different sets of values compared to
PCIe.

Add a new dle_type member in struct rtw89_hci_info and make dle_mem in
struct rtw89_chip_info an array to hold the four different sets of
values.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Make dle_mem an array instead of having (eventually) four different
   dle_mem_* members.

v3:
 - Add null check for rtwdev->chip->dle_mem[rtwdev->hci.dle_type].
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
index 328d4e9352fe..46d3512afb57 100644
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
@@ -3647,6 +3656,7 @@ struct rtw89_hci_ops {
 struct rtw89_hci_info {
 	const struct rtw89_hci_ops *ops;
 	enum rtw89_hci_type type;
+	enum rtw89_hci_dle_type dle_type;
 	u32 rpwm_addr;
 	u32 cpwm_addr;
 	bool paused;
@@ -4346,7 +4356,7 @@ struct rtw89_chip_info {
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
-	const struct rtw89_dle_mem *dle_mem;
+	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8ec86e1fa9d6..7d3e6448423a 100644
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
index 6ba88ca2bab3..bd777b0c3f4d 100644
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
index dc4eab2e7919..13fbc3a1b49e 100644
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
index 1f1e10f2b39d..b2989cdcce34 100644
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
index 4c34f5037908..762a1fc005d2 100644
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
index b39add1b798c..c0d76d318b24 100644
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
index ca32ccb00107..7854d6f30b6d 100644
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


