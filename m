Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08060CA20
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiJYKcO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiJYKcI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 06:32:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256EDA98D1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 03:32:01 -0700 (PDT)
X-UUID: 6bba17f7ccc44b9985c54547ba5108ae-20221025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nwXtOrBGmhN+rfXZEJWhEkUK9+9OxseQHuwTgjxb580=;
        b=hDsK3fl8B3MN/Dg8xk7mwD2JQs9xMg9x629ERwVWh8eWTLIVqocU3USFyBBOnv6GlEagdWpl+InfXTtOLfDH6opD0fOOs4Okuu7FgDNZdYFx2Vmpq3zX3r0GA7O6mup1DUagdLvKfCavIAa4vMhYUS9sruQ4MaaEKILG8PkN0pM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:71144457-8691-4869-a3cb-ca2f62db0557,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:17979ce4-e572-4957-be22-d8f73f3158f9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6bba17f7ccc44b9985c54547ba5108ae-20221025
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 239825654; Tue, 25 Oct 2022 18:31:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 25 Oct 2022 18:31:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 25 Oct 2022 18:31:57 +0800
Message-ID: <8db3eb8a72da2d478780782a54305e3cf1b5b50a.camel@mediatek.com>
Subject: Re: [PATCH v2] wifi: mt76: fix bandwidth 80MHz link fail in 6GHz
 band
From:   Deren Wu <deren.wu@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        "Soul Huang" <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Date:   Tue, 25 Oct 2022 18:31:56 +0800
In-Reply-To: <Y1efUIq4aCFO7V6j@lore-desk>
References: <85b5e8374fc9b86fb955060c1840f3b2a1d187e4.1666614616.git.deren.wu@mediatek.com>
         <Y1efUIq4aCFO7V6j@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

On Tue, 2022-10-25 at 10:33 +0200, Lorenzo Bianconi wrote:
> > From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > 
> > Due to information missing, the firmware may be fail on bandwidth
> > related settings in mt7921/mt7922. Add new cmd STA_REC_HE_V2 to
> > apply
> > additional capabilities in 6GHz band.
> > 
> > Tested-by: Ben Greear <greearb@candelatech.com>
> > Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > ---
> > v2: Fix le16/cpu type problem, reported by kernel test robot <
> > lkp@intel.com>
> > ---
> >  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 34
> > +++++++++++++++++++
> >  .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 11 ++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > index 011fc9729b38..9bba18d24c71 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > @@ -744,6 +744,39 @@ mt76_connac_mcu_sta_he_tlv(struct sk_buff
> > *skb, struct ieee80211_sta *sta)
> >  	he->pkt_ext = 2;
> >  }
> >  
> > +static void
> > +mt76_connac_mcu_sta_he_tlv_v2(struct sk_buff *skb, struct
> > ieee80211_sta *sta)
> 
> Is this tlv available just for 7921 fw? If so I guess we should add
> it just for
> it since mt76_connac_mcu_sta_tlv is used even by other chipsets.
> 
> Regards,
> Lorenzo
> 

For now, mt76_connac_mcu_sta_he_tlv_v2() would be used for mt7921 only,
not for other chips. However, it would be used for all next-generation
chipsets. I propose to put it here and we will take this API in new
chip porting.

Regards,
Deren


