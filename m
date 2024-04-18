Return-Path: <linux-wireless+bounces-6542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585168AA53E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 00:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3431F21E98
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 22:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070019DF47;
	Thu, 18 Apr 2024 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSWxytiQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAF199EBD
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477762; cv=none; b=lPgKdNoWbMJODrSuX3+mx3DmhdVj92L3/ZFTETzRg4FCMABiEtTri2NH2TWZh8ieTvNdkcb7+ZjoF7LoMF/jz4VLGzqB5MwA37JBw05EeiDBdznfISi+ZBVZF6m3jhcrbMZlEhxEGF7T6pnLMtdIzO31oucdlRUTzvK22FVwSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477762; c=relaxed/simple;
	bh=AUS4GUa/eyU3v5BB4Tn9qBYrwByKBJUOjGzR1LjtoqE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BvrWqlYK4cUNQw4IVMw4hUrhMC8r8HUMP46wA/cNiNLgqUxFUk2Bz79D7q0MxVfCkTUL0sguwiLbTDJooOQGqr/B4jhyvs9XheU0s3Ws+Tggaes5tQvVn5MtR93moBzDeAIo+bir/aYsW8xbxrMtIeMZDZtkIlIexj+WtFW4HRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSWxytiQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so1311792a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477759; x=1714082559; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd6LP3ZQM+LufYB8qKxbCffUrLgE9kSOf27rHY5oThY=;
        b=JSWxytiQCTDeSxZ0KKNk5D+P9x1pLL6U4q2+L32/f5Nvvw0OV4ACJ9Qp0g+Jp8TzbQ
         fL87abZwA3W2BPN16ZBmoYc0lebuxlyS+tpiddQOuSDjkDASSKVb3qEhpeZ3EsgRbGI9
         DfR0zXS14hk9BXZ+mSAVPNOxao+OeAd95L3YToDduHjfzUMX+ViKj1ZAwYMdz/I6Z9Bg
         3AutyEfwRxLCYSbHG030eMtwwhTXWyvGdHKoIpSAnsYwp9xagG2/6FBWKSkPYvKESAuU
         qwb1smcXaCck6WjTIXDu2aQg6mS2zPebP9Yz0/Fi9Iq3IjSg83fMTen/zGx6KUCtNUT4
         H4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477759; x=1714082559;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gd6LP3ZQM+LufYB8qKxbCffUrLgE9kSOf27rHY5oThY=;
        b=puhf++uEnFbNXE/AGSRVMj9hYyVl4y9zByyQdz9cSJO558EvMU7Jpjl5XWBKU9GaU/
         DGE+stW+nCnMR7MhISxb4jG8GaYFYUdCIrs3XW2eZO1G7XrmqG0xa10pEkyH6khymGne
         rNrGrcvUcYDpFnCjxQKOxjm2vjer5IpN6z+OXbKAQnbGHd2kUCgLAHtdJw6Yr7eKLfE5
         8yqOl61CIr47VkR7NX18GSlIJDM6kYsgRE1+Ocv3MA3KOlYSf8NcDWDpaeuR/5zgp3mp
         UVGZnmcO1sEqac2ZWQmCy+Uv7ECmUyZnKTmMRn1h449pJ4IpLt20uWU8WoePThMVFyQt
         Pezw==
X-Gm-Message-State: AOJu0YwaMjWKW91ImNYJ3aEYzHVaYVgEBgMPxsw0KbYlq+fFLYBmHf+b
	AI0eWM41UZlJZzfJhWIvA+ceyGNzxdZA1n0bFw0nS+xq0Fs2wo5hC4quuTZR
X-Google-Smtp-Source: AGHT+IGIaUQWmSF5AxGQdkCtFEseFJg2Vbg2SXA2/vOWE0RHKPHc180WoLyPIg9sFfiqIBqWwYN/yw==
X-Received: by 2002:a50:871e:0:b0:56e:3774:749b with SMTP id i30-20020a50871e000000b0056e3774749bmr195643edb.42.1713477758798;
        Thu, 18 Apr 2024 15:02:38 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005704957a968sm1359989edb.13.2024.04.18.15.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 15:02:38 -0700 (PDT)
