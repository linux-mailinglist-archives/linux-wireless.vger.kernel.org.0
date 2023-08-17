Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14E977F672
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbjHQMa0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350905AbjHQMaL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 08:30:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF7D2D70
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=uWIz/TQERxsJBPccLJb9J3zhTd2hMHb/KA7QEhLmwC4=;
        t=1692275405; x=1693485005; b=Tbdj4md+S81fVtiv04f/H8DCh9Ufxy3sSIGyplaK5raK8Zd
        vcbV9HVp7jYEkF5YmKLFdOB2t9hKN1upqDYDw7ih8DtHsOHrN0ih7fXSTj/aHJ2G1BjDAYJXq33l/
        co5PJ0igQJqUwVCBlK7AEpf3OvwjCsQIwnh4fI53vnxYUcVVQTle9EnQyDhLFRVEHoZkp1C2uHWml
        543t108Qsw7CMutToHF3TRzRSA/IYuUu89W6O/NneW0MUqRQLVylYRn0db9QWIQc8G/t2S8sD4JCz
        Gtluad8EnQXYC1tMQagjvKPrB376daLXVw6tXtV/rFGyA3enmcg1FkW9nYiqWcbg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWc8W-00Cu8Q-36;
        Thu, 17 Aug 2023 14:30:01 +0200
Message-ID: <dda4148bb980f7f92b8092854be140e6a79e8c4a.camel@sipsolutions.net>
Subject: Re: [RFC] wifi: mac80211: fix UBSAN warning caused by
 reorder_buf_filtered bits shift-out-of-bounds
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "gregory.greenman@intel.com" <gregory.greenman@intel.com>
Date:   Thu, 17 Aug 2023 14:30:00 +0200
In-Reply-To: <408e1ca10cb4daabdad0e2760f69a9b03fbeedd3.camel@realtek.com>
References: <20230817053215.51636-1-pkshih@realtek.com>
         <d55de56e2cc69031f1588fc1db981f5bed640348.camel@sipsolutions.net>
         <408e1ca10cb4daabdad0e2760f69a9b03fbeedd3.camel@realtek.com>
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

On Thu, 2023-08-17 at 12:06 +0000, Ping-Ke Shih wrote:
> On Thu, 2023-08-17 at 09:03 +0200, Johannes Berg wrote:
> >=20
> > >=20
> > > If not, we can just
> > > add some conditions to avoid UBSAN warning like this patch. Otherwise=
,
> > > this RFC can't entirely resolve the problem.
> >=20
> > Seems fine. I'd kind of probably not word it as "fix UBSAN" since reall=
y
> > it's just more along the lines of "warn if API is misused"? :)
>=20
> Maybe, combine two? Because I want to avoid UBSAN warning initially.=20

Yeah I understood later - never mind.

>=20
> > I don't really think this is stable material - if there's a driver
> > that's calling this when >64 frames is supported then it's a driver bug
> > that should be fixed, and if not then there's no bug?
>=20
> I'll remove this.=20

Actually I don't know - do you have a driver that's actually supporting
>64 BlockAck on stable?

I initially missed entirely the fact that the UBSAN happens on the
normal RX path, not (only) on the "mark as filtered" path. Sorry I
didn't make that clear.

>=20
> >=20
> > > +++ b/net/mac80211/rx.c
> > > @@ -1083,7 +1083,8 @@ static inline bool ieee80211_rx_reorder_ready(s=
truct tid_ampdu_rx
> > > *tid_agg_rx,
> > >       struct sk_buff *tail =3D skb_peek_tail(frames);
> > >       struct ieee80211_rx_status *status;
> > >=20
> > > -     if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
> > > +     if (tid_agg_rx->reorder_buf_filtered &&
> > > +         tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
> > >               return true;
> >=20
> > Or maybe no - this part is what you think should be
>=20
> This function will be called by all drivers that rely on mac80211's rx re=
ordering.=20

Yeah.

> The UBSAN find `index` of `BIT_ULL(index)` could be over 64, for example
> index=3D215 when I set hw.max_rx_aggregation_subframes to 256. This is in=
itial
> problem I want to fix.

Right, which I had missed initially in review.

> The `tid_agg_rx->reorder_buf_filtered !=3D 0` means hw.max_rx_aggregation=
_subframes <=3D 64
> (as well as index <=3D 64) implicitly, because only this kind of hardware=
 can call
> ieee80211_mark_rx_ba_filtered_frames(). Maybe, below would be intuitive, =
but
> I worry it hides problem that UBSAN can't find.
>=20
>     if (index < 64 && tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
>           return true;
>=20
> Any suggestion? or prefer?

I think what you did is fine.

Just send the patch as it was?

johannes
