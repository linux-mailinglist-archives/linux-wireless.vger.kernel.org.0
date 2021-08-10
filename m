Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D33E7CA9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbhHJPok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 11:44:40 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:41360 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbhHJPoj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 11:44:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628610257; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=E1wwJGhwcT0fgokIUql38ixNmO/5P8vzBcKlP7nnMgk=;
 b=frTbIM5NpMZg4DpxxT4pluGNu67xYOdLlaWL5itkLwBcGjUduYsgLxLm0oCwo8OsFtVKh2Jj
 /j1zi1GD66mgLL/pcIc2+9pbQV3JiZOJwMkhkv/CNJEr+oVMp4Z7cmAWo3jr7/EnqeI2BD53
 GEWZgOwypNZlWwfBl47gNCA1sco=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61129ec2b14e7e2ecbd6ed4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 15:44:02
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D274AC433F1; Tue, 10 Aug 2021 15:44:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1966DC43460;
        Tue, 10 Aug 2021 15:43:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Aug 2021 08:43:59 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        ath11k <ath11k-bounces@lists.infradead.org>
Subject: Re: [PATCH v5 1/3] nl80211: Add support for beacon tx mode
In-Reply-To: <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org>
 <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
Message-ID: <1c6e3e783ef437c3b8d83aeb19ec0760@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-10 01:56, Maharaja Kennadyrajan wrote:
> User can configure the below beacon tx mode
> 1. Staggered mode and 2. Burst mode while bring-up the AP
> or MESH.
> 
> Beacons can be sent out in burst(continuously in a single shot
> one after another) or staggered (equally spread out over beacon
> interval) mode.
> 
> Set the beacon_tx_mode as 1 for Staggered mode and 2 for
> burst mode.
> 
> Hence, added the support in the nl80211/cfg80211
> layer to honour the beacon tx mode configuration and pass
> this value to the driver.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00630-QCAHKSWPL_SILICONZ-2
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> ---
> 
> V5: Addressed Johannes's & Felix's comments on v4 patch.
> 
> V4: Rebases on latest ath.git TOT.
> 
> V3: Addressed Johnson's comment on v2 patch.
> 
> V2: Addressed Johannes's comment on v1 patch.
> 
>  include/net/cfg80211.h       |  4 ++++
>  include/uapi/linux/nl80211.h | 20 ++++++++++++++++++++
>  net/wireless/nl80211.c       | 11 +++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 161cdf7..8c3777b 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1189,6 +1189,7 @@ enum cfg80211_ap_settings_flags {
>   * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
>   * @fils_discovery: FILS discovery transmission parameters
>   * @unsol_bcast_probe_resp: Unsolicited broadcast probe response
> parameters
> + * @beacon_tx_mode: Beacon Tx Mode setting
>   */
>  struct cfg80211_ap_settings {
>  	struct cfg80211_chan_def chandef;
> @@ -1221,6 +1222,7 @@ struct cfg80211_ap_settings {
>  	struct cfg80211_he_bss_color he_bss_color;
>  	struct cfg80211_fils_discovery fils_discovery;
>  	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
> +	enum nl80211_beacon_tx_mode beacon_tx_mode;
>  };
> 
>  /**
> @@ -2066,6 +2068,7 @@ struct mesh_config {
>   *	to operate on DFS channels.
>   * @control_port_over_nl80211: TRUE if userspace expects to exchange
> control
>   *	port frames over NL80211 instead of the network interface.
> + * @beacon_tx_mode: Beacon Tx Mode setting.
>   *
>   * These parameters are fixed when the mesh is created.
>   */
> @@ -2089,6 +2092,7 @@ struct mesh_setup {
>  	struct cfg80211_bitrate_mask beacon_rate;
>  	bool userspace_handles_dfs;
>  	bool control_port_over_nl80211;
> +	enum nl80211_beacon_tx_mode beacon_tx_mode;
>  };
> 
>  /**
> diff --git a/include/uapi/linux/nl80211.h 
> b/include/uapi/linux/nl80211.h
> index db47499..29c6429 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2560,6 +2560,13 @@ enum nl80211_commands {
>   *	disassoc events to indicate that an immediate reconnect to the AP
>   *	is desired.
>   *
> + * @NL80211_ATTR_BEACON_TX_MODE: used to configure the beacon tx mode
> (u32),
> + *	as specified in the &enum nl80211_beacon_tx_mode. The user-space
> + *	shall use this attribute to configure the tx mode of beacons.

s/shall/can/
'shall' implies a required action whereas 'can' implies an optional 
action

> + *	Beacons can be sent out in burst(continuously in a single shot
> + *	one after another) or staggered (equally spread out over beacon
> + *	interval) mode.
> + *
>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>   * @NL80211_ATTR_MAX: highest attribute number currently defined
>   * @__NL80211_ATTR_AFTER_LAST: internal use
> @@ -3057,6 +3064,8 @@ enum nl80211_attrs {
> 
>  	NL80211_ATTR_DISABLE_HE,
> 
> +	NL80211_ATTR_BEACON_TX_MODE,
> +
>  	/* add attributes here, update the policy in nl80211.c */
> 
>  	__NL80211_ATTR_AFTER_LAST,
> @@ -7306,4 +7315,15 @@ enum nl80211_sar_specs_attrs {
>  	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
>  };
> 
> +/**
> + * enum nl80211_beacon_tx_mode - Beacon Tx Mode enum.
> + * @NL80211_BEACON_STAGGERED_MODE: Used to configure beacon tx mode as
> + *	staggered mode. This is the default beacon tx mode.
> + * @NL80211_BEACON_BURST_MODE: Used to configure beacon tx mode as 
> burst
> mode.
> + */
> +enum nl80211_beacon_tx_mode {

what happened to 0?

now we're back to the issue that I originally reported that if the 
attribute is not present you send 0 to the driver which is not a valid 
enumeration
See my additional comments further below

> +	NL80211_BEACON_STAGGERED_MODE = 1,
> +	NL80211_BEACON_BURST_MODE = 2,
> +};
> +
>  #endif /* __LINUX_NL80211_H */
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 50eb405..c00e326 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -759,6 +759,9 @@ static const struct nla_policy
> nl80211_policy[NUM_NL80211_ATTR] = {
>  	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
>  	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
>  	[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
> +	[NL80211_ATTR_BEACON_TX_MODE] =
> +		NLA_POLICY_RANGE(NLA_U32, NL80211_BEACON_STAGGERED_MODE,
> +				 NL80211_BEACON_BURST_MODE),
>  };
> 
>  /* policy for the key attributes */
> @@ -5346,6 +5349,10 @@ static int nl80211_start_ap(struct sk_buff *skb,
> struct genl_info *info)
>  	params.dtim_period =
>  		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
> 
> +	if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
> +		params.beacon_tx_mode =
> +
> nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
> +
>  	err = cfg80211_validate_beacon_int(rdev,
> dev->ieee80211_ptr->iftype,
>  					   params.beacon_interval);
>  	if (err)
> @@ -11900,6 +11907,10 @@ static int nl80211_join_mesh(struct sk_buff 
> *skb,
> struct genl_info *info)
>  			return -EINVAL;
>  	}
> 
> +	if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
> +		setup.beacon_tx_mode =
> +
> nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
> +

if you are not going to have an enum for default = 0 then you need an 
else to set
beacon_tx_mode = NL80211_BEACON_STAGGERED_MODE


>  	if (info->attrs[NL80211_ATTR_MESH_SETUP]) {
>  		/* parse additional setup parameters if given */
>  		err = nl80211_parse_mesh_setup(info, &setup);
> --
> 2.7.4

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
