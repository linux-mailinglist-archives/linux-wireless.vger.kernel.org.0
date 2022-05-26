Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F118534C90
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 11:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiEZJfh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 05:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiEZJfe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 05:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8002C8BDD
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653557732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmnRO7LHTYggSFd+n0zAYXE0N2NAbgdq/MhcoO3eVeQ=;
        b=db3IzVGroGqoMcF4c8Hra3F6KIFE9kSwTM7zz3hrqKoRPh5LMvtFZSH05iogdl0peQrkG/
        DoOmlu48VaVzSpQA/XvMAaak65Trl68vh4i6mKIeQgRL7W9IxN7usVeaANEaMp/L/15UM0
        xqDKtU1fZzGh49ai1BYG0JP/UrHFx9M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-G0I8j0FlM7CYKXCu10Ij7Q-1; Thu, 26 May 2022 05:35:30 -0400
X-MC-Unique: G0I8j0FlM7CYKXCu10Ij7Q-1
Received: by mail-wr1-f70.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so175443wra.15
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 02:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JmnRO7LHTYggSFd+n0zAYXE0N2NAbgdq/MhcoO3eVeQ=;
        b=Kwg0qPXYa7DujNeDGHBuMDz5rWfbLRlWUvW7lSi+ovyloqmusBKuun/Q34pGm4WLO4
         6WIJsmf9dZaEb6bkwhvQTZlUt2yC1IXnf60vxzP9drjDst3G2NofzESMzE1lIEvkakMe
         fheoW5jHJ4IIPVZx8Ken7qFhlUjTJRb/Sbkn1SDHC8egGL2SVRC53o1MZueR0oWgR6BM
         TmKoI77SUERvKi2n2iJWjWrAeMCfFYiWnJ+NtweI1cbPd0W6/v53PqU7dhHgsjCg2Eax
         BnWNSK1KrcjETNzCTJ5kvGx/fdYBxg42x37PshqvrvQChGOlkgwwfIDG9pc65Y+wpKTV
         PE2Q==
X-Gm-Message-State: AOAM532/ZAmui76//qUMsyp1FM/Zi30D2od6K638zPXuHv/z6FI1+rSk
        UV1ck9UVM/eKspfOjnH6kwhaYefrgWcxYuJyrAmut7HVDvZMy2tSDjigiFiVfYstxR5z1dmDtAb
        NxQfcdzeYkVksb7TFpq5Q3h0OS8I=
X-Received: by 2002:a5d:56c8:0:b0:20e:7638:ce53 with SMTP id m8-20020a5d56c8000000b0020e7638ce53mr26336954wrw.420.1653557729604;
        Thu, 26 May 2022 02:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDULMePG4Y7BXWXBNJHRLjgkWShICKdMlLsOk2j8S7NZVAPgSkqkQJnrzSF7YRqyGy6gYdnw==
X-Received: by 2002:a5d:56c8:0:b0:20e:7638:ce53 with SMTP id m8-20020a5d56c8000000b0020e7638ce53mr26336937wrw.420.1653557729392;
        Thu, 26 May 2022 02:35:29 -0700 (PDT)
Received: from localhost (net-93-71-56-156.cust.vodafonedsl.it. [93.71.56.156])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d648a000000b0020ff877cfbdsm1249445wri.87.2022.05.26.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:35:28 -0700 (PDT)
Date:   Thu, 26 May 2022 11:35:26 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mac80211: check skb_shared in ieee80211_8023_xmit()
Message-ID: <Yo9J3j4mjD5ep6Da@lore-desk>
References: <1ef9b892cc93a36b1e62a6dda0e2e0a019f4e5f7.1653555361.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pe8cQTOWleRQHimU"
Content-Disposition: inline
In-Reply-To: <1ef9b892cc93a36b1e62a6dda0e2e0a019f4e5f7.1653555361.git.ryder.lee@mediatek.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Pe8cQTOWleRQHimU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add missing skb_shared check into 802.3 path as 802.11 path does
> to prevent potential use-after-free from happening.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  net/mac80211/tx.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 0e4efc08c762..b026e746ac5b 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -4437,7 +4437,7 @@ static void ieee80211_8023_xmit(struct ieee80211_su=
b_if_data *sdata,
>  				struct net_device *dev, struct sta_info *sta,
>  				struct ieee80211_key *key, struct sk_buff *skb)
>  {
> -	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> +	struct ieee80211_tx_info *info;
>  	struct ieee80211_local *local =3D sdata->local;
>  	struct tid_ampdu_tx *tid_tx;
>  	u8 tid;
> @@ -4452,6 +4452,17 @@ static void ieee80211_8023_xmit(struct ieee80211_s=
ub_if_data *sdata,
>  	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
>  		goto out_free;
> =20
> +	if (skb_shared(skb)) {
> +		struct sk_buff *tmp_skb =3D skb;
> +
> +		skb =3D skb_clone(skb, GFP_ATOMIC);
> +		kfree_skb(tmp_skb);
> +
> +		if (!skb)
> +			return;
> +	}

I guess you can use skb_share_check() here instead.

Regards,
Lorenzo

> +
> +	info =3D IEEE80211_SKB_CB(skb);
>  	memset(info, 0, sizeof(*info));
> =20
>  	ieee80211_aggr_check(sdata, sta, skb);
> --=20
> 2.29.2
>=20

--Pe8cQTOWleRQHimU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYo9J3gAKCRA6cBh0uS2t
rFmCAQCaolYs75JOv0Zht8/vMW6lA2NyXUt6FnUf0Lsuh+7PagD8DiUDWY9LYMhF
WestUWb7Ak0vkSyywILqS3E5rRLOVQU=
=7M7Q
-----END PGP SIGNATURE-----

--Pe8cQTOWleRQHimU--

