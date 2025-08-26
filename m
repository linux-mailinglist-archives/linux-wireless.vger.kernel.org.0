Return-Path: <linux-wireless+bounces-26607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173E3B35364
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 07:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28979189F79B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 05:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9E1DE8BF;
	Tue, 26 Aug 2025 05:32:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46C288C22;
	Tue, 26 Aug 2025 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186331; cv=none; b=rY+TV4Wcfi5613IbDs/OolyoRqg2PqZDvOZ56GQ0K23/XPMgh6cjRH4WWn9CLu/EvZphqWN+IXvj5w2n7b0cEa0/hew1DupMFToqyzbzP1sXd6+lB/PjZNfYZjCLGLBt8uk4aejqPsKf9IIeejsqtbQk1YhM6eoycO3aw5CIyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186331; c=relaxed/simple;
	bh=oZOU4Wm6ay8KH21hAmJjmxmKpphnFcRGNlKkuB7PKDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIWAZUv2Jf1lnJDaHINIlC+fXmLU4OMSM1djAfSyhzXINBseYCOEOHIgr9nP6nK0+Wa4N201wiX0Agsy1Hem6Sj15ATl7ldn4XV5+Ac+Ydw50dAQt4Fj4qMbRe1Un2Aw54IDkrzTe4KjyjByuTkZkUJpoirNIAIE9laU7ITWR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d29840c0823d11f0b29709d653e92f7d-20250826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8c9a5f6f-fa55-4bdc-9ff7-2a2c8c52f593,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:e5e44cd7f4c45bf558a515c96f0155dc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d29840c0823d11f0b29709d653e92f7d-20250826
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 860650897; Tue, 26 Aug 2025 13:30:48 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 73323160038C0;
	Tue, 26 Aug 2025 13:30:48 +0800 (CST)
X-ns-mid: postfix-68AD4688-26915480
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id B90A416001A03;
	Tue, 26 Aug 2025 05:30:47 +0000 (UTC)
From: tanzheng <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: arend.vanspriel@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	tanzheng@kylinos.cn
Subject: [PATCH v2] wifi: cfg80211: simplify the code
Date: Tue, 26 Aug 2025 13:30:23 +0800
Message-Id: <20250826053023.861725-1-tanzheng@kylinos.cn>
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


