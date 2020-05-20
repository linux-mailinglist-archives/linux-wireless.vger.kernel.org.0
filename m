Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A681DAA5F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 08:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgETGKp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 02:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETGKo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 02:10:44 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A766C061A0E
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 23:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hvSYZv282X6tnUFKanEpVpgDIJJ4VfP0USEAv2fAfqo=; b=jbR8dL/4AuxPPChkEuiBtmfFbB
        lcF8zGVhroSziGtrFpPuoNOLhdnMmplw7BwrYdHxKHWb2vacjjlibETuIG9gPnA4UuhBkpO0ZQLN0
        MqPydAwy/icxiccWhlhPFa1pt3PSYZVSDu5vTDVBuFD5w4pktns+XMufMzi/CObbmlpE=;
Received: from p5b206c3b.dip0.t-ipconnect.de ([91.32.108.59] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jbHw8-0004pO-KI; Wed, 20 May 2020 08:10:40 +0200
Subject: Re: [PATCH] mt76: fix kbuild test robot warnings
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-wireless@vger.kernel.org
References: <82c0a9e246ea2a4e7344dcd7476f5cf491f7dde5.1589930747.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <64c2f770-9251-3530-6395-5d8437fae923@nbd.name>
Date:   Wed, 20 May 2020 08:10:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <82c0a9e246ea2a4e7344dcd7476f5cf491f7dde5.1589930747.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-20 01:55, Ryder Lee wrote:
> Fix the following warnings:
> 
> warning: comparison is always false/true due to limited range of data type [-Wtype-limits].
> warning: variable 'msta' set but not used
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> @felix, maybe fold this patch into the previous one (if it's not yet merged).
The previous changes are in linux-next, so nothing can be folded in anymore.

>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c  | 4 ++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 4 ++--
>  drivers/net/wireless/mediatek/mt76/mt76x02.h     | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.h | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 3 ---
>  6 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> index f8c0c957ca01..f40dc4374eee 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
> @@ -468,7 +468,7 @@ void mt7603_mac_sta_poll(struct mt7603_dev *dev)
>  }
>  
>  static struct mt76_wcid *
> -mt7603_rx_get_wcid(struct mt7603_dev *dev, u8 idx, bool unicast)
> +mt7603_rx_get_wcid(struct mt7603_dev *dev, u16 idx, bool unicast)
>  {
>  	struct mt7603_sta *sta;
>  	struct mt76_wcid *wcid;
> @@ -1227,7 +1227,7 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
>  	struct mt76_wcid *wcid;
>  	__le32 *txs_data = data;
>  	u32 txs;
> -	u8 wcidx;
> +	u16 wcidx;
>  	u8 pid;
>  
>  	txs = le32_to_cpu(txs_data[4]);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> index 7d65a3fb0c23..08b950386bc8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -56,7 +56,7 @@ static const struct mt7615_dfs_radar_spec jp_radar_specs = {
>  };
>  
>  static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
> -					    u8 idx, bool unicast)
> +					    u16 idx, bool unicast)
>  {
>  	struct mt7615_sta *sta;
>  	struct mt76_wcid *wcid;
> @@ -1291,7 +1291,7 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
>  	struct mt76_phy *mphy = &dev->mt76.phy;
>  	__le32 *txs_data = data;
>  	u32 txs;
> -	u8 wcidx;
> +	u16 wcidx;
>  	u8 pid;
>  
>  	txs = le32_to_cpu(txs_data[0]);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
> index 6ea210bd3f07..5adcc9fa842a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
> @@ -242,7 +242,7 @@ mt76x02_wait_for_txrx_idle(struct mt76_dev *dev)
>  }
>  
>  static inline struct mt76x02_sta *
> -mt76x02_rx_get_sta(struct mt76_dev *dev, u8 idx)
> +mt76x02_rx_get_sta(struct mt76_dev *dev, u16 idx)
>  {
>  	struct mt76_wcid *wcid;
>  
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
> index a5a3bcd30d6f..a824412d1b8b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
> @@ -778,7 +778,7 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
>  	int pad_len = 0, nstreams = dev->chainmask & 0xf;
>  	s8 signal;
>  	u8 pn_len;
> -	u8 wcid;
> +	u16 wcid;
>  	int len;
>  
>  	if (!test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> index c70d17b2290c..e4c405130e60 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> @@ -14,7 +14,7 @@ struct mt76x02_tx_status {
>  	u8 success:1;
>  	u8 aggr:1;
>  	u8 ack_req:1;
> -	u8 wcid;
> +	u16 wcid;
>  	u8 pktid;
>  	u8 retry;
>  	u16 rate;
All of the changes above are wrong and only paper over a real bug, since
the chip limit of 128 entries for 76xx still needs to be checked.
I'm sending a fix for this, so please send a new patch with only the
change below.

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 95cd24f41f98..f81afcc51801 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -1836,15 +1836,12 @@ static u8
>  mt7915_mcu_sta_txbf_type(struct mt7915_phy *phy, struct ieee80211_vif *vif,
>  			 struct ieee80211_sta *sta)
>  {
> -	struct mt7915_sta *msta;
>  	u8 type = 0;
>  
>  	if (vif->type != NL80211_IFTYPE_STATION &&
>  	    vif->type != NL80211_IFTYPE_AP)
>  		return 0;
>  
> -	msta = (struct mt7915_sta *)sta->drv_priv;
> -
>  	if (sta->he_cap.has_he) {
>  		struct ieee80211_he_cap_elem *pe;
>  		const struct ieee80211_he_cap_elem *ve;
> 

Thanks,

- Felix
