Return-Path: <linux-wireless+bounces-22405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA513AA8942
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864AE1893831
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125F1DF42;
	Sun,  4 May 2025 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap0XIhtt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D0C2FD
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391781; cv=none; b=RS2gKNxJs7PPtqcMdQpQIz/YeWja5yOs037zg+UnO5WNXFYKgIVfBTjNC/SnvOrsilH1N+LYjkVXs2mbouYwuyJPg5+P/OgT2iH6PFIcVC4qvLrSjEbspylcFMaTNbRq6WyJBEmX5qbK55qey9qndHUCeqat9rbFTJryOC/PEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391781; c=relaxed/simple;
	bh=w0s/ALPGuX8kC+Cz0prWkLGNyrFfofU/WZnwPRbRcWA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e8SwAql6YpXJSxKNzjsDbf7gpFS9JkdQTCP/vjfqa1fxEZGXQ4xUA9X8kV6OXdEiRzYPk1FLbaDXUTCXVequpJkLGOx5oEQpXwFoImcHdPd2hrqJ/HRPxSX7ru8T4wkq4MG/KQ+c5kZGyL1rhn8MyowmTLgaISW4zRuViAlwLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ap0XIhtt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so695991366b.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391777; x=1746996577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbu1KsHXRrM2HKqvYKEjG/LOYnI8QfLra6c92LT8h5A=;
        b=Ap0XIhttNJXt7cxfrle5BxCwiYJT0zt7rt2bdfYWyw3MKzKkGJt3JsoToDPnsIP0PC
         x6WAvb0c6whYQ228GaT4FdE3/lgy04NsV6CxqHzjctpORmWe8Zc4li+ht5Nk3fBV+DQk
         Q9GPM7lAAVS7Za7pccxRQwRwksahKM1pWO2I+tfGnUsP8Vqin8e5pVg1+rputOM/s4QG
         HoR6Fr1rOi/btbqS4mn2jZ8oZw1ofAKZwu2IgZZf2blc7nHmrdzZpGFjUEy+e03TbcF5
         Xl3G8oI5GXwLSMyf84EvboMBrI4t2nX9LbyNPuNulR6njRgvsLH1Vs8InWoMGvR1Q8Gu
         NvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391777; x=1746996577;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbu1KsHXRrM2HKqvYKEjG/LOYnI8QfLra6c92LT8h5A=;
        b=eq0HnoPreVDiqnYWdk8QoYcGqsfdt7HCiYGQAVF0Wx5JN4YlkGWavKfHk7U8V2RTk6
         I1Ec9H/bcUHjxpFa/KI8Mv4iAQgvEETf3mkOJbRy0EKp5ESou5lAAKGm+SZ2obGBugwh
         PKNl6bB8E2Y/pNbbeAbYhi8brz5OnxdBvKQjkqkBbyLwTsZws4+JcsqPqgbCj8Z9dPyA
         RdVregUWGK6k4b1ZHGYvDO/FQgDEAqUisplBpnsmNKJwkqbu1oQYgCAtxea69VveZ9k5
         rOSqjz+thxVkQ9gJy9hwLRXpIICi6yvMkZVFhu68NAkOVzg7uSZhUBf9kuo5KqsHpCSc
         W2bA==
X-Gm-Message-State: AOJu0YwKJXw7LzhGRpACG5qUUFf541Lq2Lj8sI6Ds1iyqrmiTVbmDYus
	ge02BhckrA1nc3Nr/Sq1bM9u61kmgzancJPbUhym8lO31U9dYpxfqf/XTQ==
X-Gm-Gg: ASbGncuua7n8MgqSIG+xYvZSIv8wtkneqtE2LpItfPy6v+gw+5e4o8nJXUaH84F+Y9a
	XapTUGSg00zLXr7aH8XLGJnbhavQMNLWbfYOxqX9AR/LQ5c41p1qB7KjMth11jFpAeLqH/1qJ+6
	e07mtXMZ2rm66RDDP4DMBLF0yreLWR4dIZC4PApf52FAulRzicFe+nbLLiRnkcn5yEg8N7t4XYh
	eXXL96KCkbYOeMo1AcseHCh6v4pjascgIz4NhYZoFkEJ56e1u6O734aKlUWh7B0PR48kJMsXabm
	9QCmRcEnMbS91y4LpyXZTmLQaDChKK9fcWHl4H/v6NV0XSrRbg==
X-Google-Smtp-Source: AGHT+IHLINGEkhCaIOsm56dxgVOh0tufv4RP3xU717K+7efqvAMgvnw1IJpNUgQq30XjA0iF6+zJtQ==
X-Received: by 2002:a17:906:ef09:b0:ac3:991:a631 with SMTP id a640c23a62f3a-ad1906a0050mr689485866b.34.1746391777143;
        Sun, 04 May 2025 13:49:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894c0381sm375222566b.98.2025.05.04.13.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:49:36 -0700 (PDT)
