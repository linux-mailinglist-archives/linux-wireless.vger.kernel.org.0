Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DC495606
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jan 2022 22:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiATVjA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jan 2022 16:39:00 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:40038 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231373AbiATVi4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jan 2022 16:38:56 -0500
X-UUID: fa4ae23abfd74a2f952a4afa386f91f6-20220121
X-UUID: fa4ae23abfd74a2f952a4afa386f91f6-20220121
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 430348806; Fri, 21 Jan 2022 05:38:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 21 Jan 2022 05:38:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 21 Jan 2022 05:38:52 +0800
Message-ID: <4e35b66a36f7dc48397f0e2f8941cbd031b29bcb.camel@mediatek.com>
Subject: Re: [PATCH v4 05/12] mt76: mt7915: add firmware support for mt7916
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Ben Greear <greearb@candelatech.com>,
        Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Fri, 21 Jan 2022 05:38:52 +0800
In-Reply-To: <edd5b78c-5277-e192-b404-1b771e1a5242@candelatech.com>
References: <cover.1639965732.git.Bo.Jiao@mediatek.com>
         <6b2d86cbbe6426a5ed0d91b8248b95ac3390885f.1639965732.git.Bo.Jiao@mediatek.com>
         <edd5b78c-5277-e192-b404-1b771e1a5242@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-01-20 at 13:29 -0800, Ben Greear wrote:
> On 12/19/21 6:17 PM, Bo Jiao wrote:
> > From: Bo Jiao <Bo.Jiao@mediatek.com>
> > 
> > Update firmware initialization for mt7916.
> > This is an intermediate patch to add mt7916 support.
> > 
> > Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
> > Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> > Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> > ---
> > v3:
> > - modify the function mt7915_wfsys_reset to support mt7916
> > ---
> >   .../net/wireless/mediatek/mt76/mt7915/init.c  | 75 ++++++++----
> > -----
> >   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 81
> > +++++++++++++++----
> >   .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
> >   .../net/wireless/mediatek/mt76/mt7915/pci.c   |  3 +
> >   .../net/wireless/mediatek/mt76/mt7915/regs.h  |  6 +-
> >   5 files changed, 115 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > index 2da342d..edf0d7e 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > @@ -511,41 +511,53 @@ static void mt7915_init_work(struct
> > work_struct *work)
> >   
> >   static void mt7915_wfsys_reset(struct mt7915_dev *dev)
> >   {
> > -	u32 val = MT_TOP_PWR_KEY | MT_TOP_PWR_SW_PWR_ON |
> > MT_TOP_PWR_PWR_ON;
> > +	u32 val;
> >   
> >   #define MT_MCU_DUMMY_RANDOM	GENMASK(15, 0)
> >   #define MT_MCU_DUMMY_DEFAULT	GENMASK(31, 16)
> > +	if (is_mt7915(&dev->mt76)) {
> > +		mt76_wr(dev, MT_MCU_WFDMA0_DUMMY_CR,
> > MT_MCU_DUMMY_RANDOM);
> > +
> > +		/* change to software control */
> > +		val |= MT_TOP_PWR_SW_RST;
> > +		mt76_wr(dev, MT_TOP_PWR_CTRL, val);
> 
> val is not properly initialized in this path.  I also notice this is
> not the version of the patch
> that was applied to nbd's tree.  The 'else nic is 7916' clause that
> this patch creates is also different
> in nbd's tree vs this patch.
> 
He sent a follow up to fix this and had been folded into nbd's tree.

Ryder

