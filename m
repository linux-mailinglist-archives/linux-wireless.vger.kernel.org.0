Return-Path: <linux-wireless+bounces-22134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B1A9EF02
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4753A9A6B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3125D536;
	Mon, 28 Apr 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vjo948Nj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEA263F30
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839552; cv=none; b=bqfDdaz71d/nHZOFAR1u/ccYwZWGToy41UNfBuRa5UqCCuoGkzCmXIbQIspCKnb+4LSi53M51X+wdVdxWyMHu1KI+p4wdwAXzvfnIPlCgWszw92hly/uoNveSQpYVJdMhzFRLTvHH/mC5v7EB1CnP9345OhpjLO8GQ74tp322bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839552; c=relaxed/simple;
	bh=gF0PzaVVTFet+MJKjgGavped8gq+dF3DfQ1DMrxqmno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvurAQe64QA4MyczzOh5161N5rhsv0Cf9kmV3Kgd9auiD6ZTfBrCxR18SY5vjLmRG9ev+LZlWrDX2ncboQuyWrYPQV5FhQIIx6nFY664CZsADAWs8Mpf4j9vcbtbqPHon/9yX6Hc1RptMqVH3I67LinXRRLxBk/r/wVl5FiQBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vjo948Nj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPmDK22101206, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839548; bh=gF0PzaVVTFet+MJKjgGavped8gq+dF3DfQ1DMrxqmno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vjo948NjJsCqzYGrmeTPfiNjjAUGtUhigYfqtdztgg/Sl0oiL/oSV7eMKrJ69jtV0
	 7IniG3CNVc4Y+imUEobTtVA0u1LD/Zs8wHYHBY/EjewuVczEzhidnPzFoKQnyDGZ6d
	 oVmLqvfBWEgO31LW0D1AaW+/0Rg0vVQtO5b1//sqt8J2waz5uFb6iMjmD2Dc6WZQBR
	 mXpUZG7//5Ii+2QfNworJmz4kE3wA85WZ1g73pa3mKYjkRXBKM11Lr0eCgP6zgD2KD
	 WYqPf8S2bcAVIrgY0Ysm0iaK1p0xZIq+KouaW1+85jaU3iLMsZsdzqW/14+4yZzgV1
	 7HEiwGG2ySOZQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPmDK22101206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:48 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/10] wifi: rtw89: extend mapping from Qsel to DMA ch for MLO
Date: Mon, 28 Apr 2025 19:24:50 +0800
Message-ID: <20250428112456.13165-5-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

After impending MLO support, TX Qsel would come from other HW band rather
than HW-0. For example, when working on HW-1, TX release report may fill
QSEL_XX_1 and cause warning "Cannot map qsel to dma: ...". So, extend the
mapping to recognize multiple HW bands.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/txrx.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 720c6b1bb254..94f27a9ee9f7 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -738,12 +738,24 @@ static inline u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
 		rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n", qsel);
 		fallthrough;
 	case RTW89_TX_QSEL_BE_0:
+	case RTW89_TX_QSEL_BE_1:
+	case RTW89_TX_QSEL_BE_2:
+	case RTW89_TX_QSEL_BE_3:
 		return RTW89_TXCH_ACH0;
 	case RTW89_TX_QSEL_BK_0:
+	case RTW89_TX_QSEL_BK_1:
+	case RTW89_TX_QSEL_BK_2:
+	case RTW89_TX_QSEL_BK_3:
 		return RTW89_TXCH_ACH1;
 	case RTW89_TX_QSEL_VI_0:
+	case RTW89_TX_QSEL_VI_1:
+	case RTW89_TX_QSEL_VI_2:
+	case RTW89_TX_QSEL_VI_3:
 		return RTW89_TXCH_ACH2;
 	case RTW89_TX_QSEL_VO_0:
+	case RTW89_TX_QSEL_VO_1:
+	case RTW89_TX_QSEL_VO_2:
+	case RTW89_TX_QSEL_VO_3:
 		return RTW89_TXCH_ACH3;
 	case RTW89_TX_QSEL_B0_MGMT:
 		return RTW89_TXCH_CH8;
-- 
2.25.1


