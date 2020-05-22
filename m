Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0011DE0E0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 09:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgEVH0X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 03:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgEVH0X (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 03:26:23 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8310A206DD;
        Fri, 22 May 2020 07:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590132382;
        bh=2ER8hK1ngIR33j7JGASFvizqrHdB2q7UTVDmEDsJwfk=;
        h=From:To:Cc:Subject:Date:From;
        b=SgmSakqogMFzvQgYeKazsX+rvxnEswIODVwP/HpY+RW8Nt+x8TWKSZv4TgOFx7Cnb
         oFTcwyMJOO0KZ377zxvaxA7Y8g58qcr+4XxWjnWP4EITXcXiB7a4XXxPlDy7kBb+5U
         MRITvhiJh3h9DqZza99uZVFCaHWNWkB4eZOGDc9U=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        dan.carpenter@oracle.com
Subject: [PATCH] mt76: mt7915: fix possible NULL pointer dereference in mt7915_register_ext_phy
Date:   Fri, 22 May 2020 09:26:06 +0200
Message-Id: <a03171996da0aaaa0963a4704b6d59be818bd42f.1590132235.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a NULL pointer dereference in mt7915_register_ext_phy since phy
data structure is allocated by mt76_alloc_phy routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
- I have just compile tested this patch
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6f200ab3ac28..aadf56e80bae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -592,7 +592,6 @@ int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	if (phy)
 		return 0;
 
-	INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
 	mt7915_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7915_ops);
 	if (!mphy)
@@ -605,6 +604,8 @@ int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
 	mt7915_init_wiphy(mphy->hw);
 
+	INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
+
 	/*
 	 * Make the secondary PHY MAC address local without overlapping with
 	 * the usual MAC address allocation scheme on multiple virtual interfaces
-- 
2.26.2

