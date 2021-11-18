Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5D4560C2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhKRQoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:44:30 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:34432 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233589AbhKRQo2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:44:28 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.137])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 65D101C0086
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:27 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3F2F614007C
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:27 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id D021413C2B1;
        Thu, 18 Nov 2021 08:41:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D021413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253665;
        bh=Efl75g3uCByOjMGB0d1n50V01YDyMJ9Ny3kUpf5/rtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/ptAnpWZMQKQ5CbLNyocCTMAU39QND0L/y//M9W/b21ksiKAR36IBhFcb8asMyPT
         +r6ym7KvjDioUP5W9BzMqBJbe1HL7MeNKtbU+gEuhBNren6SDtQDMaj6LzdS4Y5kSA
         iRAQpAVlhBvYG0yOeKQ6e2mH4K/7TdT1VQ7VM9rs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 02/11] mt76: mt7915: print out hw revision
Date:   Thu, 18 Nov 2021 08:40:47 -0800
Message-Id: <20211118164056.2965-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164056.2965-1-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253687-Ijmf-qjyRH1H
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
index 1f6ba306c850..fcc4312555f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -146,7 +146,7 @@ int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq)
 
 	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
-	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
-- 
2.20.1

