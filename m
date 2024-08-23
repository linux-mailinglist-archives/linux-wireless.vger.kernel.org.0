Return-Path: <linux-wireless+bounces-11818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C395C31A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 04:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B1E281A5F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 02:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B0182B5;
	Fri, 23 Aug 2024 02:04:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713BA934
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724378693; cv=none; b=LcfADrjJ5KV2dWUlhjdwkd8qYz4PDhdRTxRYWeLspr34qJsAXe6/RN19wFNC1CspXvblaNU3uhTMJf3hYdDmz+CKc4FllGhXZ87S0syeE78j4GrRvlzfeyFgS/QLAy860iFFrCirEeNlYMQ5K/jOi9baam8RJZvtitrPovs9+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724378693; c=relaxed/simple;
	bh=JVGKHQOCkEtw2Fe6EixEsd5dtswPvagOZrBVCzsqdkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RMoEmOGRmWxal8nqOxvu0kLNL25tDLE878a2k5G7lqeu1f41kkP2/iObpt5vnn+9ep5rB8x5s5h8cAZg9swDbU0YcIyoJ6wjeZfxM92Z4E2ZiezhZgNKlfl+g/MGVpNGZvf3bvEFTjA6JRjGk2qjAEfkiNZU8QO3yDpZWLmnhLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wqjv841cfz20mK5;
	Fri, 23 Aug 2024 10:00:04 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (unknown [7.185.36.76])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BEB71401E9;
	Fri, 23 Aug 2024 10:04:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 10:04:47 +0800
From: Zhang Changzhong <zhangchangzhong@huawei.com>
To: <linux-wireless@vger.kernel.org>
CC: Zhang Changzhong <zhangchangzhong@huawei.com>, Johannes Berg
	<johannes@sipsolutions.net>
Subject: [PATCH -next] mac80211: remove redundant unlikely() around IS_ERR()
Date: Fri, 23 Aug 2024 10:37:38 +0800
Message-ID: <1724380658-25139-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500006.china.huawei.com (7.185.36.76)

IS_ERR() already calls unlikely(), so unlikely() is redundant here.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 net/mac80211/mesh_pathtbl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index c0a5c75..30c0d89 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -580,7 +580,7 @@ void mesh_fast_tx_cache(struct ieee80211_sub_if_data *sdata,
 	prev = rhashtable_lookup_get_insert_fast(&cache->rht,
 						 &entry->rhash,
 						 fast_tx_rht_params);
-	if (unlikely(IS_ERR(prev))) {
+	if (IS_ERR(prev)) {
 		kfree(entry);
 		goto unlock_cache;
 	}
-- 
2.9.5


