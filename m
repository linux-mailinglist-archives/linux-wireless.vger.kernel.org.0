Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C317A23B1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjIOQiS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjIOQh5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 12:37:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A728A2134
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sWQlWrrH8qp29PKweTcszqEaNfAy2UV9/p+KOki6PqU=;
        t=1694795868; x=1696005468; b=PpESsuTAbmhgpEORSonmDMxvdzBZzrySoyEjnr06Di1fTXs
        5QcHUvXVvPJ8DRrVOBztY13m97lNSccxTg/Gas445lGZqwQJEYtNKVGMzEMRqmdne5SqNUv4op4ol
        F5sv07lDUbxnbcwEQ3GwdntGKmlbT2JA5iBf3anDkJ61dJz/SHIbs+ZGpmSEQoRA6u1nyULlM286z
        CKGIa1Z2QzlmDEgKLbN4jkoNb7kARiRMPLEWEUsCgGhwqP0uvRRfph+BBgVR4kSUMJjTpNRyyvA/T
        bLRPgwwJgpTeo4h1xh+mFJ3o5VYgVoFZ+1svaqwe4kCP6nQwD6ZI3zz0mrp6l+pg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qhBpC-001d1i-00;
        Fri, 15 Sep 2023 18:37:46 +0200
Message-ID: <bb7444d9833236ee5ab5474bc34049eebd5e2c09.camel@sipsolutions.net>
Subject: Re: [bug report] mac80211: accept key reinstall without changing
 anything
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Sep 2023 18:37:45 +0200
In-Reply-To: <220d9f82-c010-4c57-82ec-60bdedc5efcd@moroto.mountain>
References: <220d9f82-c010-4c57-82ec-60bdedc5efcd@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Fri, 2023-09-15 at 11:29 +0300, Dan Carpenter wrote:
> Hello Johannes Berg,
>=20
> The patch fdf7cb4185b6: "mac80211: accept key reinstall without
> changing anything" from Sep 5, 2017 (linux-next),

Huh that's kind of old :-)

> leads to the
> following Smatch static checker warning:
>=20
> 	net/mac80211/key.c:1385 ieee80211_gtk_rekey_add()
> 	warn: 'key' was already freed.
>=20
> net/mac80211/key.c
>    899 =20
>    900          /*
>    901           * Silently accept key re-installation without really ins=
talling the
>    902           * new version of the key to avoid nonce reuse or replay =
issues.
>    903           */
>    904          if (ieee80211_key_identical(sdata, old_key, key)) {
>    905                  ieee80211_key_free_unused(key);
>                                                   ^^^
> key is freed here.
>=20
>    906                  return 0;
>    907          }
>    908 =20
>=20
> net/mac80211/key.c
>     1375                 return ERR_CAST(key);
>     1376=20
>     1377         if (sdata->u.mgd.mfp !=3D IEEE80211_MFP_DISABLED)
>     1378                 key->conf.flags |=3D IEEE80211_KEY_FLAG_RX_MGMT;
>     1379=20
>     1380         /* FIXME: this function needs to get a link ID */
>     1381         err =3D ieee80211_key_link(key, &sdata->deflink, NULL);
>     1382         if (err)
>     1383                 return ERR_PTR(err);
>     1384=20
> --> 1385         return &key->conf;
>                         ^^^^^^^^^^
> Use after free.
>=20

Indeed. The good thing is that basically this really shouldn't happen
since this latter function is only used by iwlwifi, and that already
checks for identical keys (i.e. KRACK protection).

Nevertheless, we should of course fix it, just not really exactly sure
how - I guess ieee80211_gtk_rekey_add() should possibly just return the
old key in that case, need to see how it's used.

johannes
