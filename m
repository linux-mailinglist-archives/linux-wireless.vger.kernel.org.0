Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE23666F9E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjALK34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 05:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbjALK3C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 05:29:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070332192
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 02:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3ZD8s7Jbcvn0ZhGwbWeAY8+NiThfyRdrFFr7bggYdFA=;
        t=1673519178; x=1674728778; b=fWeGJJ86ExKvmB8Jw8s6AD86b/murYmkFs5BiTnI75iqPRz
        qofr94yVUb+1a54EbGYbnqsUx5ubtP6DPQ7yq0LYGcBrNa00ogXRG57zMCxhim4WZ8d2oi3yLtivj
        Xg/PFgFYU4OUtTwiAq6g7Mms7lKxQLlFeY405LnvKBbS2Lom9V5eiQA3Tr7rywMYGfp5DncOOBelU
        uNtkHwAkGt15UM2ZZAFj2rZlef69ockPpmuow0dPMv3eNCm5ts9bJ8IpBQTELbIGpKyhIHZ/D0x1F
        MgT7gZq6vwCpdnZvhrFQjX3RBHnbQ9ptvI+x4/W79ZJjKzzKGLl+RbjzNjSIY5KA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFumm-00H3Av-22;
        Thu, 12 Jan 2023 11:26:16 +0100
Message-ID: <64731257b957f50b0f66e4d2fcd8c24dea8d70ff.camel@sipsolutions.net>
Subject: Re: [RFC v2 4/6] mac80211: add utility function for tx_rate -
 rate_info conversion
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name
Date:   Thu, 12 Jan 2023 11:26:15 +0100
In-Reply-To: <20220920104032.496697-5-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
         <20220920104032.496697-5-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-20 at 12:40 +0200, Jonas Jelonek wrote:
> This patch adds an utility function to mac80211 for conversion between
> ieee80211_tx_rate (mac80211.h) and rate_info (cfg80211.h).
>=20
> struct ieee80211_tx_rate is space limited to annotate rates up to IEEE
> 802.11ac. The new struct rate_info is able to annotate IEEE 802.11ax
> rates and beyond. Several drivers internally still use ieee80211_tx_rate
> but mac80211 expects rate_info in struct ieee80211_rate_status. This
> struct is in turn required to allow, e.g., tx-power status report or
> dynamic number of mrr stages.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> ---
>  include/net/mac80211.h |  4 ++++
>  net/mac80211/util.c    | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index c4b55c7273ed..f17a03caa361 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -1051,6 +1051,10 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_=
tx_rate *rate)
>  	return (rate->idx >> 4) + 1;
>  }
> =20
> +void ieee80211_rate_get_rate_info(const struct ieee80211_tx_rate *rate,
> +				  struct wiphy *wiphy, u8 band,
> +				  struct rate_info *rate_info);
> +
>  /**
>   * struct ieee80211_tx_info - skb transmit information
>   *
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 0ea5d50091dc..c76dc255bec3 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -4867,3 +4867,38 @@ void ieee80211_fragment_element(struct sk_buff *sk=
b, u8 *len_pos)
> =20
>  	*len_pos =3D elem_len;
>  }
> +
> +

nit: use just one blank line.

johannes

> +void ieee80211_rate_get_rate_info(const struct ieee80211_tx_rate *rate,
> +				  struct wiphy *wiphy, u8 band,
> +				  struct rate_info *rate_info)
> +{
> +	memset(rate_info, 0, sizeof(struct rate_info));
> +
> +	if (rate->flags & IEEE80211_TX_RC_MCS) { /* 802.11n */
> +		rate_info->flags |=3D RATE_INFO_FLAGS_MCS;
> +		rate_info->mcs =3D rate->idx;
> +	} else if (rate->flags & IEEE80211_TX_RC_VHT_MCS) { /* 802.11ac */
> +		rate_info->flags |=3D RATE_INFO_FLAGS_VHT_MCS;
> +		rate_info->mcs =3D ieee80211_rate_get_vht_mcs(rate);
> +		rate_info->nss =3D ieee80211_rate_get_vht_nss(rate);
> +	} else { /* 802.11a/b/g */

what about HE/EHT?

johannes
