Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7675B249306
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 04:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHSCs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 22:48:59 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13577 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbgHSCs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 22:48:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597805337; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4qUM4fIFkj+7qr22VY5heTg/D0ykP7DPQCdILg7c23g=;
 b=CEnedwgKOCzXCikFLzkhJKFi7H6cpmNP2S1rmcQXMrMFu9wE7irMTpIS+GGmqqu8zyk4XK7d
 y2OZDZzbDbkNAokvGgUzhB5W6VCkTqIqj0DlpRPR3j7aeozL9x/iIc2RuVE4BOgRvxSsHwm5
 rBIb+zW+eUKaWGm9hxhFXjdwBjM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f3c930ef2b697637a65b48f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 02:48:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7A22C43391; Wed, 19 Aug 2020 02:48:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F1DCC433CA;
        Wed, 19 Aug 2020 02:48:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 19:48:44 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 1/9] nl80211: add basic multiple bssid support
In-Reply-To: <20200812150050.2683396-2-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
 <20200812150050.2683396-2-john@phrozen.org>
Message-ID: <38950cb7375b29f14e7605c76f500cd7@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-12 08:00, John Crispin wrote:
> This patch adds support for passing the multiple bssid config to the
> kernel when adding an interface. If the BSS is non-transmitting it 
> needs
> to be indicated. A non-transmitting BSSID will have a parent interface,
> which needs to be transmitting. The multiple bssid elements are passed
> as an array.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  include/net/cfg80211.h       | 35 +++++++++++++++++++++++++++++++
>  include/uapi/linux/nl80211.h | 22 ++++++++++++++++++++
>  net/wireless/nl80211.c       | 40 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 541dea0fd571..0b0c730dc8d2 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -470,6 +470,21 @@ struct ieee80211_supported_band {
>  	const struct ieee80211_sband_iftype_data *iftype_data;
>  };
> 
> +/**
> + * struct ieee80211_multiple_bssid - AP settings for multi bssid
> + *
> + * @index: the index of this AP in the multi bssid group.
> + * @count: the total number of multi bssid peer APs.
> + * @parent: a non-transmitted bssid has a transmitted parent
> + * @non_transmitted: Is this a non-transmitted bssid
> + */
> +struct ieee80211_multiple_bssid {
> +	u8 index;
> +	u8 count;
> +	u32 parent;
> +	bool non_transmitted;
> +};
> +
>  /**
>   * ieee80211_get_sband_iftype_data - return sband data for a given 
> iftype
>   * @sband: the sband to search for the STA on
> @@ -614,6 +629,7 @@ static inline void
> wiphy_read_of_freq_limits(struct wiphy *wiphy)
>   *	belonging to that MU-MIMO groupID; %NULL if not changed
>   * @vht_mumimo_follow_addr: MU-MIMO follow address, used for 
> monitoring
>   *	MU-MIMO packets going to the specified station; %NULL if not 
> changed
> + * @multiple_bssid: AP settings for multiple bssid
>   */
>  struct vif_params {
>  	u32 flags;
> @@ -621,6 +637,7 @@ struct vif_params {
>  	u8 macaddr[ETH_ALEN];
>  	const u8 *vht_mumimo_groups;
>  	const u8 *vht_mumimo_follow_addr;
> +	struct ieee80211_multiple_bssid	multiple_bssid;
>  };
> 
>  /**
> @@ -998,6 +1015,19 @@ struct cfg80211_crypto_settings {
>  	u8 sae_pwd_len;
>  };
> 
> +/**
> + * struct cfg80211_multiple_bssid_data - multiple_bssid data
> + * @ies: array of extra information element(s) to add into Beacon
> frames for multiple
> + *	bssid or %NULL
> + * @len: array of lengths of multiple_bssid.ies in octets
> + * @cnt: number of entries in multiple_bssid.ies
> + */
> +struct cfg80211_multiple_bssid_data {
> +	u8 *ies[NL80211_MULTIPLE_BSSID_IES_MAX];
> +	size_t len[NL80211_MULTIPLE_BSSID_IES_MAX];
> +	int cnt;
> +};
> +
>  /**
>   * struct cfg80211_beacon_data - beacon data
>   * @head: head portion of beacon (before TIM IE)
> @@ -1024,6 +1054,7 @@ struct cfg80211_crypto_settings {
>   *	Token (measurement type 11)
>   * @lci_len: LCI data length
>   * @civicloc_len: Civic location data length
> + * @multiple_bssid: multiple_bssid data
>   */
>  struct cfg80211_beacon_data {
>  	const u8 *head, *tail;
> @@ -1042,6 +1073,8 @@ struct cfg80211_beacon_data {
>  	size_t probe_resp_len;
>  	size_t lci_len;
>  	size_t civicloc_len;
> +
> +	struct cfg80211_multiple_bssid_data multiple_bssid;
>  };
> 
>  struct mac_address {
> @@ -1111,6 +1144,7 @@ enum cfg80211_ap_settings_flags {
>   * @he_obss_pd: OBSS Packet Detection settings
>   * @he_bss_color: BSS Color settings
>   * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
> + * @multiple_bssid: AP settings for multiple bssid
>   */
>  struct cfg80211_ap_settings {
>  	struct cfg80211_chan_def chandef;
> @@ -1141,6 +1175,7 @@ struct cfg80211_ap_settings {
>  	u32 flags;
>  	struct ieee80211_he_obss_pd he_obss_pd;
>  	struct cfg80211_he_bss_color he_bss_color;
> +	struct ieee80211_multiple_bssid multiple_bssid;
>  };
> 
>  /**
> diff --git a/include/uapi/linux/nl80211.h 
> b/include/uapi/linux/nl80211.h
> index cade02a0e60e..5bc38d53c78c 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2551,6 +2551,20 @@ enum nl80211_commands {
>   * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_C_OFF_PRESP: An array of
> offsets (u16) to the color
>   *	switch counters in the probe response (%NL80211_ATTR_PROBE_RESP).
>   *
> + * @NL80211_ATTR_MULTIPLE_BSSID_NON_TRANSMITTING: Set the
> Non-Transmitted flag for this
> + *	BSSIDs beacon.
> + *
> + * @NL80211_ATTR_MULTIPLE_BSSID_PARENT: If this is a Non-Transmitted
> BSSID, define
> + *	the parent (transmitting) interface.
> + *
> + * @NL80211_ATTR_MULTIPLE_BSSID_INDEX: The index of this BSS inside
> the multi bssid
> + *	element.
> + *
> + * @NL80211_ATTR_MULTIPLE_BSSID_COUNT: The number of BSSs inside the
> multi bssid element.
> + *
> + * @NL80211_ATTR_MULTIPLE_BSSID_IES: The Elements that describe our
> multiple BSS group.
> + *	these get passed separately as the kernel might need to split them
> up for EMA VAP.
> + *
>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>   * @NL80211_ATTR_MAX: highest attribute number currently defined
>   * @__NL80211_ATTR_AFTER_LAST: internal use
> @@ -3039,6 +3053,12 @@ enum nl80211_attrs {
>  	NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR,
>  	NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES,
> 
> +	NL80211_ATTR_MULTIPLE_BSSID_NON_TRANSMITTING,
> +	NL80211_ATTR_MULTIPLE_BSSID_PARENT,
> +	NL80211_ATTR_MULTIPLE_BSSID_INDEX,
> +	NL80211_ATTR_MULTIPLE_BSSID_COUNT,
> +	NL80211_ATTR_MULTIPLE_BSSID_IES,
> +
>  	/* add attributes here, update the policy in nl80211.c */
> 
>  	__NL80211_ATTR_AFTER_LAST,
> @@ -3102,6 +3122,8 @@ enum nl80211_attrs {
> 
>  #define NL80211_CQM_TXE_MAX_INTVL		1800
> 
> +#define NL80211_MULTIPLE_BSSID_IES_MAX		8
> +
>  /**
>   * enum nl80211_iftype - (virtual) interface types
>   *
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 2f0bae3c6572..4ba7203ad0d2 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -662,6 +662,11 @@ static const struct nla_policy
> nl80211_policy[NUM_NL80211_ATTR] = {
>  	[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT] = { .type = NLA_U8 },
>  	[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR] = { .type = NLA_U8 },
>  	[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES] =
> NLA_POLICY_NESTED(nl80211_policy),
> +	[NL80211_ATTR_MULTIPLE_BSSID_NON_TRANSMITTING] = { .type = NLA_FLAG 
> },
> +	[NL80211_ATTR_MULTIPLE_BSSID_PARENT] = { .type = NLA_U32 },
> +	[NL80211_ATTR_MULTIPLE_BSSID_INDEX] = { .type = NLA_U8 },
> +	[NL80211_ATTR_MULTIPLE_BSSID_COUNT] = { .type = NLA_U8 },
> +	[NL80211_ATTR_MULTIPLE_BSSID_IES] = { .type = NLA_NESTED },
>  };
> 
>  /* policy for the key attributes */
> @@ -3758,6 +3763,14 @@ static int nl80211_new_interface(struct sk_buff
> *skb, struct genl_info *info)
>  			return err;
>  	}
> 
> +	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_NON_TRANSMITTING])
> +		params.multiple_bssid.non_transmitted =
> +			nla_get_flag(info->attrs[NL80211_ATTR_MULTIPLE_BSSID_NON_TRANSMITTING]);
> +
> +	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_PARENT])
> +		params.multiple_bssid.parent =
> +			nla_get_u8(info->attrs[NL80211_ATTR_MULTIPLE_BSSID_PARENT]);
This should be nla_get_u32() as per the policy

> +
>  	if (!cfg80211_iftype_allowed(&rdev->wiphy, type, params.use_4addr, 
> 0))
>  		return -EOPNOTSUPP;
> 
> @@ -4670,6 +4683,21 @@ static int nl80211_parse_beacon(struct
> cfg80211_registered_device *rdev,
>  		bcn->ftm_responder = -1;
>  	}
> 
> +	if (attrs[NL80211_ATTR_MULTIPLE_BSSID_IES]) {
> +		struct nlattr *nl_ie;
> +		int rem_ie;
> +
> +		nla_for_each_nested(nl_ie, attrs[NL80211_ATTR_MULTIPLE_BSSID_IES], 
> rem_ie) {
> +			if (bcn->multiple_bssid.cnt > NL80211_MULTIPLE_BSSID_IES_MAX)
> +				return -EINVAL;
> +			if (nla_type(nl_ie) != bcn->multiple_bssid.cnt + 1)
> +				return -EINVAL;
> +			bcn->multiple_bssid.ies[bcn->multiple_bssid.cnt] = nla_data(nl_ie);
> +			bcn->multiple_bssid.len[bcn->multiple_bssid.cnt] = nla_len(nl_ie);
> +			bcn->multiple_bssid.cnt++;
> +		}
> +	}
> +
>  	return 0;
>  }
> 
> @@ -5032,6 +5060,18 @@ static int nl80211_start_ap(struct sk_buff
> *skb, struct genl_info *info)
>  			goto out;
>  	}
> 
> +	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_INDEX])
> +		params.multiple_bssid.index = nla_get_u8(
> +				info->attrs[NL80211_ATTR_MULTIPLE_BSSID_INDEX]);
> +
> +	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_COUNT])
> +		params.multiple_bssid.count = nla_get_u8(
> +				info->attrs[NL80211_ATTR_MULTIPLE_BSSID_COUNT]);
> +
> +	if (params.multiple_bssid.non_transmitted &&
> +	    !info->attrs[NL80211_ATTR_MULTIPLE_BSSID_PARENT])
> +		return -EOPNOTSUPP;
> +
>  	nl80211_calculate_ap_params(&params);
> 
>  	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
