Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22B0572902
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiGLWIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 18:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiGLWIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 18:08:35 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEA8B4B
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657663711; x=1689199711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZkUo+1qnDJvUvf8/GBUzwNs7Bbn+3ngGp5W1aFmbFY0=;
  b=Tgx7Oy+5fpZ1VKFKqhSp1dwuKV6SkhlEQKGR6bLE44CRFyUW8PQ696+I
   yCov2rf3uMGdYsPkHRUBiepAB4Dj1hAkq/Izy2cj50NfWbL3+lM6yqgMe
   PpKw2TCZi2RCVA5WZa0TvNLpkuk97REIa56JONQd5i+1FB+DNveQMedh0
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Jul 2022 15:08:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 15:08:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 15:08:29 -0700
Received: from [10.110.97.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Jul
 2022 15:08:29 -0700
Message-ID: <2b75f624-da68-6cb0-89c1-cca788896969@quicinc.com>
Date:   Tue, 12 Jul 2022 15:08:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/12] nl80211: support setting S1G short beacon period
Content-Language: en-US
To:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Bassem Dawood <bassem@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
 <20220711010816.45927-5-kieran.frewen@morsemicro.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220711010816.45927-5-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/10/2022 6:08 PM, Kieran Frewen wrote:
> With the kernel able to send both short and long S1G beacons, include
> the ability for setting the short beacon period.
> 
> Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
> Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
> ---
>   include/uapi/linux/nl80211.h | 6 ++++++
>   net/wireless/nl80211.c       | 4 ++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 89f64f46b98d..bd6e2cae1dd3 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2694,6 +2694,8 @@ enum nl80211_commands {
>    *	connection. Used with %NL80211_CMD_CONNECT. If this attribute is not
>    *	included in NL80211_CMD_CONNECT drivers must not perform MLO connection.
>    *
> + * @NL80211_ATTR_SHORT_BEACON_PERIOD: S1G short beacon period in TUs.
> + *
>    * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>    * @NL80211_ATTR_MAX: highest attribute number currently defined
>    * @__NL80211_ATTR_AFTER_LAST: internal use
> @@ -3214,6 +3216,8 @@ enum nl80211_attrs {
>   
>   	NL80211_ATTR_MLO_SUPPORT,
>   
> +	NL80211_ATTR_SHORT_BEACON_PERIOD,
> +
>   	/* add attributes here, update the policy in nl80211.c */
>   
>   	__NL80211_ATTR_AFTER_LAST,
> @@ -4890,6 +4894,7 @@ enum nl80211_bss_scan_width {
>    *	Contains a nested array of signal strength attributes (u8, dBm),
>    *	using the nesting index as the antenna number.
>    * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
> + * @NL80211_BSS_SHORT_BEACON_PERIOD: S1G short beacon period in TUs
>    * @__NL80211_BSS_AFTER_LAST: internal
>    * @NL80211_BSS_MAX: highest BSS attribute
>    */
> @@ -4915,6 +4920,7 @@ enum nl80211_bss {
>   	NL80211_BSS_PARENT_BSSID,
>   	NL80211_BSS_CHAIN_SIGNAL,
>   	NL80211_BSS_FREQUENCY_OFFSET,
> +	NL80211_BSS_SHORT_BEACON_PERIOD,

please rebase against latest wireless-next since a new attribute 
NL80211_BSS_MLO_LINK_ID was very recently added

>   
>   	/* keep last */
>   	__NL80211_BSS_AFTER_LAST,
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 6a45801c783c..ab47e4130141 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -798,6 +798,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>   		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS),
>   	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
>   	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
> +	[NL80211_ATTR_SHORT_BEACON_PERIOD] = { .type = NLA_U32 },

entire range of u32 values are valid?

IEEE Std 802.11-2020 Figure 9-684—Short Beacon Interval element format 
indicates a 2 octet field, so consider either changing the type to U16 
or use NLA_POLICY_RANGE() to align with the MIB definition:
dot11ShortBeaconPeriod OBJECT-TYPE
SYNTAX Unsigned32 (1..65535)


>   };
>   
>   /* policy for the key attributes */
> @@ -5654,6 +5655,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
>   		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
>   	params->dtim_period =
>   		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
> +	if (info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD])
> +		params->short_beacon_period =
> +			nla_get_u32(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]);
>   
>   	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
>   					   params->beacon_interval);

