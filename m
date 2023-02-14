Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C570A696725
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 15:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjBNOl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 09:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjBNOlZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 09:41:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1632119
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 06:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bcZxwNGF+gM8pPpuJg6Cbw+YGM7dLzAMCe05mZZE3Gs=;
        t=1676385685; x=1677595285; b=QYryiieBfPun5RyNx5fJSML1JJzntXsXKvliTiRIEpgfNMM
        g72WrIAnOzKesjyG17HeVj8ZIBEeONS7e7+73wPYIP39hUpkQogTCZrSRN9mBNlRZencDwx/k67oW
        UtD9egrcZ8Pi/nk8zuOt0tyveQpQc9C8/Iu9E21UaFxMUHAeUCJpAHnY629Qol8wB3nvSGk5tvw2x
        bJg5GD4yEMxVJh6eVAq0+tHZB47RHPVWceouxi7qhWmO5uDp+1PgzT1ovyT0UZG9sBtcuq4cU9HAU
        BjnA3FOobWUdbykjApZP0qsN4wpUe9pKpkaD762Jt/oU+BDLAGDWvDitkuwRa/3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRwUf-00CBEN-0p;
        Tue, 14 Feb 2023 15:41:17 +0100
Message-ID: <f5ffcc0b186cf9285e1dedebc8cf47c06d46bbd9.camel@sipsolutions.net>
Subject: Re: [PATCH v10 3/5] cfg80211/mac80211: move interface counting for
 combination check to mac80211
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        Luciano Coelho <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     michal.kazior@tieto.com, sw@simonwunderlich.de,
        andrei.otcheretianski@intel.com, eliad@wizery.com,
        ath11k@lists.infradead.org
Date:   Tue, 14 Feb 2023 15:41:16 +0100
In-Reply-To: <6c2b5e49-2cdc-b506-e3c8-0a51fccc294d@quicinc.com>
References: <1394547394-3910-1-git-send-email-luciano.coelho@intel.com>
         <1394547394-3910-4-git-send-email-luciano.coelho@intel.com>
         <4de1f964-b623-2b31-c044-60cc188fc134@quicinc.com>
         <6187b1566674ba2e0d7d5413af5475688d8421b3.camel@sipsolutions.net>
         <6c2b5e49-2cdc-b506-e3c8-0a51fccc294d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Tue, 2023-01-10 at 15:23 +0800, Wen Gong wrote:
> On 1/9/2023 6:05 PM, Johannes Berg wrote:
> > On Mon, 2023-01-09 at 17:39 +0800, Wen Gong wrote:
> > > On 3/11/2014 10:16 PM, Luciano Coelho wrote:
> > > > ...
> > > > +int ieee80211_check_combinations(struct ieee80211_sub_if_data *sda=
ta,
> > > > +				 const struct cfg80211_chan_def *chandef,
> > > > +				 enum ieee80211_chanctx_mode chanmode,
> > > > +				 u8 radar_detect)
> ...
> > > > +
> > > > +	if (total =3D=3D 1 && !radar_detect)
> > > > +		return 0;
> > > > +
> > > should also check with cfg80211_check_combinations() when total =3D=
=3D 1 and
> > > num_different_channels > 1 ?
> > >=20
> > > When MLO is enabled, it could have 2 channels for one ieee80211_sub_i=
f_data.
> > >=20
> > Heh. You're commenting on a patch from 2014, well before MLO :-)
> >=20
> > Not sure what happens in the code now?
> >=20
> > johannes
> Yes, it is 2014. Each interface only has one channel at 2014.
> I did not hit issue for the code.
>=20
> the story is like this:
> When station interface and p2p device interface both running.
> the station connect to MLO AP which has 2 links.
> The ieee80211_link_use_channel()/ieee80211_check_combinations() call=20
> cfg80211_check_combinations()
> for the channel1 and channel2 because total=3D=3D2.
> When only station interface is running, not called for channel1/channel2=
=20
> because total=3D=3D1.
> That is the little thing I hit.
>=20

So ... I guess you found a bug? Not sure what I'm supposed to say here.
Send a fix?

johannes
