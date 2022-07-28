Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6222583779
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 05:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiG1DVJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 23:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbiG1DUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 23:20:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298825A142
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 20:20:47 -0700 (PDT)
X-UUID: 37c1d49e7a65438cbd091a2a9c94c5ae-20220728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:f00b0566-d9b4-4e0d-a378-f7b7043efc39,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:f00b0566-d9b4-4e0d-a378-f7b7043efc39,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:c1e2868e-b90a-4310-9e08-cd036292eb9e,C
        OID:dc5365b0e233,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 37c1d49e7a65438cbd091a2a9c94c5ae-20220728
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1750394842; Thu, 28 Jul 2022 11:20:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 28 Jul 2022 11:20:41 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 28 Jul 2022 11:20:41 +0800
Message-ID: <7f5284ae5f78f59dcf0d1cf559bf444e237eadbe.camel@mediatek.com>
Subject: Re: [PATCH 05/12] wifi: mt76: mt7915: report tx-retries
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
CC:     <nbd@nbd.name>
Date:   Thu, 28 Jul 2022 11:20:41 +0800
In-Reply-To: <20220727230122.29842-5-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
         <20220727230122.29842-5-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-07-27 at 16:01 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> mac80211 stack will only report tx-status for skb claiming to be
> ampdu heads, so lie a bit in mt7915 and set the flag so that mac80211
> will record status for each skb.
> 
> mt7915 appears to report retry status on an individual per-skb
> manner,
> so that method above seems to work.
> 
> Re-constitute the txinfo status rate info so that the rix and flags
> is also at least close to correct.  No direct way to report HE
> rates that way, so mac80211 might could use some tweaking in
> the ieee80211_tx_status_ext to take both info and status->rate
> into account.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 95
> ++++++++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7915/mac.h   |  6 +-
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +
>  drivers/net/wireless/mediatek/mt76/tx.c       | 18 +++-
>  8 files changed, 129 insertions(+), 8 deletions(-)

Hi Ben,

Looks like we have a similar goal but I don't use txs_for_no_skb. 

What about directly switching to PPDU bases reporting (it should
include MPDUs total/failed/retries counts/bytes) and using
.sta_statistics? I think this might simplify the codes and can use
mac80211 ethtool as is.

I made these changes for .net_fill_forward_path (WED) cases. We're
doing some throughput tests.
https://pastebin.com/raw/qCzNNDzw
https://pastebin.com/raw/25Vsk2xs


Ryder


