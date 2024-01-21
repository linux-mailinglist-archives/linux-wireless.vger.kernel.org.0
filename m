Return-Path: <linux-wireless+bounces-2294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8B8354CE
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 08:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3244B28336A
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEA364A2;
	Sun, 21 Jan 2024 07:19:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F536134
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705821548; cv=none; b=odx7FuCuK4oQ+OD0KlnGInKGmOut2hhDCMxhSFz+yw6vuiAjuFHVjY+7z/GkyzGXpF7U7KfvCmyftk+duUFIND5h2ncZKRCu5MuaKEQJP6jzursAL9X/aZ8Xnece1t0z36IpU8PqSbzW+YRNnrFIdfE9T6XGrn7KpiDPAEGxB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705821548; c=relaxed/simple;
	bh=XJPnyNE2awKz9LU47PssoaGxUYSEr2fpwZNq/EGEaj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyEbI7G62mn9w75rzZg5UH0VaGMs13diCdLPvem2Y2Z8zi2UqGahKCfSDY0m8X3Nb+bf5OAd1WgQgbsgUcYlzKMQEJ3UXmVXe91gXuP4hmy6yq9S5IYqxIms42gEf4HWS2jHgHEENgVCeM835GjAbXrzhovrCibu4mmarLAyp4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40L7IxNS23102118, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40L7IxNS23102118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jan 2024 15:18:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sun, 21 Jan 2024 15:18:59 +0800
Received: from [127.0.1.1] (172.16.17.107) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 21 Jan
 2024 15:18:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: pci: interrupt v2 refine IMR for SER
Date: Sun, 21 Jan 2024 15:18:24 +0800
Message-ID: <20240121071826.10159-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121071826.10159-1-pkshih@realtek.com>
References: <20240121071826.10159-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

During SER (system error recovery), expect to deal with
only ISR related to halt. So, refine IMR configuration.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 9943ed856248..8227dc55e818 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -705,7 +705,7 @@ void rtw89_pci_recognize_intrs_v2(struct rtw89_dev *rtwdev,
 			      rtw89_read32(rtwdev, R_BE_HISR0) & rtwpci->halt_c2h_intrs : 0;
 	isrs->isrs[0] = isrs->ind_isrs & B_BE_HCI_AXIDMA_INT ?
 			rtw89_read32(rtwdev, R_BE_HAXI_HISR00) & rtwpci->intrs[0] : 0;
-	isrs->isrs[1] = rtw89_read32(rtwdev, R_BE_PCIE_DMA_ISR);
+	isrs->isrs[1] = rtw89_read32(rtwdev, R_BE_PCIE_DMA_ISR) & rtwpci->intrs[1];
 
 	if (isrs->halt_c2h_isrs)
 		rtw89_write32(rtwdev, R_BE_HISR0, isrs->halt_c2h_isrs);
@@ -3452,8 +3452,7 @@ static void rtw89_pci_recovery_intr_mask_v2(struct rtw89_dev *rtwdev)
 	rtwpci->ind_intrs = B_BE_HS0_IND_INT_EN0;
 	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
 	rtwpci->intrs[0] = 0;
-	rtwpci->intrs[1] = B_BE_PCIE_RX_RX0P2_IMR0_V1 |
-			   B_BE_PCIE_RX_RPQ0_IMR0_V1;
+	rtwpci->intrs[1] = 0;
 }
 
 static void rtw89_pci_default_intr_mask_v2(struct rtw89_dev *rtwdev)
-- 
2.25.1


