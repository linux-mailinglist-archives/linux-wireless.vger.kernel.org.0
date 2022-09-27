Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8065EBECC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiI0Jie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 05:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI0Jid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 05:38:33 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7DFAC5A
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Adedgf97b3n0lmH8f5kcXgL8hQ1VGagRnrDZF/+PSsU=; b=WlJorLFOVsZnsp5oogaVcfZ9++
        pwA//vDPuXStSV8IlkvSJtsrjhtMn3MLONx78jK+5lKizEPnVaVvMY6CzVRXs4hed6ekis1FqlcbC
        Yg+A/XWi756ibx2WbNP/vK5VWO9xZxjVTxWdj5vRORkEIDDOtKVo4WifYkISPbXTPLuc=;
Received: from p200300daa7301d0091ae78e8b65b5c8e.dip0.t-ipconnect.de ([2003:da:a730:1d00:91ae:78e8:b65b:5c8e] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1od72q-0085yP-Te; Tue, 27 Sep 2022 11:38:28 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, Jonas Jelonek <jelonek.jonas@gmail.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH 6.0] wifi: mt76: fix rate reporting / throughput regression on mt7915 and newer
Date:   Tue, 27 Sep 2022 11:38:23 +0200
Message-Id: <20220927093823.6007-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7915 and newer need to report the rate_info that's stored in wcid->rate,
since they don't fill info->status.rates.

Cc: Jonas Jelonek <jelonek.jonas@gmail.com>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/all/CABXGCsP0znm9pS-MiKtyxTXR7XiyFVqen0qzNpicGHDZKCzbwg@mail.gmail.com/
Fixes: 44fa75f207d8 ("mac80211: extend current rate control tx status API")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index e67cc7909bce..6c054850363f 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -60,14 +60,20 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 			.skb = skb,
 			.info = IEEE80211_SKB_CB(skb),
 		};
+		struct ieee80211_rate_status rs = {};
 		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 		struct mt76_wcid *wcid;
 
 		wcid = rcu_dereference(dev->wcid[cb->wcid]);
 		if (wcid) {
 			status.sta = wcid_to_sta(wcid);
-			status.rates = NULL;
-			status.n_rates = 0;
+			if (status.sta && (wcid->rate.flags || wcid->rate.legacy)) {
+				rs.rate_idx = wcid->rate;
+				status.rates = &rs;
+				status.n_rates = 1;
+			} else {
+				status.n_rates = 0;
+			}
 		}
 
 		hw = mt76_tx_status_get_hw(dev, skb);
-- 
2.36.1

