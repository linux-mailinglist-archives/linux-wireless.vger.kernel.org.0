Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CE53534E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348593AbiEZSXF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 14:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348597AbiEZSW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 14:22:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C82ADEEA
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BuIjDyivpmYEOCsVLIh544YjZRSmIQmxmWhMohtSE5w=;
        t=1653589376; x=1654798976; b=b68KMFqW3LT1TTgVemDgBj+RQZ7xaHiC/KArwo0BiZutPs+
        9O0ZzGNU4zcjRkWB/M/DCM3BWSYgKtyxc8wvDH0F/oC5G2x7wTp8R6GGZ8LYDgOesHWIehzi2jIel
        Pk0MtQvnboxorpZibco9eYi5fcQxh3hi6oXNmF2/Fc4Qm+ovmK3vJRFFg9tTGTDnY7j7G8gA6mGXt
        4cCDLL2NOjII4WeSDNXFL477Iiv9RQ79VtjEEcXri/dzIya8IAbTVJbmxZu2JWFAvB0pj8YyLfSa5
        W3HTo4YfjxQZg11Ugg/4ZfTME8wvZp+VCLrTgBp9TcjoJhfQhUCT6EfkFTs6WpZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuI8M-005Ed9-7W;
        Thu, 26 May 2022 20:22:54 +0200
Message-ID: <72c7c72f71d8568d28429ec2fa1323564b4f25cc.camel@sipsolutions.net>
Subject: Re: [RFC v2 05/96] cl8k: add ampdu.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Date:   Thu, 26 May 2022 20:22:53 +0200
In-Reply-To: <20220524113502.1094459-6-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
         <20220524113502.1094459-6-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-24 at 14:33 +0300, viktor.barna@celeno.com wrote:
>=20
> +	if (sta->vht_cap.vht_supported) {
> +		u32 vht_exp =3D (sta->vht_cap.cap &
> +			       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK) >>
> +			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;

You can (often) simplify that kind of thing using u32_get_bits()

> +	he_exp =3D (mac_cap_info3 & IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MAS=
K) >>
> +		HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_OFFSET;

or u8_get_bits(), etc.

There are even le/be versions.

> +		struct ieee80211_he_6ghz_capa *he_6g_cap =3D &sta->he_6ghz_capa;
> +		u8 he_exp_6ghz =3D (le16_to_cpu(he_6g_cap->capa) &
> +				  HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_MASK) >>
> +				  HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_OFFSET;

which you could use here.

I know we don't use it everywhere yet, but IMHO it's ultimately nicer
code, and I definitely try to use it in new code.

johannes
