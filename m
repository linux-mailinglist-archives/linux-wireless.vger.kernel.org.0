Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA11ECD94
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFCKbW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 06:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFCKbV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 06:31:21 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54BF20679;
        Wed,  3 Jun 2020 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591180280;
        bh=pm0NKigE///7cT4gXPSKKK49ItkCS9WUor6GvW/MGCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClMbU7w/G+SuuQykfllcHdxtG/9Ur6TAEzdPwGcwKrsQBAvVif/Tc6HHQbkev3eZl
         aWhfmCHa9u3wREU3fkN+wlh1UoGDJwt1K75aO2jYkvYeXFhwAgN0KSfrdB7aNmGEGG
         HJ8uQEQiFI9qUv9MIxp2gB4xKrnGP7aHZAjvH8/U=
Received: by pali.im (Postfix)
        id 4D4956F0; Wed,  3 Jun 2020 12:31:18 +0200 (CEST)
Date:   Wed, 3 Jun 2020 12:31:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     David Lin <yu-hao.lin@nxp.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Steve deRosier <derosier@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chor Teck Law <chorteck.law@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9] Add new mac80211 driver mwlwifi.
Message-ID: <20200603103118.av625inuqyfdjfgk@pali>
References: <CACna6rzKWAz_xxi=ehKijGtM4XEcioSjwmb=V0rq_vKioiS=Ew@mail.gmail.com>
 <3e57f30c29254db4a906e3e71ac36da5@SC-EXCH02.marvell.com>
 <CALLGbRJ9h5fvS+DLOBGTcejW8yiwFW-xey+TaubauH2rZuVWwQ@mail.gmail.com>
 <def0e631e44d4b44a87124a5b530d6ec@SC-EXCH02.marvell.com>
 <CACna6rz8chrPU+yZC0xakKVeLFm8fgpDoSFP_Vyo8mH1C+DCzQ@mail.gmail.com>
 <8492870c897543a1b3c635a96f1066cb@SC-EXCH02.marvell.com>
 <CACna6rwE1YE6bokFehgRNsyRGNGORbrYcnuUR-df286h0K4KXw@mail.gmail.com>
 <4b33da1fb23a476ca5bc21eb74f1ffd2@SC-EXCH02.marvell.com>
 <CACna6rwXq2PJmNxX8j9V2yMTtCeFHf5-GrjcA-U8A1bPW9pqPg@mail.gmail.com>
 <20200519151208.g35qpxdtroedjma7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519151208.g35qpxdtroedjma7@pali>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(resending email, now with correct David's NXP email address)

On Tuesday 19 May 2020 17:12:08 Pali Rohár wrote:
> On Wednesday 21 November 2018 09:24:55 Rafał Miłecki wrote:
> > On Wed, 8 Feb 2017 at 08:55, David Lin <dlin@marvell.com> wrote:
> > > > From: Rafał Miłecki [mailto:zajec5@gmail.com] worte:
> > > > On 8 February 2017 at 08:28, David Lin <dlin@marvell.com> wrote:
> > > > >> From: Rafał Miłecki [mailto:zajec5@gmail.com] worte:
> > > > >> Sent: Wednesday, February 08, 2017 3:24 PM On 8 February 2017 at
> > > > >> 07:30, David Lin <dlin@marvell.com> wrote:
> > > > >> > steve.derosier@gmail.com [mailto:steve.derosier@gmail.com] wrote:
> > > > >> >> On Tue, Feb 7, 2017 at 10:15 PM, David Lin <dlin@marvell.com> wrote:
> > > > >> >> >> Rafał Miłecki [mailto:zajec5@gmail.com] wrote:
> > > > >> >> >> Please use ieee80211-freq-limit:
> > > > >> >> >> https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git
> > > > >> >> >> /co
> > > > >> >> >> mmi
> > > > >> >> >> t/?id=b3
> > > > >> >> >> 30b25eaabda00d74e47566d9200907da381896
> > > > >> >> >>
> > > > >> >> >> Most likely with wiphy_read_of_freq_limits helper:
> > > > >> >> >> https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git
> > > > >> >> >> /co
> > > > >> >> >> mmi
> > > > >> >> >> t/?id=e6
> > > > >> >> >> 91ac2f75b69bee743f0370d79454ba4429b175
> > > > >> >> >
> > > > >> >> > I already replied meaning of these parameters:
> > > > >> >> > <marvell,2ghz> is used to disable 2g band.
> > > > >> >> > <marvell,5ghz> is used to disable 5g band.
> > > > >> >> > <marvell, chainmask> is used to specify antenna number (if
> > > > >> >> > default number
> > > > >> >> is suitable for you, there is no need to use this parameter).
> > > > >> >> > <marvell,powertable> should not be used for chip with device
> > > > >> >> > power
> > > > >> table.
> > > > >> >> In fact, this parameter should not be used any more.
> > > > >> >> >
> > > > >> >>
> > > > >> >> David, I think you're not understanding the comment, or at least
> > > > >> >> that's what it looks like to me. Yes, you did reply as to the meaning.
> > > > >> >> And, your reply, while informative, didn't tell us you understood
> > > > >> >> and were willing to fix the problem. I doubt you meant it this
> > > > >> >> way, but it feels defensive and like a brush-off.
> > > > >> >>
> > > > >> >> First off, you will still have to document any DT bindings you're
> > > > >> >> adding. Just because you answer the question in the review doesn't
> > > > >> >> mean you're not responsible for doing so.
> > > > >> >>
> > > > >> >> And second off, I think that Rafal (and sorry about my spelling,
> > > > >> >> looks like there's some sort of accent on the l that I don't know
> > > > >> >> how to make my keyboard do) is saying: there's already some
> > > > >> >> generic bindings that can be used to disable the 2g or 5g bands.
> > > > >> >> Granted they're even newer than your patch, but I do think if said
> > > > >> >> bindings exist and
> > > > >> are appropriate, you should use them.
> > > > >> >>
> > > > >> >> - Steve
> > > > >> >
> > > > >> > These parameters are marvell proprietary parameters, I don't think
> > > > >> > it should
> > > > >> be added to DT bindings.
> > > > >>
> > > > >> Steve is correct.
> > > > >>
> > > > >> You have to document new properties, just because they are Marvell
> > > > >> specific doesn't change anything. You just document them in a proper
> > > > place.
> > > > >>
> > > > >
> > > > > All right. I will do that.
> > > > >
> > > > >>
> > > > >> > BTW, <marvell,2ghz> and <marvell,5ghz> are only used for mwlwifi to
> > > > >> > report
> > > > >> supported bands, it is not related to limitation of frequency.
> > > > >>
> > > > >> How reporting a single band doesn't limit reported frequencies? You
> > > > >> can achieve exactly the same using generic property, so there is no
> > > > >> place for Marvell specific ones.
> > > > >>
> > > > >> In fact there were drivers of 3 vendors requiring band/freq-related
> > > > >> description in DT: Broadcom, Marvell & Mediatek. This property was
> > > > >> discussed & designed to support all limitation cases we found
> > > > >> possible to make it usable with
> > > > >> (hopefully) all drivers.
> > > > >>
> > > > >
> > > > > I only need simple way to disable 2g or 5g band. I will follow your suggestion
> > > > to document these marvell proprietary parameters.
> > > >
> > > > Seriously? Refusing to use generic binding because you think marvell,5ghz; is
> > > > simpler than ieee80211-freq-limit = <2402000 2482000>; (not to mention your
> > > > property seems reversed!)?
> > > >
> > > > I don't know how else to explain this to you. We don't want duplicated
> > > > properties where one can work. Just use existing one. Don't add new one even
> > > > if documented.
> > > >
> > >
> > > All right. I will check and let patch v10 to use it. For previous parameters, they will only be used by previous OpenWrt projects.
> > 
> > Hi David, how are things going? Could we get v10?

Hello! I would like to ask, is there any plan for future updates for this mwlwifi softmac driver?
