Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2883D3D20
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhGWP0i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:26:38 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:38334 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhGWP0h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:26:37 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.132])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1F1EB1C006E;
        Fri, 23 Jul 2021 16:07:10 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E724750007D;
        Fri, 23 Jul 2021 16:07:09 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id F2B8913C340;
        Fri, 23 Jul 2021 09:06:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F2B8913C340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627056397;
        bh=3Bh+q8ysjWIhMaXB7TFJuyYqlIc4Vno4/+eMzxvGXXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JO+Pr/e15nn6Fpuwhbp7/S+IM21X+fDmxZTEIxqNWhtZ9hqpSmy3hkAti9o5DF5oJ
         UO77QyubxQmsrR1c3eV1wJYxoRD/mzJUh2CUabcOjrvnsjsW81+6+OHlfORTnhzLKo
         EFeU8Pom/oOXpuTehkoTnjy3Tzxt+cKVqw7P7sgI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 11/11] mt76: mt7915: add a missing HT flag for GI parsing
Date:   Fri, 23 Jul 2021 09:06:23 -0700
Message-Id: <20210723160623.14709-11-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723160623.14709-1-greearb@candelatech.com>
References: <20210723160623.14709-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627056430-KZ9ldtQMxTtB
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

The previous commit missed a HT flag.

Fixes: 14b220c07188 ("mt76: mt7915: report tx rate directly from tx status")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index bef116445119..77620404ab7a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -215,7 +215,8 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 
 			rate->he_gi = (val & (0x3 << offs)) >> offs;
 			msta->wcid.rate_he_gi = rate->he_gi; /* cache for later */
-		} else if (rate->flags & RATE_INFO_FLAGS_VHT_MCS) {
+		} else if (rate->flags &
+			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
 			if (val & BIT(12 + bw)) {
 				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 				msta->wcid.rate_short_gi = 1;
@@ -224,7 +225,6 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 				msta->wcid.rate_short_gi = 0;
 			}
 		}
-		/* TODO:  Deal with HT_MCS */
 	}
 
 	rcu_read_unlock();
-- 
2.20.1

