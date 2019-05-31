Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F930C96
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEaKbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 06:31:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50287 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726233AbfEaKbh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 06:31:37 -0400
X-UUID: ad0d1c2b08554872854e3b038420a56c-20190531
X-UUID: ad0d1c2b08554872854e3b038420a56c-20190531
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 661529757; Fri, 31 May 2019 18:31:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 31 May 2019 18:31:27 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 31 May 2019 18:31:21 +0800
Message-ID: <1559298681.3296.3.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] mt76: mt7615: enable support for mesh
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 31 May 2019 18:31:21 +0800
In-Reply-To: <20190531100201.GA3527@localhost.localdomain>
References: <7f167d09736652f81383991c971506630bbedacc.1559287432.git.ryder.lee@mediatek.com>
         <20190531100201.GA3527@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-05-31 at 12:02 +0200, Lorenzo Bianconi wrote:
> > Enable NL80211_IFTYPE_MESH_POINT and add its path.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
> >  drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
> >  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 5 ++++-
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> > 
> 
> [...]
> 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> > index b0bb7cc12385..585e67fa2728 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> > @@ -37,6 +37,7 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
> >  
> >  	switch (type) {
> >  	case NL80211_IFTYPE_AP:
> > +	case NL80211_IFTYPE_MESH_POINT:
> >  		/* ap use hw bssid 0 and ext bssid */
> >  		if (~mask & BIT(HW_BSSID_0))
> >  			return HW_BSSID_0;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > index 43f70195244c..8b8db526cb16 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > @@ -754,6 +754,7 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> >  
> >  	switch (vif->type) {
> >  	case NL80211_IFTYPE_AP:
> > +	case NL80211_IFTYPE_MESH_POINT:
> >  		tx_wlan_idx = mvif->sta.wcid.idx;
> >  		conn_type = CONNECTION_INFRA_AP;
> 
> Just out of curiosity, why not using CONNECTION_MESH_{AP,STA} here?
> why not NETWORK_MESH?

Actually the CONNECTION_MESH_{AP,STA} are useless and I will send v2 to
remove them.

> >  		break;
> > @@ -968,7 +969,8 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
> >  		.rx_wtbl = {
> >  			.tag = cpu_to_le16(WTBL_RX),
> >  			.len = cpu_to_le16(sizeof(struct wtbl_rx)),
> > -			.rca1 = vif->type != NL80211_IFTYPE_AP,
> > +			.rca1 = vif->type != (NL80211_IFTYPE_AP ||
> > +					      NL80211_IFTYPE_MESH_POINT),
> >  			.rca2 = 1,
> >  			.rv = 1,
> >  		},
> > @@ -1042,6 +1044,7 @@ static void sta_rec_convert_vif_type(enum nl80211_iftype type, u32 *conn_type)
> >  {
> >  	switch (type) {
> >  	case NL80211_IFTYPE_AP:
> > +	case NL80211_IFTYPE_MESH_POINT:
> >  		if (conn_type)
> >  			*conn_type = CONNECTION_INFRA_STA;
> >  		break;
> 
> same here.
> 
> Regards,
> Lorenzo
> 
> > -- 
> > 2.18.0
> > 


