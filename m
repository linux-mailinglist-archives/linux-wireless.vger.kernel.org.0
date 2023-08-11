Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA5778A66
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjHKJy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjHKJy3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:54:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C82723;
        Fri, 11 Aug 2023 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JqIVzqe3zsZkySYk3QDj5cazXjSDkcgsZQVLFuNqkEQ=;
        t=1691747668; x=1692957268; b=ntewn/KSpK1idGWMgrbAqfcl+eBXczYCc5c6/6vXkpYgQcR
        iF61TF99IcLqeIVoj2YO2+yK786feDodhAeYiU/+ZxpVa3jRLYbleY+a9l7hFEzs3C2R9aS1AYC7Y
        N825GPqf7u8F4McGxpV5ttpMxZubsTBN5ANNVS1qWB7HLmN0L2t17tLgmBcN0wXI7y7ZtpnW5LPx6
        EK2hkMJW82v1N+2i29QcVnEI0N5l8j4su6UOogsSEsSdwQGNyvJgynIQKqoTTBwxah1T7yOS+zEKL
        eMjCRTh7YxvXzaxlCq2eIlSLYn+ymXx1gkFzB5ENo7L8KGCypr0MW8ZieE8Ixi1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qUOqX-000rKw-2M;
        Fri, 11 Aug 2023 11:54:17 +0200
Message-ID: <55a6644c62e7c955d6dacd9a10f945a199f47277.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: avoid NULL-ptr deref after
 cfg80211_cqm_rssi_update
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Max Schulze <max.schulze@online.de>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org
Date:   Fri, 11 Aug 2023 11:54:15 +0200
In-Reply-To: <eb944f1f-8d7c-5057-35f2-34812907e4d1@online.de>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
         <bc3bf8f6-7ad7-bf69-9227-f972dac4e66b@online.de>
         <eb944f1f-8d7c-5057-35f2-34812907e4d1@online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Fri, 2023-08-11 at 09:30 +0200, Max Schulze wrote:
> In cfg80211_cqm_rssi_notify, when calling cfg80211_cqm_rssi_update, this =
might free
> the wdev->cqm_config . Check for this when it returns.

That doesn't seem right? How does cfg80211_cqm_rssi_update() free it?

> This has been observed on brcmfmac, when a RSSI event is generated just r=
ight
> after disconnecting from AP. Then probing for STA details returns nothing=
, as
> evidenced i.e. by
> "ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52".

I think the issue then isn't that this frees it but rather than a free
of it races with the reporting?

> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -19088,7 +19088,7 @@ void cfg80211_cqm_rssi_notify(struct net_device *=
dev,
> =20
>  		cfg80211_cqm_rssi_update(rdev, dev);
> =20
> -		if (rssi_level =3D=3D 0)
> +		if (rssi_level =3D=3D 0 && wdev->cqm_config)
>  			rssi_level =3D wdev->cqm_config->last_rssi_event_value;
>=20

But if it's a race, then this isn't actually going to really fix the
issue, rather it just makes it (much) less likely.

Since we can probably neither lock the wdev here nor require calls to
this function with wdev lock held, it looks like we need to protect the
pointer with RCU instead?

johannes
