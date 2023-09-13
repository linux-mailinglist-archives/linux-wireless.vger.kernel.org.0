Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3179E3FA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbjIMJmv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 05:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIMJmv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 05:42:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94814196
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=85yhBv0lSgnV9ZVj6qyKo2Nu8T/WdCmRvTM9KCSNxOc=;
        t=1694598167; x=1695807767; b=rXOXE7u0ZaX9UAKFun6TgRbH21CqDPsUOP3U67u5IY7+ME9
        mq1bTAP8wwUQ1hh+FN9pu1bIwpGKNwOhkh0vA62ipYZdY61UP8sN+BFEbAK68uJVGsIw5RuNhj0bW
        t5DG5t6PDDZXo+bRxlxSYJu4YVyVSVENbKRjn2YjBHaxDPChS+bPWQu9XSGMX1PfrJOFre6xbjGsh
        hf+GRS+F26IdjuJW+e2R/dhl4cVkpkZ7F4CWjljHlg3SicCH2hQq/8ErSAGhzFfzDzflxYaOw+Ahh
        oUOPsSARaN1Q/xTHdaKbTNxSDE9wzCbHSO9leSUe1FUVfhEIHqzI4Gzz0tNEHXyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgMOS-00EkJy-2T;
        Wed, 13 Sep 2023 11:42:44 +0200
Message-ID: <b73fe9aa87682553302d237d0b071b6b71f75d83.camel@sipsolutions.net>
Subject: Re: [PATCH v6 1/3] wifi: cfg80211: allow userspace to enable driver
 control of MU-EDCA
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 13 Sep 2023 11:42:43 +0200
In-Reply-To: <1682960363-15452-1-git-send-email-quic_msinada@quicinc.com>
References: <1682960363-15452-1-git-send-email-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-05-01 at 09:59 -0700, Muna Sinada wrote:
> Add option for user space to enable driver to dynamically update MU-EDCA
> parameters.
>=20
> The updated MU-EDCA parameters from driver are part of an AP mode feature
> where firmware determines better MU-EDCA parameters based on channel
> conditions. The updated parameters are used and reported to user space
> to reflect in AP management frames. These dynamic parameter updates
> are offloaded to firmware for better user experience, thus details on
> algorithm are not provided. This is a driver specific feature, thus
> no spec references.
>=20
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> ---
> v6: no change
>=20
> v5: no change
>=20
> v4: newly created patch in response to review comment to add opt in
>     for user for this feature
> ---
>  include/net/cfg80211.h       | 3 +++
>  include/uapi/linux/nl80211.h | 5 +++++
>  net/wireless/nl80211.c       | 5 +++++
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 9e04f69712b1..e56af095828e 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1359,6 +1359,8 @@ struct cfg80211_unsol_bcast_probe_resp {
>   * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
>   *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
>   *	Bit set to 1 indicates that the channel is punctured.
> + * @dyn_muedca_enable: enable/disable driver control of dynamically upda=
te
> + *     MU-EDCA parameters

please use tabs for indentation

>   */
>  struct cfg80211_ap_settings {
>  	struct cfg80211_chan_def chandef;
> @@ -1394,6 +1396,7 @@ struct cfg80211_ap_settings {
>  	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
>  	struct cfg80211_mbssid_config mbssid_config;
>  	u16 punct_bitmap;
> +	bool dyn_muedca_enable;
>  };
> =20
>  /**
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index cf4fb981e131..e68169130e7e 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2805,6 +2805,9 @@ enum nl80211_commands {
>   *	index. If the userspace includes more RNR elements than number of
>   *	MBSSID elements then these will be added in every EMA beacon.
>   *
> + * @NL80211_ATTR_DYN_MUEDCA_ENABLE: Flag attribute to indicate user spac=
e has
> + *  enabled Driver control of dynamically updating MU-EDCA parameters.

dito

> @@ -6156,6 +6157,10 @@ static int nl80211_start_ap(struct sk_buff *skb, s=
truct genl_info *info)
>  		goto out_unlock;
>  	}
> =20
> +	if (info->attrs[NL80211_ATTR_DYN_MUEDCA_ENABLE])
> +		params->dyn_muedca_enable =3D
> +		     nla_get_flag(info->attrs[NL80211_ATTR_DYN_MUEDCA_ENABLE]);
>=20

Should it be possible to dynamically change this configuration?


See also
https://patchwork.kernel.org/project/linux-wireless/patch/20230727174100.11=
721-4-quic_alokad@quicinc.com/
where this gets used differently later. I'll look at that next. You're
both @quicinc so you can talk to each other I hope ;-)

johannes
