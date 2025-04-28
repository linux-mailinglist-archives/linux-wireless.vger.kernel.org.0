Return-Path: <linux-wireless+bounces-22133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5308A9EEFF
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48A418891B0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4225E800;
	Mon, 28 Apr 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="u9Bv1SqD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9025D536
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839549; cv=none; b=oXMOo0Ym3Eu2x913O2ImjCjbF/6+gMDbplYSmhb3GgVUidRirrFbO2+kAAfSp/QsakZKUAk36iFMJPSXmVMdfyMqlXveVK2YAc25NqoizYs+Rgx2Ksk39fxkNZC372MrBJNJ7eDrkWzQqKc3jDrf9nQO6XuLs5CftsFQgZ0d0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839549; c=relaxed/simple;
	bh=QNHOpDsRXjGQvamQ5apUOlu6rCqKiTpQyU6P4sXHnPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocKFChRFJGHYaqAiq7+2ltD8wkSolFpMfQLDUL4uqzqT+upXSs+0Zb4gcyufT1YAefZMHQyq+7MKGqV5mog97SHjATgeqJ3Jpk1eHC8cK71rPS+mXsHQvXSmP0zmNWt/hualWLITfS3jSTVKusNtqPtufVbIvVl6OLkY4nOdhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=u9Bv1SqD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPjvM62101199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839545; bh=QNHOpDsRXjGQvamQ5apUOlu6rCqKiTpQyU6P4sXHnPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=u9Bv1SqDgt6UgZC2qwNxBixFzF33YpR8XB5jcgp0TyVGQTSF0INV+Wjp6cKVXuh7q
	 SAGm8QrEJAcFYccLadeT/Ygr+D+4tWhpJZLlYwu9rARKvdTtHZQAQmrOKB1Imeel/7
	 pV8G1p66D/KPfyoj9Q+wbOp6Guo9JNVQb4digZcqMgDN49+0BZzocL2RllkTtCC4Pb
	 uEqFGDow1fEaUWmEH+GdkwalsZa4Zow0pQQdU56j3ZWUTG3oz1pqZcx1i7EhpJbkaL
	 wsb8SgQEKOpQiGKGXif5F4FLDtm3uH7Zk6pYnQ4Sd2x+BVlFqK+tPfrATbeBmWnWZv
	 m3IBtt+ZWrDMg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPjvM62101199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:45 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/10] wifi: rtw89: Adjust management queue mapping for [MLO, HW-1]
Date: Mon, 28 Apr 2025 19:24:49 +0800
Message-ID: <20250428112456.13165-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428112456.13165-1-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Adjust mapping of management packets accordingly to send it on the
second hardware band. Previously only single band is used and we
plan to enable MLO, so the second band will be needed. Data packets
will be steered by hardware so no related changes are required.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  2 +-
 drivers/net/wireless/realtek/rtw89/txrx.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a6e67e22349e..93e7889eec96 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -673,7 +673,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb = tx_req->skb;
 	u8 qsel, ch_dma;
 
-	qsel = desc_info->hiq ? RTW89_TX_QSEL_B0_HI : RTW89_TX_QSEL_B0_MGMT;
+	qsel = rtw89_core_get_qsel_mgmt(rtwdev, tx_req);
 	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
 
 	desc_info->qsel = qsel;
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 70fe7cebc9d5..720c6b1bb254 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -712,6 +712,25 @@ static inline u8 rtw89_core_get_qsel(struct rtw89_dev *rtwdev, u8 tid)
 	}
 }
 
+static inline u8
+rtw89_core_get_qsel_mgmt(struct rtw89_dev *rtwdev, struct rtw89_core_tx_request *tx_req)
+{
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct rtw89_vif_link *rtwvif_link = tx_req->rtwvif_link;
+
+	if (desc_info->hiq) {
+		if (rtwvif_link->mac_idx == RTW89_MAC_1)
+			return RTW89_TX_QSEL_B1_HI;
+		else
+			return RTW89_TX_QSEL_B0_HI;
+	}
+
+	if (rtwvif_link->mac_idx == RTW89_MAC_1)
+		return RTW89_TX_QSEL_B1_MGMT;
+	else
+		return RTW89_TX_QSEL_B0_MGMT;
+}
+
 static inline u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
 {
 	switch (qsel) {
-- 
2.25.1


