Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7B6076AE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 14:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJUME1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 08:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJUME0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 08:04:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F1FCD
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=c7Rv9y9uUDPkJqNqC0edoRVL1It1YeV+sh4nGw5HRhM=;
        t=1666353861; x=1667563461; b=QEI8/j76K/xfS7Xet0Gbc1mD/85Hx+iESc2qUTt5hZLFj4y
        p0xj1FSpbq79L/IxQJd9XklYAsrqZgnSL0cRyGXBY9U2uQ6fLxD3M8s5HfD3AMYOGhyZ4JEh+rj/D
        8Vq8vwOO32sgY5nc38UCB3bF+KdV1TscClaCxNF2Z1OKBaR4v9EZXXMS0QFKkHcHIgopn+cl64aMA
        p3UomgVVI/NPiYO0oUU0/uz5fY1OsYYg254nP39j4vHuFd4h1LrSBDjIvdbhJhiallmBgcb2EQ9R7
        eeoZ6HLuxETupGO2iMFVJUr9Zn3IJ2dNzkDpUarBc2KBOf/LJvJfYR5w21z23a8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1olql8-00Cqn5-1l;
        Fri, 21 Oct 2022 14:04:18 +0200
Message-ID: <0af1c2b6e7b964b559989e860e600a5c27372e83.camel@sipsolutions.net>
Subject: Re: [RFC 1/4] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 21 Oct 2022 14:04:17 +0200
In-Reply-To: <20220920100518.19705-2-quic_vthiagar@quicinc.com>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
         <20220920100518.19705-2-quic_vthiagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-20 at 15:35 +0530, Vasanthakumar Thiagarajan wrote:
> The prerequisite for MLO support in cfg80211/mac80211 is that all
> the links participating in MLO must be from the same wiphy/ieee80211_hw.
> To meet this expectation, some drivers may need to group multiple discret=
e
> hardware each acting as a link in MLO under one wiphy. Though most of the
> hardware abstractions must be handled within the driver itself, it may be
> required to have some sort of mapping while describing interface
> combination capabilities for each of the underlying hardware. This commit
> adds an advertisement provision for drivers supporting such MLO mode of
> operation.
>=20
> Capability advertisement such as the number of supported channels for eac=
h
> physical hardware has been identified to support some of the common use
> cases.
>=20
> Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
> ---
>  include/net/cfg80211.h |  24 +++++++++
>  net/wireless/core.c    | 109 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index e09ff87146c1..4662231ad068 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -5088,6 +5088,18 @@ struct wiphy_iftype_akm_suites {
>  	int n_akm_suites;
>  };
> =20
> +/**
> + * struct ieee80211_supported_chans_per_hw - supported channels as per t=
he
> + * underlying physical hardware configuration
> + *
> + * @n_chans: number of channels in @chans
> + * @chans: list of channels supported by the constituent hardware
> + */
> +struct ieee80211_chans_per_hw {
> +	int n_chans;

nit: unsigned?

> + * @hw_chans: list of the channels supported by every constituent underl=
ying

"every" here refers to the fact that you have all the channels, right? I
mean, hw_chans is per hardware, basically.

> + *	hardware. Drivers abstracting multiple discrete hardware (radio) unde=
r
> + *	one wiphy can advertise the list of channels supported by each physic=
al
> + *	hardware in this list. Underlying hardware specific channel list can =
be
> + *	used while describing interface combination for each of them.
> + * @num_hw: number of underlying hardware for which the channels list ar=
e
> + *	advertised in @hw_chans.
> + *
>   */
>  struct wiphy {
>  	struct mutex mtx;
> @@ -5445,6 +5466,9 @@ struct wiphy {
>  	u8 ema_max_profile_periodicity;
>  	u16 max_num_akm_suites;
> =20
> +	struct ieee80211_chans_per_hw **hw_chans;
> +	int num_hw;

also here, maybe unsigned.

> +static bool
> +cfg80211_hw_chans_in_supported_list(struct wiphy *wiphy,
> +				    const struct ieee80211_chans_per_hw *chans)
> +{
> +	enum nl80211_band band;
> +	struct ieee80211_supported_band *sband;
> +	bool found;
> +	int i, j;
> +
> +	for (i =3D 0; i < chans->n_chans; i++) {
> +		found =3D false;

nit: you can move the variable declaration here

	bool found =3D false;
	\n

since you don't need it outside the loop.

> +	for (i =3D 0; i < wiphy->num_hw; i++) {
> +		for (j =3D 0; j < wiphy->num_hw; j++) {
> +			const struct ieee80211_chans_per_hw *hw_chans1;
> +			const struct ieee80211_chans_per_hw *hw_chans2;
> +
> +			if (i =3D=3D j)
> +				continue;

It's symmetric, if I read the code above right, so you can do

	for (j =3D i; j < ...; j++)

in the second loop and avoid this?


> +		hw_chans =3D wiphy->hw_chans[i];
> +		if (!cfg80211_hw_chans_in_supported_list(wiphy, hw_chans)) {
> +			WARN_ON(1);

I can kind of see the point in not using WARN_ON(!cfg80211_hw_chans...)
since it gets really long, but maybe just remove the warning?
=20
> +	if (cfg80211_validate_per_hw_chans(&rdev->wiphy)) {
> +		WARN_ON(1);
> +		return -EINVAL;
>=20

Anyway you'll have one here, and it's not directly visible which
condition failed anyway.

And you could use WARN_ON(validate(...)) here :)

johannes
