Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76A7504A2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jul 2023 12:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjGLKe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLKez (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 06:34:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DD61BEB;
        Wed, 12 Jul 2023 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BehkYB+NlC+IYLjEogwPvXscDT4PcOFLPYCBYNOXY10=;
        t=1689158077; x=1690367677; b=eyBbliPHyW2VF/+v8BUdFWuuIQfFWf5D7eRhYHgz/Mxcgeg
        xfQ7KD0z1r35m/M9sQTs3LoH1Bf0kOQsUk18AawBgj4jKFOz1xwGks5dsLBSMEjcEFaMbjvge0vSd
        3LpOA5FVdVEgJgwQ2zeiUQ0JrdTqGegSWuLrmiRvbFtxye1KZDUPQN1oNAHDfQjHE14dstTx3oSaW
        s26H+l4dF/896UoKwrFWSPHjv8R4WY7thSVanHvKPV5bfRbc3sUXOjmzr6FcgFncxx0wmc8AApEfB
        cMMJZTsu2wme4mk48EhkUdkqAUNgbgcb0uLsPg1fq8OQK86ww2mne41qiB+PeGgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qJXB4-00Gc0l-2S;
        Wed, 12 Jul 2023 12:34:34 +0200
Message-ID: <82b75a5e344b23a388a8f078de730272e91f99d2.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: fix mbssid nesting
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Koen Vandeputte <koen.vandeputte@citymesh.com>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>, stable@vger.kernel.org
Date:   Wed, 12 Jul 2023 12:34:33 +0200
In-Reply-To: <CAPh3n82BY0bFkHs6DKKf6+ZUZw+DJmTy7=JEG8REFHyHFMqoVQ@mail.gmail.com>
References: <20230712083841.222607-1-koen.vandeputte@citymesh.com>
         <9936de52da43347ba0ccfb8737440a9698fb4585.camel@sipsolutions.net>
         <CAPh3n82BY0bFkHs6DKKf6+ZUZw+DJmTy7=JEG8REFHyHFMqoVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-07-12 at 11:05 +0200, Koen Vandeputte wrote:
> On Wed, Jul 12, 2023 at 10:44=E2=80=AFAM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >=20
> > On Wed, 2023-07-12 at 10:38 +0200, Koen Vandeputte wrote:
> > > Executing command NL80211_CMD_GET_WIPHY and parsing it's output
> > > natively without libnl shows following attributes as part of
> > > the nl80211 generated netlink message (part 16):
> > >=20
> > > GetWiphy: Type: 1
> > > GetWiphy: Type: 2
> > > GetWiphy: Type: 46
> > > GetWiphy: Type: 33074 <-- wrong enum value, above MAX also ..
> >=20
> > That's not wrong, that's just NLA_F_NESTED | NL80211_ATTR_MBSSID_CONFIG=
,
> > since it *is* in fact a nested attribute.
>=20
> ahha! so one should check on each received attribute if this flag is set?

Yeah, that indicates that it's nested, without having the out-of-band
information that it should be nested.


There's also NLA_F_NET_BYTEORDER, so we really only have 14 bits for the
type, so you should probably use NLA_TYPE_MASK.

> I guess all the ones with the noflag so far are using it to avoid
> breaking legacy stuff?

Right. When we realized that nla_put_nested() didn't actually put the
nested flag it was kind of too late - although a lot of userspace
probably would have handled it correctly (if it uses libnl, etc.) But
still, we converted it all to nla_put_nested_noflag(), but we really
shouldn't be adding new code that calls nla_put_nested_noflag() since by
definition new code is new attributes, and then userspace can be
updated.

Unless you're saying this somehow breaks old userspace that doesn't even
understand NL80211_ATTR_MBSSID_CONFIG yet? But that seems unlikely, you
have to be prepared to see attributes bigger than what you expected and
skip them?

johannes
