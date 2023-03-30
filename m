Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8186D007D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjC3KBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 06:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjC3KB2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 06:01:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6283DB
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=12UZPQCfdRbHnlrfQyRD17hEz7rxT8h3QBgvCkFpUmU=;
        t=1680170463; x=1681380063; b=yGEr7taqH8Kvr80/r8Ad7EFGEip1eIXoovSraEx8f6mzZZi
        VKuSqmu8IB/2BGt5oaqfpnWGLNvPZHQTBgiay/eWa8WPlQICgphA0DoutrMbLHusvLWSPihWYaCR9
        mEtNlhcc/NgpfB6lh4O+zBWCZ0+zl2wWApP7b1rKEsb8AFFGqh3XCCZpOSCAd8vS79yPouJje6StD
        1xHkwfFmJ5Ixo35e2PUqHT/OG7DFj6KmLj38+VwrAPtAz0jKitcg7TFtyLzzwuDeVYfM9U4QuDBIX
        7pOprspTrEVeQ0rMwZF5jWthrTbiwI+09yvtPLDL1TraJJksdnMVuAfWoRnh8Tnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1php5Y-000yjO-2m;
        Thu, 30 Mar 2023 12:01:00 +0200
Message-ID: <c29c5d8bd6c2da5ed448d4d992aa27a97cb63145.camel@sipsolutions.net>
Subject: Re: [PATCH v3 4/4] wifi: mac80211: support setting S1G short beacon
 period, head and tail
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Date:   Thu, 30 Mar 2023 12:00:59 +0200
In-Reply-To: <20221116020700.3907453-4-gilad.itzkovitch@morsemicro.com>
References: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
         <20221116020700.3907453-4-gilad.itzkovitch@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-11-16 at 15:07 +1300, Gilad Itzkovitch wrote:
>=20
> +	/* Short head is not a mandatory field */
> +	new_short_head_len =3D 0;
> +	if (params->short_head)
> +		new_short_head_len =3D params->short_head_len;
> +	else
> +		if (old && old->short_head)
> +			new_short_head_len =3D old->short_head_len;


"else if (...)"

would seem nicer and save the indentation level

> +	if (params->short_head)
> +		memcpy(new->short_head, params->short_head, new_short_head_len);
> +	else
> +		if (old && old->short_head)
> +			memcpy(new->short_head, old->short_head, new_short_head_len);

same here

> +
>  	/* copy in optional tail */
>  	if (params->tail)
>  		memcpy(new->tail, params->tail, new_tail_len);
> @@ -1177,6 +1204,13 @@ static int ieee80211_assign_beacon(struct ieee8021=
1_sub_if_data *sdata,
>  		if (old)
>  			memcpy(new->tail, old->tail, new_tail_len);
> =20
> +	/* copy in optional short tail */
> +	if (params->short_tail)
> +		memcpy(new->short_tail, params->short_tail, new_short_tail_len);
> +	else
> +		if (old)
> +			memcpy(new->short_tail, old->short_tail, new_short_tail_len);

and here.


And also here I'm a bit worried about hitting all these code paths when
it's not S1G?


johannes
