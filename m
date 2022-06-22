Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8FA55469C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 14:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiFVILx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 04:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiFVILu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 04:11:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969AA37BC7
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZVbU85c3COMeHYKTxDdta1DL9CoFu+4xk5oUOZLYSW8=;
        t=1655885506; x=1657095106; b=k7DopqCusYlZHyGJyVyfkddL1NZcIp3/lFK8kgNLSQOmJ9v
        jjZ3tyaTkjU8/zHSfr+lgYgUqAbPMmoKnCMAnx/y+Y3bd5weVe+JJMLdUWb9QGQ7S7IYZ12F2d/Am
        pYOOkXsnUXm0uclOeq58ttVqS0YhKQHFs4eGQj9LMGy3tjUFpCIPxccj0E1Z0sKIgScJTzB/HSRek
        gWpOfnSVQIIFjcf4tS8JhqgtYkJGGgSSZiFXYgVIOWEWswJ1O0zsY9PthFoQvqRUAO0ZswgVwbiug
        ohIP6tq8e6wrxYYXVndTTsQwa34rTqLwXv0+VBJI2x/s3sG+BK3CJxT9Gd4fTWPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o3vSh-00CoHZ-UG;
        Wed, 22 Jun 2022 10:11:44 +0200
Message-ID: <0ee06d5296b836312346e23e7876ede8655835a0.camel@sipsolutions.net>
Subject: Re: [bug report] wifi: nl80211: support MLO in auth/assoc
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 22 Jun 2022 10:11:42 +0200
In-Reply-To: <YrK+sjPSFRxX4XAM@kili>
References: <YrK+sjPSFRxX4XAM@kili>
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

On Wed, 2022-06-22 at 10:03 +0300, Dan Carpenter wrote:
> The patch d648c23024bd: "wifi: nl80211: support MLO in auth/assoc"
> from May 31, 2022, leads to the following Smatch complaint:
>=20
>     net/wireless/mlme.c:328 cfg80211_mlme_assoc()
>     warn: variable dereferenced before check 'req->bss' (see line 324)
>=20
> net/wireless/mlme.c
>    323=09
>    324		err =3D rdev_assoc(rdev, dev, req);
>                                             ^^^
> req->bss dereferenced inside the function call
>=20
>    325		if (!err) {
>    326			int link_id;
>    327=09
>    328			if (req->bss) {
>                             ^^^^^^^^
> Check for NULL is too late
>=20

I was writing why all of this is correct but now I realized that
literally in rdev_assoc() we dereference it ... that's obviously
garbage, I need to adjust the tracing for all of this.

But anyway I should move that into the tracing.

For now this is fine because you can't get here with req->bss =3D=3D NULL
(which would imply req->link[i] !=3D NULL for some value(s) of i) because
no driver advertises MLO support.

Thanks for the report!

johannes
