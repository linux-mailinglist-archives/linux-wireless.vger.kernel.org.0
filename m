Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEF27D3B14
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjJWPmN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 11:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWPmL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 11:42:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3CDA9
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 08:42:03 -0700 (PDT)
X-UUID: b4806d1e71ba11eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Xqb3MLBilNqUzJ8uH0O8CsGoFH99xg5qZH04+7HCYSs=;
        b=NgRVJ8rKw5A8rl7jIQK9bQl7GdnH3FycLkGtHuFd9r646IhTVtpO6VeV7YrQqR6p0BbYuE7OSjCU+ktjWhLTDDAEYTSGSAi9L8QHvYSfSK0PFcSXSXuQaY5o36d6ircdXfz4mXmzfZGdEPP5mdE1p6ABPCaihYoPYWOFUQ8ZSzk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:04fcd858-76fe-4528-ad03-c50a0ed81522,IP:0,U
        RL:0,TC:0,Content:59,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:59
X-CID-META: VersionHash:5f78ec9,CLOUDID:cd95abfb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
        il,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR
        :NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b4806d1e71ba11eea33bb35ae8d461a2-20231023
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1645672579; Mon, 23 Oct 2023 23:42:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 23:41:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 23:41:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 06/11] wifi: mt76: mt7996: fix the size of struct bss_rate_tlv
Date:   Mon, 23 Oct 2023 23:38:49 +0800
Message-ID: <20231023153854.10708-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231023153854.10708-1-shayne.chen@mediatek.com>
References: <20231023153854.10708-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.297500-8.000000
X-TMASE-MatchedRID: jeHmhBrEiJeAy+S7L1wP4Xa57ruHAnHxSiliXIcwP3HrdFaCtcd713ln
        exxwwbXW6NDB1lA5UKvhihMBM8ipLOgU5Ipq9M1NsK+WWVTsOXVCX8V1FiRRkt9RlPzeVuQQ5zl
        dYRH+EtFEANm0QNhRHMpjK4dbPxs8HxPMjOKY7A+Wlioo2ZbGwdmzcdRxL+xwKrauXd3MZDU1Jp
        BASV0yCsAdn5jcjA5bzH9v/HFl9hYL564ITuXOf2UD8eE9N99VEkFGoocKwPG7EKDJDCCqwzvSu
        A0jF5ZL6nvl52G2VRDG7TI4kEpXzxdGg+ZY7eN6THB2Q+oKru8MTI34nyF36MJL1aANdU8KiTSg
        m8kJVKRDDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.297500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BC535A2C903C5559AA5EB15258151C7F450E9186B94EFBB191206C198C0BBB412000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

Align the format of struct bss_rate_tlv to the firmware.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index a2700151ee1c..d3ac6ac0e5c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -320,7 +320,7 @@ struct bss_rate_tlv {
 	u8 short_preamble;
 	u8 bc_fixed_rate;
 	u8 mc_fixed_rate;
-	u8 __rsv2[1];
+	u8 __rsv2[9];
 } __packed;
 
 struct bss_ra_tlv {
-- 
2.39.2

