Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD914456118
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhKRRF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:05:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37478 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233889AbhKRRF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:05:58 -0500
X-UUID: 0e989a63f1be4352ab9fed3e8a097104-20211119
X-UUID: 0e989a63f1be4352ab9fed3e8a097104-20211119
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1517207725; Fri, 19 Nov 2021 01:02:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Nov 2021 01:02:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Nov 2021 01:02:54 +0800
Message-ID: <d8e9f53e4f6fc613ed6524abec050d248e448eeb.camel@mediatek.com>
Subject: Re: [PATCH 4/8] mt76: mt7915: add note about TXSFM 0x2
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
Date:   Fri, 19 Nov 2021 01:02:55 +0800
In-Reply-To: <20211118164549.3863-4-greearb@candelatech.com>
References: <20211118164549.3863-1-greearb@candelatech.com>
         <20211118164549.3863-4-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-11-18 at 08:45 -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This format needs a special command to enable, and is not enabled
> by default.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
> b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
> index 7a2c740d1464..b66e740832e4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
> @@ -348,6 +348,9 @@ struct mt7915_tx_free {
>  
>  #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
>  
> +/* The F0 variables are for TXSFM 0x0 and 0x1.  The F1 variables
> + * are for TXSFM 0x2 aka PPDU format.
> + */
>  #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
>  #define MT_TXS5_F0_QOS			BIT(30)
>  #define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)

Now that we don't need it why should it needs a special command.

Ryder

