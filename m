Return-Path: <linux-wireless+bounces-23826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C5AD0ED0
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 20:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682A116D0C6
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7489D1E2853;
	Sat,  7 Jun 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY7gG2NI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B32F3E
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749319200; cv=none; b=aEl0TThDae7rlA66WEZEryJbBelf/LXtuamwRpH2fywlX/AZPc7aXZhATcDWNAwmp7dWKXqcV8U/FnJf/dt6vuYZ6KC+gl0HBZGwApjI0FU4l7Al+AqXR7cFXN56Z5qI8zJQkXTbUfeTBljbQO5tyzQqiL7qzq2TBuJENMwz/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749319200; c=relaxed/simple;
	bh=2Ai/81jks0Pz6ydx0FgXxUjhFRZpcFT9l8WREgxf9BQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rWC+qZtIKzKo7vMwfs5XSOUKn1Ddt2GmFZ2a4wigDgi1HNc48tQtUuovDYagUOG47Qd5Z3ASv6OJyROCAT1QJYltV4KZV1QSZJjnWah4Gk2WuLhGFOfiJY/h4pvsLAyHjd3M+HdKa6uDlTLyJbha2CPP1mz3Uatd2inD4/JhsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY7gG2NI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad883afdf0cso594219366b.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749319196; x=1749923996; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KkpYqvDPQmTZ+eznOVxfk7aCfRmlcToQlSVRWYkTxw=;
        b=lY7gG2NIGUvhxIfHxQDq92tRjz2HkRZqwK3R1Q9kj1HuULZZ+0ELeN/WJ0Wc0jG2ai
         ZiMXW3Xtu5Wv5DzfLAY/QW3X1/B5OsYwHzZNrKDILLFN1JwEBG+f1SA22ij7BnWCjRih
         sSlFiP2hSRxP3WNL++Yc1rMbNzBFimqkkYHXc1YzlY3Ycy5qTyr1L0htS2iZuNWyXXLg
         P//CIawNpPNHS7Xl4SHwLv1/zvaF0QMIzpndsHtVdi68qKv8Kcxfna+1Fbzr2A0PvCMM
         wI0EVgdCzlefgg0nvK7SM170a5Psm7V4neNX8y7bNyDV9VkefDpVMKDCuyfGFOVHiIOJ
         AS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749319196; x=1749923996;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1KkpYqvDPQmTZ+eznOVxfk7aCfRmlcToQlSVRWYkTxw=;
        b=j4AZ+nTMocFPp3gnIY2W8ZdN9HOJo0vNLCpS78DgVSpdNfvGQUYGCUiUscczi9MInX
         ScfXP1nbbFE5fYd4VasOur9uveDds6agsQ/bFNOazAL2rqralDFNxnom9Znox5s1AgI1
         xTovPuuFEmPePbu929jZE3mc37BoMRo0/DuoNLSYg8UNW8pNSn99we70NYes3SBgYvt2
         cqm/FPkYlxpVe8DZnrb9UOSn352AUIl/CINebWG6JKJYtKZmMMXdxSaScZSolfX66qB/
         KWhvj4mNfV84oFj6cEIGIlE1EOYR968LEUK8bbgFA5/d5UXI89c3ZUN3fKdzMd1sgJAs
         XJxA==
X-Gm-Message-State: AOJu0Yyw1DMqEWXUhgk+LDFFWwibppkIM6a6/5G1DsYUDmOqlcXhTVWb
	pC/R4bWZ6tbTxOI+1h2qOIIa1MIOE6nLTM5m2sz+KX7z20+mtTqqaj1sVfiUkA==
