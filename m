Return-Path: <linux-wireless+bounces-10585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D38293E915
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 21:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DB7B20CFA
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB1D5EE8D;
	Sun, 28 Jul 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghG35QM0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBDB669
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722195593; cv=none; b=olZ0GL5JAHsfL8s3H6MjTVal9Vp/PxoZdVGgYBlXBBaqcIVqUNiroPGzvXazn0KxYAOw3xgsxVOScWEkD1OVYwmOd8UUi4cWGv2r+jMfAg06kJwdCzx6Hb1MW/q7MjU/n7j0oSznu/W+vTGsOEO9Yguqpfn1fmY3r0PlRJfH32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722195593; c=relaxed/simple;
	bh=+JAFv01CnjZn5AkUsRdWkvzkrIYqK8bqd8QDBE0c4JM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uo+G6pj2z4+DlJZUKp3HWaXwXJd3oJx4UQ/yJvA6XftwmbOVw4g3SKU47jB/LJ4NsDM1WR8btdkcmuGpYnQlbdwf65lQ7zDF5Y2eK2AW3BdVtWCbAKGK/h7wHnGsjRxNR4nwuozzReCmy7U1YEtxJCASmSLRmiqYR7SXREEVIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghG35QM0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so4480769a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722195590; x=1722800390; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19gGTBP79wxMQ5kqQy6/0Rfl7hAFwTK3bj09bHEpIOY=;
        b=ghG35QM0LbzgscMJf/X1VMtgAn5MD5VzYjzgexcrhOPh0/OmKLDHeGAEj/6D8bsI6r
         1K0BIggVbgBK5tE4m+yrKP+SUwIISqXdbCHBFhOHdis7OyhnIOc7qXj19JHbCaogDF29
         bfdj6KIxWYwBMp8vyU4U0ZdtzKcSrpD6dhG1rb9bCEQdtAvoHJ5/311kctnlUX+RJlw1
         zgw0adVcI+SE9Kf3ZCrirh6KTavDU047qgU7mpkcXCRHuh9mkPf1YPilVpXQ858RnmIC
         InbG0dxdP0YqgvRVYEblp3nCsmDFG0y4oTy4r6TsorEfEekh6onL6DoC/6xanuYBoExC
         Ti8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722195590; x=1722800390;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=19gGTBP79wxMQ5kqQy6/0Rfl7hAFwTK3bj09bHEpIOY=;
        b=Avo54yp0SzA++Jgrhz0p+S7okaIhZuchUnNtU6vBcrWQAcQfMujcsKhCD61h3hQeNA
         wZoWjJaI2N87zH89kYaxn/1SjsxskVcc5wNsihEF09bA9JM4QVWzjwb0BrKVwLzCZBx2
         va1ea4e6alfMglcte+U2LQ2+USXIARNBxVc3zAd8lWWkumH8gwqCiIlaj4fhwRO104gh
         k2NPkQtgINTdWB88ITEasLdDaiObHo0KODw4tXsFrJCsAVnw57mQJ+24TM4Ti+fCWVdK
         L4JfUMixXbv+EfyMWAACW12B+dZ+XpocttUXIAeC2VC1/r1r3PeBdb5q9lb+mxvy7EDZ
         tZwg==
X-Gm-Message-State: AOJu0YxgRjdMd1UDYxAHtEbqXr9RNzd6dkHpTy8U6UOsU6OimXzgNilh
	kq9y0gK9XiPomlVDv4DD8XGxMFuZw7lDPHsGNNAsevh4KGjNlcQsTsbyFA==
X-Google-Smtp-Source: AGHT+IFRAgRhynVLBBcZcxGL1m2IdSmXHM9hflZ1tPtX/n4pAXlIRovL6Dw7Fg7hp3HyqtXs2ihjVg==
X-Received: by 2002:a50:d7d4:0:b0:5a1:a7cb:8f86 with SMTP id 4fb4d7f45d1cf-5b01d56798dmr3916960a12.0.1722195589383;
        Sun, 28 Jul 2024 12:39:49 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3ab8sm4713752a12.71.2024.07.28.12.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 12:39:49 -0700 (PDT)
Message-ID: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
Date: Sun, 28 Jul 2024 22:39:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/4] wifi: rtw88: Init RX burst length for
 8822cu/8822bu/8821cu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Init RX burst length according to the USB speed.

This is needed in order to make USB RX aggregation work.

Tested with RTL8811CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
I would mention in the commit message what BIT_DMA_BURST_CNT,
BIT_DMA_MODE, and BIT_DROP_DATA_EN are doing, but I don't know.
---
 drivers/net/wireless/realtek/rtw88/reg.h      |  8 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 22 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 22 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 22 +++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index e7b24465f549..788e450d30d2 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -322,6 +322,12 @@
 #define REG_RXDMA_DPR		0x028C
 #define REG_RXDMA_MODE		0x0290
 #define BIT_DMA_MODE		BIT(1)
+#define BIT_DMA_BURST_CNT	GENMASK(3, 2)
+#define BIT_DMA_BURST_SIZE	GENMASK(5, 4)
+#define BIT_DMA_BURST_SIZE_64	2
+#define BIT_DMA_BURST_SIZE_512	1
+#define BIT_DMA_BURST_SIZE_1024	0
+
 #define REG_RXPKTNUM		0x02B0
 
 #define REG_INT_MIG		0x0304
