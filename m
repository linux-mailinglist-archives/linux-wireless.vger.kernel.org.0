Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E72D73A642
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFVQlW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFVQlV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:41:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F0F1BF7
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZInLCT6H7j05FEcvDUb75tPJKJHmh6+6Gsy7X8bW39I=;
        t=1687452080; x=1688661680; b=KfOBWrMoyhUe3QfImKQKTfdY916pwt5zQBPXm+CRO+75kuo
        OWC3u494ron0VPbeBAjkrfCLICRhrZSSteIVnrupaMnUOJMF+QnIKmz0GcGMGN7NVgSu//HHYVbHk
        0/WD7vbvXHOi8+84KOBVPV+9oNzDtbwmc+ygKyO+XTADNiYSG2KRzI+aj5ec61m03RKBdsYtYiZQG
        YB9oSEuBL1lIyPNCmxCjf6kP0QqCDX5tErAHs7G6g36FgxCCdv4sBzU+dkW7l33kiJl4SMOpkaM/B
        as9m5rSXIUCg9A3yeYDKACQRG+cP2NbmGdLqqFmLTxqN+/Nuv8LPgcFUW2b9VrLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qCNN0-00Eosz-0M;
        Thu, 22 Jun 2023 18:41:18 +0200
Message-ID: <f717c60c24bf3dcec7cd3b0308c6bd804683276a.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: fix sband iftype data lookup for AP_VLAN
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Thu, 22 Jun 2023 18:41:17 +0200
In-Reply-To: <2815ff55-5b5d-1412-5694-7692337bc473@nbd.name>
References: <20230622160501.40666-1-nbd@nbd.name>
         <adf8c1b8ea96c0c6ddc12579eacb8d9948440dcf.camel@sipsolutions.net>
         <2815ff55-5b5d-1412-5694-7692337bc473@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Thu, 2023-06-22 at 18:25 +0200, Felix Fietkau wrote:
> On 22.06.23 18:07, Johannes Berg wrote:
> > On Thu, 2023-06-22 at 18:05 +0200, Felix Fietkau wrote:
> > > Since AP_VLAN interfaces are not pushed to the driver,=20
> > >=20
> > That's a mac80211 thing though.
> >=20
> > > the driver should not
> > > be expected to register iftype data for them.
> > > Map them to the regular AP iftype on lookup.
> >=20
> > And this is in cfg80211 - not sure that seems right?
> >=20
> > OTOH I'd expect no callers with VLAN here, it doesn't really make sense
> > since they're not a standalone mode that actually has HE/EHT, but still=
,
> > seems odd this way?
> >=20
> > What's actually calling it? I'm guessing somewhere in mac80211?
>=20
> Yes, I guess only mac80211 is affected. I put in the cfg80211 prefix
> because that's what the header file belongs to.
>=20
> I made the patch in response to this:
> https://patchwork.kernel.org/project/linux-wireless/patch/20230605152141.=
17434-4-shayne.chen@mediatek.com/

OK, sure, that also doesn't really make sense.

> I found that there are several calls to ieee80211_get_he_iftype_cap and
> ieee80211_get_eht_iftype_cap, which could be affected by this issue.
> I thought dealing with this in a single place would be better than playin=
g
> whac-a-mole by fixing it at the call sites.
>=20

I replaced almost all of them with ieee80211_get_he_iftype_cap_vif() so
it shouldn't be that bad? Looks like I forgot some though.

johannes
