Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71414AF8D3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 18:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiBIRyx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 12:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiBIRys (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 12:54:48 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC36C05CB87
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 09:54:50 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so2038154oth.12
        for <linux-wireless@vger.kernel.org>; Wed, 09 Feb 2022 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forshee.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=21KKN7+ZTc48MhpoxW5p1y1F1Vlvg9Mt62AYQCXp/G4=;
        b=mT3RWVKCu1AY0jEofesSusDrbBI+HP4/DZWEdzi7n0mx+gwpw0i/Og7k3PP781zm6W
         tLgEDLfYMk4PT+RacjZ2Ej6ut7JVeWbLQsJsl4TttjgY/hV/VrA9PX2IWGs3xdgOAgnn
         AeAm20vV/kwIppg2Ns/yRaeVJuOPYQJpuFz85QaTLZdbPlDhEr0ANStwk5Vb+eS/wViM
         4y6EhEkQuy1Cj/SxC6tYgh++yCRUQ8dffL5DPq7ZuErrDPVNdKljE+BjoVe6ZqNF6vmX
         H+DeXnHwgBBtxaXBcjlUgR5kx1xp9+qd6B7tJvNysVrjL+UUDXsYubgZPAMyJtXBKzKD
         x7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=21KKN7+ZTc48MhpoxW5p1y1F1Vlvg9Mt62AYQCXp/G4=;
        b=r6X/qvM6vqM9wYSQ8h7PAigyMR67oPC6n/fmCUdZS4gu3gFnHWTJK1IM76jmMTtWyN
         0I6Zb4w/sadBQZCabXCcjFq0d71f04z5iT07ac42BUu32N+5d+XMdLfL+OnwphNmdo/a
         ICpHNApE9RI+1kU+Oqrh3NqtECjKPyfQ42+mkdaTR3peUrPRj/Rmk84NnsqsFF/XYR93
         Y2XxsjWAHj7C7TPuAem5IJdLC4cmEE1NP5vy+U+lR67zqFkXqjfKSnuRgqgABDh9z+0F
         vzhdOvMdkOX907tjq0EYcIe0UXzEbPvbVrHUgFP18GIKHve2OaOVbOUYdgm36I/LU/e2
         N2eg==
X-Gm-Message-State: AOAM532g7Zwhla8+riinTFGRD5kf0+Xcwh0UaT6fCG1iatZrvw6SlO2b
        VKjAiCcHD76Texni3pd/bSBMeMcvrGatGX6GIPY=
X-Google-Smtp-Source: ABdhPJzrRFaTDL0bpN1Agib8gJKi9/9kqV0uqx+ibobx7GeuGGMOOfuK7FCMy0ZeTCrzptNgT1i6DA==
X-Received: by 2002:a05:6830:1294:: with SMTP id z20mr1367756otp.194.1644429290204;
        Wed, 09 Feb 2022 09:54:50 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:9212:76b8:b270:7ba])
        by smtp.gmail.com with ESMTPSA id m7sm6825279ots.32.2022.02.09.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:54:49 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:54:49 -0600
From:   Seth Forshee <seth@forshee.me>
To:     b.K.il.h.u+tigbuh@gmail.com
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Asura Liu (asuliu)" <asuliu@cisco.com>
Subject: Re: [wireless-regdb] wireless-regdb: Update regulatory rules for the
 US on 6 GHz band
Message-ID: <YgP/6RnJxFipnrFX@ubuntu-x1>
References: <DM6PR11MB3116340921B7E66B0E4176A1D7749@DM6PR11MB3116.namprd11.prod.outlook.com>
 <Yb0HabN+Js2iWnOH@ubuntu-x1>
 <3e599e1a-29cd-5c86-1f43-c4ce869909b3@gorani.run>
 <YcDvD1aXJ1R7vG8y@ubuntu-x1>
 <CAPuHQ=G7s=kqsv7gdvOs3ZHLpwrgjYj1NivfL-BXMZZ+fzUHtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPuHQ=G7s=kqsv7gdvOs3ZHLpwrgjYj1NivfL-BXMZZ+fzUHtw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Adding patch author back to Cc)

On Tue, Feb 08, 2022 at 07:12:33PM +0100, b.K.il.h.u+tigbuh@gmail.com wrote:
> Sorry to chime in like this. I haven't even read the linked
> documentation, but whatever the final solution will be, I would prefer
> if we committed the lowest, safe power levels while we are actively
> researching, deciding and implementing a final solution. We can always
> raise limits later on.

Yes, I will not be applying the patch as-is. In addition to my other
comments, the power limits will need to be adjusted to meet the PSD
limits on a 20 MHz channel.

Seth

