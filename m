Return-Path: <linux-wireless+bounces-11883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E295DC8C
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68188B21DBE
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539DD1714B0;
	Sat, 24 Aug 2024 07:33:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F4155733;
	Sat, 24 Aug 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484805; cv=none; b=qmCjuzik0tMP+tj3Gct/733DAuB1jinbC/P7U8vwDUZU/QjM7E+ERszqdkdih92owNWq9QxQEK/KH3nuoIqnQLds3AtBKv1t7DO+TzQEqsrsTOxBmBBKErJOGUycRzan/R6adFAzmikQC+2UOjnwXXw0RCVr55C/1CyIIV1cS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484805; c=relaxed/simple;
	bh=6GXKtjujGwEH+GhrHTdQj88RQxkCOT45Z7plPSoEHCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcJMvBHK5BZN9MFrFYBL7i7g6XMETKlqhbTyfUf8H1WYleu8AokZUGW//0V6Pkwz6mr/eN28Lu23Zd4fjZEYCGROW9kFAx7lwCMDkAliZaLGNX3jAVjuC0N6aPznSgsxD8JkSWNraZb+lVOKCnvAgeobX3YvLWiY7SnWHLeUEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrTCG5W2QzpStD;
	Sat, 24 Aug 2024 15:31:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8024414035E;
	Sat, 24 Aug 2024 15:33:14 +0800 (CST)
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
Subject: [PATCH net-next 4/8] net/core: Use min()/max() to simplify the code
Date: Sat, 24 Aug 2024 15:40:29 +0800
Message-ID: <20240824074033.2134514-5-lihongbo22@huawei.com>
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

Let's use min()/max() to simplify the code and fix the
Coccinelle/coccicheck warning.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/core/pktgen.c | 6 ++----
 net/core/sock.c   | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ea55a758a475..5d4d5ec4a126 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2793,8 +2793,7 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
 		}
 
 		i = 0;
-		frag_len = (datalen/frags) < PAGE_SIZE ?
-			   (datalen/frags) : PAGE_SIZE;
+		frag_len = min(datalen/frags, PAGE_SIZE);
 		while (datalen > 0) {
 			if (unlikely(!pkt_dev->page)) {
 				int node = numa_node_id();
@@ -2811,8 +2810,7 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
 			if (i == (frags - 1))
 				skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
 							pkt_dev->page, 0,
-							(datalen < PAGE_SIZE ?
-							 datalen : PAGE_SIZE));
+							min(datalen, PAGE_SIZE));
 			else
 				skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
 							pkt_dev->page, 0, frag_len);
diff --git a/net/core/sock.c b/net/core/sock.c
index bbe4c58470c3..c9910f48903f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3800,7 +3800,7 @@ int sock_prot_inuse_get(struct net *net, struct proto *prot)
 	for_each_possible_cpu(cpu)
 		res += per_cpu_ptr(net->core.prot_inuse, cpu)->val[idx];
 
-	return res >= 0 ? res : 0;
+	return max(res, 0);
 }
 EXPORT_SYMBOL_GPL(sock_prot_inuse_get);
 
-- 
2.34.1


