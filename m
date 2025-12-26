Return-Path: <linux-wireless+bounces-30121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CC5CDE5F6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 770BF3005097
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9F1E9919;
	Fri, 26 Dec 2025 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="W2hBK6L7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4B135A53
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729725; cv=none; b=TrTyXM+/Uihz5t+lI4/kGmaRG1t4jkG+K6e7hAjZkQ5Y8VDYX9hDllqIFDEqdClQOfAXrRsthvUhkYDebt6UD+vLlyN/UQTrcx9XzNhVfeE2ianK0a1Na3+rus4c1crn/jnL9g1jBOLEMzuPeQ1JV+idgVfW4zuYGOXr7PRbaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729725; c=relaxed/simple;
	bh=epib8HfU7d1/Vh6gbXyyHGNFlk6mBvu8E8/hcSotFkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFXs25Y2QgBugLP/I2vMjTjkfPa6+Dq3+Cp3h9jA2qpJ1r5xV+8zaI6ljQxBbkmQlJ3/Q+OwvmJseRIPv4ebybTisZ4+pMMpi7iB2/goC7YVqi857Z8dXTT58Is/R0n42attw+DeibPNhjd53xOQrC2ha+emonmXHpJMSNtWO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=W2hBK6L7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6FLo843113010, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729721; bh=SthFbXQU3rcdJdekpF1iWjuji4xawu9ajkRQfv8aScg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=W2hBK6L7+mZL5lucch0MQePL9XCVpmCSe82KXYKtteoX2+cQo9Ps88Ax5oKKXIfAX
	 wTqA9/pC4eHVqkMU2maH1RMec0yH7J2AhdXLrSHPbc5Gjl9U4pMhzXCN0HXbdd5Vmo
	 E8tHO7quoOFCxJDWr/mmS/AY3zVGHMYvpq1SrNbAIVooJUqYvrTdMXcG3mQGcrwWFl
	 iZ56XXOxg6xfdS8206ag7KuJELr/lZXGznGB176G8RjwIASUTmlm4j6Ljp5nbpEiF8
	 BK7VgpNlbijxlT15rpKphgIvhPOFybcbg1T4kuyfoSdbhlOq+SkdhwQFabc8hKsSfW
	 fJEINsfulPd/w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6FLo843113010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:15:21 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:21 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:15:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/12] wifi: rtw89: wow: abstract DMA check register for RTL8922DE
Date: Fri, 26 Dec 2025 14:14:38 +0800
Message-ID: <20251226061446.63514-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251226061446.63514-1-pkshih@realtek.com>
References: <20251226061446.63514-1-pkshih@realtek.com>
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


