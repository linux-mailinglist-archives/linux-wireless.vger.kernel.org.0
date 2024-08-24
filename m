Return-Path: <linux-wireless+bounces-11879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305D95DC80
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B81C2111D
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C5155A52;
	Sat, 24 Aug 2024 07:33:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63536155735;
	Sat, 24 Aug 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484804; cv=none; b=Vld7CF4EJcKvCP2fx/xUpxR2KWfC7wOdY/I8qQOU/Jx44Pm5QQl8CQmZoLQ4GjuWdUKalemAhMPL8fDA/IwUkDWHYPuCFtTbbr/LvK5tCDoX+en7GsvULhsSnn36sJIL9kN39eW5Lz3qeOsNUv/hFxR8Zp902droJsgzh7vjmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484804; c=relaxed/simple;
	bh=Zl6JU4raRf1DfkAjrXYsxw8FZaF/pAfSri/sLIxlhdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjHePwygHFfPudRlIvcLxHibQNmYuTOHryXSaPEAPX5h+iRovi/Tug4lpBOadYp0GY8KhMbtBfgsQPYO5ZqJMaM/QmHjm2XeNfYDIVFreVHbq5CfUzQz6Tw/4ckv5+mITdYV7r3RJnjm8HuTVal3IQ57Vlvl1eTnmzfObttuXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrTBn0ntCzhXgK;
	Sat, 24 Aug 2024 15:31:13 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CEFD140137;
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
Subject: [PATCH net-next 7/8] net/rxrpc: Use min() to simplify the code
Date: Sat, 24 Aug 2024 15:40:32 +0800
Message-ID: <20240824074033.2134514-8-lihongbo22@huawei.com>
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
 net/rxrpc/input.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 16d49a861dbb..455aa0189b28 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -868,8 +868,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	prev_pkt	= sp->ack.prev_ack;
 	nr_acks		= sp->ack.nr_acks;
 	hard_ack	= first_soft_ack - 1;
-	summary.ack_reason = (sp->ack.reason < RXRPC_ACK__INVALID ?
-			      sp->ack.reason : RXRPC_ACK__INVALID);
+	summary.ack_reason = min(sp->ack.reason, RXRPC_ACK__INVALID);
 
 	trace_rxrpc_rx_ack(call, ack_serial, acked_serial,
 			   first_soft_ack, prev_pkt,
-- 
2.34.1


