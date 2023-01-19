Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AAD674355
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 21:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjASUMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 15:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASUML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 15:12:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4B9373F
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NjDq1H3yfOYs/qcxDGqFjJT9MmOnVktdBhpgsoQ39rQ=;
        t=1674159129; x=1675368729; b=DdoVzqpLzYRPM6vvKZKxI+cyM2ajPalcTUmsDoVbt7iw4L3
        aF32cL88y8q3cw2ZE6P0j4u6LvIS2bNVLg/XnvQSqiMkZd0Xs7nAofOncBJt6v15XqkemSzduxZcD
        Bpdc1BJF8W9eoWYT5Gun4wVQs/lZIVk6EuEDgqZANj3w1Cz+u1bfdH8/s4AdbqSFpep7BdR9NVnRd
        fexkcGAa/0dlyFK8ih/Sb0WLPb6wOQzfZug+pzY3z4CLBU6xbgeEHJ44hrl4hnnmh3Xv7VdGSepHQ
        kfJ1jrc2pI/hP6w55RwObEIwQ76xV18Ab3tJfGg6bV7inB2wAIWjQr1HKOHpwqxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIbGZ-006e8X-2B;
        Thu, 19 Jan 2023 21:12:07 +0100
Message-ID: <26ef0d67db3af16853915568585767b13a73ef9a.camel@sipsolutions.net>
Subject: Re: [PATCH v7 2/3] nl80211: additional processing in
 NL80211_CMD_SET_BEACON
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 21:12:06 +0100
In-Reply-To: <9ff00d88-6d12-8ee5-aa25-a5e82879d25c@quicinc.com>
References: <20221109214720.6097-1-quic_alokad@quicinc.com>
         <20221109214720.6097-3-quic_alokad@quicinc.com>
         <0b42cfb9f0effce61b33c41ec9067b3747fade5c.camel@sipsolutions.net>
         <9ff00d88-6d12-8ee5-aa25-a5e82879d25c@quicinc.com>
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

On Thu, 2023-01-19 at 11:40 -0800, Aloka Dixit wrote:
> On 1/18/2023 7:57 AM, Johannes Berg wrote:
> > On Wed, 2022-11-09 at 13:47 -0800, Aloka Dixit wrote:
> > > FILS discovery and unsolicited broadcast probe response transmissions
> > > are configured as part of NL80211_CMD_START_AP, however both stop
> > > after userspace uses the NL80211_CMD_SET_BEACON command as these
> > > attributes are not processed in that command.
> >=20
> > That seems odd. Why would that *stop*? Nothing in the driver should
> > actually update it to _remove_ it during change_beacon()?
> > > Are you sure you didn't mean to "just" say "however both cannot be
> > updated as these attributes ..."?
> >=20
> > johannes
>=20
> FILS discovery has primary channel, center frequency in the frame format=
=20
> which should be changed depending on why the beacon changed.=C2=A0

Hmm? Sure, the frequency is important, but beacon can change for so many
other reasons? Even just the greenfield bit in HT would cause a beacon
change as far as cfg80211/mac80211 are concerned.

> Hence the=20
> current design, at least ath11k, assumes that BSS_CHANGED_FILS_DISCOVERY=
=20
> and BSS_CHANGED_UNSOL_BCAST_PROBE_RESP "not being set", when beacon is=
=20
> changed, means disable these features.
> What do you think?

I think that makes no sense? If mac80211 didn't clear struct
ieee80211_bss_conf::fils_discovery, then surely it should stick around
even if the beacon changes???

Surely you can't be right - that'd basically mean the whole feature is
useless right now because even the greenfield update or similar that
basically *always* happens in hostapd would disable it, since the beacon
changes and we don't have these patches?

> Should I send a follow-up with a different commit log?
>=20

Well seems like we need to first figure out the correct semantics here,
and possibly fix things...

johannes
