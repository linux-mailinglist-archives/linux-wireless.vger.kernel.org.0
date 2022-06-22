Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE05547C0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiFVIQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiFVIQ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 04:16:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EDC37BE9
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZQin75inISirTGT5nX2PYGbsbQMnL3SGsDkob/RKN2U=;
        t=1655885786; x=1657095386; b=YWcK3ggWy2bbk+jFop4GcjC2nWXjqd80XG/HSvjlKyw22a9
        fMca1hUs4W69Y1H5B3Lr/dA3oBcdBVmHuI3sN9bV0scmaugvfZY1+tp41BxOwdZMuWm7sFFz3KLkw
        r2aeFdf5mOW1J1NuBCskgozUIWtRc8wv23sJLONI3/n3mKJCetGVBUBeH3puj/5XIfESIIBpIDPEW
        Ibpk2SQ5q6o+ATs+gHT2SauAeCSEHO++D7J5GiZ3R/3M7hnrtvzcobJLj/HYt8hN+xsEigY1pnXKn
        BNjgZs0WK0DoTI5XgwAODqGBN1fDU8Y2AMKLOySvnrarMDBySRHDZPDLMisxaWhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o3vXE-00CoMZ-Bg;
        Wed, 22 Jun 2022 10:16:24 +0200
Message-ID: <4f6a0142d892f39636161523b573be3110826dd6.camel@sipsolutions.net>
Subject: Re: [bug report] wifi: cfg80211: simplify cfg80211_mlme_auth()
 prototype
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 22 Jun 2022 10:16:23 +0200
In-Reply-To: <YrK/kj6QI2j/CNqO@kili>
References: <YrK/kj6QI2j/CNqO@kili>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
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

Hi,

On Wed, 2022-06-22 at 10:06 +0300, Dan Carpenter wrote:
> The patch 325839da9581: "wifi: cfg80211: simplify
> cfg80211_mlme_auth() prototype" from Jun 1, 2022, leads to the
> following Smatch static checker warning:
>=20
> 	net/wireless/nl80211.c:10310 nl80211_authenticate()
> 	warn: assigning signed to unsigned: 'req.key_idx =3D key.idx' '(-1)-3'

Hmm, ok. What does "(-1)-3" mean? Oh, it's a range: [-1, 3].

>     10217         err =3D nl80211_parse_key(info, &key);
>     10218         if (err)
>     10219                 return err;
>     10220=20
>     10221         if (key.idx >=3D 0) {
>     10222                 if (key.type !=3D -1 && key.type !=3D NL80211_K=
EYTYPE_GROUP)
>     10223                         return -EINVAL;
>     10224                 if (!key.p.key || !key.p.key_len)
>     10225                         return -EINVAL;
>     10226                 if ((key.p.cipher !=3D WLAN_CIPHER_SUITE_WEP40 =
||
>     10227                      key.p.key_len !=3D WLAN_KEY_LEN_WEP40) &&
>     10228                     (key.p.cipher !=3D WLAN_CIPHER_SUITE_WEP104=
 ||
>     10229                      key.p.key_len !=3D WLAN_KEY_LEN_WEP104))
>     10230                         return -EINVAL;
>     10231                 if (key.idx > 3)
>     10232                         return -EINVAL;
>     10233         } else {
>     10234                 key.p.key_len =3D 0;
>     10235                 key.p.key =3D NULL;
>=20
> Apparently key.idx can be -1 on this path

Yeah that's plausible.

>     10307         req.auth_type =3D auth_type;
>     10308         req.key =3D key.p.key;
>     10309         req.key_len =3D key.p.key_len;
> --> 10310         req.key_idx =3D key.idx;
>=20
> So do we really want to set "req.key_idx to (u8)-1" here?

Well, key will be NULL, so the key_idx fundamentally cannot be used...

But I guess I can make that an s8 to make this issue go away.

johannes

