Return-Path: <linux-wireless+bounces-28882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA9C557EC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49BEB4E343E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D397253B73;
	Thu, 13 Nov 2025 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cAOeRpSU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09344257852
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002626; cv=none; b=Ry2SV1xg3HH9xedXhv9u/5hZGCYA6qL5dBZwwqCRulUoWC11XVUwLzDAZxAjGvttP2kpdzxI4CoC2q6awzsnEVfH4CPrEFNN6Iru9v9uucAMe2ztGEGq9otDNAVyRLgARZRPxZCVLnMq4m5aWYmtqNO+t65v9BoB3dwBYbmXj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002626; c=relaxed/simple;
	bh=kucoYfap6mlcO+hqBtjg3Ma59m2TCtEE87Kz8FDqpVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGlbfRx7prRuk6G6EOrE/pLLp36U7sdz92ha5zuY5eFQcLdx1UqATzOOgUV9fuGWngJ3P82SrxYhVJm1xh+7jxxg16qLJMfkaMollCRwaHwTibqN36Wmhj63EN54MzUNwrU4IVW7Ot68RUDaKuF6BRTGoT9J1Q3R1mFf4rZJWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cAOeRpSU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2v0zkD2839310, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002620; bh=jyIIGtZw9yzL7OXxvgv8rgrmc3K4gJZYPaaMPzAY/vU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cAOeRpSUAZ7DSATvsqT0cYyVGhDdZIwYcM2DCfwpbbz0vXIrPz8Ehn9SL617jyhDw
	 6VM1xJUSn5eCGr8kfJ8wid79PIjLrpex+CtOFxvK92MWGSP4noL2FHASCvjtb8R9S6
	 f/Fjy5G2gD9AgH9GdhHw+VOvyqM/D8QNe+46hFJtKOdlJyXcxDq2qQT8MVNfF6Bk6q
	 YCmOxV9c+cY9+p3XiMuNa4Ykb/XnTjeUuh7n8Mipzz5TqGnuP3pRnROjQnc0/WcIOJ
	 4EHsxke1VNKqYXL8Z4AtqAlsBvgtbO7cdreErRa65nCl5UACYXmF0+KCPYvBImWzPL
	 QEnXisR4X8Jag==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2v0zkD2839310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:57:00 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:00 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:57:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 01/14] wifi: rtw89: flush TX queue before deleting key
Date: Thu, 13 Nov 2025 10:56:07 +0800
Message-ID: <20251113025620.31086-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113025620.31086-1-pkshih@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

In the wpa_supplicant rekey flow, it sends an EAPOL packet 4/4 through
nl80211_tx_control_port() and triggers wake_tx_queue() in the driver.
Then, it sends nl80211_new_key() to configure a new key in mac80211.
However, in wake_tx_queue(), a workqueue is used to process the TX packet,
which might cause the driver to process the EAPOL packet later than
nl80211_new_key(). This results in the EAPOL packet 4/4 being transmitted
with the new key and IV, causing it to be dropped by the AP. Therefore,
needs to flush TX queue before deleting the old key to ensure that the
EAPOL 4/4 packet is transmitted using the old key.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 6f7571c7c274..4a7364432428 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -969,6 +969,7 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		}
 		break;
 	case DISABLE_KEY:
+		flush_work(&rtwdev->txq_work);
 		rtw89_hci_flush_queues(rtwdev, BIT(rtwdev->hw->queues) - 1,
 				       false);
 		rtw89_mac_flush_txq(rtwdev, BIT(rtwdev->hw->queues) - 1, false);
-- 
2.25.1


