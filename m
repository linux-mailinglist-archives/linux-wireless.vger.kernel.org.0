Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695636DD94F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 13:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDKLYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 07:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjDKLYn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 07:24:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1670E3C25
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aGauEiHqVA7QiQ97Qr+6UKOHPx0gVf8dVIWyTskmRwE=;
        t=1681212279; x=1682421879; b=scIGKx4qF3aHq3p8pwA1rbiChj7EcwDFZX73KI7i+TIOdIY
        gbFCRFYM5EBcCcKiwPRwDL89agGcYbUL3LCP5QyQV30xhLO2a+G+Kn96jMX6XcW8qYH4gpc13IjDF
        NcF2lN2UowadVssA389dMmfEL7whZHD9xNU4gHktk6U35eX5vGd/5z1AuLmwGb9wOvz6Vwxphdlal
        mHO6o9uSzvGK6KDcUozqB+4dSYQU9paeud9/Jle+s44jQUwzLitHgzoJRQmWNvu8G5861WllyrucH
        241e4ewX/KoZeCcUVvXZ/0L13pc20Ld8QIn4iuBnpRZEs3Lb8rS0lHjknOZyGN8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pmC72-00ChVj-1e;
        Tue, 11 Apr 2023 13:24:36 +0200
Message-ID: <a91e755bf3aee9ed7fcd5dd4d8ba5b315312c22b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: wilc1000: fix kernel oops during interface down
 during background scan
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michael Walle <michael@walle.cc>, Ajay.Kathat@microchip.com,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, mwalle@kernel.org
Date:   Tue, 11 Apr 2023 13:24:35 +0200
In-Reply-To: <f10d69fb17e03eb093d846d005d7496a@walle.cc>
References: <20230404012010.15261-1-ajay.kathat@microchip.com>
         <f10d69fb17e03eb093d846d005d7496a@walle.cc>
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

On Wed, 2023-04-05 at 13:40 +0200, Michael Walle wrote:
>=20
> wilc_disconnect() is called from the cfg80211_ops::disconnect
> callback. wilc_deinit() is called from net_device_ops::ndo_stop.
> Is there any lock which prevents both functions be called in
> parallel?

I don't _think_ there's any common lock, ndo_stop() holds the RTNL, but
cfg80211 for a normal nl80211 disconnect command will only briefly hold
the RTNL and drop it again before calling into the driver.

The internal flags here don't indicate requiring RTNL and that wouldn't
make much sense either:

        {
                .cmd =3D NL80211_CMD_DISCONNECT,
                .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDAT=
E_DUMP,
                .doit =3D nl80211_disconnect,
                .flags =3D GENL_UNS_ADMIN_PERM,
                .internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
        },


See commit a05829a7222e ("cfg80211: avoid holding the RTNL when calling
the driver").


johannes
