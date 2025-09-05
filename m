Return-Path: <linux-wireless+bounces-27033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012CAB44E30
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 08:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BEA17384F
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AB5212545;
	Fri,  5 Sep 2025 06:44:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8127935C;
	Fri,  5 Sep 2025 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054680; cv=none; b=bJjWQz321QUfyLKVWVW8CAg5JGTV0GjdvdhBlxiJ4oXECvTeewgECdWlw01e3tcuWE6vyPYbYj1mkuM/SCHrRZnxgkXdWZTqacZBglj+uLiD0VDRWygWvgEVqDBBH43x49LqjxD/FvhDaKxDwq46sMowkZy/O0Jg3MEEtIIKdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054680; c=relaxed/simple;
	bh=xCbZ0OC2D6dK4DEuY+6kFETEtfde45wGVI9WtSustIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DAaQzbMyu5AU7HtKVFvVCA1lQcxy45a03ifLqIuadiokoAJ9gPdw8pwY5EB2O1BULMJYYaWMMTs6AjQMpWw2u+38Ngd15ZTzefp2vtNl8h5KQ2Yke+GzQ27GP98mYP2A/tjVIznKPagCRZRHifUE3QzqSuF85/ejOKsdO25GeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 125a72548a2311f0b29709d653e92f7d-20250905
X-CID-CACHE: Type:Local,Time:202509051438+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ebc0d553-b6b3-4b3d-b2d1-42ccbcc89bb8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:fe34e70d8ada746319231e1bc6db2edf,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 125a72548a2311f0b29709d653e92f7d-20250905
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2141632053; Fri, 05 Sep 2025 14:39:28 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 51DCF160038C1;
	Fri,  5 Sep 2025 14:39:28 +0800 (CST)
X-ns-mid: postfix-68BA859E-8633652120
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id 7F2E1160038C0;
	Fri,  5 Sep 2025 06:39:25 +0000 (UTC)
From: tanzheng <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: arend.vanspriel@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	tanzheng@kylinos.cn
Subject: [PATCH v3] wifi: cfg80211: Remove the redundant wiphy_dev
Date: Fri,  5 Sep 2025 14:39:23 +0800
Message-Id: <20250905063923.1170764-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no need to call wiphy_dev again.Simplifying the
code makes it more readable.

Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Changes in v3:
- Modify the patch description=09

Changes in v2:
- Delete the use of dev_name instead of pdev->driver->name.
  This is incorrect.

 net/wireless/ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/ethtool.c b/net/wireless/ethtool.c
index 2613d6ac0fda..46e4317cbd7e 100644
--- a/net/wireless/ethtool.c
+++ b/net/wireless/ethtool.c
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


