Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9745610D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhKRRDB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:03:01 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59660 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233781AbhKRRDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:03:01 -0500
X-UUID: 8760d5f80add43db9936028f3597564c-20211119
X-UUID: 8760d5f80add43db9936028f3597564c-20211119
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1740847744; Fri, 19 Nov 2021 00:59:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 19 Nov 2021 00:59:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Nov 2021 00:59:56 +0800
Message-ID: <c92a3f57b1d6ad7b8dd24a4cde6325d92f0e160b.camel@mediatek.com>
Subject: Re: [PATCH 02/11] mt76: mt7915: print out hw revision
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
Date:   Fri, 19 Nov 2021 00:59:56 +0800
In-Reply-To: <20211118164056.2965-2-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
         <20211118164056.2965-2-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-11-18 at 08:40 -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Help determine what version of silicon is in use.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> index 1f6ba306c850..fcc4312555f7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -146,7 +146,7 @@ int mt7915_mmio_init(struct mt76_dev *mdev, void
> __iomem *mem_base, int irq)
>  
>  	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
>  		    (mt76_rr(dev, MT_HW_REV) & 0xff);
> -	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
> +	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
>  
>  	mt76_wr(dev, MT_INT_MASK_CSR, 0);

I prefer leaving it as is now.

Ryder