X-Gm-Gg: ASbGncux2D3LeHeGAy4y+6ljLv0pNnGnD7A6RDJoFELW8w8Dkb4OTMnat9ghEpKKGcw
	MTgtm5avVTmi+msp/UPaGp7KDrDZxycWd9oi04j4b4zkwWIFZ4m9r3bz2FRsajDtgoPzh/bwySy
	+H3L5LVdfHUihk/dxSiAbBJWTrDWtkaff8FwZS2PFibUI4AwpXr3G/ZfNN6JrFKNaR4DTjjonT3
	sj4nJpOKmr/j0jwO2ZHNrXRSQuAplvCqJOIEQGrFsTKl2//eTjo1jrtO2gYVIu9jBBl5jRsvR5v
	OEP1df1Al8/6R1/wgM5n0z+PQ4tQy57lRzPnL5o6sOfS+uNrw8JXMFXcu9yfqiPgHVwZLA==
X-Google-Smtp-Source: AGHT+IFooWOnHJsnAKkHX/y/TTjg1U0kUu6/xsXDuHsq8oH1bS/toZ1+UEB0pIGD+Y/WHHuRfzeuNg==
X-Received: by 2002:a17:907:da3:b0:ad8:9909:20aa with SMTP id a640c23a62f3a-ade1ab0872emr731779666b.40.1749319196130;
        Sat, 07 Jun 2025 10:59:56 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7542bcsm301769966b.32.2025.06.07.10.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 10:59:55 -0700 (PDT)
Message-ID: <bfb1099c-db52-4b25-b111-17ab712e9404@gmail.com>
Date: Sat, 7 Jun 2025 20:59:53 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 1/2] wifi: rtw88: Rename the RTW_WCPU_11{AC,N} enums
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The RTW_WCPU_11AC and RTW_WCPU_11N enums are used to identify two
types of microcontrollers used in Realtek chips, but these names are
misleading. The "11AC" type was also used in 11n devices (e.g.
RTL8733BU, not supported by rtw88), and the "11N" type was also used
in 11ac devices (RTL8821AU, RTL8812AU).

Rename RTW_WCPU_11AC to RTW_WCPU_3081 and RTW_WCPU_11N to RTW_WCPU_8051.
(8051 is well known. It's less clear what 3081 is, but the out of tree
drivers use this name.)

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |  8 +++----
 drivers/net/wireless/realtek/rtw88/mac.c      | 22 +++++++++----------
 drivers/net/wireless/realtek/rtw88/main.c     |  2 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 12 +++++-----
 drivers/net/wireless/realtek/rtw88/pci.c      | 12 +++++-----
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c     |  8 +++----
 14 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 4fc78b882080..c68a9fff6808 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -521,7 +521,7 @@ rtw_fw_send_general_info(struct rtw_dev *rtwdev)
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 	u16 total_size = H2C_PKT_HDR_SIZE + 4;
 
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		return;
 
 	rtw_h2c_pkt_set_header(h2c_pkt, H2C_PKT_GENERAL_INFO);
@@ -544,7 +544,7 @@ rtw_fw_send_phydm_info(struct rtw_dev *rtwdev)
 	u16 total_size = H2C_PKT_HDR_SIZE + 8;
 	u8 fw_rf_type = 0;
 
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		return;
 
 	if (hal->rf_type == RF_1T1R)
@@ -1480,7 +1480,7 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 
 	bckp[2] = rtw_read8(rtwdev, REG_BCN_CTRL);
 
