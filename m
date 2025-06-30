Return-Path: <linux-wireless+bounces-24676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F201AAEE86D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E93AF93B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181B2230BE4;
	Mon, 30 Jun 2025 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HujWIbXY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51E1E7C12
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316126; cv=none; b=ehNGpjVxX3soa2xwQD//E7PKnsNMlaTvgnhOwYQLb1Gafwt2YRTscoEC6lFQfCDPDUgqbQlxrXBTG/ghOgIyz9CeIBCz92z5C2HOIyEaWQCZfYeuqNj22AzwVoooR9Zt0cMNtGnEo2MSnggXyg2uyKVHGt6vuU1JvdNOA3KQAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316126; c=relaxed/simple;
	bh=G3p04gMpI0/HuIv1121GQawZDZGn8Hl5aQfmtwIGuAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h46na/lmKOmsYdxM5XZ6k8Eyue5ho9fPUhshP+Se6uFNBf86QPn7bonljcSrP8dQwbcVM/Z+ZemnR4zObZb1FgOpbEObTsjE6+KgC9G+vqujfB/RptRKScmKWaeqdRXU3/yju4MGee+i1gIwYcGcFpa6NpIpaH+22lXETENJnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HujWIbXY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so27775035e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316123; x=1751920923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6RmzGLOGoqxoiYLF8XGxQPgrb4yutL5GrfoFW3evEsQ=;
        b=HujWIbXYuGpWfXrjRs97oFQtDfJucvQ0KB4qlkb98vZwoVQPyvLAS1iiml5rlUQ8oi
         UO8v+6i5pFR0+iIATiZfngPj6wqhVp08GZEvzXlMVqSe4Q5T1RrXSCPaZN4R8lOaHDNY
         nXhRA6Qnp1bnGGmpqST4U5nEgdquJYtbQWfYuOeB8QkXwKMaMVXkAdtPj79zZeqN3PF7
         cWnnRqCVeBUU8Wg1yBAdl+45rRl+R+d17tP6DVrzvUoB8byP5oZbUJqiZ/GSVubmMQf6
         K7vOG+SEXkKuYQaiB7Fd5mdzn3fDgXGED75YthOcQa4BsMeIcZtyvzrUjsmFbu/HJusg
         LFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316123; x=1751920923;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RmzGLOGoqxoiYLF8XGxQPgrb4yutL5GrfoFW3evEsQ=;
        b=jUE9+LRi2f3x8i1FhA+9ZtKTEmKznnMhRKC+3/oEWuUOIHhzUqtpBOlfOdO1zqO9xW
         XOyKLCNJZ+IuDjx4aN1+sw8eDmWGmChRJ61TQz6flw/+PfytkwQ3MtRBQbBHrIEWVVB1
         J8Ec2impescTc45IrqZrGN0D2QOkQ+SYAb4IGqd6Pe+S2LdTEMLh3bFng4V1NSfn4/g+
         oq9Z2zCbcNBm07vAwHWgXsFzzszoWQC8k6c0rpaDUrA/nNVyOC/AB1yZX8UF7grrLyGz
         hfDMAYApcZFP3MympkvuXR2xVlyRs/JE+tuazOijfIPrqhWZWirC0rVDLvS7L4Fzgu7C
         uZ8A==
X-Gm-Message-State: AOJu0YxQKdKi7dQY0COF6RHZgELOaKYEHZfM3h4+1+rlEr2digcHTRvr
	jijeHCQsFhJ2b0Xwm2xf/gCQIs58Vz0Zg3OknaUmIyFy1EHPNED7k4zHJCRwAg==
X-Gm-Gg: ASbGnctKRvJKMdHsYVo/kKfEcmludueJ4IrW6+Zq1gXPgWuE6/ZrzVbqydHZhEsqNGv
	Q5Kc+Z/+rVfU3qmUthie7XWM9WFHk7Djh9d5l0EBV2KKrN+pgOUajV06JvUFG14iHV55eM9S3YI
	su6ipCkGaVv+cIaaplHasKfDczg5rn0gezy+v8vmZ/11skd9MMscd1uWoiURM9Mb2bIqXC6QaLu
	X2z3JoS2amrHGUWxY4RwVUg8lGfF/F2UdEJ/yWtFWFfC0fXirWqb4DXvAw+hR+cDCiZhfHuLB4O
	rnbTqcTA9IavyPLhn+Uk/VCPGYyG1TcRxyY1jc++FvR/6zSm43YSEv5ekuLlAu1G0VFaoA==
X-Google-Smtp-Source: AGHT+IGLkZeAGD01mZJxO/ieQ/u7Ft0NYbJ3vKRtELGdm9+U0Ad9L3AQAjWcU2pRsk0z2cpexEqbsg==
X-Received: by 2002:a05:600c:1e0d:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-4538edf0902mr176183295e9.0.1751316122738;
        Mon, 30 Jun 2025 13:42:02 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f74sm11290298f8f.3.2025.06.30.13.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:42:02 -0700 (PDT)
Message-ID: <1356f901-9ebf-451e-827f-50dd3efda534@gmail.com>
Date: Mon, 30 Jun 2025 23:42:01 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 03/14] wifi: rtw89: Make hfc_param_ini in
 rtw89_chip_info an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

USB and SDIO will need different sets of values, so make hfc_param_ini
in struct rtw89_chip_info an array.

Also make param_ini a pointer instead of copying the struct.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Make hfc_param_ini an array instead of having (eventually) three
   different hfc_param_ini_* members.

v3:
 - Add null check for rtwdev->chip->hfc_param_ini[rtwdev->hci.type].
 - Make param_ini a pointer instead of copying the struct.

v4:
 - Add Acked-by.
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
index 5771e195429f..b996afc77862 100644
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
@@ -4367,7 +4369,7 @@ struct rtw89_chip_info {
 	u16 max_amsdu_limit;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
-	const struct rtw89_hfc_param_ini *hfc_param_ini;
+	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_TYPE_NUM];
 	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8e7ce45207da..4432b03e8f7a 100644
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
index d4744defebe2..62147203993f 100644
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
index 8bf222bdb927..0496deb7278f 100644
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
index a6faae0d031a..b0b73a4a70a0 100644
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
index f536181bfb66..10d09c12f318 100644
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
index 67db480940b3..6e27f1ff94dc 100644
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
index 09dbe4008b89..e23655f3e4c1 100644
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


