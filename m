Return-Path: <linux-wireless+bounces-28951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F32F6C5B75C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D3914E98D7
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB2D2E8884;
	Fri, 14 Nov 2025 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JFUFSpTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CB2DC77A
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100150; cv=none; b=tN/Be8thnwDnsIHMFVE/VOJTwB8GsYKnwnZ/1vZsFfXVyoIaK0mIf3MZAA+eB7IgQKzP0FQla0/x7jKfuqBq+Ufj1C4FYoFovybZ/IE3nH0S0ql2VujbXxkn4A58yIlvQNTys9NisQvlJiNczosYuhZczdXAGKDl3fpxUvMZnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100150; c=relaxed/simple;
	bh=qyRBBqenEuFAgNnZ7YN6/ls/M6JFV8/m+YzaCRh7eQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bB03qt89Gg+ssHUItYwBVx6cnaiq9LRGoMwmMuiE7vAd7kPm4l+WKRqUUtY1qP/ojmIoL3OQBj78HUDaTFyGDMuZEP5NMXMMFM9TZa3o0j6z0oHPfSz/K6VPieQIgYTpzBuoyjcjH7q/ePFjnVlo8Be4x5NU4JEJCI1ec+CTtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JFUFSpTT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62PpK41037621, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100145; bh=RveRh49Wj6WkLkqwuG66UOou4iRL0rBoeuXFKtYMcJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JFUFSpTT1doJ84knKkVDnfvlefz9ZYZx4s5StJvLfgGGg0nQZO/bzFtZ7bEKYGfPW
	 gDeXR+uv6kWy7xnJXSViObo619USyrGzjponkAFcIJMq44IUVxVKuPXlWBNw+Qk5c5
	 /OQwiT0BOVIY+9j8O+i5hVqp++waAQ+QJk+YrgoIlKrssB8mvqx9JOJX/A3qUwcAUB
	 6334bJa1pEtlCmJ1ZZ118o7Clf949O3ezilE7/2XpVk6IqKDPzDz+wVG46KI9g/H2D
	 BprT5aRUyuQWa93EqrgN2TbSMWASEQIfQZJctbjy087TggRxjAgJ/7dNnPIqqu2Qgo
	 epwzXoVAAtQrg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62PpK41037621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:25 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 04/14] wifi: rtw89: phy: calling BB pre-init by chips with/without BB MCU
Date: Fri, 14 Nov 2025 14:01:18 +0800
Message-ID: <20251114060128.35363-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The existing flow is doing BB pre-init before downloading BB MCU firmware,
because existing chip RTL8922A has BB MCU. However, the coming chips don't
have this, and BB pre-init configuring registers can affect downloading
WiFi-CPU firmware. Therefore, calling BB pre-init afterward for new coming
chips without BB MCU.

For existing WiFi 6 chips, no BB pre-init. For RTL8922A, don't change
the logic.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/core.c |  4 ++++
 drivers/net/wireless/realtek/rtw89/core.h | 11 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac.c  |  9 ++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0cabea7dd92b..ea22925b8772 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5615,6 +5615,7 @@ EXPORT_SYMBOL(rtw89_check_quirks);
 
 int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
+	bool no_bbmcu = !rtwdev->chip->bbmcu_nr;
 	int ret;
 
 	ret = rtw89_mac_preinit(rtwdev);
@@ -5623,6 +5624,9 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	if (no_bbmcu)
+		rtw89_chip_bb_preinit(rtwdev);
+
 	rtw89_phy_init_bb_afe(rtwdev);
 
 	/* above do preinit before downloading firmware */
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f63857b389d7..8943166de52c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7039,12 +7039,17 @@ static inline void rtw89_chip_rfk_hw_init(struct rtw89_dev *rtwdev)
 }
 
 static inline
-void rtw89_chip_bb_preinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw89_chip_bb_preinit(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->ops->bb_preinit)
-		chip->ops->bb_preinit(rtwdev, phy_idx);
+	if (!chip->ops->bb_preinit)
+		return;
+
+	chip->ops->bb_preinit(rtwdev, RTW89_PHY_0);
+
+	if (rtwdev->dbcc_en)
+		chip->ops->bb_preinit(rtwdev, RTW89_PHY_1);
 }
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ff160d25a7c9..21f5023c4f69 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4104,9 +4104,12 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 
 	if (include_bb) {
-		rtw89_chip_bb_preinit(rtwdev, RTW89_PHY_0);
-		if (rtwdev->dbcc_en)
-			rtw89_chip_bb_preinit(rtwdev, RTW89_PHY_1);
+		/* Only call BB preinit including configuration of BB MCU for
+		 * the chips which need to download BB MCU firmware. Otherwise,
+		 * calling preinit later to prevent touching registers affecting
+		 * download firmware.
+		 */
+		rtw89_chip_bb_preinit(rtwdev);
 	}
 
 	ret = rtw89_mac_dmac_pre_init(rtwdev);
-- 
2.25.1


