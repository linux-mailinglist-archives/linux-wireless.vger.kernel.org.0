Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB046B3D5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 08:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhLGH3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 02:29:22 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:35684 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229960AbhLGH3W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 02:29:22 -0500
X-UUID: d1f291a8f0bc411b968fc590b218a79d-20211207
X-UUID: d1f291a8f0bc411b968fc590b218a79d-20211207
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 629710709; Tue, 07 Dec 2021 15:25:49 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Dec 2021 15:25:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Dec
 2021 15:25:48 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Dec 2021 15:25:47 +0800
Message-ID: <72ca4f5fe3c351ec56dee4935b28c7b7f26188c2.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7915: add mu-mimo and ofdma debugfs knobs
From:   meichia chiu <meichia.chiu@mediatek.com>
To:     Ben Greear <greearb@candelatech.com>, Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 7 Dec 2021 15:25:48 +0800
In-Reply-To: <7158a937-57f3-2bd8-591e-124a18d2d8e8@candelatech.com>
References: <20211206141006.29632-1-MeiChia.Chiu@mediatek.com>
         <7158a937-57f3-2bd8-591e-124a18d2d8e8@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-12-06 at 08:43 -0800, Ben Greear wrote:
> On 12/6/21 6:10 AM, MeiChia Chiu wrote:
> > From: MeiChia Chiu <meichia.chiu@mediatek.com>
> > 
> > Add mu-mimo and ofdma packet counters statistics.
> 
> Hello,
> 
> Are these stats clear-on-read in the firmware?  If so, then we need
> to accumulate
> them in the driver.
> 
> Is there any significant downside to enabling the stats?  For
> instance, a performance
> degradation in the firmware/hardware?
> 
> Thanks,
> Ben

Hi Ben,

Yes, the current design is clear-on-read and its sole purpose is for
debugging only. If you need statistics, this may have to be done in
another way.

Yes, a performance degradation is expected since enabling this debug
function would burden MCU with more calculation.

Thanks,
Meichia

