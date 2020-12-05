Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F012CFECA
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 21:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgLEUY6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 15:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLEUY6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 15:24:58 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7238AC0613D1
        for <linux-wireless@vger.kernel.org>; Sat,  5 Dec 2020 12:24:17 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s30so12484955lfc.4
        for <linux-wireless@vger.kernel.org>; Sat, 05 Dec 2020 12:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5R5hbI6biOrhFi72PZ0N9OyJIbErNw6C3yWTUOEjdUE=;
        b=Ud7WgjmZxAMJgtEW+A4CekkOTT0q/Ftcg4Ut/RQlz4ueYAzarkyZZdnM+fvXGGrdmz
         CjvS2QQip3HeIOCveRIcxSLr4m2OZLRDg6HZkLh4fOGG2SVOg+peWWeyuwDnMgBxqw2L
         BywLaaavT+UDcBngxfr8T/zevWoHsRxwZESvXNh/+DDsEsH1VO6B+NI3T+yurY2kp/S7
         ebiYmhuEBFNmf3dSDFYds0OhfqscsbpkS0lfw7e6LEWzugCgYBypDpmoheJUJF9kItgr
         wS36YFSFYVZSllY0WGmoDTnLOGBN0PSLo7f8Z9mCoKD4Ct5gDPt3Sq9eFilRBTNX3l9C
         KdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5R5hbI6biOrhFi72PZ0N9OyJIbErNw6C3yWTUOEjdUE=;
        b=XiC6mvKqNPZzb9p9SV0HfkmC1BU2IBeU/NgSU43pTDFeyuL8xI3ZIiBb8XdbzYQ5OP
         VPLGlRB1yMrlIG/aNyBpJ8fUVk9FSjYWVwV2Gj+PElST0Is5lxzhbZHZD/BXDgO7sYzK
         2fUgnK9iNVaa4s7AwxetE3ajcNi+wizj0eXaBVOQlWb/jbVL1t+nnK9aqUEMgafAt5yB
         80YmDH0BaOa7avTXP2ukpRmfmIiGClmcs71tp3puq9WqY7G9gBhmk85cCLGvem0+u9Ar
         ovcN4hETZ59kYkr0NsWv8H8GL1c0JWIDg7CSZUk3u++N680wwrxokhmqESUHvaWfKD8G
         jTMA==
X-Gm-Message-State: AOAM530013Ez7datQXnL40yq3Rf4Ic6ZBJn0eLAB/qgjfySu2t71Fq/I
        JS6/8Ymu4CZO8DRyPZylxmegw6UmzUV5NbwkWY1pp5bep6A=
X-Google-Smtp-Source: ABdhPJzP8cYTlU7CeSi4q+mWURpnKIY0eKiUJaZ4mn4ZXV12lUXF48rmdU8Sk1KXtTvn/Q2bTHIuhp3p7JJKlRAamqs=
X-Received: by 2002:a05:6512:202b:: with SMTP id s11mr5352657lfs.27.1607199855965;
 Sat, 05 Dec 2020 12:24:15 -0800 (PST)
MIME-Version: 1.0
References: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
 <X8pRrWfZPhLdguu8@ubuntu-x1>
In-Reply-To: <X8pRrWfZPhLdguu8@ubuntu-x1>
From:   b.K.il.h.u+tigbuh@gmail.com
Date:   Sat, 5 Dec 2020 21:24:03 +0100
Message-ID: <CAPuHQ=EUcsn24EoSP+PGH2H6kPROvauyJN_6RtYLXqVYW=sK-g@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb <wireless-regdb@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for double checking. Honestly, I've only spent a few hours
skimming through the document and haven't read it through all the way.

Agreed that both bandwidths should probably be upped to 160.

Considering  =C2=A7 15.407 (a)(3)(v): shouldn't the flag `PTMP-ONLY`
already signal this infrastructure-mode only restriction? I think
sending a probe request frame before connecting may be considered a
"brief message", and NO-IR would even disallow that. Also, if we added
NO-IR, wouldn't that close the band for AP's running Linux as well?

