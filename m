Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7145615C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhKRRXy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:23:54 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52412 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229681AbhKRRXx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:23:53 -0500
X-UUID: c46beaefee184257be1cc09c0645bc4f-20211119
X-UUID: c46beaefee184257be1cc09c0645bc4f-20211119
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1514240210; Fri, 19 Nov 2021 01:20:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 19 Nov 2021 01:20:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Nov 2021 01:20:49 +0800
Message-ID: <9251a91c3bf2ca37e86fb3eb67c6c57ba90ddf2b.camel@mediatek.com>
Subject: Re: [PATCH 1/8] mt76: mt7915: cache sgi in wcid.
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Ben Greear <greearb@candelatech.com>,
        <linux-wireless@vger.kernel.org>
Date:   Fri, 19 Nov 2021 01:20:49 +0800
In-Reply-To: <7ec78991-2104-a3f7-dd2f-373cf6a10019@candelatech.com>
References: <20211118164549.3863-1-greearb@candelatech.com>
         <c0a09707cf9bcf1205b60c7a36e5afa2a6b2f39c.camel@mediatek.com>
         <7ec78991-2104-a3f7-dd2f-373cf6a10019@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 * On Thu, 2021-11-18 at 09:10 -0800, Ben Greear wrote:
> On 11/18/21 9:06 AM, Ryder Lee wrote:
> > On Thu, 2021-11-18 at 08:45 -0800, greearb@candelatech.com wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > > 
> > > Explicitly cache short_gi and he_gi in wcid, don't try to store
> > > it in the wcid.rate object.  Slightly less confusing and less
> > > fragile
> > > when TXS starts parsing lots of frames.
> > > 
> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > ---
> > > 
> > > This is actually the first series, not that one I posted a few
> > > minutes
> > > ago.  txs, tx overrides and other things.  Rebased on top of 5.16
> > 
> > Maybe we can consider switching to use existing fixed-rate method
> > in
> > debugfs? On th other hand, that's the only way to configure HE MU
> > UL
> > fixed-rate.
> 
> This patch is to improve reported tx rates, not to control tx rates.
> 

Ah.  I shall reply [PATCH 8/8] mt76: mt7915: fix SGI reporting when
using tx-overrides.

