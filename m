Return-Path: <linux-wireless+bounces-13743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B10995C64
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C38C1C22036
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946166FC3;
	Wed,  9 Oct 2024 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XJGDfD0t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9A17736
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434603; cv=none; b=FmRRwliUb1GYpjSlmGvAjCr5azflyfGjJJ0OGl2YcRwIwuEZulCJsypdmhy3tWkIJ6/8coIc/eAgjMJ3rEDgQMG5WJLDcX6P7H7yez4SD10zFO48uDQn5yYtO32jhRqwgmEg09SaECXja4SuuBrQdGBA0NUUXmlrp03Hxa8JsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434603; c=relaxed/simple;
	bh=9MuJS3Zm1UE/dXuQZ06hU25X5eibJkVb7XGZGDMN9YE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb4/6feeULhW6MZXeF6yGn3o1GCkyBKS14rr4zM9Fpx7AnljCGfaoPgxZbkfkk8RkQkX6ivlnG7/5j5tv8y2VYiPxZtLjWYKuctP8hosYeCAcJx429IHjfhhkqnExZPHGRDFGcz3KFEoeVhVp8/O4AgGMctePjjfaqlPOhUPaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XJGDfD0t; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4990hJ0f94153173, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728434599; bh=9MuJS3Zm1UE/dXuQZ06hU25X5eibJkVb7XGZGDMN9YE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XJGDfD0tyjVMRP/2FN9LZfAX5tLvgCiYMNR5kGjWnyIeeGDF9daVS3j6Wbpa89BKp
	 4BUsth3usbjg6Y0JZ/RvA+8sfYxx/fKSD/WTGQM9AKmpZ115zEuVG4mUxrWL6sIJbz
	 Ql6IFCu5lKcjwKTFr8D/LHzAnDgcuJAN8lgxn3MRmWgr4V4656ZZbUn+86u1yrZR2L
	 4PtsWjwEwtLYy2QjO+GxsgAOiPPfxUpWlF8ShnzPLd/RXpCEMU7Q78K0N2jkj9RwIS
	 /GXyFEhlwyNfzmXSsslJJ6/M86Iys+z+/Tme+UXdEFk8rKaqEcqv2aIbZ1CN9ikWLw
	 z4vi/kDWxWLGw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4990hJ0f94153173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Oct 2024 08:43:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:43:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Oct
 2024 08:43:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: pci: use 'int' as return type of error code in poll_{tx,rx}dma_ch_idle()
Date: Wed, 9 Oct 2024 08:42:56 +0800
Message-ID: <20241009004300.8144-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009004300.8144-1-pkshih@realtek.com>
References: <20241009004300.8144-1-pkshih@realtek.com>
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

The return type of error code of read_poll_timeout() and
rtw89_pci_poll_{tx,rx}dma_ch_idle_ax() and must be 'int'.
Correct them accordingly.

Addresses-Coverity-ID: 1622341 ("Overflowed constant")
Addresses-Coverity-ID: 1627296 ("Overflowed constant")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5ed7eaa18c85..b0753dd2e54c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2671,9 +2671,10 @@ static void rtw89_pci_clr_idx_all_ax(struct rtw89_dev *rtwdev)
 static int rtw89_pci_poll_txdma_ch_idle_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
-	u32 ret, check, dma_busy;
 	u32 dma_busy1 = info->dma_busy1.addr;
 	u32 dma_busy2 = info->dma_busy2_reg;
+	u32 check, dma_busy;
+	int ret;
 
 	check = info->dma_busy1.mask;
 
@@ -2698,8 +2699,9 @@ static int rtw89_pci_poll_txdma_ch_idle_ax(struct rtw89_dev *rtwdev)
 static int rtw89_pci_poll_rxdma_ch_idle_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
-	u32 ret, check, dma_busy;
 	u32 dma_busy3 = info->dma_busy3_reg;
+	u32 check, dma_busy;
+	int ret;
 
 	check = B_AX_RXQ_BUSY | B_AX_RPQ_BUSY;
 
-- 
2.25.1