Message-ID: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
Date: Fri, 19 Apr 2024 01:02:37 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtl8xxxu: Add separate MAC init table for RTL8192CU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Until now RTL8192CU family was using the MAC init table from RTL8723AU,
but these tables are not identical in the two vendor drivers. Import
the correct table for RTL8192CU.

Also move the existing MAC init table to rtl8xxxu_8723a.c, which is
the only remaining user.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 -
 .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         | 28 ++++++++++++++++++-
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         | 27 +++++++++++++++++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 25 -----------------
 4 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index fd92d23c43d9..74a3ad18b4b3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -2022,7 +2022,6 @@ struct rtl8xxxu_fileops {
 
 extern int rtl8xxxu_debug;
 
-extern const struct rtl8xxxu_reg8val rtl8xxxu_gen1_mac_init_table[];
 extern const u32 rtl8xxxu_iqk_phy_iq_bb_reg[];
 u8 rtl8xxxu_read8(struct rtl8xxxu_priv *priv, u16 addr);
 u16 rtl8xxxu_read16(struct rtl8xxxu_priv *priv, u16 addr);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index 3ee7d8f87da6..e54978ca7171 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -77,6 +77,32 @@ static struct rtl8xxxu_power_base rtl8188r_power_base = {
 	.reg_0868 = 0x00020204,
 };
 
+static const struct rtl8xxxu_reg8val rtl8192cu_mac_init_table[] = {
+	{0x420, 0x80}, {0x423, 0x00}, {0x430, 0x00}, {0x431, 0x00},
+	{0x432, 0x00}, {0x433, 0x01}, {0x434, 0x04}, {0x435, 0x05},
+	{0x436, 0x06}, {0x437, 0x07}, {0x438, 0x00}, {0x439, 0x00},
+	{0x43a, 0x00}, {0x43b, 0x01}, {0x43c, 0x04}, {0x43d, 0x05},
+	{0x43e, 0x06}, {0x43f, 0x07}, {0x440, 0x5d}, {0x441, 0x01},
+	{0x442, 0x00}, {0x444, 0x15}, {0x445, 0xf0}, {0x446, 0x0f},
+	{0x447, 0x00}, {0x458, 0x41}, {0x459, 0xa8}, {0x45a, 0x72},
+	{0x45b, 0xb9}, {0x460, 0x66}, {0x461, 0x66}, {0x462, 0x08},
+	{0x463, 0x03}, {0x4c8, 0xff}, {0x4c9, 0x08}, {0x4cc, 0xff},
+	{0x4cd, 0xff}, {0x4ce, 0x01}, {0x500, 0x26}, {0x501, 0xa2},
+	{0x502, 0x2f}, {0x503, 0x00}, {0x504, 0x28}, {0x505, 0xa3},
+	{0x506, 0x5e}, {0x507, 0x00}, {0x508, 0x2b}, {0x509, 0xa4},
+	{0x50a, 0x5e}, {0x50b, 0x00}, {0x50c, 0x4f}, {0x50d, 0xa4},
+	{0x50e, 0x00}, {0x50f, 0x00}, {0x512, 0x1c}, {0x514, 0x0a},
+	{0x515, 0x10}, {0x516, 0x0a}, {0x517, 0x10}, {0x51a, 0x16},
+	{0x524, 0x0f}, {0x525, 0x4f}, {0x546, 0x40}, {0x547, 0x00},
+	{0x550, 0x10}, {0x551, 0x10}, {0x559, 0x02}, {0x55a, 0x02},
+	{0x55d, 0xff}, {0x605, 0x30}, {0x608, 0x0e}, {0x609, 0x2a},
+	{0x652, 0x20}, {0x652, 0x20}, {0x63c, 0x08}, {0x63d, 0x08},
+	{0x63e, 0x0c}, {0x63f, 0x0c}, {0x66e, 0x05}, {0x700, 0x21},
+	{0x701, 0x43}, {0x702, 0x65}, {0x703, 0x87}, {0x708, 0x21},
+	{0x709, 0x43}, {0x70a, 0x65}, {0x70b, 0x87},
+	{0xffff, 0xff},
+};
+
 static const struct rtl8xxxu_rfregval rtl8192cu_radioa_2t_init_table[] = {
 	{0x00, 0x00030159}, {0x01, 0x00031284},
 	{0x02, 0x00098000}, {0x03, 0x00018c63},
@@ -621,7 +647,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.trxff_boundary = 0x27ff,
 	.pbp_rx = PBP_PAGE_SIZE_128,
 	.pbp_tx = PBP_PAGE_SIZE_128,
-	.mactable = rtl8xxxu_gen1_mac_init_table,
+	.mactable = rtl8192cu_mac_init_table,
 	.total_page_num = TX_TOTAL_PAGE_NUM,
 	.page_num_hi = TX_PAGE_NUM_HI_PQ,
 	.page_num_lo = TX_PAGE_NUM_LO_PQ,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index ad1bb9377ca2..bf8c34af781f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -54,6 +54,31 @@ static struct rtl8xxxu_power_base rtl8723a_power_base = {
 	.reg_0868 = 0x02040608,
 };
 
+static const struct rtl8xxxu_reg8val rtl8723au_mac_init_table[] = {
+	{0x420, 0x80}, {0x423, 0x00}, {0x430, 0x00}, {0x431, 0x00},
+	{0x432, 0x00}, {0x433, 0x01}, {0x434, 0x04}, {0x435, 0x05},
+	{0x436, 0x06}, {0x437, 0x07}, {0x438, 0x00}, {0x439, 0x00},
+	{0x43a, 0x00}, {0x43b, 0x01}, {0x43c, 0x04}, {0x43d, 0x05},
+	{0x43e, 0x06}, {0x43f, 0x07}, {0x440, 0x5d}, {0x441, 0x01},
+	{0x442, 0x00}, {0x444, 0x15}, {0x445, 0xf0}, {0x446, 0x0f},
+	{0x447, 0x00}, {0x458, 0x41}, {0x459, 0xa8}, {0x45a, 0x72},
+	{0x45b, 0xb9}, {0x460, 0x66}, {0x461, 0x66}, {0x462, 0x08},
+	{0x463, 0x03}, {0x4c8, 0xff}, {0x4c9, 0x08}, {0x4cc, 0xff},
+	{0x4cd, 0xff}, {0x4ce, 0x01}, {0x500, 0x26}, {0x501, 0xa2},
+	{0x502, 0x2f}, {0x503, 0x00}, {0x504, 0x28}, {0x505, 0xa3},
+	{0x506, 0x5e}, {0x507, 0x00}, {0x508, 0x2b}, {0x509, 0xa4},
+	{0x50a, 0x5e}, {0x50b, 0x00}, {0x50c, 0x4f}, {0x50d, 0xa4},
+	{0x50e, 0x00}, {0x50f, 0x00}, {0x512, 0x1c}, {0x514, 0x0a},
+	{0x515, 0x10}, {0x516, 0x0a}, {0x517, 0x10}, {0x51a, 0x16},
+	{0x524, 0x0f}, {0x525, 0x4f}, {0x546, 0x40}, {0x547, 0x00},
+	{0x550, 0x10}, {0x551, 0x10}, {0x559, 0x02}, {0x55a, 0x02},
+	{0x55d, 0xff}, {0x605, 0x30}, {0x608, 0x0e}, {0x609, 0x2a},
+	{0x652, 0x20}, {0x63c, 0x0a}, {0x63d, 0x0a}, {0x63e, 0x0e},
+	{0x63f, 0x0e}, {0x66e, 0x05}, {0x700, 0x21}, {0x701, 0x43},
+	{0x702, 0x65}, {0x703, 0x87}, {0x708, 0x21}, {0x709, 0x43},
+	{0x70a, 0x65}, {0x70b, 0x87}, {0xffff, 0xff},
+};
+
 static const struct rtl8xxxu_rfregval rtl8723au_radioa_1t_init_table[] = {
 	{0x00, 0x00030159}, {0x01, 0x00031284},
 	{0x02, 0x00098000}, {0x03, 0x00039c63},
@@ -518,7 +543,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.trxff_boundary = 0x27ff,
 	.pbp_rx = PBP_PAGE_SIZE_128,
 	.pbp_tx = PBP_PAGE_SIZE_128,
-	.mactable = rtl8xxxu_gen1_mac_init_table,
+	.mactable = rtl8723au_mac_init_table,
 	.total_page_num = TX_TOTAL_PAGE_NUM,
 	.page_num_hi = TX_PAGE_NUM_HI_PQ,
 	.page_num_lo = TX_PAGE_NUM_LO_PQ,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fac7824ae727..82037a1f3dfc 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -132,31 +132,6 @@ static struct ieee80211_supported_band rtl8xxxu_supported_band = {
 	.n_bitrates = ARRAY_SIZE(rtl8xxxu_rates),
 };
 
-const struct rtl8xxxu_reg8val rtl8xxxu_gen1_mac_init_table[] = {
-	{0x420, 0x80}, {0x423, 0x00}, {0x430, 0x00}, {0x431, 0x00},
-	{0x432, 0x00}, {0x433, 0x01}, {0x434, 0x04}, {0x435, 0x05},
-	{0x436, 0x06}, {0x437, 0x07}, {0x438, 0x00}, {0x439, 0x00},
-	{0x43a, 0x00}, {0x43b, 0x01}, {0x43c, 0x04}, {0x43d, 0x05},
-	{0x43e, 0x06}, {0x43f, 0x07}, {0x440, 0x5d}, {0x441, 0x01},
-	{0x442, 0x00}, {0x444, 0x15}, {0x445, 0xf0}, {0x446, 0x0f},
-	{0x447, 0x00}, {0x458, 0x41}, {0x459, 0xa8}, {0x45a, 0x72},
-	{0x45b, 0xb9}, {0x460, 0x66}, {0x461, 0x66}, {0x462, 0x08},
-	{0x463, 0x03}, {0x4c8, 0xff}, {0x4c9, 0x08}, {0x4cc, 0xff},
-	{0x4cd, 0xff}, {0x4ce, 0x01}, {0x500, 0x26}, {0x501, 0xa2},
-	{0x502, 0x2f}, {0x503, 0x00}, {0x504, 0x28}, {0x505, 0xa3},
-	{0x506, 0x5e}, {0x507, 0x00}, {0x508, 0x2b}, {0x509, 0xa4},
-	{0x50a, 0x5e}, {0x50b, 0x00}, {0x50c, 0x4f}, {0x50d, 0xa4},
-	{0x50e, 0x00}, {0x50f, 0x00}, {0x512, 0x1c}, {0x514, 0x0a},
-	{0x515, 0x10}, {0x516, 0x0a}, {0x517, 0x10}, {0x51a, 0x16},
-	{0x524, 0x0f}, {0x525, 0x4f}, {0x546, 0x40}, {0x547, 0x00},
-	{0x550, 0x10}, {0x551, 0x10}, {0x559, 0x02}, {0x55a, 0x02},
-	{0x55d, 0xff}, {0x605, 0x30}, {0x608, 0x0e}, {0x609, 0x2a},
-	{0x652, 0x20}, {0x63c, 0x0a}, {0x63d, 0x0a}, {0x63e, 0x0e},
-	{0x63f, 0x0e}, {0x66e, 0x05}, {0x700, 0x21}, {0x701, 0x43},
-	{0x702, 0x65}, {0x703, 0x87}, {0x708, 0x21}, {0x709, 0x43},
-	{0x70a, 0x65}, {0x70b, 0x87}, {0xffff, 0xff},
-};
-
 static const struct rtl8xxxu_reg32val rtl8723a_phy_1t_init_table[] = {
 	{0x800, 0x80040000}, {0x804, 0x00000003},
 	{0x808, 0x0000fc00}, {0x80c, 0x0000000a},
-- 
2.44.0


