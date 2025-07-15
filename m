Return-Path: <linux-wireless+bounces-25433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73042B04F86
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A0417EF2B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8B28D836;
	Tue, 15 Jul 2025 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cWCf2yXV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BD2D12E0
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551613; cv=none; b=bfxrc8HMTC4UGHSsPvb9ivZAiyKQPgP3BLv6Ek72X8Fpg8K+F3eZOY7/qkt2pORWd/mJUFFfrxLEWPMh0NyyXnwCa2M6guUR7t2+jjwLGHAPhg1Hd3KiZ8Fmmf2g0zhrd90cNP4emurvsG5lE0hFltfZPxYpQCDpk3SuP/YcgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551613; c=relaxed/simple;
	bh=siKLxzehvPQpRLUBhNHM4PtTO8Z9G3ARkCikYfpktzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEg6iy0N6qJrbBLGb/4W433NpE3ICW1D3oBeKXQ+S5r6LmOVjrlIwXWzKTg/VsZP/yFs3zdZGYPBXDnqH/HFsiWLoyV+runAmuRR965mn/4BqLGa5gu/GegnNESXOg+K9vzoIzfg+vLLXIbsW7QhB4gz7Pa+VQdCCW9tvu0cEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cWCf2yXV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F3rSZc93971437, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752551608; bh=57LzRvJnYsR6MNkms06a3OZjuP8zQT3BX9a7dXPhULA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cWCf2yXVUz8tjUnbEjzrr7AVLBcuC4aZCGJjZ2W4etmXqac6M5EWxZcO0kfmuloVG
	 pBk89JQVYzZAnGzDDeZf48NzBf8PtGHYwuT+FHtjBn5+xTmuHrRgA3I5seWfTjgXoJ
	 3ZHIZm+1b4+gyVVlx6AsJPx6Xjb7TldKBUMuiuXZxo2JYBap7MY2J4sZ8XmDkLwAoQ
	 GhzxG9JnoKgY37C/0SVwHWqHNXMXpNBOfujGs5+avx0HgWg/HRg92AB0rCMVutpnsC
	 0IdnovseD0OjH8yCqakEgkipZes4krudQ1G6NBadOkI/7Xm1v4MO7JD1q4LdeM3V00
	 2f5JjQTTnoFaQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F3rSZc93971437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 11:53:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 11:53:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 11:53:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 1/5] wifi: rtw89: trigger TX stuck if FIFO full
Date: Tue, 15 Jul 2025 11:52:55 +0800
Message-ID: <20250715035259.45061-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715035259.45061-1-pkshih@realtek.com>
References: <20250715035259.45061-1-pkshih@realtek.com>
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

From: Chia-Yuan Li <leo.li@realtek.com>

In order for the situation where the dispatcher blocking
causes HAXIDMA to be unable to TX to be reported as
a TX stuck, so that subsequent recovery can be handled.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 597de632e364..a669f2f843aa 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2638,6 +2638,10 @@ static void rtw89_pci_set_dbg(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev, R_AX_PCIE_DBG_CTRL,
 			  B_AX_ASFF_FULL_NO_STK | B_AX_EN_STUCK_DBG);
 
+	rtw89_write32_mask(rtwdev, R_AX_PCIE_EXP_CTRL,
+			   B_AX_EN_STUCK_DBG | B_AX_ASFF_FULL_NO_STK,
+			   B_AX_EN_STUCK_DBG);
+
 	if (rtwdev->chip->chip_id == RTL8852A)
 		rtw89_write32_set(rtwdev, R_AX_PCIE_EXP_CTRL,
 				  B_AX_EN_CHKDSC_NO_RX_STUCK);
-- 
2.25.1


