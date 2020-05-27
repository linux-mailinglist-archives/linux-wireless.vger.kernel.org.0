Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0A91E4C26
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgE0RkK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 13:40:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37548 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387564AbgE0RkK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 13:40:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590601208; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Oh7ANtUIWThyAUINewPNEEgb4BBMXxQ/28NmDP3QMpk=;
 b=qNwoyBruYGpX2uNq9UyKy7ltg5etoJzRdhMqwc+Ejq1wTG+lN8eJwNLdeMBuUbeNUqSu35hQ
 RWYU1kXxjWYJJxY1FR06ulECqC7nUxQtWYWTKjg25ak3S+zFHUI89A7rGZOxuWmfibi6xeYJ
 Ulzlopl2LF0utEyJsp1XvbQXPxU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ecea5ed2dd9e15ae383e4df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 17:39:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77304C433CB; Wed, 27 May 2020 17:39:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2339C433C9;
        Wed, 27 May 2020 17:39:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 27 May 2020 10:39:55 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v3 03/11] nl80211: add HE 6 GHz Band Capability support
In-Reply-To: <4e3a5ab6eed1dc91f45a459bb616fa05a110483d.camel@sipsolutions.net>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
 <1589399105-25472-3-git-send-email-rmanohar@codeaurora.org>
 <4e3a5ab6eed1dc91f45a459bb616fa05a110483d.camel@sipsolutions.net>
Message-ID: <e9ab93034612fd476ac17fd25052cd06@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-27 07:27, Johannes Berg wrote:
> On Wed, 2020-05-13 at 12:44 -0700, Rajkumar Manoharan wrote:
>> 
>>  /**
>> + * enum ieee80211_he_6ghz_chanwidth - HE 6 GHz channel width
>> + * @IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ: 20 MHz bandwidth
>> + * @IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ: 40 MHz bandwidth
>> + * @IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ: 80 MHz bandwidth
>> + * @IEEE80211_HE_6GHZ_CHANWIDTH_80P80MHZ: 160 or 80+80 MHz bandwidth
>> + */
>> +enum ieee80211_he_6ghz_chanwidth {
>> +	IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ		= 0,
>> +	IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ		= 1,
>> +	IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ		= 2,
>> +	IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ	= 3,
>> +};
>> +
>> +/**
>> + * struct ieee80211_he_oper_6ghz_op_info - 6 GHz Operation 
>> Information
>> + *
>> + * This structure is defined as described in IEEE P802.11ax/D6.0,
>> + * Figure 9-787k—6 GHz Operation Information field.
>> + *
>> + * @primary_chan: The channel number of the primary channel in the 6 
>> GHz band.
>> + * @control: First two bits defines channel width field indicates the 
>> BSS
>> + *	channel width and is set to 0 for 20 MHz, 1 for 40 MHz, 2 for 80 
>> MHz,
>> + *	and 3 for 80+80 or 160 MHz.
>> + * @center_freq_seg0_idx: Channel center frequency index for the 20 
>> MHz,
>> + *	40 MHz, or 80 MHz, or 80+80 MHz.
>> + * @center_freq_seg1_idx: Channel center frequency index of the 160 
>> MHz.
>> + * @min_rate: Minimum rate, in units of 1 Mb/s, that the non-AP STA 
>> is allowed
>> + *	to use for sending PPDUs.
>> + */
>> +struct ieee80211_he_oper_6ghz_op_info {
>> +	u8 primary_chan;
>> +	u8 control;
>> +	u8 center_freq_seg0_idx;
>> +	u8 center_freq_seg1_idx;
>> +	u8 min_rate;
>> +} __packed;
>> 
> 
> Looks like I had
> 
> +/**
> + * ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
> + * @primary: primary channel
> + * @control: control flags
> + * @ccfs0: channel center frequency segment 0
> + * @ccfs1: channel center frequency segment 1
> + * @minrate: minimum rate (in 1 Mbps units)
> + */
> +struct ieee80211_he_6ghz_oper {
> +       u8 primary;
> +#define IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH  0x3
> +#define                IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ     
> 0
> +#define                IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ     
> 1
> +#define                IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ     
> 2
> +#define                IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ    
> 3
> +#define IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON 0x4
> +       u8 control;
> +       u8 ccfs0;
> +       u8 ccfs1;
> +       u8 minrate;
> +} __packed;
> 
> 
> Any objection to that? The names are getting _really_ long the way you
> had them ...
> 
Neat.. LGTM.. :)

