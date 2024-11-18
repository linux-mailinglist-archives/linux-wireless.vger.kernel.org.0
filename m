Return-Path: <linux-wireless+bounces-15441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E707D9D084C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 05:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7126281B25
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 04:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD4312E1E0;
	Mon, 18 Nov 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="td3lRX3m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018B13A888
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902649; cv=none; b=OdTxdzPoq7GVwA/ujh5asMuOIDBjRhjjZgk1AtNXZbvs0Q8yPb6bdAkRu64/fRLZJZc1UBaS0dfVvprRhB5XOSmeMvR1KQUdet6rPDg8AwLCFJ1rOPqP+fWFIAZsUy7J7uCuIOZmex5buh7DRd6VwN+rpPZ3mvCsms1S8ywaE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902649; c=relaxed/simple;
	bh=/X6VL04OWiK76KJPqzIxMMS9C4EgS3enbc5iXQS5XXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q22Q/3GHv4nml6haZzGjeB1b7c0rHzGI83/bOAv0sjuPEOgr4rT1NnN3DfLuQI9knNUb0o78NoRLOfAmPnO7O/GW4jvvtdBH8YpBUwXwWll+EwsS4rF2LqY50H7rdlEKGNvdHFxj3N3sKM2spqaLNStFnmroPdP5or4hHS3jp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=td3lRX3m; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI444fY4100401, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902644; bh=/X6VL04OWiK76KJPqzIxMMS9C4EgS3enbc5iXQS5XXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=td3lRX3mWe5m00qhk2amf9F7QiPGRIR35uMzBMkwaWfen1e6Tkb9d+1bJ19nHu5Kc
	 RjTpczfKSOQjqKDsTpEosgJWJn6ORWewxy5c3vv1VNyR2EZnF9nh8cZfBY4uMXzLb7
	 kWCy0fifI0ti9ojIdJqpuu6ehVzNtBTFJ+FdPXqK9is9i6PMMmrALJghdDnhZtnnSV
	 /1YfUqXg9PaOg93PcOQhEblwU0j15VAhuXUineiWQYOW4wym1JudidHIJ2s8WDZ0As
	 GtVbVK7zojv0+cApabQrfGXLGtMdGvmEqWfGgVu5ANwvfjm4tNH4qaZSXvSFDqTsgB
	 dizKYCMPtnG2A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI444fY4100401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:04:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:04:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:04:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v2 5/6] wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
Date: Mon, 18 Nov 2024 12:02:54 +0800
Message-ID: <20241118040255.40854-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118040255.40854-1-pkshih@realtek.com>
References: <20241118040255.40854-1-pkshih@realtek.com>
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


