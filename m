Return-Path: <linux-wireless+bounces-11878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9895DC7D
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763182827BC
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D19155759;
	Sat, 24 Aug 2024 07:33:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D72D7B8;
	Sat, 24 Aug 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484804; cv=none; b=CaWJqQCKf4lJ5IwAp9uQA4w1hwPj7yAwR4bNQm2Ief5E+PtIGw7KylrxxNzOgVcDbX6K0HkDDwwqhbvWNMyfUlAYRYCjrPkPc1mRbpp+iel8CparizxcUMtIk7uVYM2edjxxYwQx7pS2ojrRe87lMGrRUjbn3Q25WjE/jbcAvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484804; c=relaxed/simple;
	bh=2Lhf//eOuftp5GWtCDU5XsiHeG7f1DhzdYzQ7ZKsezQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzeCb03ndp21GlWNsUUrDkNr2PVVuIfWnSIA8RGX63d+kPYEuIj91sM8HkM9mlq5BWTM/i7Sn4u2I9iTXFDO9YHRNyMcXr6rZKN+N84IATmfQIhaK+Qx/FTxgD57/rdaI8b8YXmE966sfs7I5rlQLGaPvhOnr3BWJ0qGVgdzvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WrT9M0qtHz1HGkR;
	Sat, 24 Aug 2024 15:29:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 540731A016C;
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
Subject: [PATCH net-next 3/8] net/ipv4: Use min() to simplify the code
Date: Sat, 24 Aug 2024 15:40:28 +0800
Message-ID: <20240824074033.2134514-4-lihongbo22@huawei.com>
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

The following Coccinelle/coccicheck warning reported by
minmax.cocci:
    WARNING opportunity for min()
Let's use min() to simplify the code and fix the warning.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/ipv4/ip_sockglue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..f35aba4c3b0e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -282,7 +282,7 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 			/* Our caller is responsible for freeing ipc->opt */
 			err = ip_options_get(net, &ipc->opt,
 					     KERNEL_SOCKPTR(CMSG_DATA(cmsg)),
-					     err < 40 ? err : 40);
+					     min(40, err));
 			if (err)
 				return err;
 			break;
-- 
2.34.1


