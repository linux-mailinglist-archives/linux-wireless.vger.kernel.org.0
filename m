Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575BD54D12
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 13:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfFYLBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 07:01:30 -0400
Received: from nbd.name ([46.4.11.11]:33640 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfFYLBa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 07:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VD1PtIB2Zg/LDHXQFp/zt3ZA5HelH5AA1RvvecntbBc=; b=cVrY6zrpyL2Q8t12JZCM9zZXk/
        eQKmVbmDaiitkpDZu2INGAxxrNJWDDp7yZeVSXJLl92JKzchPk7gXsU4s/bOOG5djBu56HlYkFSiu
        fsLas6R0mE9tY4j6//G33w0iUTduJPBsUf/qL+PlDf8QkUOmaZRlOl1+V4Xy2idAbP3k=;
Received: from p5b2063ee.dip0.t-ipconnect.de ([91.32.99.238] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hfjCb-0004oF-CK
        for linux-wireless@vger.kernel.org; Tue, 25 Jun 2019 13:01:29 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id DE3725F9A1A0; Tue, 25 Jun 2019 13:01:23 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7603: improve hardware rate switching configuration
Date:   Tue, 25 Jun 2019 13:01:23 +0200
Message-Id: <20190625110123.12979-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190625110123.12979-1-nbd@nbd.name>
References: <20190625110123.12979-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now that tx status reporting can figure out the first attempted rate, we can
make switching from lower rates to higher rates more conservative.
This reduces retries under bad link conditions and ensures that fallback
rates get more test coverage

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/init.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index d666e26afe90..357db811ad32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -227,7 +227,16 @@ mt7603_mac_init(struct mt7603_dev *dev)
 	mt76_rmw_field(dev, MT_LPON_BTEIR, MT_LPON_BTEIR_MBSS_MODE, 2);
 	mt76_rmw_field(dev, MT_WF_RMACDR, MT_WF_RMACDR_MBSSID_MASK, 2);
 
-	mt76_wr(dev, MT_AGG_ARUCR, FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 7));
+	mt76_wr(dev, MT_AGG_ARUCR,
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 7) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(2), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(3), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(4), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(5), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(6), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), 1));
+
 	mt76_wr(dev, MT_AGG_ARDCR,
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), MT7603_RATE_RETRY - 1) |
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), MT7603_RATE_RETRY - 1) |
-- 
2.17.0

