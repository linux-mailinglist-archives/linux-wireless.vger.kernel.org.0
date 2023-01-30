Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C594668079F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjA3ImG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 03:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3ImF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 03:42:05 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52DE193ED
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 00:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HlW8H4QPbvlWL8nOUwbEAAOFRDtW+JldUsZQVmM7PcU=;
        t=1675068124; x=1676277724; b=fFPlW8IvSmzKBxJZxnYIDsuP4oV5agG5arycnfOXd5PEAGU
        8Cy0BqS8CQf7ADU6zAOnZ0WbeQKeyOzzNEC6ts3zYeQy6ak2GR8Je6lzwW5VPbeNj2F0J9BpJjhMz
        ykaxoJ4y2WkXPxS+3soq01vQVtVuet6gT45zokmeko4ML5bYOE6knpdswQe2IkRuJRE44Q9UZA9O9
        FO6Yqm36xbbeU7we1Sv5l72d2EKBD1O+TBxDr1zKB2NT3bEHbV+Hfud9yT3lpGhbc6W1LqGfkXcOK
        p4d5tsMZUJpJ/Y4gVs+p6+/Yr/e1lauqA3wc9PK8FwsLUjs6l6El6THWQQCtQ1XQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pMPjm-00G1E9-1k;
        Mon, 30 Jan 2023 09:42:02 +0100
Message-ID: <7d7e6bc0b102f7c7d2aa7a4755d62598735fa0e1.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/6] wifi: mac80211: validate and configure
 puncturing bitmap in start_ap()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Muna Sinada <quic_msinada@quicinc.com>
Date:   Mon, 30 Jan 2023 09:42:01 +0100
In-Reply-To: <20230130072239.26345-3-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
         <20230130072239.26345-3-quic_alokad@quicinc.com>
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
> - Make puncturing bitmap 32 bit to match NL80211 interface.
> - Export ieee80211_valid_disable_subchannel_bitmap() and use it to
> validate the puncturing bitmap in AP mode.
> - Modify 'change' in ieee80211_start_ap() from u32 to u64 to support
> BSS_CHANGED_EHT_PUNCTURING.
> - Configure the bitmap in link_conf and notify the driver.
>=20
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> ---
> v3: This patch depends on following,
> https://patchwork.kernel.org/project/linux-wireless/patch/20230127123930.=
4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/
>=20
>  include/net/mac80211.h     |  2 +-
>  net/mac80211/cfg.c         | 10 +++++++++-
>  net/mac80211/ieee80211_i.h |  2 ++
>  net/mac80211/mlme.c        | 10 +++++-----
>  4 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 54ffc0cc2918..b1c17c7ac044 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -738,7 +738,7 @@ struct ieee80211_bss_conf {
>  	u8 tx_pwr_env_num;
>  	u8 pwr_reduction;
>  	bool eht_support;
> -	u16 eht_puncturing;
> +	u32 eht_puncturing;

Don't see a reason to change this right now.

> @@ -1296,6 +1296,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy,=
 struct net_device *dev,
>  				IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
>  	}
> =20
> +	if (params->eht_cap) {
> +		if (!ieee80211_valid_disable_subchannel_bitmap(
> +							&params->punct_bitmap,
> +							params->chandef.width))
> +			return -EINVAL;
> +		link_conf->eht_puncturing =3D params->punct_bitmap;
> +		changed |=3D BSS_CHANGED_EHT_PUNCTURING;
> +	}
>  	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP &&

An extra blank line wouldn't be bad :)

And some other bits of this would change by moving the validation to
cfg80211, of course.

Might even be worth doing that as a completely separate patch 1/7?

johannes
