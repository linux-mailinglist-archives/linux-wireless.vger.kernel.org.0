Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435F7AFB92
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjI0HAq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 03:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjI0HAm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 03:00:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AF5198
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PdbCbAzO5QXxKSMwQQ5K2AOCdBgYiDiJfobjzUikv8k=;
        t=1695798040; x=1697007640; b=Bbyn4Nmi/Hn+r2038Q0P0FTTBcKvho6NcJ256Si5H4NTBVe
        7m2tLPOFHumoIvnSJ9gG+tvb5BPXd9k9XQZY5yCQl798j7ogZRCX743by67jb24eFWI5KSXKj4+O5
        mwL3KTD4xViCvMi6YDpQ6l/xklx3D/eoXbjTBAgeEaGpv3Z5/qXxnOiRKi7tac0gGG5n3UGTihSO5
        W3r/gZNrJccNk6HTdn5kYssWvyxE2d65RLQb3wAWwQcIdHfK1wGMgr7K06PaEJKu4/CRoWC8dNSzt
        TW8KRjmNWfxM+fpivRTQN+KvDMAbO/jMqzQ4nhsk/Te61RJW2uRCezLEi8yzSVjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qlOXE-007Ht7-1R;
        Wed, 27 Sep 2023 09:00:36 +0200
Message-ID: <9a544a1b9385a150f779ac35a780dbb50200a962.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: remove set_fils_aad support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 27 Sep 2023 09:00:35 +0200
In-Reply-To: <9ddcbc2f-5e40-48cd-bdbd-943bd86acb61@quicinc.com>
References: <20230926160950.d698c25528e3.If118a835a25c59de20e1728ab71949fdb4172fb2@changeid>
         <9ddcbc2f-5e40-48cd-bdbd-943bd86acb61@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-09-26 at 13:35 -0700, Jeff Johnson wrote:
> On 9/26/2023 7:09 AM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > There's no user for this, so remove the support.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> if you are going to remove it, why not just revert e306784a8de0=20
> ("cfg80211: AP mode driver offload for FILS association crypto") to make=
=20
> sure you get all of the artifacts? for example, I believe your patch=20
> will leave behind an unused struct cfg80211_fils_aad and unused=20
> FILS_AAD_ASSIGN() trace helper macro.

Hah, good point, I didn't do this well.

> the caveat to reverting is that it should only be a partial revert; the=
=20
> UAPI definitions would need to be retained (and should be documented as=
=20
> obsolete).

Yeah, that's why I didn't do it as a revert.

> however, let me check to make sure there is no plan to actually utilize=
=20
> this interface upstream. as i've indicated earlier, we are in the=20
> process of trying to transition to an "upstream first" mentality, but=20
> this is not going to happen overnight, but instead will take years. that=
=20
> said, i'd hate to rip out an interface now just to need to add it back=
=20
> in the future.

Sure. I don't mind keeping something around that really _has_ a future,
but it's been two years and nobody showed up ... but yeah, I also think
that "has a future" means upstream.

And clearly the old "other people can use it" argument doesn't work any
more either, the only other vendors who are doing something in AP mode
are Mediatek and maybe to some extent Realtek, and they all work on top
of mac80211 with thinner firmware. Broadcom has disappeared as far as I
can tell, with the occasional patch like recently that I'm also
suspecting serves pure out-of-tree driver purposes...

johannes
