Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D83E9A80
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhHKVpp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:45 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:52186 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232196AbhHKVpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:17 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.134])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 571241A0074
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3767D680084
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CC95D13C2B4;
        Wed, 11 Aug 2021 14:44:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CC95D13C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718289;
        bh=DMRDbnlxyZFlpGiwIUM23IfKeuuBR+iwrwp8Vyq3Bac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GltY4wpvP5HXeLOwSApz4szrlWlq8t/4wlKQ4e8B+oD8cdizsvSpZ1s172/BQZFd6
         3KukqNADgN08seRwrWEb95yN9ykMMnuJaVNGbaU6gHFRXz4hFslGfgIRPsIcwTpPg7
         PByRdmHnc+V5tSA7nS8WTRRQOfxaiD+m+zufNyLk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 02/15] mt76: mt7915:  print out hw revision
Date:   Wed, 11 Aug 2021 14:44:26 -0700
Message-Id: <20210811214439.17458-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718290-uz5VEtC5oaJc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Help determine what version of silicon is in use.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index af712a936ef6..34febe09f071 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -144,7 +144,7 @@ int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq)
 
 	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
-	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
-- 
2.20.1

