Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527B35B9614
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 10:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIOITk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 04:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIOITj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 04:19:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE312A88
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 01:19:36 -0700 (PDT)
X-UUID: cbbcb2d26e3c4693b609093bd257e8ab-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tfXQ2d35MrLc1v4GYZPeQpiq5HAopCVjNu6MieQbaYE=;
        b=EpPcpgjJqZmgfawJIXACcSrihnhaKvJukOPVyTL3Q+ta49NQ/VlYjUj1il7qX2LEmRGa3MGMpujNSzYVy0DmA+21dt+bTW4qG0r6CihH7qeSF0x6DVfO2iWwzJ5mSGiA+8OnuCLGxANMjitw5ikIAgXJXbZ7dSvDeuDClKr/Mi8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:a5f37e85-4c39-47ec-84be-0dd958ae2e61,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:a96a7ff6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: cbbcb2d26e3c4693b609093bd257e8ab-20220915
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 483143530; Thu, 15 Sep 2022 16:19:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 16:19:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Sep 2022 16:19:30 +0800
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
Subject: [PATCH] wifi: mac80211: fix decapsulation offload flag for WDS interface
Date:   Thu, 15 Sep 2022 16:19:17 +0800
Message-ID: <20220915081917.3409-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WDS interface whose iftype is NL80211_IFTYPE_AP_VLAN can not be
enabled rx decap offload because its offload_flags is not configured.
The offload_flags of wds interface shall be configured by checking
hardware information.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 net/mac80211/iface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 41531478437c..ea35a7cabd1a 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -865,6 +865,7 @@ static bool ieee80211_iftype_supports_hdr_offload(enum nl80211_iftype iftype)
 	/* P2P GO and client are mapped to AP/STATION types */
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_AP_VLAN:
 		return true;
 	default:
 		return false;
@@ -2120,6 +2121,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	/* setup type-dependent data */
 	ieee80211_setup_sdata(sdata, type);
+	ieee80211_set_sdata_offload_flags(sdata);
 
 	if (ndev) {
 		ndev->ieee80211_ptr->use_4addr = params->use_4addr;
-- 
2.18.0

