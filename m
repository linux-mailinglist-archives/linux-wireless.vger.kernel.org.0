Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B93666E6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGLGUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 02:20:48 -0400
Received: from nbd.name ([46.4.11.11]:33148 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfGLGUr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 02:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=23LjpPgN5F8cAOkx1vRlBymaEP8nqi+hNZgyezn4g1o=; b=tJT+3DtuiJ4ae2uiCy9Dp/XU5f
        mO70B76/yMdOH+hKDojwZOrUCulHeSZg3IKszAkgjgojtYYqz78PvHfXzT2dzmHK8jBs93t6VDPzb
        KMuYUHH9i89rgC+RZg4o3R1OxTHvqRANpPyeN2Uqnnz1w+zjGnkUMKcxc4NMDGCQG0BE=;
Received: from p54ae9abd.dip0.t-ipconnect.de ([84.174.154.189] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hlovG-0003rd-BI
        for linux-wireless@vger.kernel.org; Fri, 12 Jul 2019 08:20:46 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id 9C7F961C52AA; Fri, 12 Jul 2019 08:20:45 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] mt76: mt7615: fix invalid fallback rates
Date:   Fri, 12 Jul 2019 08:20:44 +0200
Message-Id: <20190712062045.85109-3-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190712062045.85109-1-nbd@nbd.name>
References: <20190712062045.85109-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only decrement the rate index on duplicate rates if it is not already 0

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index fc98dabed594..b3e8ee06a783 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -503,6 +503,9 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			     IEEE80211_TX_RC_160_MHZ_WIDTH))
 				continue;
 
+			if (!rates[i].idx)
+				continue;
+
 			rates[i].idx--;
 		}
 
-- 
2.17.0

