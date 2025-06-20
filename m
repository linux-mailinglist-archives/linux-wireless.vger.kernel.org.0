Return-Path: <linux-wireless+bounces-24296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EB5AE2292
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 20:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE616B9F0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925412E8E1D;
	Fri, 20 Jun 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPykypai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AF27E040
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445767; cv=none; b=CxpJ/FVYV04lbtHIue24NIH3XJj64xrXu3WpuuqxvRNmbd2q2oZr3WGzVbl6mLcIiXGL2LpWyCUC3u9hYiGtC9tuUe54spLxvF52wJHEkwSlO1Vw3wFChEmH+HDB2KXMDkSOSybaDw5Sgueq/K+SwcnmJoGMeEiVu/YnH3pQ+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445767; c=relaxed/simple;
	bh=uhzeiwhTC5RbUNLDmYd6/ZM/1sn2tnyKlSfBcxbYoMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RER3UeUq9ueIuiuScFzfF3gJBUMxJoqSJdXUgqfQGDEr1WPBbntSO6Lx2Y/FCVah3UEiiQ8O+g02QVrQN1yDY0eaMtSGBSWEExXQdi331gdappx0zWPeZ7X7z+XNeg+i+YcQ2s/I1KvXQQgAeWUbAzyLL0DStS54xe93CRLwN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPykypai; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so24849585e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445764; x=1751050564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mDuk4rR7xmvUDfdPmoD7BLnQtPdniSEaK7Uf+g1XJRw=;
        b=CPykypaiNLFQXzMeD6LSLUwDfmdjF8shsyGEleJseMrotWG7HSM+4bW4bQZOuUav37
         Kp5hDo22sCJBhywjVHifSSs+BV20yB7HJItVImrC6M+EsaqZIQNfw9OTblbFSk9+weFR
         BFfMXL8ijtrEPo3Lj3FdiGcJ+xPqz9pPP8OMzqpLeDJYKxD8qZ4NB+dRw89t2F3j6z+h
         SmjenNmkVNt4GDjnnvF+MqinQaV1JaeE3I0WIfESIlGnKIuTeSLpRcnXSQolEV4/PRGh
         /hTFiwy+mnqKtubAFTTxBH3Ln01CcXEWPI/skJqB2v97Zdp37XE18Dd0MQtdBA4RaURs
         8NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445764; x=1751050564;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDuk4rR7xmvUDfdPmoD7BLnQtPdniSEaK7Uf+g1XJRw=;
        b=hgp7P4S5xbaZWvgiJut8LLMSmxrqfA9e2IznFpv0chEDvtSdzKUwIV1NsS0u8sYJ0c
         Vj2F6WPe1PT/pLEyad9m23dnwk/1PeSjIWfH4i2Sokff0A6DoyG9b6sc1WzqhtBL20mN
         BVktaP8sfiJuhDnl0rhkIey30YInvuoCwgwvDUFCFbCemb/cYcl2bZy+WL8+slTj9nWw
         gRIMd1533t8bVwRhesl6GaKE4g7zUMdJf0jjh0rnaaKzjEfZ7N55XRwqO7sSANdqmzQB
         ZZIXJ3TT5FcCNeQYgOYKRgq1vwke0+yPy2TFvE0qcrHYIRM0S3Soq8rHTZ7Q7So1dBFD
         VW0g==
X-Gm-Message-State: AOJu0YyosyvDQWkmvNl71pL/kXjCV+H2QA5GiKpZ3qcyM87nlvlVDpdD
	eG8KiryMcMvg12p+wvF4k1Whd/DQXhFuDGmuYUAxA0T4JrCfQfjqvB3YE5qh/Q==
X-Gm-Gg: ASbGnctrLlI2aHkvRuea0ORcTvqFKcdWPvsWsoOwEeFaTq5f0+ZBsfgVDTXWi80dUmO
	Wfaohs8xPSxwopdkHAq9pvRaz0DFNyXP0l7b1UTdW0CmSNcOtZL9Tais+s1pLJwJhLu0S5jNeN6
	32l9X0gNXSXWRrvmObuKt264sYlcdeAYXwIDSbHsuRU12etWp5wz+2/Hp9aqg2oxGiP6HXRtyUZ
	7NKPfma/B/pj/uCKYQ7qSnIn6a/wda5EAQxqjzYFndmS0BYIyKvdpSIgTD/oIaKZ2FBWmECbPS3
	iCHHGCsGj/+K4APg2+sWcMIoqYtFnZZN5WXNAz2/fb/CTUr61qQLlcU8aSuJbENbZfc/9A==
