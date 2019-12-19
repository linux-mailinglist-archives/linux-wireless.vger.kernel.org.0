Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC41271A1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 00:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLSXk7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 18:40:59 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37741 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfLSXk7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 18:40:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so6176534qky.4
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 15:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uG8r1HUS9fGO+BwiDUVGLE//cKSZauHELXBsBFK0kD4=;
        b=fdF5CxkfLEktgqkt8kaiPh8D4WrWusI8mQmmsjSHoa8Aotr4lla6lsjWPnYK50jrkc
         1eDg59Pg9PbXcszaB4E0mohlBHOn91ajkWGmuAuPvAfWJdtjiQQYyUpSfE4o8AoaD1ww
         yWrnvexJ9VbEgokUhGopsfylFFLufvW5VhsHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uG8r1HUS9fGO+BwiDUVGLE//cKSZauHELXBsBFK0kD4=;
        b=U7ORThk0XzmE8IsI0tFh0LrFtHmYXAqBJFBuDtRBnvA1a36k00I4+1/Yq4g3QywxsX
         QHcCUXT2Mm5imfkd5dB0F3yL3ArMu4U/Vx1b2eUC7/gLqsdrF4fA15ulwIGTiHZTHHzv
         U3jH5deIfv6dlXtlJSSt4twc8YGNLj4ha5zNLEoQzAzLIpesaSWjhJM5cGSPMhCbQOOY
         HfxUcUHnBxS2miqBcVxuDn3YZb6hBEwZp2J4aBEkzuOPzPW7e/TcG7Cs3l29HHL/Jy8Y
         aJh1/ywLF6LbtUYdLXgDuaJJGXhswAdtybyB+7vTgI52WVaqtis/OdYlCViDwRD/X8s0
         vHog==
X-Gm-Message-State: APjAAAVHUvXENuBwsGJOBuRcNe3SqqaJ/SfOjfo1IbHVi6hGn35qJy9h
        LGVDAhGpkGUxipq0J3EkM/iUjYIKpJk=
X-Google-Smtp-Source: APXvYqybA5rDhD/fyHbYHIhlIK0HKoy1OKW7CQfNTwnpf3TRbPmVU55kmBk0Cr9jFTIcCWU+hSPbWw==
X-Received: by 2002:a37:61cd:: with SMTP id v196mr10808465qkb.376.1576798856629;
        Thu, 19 Dec 2019 15:40:56 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id k184sm2229382qke.2.2019.12.19.15.40.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 15:40:56 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id e5so6599124qtm.6
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 15:40:55 -0800 (PST)
X-Received: by 2002:ac8:4086:: with SMTP id p6mr9221206qtl.161.1576798854764;
 Thu, 19 Dec 2019 15:40:54 -0800 (PST)
MIME-Version: 1.0
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
 <1576684108-30177-2-git-send-email-kvalo@codeaurora.org> <1576748692.7758.17.camel@realtek.com>
 <20191219154828.GA12287@w1.fi> <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
 <20191219185522.GA16010@w1.fi>
In-Reply-To: <20191219185522.GA16010@w1.fi>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 19 Dec 2019 15:40:43 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
Message-ID: <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power limits
To:     Jouni Malinen <j@w1.fi>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 19, 2019 at 10:55 AM Jouni Malinen <j@w1.fi> wrote:
>
> On Thu, Dec 19, 2019 at 10:32:06AM -0800, Brian Norris wrote:
> > On Thu, Dec 19, 2019 at 7:48 AM Jouni Malinen <j@w1.fi> wrote:
> > > On Thu, Dec 19, 2019 at 09:44:52AM +0000, Pkshih wrote:
> > > > On Wed, 2019-12-18 at 17:48 +0200, Kalle Valo wrote:
> > > > > diff --git a/include/uapi/nl80211-vnd-qca.h b/include/uapi/nl80211-vnd-qca.h
> > > > > + * NOTE: The authoritative place for definition of QCA_NL80211_VENDOR_ID,
> > > > > + * vendor subcmd definitions prefixed with QCA_NL80211_VENDOR_SUBCMD, and
> > > > > + * qca_wlan_vendor_attr is open source file src/common/qca-vendor.h in
> > > > > + * git://w1.fi/srv/git/hostap.git; the values here are just a copy of that
> >
> > By the way, I wonder -- why have this statement? That's not how I
> > recall any other piece of kernel development ever working; upstream
> > Linux defines the upstream Linux API, not some arbitrary user space
> > project. This statement could be useful for saying, "don't stomp on
> > those command numbers please," but the response should probably be to
> > go out and define a totally new vendor ID or something. (See below.)
>
> As far as the OUI 00:13:74 is concerned, the defined mechanism for
> getting any new identifier values assigned is by getting a patch applied
> into hostap.git. If another OUI is used, that can clearly use different
> mechanism for this. Anyway, I'd expect the process for OUI 00:13:74 to
> be the most convenient one to use.

