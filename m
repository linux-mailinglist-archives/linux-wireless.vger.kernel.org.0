Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571885640B8
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiGBOal (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 10:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiGBOak (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 10:30:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978CAEE12
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 07:30:34 -0700 (PDT)
X-UUID: e9b7289f7876430eb8cb35bc687af447-20220702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:ba845107-e158-44bc-be3c-a849ea61bfab,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.7,REQID:ba845107-e158-44bc-be3c-a849ea61bfab,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:87442a2,CLOUDID:8baf5d86-57f0-47ca-ba27-fe8c57fbf305,C
        OID:ce46dbe8f406,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e9b7289f7876430eb8cb35bc687af447-20220702
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1495510867; Sat, 02 Jul 2022 22:30:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 2 Jul 2022 22:30:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 2 Jul 2022 22:30:25 +0800
Message-ID: <4b135d37fc8b9a9ee3a8674126c76c1c45b02054.camel@mediatek.com>
Subject: Re: [PATCH 0/5] mt76: add the capability to support more than two
 phys
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, <nbd@nbd.name>
CC:     <lorenzo.bianconi@redhat.com>, <linux-wireless@vger.kernel.org>,
        <evelyn.tsai@mediatek.com>, <sean.wang@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>
Date:   Sat, 2 Jul 2022 22:30:25 +0800
In-Reply-To: <cover.1656624320.git.lorenzo@kernel.org>
References: <cover.1656624320.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-06-30 at 23:41 +0200, Lorenzo Bianconi wrote:
> Introduce the capability to support more than two mt76_phys.
> This is a preliminary series to add mt7990 support.
> 
> Lorenzo Bianconi (5):
>   mt76: add phy_idx in mt76_rx_status
>   mt76: introduce phys array in mt76_dev structure
>   mt76: add phy_idx to mt76_wcid
>   mt76: convert MT_TX_HW_QUEUE_EXT_PHY to MT_TX_HW_QUEUE_PHY
>   mt76: get rid of mt76_wcid_hw routine
> 
>  drivers/net/wireless/mediatek/mt76/dma.c      |  9 ++-
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 27 ++++----
>  drivers/net/wireless/mediatek/mt76/mt76.h     | 67 ++++++++++-------
> --
>  .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +-
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 44 ++++++------
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +-
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 32 +++++----
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
>  .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 15 +++--
>  .../wireless/mediatek/mt76/mt76_connac_mac.c  | 12 ++--
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +-
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 ++++---
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +-
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 25 +++----
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +-
>  drivers/net/wireless/mediatek/mt76/testmode.c |  5 +-
>  drivers/net/wireless/mediatek/mt76/tx.c       | 48 +++++++------
>  18 files changed, 174 insertions(+), 157 deletions(-)

I think this series should add Bo's SOB as he finished the initial
work.

Ryder