> FWIW, I also had a fix in ieee80211_he_oper_size() where the size of 
> the
> oper is now sizeof(struct ieee80211_he_6ghz_oper).
> 
> And this, to find it:
> 
> +/**
> + * ieee80211_he_6ghz_oper - obtain 6 GHz operation field
> + * @he_oper: HE operation element (must be pre-validated for size)
> + *     but may be %NULL
> + *
> + * Return: a pointer to the 6 GHz operation field, or %NULL
> + */
> +static inline const struct ieee80211_he_6ghz_oper *
> +ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
> +{
> +       const u8 *ret = (void *)&he_oper->optional;
> +       u32 he_oper_params;
> +
> +       if (!he_oper)
> +               return NULL;
> +
> +       he_oper_params = le32_to_cpu(he_oper->he_oper_params);
> +
> +       if (!(he_oper_params & IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
> +               return NULL;
> +       if (he_oper_params & IEEE80211_HE_OPERATION_VHT_OPER_INFO)
> +               ret += 3;
> +       if (he_oper_params & IEEE80211_HE_OPERATION_CO_HOSTED_BSS)
> +               ret++;
> +
> +       return (void *)ret;
> +}
> +
> 
Great.

> 
>>  #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
>>  #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991			0x00000001
>> @@ -1982,6 +2029,15 @@ int ieee80211_get_vht_max_nss(struct 
>> ieee80211_vht_cap *cap,
>>  #define IEEE80211_TX_RX_MCS_NSS_SUPP_TX_BITMAP_MASK			0x07c0
>>  #define IEEE80211_TX_RX_MCS_NSS_SUPP_RX_BITMAP_MASK			0xf800
>> 
>> +/* 802.11ax HE 6 GHz Band Capability */
>> +#define IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START_SPACE_MASK		GENMASK(2, 
>> 0)
>> +#define 
>> IEEE80211_HE_6GHZ_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK	GENMASK(5, 3)
>> +#define IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LENGTH_MASK		GENMASK(7, 6)
>> +#define IEEE80211_HE_6GHZ_CAP_SMPS_MASK				GENMASK(10, 9)
>> +#define IEEE80211_HE_6GHZ_CAP_RD_RESP				BIT(11)
>> +#define IEEE80211_HE_6GHZ_CAP_RX_ANTENNA_PATTERN		BIT(12)
>> +#define IEEE80211_HE_6GHZ_CAP_TX_ANTENNA_PATTERN		BIT(13)
> 
> I don't like GENMASK() much ... but ok. FWIW, I had
> 
Hope GENMASK defined in backports for older kernel. I started using this 
since ath11k.
I feel GENMASK is more user readable and avoid masking errors.

> +struct ieee80211_he_6ghz_capa {
> +       /* uses IEEE80211_HE_6GHZ_CAP_* below */
> +       __le16 capa;
> +} __packed;
> +
> +/* HE 6 GHz band capabilities */
> +/* uses enum ieee80211_min_mpdu_spacing values */
> +#define IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START   0x0007
> +/* uses enum ieee80211_vht_max_ampdu_length_exp values */
> +#define IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP        0x0038
> +/* uses IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_* values */
> +#define IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN     0x00c0
> +/* WLAN_HT_CAP_SM_PS_* values */
> +#define IEEE80211_HE_6GHZ_CAP_SM_PS_SHIFT       9
> +#define IEEE80211_HE_6GHZ_CAP_SM_PS            0x0600
> +#define IEEE80211_HE_6GHZ_CAP_RD_RESPONDER     0x0800
> +#define IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS   0x1000
> +#define IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS   0x2000
> 
> 
> again, just shorter names ...
> 
I am fine with this.. Leave it to you. Cheers.

-Rajkumar