> On Mon, Dec 20, 2021 at 10:02 PM Seth Forshee <sforshee@kernel.org> wrote:
> >
> > On Sat, Dec 18, 2021 at 04:34:13PM +0900, Sungbo Eo wrote:
> > > On 2021-12-18 06:55, sforshee@kernel.org wrote:
> > > > On Mon, Dec 13, 2021 at 09:19:50AM +0000, Asura Liu (asuliu) wrote:
> > > > >  From 3db25ea674232fea6a5efca292f6ed3fd8eba7a2 Mon Sep 17 00:00:00 2001
> > > > > From: Asura Liu <asuliu@cisco.com>
> > > > > Date: Mon, 13 Dec 2021 16:46:28 +0800
> > > > > Subject: [PATCH] wireless-regdb: Update regulatory rules for the US on 6 GHz
> > > > > band
> > > > > MIME-Version: 1.0
> > > > > Content-Type: text/plain; charset=UTF-8
> > > > > Content-Transfer-Encoding: 8bit
> > > > >
> > > > > According to FCC 20-51, FCC adopts rules to unlicensed use of the 6 GHz band:
> > > > > "59. Third, the Commission limits the low-power indoor access points to lower power levels than the standard-power access points that operate under the control of an AFC. Consistent with the Commission's approach for the existing U-NII bands, the Commission specifies both a maximum power spectral density and an absolute maximum transmit power, both in terms of EIRP. Specifically, the Commission allows a maximum radiated power spectral density of 5 dBm per 1 megahertz and an absolute maximum radiated channel power of 30 dBm for the maximum permitted 320-megahertz channel (or 27 dBm for a 160-megahertz channel). In addition, to ensure that client devices remain in close proximity to the indoor access points, the Commission limits their PSD and maximum transmit power to 6 dB below the power permitted for the access points."
> > > > > See https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-use-of-the-6-ghz-band
> > > > >
> > > > > And 47 CFR § 15.407 describe this as following:
> > > > > (a) (5) For an indoor access point operating in the 5.925-7.125 GHz band, the maximum power spectral density must not exceed 5 dBm e.i.r.p. in any 1-megahertz band. In addition, the maximum e.i.r.p. over the frequency band of operation must not exceed 30 dBm.
> > > > > (a) (8) For client devices operating under the control of an indoor access point in the 5.925-7.125 GHz bands, the maximum power spectral density must not exceed −1 dBm e.i.r.p. in any 1-megahertz band, and the maximum e.i.r.p. over the frequency band of operation must not exceed 24 dBm.
> > > >
> > > > Thanks for the patch. A couple of quick notes about the patch
> > > > description. It's preferred to wrap lines in the body at around 75
> > > > characters, and it's required that you include a Signed-off-by tag
> > > > indicating your agreement to the DCO for your contribution (see
> > > > CONTRIBUTING).
> > > >
> > > > Additional comments below.
> > > >
> > > > > ---
> > > > > db.txt | 6 ++++++
> > > > > 1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/db.txt b/db.txt
> > > > > index b898799..c6ef9b6 100644
> > > > > --- a/db.txt
> > > > > +++ b/db.txt
> > > > > @@ -1606,6 +1606,12 @@ country US: DFS-FCC
> > > > >   # https://www.federalregister.gov/documents/2021/05/03/2021-08802/use-of-the-5850-5925-ghz-band
> > > > >   # max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
> > > > >   (5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
> > > > > + # 6ghz band
> > > > > + # https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-use-of-the-6-ghz-band
> > > > > + # https://docs.fcc.gov/public/attachments/FCC-20-51A1_Rcd.pdf
> > > > > + # max. 30 dBm AP @ 320MHz, 27 dBm AP @ 160MHz, 6 dB less for clients
> > > > > + (5925 - 7125 @ 320), (30), NO-OUTDOOR, AUTO-BW
> > > > > + (5925 - 7125 @ 320), (24), NO-OUTDOOR, AUTO-BW, NO-IR
> > > >
> > > > The kernel doesn't currently support multiple rules with different flags
> > > > for the same range. This is an issue that's come up several times, but
> > > > so far nothing has been done about it.
> > > >
> > > > Even ingoring that, I don't think these rules accomplish the intended
> > > > purpose. There's nothing that would require a client device to use the
> > > > NO-IR rule, so they could end up using the higher power limit and
> > > > transmitting before detecting transmission from an AP.
> > > >
> > > > I also suspect that we should be able to express the AFC requirement in
> > > > the database before permitting AP operation in this range.
> > > >
> > > > Currently I think the best we're able to do is to use the lowest common
> > > > denominator, which is the 24 dBm rule with NO-IR.
> > > >
> > > > Thanks,
> > > > Seth
> > >
> > > Hi, sorry for intruding.
> > >
> > > I thought max EIRP rule for larger bandwidth also applies to smaller
> > > bandwidth, that means we would use 24 dBm tx power with 20 MHz channel as
> > > well. But the regulation limits PSD to -1 dBm/MHz and it leads to 12 dBm for
> > > 20 MHz. Shouldn't we use 12 dBm rule to fit the smallest bandwidth?
> > >
> > > I still don't understand exactly how the rules work, my apologies if I am
> > > mistaken.
> >
> > Before I respond, let me be upfront about my limitations. I'm not an RF
> > engineer. My day job no longer has anything to do with wireless and has
> > not for a number of years now. I haven't had time to really keep up with
> > recent developments either, so my impressions are based on some light
> > research and what I remember of information I rarely use nowadays.
> >
> > After doing a little bit of reading, I suspect that you are probably
> > right (in principle at least, I didn't check the math). It seems there's
> > been a movement towards specifying PSD so that larger bandwidths can
> > effectively have a higher max EIRP than lower bandwitdths to overcome
> > diminishing SNR with increasing bandwidth.
> >
> > That leaves us in the unfortunate position of needing to specify an EIRP
> > suitable for a bandwidth of 20 MHz when larger bandwidths could be using
> > a higher power limit. It seems like the Linux regulatory framework needs
> > to evolve to support PSD limits. I don't currently have the time or the
> > inclination to do this work though, and until someone does we're stuck
> > with the status quo.
> >
> > Thanks,
> > Seth
> >
> > _______________________________________________
> > wireless-regdb mailing list
> > wireless-regdb@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/wireless-regdb
> 
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
