Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6A43E0239
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhHDNp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 09:45:28 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:51214 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237305AbhHDNp1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 09:45:27 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.48.6])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8610BA007A
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:45:13 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5AA05900070
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:45:13 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id DDF8813C2B3;
        Wed,  4 Aug 2021 06:45:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DDF8813C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628084713;
        bh=b1mC2DKUHLb37d1cgZWWuKWOQLvZD/Gh4rxmvKoYItQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdY9JdRL7k7/4DG46ur2HMFUbkrdPznWkny2+EtrLji10MCc9a1ThXgxSSgtsLYC3
         izAtamTTcVFtm43XkKYIliOrrARxvMYjHIeJ/gHvBTVfKWfPcZ+VPriC1kZbStLRkI
         ngoj3SMerYb98ikbMTw4q+RsbOnFuf6QY4gapaK0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v5 02/11] mt76: mt7915:  fix potential NPE in TXS processing
Date:   Wed,  4 Aug 2021 06:44:56 -0700
Message-Id: <20210804134505.3208-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804134505.3208-1-greearb@candelatech.com>
References: <20210804134505.3208-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628084714-YwQpMPUB5StV
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
index 8f5702981900..b568d6baa768 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1321,7 +1321,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 	/* TODO:  Gather stats anyway, even if we are not matching on an skb. */
 	if (!skb)
-		goto out;
+		goto out_no_skb;
 
 	txs = le32_to_cpu(txs_data[0]);
 
@@ -1427,6 +1427,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 out:
 	mt76_tx_status_skb_done(mdev, skb, &list, wcid);
+
+out_no_skb:
 	mt76_tx_status_unlock(mdev, &list);
 
 	return !!skb;
-- 
2.20.1

