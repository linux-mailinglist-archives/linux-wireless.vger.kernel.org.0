Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB5AB3A672
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2019 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfFIOoq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jun 2019 10:44:46 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:33049 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfFIOoq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jun 2019 10:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=yM5fipLJxa/mXIFECT+TVx859Rd8WsNIXWXUZfpdc50=;
        b=ym07mQSzwe4qYsiK1HfUlQn/7+J/wdkHo+BrYWzngx3y14nQ87lTYu6X0bbCkLHMZI3Pfg15VY8UX7isXd34+lS5+2vsm4K8FG+6fJc4Jq6ed84HNCX6bO3FOXdfKZTokoJMbIzHXEG3gDvKGbGz8pBwsU1VkKCONDKS+9mADyw=;
Subject: Re: [PATCH] mt76: mt7615: add support for per-chain signal strength
 reporting
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <3912a2863e858f3623ced61737836e42c7b19149.1560071167.git.ryder.lee@mediatek.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <d6cfd2e9-4b2b-36ac-6cae-a34f74204801@newmedia-net.de>
Date:   Sun, 9 Jun 2019 16:44:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3912a2863e858f3623ced61737836e42c7b19149.1560071167.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f05:3a00:f095:7be4:6d09:fd49]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1hZz3z-0006SK-2d; Sun, 09 Jun 2019 16:44:51 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

according to my findings

MT_RXV4_RCPI1 is part of rx descriptor 4 and not 3
so it must be rxdg4 = rxd[4] etc.
however rxdg3 contains MT_RXV3_IB_RSSIRX which can be used for signal calculation.
i already wrote a similar code for this driver which i sended to felix a long time ago.

my variant looks like
                 status->signal = (FIELD_GET(MT_RXV3_IB_RSSIRX, rxdg3) - 220) / 2;
                 status->chain_signal[0] = (FIELD_GET(MT_RXV4_RCPI0, rxdg4) - 220) / 2;
                 status->chain_signal[1] = (FIELD_GET(MT_RXV4_RCPI1, rxdg4) - 220) / 2;
                 status->chain_signal[2] = (FIELD_GET(MT_RXV4_RCPI2, rxdg4) - 220) / 2;
                 status->chain_signal[3] = (FIELD_GET(MT_RXV4_RCPI3, rxdg4) - 220) / 2;


Am 09.06.2019 um 11:09 schrieb Ryder Lee:
> Fill in RX status->chain_signal to avoid empty value.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7615/mac.c   | 30 ++++++++++++++++++-
>   .../net/wireless/mediatek/mt76/mt7615/mac.h   |  5 ++++
>   2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> index b60d42b5923d..9ee83ea11b8c
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -13,6 +13,11 @@
>   #include "../dma.h"
>   #include "mac.h"
>   
> +static inline s8 to_rssi(u32 field, u32 rxv)
> +{
> +	return (FIELD_GET(field, rxv) - 220) / 2;
> +}
> +
>   static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
>   					    u8 idx, bool unicast)
>   {
> @@ -120,6 +125,7 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
>   	if (rxd0 & MT_RXD0_NORMAL_GROUP_3) {
>   		u32 rxdg0 = le32_to_cpu(rxd[0]);
>   		u32 rxdg1 = le32_to_cpu(rxd[1]);
> +		u32 rxdg3 = le32_to_cpu(rxd[3]);
>   		u8 stbc = FIELD_GET(MT_RXV1_HT_STBC, rxdg0);
>   		bool cck = false;
>   
> @@ -169,7 +175,29 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
>   
>   		status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
>   
> -		/* TODO: RSSI */
> +		status->chains = dev->mt76.antenna_mask;
> +		status->chain_signal[0] = to_rssi(MT_RXV4_RCPI0, rxdg3);
> +		status->signal = status->chain_signal[0];
> +
> +		switch (status->chains) {
> +		case 0x3:
> +			status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
> +			status->signal = max(status->signal,
> +					     status->chain_signal[1]);
> +			break;
> +		case 0x7:
> +			status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
> +			status->signal = max(status->signal,
> +					     status->chain_signal[2]);
> +			break;
> +		case 0xf:
> +			status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
> +			status->signal = max(status->signal,
> +					     status->chain_signal[3]);
> +			break;
> +		default:
> +			break;
> +		}
>   		rxd += 6;
>   		if ((u8 *)rxd - skb->data >= skb->len)
>   			return -EINVAL;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
> index 18ad4b8a3807..b00ce8db58e9
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
> @@ -98,6 +98,11 @@ enum rx_pkt_type {
>   #define MT_RXV2_GROUP_ID		GENMASK(26, 21)
>   #define MT_RXV2_LENGTH			GENMASK(20, 0)
>   
> +#define MT_RXV4_RCPI3			GENMASK(31, 24)
> +#define MT_RXV4_RCPI2			GENMASK(23, 16)
> +#define MT_RXV4_RCPI1			GENMASK(15, 8)
> +#define MT_RXV4_RCPI0			GENMASK(7, 0)
> +
>   enum tx_header_format {
>   	MT_HDR_FORMAT_802_3,
>   	MT_HDR_FORMAT_CMD,
