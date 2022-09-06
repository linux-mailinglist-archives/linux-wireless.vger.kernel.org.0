Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC35AE4A7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiIFJr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 05:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiIFJr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 05:47:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0576454
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gTvnpQR9Kcs8G7lZpM4myKC45cSn5caKLVbUtvlaL6E=;
        t=1662457645; x=1663667245; b=by/a5dCQC+M6aBKj8qJV2KSChk5lEOk1Zj0uUKH1J2fDb56
        HUxXQlqkTT+z49El+jHYxEAoDXpYyZoG622Xuyi+1B2/Dt+wgZDL0YtMimMcYXdvmZU0L7qyLAAmd
        qWpQ2vNVo2f0jwI1RXEaxn3SODSN8kJ3el0QEcWMNF0B7ah/Ur2y6ds2j/VVvm2zMm09yFVHQbxXr
        CS0LQ7tCE9HElFXpxrk/hgkO3icQpmZsWjfo/RqJHSgLCoDVqe9Z0coWIuI+ijdXd5KpHKhop/RGE
        KPuGse3gNtqUiWd7/WLYotSCvnlejlG01RFqXQOE8361dkS6xYZOvqU1h9ORnpDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVVAx-009MsP-0t;
        Tue, 06 Sep 2022 11:47:23 +0200
Message-ID: <4184a31465de442c3f8a66f06aa4c59e77e4c237.camel@sipsolutions.net>
Subject: Re: [PATCH v3 07/12] mac80211: S1G capabilities information element
 in probe request
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Date:   Tue, 06 Sep 2022 11:47:22 +0200
In-Reply-To: <20220906044812.7609-8-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
         <20220906044812.7609-8-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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



Feels like somewhere in this patch you should consider the size of the
new element?
=20
>  /* channel management */
>  bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_o=
per,
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 53826c663723..78e8c286011e 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -1857,6 +1857,12 @@ static int ieee80211_build_preq_ies_band(struct ie=
ee80211_sub_if_data *sdata,
>  	rate_flags =3D ieee80211_chandef_rate_flags(chandef);
>  	shift =3D ieee80211_chandef_get_shift(chandef);
> =20
> +	/* For direct mac80211 scan (probe request), add S1G IE and consider it=
s override bits */
> +	if (band =3D=3D NL80211_BAND_S1GHZ) {
> +		pos =3D ieee80211_ie_build_s1g_cap(pos, &sband->s1g_cap);
> +		goto done;
> +	}
>=20

Though off the top of my head I'm not really sure how it works for the
other bits.

johannes
