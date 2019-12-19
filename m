Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCD812691A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 19:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSScW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 13:32:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39831 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSScV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 13:32:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so5874973qtm.6
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G6Vp8WB7zFaMYDsDqjMxasHiaE3hIOW0+ggjUmP96JA=;
        b=IvZmQM+1xx5wRKtwGsH7GokWQ0Q246Nv5kRgefExpPEf0EQpq/5uBmh0vTpjiLnH9a
         bX4Oo7FLSv0AY+AZkMDdHolJe53QzpAZBCMtwOdVi6QFAmnKK3qBYH9QtQOUpjGJL3vp
         BDSg1g5jge56DobIY7tn1w6Rb28kIAzN9WFuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G6Vp8WB7zFaMYDsDqjMxasHiaE3hIOW0+ggjUmP96JA=;
        b=KRJd3xgyqdghSEUnQELqfuUnVpIfxvtBTU+Jx+/XARP/G5RwR9vfTgY4l+nhYwJ9zw
         TxkKpGyJlRoEfn+CwlVlqUGo2WJd+BEnPOCAlv0AypgqjWBbXBUFzX5p47LMOKtPBOPF
         U+dTY2kal2CtQON0i+yzbX4kvwjUtprqL82DjTPu8XFuB/OzI4lCmc1uARt3FvsPWmjI
         H69uBMHLQ5hRC7Rgq8khjEhp+FBWeDMY+2DPJBi2poJEz5Q795iCm1Qp64yOy/kcjia+
         ctGaAcVjs9ARvftNhUMbNCg3IVLVvLkfVHH4eb69keVmUJFqXoT9/VqyHsNyhaYlsZSl
         X8/w==
X-Gm-Message-State: APjAAAXnXvIwIWrriOJT1Glo4BBsvX0t2QJkydPl4I2rLOvZBh9fpq6K
        eYY2+TmLtkp6aHJY1Yoqf6HXLKcOuHE=
X-Google-Smtp-Source: APXvYqxNGA39Yyk/6iM6HrZz8YaMMk8ctwVSWuXXMMejaMlO9W2vfWeXdiBJ4KyTWnnZ761asXNv8A==
X-Received: by 2002:aed:2047:: with SMTP id 65mr8303656qta.78.1576780340038;
        Thu, 19 Dec 2019 10:32:20 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id g4sm2179325qtg.35.2019.12.19.10.32.18
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:32:18 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id j5so5846288qtq.9
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 10:32:18 -0800 (PST)
X-Received: by 2002:ac8:2b29:: with SMTP id 38mr8236384qtu.238.1576780338156;
 Thu, 19 Dec 2019 10:32:18 -0800 (PST)
MIME-Version: 1.0
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
 <1576684108-30177-2-git-send-email-kvalo@codeaurora.org> <1576748692.7758.17.camel@realtek.com>
 <20191219154828.GA12287@w1.fi>
In-Reply-To: <20191219154828.GA12287@w1.fi>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 19 Dec 2019 10:32:06 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
Message-ID: <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power limits
To:     Jouni Malinen <j@w1.fi>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 19, 2019 at 7:48 AM Jouni Malinen <j@w1.fi> wrote:
> On Thu, Dec 19, 2019 at 09:44:52AM +0000, Pkshih wrote:
> > On Wed, 2019-12-18 at 17:48 +0200, Kalle Valo wrote:
> > > diff --git a/include/uapi/nl80211-vnd-qca.h b/include/uapi/nl80211-vn=
d-qca.h
> > > + * NOTE: The authoritative place for definition of QCA_NL80211_VENDO=
R_ID,
> > > + * vendor subcmd definitions prefixed with QCA_NL80211_VENDOR_SUBCMD=
, and
> > > + * qca_wlan_vendor_attr is open source file src/common/qca-vendor.h =
in
> > > + * git://w1.fi/srv/git/hostap.git; the values here are just a copy o=
f that

By the way, I wonder -- why have this statement? That's not how I
recall any other piece of kernel development ever working; upstream
Linux defines the upstream Linux API, not some arbitrary user space
project. This statement could be useful for saying, "don't stomp on
those command numbers please," but the response should probably be to
go out and define a totally new vendor ID or something. (See below.)

> > > + * @QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND: Optional (u32) value =
to
> > > + * indicate for which band this specification applies. Valid
> > > + * values are enumerated in enum %nl80211_band (although not all
> > > + * bands may be supported by a given device). If the attribute is
> >
> > Can we define separated enum to address four 5G sub-bands, likes
> >
> > enum nl80211_sar_band {
> >       NL80211_SAR_BAND_2G,
> >       NL80211_SAR_BAND_5G_BAND1,
> >       NL80211_SAR_BAND_5G_BAND2,
> >       NL80211_SAR_BAND_5G_BAND3,
> >       NL80211_SAR_BAND_5G_BAND4,
> > };
>
> Please note that the vendor subcmd and attributes used here are already
> deployed and in use as a kernel interface. As such, the existing
> attributes cannot really be modified; if anything else would be needed,
> that would need to be defined as a new attribute and/or command.

Clarification: you're talking about out-of-tree drivers, which really
have no relevance in upstream discussion, except possibly as examples.
I don't think it's ever been a valid approach to dictate upstream
kernel design based simply on "what $vendor already implemented for
Android."

Maybe it's a better idea to just use different command numbers (or
vendor ID?) here, to avoid stomping on each others' implementation
choices. Otherwise, it sounds like our only choice here is to copy
your Android driver verbatim, or get lost.

> > I think this vendor command can be a generic nl80211 command, because
> > we need SAR
> > power limit as well.
>
> This was discussed during the 2019 wireless workshop. The conclusion
> from that discussion was that while there is clear need for SAR power
> limits for various devices and multiple vendors/drivers, it did not look
> clear that a single common interface could be defined cleanly taken into
> account the differences in the ways vendors have designed the mechanism
> in driver and firmware implementations. As such, vendor specific
> commands were identified as the approach.

[citation needed]
I was in that workshop, and while I recall the assertion, I don't
recall any evidence [1]. In fact, I've watched (off-list) Wen Gong
propose several variations of this exact same API along the way (hint,
I'm the one requesting he upstream this), and it's clear there's
*some* flexibility in the API. If, for example, the driver attempted
to provide a list of frequency bands it supports controlling TX power
for, that would go a long way toward sharing this API between drivers.

Another hint: this is exactly why Pkshih is speaking up here -- I'm
fielding requests from him and his employer on implementing the same
feature, and his API is starting to look an awful lot like yours. So I
suggested he review this proposal to see where and why they differ.

Anyway, I don't really object with starting out with a
Qualcomm-specific and a Realtek-specific vendor command to implement
nearly the same feature, but I'd prefer if people did engage in some
healthy discussion about why they can't share an API, with the hopes
that maybe they can converge someday. In fact, that's exactly what the
Wiki says about this:

https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor=
-specific_api

"The goal with these rules is to enable use of vendor commands in a
fashion that is transparent enough to allow later reuse by other
components with similar needs, and then potentially defining =E2=80=9Creal=
=E2=80=9D
nl80211 API for the use case in question."

Regards,
Brian

[1] The closest thing to evidence I've seen is that certain $vendors
decide they don't want to give user space any control at all over the
SAR power tables, for $reasons. But such $vendors should not really
have any say in implementing user space APIs for those $vendors that
do provide such control.
