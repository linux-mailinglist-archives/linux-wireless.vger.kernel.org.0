Return-Path: <linux-wireless+bounces-36997-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ25A6PCFmrOqgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36997-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:08:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7175E2643
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A57303352A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256ED3EEACA;
	Wed, 27 May 2026 10:00:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8C3E7BDF;
	Wed, 27 May 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876031; cv=none; b=F5/sOWClJWu1QNFk1+U0Lbj0xwVvhFvb69PwuCQNLjnXA+AyVWaglgd8ykJsAI4MQmcrkUMMZRIFCYpumRwyqfNGxkBUKvPjk9YDdYeRvE3Hihn+FpdAFL/XXwUI3zVjbE9F7Vk7GaLZ7SWqppZNb2bZfFwVhlyOxXARjgtRqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876031; c=relaxed/simple;
	bh=gDgkJ0TD82DFTvkh4599+Re+Yyjc+glCUZn5JIR+0YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIcxl1hU42naGiHSz/0N4vbQMK3qu/YR0v0LOkjARdoGF/F72lHfVbBWmNrnNbjke2FNugZiOOQY+kFPxyHU30iZkWbjZ0WPYRQW9FovcUaOOJ/aChdyJZ/7uTFLBZ35qA6kB5958bQ/eD3Sy3RUQ3ubguKsnfEDQH9RwYx0VOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dec7402459b211f1aa26b74ffac11d73-20260527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1fdcb15d-86a5-4dfd-9310-ad06384d0138,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:21fde180ab3492c37f445fc5f12cf05d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dec7402459b211f1aa26b74ffac11d73-20260527
