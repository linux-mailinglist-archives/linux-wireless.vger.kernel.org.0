Return-Path: <linux-wireless+bounces-23893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4CBAD26AC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203753A39B3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48921C18C;
	Mon,  9 Jun 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtHcSgXI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0419258E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497071; cv=none; b=VqNv1WqlzFQGbYv6FVnv6itCyOXBdIj2UnByGdeLxqCcAjU9XIwpiM7L7UXvhHbbSK8VwBj0cnfUKut0vr/sU3GOV1X8R6TfF3a1SAHI0/zqS57uKA/3njhWjOwpc11oZ45Eem3ygc9WpNrR5x9SAcahNUcc/Um0RcsQycHZidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497071; c=relaxed/simple;
	bh=KeUlxThdDPFoAUHzXoAlw2RVzovoB0y0Co7OwKfL5pw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D+OvJTyjQiQwEhVA2fljVi9Nxxu9wKsTNkBbw0AH8tILUnz+c/on3O6JY8/0xxQLIEjzwFgrq2/OPiPPMHqEH2VDLyyl6+6RCGYewGk9JRhkFnN2Nkg1QJEfuVYZ/voCBPw2Ay8EFuh9umcn9KmgB5j7X0OkBJDcUMXnl3zfAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtHcSgXI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso2740328a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497068; x=1750101868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bJD0ShiKOFZd30x3smIXbCCfXQODHuqHjVs7p/ulQ8A=;
        b=JtHcSgXIPp993edQxoVJtPR9bbz/CdHJK7b03NNL0GXCb7Okj8VfXLDNeG/VMM4ObZ
         PkImMISevTJgQg+VlYK9Rh7PLuvGF59EqvWMCKpp+13lV6uxwxGGxXmjZ83qYxvew2Cz
         7NXRPNNaH9Yocly+1sU3w59bdqVUAH1qODFfrQk70GhXvFgGLmUDkjezsQaGlMKypFa7
         Cm1LWRdzaT3JHXOD3wH4nckyex8KR89WEwZj9UEOjZsKB7pBbnG2007KpAxlZ5uCcFhI
         GzXSju+Od+WGR/kgsfNTootlin747nLjmnwm65Ryu6EA0Y2bUNcpgKwm+L4YsIenHSOp
         kMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497068; x=1750101868;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJD0ShiKOFZd30x3smIXbCCfXQODHuqHjVs7p/ulQ8A=;
        b=sXOVGykzaAtqzLNfAo+8kLGynwGcy8Wi+3cNY7f738Fop+wqhOYsx4WzqcugdmAQ4w
         2PB9Jvpwxkk1g2hDFRQH09xp+amN7z06fHKHKHZK1uwMwqyGR+6aRJhPSQHan+slJNsI
         x+m95briWLrkOVjfDneeurXsVcItWcMh/x/W9i0EZL4NW1pTzzSGaPCi6DMJ+8lsYOwx
         PEbu79Lydo5UWlbngWx0Y+cLUua3D5zMeR35xpSJ9Al+tNY2ic+9azdEkw+0cGETEuM7
         J+4/xtOFNfY5/7rVWIgivAQRG7ZSJSW+gI05cnLIkZRnNOaCm6WJyWMCdh99szFfggAZ
         /pTg==
X-Gm-Message-State: AOJu0YwSwp6r26zFHqWRWS0rzv9fBqvEplvCtzTx0VQOr2ap24tXx1lx
	4BCjkuXBcyrCoQXQWwQBiufy71ff8SYc/XTjH8sUWEDcp6gknbwM893jbaU0Zw==
X-Gm-Gg: ASbGnct6nk+mMn7xcnkfe5SGcUORNZZxetCxM6z2s5QhO1nUJWX78hPkp6KVkUkb5f4
	qI87VB94Eac9pUONkVti5ww/nfOda16KABsF8yiULiB+/WL/z1jhBPNwnwJcKXABwbxCUeSHXTP
	n+TNj8/E2k5PTv+FSLZqUeva7ECLqfGK0mHANQU6BDls4+aVGACsyhxUvuYKFKPy1Im5faKjG9j
	cL5Rzvtu3vOl4yYgabJXuIrDPfPTnaoK8OvPzNMHlDKUZTC8hzJGPOxxVF3P/6LcIwY3zfK4ypw
	d6Gu1yfFqodwbRjXCQCA1fSyW1jnH+hZ08sNsGqjCWNQrmy9Ns2lksaGKTA=
