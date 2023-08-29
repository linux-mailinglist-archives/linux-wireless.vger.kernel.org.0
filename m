Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497A278CB90
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbjH2Ruy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbjH2RuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 13:50:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA080F4
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=J9TuUtqJG2UbjpSxmyRA25dEzoXFGer3upQ/oiRgJrQ=;
        t=1693331420; x=1694541020; b=Y5tBbcZoF/qmLLhKKTD14v0s3RqHKvVtQqu69P0rR9E4EtH
        JzhoC3gLl+ERqlOT9uVBYnQ3YZboQSc1L9TcArEeaB6oo3uICQeGBdLowVV9C9yZFIIy2QI/K9dig
        QLfbTQ+owQd7zu2i9IeWRyV1qxRU1H3sK5gOZFI6UulxYFnfJWFe7BB2yRik2irFhcLtDiLxFkdjF
        wczg5xXoOjwgWEIGpmTeBHwhAuIX447mjO4Ks+5L5sceGi2z94R36axGD6uchmJftqPOUWZbJJau7
        7KRUSmYsnnWQU8k4taCjqPXOJ1NZLNYvSUdHH2uHcIupzJeIz6fJYmKu5oRs5M5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qb2r3-001Qdf-37;
        Tue, 29 Aug 2023 19:50:18 +0200
Message-ID: <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support
 for all power modes
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 29 Aug 2023 19:50:16 +0200
In-Reply-To: <20230315132904.31779-1-quic_adisi@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
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

Hi,

So ... yeah. I shied away from even reviewing this because it's such a
messy topic and we've had so many threads about this. Sorry about that.


On Wed, 2023-03-15 at 18:58 +0530, Aditya Kumar Singh wrote:
> 6 GHz introduces various power modes of operation. Currently, based
> on the power mode, channel's Power Spectral Density (PSD) value,
> Regulatory power value, as well as channel disabled flag can change.
> For single interface, current implementation works just fine. But for
> multi-interfaces, for example AP-STA concurrency, two different channel
> context needs to be maintained. This is because, STA power mode also
> depends on the AP's power mode it is going to associate with. Hence,
> PSD value, regulatory power value and channel disabled flag might vary.
> In this case, same channel context cannot be used for both AP and STA.
>=20
> Therefore, to support multiple channel space for each power mode, the
> 6 GHz channels needs a separate storage space in data structure
> ieee80211_supported_band. Because of this, the existing APIs to get the
> channel/frequency from frequency/channel will not work for 6 GHz band.
>=20
> Add support to store all possible 6 GHz channel pools according to the
> power mode as well as add API support for getting channel/frequency info
> from the new struct ieee80211_6ghz_channel.
>=20
>=20
> Why different channel pools and not array of varying member in the same c=
hannel?:


I really don't understand.

Why do you even need to set *from userspace* the power mode for a
client? That ... doesn't make that much sense?

I mean, you're explaining here the mechanics, which is all fine, but
what's the "theory of operation"? Yes, I get that 6 GHz spectrum use
introduced power modes, but why do we even need to handle it this way?
None of this or the patches actually introduce any rationale?

Also, I'll note that the patch subjects with "cfg80211" or "mac80211"
are _really_ unclear. Sometimes you have "cfg80211" patches that mostly
change mac80211, etc. It'd make reviewing easier if you actually did
limit cfg80211 patches to touching cfg80211 only (with the exception of
necessary API updates, of course), and mac80211 patches to implementing
the new cfg80211 APIs. The first patch is probably neither, you can mark
it as ieee80211.

And then trivial things like - don't introduce a bug only to fix it in
the next patch! I mean, really?

I _still_ don't like "(A)" operation with different channel pointers -
you talk about introducing bugs with (B) but at least those would be
bugs in the new parts; (A) is almost certainly introducing bugs in
existing code that compares pointers and you never even know about it.

Also, related to that, is kind of a fundamental question - should we
really think that two *channels* are different because you use different
(TX) power control/scheme on them? That seems a bit strange, and you've
not gotten into that at all, from a semantic POV, only from a code POV.
I actually currently don't think that makes sense, but convince me
otherwise?

For a chandef, _maybe_? But also see the discussion around puncturing,
I'm not sure that's actually the right solution either.

johannes