@@ -703,6 +709,8 @@
 
 #define REG_IGN_GNTBT4	0x4160
 
+#define REG_USB_USBSTAT	0xFE11
+
 #define RF_MODE		0x00
 #define RF_MODOPT	0x01
 #define RF_WLINT	0x01
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 526e8de77b3e..55b6fe874710 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -204,6 +204,25 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 	rtw8821c_phy_bf_init(rtwdev);
 }
 
+static void rtw8821cu_init_burst_pkt_len(struct rtw_dev *rtwdev)
+{
+	u8 rxdma, burst_size;
+
+	rxdma = BIT_DMA_BURST_CNT | BIT_DMA_MODE;
+
+	if (rtw_read8(rtwdev, REG_SYS_CFG2 + 3) == 0x20)
+		burst_size = BIT_DMA_BURST_SIZE_1024;
+	else if ((rtw_read8(rtwdev, REG_USB_USBSTAT) & 0x3) == 0x1)
+		burst_size = BIT_DMA_BURST_SIZE_512;
+	else
+		burst_size = BIT_DMA_BURST_SIZE_64;
+
+	u8p_replace_bits(&rxdma, burst_size, BIT_DMA_BURST_SIZE);
+
+	rtw_write8(rtwdev, REG_RXDMA_MODE, rxdma);
+	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
+}
+
 static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
 {
 	u32 value32;
@@ -261,6 +280,9 @@ static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
 	rtw_write32(rtwdev, REG_WMAC_OPTION_FUNCTION + 8, WLAN_MAC_OPT_FUNC2);
 	rtw_write8(rtwdev, REG_WMAC_OPTION_FUNCTION + 4, WLAN_MAC_OPT_NORM_FUNC1);
 
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB)
+		rtw8821cu_init_burst_pkt_len(rtwdev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 6edb17aea90e..0949eaa2b6c1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -237,6 +237,25 @@ static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 #define WLAN_NAV_CFG		(WLAN_RDG_NAV | (WLAN_TXOP_NAV << 16))
 #define WLAN_RX_TSF_CFG		(WLAN_CCK_RX_TSF | (WLAN_OFDM_RX_TSF) << 8)
 
+static void rtw8822bu_init_burst_pkt_len(struct rtw_dev *rtwdev)
+{
+	u8 rxdma, burst_size;
+
+	rxdma = BIT_DMA_BURST_CNT | BIT_DMA_MODE;
+
+	if (rtw_read8(rtwdev, REG_SYS_CFG2 + 3) == 0x20)
+		burst_size = BIT_DMA_BURST_SIZE_1024;
+	else if ((rtw_read8(rtwdev, REG_USB_USBSTAT) & 0x3) == 0x1)
+		burst_size = BIT_DMA_BURST_SIZE_512;
+	else
+		burst_size = BIT_DMA_BURST_SIZE_64;
+
+	u8p_replace_bits(&rxdma, burst_size, BIT_DMA_BURST_SIZE);
+
+	rtw_write8(rtwdev, REG_RXDMA_MODE, rxdma);
+	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
+}
+
 static int rtw8822b_mac_init(struct rtw_dev *rtwdev)
 {
 	u32 value32;
@@ -284,6 +303,9 @@ static int rtw8822b_mac_init(struct rtw_dev *rtwdev)
 	rtw_write8_set(rtwdev, REG_SND_PTCL_CTRL,
 		       BIT_DIS_CHK_VHTSIGB_CRC);
 
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB)
+		rtw8822bu_init_burst_pkt_len(rtwdev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index e265a35184ab..2a90a879196b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2001,6 +2001,25 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 #define MAC_CLK_SPEED	80 /* 80M */
 #define EFUSE_PCB_INFO_OFFSET	0xCA
 
+static void rtw8822cu_init_burst_pkt_len(struct rtw_dev *rtwdev)
+{
+	u8 rxdma, burst_size;
+
+	rxdma = BIT_DMA_BURST_CNT | BIT_DMA_MODE;
+
+	if (rtw_read8(rtwdev, REG_SYS_CFG2 + 3) == 0x20)
+		burst_size = BIT_DMA_BURST_SIZE_1024;
+	else if ((rtw_read8(rtwdev, REG_USB_USBSTAT) & 0x3) == 0x1)
+		burst_size = BIT_DMA_BURST_SIZE_512;
+	else
+		burst_size = BIT_DMA_BURST_SIZE_64;
+
+	u8p_replace_bits(&rxdma, burst_size, BIT_DMA_BURST_SIZE);
+
+	rtw_write8(rtwdev, REG_RXDMA_MODE, rxdma);
+	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
+}
+
 static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
 {
 	u8 value8;
@@ -2127,6 +2146,9 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
 	/* Interrupt migration configuration */
 	rtw_write32(rtwdev, REG_INT_MIG, WLAN_MAC_INT_MIG_CFG);
 
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB)
+		rtw8822cu_init_burst_pkt_len(rtwdev);
+
 	return 0;
 }
 
-- 
2.45.2


