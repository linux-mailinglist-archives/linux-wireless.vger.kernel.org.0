Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D3D60EDA9
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 03:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiJ0B5M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 21:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiJ0B5L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 21:57:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD6412790A
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 18:57:09 -0700 (PDT)
X-UUID: 6215d7b22aca4b71b6a227d459f5cdf7-20221027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=coRe6aFtKEJ8SucS8fOYdsHKCX19NW/bW5k33DfhxmU=;
        b=dlhDA3LWZ6IUXr5huF5BtYFiAXY0kXlFbTz6Az/DNHGjlXHwDfyTAy6aDrcdvtUWjKQfiDMXZuUp47lVXEW0HiY2DGy0Y4SC6qcrXC+pWyxswUfy3O8Jb0it3HtgPfePqJqiEJsbmUeryCWvf7+E6VZ1YHZQKCV0KuMfy/DetUQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:18415d3e-74db-4604-8dfe-d49173641cc0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:c57b4227-9eb1-469f-b210-e32d06cfa36e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6215d7b22aca4b71b6a227d459f5cdf7-20221027
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 947070416; Thu, 27 Oct 2022 09:57:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 27 Oct 2022 09:57:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 27 Oct 2022 09:57:01 +0800
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
Subject: [PATCH] wifi: mac80211: Set TWT Information Frame Disabled bit as 1
Date:   Thu, 27 Oct 2022 09:56:53 +0800
Message-ID: <20221027015653.1448-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The TWT Information Frame Disabled bit of control field of TWT Setup
frame shall be set to 1 since handling TWT Information frame is not
supported by current mac80211 implementation.

Fixes: f5a4c24e689f ("mac80211: introduce individual TWT support in AP mode")

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 net/mac80211/s1g.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index 8ca7d45d6daa..cb2ab8fd4848 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -111,6 +111,8 @@ ieee80211_s1g_rx_twt_setup(struct ieee80211_sub_if_data *sdata,
 					 IEEE80211_TWT_REQTYPE_SETUP_CMD);
 		goto out;
 	}
+	/* TWT Information not supported yet */
+	twt->control |= IEEE80211_TWT_CONTROL_RX_DISABLED;
 
 	drv_add_twt_setup(sdata->local, sdata, &sta->sta, twt);
 out:
-- 
2.18.0

