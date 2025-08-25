Return-Path: <linux-wireless+bounces-26575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D586B3360C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 07:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112391B20654
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59227A928;
	Mon, 25 Aug 2025 05:51:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B40277C8D;
	Mon, 25 Aug 2025 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101103; cv=none; b=efw17pE4y3fgxO9uEyi9U3XWUKVzqloG04a0zHj+Tj44QGOU0GkDLVicdhYlHgXEfR8yLM1Nx2o6V0K6aNq8SnLoRRgcadz9pIqrlgKDJ7k0FP2BEyc+VLcVf1yxfaHWU2i5BDw8lTq/Yn8Q+kUe/lwqMSYSHarVB6f/G21TAoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101103; c=relaxed/simple;
	bh=qE9zFKIfhkBRu30z6t90ivQJQIX5cozzfd18irPXrA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iRGx+GUvxNvMVr7DSYyPMVqOqNuWDyMr3RffMwv5XevDHfkOwjM6LgdEtoPbYd+95M9fPjFFmpoJGRa7Jo9ahmImEvXcPbhQ2JGMs/VQIAcmLzWJvSF5ZGih49AvM8go4qAUV/BZ2c/DhS6uVRUjZRQK0aHDiuhusV1/4BR0qBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c2de9da817711f0b29709d653e92f7d-20250825
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:40f57b8d-2681-4a39-8c80-17f6df75ba64,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:1717852baaac36a722040a80a822ab7f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8c2de9da817711f0b29709d653e92f7d-20250825
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 915371682; Mon, 25 Aug 2025 13:51:30 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 3A1F916001A03;
	Mon, 25 Aug 2025 13:51:29 +0800 (CST)
X-ns-mid: postfix-68ABF9DF-9485901807
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id BA0CD16001A01;
	Mon, 25 Aug 2025 05:51:27 +0000 (UTC)
From: tanzheng <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tanzheng <tanzheng@kylinos.cn>
Subject: [PATCH v1] wifi: cfg80211: simplify the code
Date: Mon, 25 Aug 2025 13:51:23 +0800
Message-Id: <20250825055123.960168-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Simplifying the code makes it more readable=EF=BC=9A
1.Use dev_name instead of pdev->driver->name.
2.There is no need to call wiphy_dev again.

Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
---
 net/wireless/ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/ethtool.c b/net/wireless/ethtool.c
index 2613d6ac0fda..0acfdc44b479 100644
--- a/net/wireless/ethtool.c
+++ b/net/wireless/ethtool.c
@@ -10,7 +10,7 @@ void cfg80211_get_drvinfo(struct net_device *dev, struc=
t ethtool_drvinfo *info)
 	struct device *pdev =3D wiphy_dev(wdev->wiphy);
=20
 	if (pdev->driver)
-		strscpy(info->driver, pdev->driver->name,
+		strscpy(info->driver, dev_name(pdev),
 			sizeof(info->driver));
 	else
 		strscpy(info->driver, "N/A", sizeof(info->driver));
@@ -23,7 +23,7 @@ void cfg80211_get_drvinfo(struct net_device *dev, struc=
t ethtool_drvinfo *info)
 	else
 		strscpy(info->fw_version, "N/A", sizeof(info->fw_version));
=20
-	strscpy(info->bus_info, dev_name(wiphy_dev(wdev->wiphy)),
+	strscpy(info->bus_info, dev_name(pdev),
 		sizeof(info->bus_info));
 }
 EXPORT_SYMBOL(cfg80211_get_drvinfo);
--=20
2.25.1


