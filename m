Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B836B5345B2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbiEYVS5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiEYVS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 17:18:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984CD692AD
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oW7fUStHFPngEd91cifUHwySaNsVwc/7m1V+5hOr7iQ=;
        t=1653513535; x=1654723135; b=w0yYlokG4nzdAewzGJriLI98l1K+FKIFJPkZ8qQEaTy4/sx
        xBjIdSSfnlVeF5nqEUz8fJxGrMeNB9bKrUhAR+tfA81mglNgqzyPW6B3XRu0goP396ovDcCvM5ymX
        vrAiXhPUsGB02t7C3t8XEOB3F+nRMxlUOEEc8irj6jHSLp1xoctt/MF1eYpPY35uaopPNJHmb1Sdf
        XOku+bxjET/PHjV9Yl0zn3s2+rGsh4L84u6u7/ifV8cEJfJjd9Z99fRRUBpotEbNcutgdVeGbk7Y/
        mB0L0NxY35jFGedRDlDw0OFFoV6Q+wJWLRdbPqg7pS4I5GDj4zQEz+8HvPlxS5lw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ntyOv-004Py1-3r;
        Wed, 25 May 2022 23:18:41 +0200
Message-ID: <ba0a2cec6291e700c5854e343cc72cffa249bc3f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: libertas: use variable-size data in assoc
 req/resp cmd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 25 May 2022 23:18:40 +0200
In-Reply-To: <20220525135326.1da8fe36@kernel.org>
References: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
         <20220525135326.1da8fe36@kernel.org>
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

On Wed, 2022-05-25 at 13:53 -0700, Jakub Kicinski wrote:
> On Mon, 23 May 2022 18:02:01 +0200 Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > The firmware has a 512 limit here, but we use less, so gcc
> > starts complaining about it:
> >=20
> > drivers/net/wireless/marvell/libertas/cfg.c:1198:63: warning: array sub=
script =E2=80=98struct cmd_ds_802_11_associate_response[0]=E2=80=99 is part=
ly outside array bounds of =E2=80=98unsigned char[203]=E2=80=99 [-Warray-bo=
unds]
> >  1198 |                       "aid 0x%04x\n", status, le16_to_cpu(resp-=
>statuscode),
> >       |                                                               ^=
~
> >=20
> > Since we size the command and response buffer per our needs
> > and not per the firmware maximum, change to a variable size
> > data array and put the 512 only into a comment.
> >=20
> > In the end, that's actually what the code always wanted, and
> > it simplifies the code that used to subtract the fixed size
> > buffer size in two places.
> >=20
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Is there a chance to get this into net before the merge window is over?
>=20
I guess you can just apply it. Kalle?

johannes
