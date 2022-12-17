Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B8564F8F9
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 13:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLQMn1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 07:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQMnZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 07:43:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166C14D23
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 04:43:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o15so3509291wmr.4
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 04:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uC6J8Y5zcpkxG8FH54867HYko/hYc7OJziBCirqQMaI=;
        b=PQlYQOHzV7bfj8rLbSsA1euTuAksqnwRMHoKiVfabadxVkND7vWo6Ziw7bIx8O4DJh
         iiN7+8iWeZytCN3W76Hz3cXQOEPanxSGvZHMOP4fcWnUCbkNtqPBq2iuDGkvi6fF2q1x
         7IR3pywewvVf4fTQLacQH4DqazWRUQzBh0p12ZSAUXM/Q50KEgbXMJFBjyEPJnVY46Rj
         Grsm+0Mgm1zL3X5XFFpl9p0NgubIlDIXTQxUS9xBpTZIf3OgVsIjT2lUUQBK4sjJ0R7J
         0VaP0IRqukd93Nq6/Orjesw4u5IkF0S8slwIkhBTSEdxXIAj/4IAcvc4IBw4f5thuCNb
         9A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uC6J8Y5zcpkxG8FH54867HYko/hYc7OJziBCirqQMaI=;
        b=plVUUIGDH1+vhPcxrdLLl+2NevywqXofn+qllyg8rlzR3NHTIuym0MMI1qcJVON+J6
         WiiuBwftNpHwgsceKtd2R4v0Tngx2PtyyM8IqjavGG0emCdmCr/L76XPja/9qTNJXWxL
         jJcSGp5AYnA6SH08F8xzKvCipJwoj4dxxB0CNsu92huKTvLQTq7rs3hKUTiodQ70VPWg
         EvyzfhRcCyisCmYIxxw2vAM8QyqewZEjdwdsyQ3aKOVeMS5mOxKGkefzfYvRT3Hi/DPp
         koaAQ+TtHWOy2XVrdvQaGttNPoDoeaSH8uJjOSBGdnApHGEa2mJyW1ZjcmIE/TjR32AB
         XwvA==
X-Gm-Message-State: ANoB5pk7Q6ijMn38ommY2oH8GhaiHwWiO/+FegvmdmmwCG1gIfVmz3+l
        5RJHcNCrdZRHWzP7Aqs3OEQ=
X-Google-Smtp-Source: AA0mqf4e2+66oLTtK2bdkI3HHjhP6NwZhv8X+aTuV0wsi90ygC8HzfEnzpNluujmwpXt4myhxzmhAg==
X-Received: by 2002:a05:600c:3646:b0:3cf:6b1d:7bad with SMTP id y6-20020a05600c364600b003cf6b1d7badmr26762537wmq.33.1671281002046;
        Sat, 17 Dec 2022 04:43:22 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b003b4cba4ef71sm14751861wmq.41.2022.12.17.04.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 04:43:21 -0800 (PST)
Message-ID: <b400592c-b21d-c675-8506-7db49326808c@gmail.com>
Date:   Sat, 17 Dec 2022 14:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 5/5] wifi: rtl8xxxu: Add rate control code for
 RTL8188EU
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>
References: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
 <d2a2e00a-6a71-49da-356d-53bcd7c0d7e1@gmail.com>
 <e223dfb9c449ed5bb0d0ec38c3348bef9531dfe6.camel@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <e223dfb9c449ed5bb0d0ec38c3348bef9531dfe6.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15/12/2022 15:14, Ping-Ke Shih wrote:
