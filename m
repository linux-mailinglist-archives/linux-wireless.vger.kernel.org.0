Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372CE42B818
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 08:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhJMG5z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 02:57:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37526 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229905AbhJMG5y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 02:57:54 -0400
X-UUID: 8277f3bcf4654394ab0f5dd6a9900b75-20211013
X-UUID: 8277f3bcf4654394ab0f5dd6a9900b75-20211013
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1323289548; Wed, 13 Oct 2021 14:50:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 13 Oct 2021 14:50:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Oct 2021 14:50:36 +0800
Message-ID: <213a93b6360e8226b409d905e518154b1eade598.camel@mediatek.com>
Subject: Re: [PATCH] MAINTAINERS: mt76: update MTK folks
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 13 Oct 2021 14:50:36 +0800
In-Reply-To: <87y26xzbwh.fsf@tynnyri.adurom.net>
References: <5b452d209fb97be1a39a2d7775557bc8f43bd07c.1634104734.git.ryder.lee@mediatek.com>
         <87y26xzbwh.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-10-13 at 09:17 +0300, Kalle Valo wrote:
> Ryder Lee <ryder.lee@mediatek.com> writes:
> 
> > Update entries for MTK folks.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  MAINTAINERS | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index eeb4c70b3d5b..6745119b70bb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11818,7 +11818,9 @@ F:	drivers/mmc/host/mtk-sd.c
> >  MEDIATEK MT76 WIRELESS LAN DRIVER
> >  M:	Felix Fietkau <nbd@nbd.name>
> >  M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> > -R:	Ryder Lee <ryder.lee@mediatek.com>
> > +M:	Ryder Lee <ryder.lee@mediatek.com>
> > +M:	Shayne Chen <shayne.chen@mediatek.com>
> > +M:	Sean Wang <sean.wang@mediatek.com>
> 
> I don't really like of having five maintainers for a driver, that
> just
> usually ends up that nobody takes responsibility. I would rather have
> just one, or maybe two, maintainers and no more.
> 
> Reviewers are of course another matter, having more of them is just a
> good thing.
> 
What about 3M2R? We need at least one representative from MTK for some
reasons.

Ryder

