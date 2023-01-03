Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A560465BB18
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 08:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjACHHv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 02:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjACHHu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 02:07:50 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A87DEA3
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 23:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qJZlfWxkp/1m9UXQ4biuXBTqc3b4Hp2gezpakrBy610=;
        t=1672729669; x=1673939269; b=nsjw6EEffgt76sN1yoqyrY0cK2SFVZe1ZZabrWlTe4arCRe
        m46+WTugTOB/IvrmHiYa9cjhNcgCH8w+9y9qOFS1ysiIUtQgXr1xRzWK0VsfoMQ3ubJ27OTC9vfs4
        Zub9xa4r1DHEKrsTCYq2gxEf+1RXbB6pSE9vDBAkIe7i+5oL2gB/lcIrpJCeqN7LIewnUM9dwiNy+
        +J1WLMQ9s6tVe9gc5Y9CBtoL7WeMG87UjZqoTicQsEx3vav8UzariVe5ixDxiCR+Sfs5DBEkT+qJQ
        d3l+F4kb2WjsPhvL1pS2PEfVoCIqvkNHdXaLGgzsNYQvHHwxmsUBXJBypmy/jrtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pCbOh-008b8A-2y;
        Tue, 03 Jan 2023 08:07:44 +0100
Message-ID: <ee24c4eda8d389ac7197b6296944e168ccc6b602.camel@sipsolutions.net>
Subject: Re: brcmfmac: Unexpected cfg80211_set_channel: set chanspec ...
 fail, reason -52
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Date:   Tue, 03 Jan 2023 08:07:41 +0100
In-Reply-To: <1f428e2b-f73f-64ff-02d3-eefbcd11db89@broadcom.com>
References: <2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com>
         <1f428e2b-f73f-64ff-02d3-eefbcd11db89@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

Hi,


> > [=C2=A0 104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e=
 fail,=20
> > reason -52

[...]

>=20
> > All of these 10 errors are repeated every 60 sec.
>=20
> Catching up after the holidays ;-) Above chanspec values are invalid.=20
> 0x100e =3D channel 14/bw 20MHz. The 'iw list' output shows all these=20
> channels are disabled. So who/what is trying to set these channels.=20
> Scanning sets the channel in firmware. Is this initiated from hostapd?=
=20

Yeah, what userspace is running here? Looks like cfg80211_set_channel()
is only used for survey?

Couple of observations on the side:
 * might be nice to have some "brcm" indication in that name :P
 * dump_survey should just dump data, not actually implement the data
   collection, I think?


> Maybe trying ACS?=C2=A0
>=20

Seems it must be something like that.

> As these are marked as disabled user-space should not=20
> use them. What I don't understand is why these pass the cfg80211 layer=
=20
> so adding Johannes here.
>=20

Well that goes back to my earlier observation above: dump_survey()
should just dump all *available* data, not actually try to *collect*
data. So if userspace requests data for a channel that's disabled,
that's actually OK, but you shouldn't _have_ any data for that channel
since it's disabled. Also nl80211 won't send the data out if it exists,
but there's no check to see if asking the driver makes sense since if
it's a channel that exists, it should be valid to ask the driver if it
has data - it just shouldn't have any.

The way it works in mac80211 is that survey data is collected during
scan, I think?

johannes
