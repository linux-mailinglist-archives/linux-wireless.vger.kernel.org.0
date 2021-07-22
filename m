Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641DC3D2DA6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGVTsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 15:48:07 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:36872 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230266AbhGVTsG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 15:48:06 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.131])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 46C692006D
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 20:28:40 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 262F9980068
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 20:28:40 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id BDCF113C2B3;
        Thu, 22 Jul 2021 13:28:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BDCF113C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626985719;
        bh=9KKPZ6s3GCWcEHfupZyr9LoRQZBFKS/9ODda1ZddgQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3IRUGqHsCL/nWQgpL3w23wr5LcBQTjdLlMIRzOnioKAtSZ8aCDAUSIlm3+D8i23Y
         XdJ4PwuR9Zob2vv3/XUWQOwIdhXTBO2ZOO31cNlENa7pQuMQPes9rOSLFI7Ig4pHoT
         Xrg+QZ8ife163IGoW/goAknjNh+kvuQ5HBXTA2Y0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 02/11] mt76 - mt7915:  Fix potential NPE in TXS processing.
Date:   Thu, 22 Jul 2021 13:28:25 -0700
Message-Id: <20210722202834.6826-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722202834.6826-1-greearb@candelatech.com>
References: <20210722202834.6826-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626985720-aAIC5e-WkYiN
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
index 555a2f94d069..fb88332f19ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1321,7 +1321,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 	/* TODO:  Gather stats anyway, even if we are not matching on an skb. */
 	if (!skb)
-		goto out;
+		goto out_no_skb;
 
 	txs = le32_to_cpu(txs_data[0]);
 	txs5 = le32_to_cpu(txs_data[5]);
@@ -1427,6 +1427,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 out:
 	mt76_tx_status_skb_done(mdev, skb, &list, wcid);
+
+out_no_skb:
 	mt76_tx_status_unlock(mdev, &list);
 
 	return !!skb;
-- 
2.20.1

