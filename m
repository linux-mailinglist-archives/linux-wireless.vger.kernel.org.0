Return-Path: <linux-wireless+bounces-30151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D113CE5C67
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB8D30062C5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF0224F3;
	Mon, 29 Dec 2025 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mwYeQAEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220A204C36
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977807; cv=none; b=p7e57wWytdVGIFLvOrykpzqj3XACa63pJNAZQuyMw3ouU8YvSsqZZBWNizxaQhwea+j9Sk97evWSv/3yEjQdUIzzf1KkH7y8bpXiIeBlsf89plxVC2IYkAsdNi3wbDDCurg3w85raAEs+c6asbdlimpd5VPqNdyVNpNtjbnPnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977807; c=relaxed/simple;
	bh=epib8HfU7d1/Vh6gbXyyHGNFlk6mBvu8E8/hcSotFkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6QkswNgUEHhG+32bC4BDpHoVCNlZp6SyUkWVJqysR17ud17IvsA4gDVngDzqrwr6I/1bgSOhXci9j4asTpkp2E8lovscCZj/iRgo95Ilw75aPe/SMyO6A5DR+b1py2huOgUWnF9B7479Nqoobm14pzno121DFdK7gCd+L1iAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mwYeQAEG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT3A3h04282625, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977803; bh=SthFbXQU3rcdJdekpF1iWjuji4xawu9ajkRQfv8aScg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mwYeQAEGAUjpdkxeGjTjAlEeu+xlovWNYUrlKOrx4ox2DICoEFBLCciLtnHXRAVap
	 ROMZ2IXMTbioUTQKYe9ef9ZjznKm8NJZM4dA3ptqn7KblXRZ5/bNHCDOqRfycVbic5
	 bO2N1tePu/wMvDkSJPpOvag/6f/uDw9ta8Ku4uNnov1BPU1dPg8ypVIljVwvepP1/D
	 EONAemUVcXKqxOZ3gNA7UrKgadcKWJOf07P1f4FdWx1OckP+iRmQHAOrEM5xUoPkJX
	 s+Ahs5oRCmyUNWsKnzJhU9ZfFgOu7jP8MfU/a30CXBq7uhI4EltcbSSB7zNxwjwpdh
	 xLdnPgcHf30yA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT3A3h04282625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:10:03 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:03 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:03 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:10:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 04/12] wifi: rtw89: wow: abstract DMA check register for RTL8922DE
Date: Mon, 29 Dec 2025 11:09:18 +0800
Message-ID: <20251229030926.27004-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229030926.27004-1-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chin-Yen Lee <timlee@realtek.com>

The coming RTL8922DE use different register and its bit to poll if DMA
becomes idle before entering WoWLAN. Abstract to share common flow.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci_be.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index e4590879b800..95efb1094b6c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -184,10 +184,13 @@ static void rtw89_pci_clr_idx_all_be(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_poll_txdma_ch_idle_be(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 dma_busy1 = info->dma_busy1.addr;
+	u32 check = info->dma_busy1.mask;
 	u32 val;
 
-	return read_poll_timeout(rtw89_read32, val, (val & DMA_BUSY1_CHECK_BE) == 0,
-				 10, 1000, false, rtwdev, R_BE_HAXI_DMA_BUSY1);
+	return read_poll_timeout(rtw89_read32, val, (val & check) == 0,
+				 10, 1000, false, rtwdev, dma_busy1);
 }
 
 static int rtw89_pci_poll_rxdma_ch_idle_be(struct rtw89_dev *rtwdev)
-- 
2.25.1


