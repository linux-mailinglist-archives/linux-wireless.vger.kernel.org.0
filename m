Return-Path: <linux-wireless+bounces-15045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA739C003D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A9B283964
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698EB1DE4EA;
	Thu,  7 Nov 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BytiNFq3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C091DACA9
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968903; cv=none; b=I7Yc4tTr4qRvywB4EOH68+HhzSe7ylMcPYJRknq03JCe99RnLxtIIm7CkGLebjt0kMI/8Q4whEhs3DTnDUIGnL8kYr114m5Uoe1pev5jyVo3f+7P/YZL5UmvU+9zG94Y1npSUCaX/9pYhAG0Z3bRc63BqGmH12zfhmaHuyRaLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968903; c=relaxed/simple;
	bh=/X6VL04OWiK76KJPqzIxMMS9C4EgS3enbc5iXQS5XXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duHRjJn4kr2VRdPTHHQAksmkg/VyqG1MizBDzHOPPhh7CAJkPIaJwCBwR3/AwVRpph3dSXkOXijZGnIdCQA0h54+jsu1aJeY2sM+iZ+w7CxpPViMqOes7YaaqIVFU0ReO02bHNv4/nsUFVp9n8yznWVQr5e4KuKEhqPxU0/zrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BytiNFq3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A78fb6A34173711, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730968897; bh=/X6VL04OWiK76KJPqzIxMMS9C4EgS3enbc5iXQS5XXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BytiNFq3JB7xOANXZGaAIhp7tFn1pvC80Go3drv+rFw/9r/hJVQQMUagEBydP86Sk
	 W5IPh60TULlHqmEvg7CxdxsKiIP4kJ59FbDWrdgC026ysqb6Gat327cPFBmC0Ksb+c
	 gbwIVRhB5R/77FCO3y6vVxAYZBUSmGu3LTvpxj5Sgw4JQvKbshYUTZX4KdmVQFTVLz
	 6IpdWHOPBfGPX3cxEO4qQ+fzfQQv9TeSAhmiSKkeOEClGeGeMxNACNQriCzsGjCdJQ
	 4qFwCNQxSetg1OEhFp/8eM6kuvrIOahgHJzwMegwMFHQnqo/78l8EFr5YI8enGG9Az
	 xpMUJVNml1pqw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A78fb6A34173711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 7 Nov 2024 16:41:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 16:41:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Nov
 2024 16:41:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 5/6] wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
Date: Thu, 7 Nov 2024 16:40:40 +0800
Message-ID: <20241107084041.20775-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107084041.20775-1-pkshih@realtek.com>
References: <20241107084041.20775-1-pkshih@realtek.com>
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


