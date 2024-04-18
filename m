Return-Path: <linux-wireless+bounces-6482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF928A910F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E41F223F7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C264F1FE;
	Thu, 18 Apr 2024 02:12:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2E4F1FC
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406369; cv=none; b=IJziQ0oLP1cpRANCMUJo7CT+4MzPiv7eWgnZMbUs5rPJuPRS8TtXI9K6LAnhrnTSEvDlgSb5n9titYS4enz417VzgvSpctohHr7uyBYH3ozAiCJMiSdMf/dKy5mwN1Yx6fmBXvAS7gPxGAkyZRaYi+Kb+aPzR6Za+iIN0SwvvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406369; c=relaxed/simple;
	bh=7vNizCsworX1D0gpcxcpNp4vbBy3ujcEgFcCeJ7ylK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mf7eZmhkWmiwF0HeLAe9sxgevPm9RKTAyLTkhQV4TlRZiAE7eysTAafNjtrwc0TenjvrJe42AZTU3DtIBm5CXs0tnC7NwjblwGJWTPs6AQvLN23jtH3QJliiRusd47ShbpAsfnGXW0F4Cz+mNf6JIKCy/sYbR9rpmnXI/4AITiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2Cin563994725, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2Cin563994725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:12:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:12:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:12:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 4/9] wifi: rtw89: coex: Add PTA path control condition for chip RTL8922A
Date: Thu, 18 Apr 2024 10:12:02 +0800
Message-ID: <20240418021207.32173-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418021207.32173-1-pkshih@realtek.com>
References: <20240418021207.32173-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

PTA(packet traffic arbitration) is a coexistence hardware feature.
Wi-Fi & Bluetooth owns their PTA, the function is to show whose PTA
control the traffic now. RTL8922A PTA control is controlled by hardware
logic, there is no register to monitor the setting.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index aa5b396b5d2b..8b34044f7a8a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5705,7 +5705,7 @@ bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 val = 0;
 
-	if (chip->chip_id == RTL8852C)
+	if (chip->chip_id == RTL8852C || chip->chip_id == RTL8922A)
 		return false;
 	else if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
 		 chip->chip_id == RTL8851B)
-- 
2.25.1


