Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA441B2BD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbhI1PQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241317AbhI1PQh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FE8C61215;
        Tue, 28 Sep 2021 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842098;
        bh=P6aNT/XmsmPvO9K6vASy3El9X46ZEh5CsV6zOkFmZSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=INynF2tnxa1/lixIjJL9oMijCq0TktX/VWZpol8Egdmc74w9sdZmhl2sBdInhc969
         uQ1ikLHinJVzwiNFqf4lw/InLDSHMbLZFGAFA7x7XBSoa2oFf1942+KBcQfSMzeRTU
         GZD8Z42BPA9Wx7xBzcpdOqxkZQkTAZIY9h+DdvZNUj52jkCAkyUfohTB1xBC060Wrq
         lIauD24cTTpeUfc0Xli7sqQzph/PB1qda7FY6H71GAU0U35uS6lp68ts5aLxiDKJDW
         PY7MFEjnN/llidUQz2ROowPtfjV98kqqcTU2Ei2kh7K2yXjdGQHMFc6OrdT79slfuS
         PtYvCEezzR9wA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com, john@phrozen.org
Subject: [RFC 5/7] mt76: mt7915: enable radar trigger on rdd2
Date:   Tue, 28 Sep 2021 17:14:36 +0200
Message-Id: <21560158742739808b76cc11f009c5844df803be.1632841652.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632841652.git.lorenzo@kernel.org>
References: <cover.1632841652.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable radar trigger for rdd2 in mt7915_radar_trigger.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index df8a498429df..2c010221e32d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -75,7 +75,10 @@ mt7915_radar_trigger(void *data, u64 val)
 {
 	struct mt7915_dev *dev = data;
 
-	return mt7915_mcu_rdd_cmd(dev, RDD_RADAR_EMULATE, 1, 0, 0);
+	if (val > MT_RX_SEL2)
+		return -EINVAL;
+
+	return mt7915_mcu_rdd_cmd(dev, RDD_RADAR_EMULATE, val, 0, 0);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
-- 
2.31.1

