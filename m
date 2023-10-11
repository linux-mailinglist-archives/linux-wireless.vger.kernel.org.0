Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154937C4E4A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjJKJNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 05:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjJKJNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 05:13:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8310698
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 02:13:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE42C433C7;
        Wed, 11 Oct 2023 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697015624;
        bh=zTR9jSfctFPdj2KpKIyTrJ6PeHXdRAVd7Qnm5yLcJxE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RlpztWxs7fdjkdqQV2J0GGFOFT5E4twEgNVXpQo+E7CAiT1P0fvvnc/xkYdqmVk4f
         WEg6R4lkkBVEKjQecgy6LyCrbYswAMdjJqbXS5B215TciPJYvtG9G+/e58aE3LJzU+
         Pw8qfwtlMGe3FKsgb16kySTg/aLE11PqqVNnwsXpXQzgoqLu5K52xV4PhTHTmgbuXE
         36b3jQOLXtUzKon/gJYKKGabluPGt1i9GTn0PRnUuRG/vElygXTFiPQeC5I6KAfHcx
         2iVOl2amsJADA9pJ0YBpDG7a1HJXJYBnHet4uXhb+qReyziaUFC9TQHJE9CV46Aj+e
         P1+NhnGRWbvVA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] wifi: rtw89: add EHT radiotap in monitor mode
References: <20231010021006.6061-1-pkshih@realtek.com>
        <20231010021006.6061-7-pkshih@realtek.com>
Date:   Wed, 11 Oct 2023 12:13:41 +0300
In-Reply-To: <20231010021006.6061-7-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Tue, 10 Oct 2023 10:10:06 +0800")
Message-ID: <87il7d4j3u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Add IEEE80211_RADIOTAP_EHT and IEEE80211_RADIOTAP_EHT_USIG radiotap to
> fill basic EHT NSS, MCS, GI and bandwidth.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 66 +++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/core.h |  9 +++-
>  2 files changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> index 2742e6646cf1..8cb1715d049a 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1907,6 +1907,70 @@ static void rtw89_core_hw_to_sband_rate(struct ieee80211_rx_status *rx_status)
>  	rx_status->rate_idx -= 4;
>  }
>  
> +static u8 rx_status_bw_to_radiotap_eht_usig[] = {
> +	[RATE_INFO_BW_20] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_20MHZ,
> +	[RATE_INFO_BW_5] = U8_MAX,
> +	[RATE_INFO_BW_10] = U8_MAX,
> +	[RATE_INFO_BW_40] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_40MHZ,
> +	[RATE_INFO_BW_80] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_80MHZ,
> +	[RATE_INFO_BW_160] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_160MHZ,
> +	[RATE_INFO_BW_HE_RU] = U8_MAX,
> +	[RATE_INFO_BW_320] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_320MHZ_1,
> +	[RATE_INFO_BW_EHT_RU] = U8_MAX,
> +};

Sorry, I noticed this only when I was abot to commit this. Should this
be static const?

> +static void rtw89_core_update_radiotap_eht(struct rtw89_dev *rtwdev,
> +					   struct sk_buff *skb,
> +					   struct ieee80211_rx_status *rx_status)
> +{
> +	struct ieee80211_radiotap_eht_usig *usig;
> +	struct ieee80211_radiotap_eht *eht;
> +	struct ieee80211_radiotap_tlv *tlv;
> +	int eht_len = struct_size(eht, user_info, 1);
> +	int usig_len = sizeof(*usig);
> +	int len;
> +	u8 bw;
> +
> +	len = sizeof(*tlv) + ALIGN(eht_len, 4) +
> +	      sizeof(*tlv) + ALIGN(usig_len, 4);
> +
> +	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
> +	skb_reset_mac_header(skb);
> +
> +	/* EHT */
> +	tlv = skb_push(skb, len);
> +	memset(tlv, 0, len);
> +	tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT);
> +	tlv->len = cpu_to_le16(eht_len);
> +
> +	eht = (struct ieee80211_radiotap_eht *)tlv->data;
> +	eht->known = cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_GI);
> +	eht->data[0] =
> +		le32_encode_bits(rx_status->eht.gi, IEEE80211_RADIOTAP_EHT_DATA0_GI);
> +
> +	eht->user_info[0] =
> +		cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
> +			    IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O);
> +	eht->user_info[0] |=
> +		le32_encode_bits(rx_status->rate_idx, IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
> +		le32_encode_bits(rx_status->nss, IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O);
> +
> +	/* U-SIG */
> +	tlv = (void *)tlv + sizeof(*tlv) + ALIGN(eht_len, 4);
> +	tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
> +	tlv->len = cpu_to_le16(usig_len);
> +
> +	bw = rx_status->bw < ARRAY_SIZE(rx_status_bw_to_radiotap_eht_usig) ?
> +	     rx_status_bw_to_radiotap_eht_usig[rx_status->bw] : U8_MAX;
> +	if (bw == U8_MAX)
> +		return;

This is cosmetics but I feel that 'if' statement is more readable than
':' operator:

if (rx_status->bw >= ARRAY_SIZE(rx_status_bw_to_radiotap_eht_usig)
        return;
        
bw = rx_status_bw_to_radiotap_eht_usig[rx_status->bw];

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
