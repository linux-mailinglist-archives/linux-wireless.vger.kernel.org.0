Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5728B3D3D17
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhGWP0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:26:17 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:35046 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhGWP0Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:26:16 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.134])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2D4951C0069
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:06:49 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0BEF6BC0076
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:06:49 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6CAB713C2B3;
        Fri, 23 Jul 2021 09:06:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6CAB713C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627056392;
        bh=z3cqtBWOsuKPpBhC7NiveH0ejIQBP9y+NWL0MUedHrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skPKcf4LbPIY45+Hzglm9T2T3SK91s28bXg3O1g+cJs+8zF2D5Mfrl6Qp2xCIpvuF
         wtbcRCvzBTdPyQuTX/J/F+P+5NvYPCwo6OBtpOzjR7DBtMxMGCCNQ49RTNAcLW04iv
         dxc7RZWUlq0Y4K2F1jn2kXsGndDLvUQ+vdiP2/4s=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3 02/11] mt76 - mt7915:  Fix potential NPE in TXS processing.
Date:   Fri, 23 Jul 2021 09:06:14 -0700
Message-Id: <20210723160623.14709-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723160623.14709-1-greearb@candelatech.com>
References: <20210723160623.14709-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627056409-X1B98B5grv10
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

