Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4856CA549
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjC0NLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjC0NLu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 09:11:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE435B3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:11:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e18so8735621wra.9
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679922704;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DEMLPOO9Dg7g+Bzi1Lpjria5ofUxYGDTz1KcXKTGHeI=;
        b=eX+t7TcNbWVPQuiPZ00V107CvMILaiTiJlFMeLH55widPE32Z0Ih7u19r5xDMy9sxr
         t3MvQCVRVIvRno+CUdPK6V9HcGZJoSdxRXD3OGfvKYdFG7jW4m/+84hLv1/5J7c1gB2S
         gCyd9PZwWED8BPn3OSb/kSPETEc+I5aEZ66UHm9wnjqUt7gu3VInGiKHcRUiDfD/eHYe
         AJO4OrUKd2ll5ZWpVHcTt1nSE/xYraIKrJHIDT6WL4K3qsrxmDuEx0AxZcCbcibFXquy
         0bvsf5L7ATAZOohKg+KDlcfNTp+LuCriD1jtdZqVfnGWjPkymJiDAfHxdkVcnTWVYIdz
         jx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922704;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEMLPOO9Dg7g+Bzi1Lpjria5ofUxYGDTz1KcXKTGHeI=;
        b=vdkjUSNUEK8KE41fsu3QZCtd9xVjL04zFY0VQgS0/fduwLzF5e02mBlLHTRPfIxBL6
         u3rnLY65XI38Tz9rel0EQcnPBgus1Awm18eiX8hNksinkKKzJE0iHqv9LSNpN/stKwGc
         RhEzI4uteydrUd3myiB2dAh6ajrWYkUn6I9GjuvHEGdMneggUFsCJZvZvOa5dDziCZ3Q
         bE62auxaYCVI2udkEZNXgUaaGy5NnQwp1Qyddcs/YUHnVOO5UQVKPM6PsyZuzuVGeQtz
         bFmQoR8lZSWvg8a/D4uaWjhvhM9Dgkzr1depRcMU28uHWurGPZLB0/BSREu6tSr3CR2F
         7ICg==
X-Gm-Message-State: AAQBX9eGB8EoYjMS5GFFBOPHIJJq7o4AOhm5l8TCtMoPDmnU2xNFfR1h
        gLFvLbwXggqfRx/GaAI3BpOVcT0jUfU=
X-Google-Smtp-Source: AKy350aBY3zDSybk2JlfXcqkyISBz0TGmgrnDpoh2ExCy6e8+lk2bHaM9o1oX5xmhcy2RpxJPOxWNQ==
X-Received: by 2002:a05:6000:1a47:b0:2d8:4f02:66b6 with SMTP id t7-20020a0560001a4700b002d84f0266b6mr9985915wry.9.1679922703854;
        Mon, 27 Mar 2023 06:11:43 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d4e8d000000b002ceacff44c7sm25198399wru.83.2023.03.27.06.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:11:43 -0700 (PDT)
