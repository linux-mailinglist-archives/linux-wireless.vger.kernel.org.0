Return-Path: <linux-wireless+bounces-11884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E3A95DCC3
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470DEB21385
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA7154BEA;
	Sat, 24 Aug 2024 07:56:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8675DC148
	for <linux-wireless@vger.kernel.org>; Sat, 24 Aug 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724486210; cv=none; b=OKI6suZJVjExLASBCMJkIImWWSTRCravjYC29cARaXhCBnEoj4PkCTwEnFRpZn+3lDXkWgIQmPcQoYry4mKMyYGtnMbtH/haj03Qxc5Z4sI6kz9dp9S1krHiBPKzIveqoODwvqXe7iQrFBGzmAqdKGiT55+qwJW0xX/lvAeadBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724486210; c=relaxed/simple;
	bh=NVSIA2ydb2sMBhxnnXNBw9w2sjBFHp+fLud1Y9UXN4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SNUVxAlvveSO0MVsyO0F+1e3vMBTqW+mD5kfepGbQhr5hJ0WquXiqJMpvqaoTIEDsr5sPM95qeHAl7tRi1+DgfXngHNgTKTXsGT9/kFP8HlsNi/a6JlsmV2ojHZgFiGVl43yRepPd7/y48SL9Sna1BCpUolWkuZRRhRX2y7f0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrTkP1cFJzpSw1;
	Sat, 24 Aug 2024 15:55:09 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (unknown [7.185.36.76])
	by mail.maildlp.com (Postfix) with ESMTPS id 0212C1800F2;
	Sat, 24 Aug 2024 15:56:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 24 Aug 2024 15:56:44 +0800
From: Zhang Changzhong <zhangchangzhong@huawei.com>
To: <linux-wireless@vger.kernel.org>
CC: Zhang Changzhong <zhangchangzhong@huawei.com>, Johannes Berg
	<johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH -next,v2] wifi: mac80211: remove redundant unlikely() around IS_ERR()
Date: Sat, 24 Aug 2024 16:26:43 +0800
Message-ID: <1724488003-45388-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)

IS_ERR() already calls unlikely(), so unlikely() is redundant here.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
v1->v2: add "wifi:" prefix to the title

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


