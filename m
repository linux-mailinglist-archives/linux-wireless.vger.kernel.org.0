Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA13392CD5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 May 2021 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhE0LhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 07:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233044AbhE0LhO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 07:37:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD92D6113B;
        Thu, 27 May 2021 11:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622115341;
        bh=p73O82Z1ZhU3VDcrG/bDC+qzdAACTdgokU8OAn8p5Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsv4UNpwnB4EAg+6gDct7EVgm+squiC/sGr3/Lt5NYFqGAS+KR/iajZ9b8tMrvxIe
         Omhxm9WNp45frBxpy5ae6hkfj7e9lsb87ddge86Vr5bV3U3dtS5xgjlxDqk5B0EKDw
         ++c2Beg+gHeEjQEa9M3H+6e8ZC1BdGs5XQ7wq8rnSk+DEirD+/T6rYC47b/BDjCpK/
         wSnFhuVoRDj7MBnJ0JCmoSZkLjhMZapXM8qqnjJrRkEiRP+VeZZ3aa8XV4zfLw5cPN
         L5gt82zWa7Mwmv0nGjcO1wy8yR6FWURv311QZvH7W5gak8Amq8bXUL32zvAxIeM1S2
         RSLJrCoQ4uzfg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 2/3] mt76: testmode: remove unnecessary function calls in mt76_testmode_free_skb
Date:   Thu, 27 May 2021 13:35:29 +0200
Message-Id: <cd696dc6c2c600e14eadb1d652bc6507bdd8d5d3.1622115194.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622115194.git.lorenzo@kernel.org>
References: <cover.1622115194.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of unnecessary function calls in mt76_testmode_free_skb routine
since they are already managed by dev_kfree_skb

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/testmode.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index f40387a866ee..c516469278a4 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -88,17 +88,8 @@ static void
 mt76_testmode_free_skb(struct mt76_phy *phy)
 {
 	struct mt76_testmode_data *td = &phy->test;
-	struct sk_buff *skb = td->tx_skb;
-
-	if (!skb)
-		return;
-
-	if (skb_has_frag_list(skb)) {
-		kfree_skb_list(skb_shinfo(skb)->frag_list);
-		skb_shinfo(skb)->frag_list = NULL;
-	}
 
-	dev_kfree_skb(skb);
+	dev_kfree_skb(td->tx_skb);
 	td->tx_skb = NULL;
 }
 
-- 
2.31.1