X-User: liujiajia@kylinos.cn
Received: from nature [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1695425657; Wed, 27 May 2026 18:00:20 +0800
Date: Wed, 27 May 2026 18:00:17 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Michael Lo <michael.lo@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7925: add wcid publish check in
 mt76_sta_add
Message-ID: <ahbAsYwFCjsvpxEC@nature>
References: <20260526060841.49161-1-liujiajia@kylinos.cn>
 <CAGp9LzqzddmyDHMNsaqigYpVEdo_Pmzwbeh5Ri5_Gr87cVL6Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGp9LzqzddmyDHMNsaqigYpVEdo_Pmzwbeh5Ri5_Gr87cVL6Dg@mail.gmail.com>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36997-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liujiajia@kylinos.cn,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 4C7175E2643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:52:32PM -0500, Sean Wang wrote:
> Hi,
> 
> On Tue, May 26, 2026 at 1:09 AM Jiajia Liu <liujiajia@kylinos.cn> wrote:
> >
> > Since mt7925_mac_sta_add publishes wcid, add publish check in mt76_sta_add
> > to avoid reinitializing the wcid->poll_list for mt7925.
> >
> > Found dev->sta_poll_list corruption when using mt7925 and 7.0-rc4.
> > According to the corruption information, prev->next was changed to itself.
> >
> > wlan0: disconnect from AP 90:fb:5d:94:8b:e3 for new auth to 90:fb:5d:94:8b:e2
> > wlan0: authenticate with 90:fb:5d:94:8b:e2 (local address=84:9e:56:9c:7e:6b)
> > wlan0: send auth to 90:fb:5d:94:8b:e2 (try 1/3)
> >  slab kmalloc-8k start ffff8c80958a6000 pointer offset 4160 size 8192
> > list_add corruption. prev->next should be next (ffff8c808a7488f8), but was ffff8c80958a7040. (prev=ffff8c80958a7040).
> >
> >  mt76_wcid_add_poll+0x95/0xd0 [mt76]
> >  mt7925_mac_add_txs.part.0+0xa5/0xe0 [mt7925_common]
> >  mt7925_rx_check+0xa7/0xc0 [mt7925_common]
> >  mt76_dma_rx_poll+0x50d/0x790 [mt76]
> >  mt792x_poll_rx+0x52/0xe0 [mt792x_lib]
> >
> > Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> > ---
> >
> > Reproduced and tested using the script below over ssh. Roam between two
> > bssids with the same SSID on a router.
> >
> > #!/bin/bash
> >
> > set -ex
> >
> > while :; do
> >         num=$(sudo iw wlan0 scan | grep Polaris | wc -l)
> >         if [ $num -eq 2 ]; then
> >                 break
> >         fi
> > done
> >
> > for i in $(seq 1 500); do
> >
> > echo "index $i"
> > wpa_cli -i wlan0 roam 90:fb:5d:94:8b:e3
> > sleep 5
> > wpa_cli -i wlan0 roam 90:fb:5d:94:8b:e2
> > sleep 5
> >
> > done
> >
> > ---
> >  drivers/net/wireless/mediatek/mt76/mac80211.c    | 11 ++++++++---
> >  drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
> >  drivers/net/wireless/mediatek/mt76/mt7925/main.c |  3 +++
> >  3 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
> > index 4ae5e4715a9c..83f4f941b890 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> > @@ -1595,11 +1595,16 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
> >                 mtxq->wcid = wcid->idx;
> >         }
> >
> > -       ewma_signal_init(&wcid->rssi);
> > -       rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
> > +       if (!test_bit(MT_WCID_FLAG_DRV_PUBLISH, &wcid->flags)) {
> > +               ewma_signal_init(&wcid->rssi);
> > +               rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
> > +               mt76_wcid_init(wcid, phy->band_idx);
> > +       } else {
> > +               wcid->phy_idx = phy->band_idx;
> > +       }
> > +
> >         phy->num_sta++;
> >
> 
> Thanks for spotting the roaming issue.
> 
> I think we can avoid adding MT_WCID_FLAG_DRV_PUBLISH and instead use the
> WCID table itself for the publish check.
> 
> dev->wcid[] already encodes whether a WCID has been published, so checking
> it directly avoids adding a second mirror state. MT_WCID_FLAG_* is also
> better kept for WCID features that affect WTBL setup or data-path handling,
> rather than common bookkeeping state.
> 
> Something like:
> 
> @@ -1620,6 +1620,7 @@ mt76_sta_add(struct mt76_phy *phy, struct
> ieee80211_vif *vif,
> {
>   struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
>   struct mt76_dev *dev = phy->dev;
> +       struct mt76_wcid *published;
>   int ret;
>   int i;
> 
> @@ -1639,7 +1640,10 @@ mt76_sta_add(struct mt76_phy *phy, struct
> ieee80211_vif *vif,
>           mtxq->wcid = wcid->idx;
>   }
> 
> -       if (!test_bit(MT_WCID_FLAG_DRV_PUBLISH, &wcid->flags)) {
> +       published = rcu_dereference_protected(dev->wcid[wcid->idx],
> +                                             lockdep_is_held(&dev->mutex));
> +       if (published != wcid) {
> +               WARN_ON_ONCE(published);
>                  ewma_signal_init(&wcid->rssi);
>                  rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
>                  mt76_wcid_init(wcid, phy->band_idx);
> 
>    ....
> 

Thanks for the suggestion. Will update in v2.

> 
> > -       mt76_wcid_init(wcid, phy->band_idx);
> >  out:
> >         mutex_unlock(&dev->mutex);
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> > index 527bef97e122..8bfce686bff7 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > @@ -361,6 +361,7 @@ enum mt76_wcid_flags {
> >         MT_WCID_FLAG_PS,
> >         MT_WCID_FLAG_4ADDR,
> >         MT_WCID_FLAG_HDR_TRANS,
> > +       MT_WCID_FLAG_DRV_PUBLISH,
> >  };
> >
> >  #define MT76_N_WCIDS 1088
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> > index 73d3722739d0..35b5c718475c 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> > @@ -1102,6 +1102,9 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
> >                                               &msta->deflink);
> >         }
> >
> > +       if (!err)
> > +               set_bit(MT_WCID_FLAG_DRV_PUBLISH, &msta->deflink.wcid.flags);
> > +
> >         return err;
> >  }
> >  EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
> > --
> > 2.53.0
> >
> >

