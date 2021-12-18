Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F809479C98
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Dec 2021 21:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhLRUhE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Dec 2021 15:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhLRUhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Dec 2021 15:37:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4BCC061574
        for <linux-wireless@vger.kernel.org>; Sat, 18 Dec 2021 12:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fzhE9l1Vy+eB+bQ/AVEdSdxWGhJfwigZvh683nqkN1A=; b=oto1aEk1FDJLfvJecLrBYfiO6R
        YojVid1Tz/qVeUb3thxPt2SMFbiXFT5tDlKY/9LkQ0IIvqP+NT4gBtrRIt0bysi8PuEQ2cS1d+MBI
        BTbTekBLznCF6et3xfVMnmFXfjRZzlMh/7wuzXckipc4Iv4vAg0MTVOK+bdd4JNTDAzo=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mygRs-0003tM-Qe; Sat, 18 Dec 2021 21:36:56 +0100
Message-ID: <bd53c19d-9240-e322-046d-f14083282ea3@nbd.name>
Date:   Sat, 18 Dec 2021 21:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 1/7] mt76: mt7915: rely on mt76_connac_mcu_alloc_sta_req
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
References: <cover.1639763123.git.lorenzo@kernel.org>
 <25810c3e3258c43119bf6db434d02eb3d40745a5.1639763123.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <25810c3e3258c43119bf6db434d02eb3d40745a5.1639763123.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-12-17 18:48, Lorenzo Bianconi wrote:
> Rely on mt76_connac_mcu_alloc_sta_req routine and remove
> duplicated code.
> Add MT76_CONNAC_LIB module dependency in mt7915 module
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   .../net/wireless/mediatek/mt76/mt76_connac.h  |  5 ++
>   .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 10 +--
>   .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 23 ++++++-
>   .../net/wireless/mediatek/mt76/mt7915/Kconfig |  2 +-
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 66 +++++++------------
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 --
>   6 files changed, 54 insertions(+), 57 deletions(-)
> 
>   				  struct mt76_connac_pm *pm);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index f79e3d5084f3..fc5c870da420 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -266,19 +266,19 @@ mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
>   EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_nested_tlv);
>   
>   struct sk_buff *
> -mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
> -			      struct mt76_wcid *wcid)
> +__mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
> +				struct mt76_wcid *wcid, int len)
>   {
>   	struct sta_req_hdr hdr = {
>   		.bss_idx = mvif->idx,
> -		.muar_idx = wcid ? mvif->omac_idx : 0,
>   		.is_tlv_append = 1,
>   	};
>   	struct sk_buff *skb;
>   
> +	hdr.muar_idx = mt76_connac_mcu_get_muar_idx(dev, wcid, mvif);
No need for a separate inline function if it's only used in this one place.

> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 5baf8370b7bd..4c0220df18b4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -570,6 +570,7 @@ struct wtbl_raw {
>   					 sizeof(struct sta_rec_muru) +	\
>   					 sizeof(struct sta_rec_bfee) +	\
>   					 sizeof(struct sta_rec_ra) +	\
> +					 sizeof(struct sta_rec_sec) +	\
>   					 sizeof(struct sta_rec_ra_fixed) + \
>   					 sizeof(struct sta_rec_he_6g_capa) + \
>   					 sizeof(struct tlv) +		\
> @@ -1436,7 +1437,7 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
>   {
>   	*wlan_idx_hi = 0;
>   
> -	if (is_mt7921(dev)) {
> +	if (is_mt7921(dev) || is_mt7915(dev)) {
>   		*wlan_idx_lo = wcid ? to_wcid_lo(wcid->idx) : 0;
>   		*wlan_idx_hi = wcid ? to_wcid_hi(wcid->idx) : 0;
>   	} else {
> @@ -1444,9 +1445,27 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
>   	}
>   }
>   
> +static inline int
> +mt76_connac_mcu_get_muar_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
> +			     struct mt76_vif *mvif)
> +{
> +	if (is_mt7915(dev))
> +		return wcid && wcid->sta ? mvif->omac_idx : 0xe;
> +
> +	return wcid ? mvif->omac_idx : 0;
 From what I can tell, the broadcast muar index should be 0xe for all 
chips, not just mt7915. Would make sense to do this in a separate patch 
before this one though.

- Felix
