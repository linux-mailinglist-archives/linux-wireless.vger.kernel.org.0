Return-Path: <linux-wireless+bounces-14809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611259B8CEF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7651F22BA4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248FB1527A7;
	Fri,  1 Nov 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vot43ctf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7DC4087C
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449386; cv=none; b=C/BEGbBFHuyMaVKtJkok5ysBRc2oRWB75FgmwS6AwhtWNQlcdv8lnLiFqDhwY/VRAX08yUGP/hjTV3X+b6pIuBemrJLKSAvHdmgfBnXd4nTjDx4LSUpdodgJTKLPFAGRoyxe81rAqXfsTu8hza67naJpLldez/qtLM+Hq3UdF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449386; c=relaxed/simple;
	bh=C4+9DkIxfJVC8bWvF29BN58RLFs/lNfp6C1sYXL9vtw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TPBLSqKvmNPNaK4uNgSCc70+c11fw+Hlvp31/spNt0xRIDSxdpBiVG2Ry+8BQEUM+A7TIAvMko2lgtizZ6frb3TYHTN69gK48cH9oEnBDXeuFKNJeIEnX9SbL3ECXlkZUPpDVCXc/bCmHd/t+St+pSzItFlVvE+tfOo73/m8uIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vot43ctf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A18MpsA62769479, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730449371; bh=C4+9DkIxfJVC8bWvF29BN58RLFs/lNfp6C1sYXL9vtw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vot43ctfCDEcJNjQuLwM5LbtVwH0kL9NLMMRDd1F1i+P8PmJ4FJYQvYiW206ntr4T
	 2aw+8d7Dl+H9NG5Aji1qvaBtl43DMHBRIqx7FmNSTFXSvjMTNkKE03rqtboEGhm/mm
	 Yr83vO3p2BpxmHIUEJkm00Wxh/S5ZN/dCVtYigXYw6wDEfNRBeJOTAk8CO5PawEqlp
	 Cd6PUN1/QcK61HJOXW2Lh0kD42JZw5CqDXsD3OdHg5LfxIIt8p1VGxF5c0Xh9VwH4F
	 EP/aG7rQbweUghR5TEFsroZRWhC8Z7A1XMehyARUVG+gnB8dorfoFcC03xoKUxYslq
	 4EdX80Lx+6cQQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A18MpsA62769479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Nov 2024 16:22:51 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 16:22:51 +0800
Received: from localhost.localhost (172.21.69.104) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 1 Nov
 2024 16:22:51 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: mac80211: fix description of ieee80211_set_active_links() for new sequence
Date: Fri, 1 Nov 2024 16:21:43 +0800
Message-ID: <20241101082143.11138-1-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The sequence of calls has changed, but the description is inconsistent.
So, fix the description.

Fixes: 188a1bf89432 ("wifi: mac80211: re-order assigning channel in activate links")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b4f246cdcca4..a97c9f85ae9a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7672,12 +7672,12 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
  *
  *  - change_vif_links(0x11)
  *  - unassign_vif_chanctx(link_id=0)
+ *  - assign_vif_chanctx(link_id=4)
  *  - change_sta_links(0x11) for each affected STA (the AP)
  *    (TDLS connections on now inactive links should be torn down)
  *  - remove group keys on the old link (link_id 0)
  *  - add new group keys (GTK/IGTK/BIGTK) on the new link (link_id 4)
  *  - change_sta_links(0x10) for each affected STA (the AP)
- *  - assign_vif_chanctx(link_id=4)
  *  - change_vif_links(0x10)
  *
  * Return: 0 on success. An error code otherwise.
-- 
2.39.0


