Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E95643ABF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 02:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiLFBbX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 20:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiLFBbW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 20:31:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76411DF18
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 17:31:17 -0800 (PST)
X-UUID: d5a96852ef3e47eea8b3fda4a94841aa-20221206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wbpioN3xNi12SHYXm+gVI9vtQJKRQ4476AIpQhNmcEM=;
        b=PM8sKPZDRAxzxo1VPb7z/sraYWmUaI9xUZfDyiDBRz75GeKzYiRI4g4wVWw+amuhQSCe1kyabE4I2+geKsC/nZn5U7D8ca03EtYWU8nV5TcWJP2mA/gqhVgPa9biJPGBqEb5B8pfEeZA4bBD9TMcsoYVVxLqizuVPqq+UCeOYew=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:80c577b0-b53b-437c-aed6-6570775dc94f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.14,REQID:80c577b0-b53b-437c-aed6-6570775dc94f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:dcaaed0,CLOUDID:0b6f6524-4387-4253-a41d-4f6f2296b154,B
        ulkID:221206093112MA6FGUV1,BulkQuantity:0,Recheck:0,SF:28|16|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d5a96852ef3e47eea8b3fda4a94841aa-20221206
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 689211426; Tue, 06 Dec 2022 09:31:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 6 Dec 2022 09:31:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 6 Dec 2022 09:31:10 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH 0/3] wifi: mt76: mt7915: rework thermal protection
Date:   Tue, 6 Dec 2022 09:29:48 +0800
Message-ID: <20221206012951.10719-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

*** BLURB HERE ***

Howard Hsu (3):
  wifi: mt76: mt7915: rework mt7915_thermal_set_cur_throttle_state()
  wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only
    after init_work
  wifi: mt76: mt7915: rework mt7915_mcu_set_thermal_throttling()

 .../net/wireless/mediatek/mt76/mt7915/init.c  | 21 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  5 +++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 17 ++++++++-------
 3 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.18.0

