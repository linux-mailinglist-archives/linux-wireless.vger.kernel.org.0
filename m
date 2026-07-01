Return-Path: <linux-wireless+bounces-38432-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id posaLy6oRGosygoAu9opvQ
	(envelope-from <linux-wireless+bounces-38432-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 07:39:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0606E9E25
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 07:39:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38432-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38432-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4EA9301FF08
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 05:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267538F92F;
	Wed,  1 Jul 2026 05:39:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176F312807;
	Wed,  1 Jul 2026 05:39:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884396; cv=none; b=IAfPSlV8iiBv4NPzoq2ikx5AaOSmZdHZpGdG5Wvto79okDhVc5TDz82HL6nmGNRa541PfUSiW+cifeAEvRzsEIfF+iTslwvG3thGq9Qx++LBRFPni8oy7mpW03p/WYCTjT+42FANHPDseQ+5gf0qq5uMORz/OGA3wftXck4PrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884396; c=relaxed/simple;
	bh=KPRpV2OTQV3O3chkhczkOkVXwXH4v+G0/WQS95RV7Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfjghZifh6SaPZ9OOkYDNN4FA9DuP9lsAnlKcl1B2GGz3drPeRldx1nKf2z7rVNbn61/mOp41R6AJqr9akRj6tMhwOeGJIQuKTZ9mZ9ghFO5/tQrm2er7YGRd6n767Gf9a/9vr6XgeNAzad79uemGNftxEUNPLyo55Wrbig5I8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 442ae94e750f11f1aa26b74ffac11d73-20260701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f37576a9-a375-4c7f-ad87-6d3dd921d54d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0e3cee1c3040dfdb058ab0416684d043,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 442ae94e750f11f1aa26b74ffac11d73-20260701
X-User: liujiajia@kylinos.cn
Received: from nature [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1450260893; Wed, 01 Jul 2026 13:39:45 +0800
Date: Wed, 1 Jul 2026 13:39:42 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] wifi: mt76: add wcid publish check in mt76_sta_add
Message-ID: <akSoHk-BozrpWPmZ@nature>
References: <20260528033814.46418-1-liujiajia@kylinos.cn>
 <b143b62e-ca11-4f00-ad60-f71ae55213b9@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b143b62e-ca11-4f00-ad60-f71ae55213b9@leemhuis.info>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:mingyen.hsieh@mediatek.com,m:leon.yen@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:regressions@lists.linux.dev,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[liujiajia@kylinos.cn,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38432-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liujiajia@kylinos.cn,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:from_mime,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E0606E9E25

On Tue, Jun 30, 2026 at 01:29:51PM +0200, Thorsten Leemhuis wrote:
> On 5/28/26 05:38, Jiajia Liu wrote:
> > Since mt7925_mac_sta_add publishes wcid, add publish check in mt76_sta_add
> > to avoid reinitializing the wcid->poll_list.
> > 
> > Found dev->sta_poll_list corruption when using mt7925 and 7.1-rc4.
> 
> Jiajia Liu, Felox: given that the problem seems to be in 7.1, should we
> ask the stable team to pick this regression fix up, as this change was
> mainlined (as 20b126920a259d ("wifi: mt76: add wcid publish check in
> mt76_sta_add") [v7.2-rc1]), but lacks both a Fixes and a Stable tag?

Yes. It seems to be related to cbf5e61da660 ("wifi: mt76: initialize
more wcid fields mt76_wcid_init") [v6.14-rc1]. But I didn't reproduce
when I checked it out and tested. So Fixes was not added.

> 
> Ciao, Thorsten
> 
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
> > Changes in v2:
> >   - use dev->wcid table instead of adding MT_WCID_FLAG_DRV_PUBLSH for
> >     wcid publish check suggested by Sean
> >   - subject and commit message update
> > 
> > ---
> >  drivers/net/wireless/mediatek/mt76/mac80211.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
> > index 4ae5e4715a9c..b78b4cd206e0 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> > @@ -1576,6 +1576,7 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
> >  {
> >  	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
> >  	struct mt76_dev *dev = phy->dev;
> > +	struct mt76_wcid *published;
> >  	int ret;
> >  	int i;
> >  
> > @@ -1595,11 +1596,19 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
> >  		mtxq->wcid = wcid->idx;
> >  	}
> >  
> > -	ewma_signal_init(&wcid->rssi);
> > -	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
> > +	published = rcu_dereference_protected(dev->wcid[wcid->idx],
> > +					      lockdep_is_held(&dev->mutex));
> > +	if (published != wcid) {
> > +		WARN_ON_ONCE(published);
> > +		ewma_signal_init(&wcid->rssi);
> > +		rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
> > +		mt76_wcid_init(wcid, phy->band_idx);
> > +	} else {
> > +		wcid->phy_idx = phy->band_idx;
> > +	}
> > +
> >  	phy->num_sta++;
> >  
> > -	mt76_wcid_init(wcid, phy->band_idx);
> >  out:
> >  	mutex_unlock(&dev->mutex);
> >

