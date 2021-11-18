Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC9456159
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhKRRWd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:22:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54362 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234070AbhKRRWd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:22:33 -0500
X-UUID: 34dabb7d07bd4674b628c1f3320c4509-20211119
X-UUID: 34dabb7d07bd4674b628c1f3320c4509-20211119
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1424351885; Fri, 19 Nov 2021 01:19:30 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 19 Nov 2021 01:19:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Nov
 2021 01:19:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Nov 2021 01:19:29 +0800
Message-ID: <d058fd943d7522104beeee626f3295f13f6439b7.camel@mediatek.com>
Subject: Re: [PATCH 6/8] mt76: mt7915: report tx-retries
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
Date:   Fri, 19 Nov 2021 01:19:29 +0800
In-Reply-To: <20211118164549.3863-6-greearb@candelatech.com>
References: <20211118164549.3863-1-greearb@candelatech.com>
         <20211118164549.3863-6-greearb@candelatech.com>
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
> mac80211 stack will only report tx-status for skb claiming to be
> ampdu heads,
> so lie a bit in mt7915 and set the flag so that mac80211 will record
> status
> for each skb.
> 
> mt7915 appears to report retry status on an individual per-skb
> manner,
> so that method above seems to work.
> 
> Re-constitute the txinfo status rate info so that the rix and flags
> is also at least close to correct.  No direct way to report HE
> rates that way, so mac80211 might could use some tweaking in
> the ieee80211_tx_status_ext to take both info and status->rate
> into account.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 93
> ++++++++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7915/mac.h   |  4 +-
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +
>  drivers/net/wireless/mediatek/mt76/tx.c       |  6 +-
>  7 files changed, 110 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c
> b/drivers/net/wireless/mediatek/mt76/mac80211.c
> index 62807dc311c1..a385c1850c61 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -1517,6 +1517,10 @@ void mt76_ethtool_worker(struct
> mt76_ethtool_worker_info *wi,
>  
>  	wi->sta_count++;
>  
> +	data[ei++] += stats->tx_mpdu_attempts;
> +	data[ei++] += stats->tx_mpdu_fail;
> +	data[ei++] += stats->tx_mpdu_retry;
> +	data[ei++] += stats->tx_mpdu_ok;
>  	data[ei++] += stats->tx_mode[MT_PHY_TYPE_CCK];
>  	data[ei++] += stats->tx_mode[MT_PHY_TYPE_OFDM];
>  	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HT];
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h
> b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 7234703b3c60..5a431b39d5c1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -785,6 +785,11 @@ enum mt76_phy_type {
>  };
>  
>  struct mt76_sta_stats {
> +	unsigned long tx_mpdu_attempts; /* counting any retries */
> +	unsigned long tx_mpdu_fail; /* frames that failed even after
> retry */
> +	unsigned long tx_mpdu_ok; /* frames that succeeded,
> +				     perhaps after retry */
> +	unsigned long tx_mpdu_retry; /* number of times frames were
> retried */
>  	u64 tx_mode[__MT_PHY_TYPE_HE_MAX];
>  	u64 tx_bw[4];		/* 20, 40, 80, 160 */
>  	u64 tx_nss[4];		/* 1, 2, 3, 4 */
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index 3b35ea245b33..90aa62c64f3e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -311,6 +311,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
>  	struct wiphy *wiphy = hw->wiphy;
>  
>  	hw->queues = 4;
> +	hw->max_report_rates = 1;
>  	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
>  	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
>  	hw->netdev_features = NETIF_F_RXCSUM;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> index e37e6b05c7a4..4f565a77770c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1246,17 +1246,22 @@ mt7915_txp_skb_unmap(struct mt76_dev *dev,
> struct mt76_txwi_cache *t)
>  
>  static void
>  mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
> -		 struct ieee80211_sta *sta, struct list_head
> *free_list)
> +		 struct ieee80211_sta *sta, struct list_head
> *free_list,
> +		 u32 tx_cnt, u32 tx_status, u32 ampdu)
>  {
>  	struct mt76_dev *mdev = &dev->mt76;
>  	struct mt76_wcid *wcid;
>  	__le32 *txwi;
>  	u16 wcid_idx;
> +	struct ieee80211_tx_info *info;
> +	struct ieee80211_tx_rate *rate;
>  
>  	mt7915_txp_skb_unmap(mdev, t);
>  	if (!t->skb)
>  		goto out;
>  
> +	rcu_read_lock(); /* protect wcid access */
> +
>  	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
>  	if (sta) {
>  		wcid = (struct mt76_wcid *)sta->drv_priv;
> @@ -1266,6 +1271,75 @@ mt7915_txwi_free(struct mt7915_dev *dev,
> struct mt76_txwi_cache *t,
>  			mt7915_tx_check_aggr(sta, txwi);
>  	} else {
>  		wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX,
> le32_to_cpu(txwi[1]));
> +		wcid = rcu_dereference(mdev->wcid[wcid_idx]);
> +	}
> +
> +	info = IEEE80211_SKB_CB(t->skb);
> +
> +	/* Cannot clear all of info->status, we need the driver private
> +	 * status intact.
> +	 */
> +	info->status.is_valid_ack_signal = 0;
> +
> +	rate = &info->status.rates[0];
> +	rate->idx = -1; /* will over-write below if we found wcid */
> +	info->status.rates[1].idx = -1; /* terminate rate list */
> +
> +	/* force TX_STAT_AMPDU to be set, or mac80211 will ignore
> status */
> +	if (ampdu || (info->flags & IEEE80211_TX_CTL_AMPDU)) {
> +		info->flags |= IEEE80211_TX_STAT_AMPDU |
> IEEE80211_TX_CTL_AMPDU;
> +		info->status.ampdu_len = 1;
> +	}
> +
> +	/* update info status based on cached wcid rate info since
> +	 * txfree path doesn't give us a lot of info.
> +	 */
> +	if (wcid) {
> +		struct mt7915_sta *msta = container_of(wcid, struct
> mt7915_sta, wcid);
> +		struct mt76_sta_stats *stats = &msta->stats;
> +
> +		if (wcid->rate.flags & RATE_INFO_FLAGS_MCS) {
> +			rate->flags |= IEEE80211_TX_RC_MCS;
> +			rate->idx = wcid->rate.mcs + wcid->rate.nss *
> 8;
> +		} else if (wcid->rate.flags & RATE_INFO_FLAGS_VHT_MCS)
> {
> +			rate->flags |= IEEE80211_TX_RC_VHT_MCS;
> +			rate->idx = (wcid->rate.nss << 4) | wcid-
> >rate.mcs;
> +		} else if (wcid->rate.flags & RATE_INFO_FLAGS_HE_MCS) {
> +			rate->idx = (wcid->rate.nss << 4) | wcid-
> >rate.mcs;

Can ieee80211_tx_rate tell HE rate apart now?

Ryder


