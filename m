Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D2448E27D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 03:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiANCWC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 21:22:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48258 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229863AbiANCWC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 21:22:02 -0500
X-UUID: 3b1fa1f097764781a3dae860d2592365-20220114
X-UUID: 3b1fa1f097764781a3dae860d2592365-20220114
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1390555901; Fri, 14 Jan 2022 10:21:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Jan 2022 10:21:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Jan 2022 10:21:58 +0800
Message-ID: <57feb4a99c835e6a70496e8e935501bb12a393b3.camel@mediatek.com>
Subject: Re: [PATCH v2 3/5] mt76: mt7915: add support for MT7986
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Xing Song" <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <bo.jiao@mediatek.com>
Date:   Fri, 14 Jan 2022 10:21:58 +0800
In-Reply-To: <YeAvXzG6ueZWxoGa@lore-desk>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
         <8b2098132192c0381e41ac78a47b7318d5c28b04.1641901681.git.Bo.Jiao@mediatek.com>
         <Yd7ZKb7Qsh4lGA5E@lore-desk>
         <2ab2731dc44494dbfe89363638cdcaf49351afbe.camel@mediatek.com>
         <Yd/8mXumr25iESux@lore-desk> <YeAvXzG6ueZWxoGa@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-01-13 at 14:55 +0100, Lorenzo Bianconi wrote:
> > > On Wed, 2022-01-12 at 14:35 +0100, Lorenzo Bianconi wrote:
> > > > > 
> > > > > @@ -302,6 +316,15 @@ struct mt7915_dev {
> > > > >  		u8 table_mask;
> > > > >  		u8 n_agrt;
> > > > >  	} twt;
> > > > > +
> > > > > +	struct reset_control *rstc;
> > > > > +	void __iomem *dcm;
> > > > > +	void __iomem *sku;
> > > > > +
> > > > > +	struct {
> > > > > +		bool is_7975;
> > > > > +		bool is_7976;
> > > > > +	} adie[MT7986_MAX_ADIE_NUM];
> > > > 
> > > > do we really need it? Can we just read data from chip when
> > > > necessary?
> > > > it is not
> > > > access in the hot-path, right?
> > > > I think it is easier and more readable.
> > > 
> > > Adie registers are inaccessible after wfsys power on so we need
> > > some
> > > places to store chip configuration.
> > > We will modify it to make it more readable.
> > > + u32 adie;
> > 
> > what I mean is just continue reading these values after the first
> > time (that is
> > in common for both approaches).
> 
> ok, sorry I misread your reply. Anyway it seems to me we need these
> values just
> in mt7986_wmac_enable() (or in routines called by
> mt7986_wmac_enable). Right?
> If so maybe we can just store them in a local struct in
> mt7986_wmac_enable().
> What do you think?
> 
OK, I will fix it in the next patch.

thanks,
Peter
> Regards,
> Lorenzo
> 
> > 
> > Regards,
> > Lorenzo
> > 
> > > 
> > > thanks,
> > > Peter
> > > 
> 
> 

