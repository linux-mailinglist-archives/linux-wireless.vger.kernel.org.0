Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0857D789E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 01:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJYXei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 19:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYXeh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 19:34:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22B13D
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 16:34:31 -0700 (PDT)
X-UUID: 0838c444738f11ee8051498923ad61e6-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qKS4mAxzCwofgV5lrkCv+67Ih4jlWyJk35U0DrEJjmE=;
        b=ATb1dGHLp8bZGIilV8/wOF5hhgypsrQ3FRkXE5HjEPE+BhKkWHs1k/rqMe6FN8ccwbDLUOESvyY4a+QLb3WXoMu4wEniAeTtUNPsdpWkiDeyu0zj+Ui/0Q/kA/XmN+LHFA1g5Qrw90xnqXQDwqsoPGMkQQMtxwtI9N/VHtIj1qU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:fad995c1-5e0f-4b1c-ac5b-792abb7b37a8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:9a8552d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0838c444738f11ee8051498923ad61e6-20231026
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 369469362; Thu, 26 Oct 2023 07:34:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 07:34:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 07:34:23 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7915: fix missing CH144 support for mt7915 pre-calibration
Date:   Thu, 26 Oct 2023 07:34:21 +0800
Message-ID: <30c279a4c3d937a592f95951ec22c8591b24e275.1698274193.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <f21b261373fc221b8370264c44ee751fa85cf41c.1698274193.git.ryder.lee@mediatek.com>
References: <f21b261373fc221b8370264c44ee751fa85cf41c.1698274193.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.565200-8.000000
X-TMASE-MatchedRID: 8d+rTuw6A/ZYXTxImR5ZvAPZZctd3P4B7f6JAS2hKPg3nZaS9VtZrqPF
        jJEFr+olwXCBO/GKkVr3FLeZXNZS4EZLVcXaUbdiuR7xzqovR/1Di9mwshcj9kaBOIZIqgk0Shp
        LTU8kT8ieqD9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.565200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 35BD9C14BD588542D622D01B6322A5A8C56C379A6B195B0D85543D01262456772000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sync from MTK SDK. The current mt7915 pre-calibration data lacks CH144@BW20
so we fallback to apply adjacent channel's data as an alternative.

Fixes: 495184ac91bb ("mt76: mt7915: add support for applying pre-calibration data")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index da3ee9f91704..01f208fec73e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2990,6 +2990,8 @@ static int mt7915_dpd_freq_idx(struct mt7915_dev *dev, u16 freq, u8 bw)
 	if (is_mt7915(&dev->mt76)) {
 		freq_list = freq_list_v1;
 		n_freqs = ARRAY_SIZE(freq_list_v1);
+		/* NOTE: apply adjacent channel data for the missing ch144 */
+		freq = (freq == 5720) ? 5700: freq;
 	} else {
 		freq_list = freq_list_v2;
 		n_freqs = ARRAY_SIZE(freq_list_v2);
-- 
2.39.0

