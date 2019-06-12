Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A085041F5B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfFLIiG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 04:38:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48079 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731305AbfFLIiF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 04:38:05 -0400
X-UUID: 0fee5e1d994d40a2be57483e599bfb28-20190612
X-UUID: 0fee5e1d994d40a2be57483e599bfb28-20190612
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1668390797; Wed, 12 Jun 2019 16:38:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 16:37:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 16:37:58 +0800
Message-ID: <1560328678.4743.6.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] mt76: mt7615: update peer's bssid when state
 transition changes
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, YF Luo <yf.luo@mediatek.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, Roy Luo <royluo@google.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "Felix Fietkau" <nbd@nbd.name>
Date:   Wed, 12 Jun 2019 16:37:58 +0800
In-Reply-To: <20190612082618.GA8107@localhost.localdomain>
References: <3065a01998dfa04a5d2d680e820a17cb5c110d0f.1560221172.git.ryder.lee@mediatek.com>
         <449fee28c558b6f02b62275f9beefaab02b47efc.1560221172.git.ryder.lee@mediatek.com>
         <20190612082618.GA8107@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 72901263F5700DB435DA5D08E473CCAD7D900AD367C6200865E79A301332B9AA2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-12 at 10:26 +0200, Lorenzo Bianconi wrote:
> > Driver should update peer's bssid and bss information when
> > state transition changes.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  .../net/wireless/mediatek/mt76/mt7615/main.c  |  5 +-
> >  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 49 ++++++++++---------
> >  2 files changed, 27 insertions(+), 27 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > index e82086eb8aa4..8fc12cd37906 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > @@ -741,17 +741,6 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> >  	u8 *buf, *data, tx_wlan_idx = 0;
> >  	struct req_hdr *hdr;
> >  
> > -	if (en) {
> > -		len += sizeof(struct bss_info_omac);
> > -		features |= BIT(BSS_INFO_OMAC);
> > -		if (mvif->omac_idx > EXT_BSSID_START) {
> > -			len += sizeof(struct bss_info_ext_bss);
> > -			features |= BIT(BSS_INFO_EXT_BSS);
> > -			ntlv++;
> > -		}
> > -		ntlv++;
> > -	}
> > -
> >  	switch (vif->type) {
> >  	case NL80211_IFTYPE_AP:
> >  	case NL80211_IFTYPE_MESH_POINT:
> > @@ -759,22 +748,23 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> >  		conn_type = CONNECTION_INFRA_AP;
> >  		break;
> >  	case NL80211_IFTYPE_STATION: {
> > -		struct ieee80211_sta *sta;
> > -		struct mt7615_sta *msta;
> > -
> > -		rcu_read_lock();
> > -
> > -		sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
> > -		if (!sta) {
> > +		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
> > +		if (en) {
> > +			struct ieee80211_sta *sta;
> > +			struct mt7615_sta *msta;
> > +
> > +			rcu_read_lock();
> > +			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
> > +			if (!sta) {
> > +				rcu_read_unlock();
> > +				return -EINVAL;
> > +			}
> > +
> > +			msta = (struct mt7615_sta *)sta->drv_priv;
> > +			tx_wlan_idx = msta->wcid.idx;
> >  			rcu_read_unlock();
> > -			return -EINVAL;
> >  		}
> > -
> > -		msta = (struct mt7615_sta *)sta->drv_priv;
> > -		tx_wlan_idx = msta->wcid.idx;
> >  		conn_type = CONNECTION_INFRA_STA;
> > -
> > -		rcu_read_unlock();
> >  		break;
> >  	}
> >  	default:
> > @@ -782,6 +772,17 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> >  		break;
> >  	}
> >  
> > +	if (en) {
> > +		len += sizeof(struct bss_info_omac);
> > +		features |= BIT(BSS_INFO_OMAC);
> > +		if (mvif->omac_idx > EXT_BSSID_START) {
> > +			len += sizeof(struct bss_info_ext_bss);
> > +			features |= BIT(BSS_INFO_EXT_BSS);
> > +			ntlv++;
> > +		}
> > +		ntlv++;
> > +	}
> 
> What did you move this chunk down?

Ah, my bad. I originally planned to add other conditions and it may
change 'en' so moved these stuff behind them.

Anyway I forgot to remove this part. Will fix it

Ryder.

> Regards,
> Lorenzo
> 
> > +
> >  	buf = kzalloc(len, GFP_KERNEL);
> >  	if (!buf)
> >  		return -ENOMEM;
> > -- 
> > 2.18.0
> > 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


