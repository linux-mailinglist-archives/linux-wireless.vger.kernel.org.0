Return-Path: <linux-wireless+bounces-11882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1586495DC87
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973B2282AAF
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339F1714A3;
	Sat, 24 Aug 2024 07:33:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346D155398;
	Sat, 24 Aug 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484805; cv=none; b=YyBR0GhT5G5KV2bL1zvivMMrvQDVF0FlAgqQb85M88/jSBEvHfhBtehOZ7IuJTZVCLedzA7q6477DwfDF1LReQ+uPxigLErhjrhXimNrAQxovXN/k63ORAzpnrqb2cEbw68WubWzhTf9l9OVUOP0Qg17MyyPlP9SKINQ87+rAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484805; c=relaxed/simple;
	bh=zR7+B23CWhFGznAhbvD+/Vaalurqp9BoWmWW0F2bidw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMk/1t1FismH7kRoIXbiIzPFF5et+8uf0ATxiqzET04lFr+hP6wuat8KEy4ljrUxbqtoSZtUmMR0jvkpWyFGDRJG3KWRHdVDkaxifhkAwYSQDK9+kwYdg9uJMIgk0x0ezjtufuVd9pNbeAXQk6kM469myNgk7U7U2muu4xLfRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrTCH0nRhzpSw1;
	Sat, 24 Aug 2024 15:31:39 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D2A86140202;
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
Subject: [PATCH net-next 6/8] net/openvswitch: Use max() to simplify the code
Date: Sat, 24 Aug 2024 15:40:31 +0800
Message-ID: <20240824074033.2134514-7-lihongbo22@huawei.com>
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

Let's use max() to simplify the code and fix the
Coccinelle/coccicheck warning reported by minmax.cocci.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/openvswitch/vport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 8732f6e51ae5..859208df65ea 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -534,7 +534,7 @@ static int packet_length(const struct sk_buff *skb,
 	 * account for 802.1ad. e.g. is_skb_forwardable().
 	 */
 
-	return length > 0 ? length : 0;
+	return max(length, 0);
 }
 
 void ovs_vport_send(struct vport *vport, struct sk_buff *skb, u8 mac_proto)
-- 
2.34.1


