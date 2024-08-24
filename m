Return-Path: <linux-wireless+bounces-11880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA7895DC82
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58101282AAF
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB97155C9B;
	Sat, 24 Aug 2024 07:33:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AE155730;
	Sat, 24 Aug 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484804; cv=none; b=qyQR5lzcbuopOFXKFqiorSATGq8bJWGxb8PcUNn+V7of790z3kMH/iKE0I8y0pKm4rJVoLaDxoZPJuoGygdaIXIl1Ak2GsqBDxEJtGpP+/QVKslAjBj4yneIwfdJKQAbnkLss1lIVgNlRjWBTMSvslKwxWMDkRh7M9XS8g0Eeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484804; c=relaxed/simple;
	bh=vLibUpSaG3BzdKHKvIS416D8qK4XEhhguVioin6uHVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4o6/KHu9g9wK1iyvlMTH8HOZsqouNmb+/QPFrgC5X8Ey+qNcHLws+yFW97OdTNzYpZgWiJL6oEi6yRWnQiUZQRM5srq9veMpB72JnyQfzF7MwSuTVkQiL5FernFm74bjOVGTZAhBSqf8smVmM6CAvv+agYgNObmoLiI6S+Ok0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrTBn20vCzhY5w;
	Sat, 24 Aug 2024 15:31:13 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 37F141800A5;
	Sat, 24 Aug 2024 15:33:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 24 Aug
 2024 15:33:14 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <allison.henderson@oracle.com>,
	<dsahern@kernel.org>, <pshelar@ovn.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <dccp@vger.kernel.org>, <dev@openvswitch.org>,
	<linux-afs@lists.infradead.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next 8/8] net/ceph: Use min() to simplify the code
Date: Sat, 24 Aug 2024 15:40:33 +0800
Message-ID: <20240824074033.2134514-9-lihongbo22@huawei.com>
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

Let's use min() to simplify the code and fix the
Coccinelle/coccicheck warning reported by minmax.cocci.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/ceph/osd_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 9d078b37fe0b..450eb3be48b0 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3058,7 +3058,7 @@ static void linger_reg_commit_complete(struct ceph_osd_linger_request *lreq,
 				       int result)
 {
 	if (!completion_done(&lreq->reg_commit_wait)) {
-		lreq->reg_commit_error = (result <= 0 ? result : 0);
+		lreq->reg_commit_error = min(result, 0);
 		complete_all(&lreq->reg_commit_wait);
 	}
 }
-- 
2.34.1


