Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77C41AFB3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhI1NOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 09:14:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58077 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbhI1NOM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 09:14:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632834753; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BAEee7+6lurq0N+VxF29a3jduQZptR8OlXs/j7Zrxm4=;
 b=VGCpOW5MLS8pzWNmQMYBjWMQWJJEeNVTKDqd5h2isQqkskpnivG3hrlnEDw85nvzV8u3/OXQ
 fzYtxVE8Hc4XnTlI1NSPfe57Vfaz9NGHy+PigATGltyNLnUCxx6ZAL+Uyxfy9QxpWwfcz0uH
 yJwm/fu91NLBFtRIfS3DGPyjec8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 615314c0519bd8dcf0d3dc3f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 13:12:32
 GMT
Sender: vnaralas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89276C4360D; Tue, 28 Sep 2021 13:12:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C1F1C4338F;
        Tue, 28 Sep 2021 13:12:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Sep 2021 18:42:31 +0530
From:   vnaralas@codeaurora.org
To:     Wen Gong <wgong@codeaurora.org>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, wgong=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <20210928085211.26186-1-wgong@codeaurora.org>
References: <20210928085211.26186-1-wgong@codeaurora.org>
Message-ID: <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
X-Sender: vnaralas@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-28 14:22, Wen Gong wrote:
> 6 GHz regulatory domains introduces power spectral density(psd).
> The power spectral density(psd) of regulatory rule should be take
> effect to the channels. Save the values to the channel which has
> psd value and add nl80211 attributes for it.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
> v5: change by comments of johannes.
>     1. add handler for nl80211 attributes
>     2. add indentation for NL80211_RRF_PSD
>     3. squashed with "cfg80211: add definition for 6 GHz power
> spectral density(psd)"
>     4. remove all other patches
> 
> v4:
>     1. rebased to top commit id 9e263e193af7 
> kernel/git/jberg/mac80211-next.git
>     2. add NULL check for "mac80211: use ieee802_11_parse_elems() to
> find ies instead of ieee80211_bss_get_ie()"
>     3. remove the 3 patches which already upstream:
>        "mac80211: parse transmit power envelope element"
>        "ieee80211: add definition for transmit power envelope element"
>        "ieee80211: add definition of regulatory info in 6 GHz
> operation information"
> 
> v3: change per comments of Johannes.
>     1. add patch "mac80211: use ieee802_11_parse_elems() to find ies
> instead of ieee80211_bss_get_ie()"
>     2. move nl80211_ap_reg_power to ieee80211
>     3. change some comments, length check, stack big size variable...
> 
> v2: change per comments of johannes.
>     including code style, code logic, patch merge, commit log...
> 
>  include/net/cfg80211.h       |  5 +++++
>  include/net/regulatory.h     |  1 +
>  include/uapi/linux/nl80211.h |  9 +++++++++
>  net/wireless/nl80211.c       | 18 ++++++++++++++++++
>  net/wireless/reg.c           | 17 +++++++++++++++++
>  5 files changed, 50 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 62dd8422e0dc..f8e0cc19e0ce 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -109,6 +109,8 @@ struct wiphy;
>   *	on this channel.
>   * @IEEE80211_CHAN_16MHZ: 16 MHz bandwidth is permitted
>   *	on this channel.
> + * @IEEE80211_CHAN_PSD: power spectral density (in dBm)
> + *	on this channel.
>   *
>   */
>  enum ieee80211_channel_flags {
> @@ -131,6 +133,7 @@ enum ieee80211_channel_flags {
>  	IEEE80211_CHAN_4MHZ		= 1<<16,
>  	IEEE80211_CHAN_8MHZ		= 1<<17,
>  	IEEE80211_CHAN_16MHZ		= 1<<18,
> +	IEEE80211_CHAN_PSD		= 1<<19,
>  };
> 
>  #define IEEE80211_CHAN_NO_HT40 \
> @@ -164,6 +167,7 @@ enum ieee80211_channel_flags {
>   *	on this channel.
>   * @dfs_state_entered: timestamp (jiffies) when the dfs state was 
> entered.
>   * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS 
> channels.
> + * @psd: power spectral density (in dBm)
>   */
>  struct ieee80211_channel {
>  	enum nl80211_band band;
> @@ -180,6 +184,7 @@ struct ieee80211_channel {
>  	enum nl80211_dfs_state dfs_state;
>  	unsigned long dfs_state_entered;
>  	unsigned int dfs_cac_ms;
> +	s8 psd;
>  };
> 
>  /**
> diff --git a/include/net/regulatory.h b/include/net/regulatory.h
> index 47f06f6f5a67..ed20004fb6a9 100644
> --- a/include/net/regulatory.h
> +++ b/include/net/regulatory.h
> @@ -221,6 +221,7 @@ struct ieee80211_reg_rule {
>  	u32 flags;
>  	u32 dfs_cac_ms;
>  	bool has_wmm;
> +	s8 psd;
>  };
> 
>  struct ieee80211_regdomain {
> diff --git a/include/uapi/linux/nl80211.h 
> b/include/uapi/linux/nl80211.h
> index c2efea98e060..ae5f69aa727b 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -3851,6 +3851,8 @@ enum nl80211_wmm_rule {
>   *	on this channel in current regulatory domain.
>   * @NL80211_FREQUENCY_ATTR_16MHZ: 16 MHz operation is allowed
>   *	on this channel in current regulatory domain.
> + * @NL80211_FREQUENCY_ATTR_PSD: power spectral density (in dBm)
> + *	is allowed on this channel in current regulatory domain.
>   * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
>   *	currently defined
>   * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
> @@ -3887,6 +3889,7 @@ enum nl80211_frequency_attr {
>  	NL80211_FREQUENCY_ATTR_4MHZ,
>  	NL80211_FREQUENCY_ATTR_8MHZ,
>  	NL80211_FREQUENCY_ATTR_16MHZ,
> +	NL80211_FREQUENCY_ATTR_PSD,
> 
>  	/* keep last */
>  	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
> @@ -3987,6 +3990,8 @@ enum nl80211_reg_type {
>   * 	a given frequency range. The value is in mBm (100 * dBm).
>   * @NL80211_ATTR_DFS_CAC_TIME: DFS CAC time in milliseconds.
>   *	If not present or 0 default CAC time will be used.
> + * @NL80211_ATTR_POWER_RULE_PSD: power spectral density (in dBm).
> + *	This could be negative.
>   * @NL80211_REG_RULE_ATTR_MAX: highest regulatory rule attribute 
> number
>   *	currently defined
>   * @__NL80211_REG_RULE_ATTR_AFTER_LAST: internal use
> @@ -4004,6 +4009,8 @@ enum nl80211_reg_rule_attr {
> 
>  	NL80211_ATTR_DFS_CAC_TIME,
> 
> +	NL80211_ATTR_POWER_RULE_PSD,
> +
>  	/* keep last */
>  	__NL80211_REG_RULE_ATTR_AFTER_LAST,
>  	NL80211_REG_RULE_ATTR_MAX = __NL80211_REG_RULE_ATTR_AFTER_LAST - 1
> @@ -4085,6 +4092,7 @@ enum nl80211_sched_scan_match_attr {
>   * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
>   * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
>   * @NL80211_RRF_NO_HE: HE operation not allowed
> + * @NL80211_RRF_PSD: channels has power spectral density value
>   */
>  enum nl80211_reg_rule_flags {
>  	NL80211_RRF_NO_OFDM		= 1<<0,
> @@ -4103,6 +4111,7 @@ enum nl80211_reg_rule_flags {
>  	NL80211_RRF_NO_80MHZ		= 1<<15,
>  	NL80211_RRF_NO_160MHZ		= 1<<16,
>  	NL80211_RRF_NO_HE		= 1<<17,
> +	NL80211_RRF_PSD			= 1<<18,
>  };
> 
>  #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 0b4f29d689d2..9f1c5be11c95 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -1055,6 +1055,10 @@ static int nl80211_msg_put_channel(struct
> sk_buff *msg, struct wiphy *wiphy,
>  	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_OFFSET, 
> chan->freq_offset))
>  		goto nla_put_failure;
> 
> +	if ((chan->flags & IEEE80211_CHAN_PSD) &&
> +	    nla_put_s8(msg, NL80211_FREQUENCY_ATTR_PSD, chan->psd))
> +		goto nla_put_failure;
> +
>  	if ((chan->flags & IEEE80211_CHAN_DISABLED) &&
>  	    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DISABLED))
>  		goto nla_put_failure;
> @@ -7755,6 +7759,11 @@ static int nl80211_put_regdom(const struct
> ieee80211_regdomain *regdom,
>  				reg_rule->dfs_cac_ms))
>  			goto nla_put_failure;
> 
> +		if ((reg_rule->flags & NL80211_RRF_PSD) &&
> +		    nla_put_s8(msg, NL80211_ATTR_POWER_RULE_PSD,
> +			       reg_rule->psd))
> +			goto nla_put_failure;
> +
>  		nla_nest_end(msg, nl_reg_rule);
>  	}
> 
> @@ -7926,6 +7935,7 @@ static const struct nla_policy
> reg_rule_policy[NL80211_REG_RULE_ATTR_MAX + 1] =
>  	[NL80211_ATTR_POWER_RULE_MAX_ANT_GAIN]	= { .type = NLA_U32 },
>  	[NL80211_ATTR_POWER_RULE_MAX_EIRP]	= { .type = NLA_U32 },
>  	[NL80211_ATTR_DFS_CAC_TIME]		= { .type = NLA_U32 },
> +	[NL80211_ATTR_POWER_RULE_PSD]		= { .type = NLA_S8 },
>  };
> 
>  static int parse_reg_rule(struct nlattr *tb[],
> @@ -7947,6 +7957,14 @@ static int parse_reg_rule(struct nlattr *tb[],
> 
>  	reg_rule->flags = nla_get_u32(tb[NL80211_ATTR_REG_RULE_FLAGS]);
> 
> +	if (reg_rule->flags & NL80211_RRF_PSD) {
> +		if (!tb[NL80211_ATTR_POWER_RULE_PSD])
> +			return -EINVAL;
> +
> +		reg_rule->psd =
> +			nla_get_s8(tb[NL80211_ATTR_POWER_RULE_PSD]);
> +	}
> +
>  	freq_range->start_freq_khz =
>  		nla_get_u32(tb[NL80211_ATTR_FREQ_RANGE_START]);
>  	freq_range->end_freq_khz =
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index df87c7f3a049..8f765befb9bc 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -1590,6 +1590,8 @@ static u32 map_regdom_flags(u32 rd_flags)
>  		channel_flags |= IEEE80211_CHAN_NO_160MHZ;
>  	if (rd_flags & NL80211_RRF_NO_HE)
>  		channel_flags |= IEEE80211_CHAN_NO_HE;
> +	if (rd_flags & NL80211_RRF_PSD)
> +		channel_flags |= IEEE80211_CHAN_PSD;
>  	return channel_flags;
>  }
> 
> @@ -1794,6 +1796,9 @@ static void handle_channel_single_rule(struct
> wiphy *wiphy,
>  				chan->dfs_cac_ms = reg_rule->dfs_cac_ms;
>  		}
> 
> +		if (chan->flags & IEEE80211_CHAN_PSD)
> +			chan->psd = reg_rule->psd;
> +
>  		return;
>  	}
> 
> @@ -1814,6 +1819,9 @@ static void handle_channel_single_rule(struct
> wiphy *wiphy,
>  			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
>  	}
> 
> +	if (chan->flags & IEEE80211_CHAN_PSD)
> +		chan->psd = reg_rule->psd;
> +
>  	if (chan->orig_mpwr) {
>  		/*
>  		 * Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
> @@ -1883,6 +1891,12 @@ static void
> handle_channel_adjacent_rules(struct wiphy *wiphy,
>  							 rrule2->dfs_cac_ms);
>  		}
> 
> +		if ((rrule1->flags & NL80211_RRF_PSD) &&
> +		    (rrule2->flags & NL80211_RRF_PSD))
> +			chan->psd = min_t(s8, rrule1->psd, rrule2->psd);
> +		else
> +			chan->flags &= ~NL80211_RRF_PSD;
> +
>  		return;
>  	}
> 
> @@ -2540,6 +2554,9 @@ static void handle_channel_custom(struct wiphy 
> *wiphy,
>  			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
>  	}
> 
> +	if (chan->flags & IEEE80211_CHAN_PSD)
> +		chan->psd = reg_rule->psd;
> +
>  	chan->max_power = chan->max_reg_power;

What about the case AP + STA concurrency? are we going to overwrite the 
PSD power and channel flags?

>  }
