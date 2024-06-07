Return-Path: <linux-wireless+bounces-8694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083739005D5
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970951F22B54
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0951953AA;
	Fri,  7 Jun 2024 14:02:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B15FC0A
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768934; cv=none; b=YvWteRiSH2GHEckvmovoKo/4jOZf8LCqx3+DkcgdWn9uUDsvQWFGDC38S/2Uz4AKyPn14erinCeL61tvG1MnNZSQrJOSGertKumGe99qaC5cia+4Q2RFaVE3CM9KWz3sfCAJ0KrflbAtmCX5SQyKvpLjfpW0WomXm/GYNVcI9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768934; c=relaxed/simple;
	bh=CCYeF1IU4NZbdQsZT3CnB9HzR8SgNaMN8HnMS12ZZjA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeAbQLZ4IYoTDeqD9kHLrtthhmL22gmPXr4vx7s7yJ3qtIO6yh7pn25pvCKLDhWcaxax8rhj6EcuVBBvRiqAuiYJN2aIxTKVjjWbN8ag/yWVim5GsJXwD0cnOIDYMEAI0a4tvJhMdOAT55AndxH/P08PYYhrbzipV8zhz5vRtII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 457E2A0Z04076724, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 457E2A0Z04076724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 7 Jun 2024 22:02:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 22:02:10 +0800
Received: from [127.0.1.1] (172.16.16.228) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 22:02:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: pci: fix RX tag race condition resulting in wrong RX length
Date: Fri, 7 Jun 2024 22:01:45 +0800
Message-ID: <20240607140145.8180-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607140145.8180-1-pkshih@realtek.com>
References: <20240607140145.8180-1-pkshih@realtek.com>
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

Read 32 bits RX info to a local variable to fix race condition between
reading RX length and RX tag.

Another solution is to get RX tag at first statement, but adopted solution
can save some memory read, and also save 15 bytes binary code.

RX tag, a sequence number, is used to ensure that RX data has been DMA to
memory completely, so driver must check sequence number is expected before
reading other data.

This potential problem happens only after enabling 36-bit DMA.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5e6df70513b3..b7d10a1b2d09 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -183,14 +183,17 @@ static void rtw89_pci_sync_skb_for_device(struct rtw89_dev *rtwdev,
 static void rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
 				       struct sk_buff *skb)
 {
-	struct rtw89_pci_rxbd_info *rxbd_info;
 	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
+	struct rtw89_pci_rxbd_info *rxbd_info;
+	__le32 info;
 
 	rxbd_info = (struct rtw89_pci_rxbd_info *)skb->data;
-	rx_info->fs = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_FS);
-	rx_info->ls = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_LS);
-	rx_info->len = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_WRITE_SIZE);
-	rx_info->tag = le32_get_bits(rxbd_info->dword, RTW89_PCI_RXBD_TAG);
+	info = rxbd_info->dword;
+
+	rx_info->fs = le32_get_bits(info, RTW89_PCI_RXBD_FS);
+	rx_info->ls = le32_get_bits(info, RTW89_PCI_RXBD_LS);
+	rx_info->len = le32_get_bits(info, RTW89_PCI_RXBD_WRITE_SIZE);
+	rx_info->tag = le32_get_bits(info, RTW89_PCI_RXBD_TAG);
 }
 
 static int rtw89_pci_validate_rx_tag(struct rtw89_dev *rtwdev,
-- 
2.25.1


