Return-Path: <linux-wireless+bounces-25159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC8AFF809
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FB65A3FF3
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805619E7D1;
	Thu, 10 Jul 2025 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pIOKpxKM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115272F3E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121544; cv=none; b=DLzxtlefLCJDBe2OgKpLtD17KKN/w9cu3WxzXjAaoF+0RRi1xAx+2xMt4L1MCaMewDXLKx+NPA2YjuzBI42rEsakzfPnODvoH6F+nr132Olw8NLFLw+xLFAfakebE4SYEz2HSyKdLCYBrGAS0ao/V5cdUWV0sRis45aVYklmeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121544; c=relaxed/simple;
	bh=AzeNy7tSGI3MsYk+TEf5ji2LTqVkf9MqwbVFfqdAktU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Skw1xYhK0vReEyjX5USgggdipr4gQ5nwKMxqMlRMNxL59gnjiL6WSxnLayAkCeBJ/0+sN1bywtL035jSxazIIqsplDH46Km3dNjvlshmpfAC0vcFeitX3n1IRSxLxPkzRis76KKuX+9ZBtD3hWz0++9rvo3QTivQycxCMLKwBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pIOKpxKM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4PfM722455868, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121541; bh=xSxtsCLtjkq3kuOeQeB4DYKw1ZFlIa9cyxwTwGFO9ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pIOKpxKM5dYp/jBGBmdheULEzNRZgoXmvkcRYGU3EITlIvRZZBgNFe7pRcVDYkosQ
	 Vk1rvA2oOhACId2V9DVpSlqdz2mgCgv7mbB5bGxpuJGQ5QgRnwJq+HKtFP+vNC5ZK9
	 d8ZKOCzd+MqWScR5H7ddWWvNRe4OSloSErDPf23+jPnhIaY5qlJzz15vyFHkRQGwfx
	 krMMJGW/h7smoL7cr3w8jDMrPWFabO9iLFwP1IZIgoPwky28s5OFN2sQ+8N67HgQR6
	 vZOpPLpHOGHncx3L5pandcGO0KGSHQthttBEnyxg9qnHRJXnk0uLupyZN+agteewK8
	 SpQcePTtTcL0A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4PfM722455868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/14] wifi: rtw89: tweak tx wake notify matching condition
Date: Thu, 10 Jul 2025 12:24:19 +0800
Message-ID: <20250710042423.73617-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

8852BT needs to call TX wake notify once entering Leisure Power Save.
8852C needs to call TX wake notify after entering low power mode. Other
AX chips only MGMT packets needs to call TX wake after entering low power
mode. BE chips no need to call TX wake.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index da82a88cce98..57590f5577a3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -994,13 +994,25 @@ rtw89_core_tx_wake(struct rtw89_dev *rtwdev,
 	if (!RTW89_CHK_FW_FEATURE(TX_WAKE, &rtwdev->fw))
 		return;
 
-	if (!test_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
-		return;
+	switch (chip->chip_id) {
+	case RTL8852BT:
+		if (test_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
+			goto notify;
+		break;
+	case RTL8852C:
+		if (test_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
+			goto notify;
+		break;
+	default:
+		if (test_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags) &&
+		    tx_req->tx_type == RTW89_CORE_TX_TYPE_MGMT)
+			goto notify;
+		break;
+	}
 
-	if (chip->chip_id != RTL8852C &&
-	    tx_req->tx_type != RTW89_CORE_TX_TYPE_MGMT)
-		return;
+	return;
 
+notify:
 	rtw89_mac_notify_wake(rtwdev);
 }
 
-- 
2.25.1


