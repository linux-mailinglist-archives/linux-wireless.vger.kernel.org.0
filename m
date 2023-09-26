Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D137AE97B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjIZJm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 05:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjIZJm6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 05:42:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F98B3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=J07PKgzvHv9pru8vLLpOFovCpNHRFFMR8SOnLLFgFZk=;
        t=1695721372; x=1696930972; b=n2V2LflF5itWd0702t/uwW75vlJq2ZrUTpWPQBliRz5bksu
        ua1mFtLuv7mA6Bxg4+6t3QqHDmexNowDg81KsW22Dr/dZl1waEKGgZvi+RAkpJSGsOei5VMC4aQQM
        rUytRoqmEAjjPmHrsFeMB/dv3ataYiCGGjAY2oxDqunykPEHZ/fwqWJgiGnoKpPLuWC8pkb52pug2
        3NrkQZ/jdqPXucfL1FxYwIP50LdwLR6nSuF7QpCYUxZ8heZ4FT+HNMO7TaHHHp8YT9NtCEOWwMhgj
        u60TIZEFN0xovg+5LuP+eLBaoKNje3yythIWyMzTAbhXdTEbwehE73eUJfXTynrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ql4ac-005RdD-1M;
        Tue, 26 Sep 2023 11:42:46 +0200
Message-ID: <d42b46d628c1d0d09d8772f19cec0b572251c02b.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] wifi: mac80211: update link RX NSS by
 ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 Sep 2023 11:42:45 +0200
In-Reply-To: <7e350410-0e45-910d-68db-ea1d85df958a@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
         <20230906103458.24092-4-quic_wgong@quicinc.com>
         <e6ea3009c489fae910adbf2e1c766f2d827f287f.camel@sipsolutions.net>
         <7e350410-0e45-910d-68db-ea1d85df958a@quicinc.com>
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

On Fri, 2023-09-15 at 15:53 +0800, Wen Gong wrote:
> On 9/13/2023 5:04 PM, Johannes Berg wrote:
> > On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
> > > Currently for MLO connection, only deflink's rx_nss is set to correct
> > > value. The others links' rx_nss of struct ieee80211_link_sta is
> > > value 0 in ieee80211_set_associated(), because they are not pass into
> > > ieee80211_sta_set_rx_nss() in mac80211 except the deflink in
> > > rate_control_rate_init(). This leads driver get NSS =3D 0 for other l=
inks.
> > > Add the ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link(),
> > > then the other links' rx_nss will be set to the correct value.
> > This is pretty much true, but I also think it's problematic the way you
> > phrase it. Software rate control is pretty much, at least currently,
> > _not_ supported for MLO (and I don't really see how to support it, if
> > firmware picks the link to transmit on, as it probably should).
> >=20
> > Thus, I'm not even sure we should be calling rate_control_rate_init().
> > Clearly we do today, but it's also obviously wrong for everything excep=
t
> > the call to ieee80211_sta_set_rx_nss().
> >=20
> > So while I agree that there's a problem with the RX NSS, I disagree tha=
t
> > this patch is the right way to fix it. Yes, it also fairly obviously
> > fixes the problem, but it just makes an existing design problem worse.
> >=20
> > Please change change the overall design here so that
> > ieee80211_sta_set_rx_nss() isn't related to rate control at all.
> >=20
> > johannes
> So should I delete ieee80211_sta_set_rx_nss() in rate_control_rate_init()=
,
> and add it into ieee80211_assoc_config_link() as you said before here?
> https://lore.kernel.org/linux-wireless/ca0f6ea2d78538ffb6640f2e56d65c89c8=
6f5221.camel@sipsolutions.net/

I think that would make sense. After all, rate_control_rate_init() is
related to the software rate control which isn't really supported with
MLD, and the NSS init is unrelated, it's just updating a piece of per
(link) station data.

> I checked the git log, ieee80211_sta_set_rx_nss() is added into
> rate_control_rate_init() here for VHT, so is it correct to delete
> ieee80211_sta_set_rx_nss() in rate_control_rate_init()?
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=
=3D8921d04e8df7475d733d853564bdb001e83bf33f
> >=20

Well we'll have to call it appropriately when rate_control_rate_init()
is called today, and then the new places in your patch, I guess.

But I per the above that makes more sense semantically, since we don't
support software rate control on link stations.

johannes