X-Google-Smtp-Source: AGHT+IHEiW9mUgWFz1xPax2tkG7P2iA6h3kzdI30s+E9/WM8nsFI/GfkUqunxBWU69IK75pHX5WzfQ==
X-Received: by 2002:a05:600c:5490:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-453655c30e4mr46148135e9.15.1750445763576;
        Fri, 20 Jun 2025 11:56:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4536466596asm34880985e9.0.2025.06.20.11.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 11:56:03 -0700 (PDT)
Message-ID: <4fedeea5-d3a4-44ca-b1a7-83de381eff8d@gmail.com>
Date: Fri, 20 Jun 2025 21:56:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 03/14] wifi: rtw89: Make hfc_param_ini in
 rtw89_chip_info an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

USB and SDIO will need different sets of values, so make hfc_param_ini
in struct rtw89_chip_info an array.

Also make param_ini a pointer instead of copying the struct.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Make hfc_param_ini an array instead of having (eventually) three
   different hfc_param_ini_* members.

v3:
 - Add null check for rtwdev->chip->hfc_param_ini[rtwdev->hci.type].
 - Make param_ini a pointer instead of copying the struct.
---
 drivers/net/wireless/realtek/rtw89/core.h     |  4 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 29 +++++++++----------
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  2 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  2 +-
 8 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 46d3512afb57..cab28dc10b4e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -130,6 +130,8 @@ enum rtw89_hci_type {
 	RTW89_HCI_TYPE_PCIE,
 	RTW89_HCI_TYPE_USB,
 	RTW89_HCI_TYPE_SDIO,
+
+	RTW89_HCI_TYPE_NUM,
 };
 
 enum rtw89_hci_dle_type {
@@ -4355,7 +4357,7 @@ struct rtw89_chip_info {
 	u16 max_amsdu_limit;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
-	const struct rtw89_hfc_param_ini *hfc_param_ini;
+	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_TYPE_NUM];
 	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7d3e6448423a..d3814012a02e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -875,31 +875,30 @@ EXPORT_SYMBOL(rtw89_mac_set_err_status);
 
 static int hfc_reset_param(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_hfc_param_ini *param_ini, *param_inis;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
-	struct rtw89_hfc_param_ini param_ini = {NULL};
 	u8 qta_mode = rtwdev->mac.dle_info.qta_mode;
 
-	switch (rtwdev->hci.type) {
-	case RTW89_HCI_TYPE_PCIE:
-		param_ini = rtwdev->chip->hfc_param_ini[qta_mode];
-		param->en = 0;
-		break;
-	default:
+	param_inis = rtwdev->chip->hfc_param_ini[rtwdev->hci.type];
+	if (!param_inis)
 		return -EINVAL;
-	}
 
-	if (param_ini.pub_cfg)
-		param->pub_cfg = *param_ini.pub_cfg;
+	param_ini = &param_inis[qta_mode];
+
+	param->en = 0;
+
+	if (param_ini->pub_cfg)
+		param->pub_cfg = *param_ini->pub_cfg;
 
-	if (param_ini.prec_cfg)
-		param->prec_cfg = *param_ini.prec_cfg;
+	if (param_ini->prec_cfg)
+		param->prec_cfg = *param_ini->prec_cfg;
 
-	if (param_ini.ch_cfg)
-		param->ch_cfg = param_ini.ch_cfg;
+	if (param_ini->ch_cfg)
+		param->ch_cfg = param_ini->ch_cfg;
 
 	memset(&param->ch_info, 0, sizeof(param->ch_info));
 	memset(&param->pub_info, 0, sizeof(param->pub_info));
-	param->mode = param_ini.mode;
+	param->mode = param_ini->mode;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index bd777b0c3f4d..7872c58c37ec 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2465,7 +2465,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= rtw8851b_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8851b_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8851b_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 13fbc3a1b49e..222d271771be 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2184,7 +2184,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8852a_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8852a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b2989cdcce34..ce2df199307f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -820,7 +820,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.max_amsdu_limit	= 5000,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8852b_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 762a1fc005d2..8f79207bfcf0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -754,7 +754,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.max_amsdu_limit	= 5000,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852bt_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8852bt_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8852bt_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index c0d76d318b24..6f481f335484 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3004,7 +3004,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8852c_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 7854d6f30b6d..43efb6b4e9cb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2859,7 +2859,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
-	.hfc_param_ini		= rtw8922a_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8922a_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8922a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
-- 
2.49.0


