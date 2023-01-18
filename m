Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D9967225D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjARQDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjARQCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:02:20 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C26856EFB
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6eHSbdz8cofcr1fSddSnJQ6rxYSNgjB+BHH23Y4AKsc=;
        t=1674057544; x=1675267144; b=YUpLqK8DCzyVN4ekIOW+qiGiXxbGTprkM9PJc7rtdTXq9SK
        lqZpahpxql2eTJrJ+CH9zDjLbEsBcKqC7omCgD1NguNdkFPZ0Al9hhdQ4G4Qpm8luvUiV8nFQsPcN
        B67l2BCvXdkkZaRume4kOkrOcURzduQkiHVDKhFQfvjXtp5X3UY1vr22/3PwpaRylUC75cUw+vutD
        Hw7UM1RjosYEAtqOWwyWHjeRfI+P1RgMZxeWBWYoV0RatIyU40tMBnV7W/Estsja1WQElZKzNcIiS
        fdt8UlD3BD777QR0Q4x2HGRAHrlZ8MF+Qp/rrg/q18odTshgtkvL7udJoFpyxheg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIAq3-005ekv-0s;
        Wed, 18 Jan 2023 16:58:59 +0100
Message-ID: <b398d76c19c83fe0a2a175547eccd399cd4bc7aa.camel@sipsolutions.net>
Subject: Re: [PATCH v7 3/3] mac80211: additional processing in
 ieee80211_change_beacon
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 16:58:58 +0100
In-Reply-To: <20221109214720.6097-4-quic_alokad@quicinc.com>
References: <20221109214720.6097-1-quic_alokad@quicinc.com>
         <20221109214720.6097-4-quic_alokad@quicinc.com>
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

On Wed, 2022-11-09 at 13:47 -0800, Aloka Dixit wrote:
> Process FILS discovery and unsolicited broadcast probe response
> transmission configurations in ieee80211_change_beacon().
>=20
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> ---
>  net/mac80211/cfg.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index feb54b5e6ebd..3e8e74d01dc9 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1405,6 +1405,7 @@ static int ieee80211_change_beacon(struct wiphy *wi=
phy, struct net_device *dev,
>  	struct cfg80211_beacon_data *beacon =3D &params->beacon;
>  	struct beacon_data *old;
>  	int err;
> +	u32 changed;
>  	struct ieee80211_bss_conf *link_conf;
> =20
>  	sdata_assert_lock(sdata);
> @@ -1429,13 +1430,33 @@ static int ieee80211_change_beacon(struct wiphy *=
wiphy, struct net_device *dev,
>  	if (err < 0)
>  		return err;
> =20
> +	changed =3D err;
> +
> +	if (params->fils_discovery.max_interval) {
> +		err =3D ieee80211_set_fils_discovery(sdata,
> +						   &params->fils_discovery,
> +						   link, link_conf);
> +		if (err < 0)
> +			return err;
> +		changed |=3D BSS_CHANGED_FILS_DISCOVERY;


This (and the similar change for unsolicited probe responses) basically
let you turn it _on_ or _modify_ it, but should there be a way to
explicitly turn it *off* too?

That goes together with my previous comment - since before we didn't
even process this data, why would it suddenly get turned off? Nothing
would ever send BSS_CHANGED_FILS_DISCOVERY or
BSS_CHANGED_UNSOL_BCAST_PROBE_RESP to the driver to turn it off, no?

johannes
