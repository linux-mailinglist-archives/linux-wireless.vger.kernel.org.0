Return-Path: <linux-wireless+bounces-15525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EB9D32BD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 04:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC211F2381A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 03:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60EE40BE5;
	Wed, 20 Nov 2024 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iSSM+762"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9153A1B6
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732074115; cv=none; b=gVn5HjbQ3f3yVYOSuaDPqBk1SkrKwLbpivEawXIWIAZ+q51aEiFcHD3dGY5MC1t/ybPRWneqhHwGO3a34G/XQsr7IrtvoCsB358WrthhvivkTJL9MQvs3ypGOwGaiU1tJbVASLiv4m9phfKRKYohNf+zIdIKwM29x8XOtlZCARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732074115; c=relaxed/simple;
	bh=/X6VL04OWiK76KJPqzIxMMS9C4EgS3enbc5iXQS5XXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1kXXiK3zcegqOkFOodbO0Zo5Cw10DvbW2jG5eSLzrFEUhof5mY7p4rTIbP254EN7sy7bFRTVKA6F8YyObcnNHI9K6nJd8R/t6DRHteTuiaI+ci9XuRlA4nE0I/we7r2majDLY2+uGv0HcM1tCVJ7pg0gUIcfp17w1ZO6VO6618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iSSM+762; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK3fpt673465177, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732074111; bh=/X6VL04OWiK76KJPqzIxMMS9C4EgS3enbc5iXQS5XXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iSSM+762eBV8Yjsqe+cUtZqDcpkgDCF2ivWCzezkJToYRe2xUAQWTO5KAc7lzIu5z
	 6K/Yb+nTdOG8djbW8GwGQvZ/9iF2YASapXb6Y+7fJw5MtSCdTlnXRs7uJL2eNWrDcY
	 1vzSl9L4bh/ARaJMEWQoTBLppmBOc3IJ8UHHkQRWw7aJx4Nw0sA4Mmkb+4rsjf5hsq
	 MQ7qxggNy6IgdhOxY6c8RUFhdBJULpXX5BPcrKoSfoC6NnYFUMid/LYDrZnVmaeUCG
	 yuTRkeSHbmPs0pEmeCFlYRy1JAtijZJ4mmkWdyzr1coc/OJ2RLgSwBeqmYAmHHMYwU
	 uVnv/7OwNnAsg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK3fpt673465177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 11:41:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:41:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Nov
 2024 11:41:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v3 5/6] wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
Date: Wed, 20 Nov 2024 11:40:53 +0800
Message-ID: <20241120034054.13575-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120034054.13575-1-pkshih@realtek.com>
References: <20241120034054.13575-1-pkshih@realtek.com>
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

When calling ieee80211_gtk_rekey_add(), pass the target link_id
instead of always -1.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 3e81fd974ec1..1e1dbb20d47a 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -620,7 +620,10 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 	 * need to unlock mutex
 	 */
 	mutex_unlock(&rtwdev->mutex);
-	key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, -1);
+	if (ieee80211_vif_is_mld(wow_vif))
+		key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, rtwvif_link->link_id);
+	else
+		key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, -1);
 	mutex_lock(&rtwdev->mutex);
 
 	kfree(rekey_conf);
-- 
2.25.1


