Return-Path: <linux-wireless+bounces-23354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BCAAC21B8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 13:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB54A9E36EA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF62356A8;
	Fri, 23 May 2025 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="O+GjlyMk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065423185B;
	Fri, 23 May 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998136; cv=none; b=hE/JFS1wFiU2PSzXp0vTA1FGDo5ggME90BDE3ibqvNb5T6eWmRNGtQ9rG/R5U7cAkv0YneZs2mMUg4N8Mmy8qJcpcYIZ88VW5cYQeOFnxdqXjRt1jRgc0EJn3TGOXMVrggup0z3yhc+rce6Zo/hB+/8HqPS2RvSZqzIw76yC9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998136; c=relaxed/simple;
	bh=wA1U2bbwCWWWNfJz305Gv8CySEchp6eJnyTgQZt24ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IEgAU+pCNkNj0q/0KrcI4hyZa1hS1xpJB1XoIhfZFZ3VsxsZBtivYUqif0FzYE93c5co3YhvSoT3im73O6hlArQchTmCwMB5eMrDWhNRCiHUrX1w9W1n1HVgJyCJ3LO9iZL+kjbHBw/CA8FZbeU/l2yBh25y/MbPG0ndNRT7dTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=O+GjlyMk; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 162e36df1;
	Fri, 23 May 2025 19:02:02 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] wifi: cfg80211: use kfree_sensitive() for connkeys cleanup
Date: Fri, 23 May 2025 11:01:56 +0000
Message-Id: <20250523110156.4017111-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHk4ZVhgeSkxPQx1JHx0YTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk5MSlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a96fccea00503a1kunm7d07db8a29d309
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6Cio5MTE*IhQoODo3PB8u
	FgEKCTJVSlVKTE9MQkJDSklJQ0NCVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKTktCNwY+
DKIM-Signature:a=rsa-sha256;
	b=O+GjlyMkKTWk2xvyT10/+a8t7Aq9yusNhkIMszo3bdz+TQ/XWs6S7kCyPd7/63HTOhaCDan6QU5jiaVVL4Zcy8q9/nqMDHQtEJVDF5EcIPsSMBpIOPzeIIbfzK7uZvMK8Mjr8kahxQ/WcsZRFCHCIkCFk5YBG7VQWDsGMgmAoik=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=2mZX1RublkKQ4pxyQ4siv7ydpqrv6wL/TIjOia5Vwf8=;
	h=date:mime-version:subject:message-id:from;

The nl80211_parse_connkeys() function currently uses kfree() to release
the 'result' structure in error handling paths. However, if an error
occurs due to result->def being less than 0, the 'result' structure may
contain sensitive information.

To prevent potential leakage of sensitive data, replace kfree() with
kfree_sensitive() when freeing 'result'. This change aligns with the
approach used in its caller, nl80211_join_ibss(), enhancing the overall
security of the wireless subsystem.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f039a7d0d..aaaafde96 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1580,7 +1580,7 @@ nl80211_parse_connkeys(struct cfg80211_registered_device *rdev,
 
 	return result;
  error:
-	kfree(result);
+	kfree_sensitive(result);
 	return ERR_PTR(err);
 }
 
-- 
2.34.1


