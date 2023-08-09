Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841607768D0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 21:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjHITfF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjHITfB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 15:35:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42ABC6
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=X+Kpq2zjjsFSoR59RdAfVfIgy0ABJrR1nvmfTCb2rY8=;
        t=1691609700; x=1692819300; b=qMXkpDP3jABG9kYwgRSYNqf+9Ke8EkMs6OtII/wxZzOsy/f
        8rPd94816KcJzi5LJl2tHXFYT9j10/1fJ8NNqoxp15VW6drbCZ95/mZdOl7MhaE8u9RJkNA4Eikun
        11hkcBuRawjqGYSsy+FM0fgdPFOuiRz8+0FCSWvYnQ/aIhmI7FUfvYR0gPTo9QNGyVo4OEnOScu1t
        4xdLb+u5tK03QE02kvOqy1YZP4HSn5jyuvNStWIxpxOmCr2NO7RIZWMJhll2il8YLQ81TRqxpv7KH
        5Scx6Ycvd3YSL3EcC0lrEkSY2GRv6VKyjz/tcD/961LCMNrSMfNgn8Tv/5jvFX7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qToxO-00F2r4-1f;
        Wed, 09 Aug 2023 21:34:58 +0200
Message-ID: <d14e88a69c9ed48e46058299cf3136467ba6e054.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: add eht_capa debugfs field.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 09 Aug 2023 21:34:57 +0200
In-Reply-To: <37a24557-2562-4891-e7ec-18b5527a54f0@candelatech.com>
References: <20230519162324.1633120-1-greearb@candelatech.com>
         <1038a5fd7d658cc29d11a6eb8776255c50e8226c.camel@sipsolutions.net>
         <e81d4d8d-8076-00cc-cb72-8417dc8203ce@candelatech.com>
         <559120af6ed8cdfdee7eaa83531b35de2ce24a0f.camel@sipsolutions.net>
         <37a24557-2562-4891-e7ec-18b5527a54f0@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-09 at 12:32 -0700, Ben Greear wrote:
> On 6/14/23 13:08, Johannes Berg wrote:
> > On Wed, 2023-06-14 at 09:39 -0700, Ben Greear wrote:
> > > On 6/14/23 01:29, Johannes Berg wrote:
> > > >=20
> > > > > +	/* TODO:  Fix and re-add this.  It compiles in 6.4 but not agai=
nst 'next'
> > > > > +	 * according to the kernel build bot.
> > > > > +	 * PFLAG(PHY, 5, SUPP_EXTRA_EHT_LTF, "SUPP-EXTRA-EHT-LTF");
> > > > > +	 */
> > > > >=20
> > > >=20
> > > > Well that's because the spec version was updated in wireless-next :=
)
> > > >=20
> > > > So please adjust according to the new fields there.
> > >=20
> > > It will be some time before I get a chance to revisit this.  If you c=
an
> > > accept as is, I'll fix the remaining bits when I move to 6.5 or whate=
ver
> > > mainline kernel has the updated spec.
> > >=20
> >=20
> > Actually I think it was just this field, so maybe I can just take v1.
>=20
> After doing some more detailed testing, I notice that this capa logic is =
using
> the AP's capability list, and is not showing lowest common features.  For=
 instance,
> a 2x2 STA radio shows as this when connected to 4x4 AP:
>=20
> ...
> 		EHT bw <=3D 80 MHz, max NSS for MCS 8-9: Rx=3D4, Tx=3D4
> 		EHT bw <=3D 80 MHz, max NSS for MCS 10-11: Rx=3D4, Tx=3D4
> 		EHT bw <=3D 80 MHz, max NSS for MCS 12-13: Rx=3D4, Tx=3D4
> 		EHT bw <=3D 160 MHz, max NSS for MCS 8-9: Rx=3D4, Tx=3D4
> 		EHT bw <=3D 160 MHz, max NSS for MCS 10-11: Rx=3D4, Tx=3D4
> 		EHT bw <=3D 160 MHz, max NSS for MCS 12-13: Rx=3D4, Tx=3D4
> 		EHT bw <=3D 320 MHz, max NSS for MCS 8-9: Rx=3D4, Tx=3D4
> 		EHT bw <=3D 320 MHz, max NSS for MCS 10-11: Rx=3D4, Tx=3D4
> 		EHT bw <=3D 320 MHz, max NSS for MCS 12-13: Rx=3D4, Tx=3D4
>=20
> I would expect it to show Rx=3D2, Tx=3D2 in this case.
>=20
> Any opinions on how or whether to change this?  Do we already store a com=
bined
> capabilities list somewhere in mac80211 for EHT?
>=20

We did this for HT and VHT, and then kind of stopped for HE because it
got so asymmetric and complicated ... it ended up easier for drivers to
do it because they have their own hardware limitations and all and know
what they may or may not advertise, and mac80211 would have to do it
_all_. Yeah, not ideal either. So dunno. I wouldn't mind the logic I
guess and we could probably remove stuff from the drivers, but either
we'd have to be really careful about what we do and don't handle, and
probably check that against what drivers have, or handle everything
which gets difficult.

johannes
