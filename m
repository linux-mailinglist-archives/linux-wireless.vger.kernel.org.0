Return-Path: <linux-wireless+bounces-11875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569FD95DC73
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129C728287F
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E41509B6;
	Sat, 24 Aug 2024 07:33:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DA746E;
	Sat, 24 Aug 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484800; cv=none; b=HzESADeKFTX63Jz3GPAiEs5fLKFoeewEPbPogVCAZ4nF9uSmRsqxJZL08a20TKo3T1Y4tSnRFcB/oNfteB8m8Y7FHUQUxrQCrPAkO5+7qezzp0GY8KoqNdwe19Tle9OsYAxVmYmzQ2midnqQhtV2u+Onp/f3G4AkNmTlolicuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484800; c=relaxed/simple;
	bh=48Em0RcKvHK8LCBYl3gaXRieC5bB2sJ6QpJq+jnDrAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vn3fBVBpPEKWUT8EOeJqph7n4DgUAQsB3zowmOAc3CFhsKGM6YAKs13LAaVAxZUh9f3ho/4U3y8IMJ5hohccMFJvLkU3PJc0K7ud6A3f89eku2k7F0y3gZj9d+f9lubrxZbnuBYg9IpcHUY621p3I9zHHUgFGx8aFwIifFIDT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WrTDc2YLszyR2M;
	Sat, 24 Aug 2024 15:32:48 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 25D0B1800A5;
	Sat, 24 Aug 2024 15:33:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 24 Aug
 2024 15:33:13 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <allison.henderson@oracle.com>,
	<dsahern@kernel.org>, <pshelar@ovn.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <dccp@vger.kernel.org>, <dev@openvswitch.org>,
	<linux-afs@lists.infradead.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next 2/8] net/rds: Use max() to simplify the code
Date: Sat, 24 Aug 2024 15:40:27 +0800
Message-ID: <20240824074033.2134514-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824074033.2134514-1-lihongbo22@huawei.com>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The target if-else can be replaced with max().

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/rds/info.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/rds/info.c b/net/rds/info.c
index b6b46a8214a0..8558b0a466b4 100644
--- a/net/rds/info.c
+++ b/net/rds/info.c
@@ -194,10 +194,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 	}
 	ret = pin_user_pages_fast(start, nr_pages, FOLL_WRITE, pages);
 	if (ret != nr_pages) {
-		if (ret > 0)
-			nr_pages = ret;
-		else
-			nr_pages = 0;
+		nr_pages = max(ret, 0);
 		ret = -EAGAIN; /* XXX ? */
 		goto out;
 	}
-- 
2.34.1