-	if (rtw_chip_wcpu_11n(rtwdev)) {
+	if (rtw_chip_wcpu_8051(rtwdev)) {
 		rtw_write32_set(rtwdev, REG_DWBCN0_CTRL, BIT_BCN_VALID);
 	} else {
 		pg_addr &= BIT_MASK_BCN_HEAD_1_V1;
@@ -1509,7 +1509,7 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 		goto restore;
 	}
 
-	if (rtw_chip_wcpu_11n(rtwdev)) {
+	if (rtw_chip_wcpu_8051(rtwdev)) {
 		bcn_valid_addr = REG_DWBCN0_CTRL;
 		bcn_valid_mask = BIT_BCN_VALID;
 	} else {
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index f66d1b302dc5..011b81c82f3b 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -41,7 +41,7 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	}
 	rtw_write32(rtwdev, REG_WMAC_TRXPTCL_CTL, value32);
 
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		return;
 
 	value32 = rtw_read32(rtwdev, REG_AFE_CTRL1) & ~(BIT_MAC_CLK_SEL);
@@ -67,7 +67,7 @@ static int rtw_mac_pre_system_cfg(struct rtw_dev *rtwdev)
 
 	rtw_write8(rtwdev, REG_RSV_CTRL, 0);
 
-	if (rtw_chip_wcpu_11n(rtwdev)) {
+	if (rtw_chip_wcpu_8051(rtwdev)) {
 		if (rtw_read32(rtwdev, REG_SYS_CFG1) & BIT_LDO)
 			rtw_write8(rtwdev, REG_LDO_SWR_CTRL, LDO_SEL);
 		else
@@ -278,7 +278,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	bool cur_pwr;
 	int ret;
 
-	if (rtw_chip_wcpu_11ac(rtwdev)) {
+	if (rtw_chip_wcpu_3081(rtwdev)) {
 		rpwm = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
 
 		/* Check FW still exist or not */
@@ -369,7 +369,7 @@ static int __rtw_mac_init_system_cfg_legacy(struct rtw_dev *rtwdev)
 
 static int rtw_mac_init_system_cfg(struct rtw_dev *rtwdev)
 {
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		return __rtw_mac_init_system_cfg_legacy(rtwdev);
 
 	return __rtw_mac_init_system_cfg(rtwdev);
@@ -981,7 +981,7 @@ static int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev,
 static
 int _rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 {
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		return __rtw_download_firmware_legacy(rtwdev, fw);
 
 	return __rtw_download_firmware(rtwdev, fw);
@@ -1122,7 +1122,7 @@ static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 
 	rtw_write8(rtwdev, REG_CR, 0);
 	rtw_write8(rtwdev, REG_CR, MAC_TRX_ENABLE);
-	if (rtw_chip_wcpu_11ac(rtwdev))
+	if (rtw_chip_wcpu_3081(rtwdev))
 		rtw_write32(rtwdev, REG_H2CQ_CSR, BIT_H2CQ_FULL);
 
 	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_SDIO) {
@@ -1145,7 +1145,7 @@ int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev)
 	/* config rsvd page num */
 	fifo->rsvd_drv_pg_num = chip->rsvd_drv_pg_num;
 	fifo->txff_pg_num = chip->txff_size / chip->page_size;
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		fifo->rsvd_pg_num = fifo->rsvd_drv_pg_num;
 	else
 		fifo->rsvd_pg_num = fifo->rsvd_drv_pg_num +
@@ -1163,7 +1163,7 @@ int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev)
 	fifo->rsvd_boundary = fifo->txff_pg_num - fifo->rsvd_pg_num;
 
 	cur_pg_addr = fifo->txff_pg_num;
-	if (rtw_chip_wcpu_11ac(rtwdev)) {
+	if (rtw_chip_wcpu_3081(rtwdev)) {
 		cur_pg_addr -= csi_buf_pg_num;
 		fifo->rsvd_csibuf_addr = cur_pg_addr;
 		cur_pg_addr -= RSVD_PG_FW_TXBUF_NUM;
@@ -1292,7 +1292,7 @@ static int priority_queue_cfg(struct rtw_dev *rtwdev)
 
 	pubq_num = fifo->acq_pg_num - pg_tbl->hq_num - pg_tbl->lq_num -
 		   pg_tbl->nq_num - pg_tbl->exq_num - pg_tbl->gapq_num;
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		return __priority_queue_cfg_legacy(rtwdev, pg_tbl, pubq_num);
 	else
 		return __priority_queue_cfg(rtwdev, pg_tbl, pubq_num);
@@ -1308,7 +1308,7 @@ static int init_h2c(struct rtw_dev *rtwdev)
 	u32 h2cq_free;
 	u32 wp, rp;
 
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		return 0;
 
 	h2cq_addr = fifo->rsvd_h2cq_addr << TX_PAGE_SIZE_SHIFT;
@@ -1375,7 +1375,7 @@ static int rtw_drv_info_cfg(struct rtw_dev *rtwdev)
 	u8 value8;
 
 	rtw_write8(rtwdev, REG_RX_DRVINFO_SZ, PHY_STATUS_SIZE);
-	if (rtw_chip_wcpu_11ac(rtwdev)) {
+	if (rtw_chip_wcpu_3081(rtwdev)) {
 		value8 = rtw_read8(rtwdev, REG_TRXFF_BNDY + 1);
 		value8 &= 0xF0;
 		/* For rxdesc len = 0 issue */
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c4de5d114eda..88ff3edeaf47 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1765,7 +1765,7 @@ static void __update_firmware_info_legacy(struct rtw_dev *rtwdev,
 static void update_firmware_info(struct rtw_dev *rtwdev,
 				 struct rtw_fw_state *fw)
 {
-	if (rtw_chip_wcpu_11n(rtwdev))
+	if (rtw_chip_wcpu_8051(rtwdev))
 		__update_firmware_info_legacy(rtwdev, fw);
 	else
 		__update_firmware_info(rtwdev, fw);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b0f1fabe9554..89b72d2a9f99 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1173,8 +1173,8 @@ struct rtw_pwr_track_tbl {
 };
 
 enum rtw_wlan_cpu {
-	RTW_WCPU_11AC,
-	RTW_WCPU_11N,
+	RTW_WCPU_3081,
+	RTW_WCPU_8051,
 };
 
 enum rtw_fw_fifo_sel {
@@ -2166,14 +2166,14 @@ static inline void rtw_chip_efuse_grant_off(struct rtw_dev *rtwdev)
 		rtwdev->chip->ops->efuse_grant(rtwdev, false);
 }
 
-static inline bool rtw_chip_wcpu_11n(struct rtw_dev *rtwdev)
+static inline bool rtw_chip_wcpu_8051(struct rtw_dev *rtwdev)
 {
-	return rtwdev->chip->wlan_cpu == RTW_WCPU_11N;
+	return rtwdev->chip->wlan_cpu == RTW_WCPU_8051;
 }
 
-static inline bool rtw_chip_wcpu_11ac(struct rtw_dev *rtwdev)
+static inline bool rtw_chip_wcpu_3081(struct rtw_dev *rtwdev)
 {
-	return rtwdev->chip->wlan_cpu == RTW_WCPU_11AC;
+	return rtwdev->chip->wlan_cpu == RTW_WCPU_3081;
 }
 
 static inline bool rtw_chip_has_rx_ldpc(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 7f2b6dc21f56..a887b8993e47 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -405,7 +405,7 @@ static void rtw_pci_reset_buf_desc(struct rtw_dev *rtwdev)
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_BCN].r.dma;
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_BCNQ, dma);
 
-	if (!rtw_chip_wcpu_11n(rtwdev)) {
+	if (!rtw_chip_wcpu_8051(rtwdev)) {
 		len = rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.len;
 		dma = rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.dma;
 		rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.rp = 0;
@@ -467,7 +467,7 @@ static void rtw_pci_reset_buf_desc(struct rtw_dev *rtwdev)
 	rtw_write32(rtwdev, RTK_PCI_TXBD_RWPTR_CLR, 0xffffffff);
 
 	/* reset H2C Queue index in a single write */
-	if (rtw_chip_wcpu_11ac(rtwdev))
+	if (rtw_chip_wcpu_3081(rtwdev))
 		rtw_write32_set(rtwdev, RTK_PCI_TXBD_H2CQ_CSR,
 				BIT_CLR_H2CQ_HOST_IDX | BIT_CLR_H2CQ_HW_IDX);
 }
@@ -487,7 +487,7 @@ static void rtw_pci_enable_interrupt(struct rtw_dev *rtwdev,
 
 	rtw_write32(rtwdev, RTK_PCI_HIMR0, rtwpci->irq_mask[0] & ~imr0_unmask);
 	rtw_write32(rtwdev, RTK_PCI_HIMR1, rtwpci->irq_mask[1]);
-	if (rtw_chip_wcpu_11ac(rtwdev))
+	if (rtw_chip_wcpu_3081(rtwdev))
 		rtw_write32(rtwdev, RTK_PCI_HIMR3, rtwpci->irq_mask[3]);
 
 	rtwpci->irq_enabled = true;
@@ -507,7 +507,7 @@ static void rtw_pci_disable_interrupt(struct rtw_dev *rtwdev,
 
 	rtw_write32(rtwdev, RTK_PCI_HIMR0, 0);
 	rtw_write32(rtwdev, RTK_PCI_HIMR1, 0);
-	if (rtw_chip_wcpu_11ac(rtwdev))
+	if (rtw_chip_wcpu_3081(rtwdev))
 		rtw_write32(rtwdev, RTK_PCI_HIMR3, 0);
 
 	rtwpci->irq_enabled = false;
@@ -1125,7 +1125,7 @@ static void rtw_pci_irq_recognized(struct rtw_dev *rtwdev,
 
 	irq_status[0] = rtw_read32(rtwdev, RTK_PCI_HISR0);
 	irq_status[1] = rtw_read32(rtwdev, RTK_PCI_HISR1);
-	if (rtw_chip_wcpu_11ac(rtwdev))
+	if (rtw_chip_wcpu_3081(rtwdev))
 		irq_status[3] = rtw_read32(rtwdev, RTK_PCI_HISR3);
 	else
 		irq_status[3] = 0;
@@ -1134,7 +1134,7 @@ static void rtw_pci_irq_recognized(struct rtw_dev *rtwdev,
 	irq_status[3] &= rtwpci->irq_mask[3];
 	rtw_write32(rtwdev, RTK_PCI_HISR0, irq_status[0]);
 	rtw_write32(rtwdev, RTK_PCI_HISR1, irq_status[1]);
-	if (rtw_chip_wcpu_11ac(rtwdev))
+	if (rtw_chip_wcpu_3081(rtwdev))
 		rtw_write32(rtwdev, RTK_PCI_HISR3, irq_status[3]);
 
 	spin_unlock_irqrestore(&rtwpci->hwirq_lock, flags);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 9e6700c43a63..03475af973b5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1882,7 +1882,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.id = RTW_CHIP_TYPE_8703B,
 
 	.fw_name = "rtw88/rtw8703b_fw.bin",
-	.wlan_cpu = RTW_WCPU_11N,
+	.wlan_cpu = RTW_WCPU_8051,
 	.tx_pkt_desc_sz = 40,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 31876e708f9e..bf69f5b06ce2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2116,7 +2116,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.ops = &rtw8723d_ops,
 	.id = RTW_CHIP_TYPE_8723D,
 	.fw_name = "rtw88/rtw8723d_fw.bin",
-	.wlan_cpu = RTW_WCPU_11N,
+	.wlan_cpu = RTW_WCPU_8051,
 	.tx_pkt_desc_sz = 40,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index c2ef41767ff9..03b441639611 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -1038,7 +1038,7 @@ const struct rtw_chip_info rtw8812a_hw_spec = {
 	.ops = &rtw8812a_ops,
 	.id = RTW_CHIP_TYPE_8812A,
 	.fw_name = "rtw88/rtw8812a_fw.bin",
-	.wlan_cpu = RTW_WCPU_11N,
+	.wlan_cpu = RTW_WCPU_8051,
 	.tx_pkt_desc_sz = 40,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.c b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
index 44dd3090484b..4a1f850d05c8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
@@ -2180,7 +2180,7 @@ const struct rtw_chip_info rtw8814a_hw_spec = {
 	.ops = &rtw8814a_ops,
 	.id = RTW_CHIP_TYPE_8814A,
 	.fw_name = "rtw88/rtw8814a_fw.bin",
-	.wlan_cpu = RTW_WCPU_11AC,
+	.wlan_cpu = RTW_WCPU_3081,
 	.tx_pkt_desc_sz = 40,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index 413aec694c33..1d02ea400b2e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -1138,7 +1138,7 @@ const struct rtw_chip_info rtw8821a_hw_spec = {
 	.ops = &rtw8821a_ops,
 	.id = RTW_CHIP_TYPE_8821A,
 	.fw_name = "rtw88/rtw8821a_fw.bin",
-	.wlan_cpu = RTW_WCPU_11N,
+	.wlan_cpu = RTW_WCPU_8051,
 	.tx_pkt_desc_sz = 40,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 413130a30ca9..a2a358d6033f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1973,7 +1973,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.ops = &rtw8821c_ops,
 	.id = RTW_CHIP_TYPE_8821C,
 	.fw_name = "rtw88/rtw8821c_fw.bin",
-	.wlan_cpu = RTW_WCPU_11AC,
+	.wlan_cpu = RTW_WCPU_3081,
 	.tx_pkt_desc_sz = 48,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index ab199eaea3c7..9c31c859ccba 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2513,7 +2513,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
 	.fw_name = "rtw88/rtw8822b_fw.bin",
-	.wlan_cpu = RTW_WCPU_11AC,
+	.wlan_cpu = RTW_WCPU_3081,
 	.tx_pkt_desc_sz = 48,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 017d959de3ce..f813ce10172d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5332,7 +5332,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.ops = &rtw8822c_ops,
 	.id = RTW_CHIP_TYPE_8822C,
 	.fw_name = "rtw88/rtw8822c_fw.bin",
-	.wlan_cpu = RTW_WCPU_11AC,
+	.wlan_cpu = RTW_WCPU_3081,
 	.tx_pkt_desc_sz = 48,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e733ed846123..cc2d4fef3587 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -547,7 +547,7 @@ static int rtw_sdio_check_free_txpg(struct rtw_dev *rtwdev, u8 queue,
 {
 	unsigned int pages_free, pages_needed;
 
-	if (rtw_chip_wcpu_11n(rtwdev)) {
+	if (rtw_chip_wcpu_8051(rtwdev)) {
 		u32 free_txpg;
 
 		free_txpg = rtw_sdio_read32(rtwdev, REG_SDIO_FREE_TXPG);
@@ -1030,7 +1030,7 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 	u32 rx_len, hisr, total_rx_bytes = 0;
 
 	do {
-		if (rtw_chip_wcpu_11n(rtwdev))
+		if (rtw_chip_wcpu_8051(rtwdev))
 			rx_len = rtw_read16(rtwdev, REG_SDIO_RX0_REQ_LEN);
 		else
 			rx_len = rtw_read32(rtwdev, REG_SDIO_RX0_REQ_LEN);
@@ -1042,7 +1042,7 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 
 		total_rx_bytes += rx_len;
 
-		if (rtw_chip_wcpu_11n(rtwdev)) {
+		if (rtw_chip_wcpu_8051(rtwdev)) {
 			/* Stop if no more RX requests are pending, even if
 			 * rx_len could be greater than zero in the next
 			 * iteration. This is needed because the RX buffer may
@@ -1054,7 +1054,7 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 			 */
 			hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
 		} else {
-			/* RTW_WCPU_11AC chips have improved hardware or
+			/* RTW_WCPU_3081 chips have improved hardware or
 			 * firmware and can use rx_len unconditionally.
 			 */
 			hisr = REG_SDIO_HISR_RX_REQUEST;
-- 
2.49.0


