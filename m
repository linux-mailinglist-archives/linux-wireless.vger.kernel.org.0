Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF823D01A1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhGTRp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 13:45:59 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:46664 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234902AbhGTRmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 13:42:44 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.203])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8BFAC1C0063;
        Tue, 20 Jul 2021 18:23:02 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 59D0EAC007E;
        Tue, 20 Jul 2021 18:23:02 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C1E8E13C340;
        Tue, 20 Jul 2021 11:23:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C1E8E13C340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626805381;
        bh=K4cCI8cWHJPByH2GhB7exI7iSrROXfCMgKjIF0B95vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7reA1eZ2nzGl4Kty+0if5fQ3NvTv9GlXgoceOVI9mE4rjbppJ2iMNP6CJOJKX1rn
         pRa1EODvh5eA1IDbInkpjoZ7DYz4bVAgGf40O0+Oc2pvA6WhI0GHqDRCYTlkJnOrId
         YCgjwPc7Y6TNMQmbWyrFjNYulpASEsiagjxCouFE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 11/11] mt76: mt7915: add a missing HT flag for GI parsing
Date:   Tue, 20 Jul 2021 11:22:55 -0700
Message-Id: <20210720182256.30536-11-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720182256.30536-1-greearb@candelatech.com>
References: <20210720182256.30536-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626805383-Uk9dUq9TDDzM
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
index e77341ca127c..cd8179331e28 100644
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
@@ -225,7 +226,6 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 				msta->wcid.rate_short_gi = 0;
 			}
 		}
-		/* TODO:  Deal with HT_MCS */
 	}
 
 	rcu_read_unlock();
-- 
2.20.1

