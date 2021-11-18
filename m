Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A24560C5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhKRQog (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:44:36 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:39906 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233608AbhKRQof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:44:35 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.166])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 66C6F20061
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:34 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3BE9B90007F
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:34 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id B6AA613C2BC;
        Thu, 18 Nov 2021 08:41:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B6AA613C2BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253667;
        bh=cz7hdPYqV1/6OZEcKtZ46vixX5rQ2uVZjynkomjDlQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XY9/ZrBy8QLVf6Pmnr3599YMX643L59Bjk7LE0bXXrpZ9ZvGvflMeKDB2iOaLik+J
         umxbXWLDdgq/kOzjBRykdMzP7rndjKx/SHZYG+rP2rEa5lOHOsWuEyLPSl9PgNcz6Q
         od3n1tL7+/Lmy++f1yvX5J9CaMB+RMuec2H9R278=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 11/11] mt76: mt7915: poll mib counters every 200ms
Date:   Thu, 18 Nov 2021 08:40:56 -0800
Message-Id: <20211118164056.2965-11-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164056.2965-1-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253694-HEkbK62m7M2f
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Instead of every 500ms, this will do better job of catching wraps
of 16-bit pkt counters.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3c89c7573015..7cfa6b2abda5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2390,7 +2390,11 @@ void mt7915_mac_work(struct work_struct *work)
 	mutex_lock(&mphy->dev->mutex);
 
 	mt76_update_survey(mphy);
-	if (++mphy->mac_work_count == 5) {
+
+	/* this method is called about every 100ms.  Some pkt counters are 16-bit,
+	 * so poll every 200ms to keep overflows at a minimum.
+	 */
+	if (++mphy->mac_work_count == 2) {
 		mphy->mac_work_count = 0;
 
 		mt7915_mac_update_stats(phy);
-- 
2.20.1

