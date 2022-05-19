Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE22252DA12
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiESQWS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 12:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiESQWQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 12:22:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9842EC1EE7
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 09:22:11 -0700 (PDT)
X-UUID: 4dd7ca02c51f46fdbd8903ef4d3ffce3-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:e119717e-d9d0-47aa-975b-453033f9ba35,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:b0d3e379-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 4dd7ca02c51f46fdbd8903ef4d3ffce3-20220520
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 658681106; Fri, 20 May 2022 00:22:06 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 00:22:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 00:22:05 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 00:22:05 +0800
Message-ID: <db3cf5f53242ec98406e4bb577f7bbb40b371231.camel@mediatek.com>
Subject: Re: [PATCH 3/3] mt76: mt7921: introduce BIOS SAR config in tx power
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Date:   Fri, 20 May 2022 00:22:05 +0800
In-Reply-To: <8207b98b-0c10-aff4-55c4-6c7118454832@nbd.name>
References: <cover.1652941276.git.deren.wu@mediatek.com>
         <2e6b69a763d60897639101506e39a2b1a81d8eab.1652941276.git.deren.wu@mediatek.com>
         <8207b98b-0c10-aff4-55c4-6c7118454832@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix,

On Thu, 2022-05-19 at 17:33 +0200, Felix Fietkau wrote:
> On 19.05.22 08:38, Deren Wu wrote:
> > From: Deren Wu <deren.wu@mediatek.com>
> > 
> > Add new function mt7921_set_tx_sar_pwr() to update SAR power from
> > .set_sar_specs and BIOS setting. Both settings would be merged into
> > mt76_freq_range_power for final tx power value.
> > 
> > Reviewed-by: Sean Wang <sean.wang@mediatek.com>
> > Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > ---
> >   .../net/wireless/mediatek/mt76/mt7921/init.c  |  3 +-
> >   .../net/wireless/mediatek/mt76/mt7921/main.c  | 32 +++++++++++++-
> > -----
> >   .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
> >   3 files changed, 26 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > index 80279f342109..c86d8805f291 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > @@ -1469,20 +1469,34 @@ static void mt7921_ipv6_addr_change(struct
> > ieee80211_hw *hw,
> >   }
> >   #endif
> >   
> > +int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
> > +			  const struct cfg80211_sar_specs *sar)
> > +{
> > +	struct mt76_phy *mphy = hw->priv;
> > +	int err;
> > +
> > +	if (sar) {
> > +		err = mt76_init_sar_power(hw, sar);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	mt7921_init_bios_sar_power(mt7921_hw_phy(hw), !sar);
> > +
> > +	err = mt76_connac_mcu_set_rate_txpower(mphy);
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(mt7921_set_tx_sar_pwr);
> 
> Why is this exported?

Thanks for pointing out. I will remove unnecessary export in next
version.


Regards,
Deren

> 
> - Felix
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

