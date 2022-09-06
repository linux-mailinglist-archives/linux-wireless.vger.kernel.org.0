Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2213A5AE110
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiIFH2Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiIFH2X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 03:28:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A9A72B7F
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 00:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2YPH9zMFuRrlBRlqLuQlNT3BPy/7LG5BRdb35alfqwo=;
        t=1662449300; x=1663658900; b=l7xpKR5jZpkyBbSDdNW6jcS4m3Zr/RWo2fGZd0EQxfihDVI
        4gnt809tIYkn6xOLMmb66Tiq+8YnlniajqYfQdXkaBQzkkcZNAkt5DU4D5n8Dmzyxwwe3QpG/yqPz
        gn1leBGM9dtRNft6Q42INWGuDvb4pwC8P7AByTven2csy7BMP3LE+CATdZq+1IMx1h7uXJ5+dSKaD
        59Axikst/a/SUa1GvnpydwVotLJ7LgtZlFWVoaafa8G6Uxerk+nP6a5e4Oi9ssWonOlaPpZWw651+
        ZQeFh5pTLBt2VB79bJBhkruX0MiwwJVVEMDQ5zhMKxNcxBB8uZO2x3JFmrNvyTRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVT0L-009JTJ-1X;
        Tue, 06 Sep 2022 09:28:17 +0200
Message-ID: <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
Subject: Re: [PATCH 00/27] another set of MLO patches
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Date:   Tue, 06 Sep 2022 09:28:16 +0200
In-Reply-To: <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

> The 3 commit below=C2=A0

> wifi: mac80211: mlme: transmit assoc frame with address translation
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.gi=
t/commit/?h=3Dmld&id=3D4ca04ed36478e21b037fc379a7e6f52d0e6d8d52
>=20
> wifi: mac80211: support MLO authentication/association with one link
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.gi=
t/commit/?h=3Dmld&id=3D81151ce462e533551f3284bfdb8e0f461c9220e6
>=20
> wifi: mac80211: do link->MLD address translation on RX
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.gi=
t/commit/?h=3Dmld&id=3D42fb9148c078004d07b4c39bd7b1086b6165780c


(Just noting that they're not part of this patchset, they were there
before)

> changed to use MLD address for send=20
> authentication/assoc request for station and
> changed to use MLD address of rx management packet include=20
> authentication/assoc response received by station from AP.

Yes.

> Does it has any description about the MLD adress in authentication/assoc=
=20
> request/assoc response in IEEE P802.11be=E2=84=A2/D2.0 or other sepcifica=
tion?

Not _really_. I don't think the spec ever really talks about this since
it simply doesn't (need to) care what you do inside your software stack.

However, I believe there are (or will be) cases where even for
management frames we will not want to make a determination which link to
use to transmit - since they're "addressed to the MLD" (see D2.0 35.3.14
Multi-link device individually addressed Management frame delivery).

Note also that for protected management frames, the MLD addresses become
part of the AAD.

Today, auth/assoc frames cannot be encrypted (though that may quite
possibly change for assoc frames in the future), and for them also only
a single link can be selected.

However, I thought that from a software POV it would still be better if
as many MLD-addressed frames actually carried MLD addresses in the
software stack as possible, to unify things with the encryption
requirements etc.

The only exception to this is the first received authentication frame on
the AP which cannot be translated in the stack/driver/firmware since we
don't have a station entry for the new station yet, so hostapd has to be
prepared to handle that very first frame with link addresses.

johannes