Message-ID: <594d5987-5e6d-405c-b482-d101b43cb65c@gmail.com>
Date: Sun, 4 May 2025 23:49:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 02/13] wifi: rtw89: Get dle_mem via
 rtw89_hci_dle_mem()
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Don't access dle_mem in get_dle_mem_cfg() directly. USB 2, USB 3, and
SDIO will need different sets of values.

Rename dle_mem in struct rtw89_chip_info to dle_mem_pcie and get it
via rtw89_hci_dle_mem() and rtw89_pci_ops_dle_mem().

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.h      | 10 +++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c       |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.c       |  8 ++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  |  2 +-
 9 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index be1259cfa712..afcf0353a625 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3579,6 +3579,8 @@ struct rtw89_hci_ops {
 	void (*disable_intr)(struct rtw89_dev *rtwdev);
 	void (*enable_intr)(struct rtw89_dev *rtwdev);
 	int (*rst_bdram)(struct rtw89_dev *rtwdev);
+	const struct rtw89_dle_mem *(*dle_mem)(struct rtw89_dev *rtwdev,
+					       u8 qta_mode);
 };
 
 struct rtw89_hci_info {
@@ -4271,7 +4273,7 @@ struct rtw89_chip_info {
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
-	const struct rtw89_dle_mem *dle_mem;
+	const struct rtw89_dle_mem *dle_mem_pcie;
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
@@ -6146,6 +6148,12 @@ static inline void rtw89_hci_clear(struct rtw89_dev *rtwdev, struct pci_dev *pde
 		rtwdev->hci.ops->clear(rtwdev, pdev);
 }
 
+static inline const
+struct rtw89_dle_mem *rtw89_hci_dle_mem(struct rtw89_dev *rtwdev, u8 qta_mode)
+{
+	return rtwdev->hci.ops->dle_mem(rtwdev, qta_mode);
+}
+
 static inline
 struct rtw89_tx_skb_data *RTW89_TX_SKB_CB(struct sk_buff *skb)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 592fbb6d2728..77d35db3e133 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1719,7 +1719,7 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 	struct rtw89_mac_info *mac = &rtwdev->mac;
 	const struct rtw89_dle_mem *cfg;
 
-	cfg = &rtwdev->chip->dle_mem[mode];
+	cfg = rtw89_hci_dle_mem(rtwdev, mode);
 	if (!cfg)
 		return NULL;
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c2fe5a898dc7..1dec603012ba 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4341,6 +4341,13 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(rtw89_pm_ops, rtw89_pci_suspend, rtw89_pci_resume);
 EXPORT_SYMBOL(rtw89_pm_ops);
 
+static const
+struct rtw89_dle_mem *rtw89_pci_ops_dle_mem(struct rtw89_dev *rtwdev,
+					    u8 qta_mode)
+{
+	return &rtwdev->chip->dle_mem_pcie[qta_mode];
+}
+
 const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.isr_rdu = B_AX_RDU_INT,
 	.isr_halt_c2h = B_AX_HALT_C2H_INT_EN,
@@ -4413,6 +4420,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.disable_intr	= rtw89_pci_disable_intr_lock,
 	.enable_intr	= rtw89_pci_enable_intr_lock,
 	.rst_bdram	= rtw89_pci_reset_bdram,
+	.dle_mem	= rtw89_pci_ops_dle_mem,
 };
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 8d774bd75edb..1295718b8fdc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2465,7 +2465,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8851b_hfc_param_ini_pcie,
-	.dle_mem		= rtw8851b_dle_mem_pcie,
+	.dle_mem_pcie		= rtw8851b_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 408c2f7b3eec..5e9e2fc09458 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2184,7 +2184,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852a_dle_mem_pcie,
+	.dle_mem_pcie		= rtw8852a_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index dec736a07c54..badaea9d4cb8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -820,7 +820,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852b_dle_mem_pcie,
+	.dle_mem_pcie		= rtw8852b_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 3aaf70e32652..74619361e29b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -754,7 +754,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852bt_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852bt_dle_mem_pcie,
+	.dle_mem_pcie		= rtw8852bt_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9a2235f28e24..8b049c3ace93 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3004,7 +3004,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
-	.dle_mem		= rtw8852c_dle_mem_pcie,
+	.dle_mem_pcie		= rtw8852c_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index cc595cae53f5..505f45595dc8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2816,7 +2816,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
 	.hfc_param_ini		= rtw8922a_hfc_param_ini_pcie,
-	.dle_mem		= rtw8922a_dle_mem_pcie,
+	.dle_mem_pcie		= rtw8922a_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
-- 
2.49.0


