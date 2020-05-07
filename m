Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E070F1C99FF
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEGSym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 14:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgEGSym (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 14:54:42 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB2420575;
        Thu,  7 May 2020 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877681;
        bh=uxpX8W7aK8UmLVlFFNK05ClZR+zoFt4I4ufIGsyleuA=;
        h=Date:From:To:Cc:Subject:From;
        b=Vc7Ojvfaumf23QiCyhoZU7rgfQM7qZWnMc9F7sDKwBz5Fa8dG1rMcR7efJArM37jo
         /glLdysDlzCdQ4oezSPYRv66bu9fsD1vtNntmkl4VB9E8u9Hsw1AD3ZMiaG9SfMDOq
         PLyr2FzlG6QXrMwbPPjjAosGJzmdikG0983dF4tk=
Date:   Thu, 7 May 2020 13:59:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mac80211: Replace zero-length array with flexible-array
Message-ID: <20200507185907.GA15102@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/mac80211.h     |   10 +++++-----
 net/mac80211/ieee80211_i.h |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b6b4de0e4b5e..75ff87b860a4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -230,7 +230,7 @@ struct ieee80211_chanctx_conf {
 
 	bool radar_enabled;
 
-	u8 drv_priv[0] __aligned(sizeof(void *));
+	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
 /**
@@ -1652,7 +1652,7 @@ struct ieee80211_vif {
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
 	/* must be last */
-	u8 drv_priv[0] __aligned(sizeof(void *));
+	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
 static inline bool ieee80211_vif_is_mesh(struct ieee80211_vif *vif)
@@ -1780,7 +1780,7 @@ struct ieee80211_key_conf {
 	s8 keyidx;
 	u16 flags;
 	u8 keylen;
-	u8 key[0];
+	u8 key[];
 };
 
 #define IEEE80211_MAX_PN_LEN	16
@@ -2035,7 +2035,7 @@ struct ieee80211_sta {
 	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
 
 	/* must be last */
-	u8 drv_priv[0] __aligned(sizeof(void *));
+	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
 /**
@@ -2081,7 +2081,7 @@ struct ieee80211_txq {
 	u8 ac;
 
 	/* must be last */
-	u8 drv_priv[0] __aligned(sizeof(void *));
+	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
 /**
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f8ed4f621f7f..ea483861b743 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -267,7 +267,7 @@ struct probe_resp {
 	struct rcu_head rcu_head;
 	int len;
 	u16 csa_counter_offsets[IEEE80211_MAX_CSA_COUNTERS_NUM];
-	u8 data[0];
+	u8 data[];
 };
 
 struct ps_data {

