Return-Path: <linux-wireless+bounces-27071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D514B48250
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 03:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0C9162E28
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 01:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25F1C863B;
	Mon,  8 Sep 2025 01:52:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A181A5BBE;
	Mon,  8 Sep 2025 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296356; cv=none; b=LF4Y3NZ55O+7XpuYwVOGiVNkbitpnAai31zOfa5a5nR79xSNFA8pRtCNzB0HtpE9YTYzqaGJG6ZJfAEG/54UN8XT00315UhzRQuDqhShVoz4Y1IaUBjkoScZQOpbKECXXGQGV3PJ7lLXESQM/s0GBsPBt0Zb4v+4QybOeyBdOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296356; c=relaxed/simple;
	bh=/S3/mVVblekzba6r69QEBZs1CnHkKjzr8UMwoauzbUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aZQgVsT++tYRkkaZgeYPCeBzTz1tbxnij6zg46nkF2G4yl75cgJhhnb/8Jnu5qYPmLzRzh23MScx5VENWbEyLH0OKSekBWItSJw5yDlxA/GI9Le1TPJpNLHZrgctbvZ7bp0yLO3pRHqRSr7nrXCrGxIjDiQWQH/Y9culBea75Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 78b842ee8c5611f0b29709d653e92f7d-20250908
X-CID-CACHE: Type:Local,Time:202509080949+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:521d00b2-335d-46af-bd3b-d481a0955c56,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:bd1e27b986c9550a12cd5e31073a416b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 78b842ee8c5611f0b29709d653e92f7d-20250908
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 532616653; Mon, 08 Sep 2025 09:52:26 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id AC90216004283;
	Mon,  8 Sep 2025 09:52:26 +0800 (CST)
X-ns-mid: postfix-68BE36DA-4909466
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id A73FF16004282;
	Mon,  8 Sep 2025 01:52:25 +0000 (UTC)
From: tanzheng <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: arend.vanspriel@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	tanzheng@kylinos.cn
Subject: [PATCH v4] wifi: cfg80211: Remove the redundant wiphy_dev
Date: Mon,  8 Sep 2025 09:52:24 +0800
Message-Id: <20250908015224.217032-1-tanzheng@kylinos.cn>
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

Signed-off-by: tanzheng <tanzheng@kylinos.cn>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
---
Changes in v4:
-Keep the from and Signed-off-by tags consistent

Changes in v3:
- Modify the patch description

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


