Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7435D4E3BDC
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 10:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiCVJpI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 05:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiCVJpH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 05:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F1E1275F8
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647942216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ep6u9o8UtFSjs92tM2XwPFhronAu/I5S/aCvFIk7Ohg=;
        b=F6cNIq9s8QntcZ1YADk+xnYwOsG9A9AEKjsgjbD9KbfOWVj4DMKGcBG9HkBcVplm7hnJTD
        SIcLGoi9FSN0Ok0qttuY20De6TQBd0NG8xPGTgyYJvX5nj8ZiJV33pXtpJppUVLLhNtTJM
        4teNuragQgC0woJYZtkGWqQPFYQ3G7I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-wvvK939QOgOxU8v4zhLiAg-1; Tue, 22 Mar 2022 05:43:34 -0400
X-MC-Unique: wvvK939QOgOxU8v4zhLiAg-1
Received: by mail-qv1-f70.google.com with SMTP id cl19-20020a05621404f300b0044103143211so7957774qvb.10
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 02:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ep6u9o8UtFSjs92tM2XwPFhronAu/I5S/aCvFIk7Ohg=;
        b=GwYrUqn0CWuRrJ4N4FXZc5Lc8Pfo627yWDOJ69hNK/YzGDU5llFe57PF8acuvq0sZ6
         dPU2PkvjgU7wxYGin4Y6S2gVUdNoDa8Ut5ae3gC11XOb09+zG3CO70Po4+duLDNxDl1p
         Z8UN0L4WORr82loKJh36IxqD+BrFMpGfn1BVExwr+baFEs4/dyI4yysD9rka4TjAccJx
         s1/QZ1x+Kf23Nre1z9o3GISPnHxqW68amTITdD/KHZ0Ur62o1gWP7BcrUMWtuMPFqWIQ
         WyhAgPkHoAMo3S80xwXh9v6VFsRJENPOdxYUUG9KTVZbw6yTu8FRr7VDAzIonoRHFdXE
         +SQA==
X-Gm-Message-State: AOAM532uaIuIRU3D/v9731Oox8ciz71cNzZIL9YQuKD+vPHskt7LVmj2
        fzaJcRoTU+rYFiWdEVM45gpkXSV7mL8qhkd90fI1NUqYxK/ejDszq4APxNqlJAQnqrR6bDEJIQq
        MSxwxg6NqnTDZNMsWhkKECfEfPnA=
X-Received: by 2002:a05:620a:4592:b0:67d:8ed9:8c37 with SMTP id bp18-20020a05620a459200b0067d8ed98c37mr15105659qkb.150.1647942214081;
        Tue, 22 Mar 2022 02:43:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZvkISH3lDe807I0UBeCaupY1PO+wJn7a1WiPNh27CybqEuvnY8S97iMCf0xws2fJn2UYH8Q==
X-Received: by 2002:a05:620a:4592:b0:67d:8ed9:8c37 with SMTP id bp18-20020a05620a459200b0067d8ed98c37mr15105647qkb.150.1647942213784;
        Tue, 22 Mar 2022 02:43:33 -0700 (PDT)
Received: from localhost (net-93-144-71-136.cust.dsl.teletu.it. [93.144.71.136])
        by smtp.gmail.com with ESMTPSA id b126-20020a376784000000b0067d21404704sm8602500qkc.131.2022.03.22.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 02:43:33 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:43:29 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        johannes@sipsolutions.net, lkp@intel.com, kbuild-all@lists.01.org,
        nbd@nbd.name, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        chui-hao.chiu@mediatek.com, j@w1.fi
Subject: Re: [kbuild] Re: [PATCH wireless-next] mac80211: introduce BSS color
 collision detection
Message-ID: <YjmaQeDWT2G7wHzU@lore-desk>
References: <6226a016389e034fd9c208b3a7a75edd01aba6f4.1647858505.git.lorenzo@kernel.org>
 <202203220555.BHvsEAhe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c6FqmyFF63MIXN5"
