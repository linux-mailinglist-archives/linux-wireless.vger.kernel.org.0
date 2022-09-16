Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376735BAF64
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIPO2S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiIPO1u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 10:27:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA5B56E0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 07:27:26 -0700 (PDT)
X-UUID: 0d4256b77da94cf3b60da6ec1447e0a8-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4LVjjoBtKIVD5H3vawJme1nq7gxmF4DCA9ujlSFbYU0=;
        b=K+yy8oMIwAhhl/2fgQRxyebs7QACwu3OPDdgNyORbYL7vS8+q83qo07y2MAyrPlKZAMNgcqFuW9LvODNRc25sZby5VmMSx6uDKO5RGvf7fewiQGGcT6JyAECKVqrNkR4TIUx2Az+SEzmnhWCErX+1rnyCN2bsktH7GhCsb8Myvw=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:e7b40999-5497-4eeb-a2e1-185d80a2cb3c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.11,REQID:e7b40999-5497-4eeb-a2e1-185d80a2cb3c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:39a5ff1,CLOUDID:af45abf6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:220916222721S8ED73WE,BulkQuantity:0,Recheck:0,SF:28|16|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 0d4256b77da94cf3b60da6ec1447e0a8-20220916
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1359109791; Fri, 16 Sep 2022 22:27:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 22:27:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Sep 2022 22:27:18 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH v2] wifi: mac80211: fix decapsulation offload flag for WDS interface
Date:   Fri, 16 Sep 2022 22:27:07 +0800
Message-ID: <20220916142707.28478-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rx decapsulation offload cannot be enabled on WDS interface since its
offload_flags is not configured. Its offload_flags shall be configured
by checking hardware information.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
v2:
   - Configure offload_flags in ieee80211_check_fast_rx
   - Update commit message
---
 net/mac80211/rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a57811372027..0d8cfe34b088 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4433,6 +4433,16 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
 	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
 		goto clear;
 
+	if (ieee80211_hw_check(&local->hw, SUPPORTS_RX_DECAP_OFFLOAD)) {
+		sdata->vif.offload_flags |= IEEE80211_OFFLOAD_DECAP_ENABLED;
+
+		if (local->monitors &&
+		    !ieee80211_hw_check(&local->hw, SUPPORTS_CONC_MON_RX_DECAP))
+			sdata->vif.offload_flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
+	} else {
+		sdata->vif.offload_flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
+	}
+
 	rcu_read_lock();
 	key = rcu_dereference(sta->ptk[sta->ptk_idx]);
 	if (!key)
-- 
2.18.0

