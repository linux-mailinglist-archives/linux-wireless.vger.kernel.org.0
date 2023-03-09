Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A716B2CC1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCISRZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 13:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCISRY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 13:17:24 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB6F7EEF
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 10:17:21 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 016D320002
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 18:17:19 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     linux-wireless@vger.kernel.org
Subject: brcm/brcmfmac4356-pcie.bin failed with error -2
Date:   Thu, 09 Mar 2023 19:17:10 +0100
Message-ID: <2716728.5R3jveeIG6@prancing-pony>
Organization: Connecting Knowledge
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13977443.ktRbgDNSCm";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart13977443.ktRbgDNSCm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: linux-wireless@vger.kernel.org
Subject: brcm/brcmfmac4356-pcie.bin failed with error -2
Date: Thu, 09 Mar 2023 19:17:10 +0100
Message-ID: <2716728.5R3jveeIG6@prancing-pony>
Organization: Connecting Knowledge
MIME-Version: 1.0

Hi,

In https://bugs.debian.org/1032367 we have a user who reported that the
brcm/brcmfmac4356-pcie.bin firmware file failed to load with a new firmware-
brcm80211 package, while it succeeded with an old one.

In https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/ 
I found 2 commits that seem relevant:
- 04f71fe564552c22dc7ece0d2b8afc11b33de392 where various cypress firmware and 
clm_blob files (including 4356) were added to the *cypress* directory.
- 0f0aefd733f70beae4c0246edbd2c158d5ce974c which removed old brcm firmware files 
that have a newer cypress variant ...  from the *brcm* directory.

So in essence a bunch of firmware files were moved from 'brcm' dir to 'cypress'.

I don't know how the firmware file loading mechanism works, but could it be that 
it (also) needs to look in the new (cypress) location for those files?

Or is the issue somewhere else (f.e. in Debian)?

Cheers,
  Diederik
--nextPart13977443.ktRbgDNSCm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZAoipwAKCRDXblvOeH7b
bk1AAQDfTOsU1jiEDX7Aq2/p/WsE7gUppd4tWF9eR49UsAr1GQEAstT1lVcIU+BW
i4fNfkYwfQ/wC4TKqEtht5GIMjy4zgk=
=0SZQ
-----END PGP SIGNATURE-----

--nextPart13977443.ktRbgDNSCm--



