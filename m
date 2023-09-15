Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3C7A23ED
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjIOQvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjIOQuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 12:50:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF3118
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=of5J7GktS8a7VzhSf+X5rgJW+pTcQ33kv0D7GoUnRQU=;
        t=1694796649; x=1696006249; b=S4gCyyldGHX2g8UsP3zeYhXFJoxZPUyGUpGqA/Klo+54jQq
        0CjdGZKI86TYs/LGzjRx0heJkUbMF6n13o5WWeIdi/QCj7soOGFkEUSG+VF2wYyskzvb39Vn7uMYl
        nny6FdUJ/3/6n/WcmnZu3MPqM5z3194XmYVFoUsHUHFsNL1L/QpXJuE1mp+/gh+RNHxy8HGEH7pYT
        4hhfR9P3RjlBZdxVyK4YLS5v8QCzy24DHj4S6VnqQBPgAbh94FT1KISSNUzsODnSI/exEqNqp145m
        0y2HW1f1QDcasP5q8ShywVuWdH3LZRSpz34GUBZfeFw7tbmnX7/CH9eZYXev6CpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qhC1n-001eK0-2y;
        Fri, 15 Sep 2023 18:50:48 +0200
Message-ID: <839b61b4ac35265a1ae847c6e011c401bf778b3e.camel@sipsolutions.net>
Subject: Re: [bug report] mac80211: accept key reinstall without changing
 anything
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Sep 2023 18:50:47 +0200
In-Reply-To: <4b30551a-f8db-441b-aba4-889a09d46009@kadam.mountain>
References: <220d9f82-c010-4c57-82ec-60bdedc5efcd@moroto.mountain>
         <bb7444d9833236ee5ab5474bc34049eebd5e2c09.camel@sipsolutions.net>
         <4b30551a-f8db-441b-aba4-889a09d46009@kadam.mountain>
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

On Fri, 2023-09-15 at 19:47 +0300, Dan Carpenter wrote:
> On Fri, Sep 15, 2023 at 06:37:45PM +0200, Johannes Berg wrote:
> > On Fri, 2023-09-15 at 11:29 +0300, Dan Carpenter wrote:
> > > Hello Johannes Berg,
> > >=20
> > > The patch fdf7cb4185b6: "mac80211: accept key reinstall without
> > > changing anything" from Sep 5, 2017 (linux-next),
> >=20
> > Huh that's kind of old :-)
> >=20
>=20
> Someone shuffled the return paths in ieee80211_key_link()=C2=A0
>=20

I did :P

> so it became easier to parse.

Somewhat:

@@ -906,8 +905,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
         */
        if (ieee80211_key_identical(sdata, old_key, key)) {
                ieee80211_key_free_unused(key);
-               ret =3D 0;
-               goto out;
+               return 0;
        }
=20
        key->local =3D sdata->local;
@@ -931,9 +929,6 @@ int ieee80211_key_link(struct ieee80211_key *key,
                ieee80211_key_free(key, delay_tailroom);
        }
=20
- out:
-       mutex_unlock(&sdata->local->key_mtx);
-
        return ret;
 }


I guess to a person that doesn't seem all that different, but who knows
how the tools interpret all the control flow here.

Hey, at least something already came out of all the locking reductions
:-)


>   I normally don't report old bugs because normally it's
> abandoned and forgotten by that time.  But I know you're still around
> fixing bugs and no good deed should go unpunished.  ;)

:-)

Anyway, not going to fix it today, but I've noted it.

johannes
