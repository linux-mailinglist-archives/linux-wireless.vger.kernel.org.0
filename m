Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FE344F6BC
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Nov 2021 06:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhKNFho (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Nov 2021 00:37:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59256 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229515AbhKNFhn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Nov 2021 00:37:43 -0500
X-UUID: 3df06dc3d05747f6869622a8918f6fe0-20211114
X-UUID: 3df06dc3d05747f6869622a8918f6fe0-20211114
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2064759205; Sun, 14 Nov 2021 13:34:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 14 Nov 2021 13:34:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 14 Nov 2021 13:34:45 +0800
Message-ID: <91230c580e09a192f32217ff6fed160bf1645594.camel@mediatek.com>
Subject: Re: [PATCH v2] mt76: mt7921: introduce 160 MHz channel bandwidth
 support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
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
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Sun, 14 Nov 2021 13:34:45 +0800
In-Reply-To: <9385a730618c9c3f09120313280cdeb0b10154a2.camel@mediatek.com>
References: <66edc3125e9a12dedeba1a61697d46322b0c004d.1636374449.git.deren.wu@mediatek.com>
         <c622447038b06d8a4068ec8126c7ec674fafe383.camel@mediatek.com>
         <6978659235747261d652379d7d1a823f6b2f6505.camel@mediatek.com>
         <ee169af76f1d45b6178204585489c187dae97757.camel@mediatek.com>
         <9385a730618c9c3f09120313280cdeb0b10154a2.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> > > 
> > > Since 80p80MHz is not supprted in mt7921, we should not register
> > > this
> > > capability to mac80211. When the feature coming, we may have a
> > > new
> > > config cap.has_bw80p80 to adapte the new flow.
> > > 
> > 
> > Then, how to tell 80p80M and 160M apart with only checking
> > IEEE80211_STA_RX_BW_160? 
> > 
> >  * @IEEE80211_STA_RX_BW_160: station can receive up to 160 MHz
> >  *	(including 80+80 MHz)
> > 
> > Maybe move has_bw80p80 into mt7921_dev as it is not generic to me?
> > 
> 
> As you noted, both 80p80M and 160M are included in
> IEEE80211_STA_RX_BW_160. We may not check two features
> by IEEE80211_STA_RX_BW_160 only. That is why I prefer to have
> .has_bw160 and .has_80p80 at next stage.
> 
> With the new feature, HW should report different result in the flow
> of 
> chip capability check. The check point should start from
> mt76_connac_mcu_parse_XXXX_cap() and then we can know the real
> capabilities of this HW chip.
> 

What about using device id? I think we can easily determine the BW
without adding .has_xx in to common core, and it looks more like a 7921specific stuff though.  

