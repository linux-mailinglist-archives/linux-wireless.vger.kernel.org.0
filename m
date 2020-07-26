Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1822DF6E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jul 2020 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGZNJv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jul 2020 09:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgGZNJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jul 2020 09:09:51 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13620C0619D2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jul 2020 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KxARJkb0hRPwKgClAui5vNEwjfRs8wKEUr9ny2/B3hY=; b=ga0Gs1xK00SF2G+ULuJ55A/fCH
        T2YZy3a5DLU9Qq/iyI/n5Nf4zPFejgC0gNCxroBopdOZ17PxBwNHjdpzRAV9JGWe7rRQzcG2BRU7+
        Oc6hf/TPe9xYEyTLrvxy6p9huSC/IphnT41axAXcqP74Nwdy8vooTvdT+RsS33M6pWck=;
Received: from p5b206d80.dip0.t-ipconnect.de ([91.32.109.128] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jzgPU-0000J8-Pd; Sun, 26 Jul 2020 15:09:48 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 1/2] net/fq_impl: use skb_get_hash instead of skb_get_hash_perturb
Date:   Sun, 26 Jul 2020 15:09:46 +0200
Message-Id: <20200726130947.88145-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This avoids unnecessary regenerating of the skb flow hash

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/fq.h      | 1 -
 include/net/fq_impl.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/fq.h b/include/net/fq.h
index 2ad85e683041..e39f3f8d5f8a 100644
--- a/include/net/fq.h
+++ b/include/net/fq.h
@@ -69,7 +69,6 @@ struct fq {
 	struct list_head backlogs;
 	spinlock_t lock;
 	u32 flows_cnt;
-	siphash_key_t	perturbation;
 	u32 limit;
 	u32 memory_limit;
 	u32 memory_usage;
diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index 38a9a3d1222b..e73d74d2fabf 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -108,7 +108,7 @@ static struct sk_buff *fq_tin_dequeue(struct fq *fq,
 
 static u32 fq_flow_idx(struct fq *fq, struct sk_buff *skb)
 {
-	u32 hash = skb_get_hash_perturb(skb, &fq->perturbation);
+	u32 hash = skb_get_hash(skb);
 
 	return reciprocal_scale(hash, fq->flows_cnt);
 }
@@ -308,7 +308,6 @@ static int fq_init(struct fq *fq, int flows_cnt)
 	INIT_LIST_HEAD(&fq->backlogs);
 	spin_lock_init(&fq->lock);
 	fq->flows_cnt = max_t(u32, flows_cnt, 1);
-	get_random_bytes(&fq->perturbation, sizeof(fq->perturbation));
 	fq->quantum = 300;
 	fq->limit = 8192;
 	fq->memory_limit = 16 << 20; /* 16 MBytes */
-- 
2.24.0

