Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B611F3ACD2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 04:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfFJCJ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jun 2019 22:09:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58302 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729916AbfFJCJ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jun 2019 22:09:56 -0400
X-UUID: 5257321715514527a3c4db15f5580d4f-20190610
X-UUID: 5257321715514527a3c4db15f5580d4f-20190610
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 574685482; Mon, 10 Jun 2019 10:09:52 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 10:09:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 10:09:50 +0800
Message-ID: <1560132590.28258.5.camel@mtkswgap22>
Subject: Re: [PATCH] mt76: mt7615: add support for per-chain signal strength
 reporting
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, Roy Luo <royluo@google.com>
Date:   Mon, 10 Jun 2019 10:09:50 +0800
In-Reply-To: <d6cfd2e9-4b2b-36ac-6cae-a34f74204801@newmedia-net.de>
References: <3912a2863e858f3623ced61737836e42c7b19149.1560071167.git.ryder.lee@mediatek.com>
         <d6cfd2e9-4b2b-36ac-6cae-a34f74204801@newmedia-net.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8D06DDBC87EE4513CDD414093242ECAB5DE3824B96BF2BAF50026F9C7918A2862000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-06-09 at 16:44 +0200, Sebastian Gottschall wrote:
> according to my findings
> 
> MT_RXV4_RCPI1 is part of rx descriptor 4 and not 3
> so it must be rxdg4 = rxd[4] etc.

RXV start from 1 in the code.

That is: RXV1 <-> rxdg0, RXV2 <-> rxdg1 ...so RXV4 <-> rxdg3

> however rxdg3 contains MT_RXV3_IB_RSSIRX which can be used for signal calculation.
> i already wrote a similar code for this driver which i sended to felix a long time ago.
> my variant looks like
>                  status->signal = (FIELD_GET(MT_RXV3_IB_RSSIRX, rxdg3) - 220) / 2;
>                  status->chain_signal[0] = (FIELD_GET(MT_RXV4_RCPI0, rxdg4) - 220) / 2;
>                  status->chain_signal[1] = (FIELD_GET(MT_RXV4_RCPI1, rxdg4) - 220) / 2;
>                  status->chain_signal[2] = (FIELD_GET(MT_RXV4_RCPI2, rxdg4) - 220) / 2;
>                  status->chain_signal[3] = (FIELD_GET(MT_RXV4_RCPI3, rxdg4) - 220) / 2;

> Am 09.06.2019 um 11:09 schrieb Ryder Lee:
> > Fill in RX status->chain_signal to avoid empty value.
> >
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >   .../net/wireless/mediatek/mt76/mt7615/mac.c   | 30 ++++++++++++++++++-
> >   .../net/wireless/mediatek/mt76/mt7615/mac.h   |  5 ++++
> >   2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> > index b60d42b5923d..9ee83ea11b8c
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> > @@ -13,6 +13,11 @@
> >   #include "../dma.h"
> >   #include "mac.h"
> >   
> > +static inline s8 to_rssi(u32 field, u32 rxv)
> > +{
> > +	return (FIELD_GET(field, rxv) - 220) / 2;
> > +}
> > +
> >   static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
> >   					    u8 idx, bool unicast)
> >   {
> > @@ -120,6 +125,7 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
> >   	if (rxd0 & MT_RXD0_NORMAL_GROUP_3) {
> >   		u32 rxdg0 = le32_to_cpu(rxd[0]);
> >   		u32 rxdg1 = le32_to_cpu(rxd[1]);
> > +		u32 rxdg3 = le32_to_cpu(rxd[3]);
> >   		u8 stbc = FIELD_GET(MT_RXV1_HT_STBC, rxdg0);
> >   		bool cck = false;
> >   
> > @@ -169,7 +175,29 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
> >   
> >   		status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
> >   
> > -		/* TODO: RSSI */
> > +		status->chains = dev->mt76.antenna_mask;
> > +		status->chain_signal[0] = to_rssi(MT_RXV4_RCPI0, rxdg3);
> > +		status->signal = status->chain_signal[0];
> > +
> > +		switch (status->chains) {
> > +		case 0x3:
> > +			status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
> > +			status->signal = max(status->signal,
> > +					     status->chain_signal[1]);
> > +			break;
> > +		case 0x7:
> > +			status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
> > +			status->signal = max(status->signal,
> > +					     status->chain_signal[2]);
> > +			break;
> > +		case 0xf:
> > +			status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
> > +			status->signal = max(status->signal,
> > +					     status->chain_signal[3]);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> >   		rxd += 6;
> >   		if ((u8 *)rxd - skb->data >= skb->len)
> >   			return -EINVAL;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
> > index 18ad4b8a3807..b00ce8db58e9
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
> > @@ -98,6 +98,11 @@ enum rx_pkt_type {
> >   #define MT_RXV2_GROUP_ID		GENMASK(26, 21)
> >   #define MT_RXV2_LENGTH			GENMASK(20, 0)
> >   
> > +#define MT_RXV4_RCPI3			GENMASK(31, 24)
> > +#define MT_RXV4_RCPI2			GENMASK(23, 16)
> > +#define MT_RXV4_RCPI1			GENMASK(15, 8)
> > +#define MT_RXV4_RCPI0			GENMASK(7, 0)
> > +
> >   enum tx_header_format {
> >   	MT_HDR_FORMAT_802_3,
> >   	MT_HDR_FORMAT_CMD,
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


