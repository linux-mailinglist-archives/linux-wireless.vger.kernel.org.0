Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6B628E04
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 01:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiKOALl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 19:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiKOALh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 19:11:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912F4FCD
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 16:11:32 -0800 (PST)
X-UUID: dd55df912c144a4cb660d6cdf5a2c005-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZuTPGR86r7bVaysdVG23npwmtpOuYDbcCm2ae20sKio=;
        b=SINjGUZtURHmBqZjWBpX7E0X8z+qY0jxgFDKA5q5kmpYDNU03Pix6zSJN/rThwP1BC/UI81ndT55t/kRdASNr8Sh83DRsL2ItWZNOXlIPMbaLKU+qWQ0kAGRaQoZXE40bkxJv3ZMsdl2lBVXRHOAfpAxvI76kKU693ZCy3OyYwY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:5742ed2a-cd92-4764-89f0-b9f4d6bb8fa0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:b1178073-e2f1-446d-b75e-e1f2a8186d19,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: dd55df912c144a4cb660d6cdf5a2c005-20221115
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1818495253; Tue, 15 Nov 2022 08:11:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 15 Nov 2022 08:11:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 15 Nov 2022 08:11:25 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Sean Wang" <objelf@gmail.com>
Subject: [PATCH v4 0/7] wifi: mt76: mt7921: introduce chanctx support
Date:   Tue, 15 Nov 2022 08:11:22 +0800
Message-ID: <cover.1668467719.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <objelf@gmail.com>

Update the driver to adapt the new firmware can have the capability to
manage the channel context scheduling on multiple roles running on the
device including Station, AP and P2P GC/GO mode (will be extended based
on the future patchset) to help users sharing the network with others
on a single device.

=== v2 ===
(at 1/7)
1. remove unneeded newline
2. squash this one with "wifi: mt76: connac: rely on
   mt76_connac_mcu_uni_set_chctx"

(at 3/7)
1. remove unneeded newline and use 'u8 rsv' instead of origin one

(at 4/7)
1. drop mt7921_mcu_bss_event that is unused any more

(at 6/7)
1. move mt7921_check_offload_capability prior to ieee80211_alloc_hw
   and decie what ieee80211_ops instance we should use by the
   firmware capability bit.

(at 7/7)
1. decide the feature by the firmware capability bit
2. decide the channel by the hardware value in
   mt7921_get_status_freq_info()

=== v3 ===

(at 6/7)
1. fix mt7921/usb.c:231:7: error: no member named 'ops' in
   'struct mt7921_dev'
2. fix mt7921/main.c:425:13: warning: variable 'err' set but not used
   [-Wunused-but-set-variable]
3. fix mt7921/init.c:173:9: warning: variable 'features' is used
   uninitialized whenever 'while' loop exits because its condition is false
   [-Wsometimes-uninitialized]

(at 7/7)
1. enhance the git message

== v4 ===

(at 1/2 and 2/2)

1. reuse mt7921_ops to set up ieee80211 ops for chanctx
2. drop the patch 1/7 to 5/7 as they are being merged

Sean Wang (2):
  wifi: mt76: mt7921: introduce remain_on_channel support
  wifi: mt76: mt7921: introduce chanctx support

 .../net/wireless/mediatek/mt76/mt7921/init.c  |  90 ++++++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   8 -
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 223 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  24 ++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  49 ++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  40 +++-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  30 ++-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  20 +-
 8 files changed, 458 insertions(+), 26 deletions(-)

-- 
2.25.1

