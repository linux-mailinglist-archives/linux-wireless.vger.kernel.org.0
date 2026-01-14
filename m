Return-Path: <linux-wireless+bounces-30803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368AD1BF8B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EA7F3008F4C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4B17A303;
	Wed, 14 Jan 2026 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wFusNDwk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1362874E1
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354882; cv=none; b=HnHw9EewOZQe2GYPOeklI9WTXi6hhDZdTcu3tmyJ1pipaZcmCpMKEirP+78q1t+mcdgOsu/hcJbGIFp0tOJ3MQhKgsJBlUNTmvWK/YNzcDOaQgOqhxxfWsQHR28sQatVDcs9wW5VxQZg8wheinMQgmDFz+qO4UPruWh9I/zukCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354882; c=relaxed/simple;
	bh=8aFeR5aQ2iHAR0NM7D7DMHr0/eUL1q7nBepxWqcYe2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gf2lyUkYAzimKqHtxxLnDrQPISXxxJcfUvOIQ0c5xbuoFk7f2Ta7FQcE87Q5I2H39ip0yH/b6ITDurXkTHX89+2d1c8HmH8YptBXN/Ca4+lFV4q/7kg/nS9VJ4QvrRoirXZKn9lzMEJD6t0B9mIBYagRbZ96XN8jWfpM0NH8Pio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wFusNDwk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1fHikD4168727, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354877; bh=V4yk38AFeaqln3YvJk46U2isEzHXiqmvQUAQ8RjvhyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wFusNDwk8YjulUDKpe85BMn46wCPRq5faYNqXspiAZve6BRc6JORvFDsA1oPgvOSE
	 NFmtWhx/e9DtR+YyIPxChKlmF2h/Dy9VsnIeTloYAKz161epg1obUF5VyJs/Q0WD/l
	 5ACaZJQ+4rDhnvrmBjINCTjWwaVA14TKqbHoh7IfsPwFMHsHNjvIGl++TM4Wv2UEcq
	 WMWW+kU/I+HvkTOUbEclDcGt8aHF4dzx6v5GtoPUXRur4WRPZ1bZjMInL6RNdOLZLZ
	 NW7tzB0+CYyX6C0mggCT67pehPo9K75h5H9blOL1WzgjNJSM7oMF2ALlqs0Nw/pZJP
	 xt+2gleLE5eXg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1fHikD4168727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:41:17 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:41:18 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:41:18 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:41:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 11/12] wifi: rtw89: phy: fix incorrect power limit by mac_id
Date: Wed, 14 Jan 2026 09:39:49 +0800
Message-ID: <20260114013950.19704-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Po-Hao Huang <phhuang@realtek.com>

Modify the power register range based on chip ability. When not set, the
default value is random. This fixes incorrect power limit on some ICs.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 2dbc194eb329..08fd24a55d85 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -455,7 +455,8 @@ void rtw89_phy_bb_wrap_pwr_by_macid_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	const struct rtw89_bb_wrap_regs *bb_wrap = phy->bb_wrap;
-	u32 macid_idx, cr, base_macid_lmt, max_macid = 32;
+	u32 max_macid = rtwdev->chip->support_macid_num;
+	u32 macid_idx, cr, base_macid_lmt;
 
 	base_macid_lmt = bb_wrap->pwr_macid_lmt;
 
@@ -470,8 +471,9 @@ void rtw89_phy_bb_wrap_tx_path_by_macid_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	const struct rtw89_bb_wrap_regs *bb_wrap = phy->bb_wrap;
+	u32 max_macid = rtwdev->chip->support_macid_num;
 	u32 cr = bb_wrap->pwr_macid_path;
-	int i, max_macid = 32;
+	int i;
 
 	for (i = 0; i < max_macid; i++, cr += 4)
 		rtw89_write_bb_wrap_flush(rtwdev, cr, 0);
-- 
2.25.1


