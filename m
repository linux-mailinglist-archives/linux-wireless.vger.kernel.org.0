Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81285837DA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 06:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiG1EZG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 00:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbiG1EWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 00:22:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B854CB3
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 21:22:16 -0700 (PDT)
X-UUID: f0085cf88a3b4f25ac317fab0e1026ea-20220728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:aa8bf231-5a1f-453f-8f52-29227f5c52bf,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:475f8ad0-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: f0085cf88a3b4f25ac317fab0e1026ea-20220728
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1098949345; Thu, 28 Jul 2022 12:22:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 28 Jul 2022 12:22:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jul 2022 12:22:09 +0800
Message-ID: <da8d837a5c39ed9fdef227db3ab624c4968f709a.camel@mediatek.com>
Subject: Re: [PATCH 05/12] wifi: mt76: mt7915: report tx-retries
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Ben Greear <greearb@candelatech.com>,
        <linux-wireless@vger.kernel.org>
CC:     <nbd@nbd.name>
Date:   Thu, 28 Jul 2022 12:22:10 +0800
In-Reply-To: <309601ec-2b09-fc99-c003-882a895469d0@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
         <20220727230122.29842-5-greearb@candelatech.com>
         <7f5284ae5f78f59dcf0d1cf559bf444e237eadbe.camel@mediatek.com>
         <309601ec-2b09-fc99-c003-882a895469d0@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-07-27 at 21:11 -0700, Ben Greear wrote:
> On 7/27/22 8:20 PM, Ryder Lee wrote:
> > On Wed, 2022-07-27 at 16:01 -0700, greearb@candelatech.com wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > > 
> > > mac80211 stack will only report tx-status for skb claiming to be
> > > ampdu heads, so lie a bit in mt7915 and set the flag so that
> > > mac80211
> > > will record status for each skb.
> > > 
> > > mt7915 appears to report retry status on an individual per-skb
> > > manner,
> > > so that method above seems to work.
> > > 
> > > Re-constitute the txinfo status rate info so that the rix and
> > > flags
> > > is also at least close to correct.  No direct way to report HE
> > > rates that way, so mac80211 might could use some tweaking in
> > > the ieee80211_tx_status_ext to take both info and status->rate
> > > into account.
> > > 
> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > ---
> > >   drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +
> > >   drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +
> > >   .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
> > >   .../net/wireless/mediatek/mt76/mt7915/mac.c   | 95
> > > ++++++++++++++++++-
> > >   .../net/wireless/mediatek/mt76/mt7915/mac.h   |  6 +-
> > >   .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +
> > >   .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +
> > >   drivers/net/wireless/mediatek/mt76/tx.c       | 18 +++-
> > >   8 files changed, 129 insertions(+), 8 deletions(-)
> > 
> > Hi Ben,
> > 
> > Looks like we have a similar goal but I don't use txs_for_no_skb.
> > 
> > What about directly switching to PPDU bases reporting (it should
> > include MPDUs total/failed/retries counts/bytes) and using
> > .sta_statistics? I think this might simplify the codes and can use
> > mac80211 ethtool as is.
> 
> I like per-packet tx-status because then I can do histograms up in
> mac80211
> (and the driver) to show distributions of nss, mcs, encoding types,
> etc.
> 
> I have not actually coded against the histograms I put in mac80211,
> but instead I'm using ethtool
> to get the histograms directly out of mt76 driver.
> 
> At least for 7915, I think you have to enable txs-for-no-skb logic to
> get
> details on mcs, nss and similar rate info?
> 
> Thanks,
> Ben
> 

Per PPDU txs provides mcs, nss and rate info as well, then we can use
.sta_statistics to report all sinfo we need. This is the way we use
for .net_fill_forward_path (WED) since it bypasses entire mac80211 data
path. We can also use iw station dump or ethtool to get histograms.

Ryder
> > 
> > I made these changes for .net_fill_forward_path (WED) cases. We're
> > doing some throughput tests.
> > 
https://urldefense.com/v3/__https://pastebin.com/raw/qCzNNDzw__;!!CTRNKA9wMg0ARbw!2EM8sO1SfUIboAp28ohdNT0OLwvCmyr-EuYoE-W1-IGsWn2RN8LI5LFNRjLBk3JM$
> >  
> > 
https://urldefense.com/v3/__https://pastebin.com/raw/25Vsk2xs__;!!CTRNKA9wMg0ARbw!2EM8sO1SfUIboAp28ohdNT0OLwvCmyr-EuYoE-W1-IGsWn2RN8LI5LFNRrLTxq5e$
> >  
> > 
> > 
> > Ryder
> > 
> > 
> 
> 

