Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17C01C1BB8
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgEARdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728495AbgEARdE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 13:33:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AE8C061A0C
        for <linux-wireless@vger.kernel.org>; Fri,  1 May 2020 10:33:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d16so7796239edv.8
        for <linux-wireless@vger.kernel.org>; Fri, 01 May 2020 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP6IAiOidrmnmH22GVnhOCP3v83hzHedixJxb4kgoZE=;
        b=NU9iyfeJ9glVr0owAUFIHQCjoEhpg69nU8h8NY2U/ElLyjWaaA9dZXoKA/uakB552J
         RY/AlGiBVC2h1972Rzh12dLrJXmGRTP/UKPJAW1Ki39ahw9eubyLY/N7ad+tZLBBu7o0
         JwCH9pWV5vOZQ29WaIMV0mPBTkYJO/wB3Au8llgb+7rBcp+ySvVnLuNmFjGakdnEVHMO
         yokao2IFCuJfJIwrJHoRjuTQMvwMrpfgkHyvK6DHlD6kq4TCUL2VGJSEpW2Taand/3nT
         kUS+E4JD7MhJs8hyUX9umfRW36+KuIsS5D2ikkMquUV8RmgIbY/vxZYGOZ17IZLwi6WL
         eAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP6IAiOidrmnmH22GVnhOCP3v83hzHedixJxb4kgoZE=;
        b=lu/jDuC7UEhU+6blGW6WCKP18G0q9UpNYjoU2kGv4kwFWXmsMz/gXy5BM22u5F82ag
         I8b0ycNsEWcf/4m8oQI4QW1wnmQu0hPDJsWNEGl5NTqzzwIM6TwulCVy9kpoPyKvp606
         m13LULuzSewV8cr2loOOkLvYjaArOceElfXT4ELC4jzmglBpVwloquMubtV2uwb9UFdU
         a6eSsC1y8DrugTErvHk9Jrh7lWvWhZRMElmoz1ajkfRw4htMDXA/q0ZOa7Arptu5Icy0
         UZu1S7X9wARnz7Qae+da10NDd4N9TqjXDRIfD5U6SCA7T1a71O5bAkqh5Mpia7SqIipV
         3uSA==
X-Gm-Message-State: AGi0PuZlogEwhJRnuNNsivrAW6vasEODWnpE4AuJ6wUMzHZiifMFSxwW
        ADDlYpDwGJyOqYjar/Lfj2VNZ/LsebtjBkq6zuptVslQFrs=
X-Google-Smtp-Source: APiQypKd9dmSlShT9lQlFt7qq8YBlyB1uC8qCJO+h7BHT9M8h610d+XIwaRm634gD67yDuNy+bAvguFTFL6YeMPwOTk=
X-Received: by 2002:a05:6402:22d5:: with SMTP id dm21mr4336051edb.275.1588354382861;
 Fri, 01 May 2020 10:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPv5Ue7kNRRf9esOKkQ=Kkx8f0_vdkiPYg24pzVsv3Dg71Ow_Q@mail.gmail.com>
 <259da597c3902c79c9d5c6e171e109dcb68564eb.camel@sipsolutions.net>
In-Reply-To: <259da597c3902c79c9d5c6e171e109dcb68564eb.camel@sipsolutions.net>
From:   James Prestwood <prestwoj@gmail.com>
Date:   Fri, 1 May 2020 10:32:51 -0700
Message-ID: <CAPv5Ue4Cp=Eeo+xy1K0CRz-AC3p-tUnEuRjuL1dyt0yiKhpwpA@mail.gmail.com>
Subject: Re: Auth/Assoc/Connect events coming before CMD_CONNECT response (hwsim)
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Fri, Apr 24, 2020 at 1:35 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2020-04-15 at 10:23 -0700, James Prestwood wrote:
> > Hi,
> >
> > I have noticed this sometimes happening with mac80211_hwsim where the
> > Authenticate, Associate, and Connect events arrive in userspace before
> > the actual response to CMD_CONNECT. It seems to be a scheduling/timing
> > problem as turning on logging in hostapd or other applications "fixes"
> > the issue
>
> Yeah, sounds like a consequence of immediately handling the frames
> through.
>
> I guess you could "fix" that by running with wmediumd?

We do run with wmediumd, although I hadn't looking into this much. The
README claims to support frame delay:

"wmediumd allows simulating frame loss and delay."

But I can't actually find a way to configure that. It only seems to
have configuration values for frame loss between stations and SNR, no
explicit delay. If a delay is possible it would be easier to integrate
this into our current test setup....

>
> Or adding some kind of fake air latency into hwsim.

... if wmediumd doesn't support a frame delay then this may be the
route we have to go.

Thanks,
James

>
> johannes
>
