Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587953E0241
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 15:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhHDNpc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 09:45:32 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:34046 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238289AbhHDNp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 09:45:28 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.175])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4FD002A0072;
        Wed,  4 Aug 2021 13:45:15 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1405F8C0082;
        Wed,  4 Aug 2021 13:45:15 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A6D5013C2B3;
        Wed,  4 Aug 2021 06:45:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A6D5013C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628084714;
        bh=bU73mEEwww77ytVjwwTS4bLHr2zHdFUzrol5MNUVIZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kc+ESFFjdKjiecBAp6yYD27A/VMR/78jZvO/Pp14fy5iLvFy2s0s5sYi3SWPGCDGq
         mCZJxFwX/yMEEsiLRJI8/ii5sOh484JtAGgiBMqbfvqZc3XWJwx0MG7Pp0Dw3OI7x2
         izMQdAuu9ZlfkRRP2Jxd6V3ehuHXzSZZHR5mBXZk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v5 11/11] mt76: mt7915: add a missing HT flag for GI parsing
Date:   Wed,  4 Aug 2021 06:45:05 -0700
Message-Id: <20210804134505.3208-11-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804134505.3208-1-greearb@candelatech.com>
References: <20210804134505.3208-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628084715-OOlpPWrP2s54
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

