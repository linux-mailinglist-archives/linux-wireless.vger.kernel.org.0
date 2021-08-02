Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F22D3DDC27
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhHBPRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 11:17:06 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:56188 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234750AbhHBPRF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 11:17:05 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.202])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7AF441C0077
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:16:54 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5941180089
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:16:54 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id EE99213C2B3;
        Mon,  2 Aug 2021 08:16:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EE99213C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627917414;
        bh=z3cqtBWOsuKPpBhC7NiveH0ejIQBP9y+NWL0MUedHrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVxN8+6zylEJ0C8FLEJl0cXoztI7qD/5oaVr+ZhyUV3MyPayVjS/MaHVfFoXGwvOT
         Fx/yqzc2r9UhBpO7nIQKf1qd29FwI2T3nZpncQmqucyG0wArDZz3GZ0RqvVLHOqrSB
         ZhHAvZBZOCJOG/KI7lahd5AWEkJ+uyeGzkaGoE+w=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v4 02/11] mt76: mt7915:  fix potential NPE in TXS processing
Date:   Mon,  2 Aug 2021 08:16:34 -0700
Message-Id: <20210802151643.32394-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802151643.32394-1-greearb@candelatech.com>
References: <20210802151643.32394-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627917415-AorLTaW3rYyq
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

If skb is null, then don't try to dereference it.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 35e4b57bd133..3f4e19358d5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1321,7 +1321,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 	/* TODO:  Gather stats anyway, even if we are not matching on an skb. */
 	if (!skb)
-		goto out;
+		goto out_no_skb;
 
 	txs = le32_to_cpu(txs_data[0]);
 	txs5 = le32_to_cpu(txs_data[5]);
@@ -1434,6 +1434,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 out:
 	mt76_tx_status_skb_done(mdev, skb, &list, wcid);
+
+out_no_skb:
 	mt76_tx_status_unlock(mdev, &list);
 
 	return !!skb;
-- 
2.20.1

