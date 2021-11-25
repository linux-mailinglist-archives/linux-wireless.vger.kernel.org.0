Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B9D45E0CC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 19:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbhKYTB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 14:01:56 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33268 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235638AbhKYS74 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 13:59:56 -0500
X-UUID: 4126f4e3acde4ed183b0501b82b8f554-20211126
X-UUID: 4126f4e3acde4ed183b0501b82b8f554-20211126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1942505478; Fri, 26 Nov 2021 02:56:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 26 Nov 2021 02:56:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Nov 2021 02:56:40 +0800
Message-ID: <7e06ea885e336e261b6ca458d371921df44af6b8.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7915: update station's airtime and gi from event
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Date:   Fri, 26 Nov 2021 02:56:40 +0800
In-Reply-To: <20211125091330.27770-1-MeiChia.Chiu@mediatek.com>
References: <20211125091330.27770-1-MeiChia.Chiu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-11-25 at 17:13 +0800, MeiChia Chiu wrote:
> From: MeiChia Chiu <meichia.chiu@mediatek.com>

Should be [RFC].

> To avoid race condition in firmware,
> if firmware support airtime and gi event,
> driver update station's airtime and gi from event.
> 
> Reviewed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> 
> ---
>  .../net/wireless/mediatek/mt76/mt7915/init.c   |   2 +
>  .../net/wireless/mediatek/mt76/mt7915/mac.c    |  35 ++++++++----
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c    | 138
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h    |  28 ++++++++++
>  .../net/wireless/mediatek/mt76/mt7915/mt7915.h |  11 ++++
>  5 files changed, 204 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index 4b56358d..a5f6d25d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -960,6 +960,8 @@ int mt7915_register_device(struct mt7915_dev
> *dev)
>  	if (ret)
>  		return ret;
>  
> +	dev->fw_ver = mt76_rr(dev, MT_SWDEF(0x7c));
> +
>  	return mt7915_init_debugfs(&dev->phy);
>  }
>  
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> index 1041d88f..b2e20251 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1433,7 +1433,8 @@ mt7915_mac_tx_free(struct mt7915_dev *dev,
> struct sk_buff *skb)
>  		mt7915_txwi_free(dev, txwi, sta, &free_list);
>  	}
>  
> -	mt7915_mac_sta_poll(dev);
> +	if (!mt7915_firmware_offload(dev))
> +		mt7915_mac_sta_poll(dev);

@ Sujuan, can you double check if MCU_EXT_EVENT_TXRX_AIR_TIME works for
all firmware versions? Maybe we can use this single event directly if
everyone agrees with this change. 

I'd suggest adding some persuasive testing datas into the commit
message to help reviewers make adjudgement.

Ryder

