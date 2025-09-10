Return-Path: <linux-wireless+bounces-27198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7311B50A90
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 03:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CF14E6515
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 01:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B0E22578A;
	Wed, 10 Sep 2025 01:56:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8762248B8;
	Wed, 10 Sep 2025 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469383; cv=none; b=kvGk7iDbzCCMXEswgihrlWdu8NipZFfeHEvwJB9D+mN65YZ2UyHtaqjffjWdihmG8QjG7nKqGogiUvHJ6Y7TV1T8qF13LPADFB+CIjMTomF8YTWMl+4OJPtQxfhD97QyAdqGvyCEgW8SRND6yAVummObRG0hct3gcC310Z0X0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469383; c=relaxed/simple;
	bh=zxesjLZpmWK0+n8WPq3ApNudAoBG+yunYX61OkpW7Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PMSt2gBw62hDib+x0tuBVKBDJ4jeOgoFobt7OUdFfwx0w68+sW/GzI3mrjMmQ4O8l0A0stkCy4p2IxtSscFz+bZL4iYQNENFIF1GW3FQMK4zpSduq5PuKgrfrKugCY7dHYuz3h60ogb3yMgWPq5YAzC4DOIdT56HSl/K+THMy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5471350a8de911f0b29709d653e92f7d-20250910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:57630198-5744-4314-ae95-7e6c36ec0f92,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f3531b3caf06b19c5753c8f07bf8d171,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5471350a8de911f0b29709d653e92f7d-20250910
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1203768447; Wed, 10 Sep 2025 09:56:13 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 07333160042A0;
	Wed, 10 Sep 2025 09:56:13 +0800 (CST)
X-ns-mid: postfix-68C0DABC-783697334
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id 4FF6C16004295;
	Wed, 10 Sep 2025 01:56:12 +0000 (UTC)
From: Zheng tan <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: arend.vanspriel@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	tanzheng@kylinos.cn
Subject: [PATCH v5] wifi: cfg80211: Remove the redundant wiphy_dev
Date: Wed, 10 Sep 2025 09:55:56 +0800
Message-Id: <20250910015556.219298-1-tanzheng@kylinos.cn>
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
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
---
Changes in v5:
-Modify the From and Signed-off-by.

Changes in v4:
-Keep the from and Signed-off-by tags consistent.

Changes in v3:
- Modify the patch description.

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


