Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACAD392CD4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 May 2021 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhE0LhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 07:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233040AbhE0LhM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 07:37:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8579613D1;
        Thu, 27 May 2021 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622115339;
        bh=gjhnBhOTi7Awsd2npnMhdrKrxykt+cNqv4JP9FPfc9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQbasv6AFfeCbJYlp74JDnwxVfC3YQHA3l1Miteve49U6r+pOZ4Jp2FV2tQzbyEQV
         O4kUSTSusg69jjbLkcXxF+ZQnX2/2t4dCs7riPQcACL/hOiXiLqdegw38Uv0cPnlzl
         txkFhUHY4fIKXMf3fgC68rkWgpX3tDmojD1W3GGqPdpaG8ophkXGgzSiuVxt6Ga8f0
         stCgffTxTVMjLR3p7gY2CpH/ejgBLUafD+gW89ak7bS296eqNSTSVlSBdfLjtX0pYq
         mPdo1kY8meQi/Ayz5zsfyKmi5KOnkHkIlfrxuV4mx0AFqVWPQ0789MI+Y1s8A8tPp8
         Iv4D3ccvyN5Gg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 1/3] mt76: testmode: fix memory leak in mt76_testmode_alloc_skb
Date:   Thu, 27 May 2021 13:35:28 +0200
Message-Id: <71df955d0c971505a872cd37eb365d002046b915.1622115194.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622115194.git.lorenzo@kernel.org>
References: <cover.1622115194.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Free all pending frames in case of failure in mt76_testmode_alloc_skb
routine

Fixes: 2601dda8faa76 ("mt76: testmode: add support to send larger packet")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/testmode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 001d0ba5f73e..f40387a866ee 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -158,8 +158,11 @@ int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
 			frag_len = MT_TXP_MAX_LEN;
 
 		frag = alloc_skb(frag_len, GFP_KERNEL);
-		if (!frag)
+		if (!frag) {
+			mt76_testmode_free_skb(phy);
+			dev_kfree_skb(head);
 			return -ENOMEM;
+		}
 
 		__skb_put_zero(frag, frag_len);
 		head->len += frag->len;
-- 
2.31.1

