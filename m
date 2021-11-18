Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1309245611F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhKRRJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:09:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40962 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233906AbhKRRJa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:09:30 -0500
X-UUID: 85a6589e6beb4028af98d554c1dd8b60-20211119
X-UUID: 85a6589e6beb4028af98d554c1dd8b60-20211119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 309307887; Fri, 19 Nov 2021 01:06:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Nov 2021 01:06:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Nov 2021 01:06:25 +0800
Message-ID: <c0a09707cf9bcf1205b60c7a36e5afa2a6b2f39c.camel@mediatek.com>
Subject: Re: [PATCH 1/8] mt76: mt7915: cache sgi in wcid.
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
Date:   Fri, 19 Nov 2021 01:06:25 +0800
In-Reply-To: <20211118164549.3863-1-greearb@candelatech.com>
References: <20211118164549.3863-1-greearb@candelatech.com>
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
> Explicitly cache short_gi and he_gi in wcid, don't try to store
> it in the wcid.rate object.  Slightly less confusing and less fragile
> when TXS starts parsing lots of frames.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> 
> This is actually the first series, not that one I posted a few
> minutes
> ago.  txs, tx overrides and other things.  Rebased on top of 5.16
> 
>  drivers/net/wireless/mediatek/mt76/mt76.h       |  5 +++++
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 17 +++++++++++++
> ----
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h
> b/drivers/net/wireless/mediatek/mt76/mt76.h
> index e2da720a91b6..7234703b3c60 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -245,7 +245,12 @@ struct mt76_wcid {
>  	struct ewma_signal rssi;
>  	int inactive_count;
>  
> +	/* cached rate, updated from mac_sta_poll() and from TXS
> callback logic,
> +	 * in 7915 at least.
> +	 */
>  	struct rate_info rate;
> +	bool rate_short_gi; /* cached HT/VHT short_gi, from
> mac_sta_poll() */
> +	u8 rate_he_gi; /* cached HE GI, from mac_sta_poll() */
>  
>  	u16 idx;
>  	u8 hw_key_idx;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> index 5fcf35f2d9fb..61ade279b35d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -206,13 +206,19 @@ static void mt7915_mac_sta_poll(struct
> mt7915_dev *dev)
>  			u8 offs = 24 + 2 * bw;
>  
>  			rate->he_gi = (val & (0x3 << offs)) >> offs;
> +			msta->wcid.rate_he_gi = rate->he_gi; /* cache
> for later */
>  		} else if (rate->flags &
>  			   (RATE_INFO_FLAGS_VHT_MCS |
> RATE_INFO_FLAGS_MCS)) {
> -			if (val & BIT(12 + bw))
> +			if (val & BIT(12 + bw)) {
>  				rate->flags |=
> RATE_INFO_FLAGS_SHORT_GI;
> -			else
> +				msta->wcid.rate_short_gi = 1;
> +			}
> +			else {
>  				rate->flags &=
> ~RATE_INFO_FLAGS_SHORT_GI;
> +				msta->wcid.rate_short_gi = 0;
> +			}
>  		}
> +		/* TODO:  Deal with HT_MCS */
>  	}
>  
>  	rcu_read_unlock();
> @@ -1411,7 +1417,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev,
> struct mt76_wcid *wcid, int pid,
>  			goto out;
>  
>  		rate.flags = RATE_INFO_FLAGS_MCS;
> -		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
> +		if (wcid->rate_short_gi)
>  			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
>  		break;
>  	case MT_PHY_TYPE_VHT:
> @@ -1419,6 +1425,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev,
> struct mt76_wcid *wcid, int pid,
>  			goto out;
>  
>  		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
> +		if (wcid->rate_short_gi)
> +			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
>  		break;
>  	case MT_PHY_TYPE_HE_SU:
>  	case MT_PHY_TYPE_HE_EXT_SU:
> @@ -1427,11 +1435,12 @@ mt7915_mac_add_txs_skb(struct mt7915_dev
> *dev, struct mt76_wcid *wcid, int pid,
>  		if (rate.mcs > 11)
>  			goto out;
>  
> -		rate.he_gi = wcid->rate.he_gi;
> +		rate.he_gi = wcid->rate_he_gi;
>  		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
>  		rate.flags = RATE_INFO_FLAGS_HE_MCS;
>  		break;
>  	default:
> +		WARN_ON_ONCE(true);
>  		goto out;
>  	}

Maybe we can consider switching to use existing fixed-rate method in
debugfs? On th other hand, that's the only way to configure HE MU UL
fixed-rate.

Ryder

