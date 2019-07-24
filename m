Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054C472533
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 05:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfGXDPx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 23:15:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47175 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbfGXDPx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 23:15:53 -0400
X-UUID: c2537188f1c24a84987cc8212d93d3b3-20190724
X-UUID: c2537188f1c24a84987cc8212d93d3b3-20190724
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1780678813; Wed, 24 Jul 2019 11:15:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 11:15:46 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 11:15:46 +0800
Message-ID: <1563938146.8010.4.camel@mtkswgap22>
Subject: Re: [PATCH] mt76: switch to SPDX tag instead of verbose boilerplate
 text
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Roy Luo <royluo@google.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 24 Jul 2019 11:15:46 +0800
In-Reply-To: <CA+zupgyq9VZkstdOOX4E_G9KWVN2WB+u0XnLiFAbxGws6Mt4qA@mail.gmail.com>
References: <6f6d5cf551a0b0d0dd1b902aca2c5417b7f98da7.1563864007.git.ryder.lee@mediatek.com>
         <CA+zupgyq9VZkstdOOX4E_G9KWVN2WB+u0XnLiFAbxGws6Mt4qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-24 at 11:03 +0800, Roy Luo wrote:
> Hi Ryder,
> 
> Please follow the convention, some of your header files use //.
> 
> C source: // SPDX-License-Identifier: <SPDX License Expression>
> C header: /* SPDX-License-Identifier: <SPDX License Expression> */
> 
> Regards,
> Cheng-Hao (Roy) Luo

I also found that - copy paste mistake.

And I will fold this one into 'fix many checkpatch.pl warnings' series
then send v1.

Ryder

> On Tue, Jul 23, 2019 at 2:45 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
> >
> > Add SPDX identifiers to all remaining files in mt76/
> >
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---


