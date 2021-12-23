Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9663347E9B6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 00:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbhLWXum (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 18:50:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55682 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240979AbhLWXul (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 18:50:41 -0500
X-UUID: 871a362597054bbcb46a46d156f291f3-20211224
X-UUID: 871a362597054bbcb46a46d156f291f3-20211224
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1385285128; Fri, 24 Dec 2021 07:50:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 24 Dec 2021 07:50:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Dec 2021 07:50:36 +0800
Message-ID: <6d3a52918457d4fedf91a6a224cf35eaf940f22c.camel@mediatek.com>
Subject: Re: [PATCH 1/1] mt76: add mt7916 to set wlan_idx_hi
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <bo.jiao@mediatek.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Xing Song <xing.song@mediatek.com>,
        "Sujuan Chen" <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Fri, 24 Dec 2021 07:50:36 +0800
In-Reply-To: <YcTwP6Hu5VoTMHEq@lore-desk>
References: <cover.1640175865.git.Bo.Jiao@mediatek.com>
         <5b82d68ee7c879591e22da51bfdb4af2e5fad228.1640175865.git.Bo.Jiao@mediatek.com>
         <YcTwP6Hu5VoTMHEq@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-12-23 at 22:55 +0100, Lorenzo Bianconi wrote:
> > From: Bo Jiao <Bo.Jiao@mediatek.com>
> > 
> > since mt7916 support up to 544 wcid entries,
> > add it to set wlan_idx_hi.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 5 +++++
> >  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > index e999d71..8701f04 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > @@ -110,6 +110,11 @@ static inline bool is_mt7915(struct mt76_dev
> > *dev)
> >  	return mt76_chip(dev) == 0x7915;
> >  }
> >  
> > +static inline bool is_mt7916(struct mt76_dev *dev)
> > +{
> > +	return mt76_chip(dev) == 0x7906;
> > +}
> > +
> >  static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def
> > *chandef)
> >  {
> >  	static const u8 width_to_bw[] = {
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > index edad583..fc9a084 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > @@ -1464,7 +1464,7 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev
> > *dev, struct mt76_wcid *wcid,
> >  {
> >  	*wlan_idx_hi = 0;
> >  
> > -	if (is_mt7921(dev) || is_mt7915(dev)) {
> > +	if (is_mt7921(dev) || is_mt7915(dev) || is_mt7916(dev)) {
> >  		*wlan_idx_lo = wcid ? to_wcid_lo(wcid->idx) : 0;
> >  		*wlan_idx_hi = wcid ? to_wcid_hi(wcid->idx) : 0;
> 
> I guess I have already included the fix here:
> 
https://patchwork.kernel.org/project/linux-wireless/patch/df4d462f1ef4cfc1ae4f6482051a28a10c78262b.1640260901.git.lorenzo@kernel.org/
> 
> Regards,
> Lorenzo
> 

I think we can fold these patches together and use !is_connac_v1
instead so that we can avoid endless is_mtxxxx || ... || ...

Ryder


