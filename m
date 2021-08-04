Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42093E0236
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbhHDNoC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 09:44:02 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:45634 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237305AbhHDNn5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 09:43:57 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.131])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0DDD11A006D;
        Wed,  4 Aug 2021 13:43:44 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D9DBE980073;
        Wed,  4 Aug 2021 13:43:43 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id E8BCE13C2BE;
        Wed,  4 Aug 2021 06:43:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E8BCE13C2BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628084623;
        bh=bU73mEEwww77ytVjwwTS4bLHr2zHdFUzrol5MNUVIZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTZXwgsN4ssAhwZNM19uetKMDQx/e2QI+hmWeuurVHMasxM+gK2AnSqA4z6kbgSrY
         qbD+2/XmdNe2BXvKLPoLPSmC4FPwQ3kfkSgi4KY+aCXQOmj7yhavBkvZtPytWccEcw
         pHzSz+VV1fqJIt3QtcTu455mc4Thn71TsCMWtgWQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v4 11/11] mt76: mt7915: add a missing HT flag for GI parsing
Date:   Wed,  4 Aug 2021 06:43:37 -0700
Message-Id: <20210804134337.2582-9-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804134337.2582-1-greearb@candelatech.com>
References: <20210804134337.2582-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628084624-GXxAs0OYqgEi
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
index 7fc219c8f5e5..886dd71e18e3 100644
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

