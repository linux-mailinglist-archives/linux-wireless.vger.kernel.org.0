Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9E403F4D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 20:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348289AbhIHS4i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 14:56:38 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37970 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240231AbhIHS4i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 14:56:38 -0400
X-UUID: f413067d81e5494494b680887cf22618-20210909
X-UUID: f413067d81e5494494b680887cf22618-20210909
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 578679305; Thu, 09 Sep 2021 02:55:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Sep
 2021 02:55:26 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Sep 2021 02:55:26 +0800
Message-ID: <dbb767a306983d59beb68cb6249cd089805bb5e8.camel@mediatek.com>
Subject: Re: [PATCH v3 8/8] mt76: mt7915: set muru platform type
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Thu, 9 Sep 2021 02:55:26 +0800
In-Reply-To: <20210908094144.25641-8-shayne.chen@mediatek.com>
References: <20210908094144.25641-1-shayne.chen@mediatek.com>
         <20210908094144.25641-8-shayne.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-09-08 at 17:41 +0800, Shayne Chen wrote:
> Set muru platform type by mcu cmd to notify fw to init corresponding
> algorithm.
> 
> Suggested-by: Money Wang <money.wang@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
> v3: - fix endianess
>     - rework muru ctrl function
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 17
> +++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h |  5 +++++
>  .../net/wireless/mediatek/mt76/mt7915/mt7915.h  |  1 +
>  .../wireless/mediatek/mt76/mt7915/testmode.c    | 16 +++++--------
> ---
>  .../wireless/mediatek/mt76/mt7915/testmode.h    |  4 ----
>  5 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 229ba3c469d1..afafc47264cd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2949,6 +2949,21 @@ static int mt7915_mcu_set_mwds(struct
> mt7915_dev *dev, bool enabled)
>  				 sizeof(req), false);
>  }
>  
> +int mt7915_mcu_set_muru_ctrl(struct mt7915_dev *dev, u32 cmd, u8
> *val)
> +{
> +	struct {
> +		__le32 cmd;
> +		u8 val[4];
> +	} __packed req = {
> +		.cmd = cpu_to_le32(cmd),
> +	};
> +
> +	memcpy(req.val, val, sizeof(req.val));

Will this lead to undefined behavior if memcpy size larger than source?
what about passing u32 and using put_unaligned_le32?

Ryder