Message-ID: <7b0c0ecf-a14f-54eb-5a1b-e1a61c643807@gmail.com>
Date:   Mon, 27 Mar 2023 16:11:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [RFC PATCH 11/14] wifi: rtl8xxxu: Put the macid in txdesc
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-12-martin.kaistra@linutronix.de>
Content-Language: en-US
In-Reply-To: <20230322171905.492855-12-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/03/2023 19:19, Martin Kaistra wrote:
> Add a parameter macid to fill_txdesc(), implement setting it for the
> gen2 version.
> This is used to tell the HW who the recipient of the packet is, so that
> the appropriate data rate can be selected.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h |  8 ++++----
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 16 ++++++++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index e78e0bbd23354..20304b0bd68a3 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1917,7 +1917,7 @@ struct rtl8xxxu_fileops {
>  			     struct ieee80211_tx_info *tx_info,
>  			     struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
>  			     bool short_preamble, bool ampdu_enable,
> -			     u32 rts_rate);
> +			     u32 rts_rate, u8 macid);
>  	void (*set_crystal_cap) (struct rtl8xxxu_priv *priv, u8 crystal_cap);
>  	s8 (*cck_rssi) (struct rtl8xxxu_priv *priv, struct rtl8723au_phy_stats *phy_stats);
>  	int (*led_classdev_brightness_set) (struct led_classdev *led_cdev,
> @@ -2046,17 +2046,17 @@ void rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  			     struct ieee80211_tx_info *tx_info,
>  			     struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
>  			     bool short_preamble, bool ampdu_enable,
> -			     u32 rts_rate);
> +			     u32 rts_rate, u8 macid);
>  void rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  			     struct ieee80211_tx_info *tx_info,
>  			     struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
>  			     bool short_preamble, bool ampdu_enable,
> -			     u32 rts_rate);
> +			     u32 rts_rate, u8 macid);
>  void rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  			     struct ieee80211_tx_info *tx_info,
>  			     struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
>  			     bool short_preamble, bool ampdu_enable,
> -			     u32 rts_rate);
> +			     u32 rts_rate, u8 macid);
>  void rtl8723bu_set_ps_tdma(struct rtl8xxxu_priv *priv,
>  			   u8 arg1, u8 arg2, u8 arg3, u8 arg4, u8 arg5);
>  void rtl8723bu_phy_init_antenna_selection(struct rtl8xxxu_priv *priv);
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index d74a3c6452507..c232de1d47173 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5152,7 +5152,8 @@ void
>  rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  			struct ieee80211_tx_info *tx_info,
>  			struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
> -			bool short_preamble, bool ampdu_enable, u32 rts_rate)
> +			bool short_preamble, bool ampdu_enable, u32 rts_rate,
> +			u8 macid)
>  {
>  	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
>  	struct rtl8xxxu_priv *priv = hw->priv;
> @@ -5224,7 +5225,8 @@ void
>  rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  			struct ieee80211_tx_info *tx_info,
>  			struct rtl8xxxu_txdesc32 *tx_desc32, bool sgi,
> -			bool short_preamble, bool ampdu_enable, u32 rts_rate)
> +			bool short_preamble, bool ampdu_enable, u32 rts_rate,
> +			u8 macid)
>  {
>  	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
>  	struct rtl8xxxu_priv *priv = hw->priv;
> @@ -5248,6 +5250,8 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  		dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
>  			 __func__, rate, le16_to_cpu(tx_desc40->pkt_size));
>  
> +	tx_desc40->txdw1 |= cpu_to_le32(macid << TXDESC40_MACID_SHIFT);
> +
>  	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
>  
>  	tx_desc40->txdw4 = cpu_to_le32(rate);
> @@ -5299,7 +5303,8 @@ void
>  rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  			struct ieee80211_tx_info *tx_info,
>  			struct rtl8xxxu_txdesc32 *tx_desc, bool sgi,
> -			bool short_preamble, bool ampdu_enable, u32 rts_rate)
> +			bool short_preamble, bool ampdu_enable, u32 rts_rate,
> +			u8 macid)
>  {
>  	struct ieee80211_rate *tx_rate = ieee80211_get_tx_rate(hw, tx_info);
>  	struct rtl8xxxu_priv *priv = hw->priv;
> @@ -5398,6 +5403,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  	u16 pktlen = skb->len;
>  	u16 rate_flag = tx_info->control.rates[0].flags;
>  	int tx_desc_size = priv->fops->tx_desc_size;
> +	u8 macid = 0;
>  	int ret;
>  	bool ampdu_enable, sgi = false, short_preamble = false;
>  
> @@ -5497,9 +5503,11 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>  	else
>  		rts_rate = 0;
>  
> +	if (vif->type == NL80211_IFTYPE_AP && sta)
> +		macid = sta->aid + 1;
>  
You should have a function which calculates the macid instead of copying
the calculation everywhere.

>  	priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
> -				ampdu_enable, rts_rate);
> +				ampdu_enable, rts_rate, macid);
>  
>  	rtl8xxxu_calc_tx_desc_csum(tx_desc);
>  