Other than deciding the above questions, should we get back to
finishing this patch after publication sometime next year? There may
be a chance for it to change until then.

On Fri, Dec 4, 2020 at 4:11 PM Seth Forshee <seth.forshee@canonical.com> wr=
ote:
>
> On Thu, Dec 03, 2020 at 11:40:30PM +0100, bkil wrote:
> > The new band is called U-NII-4.
>
> The report states in paragraph 203 that the order is effective 60 days
> from publication in the Federal Register, and it looks like they haven't
> even been published in the Federal Register yet. We will need to wait
> for the rules to go into effect before applying any updates.
>
> > The report recommends combining it with 5725-5895 to allow 160 MHz
> > bandwidth, but that's technically not that easy with regdb due to the
> > differing restrictions of the two parts. Marking the line for U-NII-3
> > NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
> > possible workaround, but this needs to be discussed.
>
> I think it should be sufficient to set the bandwidth of both 5730-5850
> and 5850-5895 to 160 MHz with AUTO-BW. The kernel will see the AUTO-BW
> flags and calculate a combined rule where 160 MHz is allowed, and for
> the original rules any bandwidth exceeding the available bandwidth of
> the rule will be disallowed.
>
> > I don't see a requirement for TPC, hence reducing EIRP by 3dB is not
> > needed. I've marked it 33dBm (minus 6dB for clients) to cope with 20MHz=
,
> > but the band can support higher power, though the logic is complicated.
>
> I believe we have an additional requirement from =C2=A7 15.407 (a)(3)(v):
>
>   In the 5.850-5.895 GHz band, client devices must operate under the
>   control of an indoor access point. In all cases, an exception exists
>   for transmitting brief messages to an access point when attempting to
>   join its network after detecting a signal that confirms that an access
>   point is operating on a particular channel.
>
> This sounds like a requirement for passive scanning, if so the range
> should also have the NO-IR flag.
>
> Thanks,
> Seth
>
> >
> > The upper subband (5895-5925 MHz) of the new band is reserved for ITS.
> >
> > "We limit unlicensed use to indoor operations in recognition of the
> > potential that ITS licensees may currently be operating"
> >
> > "We also proposed that U-NII-4 devices be permitted to operate at the s=
ame
> > power levels as U-NII-3 devices."
> >
> > "For the U-NII-4 band, indoor access point EIRP will be limited to
> > 33 dBm/20 MHz and 36 dBm/40 MHz. When combined with U-NII-3 band spectr=
um,
> > indoor access point EIRP can scale to 36 dBm for 80 and 160 megahertz
> > channels."
> >
> > "Client devices would be limited to power levels 6 dB below the power
> > limits for access points."
> >
> > "the First Report and Order prohibit U-NII-4 client-to-client
> > communications to protect co-channel incumbent ITS"
> >
> > Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>
> > ---
> >  db.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/db.txt b/db.txt
> > index c71a03a..e6dd063 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1587,7 +1587,10 @@ country US: DFS-FCC
> >       # requirements, we can extend the range by 5 MHz to make the kern=
el
> >       # happy and be able to use channel 144.
> >       (5470 - 5730 @ 160), (23), DFS
> > -     (5730 - 5850 @ 80), (30)
> > +     (5730 - 5850 @ 80), (30), AUTO-BW
> > +     # https://www.fcc.gov/document/fcc-modernizes-59-ghz-band-improve=
-wi-fi-and-automotive-safety-0
> > +     # max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clien=
ts
> > +     (5850 - 5895 @ 40), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW
> >       # 60g band
> >       # reference: section IV-D https://docs.fcc.gov/public/attachments=
/FCC-16-89A1.pdf
> >       # channels 1-6 EIRP=3D40dBm(43dBm peak)
