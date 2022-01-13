Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1648D572
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 11:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiAMKKu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 05:10:50 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45256 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231590AbiAMKKu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 05:10:50 -0500
X-UUID: 070e4b9494684a01b23a5df5068794cd-20220113
X-UUID: 070e4b9494684a01b23a5df5068794cd-20220113
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1184831195; Thu, 13 Jan 2022 18:10:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 18:10:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 18:10:29 +0800
Message-ID: <2ab2731dc44494dbfe89363638cdcaf49351afbe.camel@mediatek.com>
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
Date:   Thu, 13 Jan 2022 18:10:29 +0800
In-Reply-To: <Yd7ZKb7Qsh4lGA5E@lore-desk>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
         <8b2098132192c0381e41ac78a47b7318d5c28b04.1641901681.git.Bo.Jiao@mediatek.com>
         <Yd7ZKb7Qsh4lGA5E@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-01-12 at 14:35 +0100, Lorenzo Bianconi wrote:
> > 
> > @@ -302,6 +316,15 @@ struct mt7915_dev {
> >  		u8 table_mask;
> >  		u8 n_agrt;
> >  	} twt;
> > +
> > +	struct reset_control *rstc;
> > +	void __iomem *dcm;
> > +	void __iomem *sku;
> > +
> > +	struct {
> > +		bool is_7975;
> > +		bool is_7976;
> > +	} adie[MT7986_MAX_ADIE_NUM];
> 
> do we really need it? Can we just read data from chip when necessary?
> it is not
> access in the hot-path, right?
> I think it is easier and more readable.

Adie registers are inaccessible after wfsys power on so we need some
places to store chip configuration.
We will modify it to make it more readable.
+ u32 adie;

thanks,
Peter

