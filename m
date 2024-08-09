Return-Path: <linux-wireless+bounces-11167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5C94CB21
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8042C284A3D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86917BA2;
	Fri,  9 Aug 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="AR8iHjz0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2E17335E
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188057; cv=none; b=tsJVYwKU0TfhQAkJfSvrhmP4yk5nfIge50efFbKEa/Me+OWz2GgOZSuGUnkzeoYeSFrVX0mFQLNdDUz7dcShK1uWzDbhjFQt7kALEIvNXCyzKSEGBZVR7XgCU23GbY6lrfdNyABdbFyVWy6r9hJYvFpwoK84egb3cBs82McqPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188057; c=relaxed/simple;
	bh=KtnPIt3F0/Td+JY5zQ1mFtpb077sKTHWpenqrwunWXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYpaMzlgvLfYIITu9589vsRhobdFSL1gD+kgYn6toP9HN/dqie8+BLwxgcLuIVk+w0DabhzCzfcnGX95LRFrbkIbyW0jQjF6HGbUvSXzR4fzfN8KNwNZ/LgnCscUxULU+Mk2enO5LLWWm6huyRWF3n3AYCnk5Lrra5dhesI9F2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=AR8iHjz0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4797Kr252514074, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723188053; bh=KtnPIt3F0/Td+JY5zQ1mFtpb077sKTHWpenqrwunWXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AR8iHjz0IYV75Lr874KTEHGJwcS4DLNAlb5QVlhY0FRDQEDwtmvKVP8QUDFt4ZrTc
	 7lXgcboIp4yj3WUDBdAIsPd/gVbWnh2BO0x3ZwICOEZJsj2Bqa1NdaM8SEvpE9jP+P
	 JHpR275kN/9gKPydhyGxzhtG0QOGXJRgLxvqMq3JOe7HmmI1JwSzIU7/Lf1iSk9A44
	 sEvSjS4ErpMkzrx/cKdWbXxTIpQo2k8Ogl2WmuD1wv8uNZwJ16pVAPKQyUr6mLL9xB
	 erGIgWqDprVH8u6Z6xlIgkXDIKdq3pvHIWl3OJCnlycszAEbJ+0s+Mg2lgQIr6A9ec
	 mLqFkKZV7/oUA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4797Kr252514074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 15:20:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 15:20:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 15:20:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH 4/6] wifi: rtw89: correct base HT rate mask for firmware
Date: Fri, 9 Aug 2024 15:20:10 +0800
Message-ID: <20240809072012.84152-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809072012.84152-1-pkshih@realtek.com>
References: <20240809072012.84152-1-pkshih@realtek.com>
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

Coverity reported that u8 rx_mask << 24 will become signed 32 bits, which
casting to unsigned 64 bits will do sign extension. For example,
putting 0x80000000 (signed 32 bits) to a u64 variable will become
0xFFFFFFFF_80000000.

The real case we meet is:
  rx_mask[0...3] = ff ff 00 00
  ra_mask = 0xffffffff_ff0ff000

After this fix:
  rx_mask[0...3] = ff ff 00 00
  ra_mask = 0x00000000_ff0ff000

Fortunately driver does bitwise-AND with incorrect ra_mask and supported
rates (1ss and 2ss rate only) afterward, so the final rate mask of
original code is still correct.

Addresses-Coverity-ID: 1504762 ("Unintended sign extension")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index aa4fc9115995..7306fb679e95 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -356,8 +356,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		csi_mode = RTW89_RA_RPT_MODE_HT;
 		ra_mask |= ((u64)sta->deflink.ht_cap.mcs.rx_mask[3] << 48) |
 			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[2] << 36) |
-			   (sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
-			   (sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
 		high_rate_masks = rtw89_ra_mask_ht_rates;
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			stbc_en = 1;
-- 
2.25.1