OK, I guess that makes a little more sense. But I'm not sure I agree
with the phrase "convenient."

> For 00:13:74, that would mean defining the
> subcmds/attributes first with TBD ID values and once the definitions are
> otherwise fine in the kernel patch review, contributing a patch to
> hostap.git to get the identifiers assigned, updating the kernel patch to
> use the assigned values, and apply it to the kernel.

That doesn't really sound convenient at all. But I suppose that's
beside the point, so I won't harp on that.

> > > Please note that the vendor subcmd and attributes used here are already
> > > deployed and in use as a kernel interface. As such, the existing
> > > attributes cannot really be modified; if anything else would be needed,
> > > that would need to be defined as a new attribute and/or command.
> >
> > Clarification: you're talking about out-of-tree drivers, which really
> > have no relevance in upstream discussion, except possibly as examples.
> > I don't think it's ever been a valid approach to dictate upstream
> > kernel design based simply on "what $vendor already implemented for
> > Android."
>
> There is clearly no requirement to use an existing attribute, but since
> there is such an attribute already defined, I'd claim it is perfectly
> fine to consider it as an option for this. If something else is
> identified to be needed, a new subcmd/attribute can obviously be
> defined.

Ack, thanks. I think I misinterpreted your intention to say, "I won't
take suggestions, because the attributes are already decided
elsewhere."

> > > This was discussed during the 2019 wireless workshop. The conclusion
> > > from that discussion was that while there is clear need for SAR power
> > > limits for various devices and multiple vendors/drivers, it did not look
> > > clear that a single common interface could be defined cleanly taken into
> > > account the differences in the ways vendors have designed the mechanism
> > > in driver and firmware implementations. As such, vendor specific
> > > commands were identified as the approach.
> >
> > [citation needed]
>
> I'm not aware of any publicly available meeting minutes that covered the
> details for that discussion. My personal notes indicate that there were
> at least two vendors indicating existence of vendor specific commands
> for configuring SAR parameters, a discussion about the parameters used
> for this being different, and a conclusion that this would be an example
> kernel interface where a generic nl80211 interface may not be achievable
> and a vendor specific interface would be more likely. This discussion
> resulted in the discussion on how to use vendor specific nl80211
> commands/attributes in upstream drivers and the eventual documentation
> of that in the location you noted.

Hmm, I actually think I was only around for the pre-discussion, in
which y'all suggested you might later meet to decide what eventually
became [1]. So maybe I missed some specific examples that would
provide the [citation] I requested.

That being said, I have personally fielded out-of-tree SAR
implementations from 4 different vendors:

(a) Two of them (this ath10k proposal, roughly; and Realtek's) employ
exactly the same concept: N frequency ranges, each with associated
power limits.
(b) Two of them (Intel/variant-of-iwiwifi and Marvell/mwifiex) utilize
a platform-specific (BIOS or Device Tree) mechanism for enumerating
power tables, and the nl80211 API simply takes an index N (e.g., 0 or
1), so user space can say "switch to mode N"

Unfortunately, for (b), I think there are enough reasons to think they
won't share an API similar to (a) (for Marvell, their
platform-specific tables are large undocumented blobs -- I have a
feeling if we already had a common API for (a), they *could* have
implemented some translation in a nicer way in their driver, but they
haven't chosen to do that work and probably won't be convinced to do
so).

But that still means there's some hope for (a).

Anyway, I am happy that there's a documented policy for vendor APIs
[1], and I'm happy to see this proposal out here. I just want to see a
critical eye put to this particular proposal if possible, to see if we
can improve its flexibility (either now, or in a later version of a
QCA vendor command, or even in a common nl80211-proper command).

So to put a little different spin on Pkshih's request: is there any
value in making this particular ath10k proposal a little more generic
(e.g., more granularity or flexibility in frequency bands, or more
precision in power limits), such that other vendors might implement
the same thing? Or would it be better to let each vendor implement
their similar-looking APIs (i.e., (a); or maybe even (b)) on their
own, and only later look at sharing?

Brian

[1] https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