> On Tue, 2022-12-13 at 19:33 +0200, Bitterblue Smith wrote:
>> Copied from the newer vendor driver, v5.2.2.4.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - Implement suggestions from Ping-Ke Shih:
>>    - Add missing break in two switch statements.
>>    - Remove unnecessary initialisation of idx in rtl8188e_set_tx_rpt_timing().
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  39 ++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         | 601 +++++++++++++++++-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 131 +++-
>>  3 files changed, 741 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index 29f5dbee16b0..be9479f969b7 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>>
> 
> [...]
> 
>> +
>> +static void rtl8188e_power_training_try_state(struct rtl8xxxu_ra_info *ra)
>> +{
>> +	ra->pt_try_state = 0;
>> +	switch (ra->pt_mode_ss) {
>> +	case 3:
>> +		if (ra->decision_rate >= DESC_RATE_MCS13)
>> +			ra->pt_try_state = 1;
>> +		break;
>> +	case 2:
>> +		if (ra->decision_rate >= DESC_RATE_MCS5)
>> +			ra->pt_try_state = 1;
>> +		break;
>> +	case 1:
>> +		if (ra->decision_rate >= DESC_RATE_48M)
>> +			ra->pt_try_state = 1;
>> +		break;
>> +	case 0:
>> +		if (ra->decision_rate >= DESC_RATE_11M)
>> +			ra->pt_try_state = 1;
>> +		break;
>> +	default:
>> +		ra->pt_try_state = 0;
> 
> It seems to be 0 already because of first statement of this function. 
> 
>> +		break;
>> +	}
>> +
>> +	if (ra->rssi_sta_ra < 48) {
>> +		ra->pt_stage = 0;
>> +	} else if (ra->pt_try_state == 1) {
>> +		if ((ra->pt_stop_count >= 10) ||
>> +		    (ra->pt_pre_rssi > ra->rssi_sta_ra + 5) ||
>> +		    (ra->pt_pre_rssi < ra->rssi_sta_ra - 5) ||
>> +		    (ra->decision_rate != ra->pt_pre_rate)) {
>> +			if (ra->pt_stage == 0)
>> +				ra->pt_stage = 1;
>> +			else if (ra->pt_stage == 1)
>> +				ra->pt_stage = 3;
>> +			else
>> +				ra->pt_stage = 5;
>> +
>> +			ra->pt_pre_rssi = ra->rssi_sta_ra;
>> +			ra->pt_stop_count = 0;
>> +		} else {
>> +			ra->ra_stage = 0;
>> +			ra->pt_stop_count++;
>> +		}
>> +	} else {
>> +		ra->pt_stage = 0;
>> +		ra->ra_stage = 0;
>> +	}
>> +
>> +	ra->pt_pre_rate = ra->decision_rate;
>> +
>> +	/* TODO: implement the "false alarm" statistics for this */
>> +	/* Disable power training when noisy environment */
>> +	/* if (p_dm_odm->is_disable_power_training) { */
>> +	if (1) {
>> +		ra->pt_stage = 0;
>> +		ra->ra_stage = 0;
>> +		ra->pt_stop_count = 0;
>> +	}
>> +}
>> +
>> +static void rtl8188e_power_training_decision(struct rtl8xxxu_ra_info *ra)
>> +{
>> +	u8 temp_stage;
>> +	u32 numsc;
>> +	u32 num_total;
>> +	u8 stage_id;
>> +	u8 j;
>> +
>> +	numsc = 0;
>> +	num_total = ra->total * pt_penalty[5];
>> +	for (j = 0; j <= 4; j++) {
>> +		numsc += ra->retry[j] * pt_penalty[j];
>> +
>> +		if (numsc > num_total)
>> +			break;
>> +	}
>> +
>> +	j = j >> 1;
> 
> j >>= 1;
> 
>> +	temp_stage = (ra->pt_stage + 1) >> 1;
>> +	if (temp_stage > j)
>> +		stage_id = temp_stage - j;
>> +	else
>> +		stage_id = 0;
>> +
>> +	ra->pt_smooth_factor = (ra->pt_smooth_factor >> 1) +
>> +			       (ra->pt_smooth_factor >> 2) +
>> +			       stage_id * 16 + 2;
>> +	if (ra->pt_smooth_factor > 192)
>> +		ra->pt_smooth_factor = 192;
>> +	stage_id = ra->pt_smooth_factor >> 6;
>> +	temp_stage = stage_id * 2;
>> +	if (temp_stage != 0)
>> +		temp_stage--;
>> +	if (ra->drop > 3)
>> +		temp_stage = 0;
>> +	ra->pt_stage = temp_stage;
>> +}
>> +
>> +void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>> +{
>> +	u32 *_rx_desc = (u32 *)(skb->data - sizeof(struct rtl8xxxu_rxdesc16));
>> +	struct rtl8xxxu_rxdesc16 *rx_desc = (struct rtl8xxxu_rxdesc16 *)_rx_desc;
>> +	struct device *dev = &priv->udev->dev;
>> +	struct rtl8xxxu_ra_info *ra = &priv->ra_info;
>> +
> 
> no blank line in declaration part.
> 
>> +	u32 tx_rpt_len = rx_desc->pktlen & 0x3ff;
>> +	u32 items = tx_rpt_len / TX_RPT2_ITEM_SIZE;
>> +	u64 macid_valid = ((u64)_rx_desc[5] << 32) | _rx_desc[4];
>> +	u32 macid;
>> +	u8 *rpt = skb->data;
>> +	bool valid;
>> +	u16 min_rpt_time = 0x927c;
>> +
>> +	dev_dbg(dev, "%s: len: %d items: %d\n", __func__, tx_rpt_len, items);
>> +
>> +	for (macid = 0; macid < items; macid++) {
>> +		valid = false;
>> +
>> +		if (macid < 64)
>> +			valid = macid_valid & BIT(macid);
>> +
>> +		if (valid) {
>> +			ra->retry[0] = le16_to_cpu(*(__le16 *)rpt);
>> +			ra->retry[1] = rpt[2];
>> +			ra->retry[2] = rpt[3];
>> +			ra->retry[3] = rpt[4];
>> +			ra->retry[4] = rpt[5];
>> +			ra->drop = rpt[6];
>> +			ra->total = ra->retry[0] + ra->retry[1] + ra->retry[2] +
>> +				    ra->retry[3] + ra->retry[4] + ra->drop;
>> +
>> +			if (ra->total > 0) {
>> +				if (ra->ra_stage < 5)
>> +					rtl8188e_rate_decision(ra);
>> +				else if (ra->ra_stage == 5)
>> +					rtl8188e_power_training_try_state(ra);
>> +				else /* ra->ra_stage == 6 */
>> +					rtl8188e_power_training_decision(ra);
>> +
>> +				if (ra->ra_stage <= 5)
>> +					ra->ra_stage++;
>> +				else
>> +					ra->ra_stage = 0;
>> +			}
>> +		} else if (macid == 0) {
>> +			dev_warn(dev, "%s: TX report item 0 not valid\n", __func__);
>> +		}
>> +
>> +		dev_dbg(dev, "%s:  valid: %d retry: %d %d %d %d %d drop: %d\n",
>> +			__func__, valid,
>> +			ra->retry[0], ra->retry[1], ra->retry[2],
>> +			ra->retry[3], ra->retry[4], ra->drop);
>> +
>> +		if (min_rpt_time > ra->rpt_time)
>> +			min_rpt_time = ra->rpt_time;
>> +
>> +		rpt += TX_RPT2_ITEM_SIZE;
>> +
>> +		/*
>> +		 * We only use macid 0, so only the first item is relevant.
>> +		 * AP mode will use more of them if it's ever implemented.
>> +		 */
>> +		break;
>> +	}
>> +
>> +	if (min_rpt_time != ra->pre_min_rpt_time) {
>> +		rtl8xxxu_write16(priv, REG_TX_REPORT_TIME, min_rpt_time);
>> +		ra->pre_min_rpt_time = min_rpt_time;
>> +	}
>> +}
>> +
> 
> [...]
> 
>> +
>>  int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>  {
>>  	struct ieee80211_hw *hw = priv->hw;
>> @@ -5823,38 +5884,46 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff
>> *skb)
>>  
>>  		skb_pull(skb, sizeof(struct rtl8xxxu_rxdesc16));
>>  
>> -		phy_stats = (struct rtl8723au_phy_stats *)skb->data;
>> +		if (rx_desc->rpt_sel) {
>> +			skb_queue_tail(&priv->c2hcmd_queue, skb);
>> +			schedule_work(&priv->c2hcmd_work);
>> +		} else {
>> +			phy_stats = (struct rtl8723au_phy_stats *)skb->data;
>>  
>> -		skb_pull(skb, drvinfo_sz + desc_shift);
>> +			skb_pull(skb, drvinfo_sz + desc_shift);
>>  
>> -		skb_trim(skb, pkt_len);
>> +			skb_trim(skb, pkt_len);
>>  
>> -		if (rx_desc->phy_stats)
>> -			rtl8xxxu_rx_parse_phystats(priv, rx_status, phy_stats,
>> -						   rx_desc->rxmcs, (struct ieee80211_hdr *)skb-
>>> data,
>> -						   rx_desc->crc32 || rx_desc->icverr);
>> +			if (rx_desc->phy_stats)
>> +				rtl8xxxu_rx_parse_phystats(
>> +					priv, rx_status, phy_stats,
>> +					rx_desc->rxmcs,
>> +					(struct ieee80211_hdr *)skb->data,
>> +					rx_desc->crc32 || rx_desc->icverr
>> +				);
> 
> squash this parenthesis to previous line.
> 
>>  
>> -		rx_status->mactime = rx_desc->tsfl;
>> -		rx_status->flag |= RX_FLAG_MACTIME_START;
>> +			rx_status->mactime = rx_desc->tsfl;
>> +			rx_status->flag |= RX_FLAG_MACTIME_START;
>>  
>> -		if (!rx_desc->swdec)
>> -			rx_status->flag |= RX_FLAG_DECRYPTED;
>> -		if (rx_desc->crc32)
>> -			rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>> -		if (rx_desc->bw)
>> -			rx_status->bw = RATE_INFO_BW_40;
>> +			if (!rx_desc->swdec)
>> +				rx_status->flag |= RX_FLAG_DECRYPTED;
>> +			if (rx_desc->crc32)
>> +				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>> +			if (rx_desc->bw)
>> +				rx_status->bw = RATE_INFO_BW_40;
>>  
>> -		if (rx_desc->rxht) {
>> -			rx_status->encoding = RX_ENC_HT;
>> -			rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
>> -		} else {
>> -			rx_status->rate_idx = rx_desc->rxmcs;
>> -		}
>> +			if (rx_desc->rxht) {
>> +				rx_status->encoding = RX_ENC_HT;
>> +				rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
>> +			} else {
>> +				rx_status->rate_idx = rx_desc->rxmcs;
>> +			}
>>  
>> -		rx_status->freq = hw->conf.chandef.chan->center_freq;
>> -		rx_status->band = hw->conf.chandef.chan->band;
>> +			rx_status->freq = hw->conf.chandef.chan->center_freq;
>> +			rx_status->band = hw->conf.chandef.chan->band;
>>  
>> -		ieee80211_rx_irqsafe(hw, skb);
>> +			ieee80211_rx_irqsafe(hw, skb);
>> +		}
>>  
>>  		skb = next_skb;
>>  		if (skb)
>>
> 
> [...]
> 
> Only some minor comments.
> 
> Thank you for the patches.
> --
> Ping-Ke
> 
I'll make the changes. Thank you for reviewing.
