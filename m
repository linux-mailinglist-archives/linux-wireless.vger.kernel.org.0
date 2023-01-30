Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE5680792
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjA3IkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 03:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3IkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 03:40:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50418DBC5
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 00:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1DlDSFxydq/rBTe24CEHXtRwAkk01w1TtAxPlC/wazA=;
        t=1675068008; x=1676277608; b=Rs23bI6Ey6kTIInY6z2UF5zQ4L17eReCBjyi3szwMOlWm+4
        6UaQxFSpFEVKLo5TprQj6Fa5RFskXu33JTzyOO6+ZUx1NHiQ60eY2Eb5qynElRQmLQ0Ndcsfx5c2U
        FGSo/GohS7fUlfyLJ+GFAtBv9+c5KPKYf4eVh18fyQzF/PzgRSpUjcJxs9l9qqccTpwUHLlfZSFxA
        EFoGt/gzue1bP8yRZ8u2IWWc5+JWcnef7SpDfuIWdI9GTXQwAp0dddLQXKSHgd8jkPS3UrgQZYtZH
        KF0R0/TKCBTtuBeF50iD92PePdypYZjkBuf5Fbtr5mzuHwhJl/s7E7R2iQuhx4bA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pMPht-00G1CM-0z;
        Mon, 30 Jan 2023 09:40:05 +0100
Message-ID: <3552eaee6a02d0b76dc4353b0d5556c3fe503d8e.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/6] wifi: nl80211: configure puncturing bitmap in
 NL80211_CMD_START_AP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Muna Sinada <quic_msinada@quicinc.com>
Date:   Mon, 30 Jan 2023 09:40:04 +0100
In-Reply-To: <20230130072239.26345-2-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
         <20230130072239.26345-2-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Sun, 2023-01-29 at 23:22 -0800, Aloka Dixit wrote:
>=20
> v3: Validation and storing the bitmap moved to MAC80211.

I think I'd prefer we move the validation function to cfg80211 so both
can use it, this way all potential non-mac80211 drivers have to do it as
well, and then they'll move the function _anyway_ to do the validation
in a single place, I'd hope?

> + * @punct_bitmap: Preamble puncturing bitmap. Each bit represents a 20 M=
Hz
> + *	channel, lowest bit corresponding to the lowest frequency. Bit set
> + *	to 1 indicates that the channel is punctured. Higher 16 bits are
> + *	reserved.
>   */
>  struct cfg80211_ap_settings {
>  	struct cfg80211_chan_def chandef;
> @@ -1350,6 +1354,7 @@ struct cfg80211_ap_settings {
>  	struct cfg80211_fils_discovery fils_discovery;
>  	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
>  	struct cfg80211_mbssid_config mbssid_config;
> +	u32 punct_bitmap;

Internally I think we can continue to use u16, that's trivial to change
later.

> + * @NL80211_EXT_FEATURE_EHT_PUNCTURING: Driver supports preamble punctur=
ing in
> + *	EHT.

That should probably make some mention of AP mode? It's not optional in
any way for client, after all, and also not relevant to the API how
client does it.

> +static int nl80211_parse_punct_bitmap(struct cfg80211_registered_device =
*rdev,
> +				      struct genl_info *info,
> +				      u32 *bitmap)
> +{
> +	if (!bitmap ||
> +	    !wiphy_ext_feature_isset(&rdev->wiphy,
> +				     NL80211_EXT_FEATURE_EHT_PUNCTURING))
> +		return -EINVAL;
> +
> +	*bitmap =3D nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]) & 0xFFF=
F;

As the top bits are *reserved* then you should check that they're indeed
zero - now they're ignored, which is generally bad. They might not
always be.

johannes