X-Google-Smtp-Source: AGHT+IFRLcSjFZHBDcFtZ9/JHEjoKAVnvNi4HzEtQlPpGlqJ0wxICwtHQzIvHQdKIeKhAEv8jjYHwA==
X-Received: by 2002:a17:907:6d22:b0:ad5:78ca:2126 with SMTP id a640c23a62f3a-ade1aa109c2mr1346270066b.59.1749497068168;
        Mon, 09 Jun 2025 12:24:28 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c4c9sm600661666b.108.2025.06.09.12.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:24:27 -0700 (PDT)
Message-ID: <f8b2b59c-5da0-4287-8ff1-f24408fba4d8@gmail.com>
Date: Mon, 9 Jun 2025 22:24:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 02/14] wifi: rtw89: Make dle_mem in
 rtw89_chip_info an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

USB 2, USB 3, and SDIO will need different sets of values.

Add a new dle_type member in struct rtw89_hci_info and make dle_mem in
struct rtw89_chip_info an array to hold the four different sets of
values.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Make dle_mem an array instead of having (eventually) four different
   dle_mem_* members.
---
 drivers/net/wireless/realtek/rtw89/core.h      | 12 +++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c       |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.c       |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  |  2 +-
 9 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1c8f3b9b7c4c..12d5727abfe9 100644
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
@@ -3596,6 +3605,7 @@ struct rtw89_hci_ops {
 struct rtw89_hci_info {
 	const struct rtw89_hci_ops *ops;
 	enum rtw89_hci_type type;
+	enum rtw89_hci_dle_type dle_type;
 	u32 rpwm_addr;
 	u32 cpwm_addr;
 	bool paused;
@@ -4293,7 +4303,7 @@ struct rtw89_chip_info {
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
-	const struct rtw89_dle_mem *dle_mem;
+	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9f0e30e75009..2ee766e37322 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1719,7 +1719,7 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 	struct rtw89_mac_info *mac = &rtwdev->mac;
 	const struct rtw89_dle_mem *cfg;
 
-	cfg = &rtwdev->chip->dle_mem[mode];
+	cfg = &rtwdev->chip->dle_mem[rtwdev->hci.dle_type][mode];
 	if (!cfg)
 		return NULL;
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 064f6a940107..928cf82d3b36 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4449,6 +4449,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rtwdev->pci_info = info->bus.pci;
 	rtwdev->hci.ops = &rtw89_pci_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_PCIE;
+	rtwdev->hci.dle_type = RTW89_HCI_DLE_TYPE_PCIE;
 	rtwdev->hci.rpwm_addr = pci_info->rpwm_addr;
 	rtwdev->hci.cpwm_addr = pci_info->cpwm_addr;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c9fdf7e8e53c..f0755afb1fdc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2465,7 +2465,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8851b_hfc_param_ini_pcie,
-	.dle_mem		= rtw8851b_dle_mem_pcie,
+	.dle_mem		= {rtw8851b_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index cd5987fc52d7..7c631ccee8fc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2184,7 +2184,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852a_dle_mem_pcie,
+	.dle_mem		= {rtw8852a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index dacdb384de2c..a2dfdc541ce6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -820,7 +820,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852b_dle_mem_pcie,
+	.dle_mem		= {rtw8852b_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 289dce688d72..96800ccdedc6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -754,7 +754,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852bt_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852bt_dle_mem_pcie,
+	.dle_mem		= {rtw8852bt_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 2a6143a8d256..5210f2f9124b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3004,7 +3004,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852c_dle_mem_pcie,
+	.dle_mem		= {rtw8852c_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 1d0f6e7df497..0517f0d27a5c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2817,7 +2817,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
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