Content-Disposition: inline
In-Reply-To: <202203220555.BHvsEAhe-lkp@intel.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--6c6FqmyFF63MIXN5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> url:    https://github.com/0day-ci/linux/commits/Lorenzo-Bianconi/mac8021=
1-introduce-BSS-color-collision-detection/20220321-183456=20
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless=
-next.git  main
> config: nios2-randconfig-m031-20220321 (https://download.01.org/0day-ci/a=
rchive/20220322/202203220555.BHvsEAhe-lkp@intel.com/config )
> compiler: nios2-linux-gcc (GCC) 11.2.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> New smatch warnings:
> net/mac80211/rx.c:3218 ieee80211_rx_check_bss_color_collision() warn: sho=
uld '(((1))) << color' be a 64 bit type?
>=20
> vim +3218 net/mac80211/rx.c
>=20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3181  static void
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3182  ieee80211_rx_check_bss_=
color_collision(struct ieee80211_rx_data *rx)
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3183  {
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3184  	struct ieee80211_mgmt =
*mgmt =3D (void *)rx->skb->data;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3185  	const struct element *=
ie;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3186  	size_t baselen;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3187 =20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3188  	if (!wiphy_ext_feature=
_isset(rx->local->hw.wiphy,
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3189  				     NL80211_EXT_FE=
ATURE_BSS_COLOR))
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3190  		return;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3191 =20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3192  	if (wiphy_ext_feature_=
isset(rx->local->hw.wiphy,
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3193  				    NL80211_EXT_FEA=
TURE_HW_COLOR_COLLISION))
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3194  		return;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3195 =20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3196  	baselen =3D mgmt->u.be=
acon.variable - rx->skb->data;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3197  	if (baselen > rx->skb-=
>len)
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3198  		return;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3199 =20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3200  	ie =3D cfg80211_find_e=
xt_elem(WLAN_EID_EXT_HE_OPERATION,
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3201  				    mgmt->u.beacon.=
variable,
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3202  				    rx->skb->len - =
baselen);
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3203  	if (ie && ie->datalen =
>=3D sizeof(struct ieee80211_he_operation) &&
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3204  	    ie->datalen >=3D i=
eee80211_he_oper_size(ie->data + 1)) {
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3205  		struct ieee80211_bss_=
conf *bss_conf =3D &rx->sdata->vif.bss_conf;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3206  		const struct ieee8021=
1_he_operation *he_oper;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3207  		u8 color;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3208 =20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3209  		he_oper =3D (void *)(=
ie->data + 1);
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3210  		if (le32_get_bits(he_=
oper->he_oper_params,
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3211  				  IEEE80211_HE_OPER=
ATION_BSS_COLOR_DISABLED))
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3212  			return;
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3213 =20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3214  		color =3D le32_get_bi=
ts(he_oper->he_oper_params,
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3215  				      IEEE80211_HE_=
OPERATION_BSS_COLOR_MASK);
>=20
> IEEE80211_HE_OPERATION_BSS_COLOR_MASK gives us 63
>=20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3216  		if (color =3D=3D bss_=
conf->he_bss_color.color)
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3217  			ieeee80211_obss_colo=
r_collision_notify(&rx->sdata->vif,
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21 @3218  							       BIT(color=
));
>=20
> So this should be BIT_ULL()

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3219  	}
> 964596b43c17b4 Lorenzo Bianconi 2022-03-21  3220  }
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp=20
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
>=20

--6c6FqmyFF63MIXN5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYjmaQQAKCRA6cBh0uS2t
rCFUAP430vetz1K7lv7+1f4YaRmuJIV42yFse17ZI6tNZjNkUwEAzkHfUrQ7jDYc
/gz1nivQw3U+gsv0XT9IXAaox3P8cAE=
=6ByS
-----END PGP SIGNATURE-----

--6c6FqmyFF63MIXN5--

