Return-Path: <linux-wireless+bounces-9745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802691D5D9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 03:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B721F216BE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 01:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F912566;
	Mon,  1 Jul 2024 01:46:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD152913
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719798408; cv=none; b=Ov05NbMnWYNoZk23GZtVegTkQjshe7bDop6MiPJNgWVNchRUJsC/HFPWXraewBnILTubTaW9UIIyS/0OUCHc/CSt8V1GMZsvNg1dYert3Z6jjvR2P18pwduJ08ZFv4462LdYGg/Vny+YLqpFG35lqk/6vwYaE+FfB+B0Uja3Rbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719798408; c=relaxed/simple;
	bh=ZF++R5gaQrpZBUzJjbELE2gHUaaTH1tlMazAxGRBWwE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEuiixB0uiMhzY4nHW8VBLNP2F6Mx1Nc+4aMUdqv48qYoo4XkSsrkvDcMojUhxatfY0kcK/QrAWLUTJxjs3rUTFevdxVMObJ981mrBe0a0+Bk02QaSF5PStzGg/HybGxmbVkAtdRteiWgBwBZ9XE+PuOThm7KH/qws99TrwZiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4611kgboF3206232, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4611kgboF3206232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jul 2024 09:46:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 09:46:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Jul
 2024 09:46:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: 8852bx: add extra handles of BTC for 8852BT in 8852b_common
Date: Mon, 1 Jul 2024 09:46:19 +0800
Message-ID: <20240701014619.7300-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701014619.7300-1-pkshih@realtek.com>
References: <20240701014619.7300-1-pkshih@realtek.com>
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

For 8852BT, the initial settings of BT-coexistence is a little bit
different, so add the extra handles.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index f183dce16398..1745c2882acf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -1793,6 +1793,11 @@ static void __rtw8852bx_btc_init_cfg(struct rtw89_dev *rtwdev)
 		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_TX_GROUP, 0x5ff);
 	}
 
+	if (rtwdev->chip->chip_id == RTL8852BT) {
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_RX_GROUP, 0x5df);
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_RX_GROUP, 0x5df);
+	}
+
 	/* set PTA break table */
 	rtw89_write32(rtwdev, R_BTC_BREAK_TABLE, BTC_BREAK_PARAM);
 
-- 
2.25.1


