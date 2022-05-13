Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F260526C58
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 23:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384675AbiEMVfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 17:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiEMVfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 17:35:23 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A395DBF42
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 14:35:20 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id y63so11654909oia.7
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 14:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vFihhg09/e+KSxHqlM0TEz+fCvVLJizBJkZfwsa6srA=;
        b=SIcKQGnt84IyTwxCq95vIIEyP8m9at4e7HO3BomIxSIqcQVKSxK8NhpUqa4o6/Aexd
         rd3ZRGZavo80jHSYcuUVak3CPNckQ5YZx13CCkZsSS2oxpIvLs3bxNaRQgE7ooTZWwq1
         Nf5pivwPqBB8IGvtpqtV5+5IKJjHbG6hL/nYcR0HKmQa64Zmust5ZOdZifvFtJjFSgu6
         qpz75Rx0JbWrVqPt8WnGG4WKomLXZo5f4WgcFdK9RyEQ4MTw3Vg7ZvzT+gZ9M1CPKIPI
         A25M1hXkFIvY05Rv6kijFTw3P7RtjDXloDqO+0AEBpQLXdy6dIX0Nzf5maRAmN9Tvg6G
         vEVw==
X-Gm-Message-State: AOAM5317w1nb2ryQ4y+mtKYQgLBho6g0wgPhdlHTn/ycAATZyOSzqrHy
        3No7/o8ygHevjk6l56atgWkadDGzo/GUsg==
X-Google-Smtp-Source: ABdhPJwVa7jxa93BNrcOIq6JL1dqs1hrls4LR4SbnCplmtj8MKpIqeYi3WUxD/7Xiut7V/JIRRdpmw==
X-Received: by 2002:a05:6808:5c7:b0:325:b1b8:248 with SMTP id d7-20020a05680805c700b00325b1b80248mr8401989oij.89.1652477719916;
        Fri, 13 May 2022 14:35:19 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:2539:caef:6137:c60a])
        by smtp.gmail.com with ESMTPSA id g31-20020a9d2da2000000b00606ae457129sm1437154otb.26.2022.05.13.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 14:35:19 -0700 (PDT)
Date:   Fri, 13 May 2022 16:35:18 -0500
From:   Seth Forshee <seth@forshee.me>
To:     Ed W <lists@wildgooses.com>
Cc:     Seth Forshee <seth.forshee@canonical.com>,
        wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] Correction of wireless-regdb for GB
Message-ID: <Yn7PFi556pM+r08j@ubuntu-x1>
References: <4d07581c-a3be-a3c6-bf32-7007eb45d541@wildgooses.com>
 <20201106214446.GG6125@ubuntu-x1>
 <2a710032-f2ec-d55b-5da4-d881089fe0cd@wildgooses.com>
 <20201120175444.GN5439@ubuntu-x1>
 <e7268989-03cf-ae7c-f3c6-b48fe679b790@wildgooses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7268989-03cf-ae7c-f3c6-b48fe679b790@wildgooses.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 25, 2022 at 02:17:57PM +0100, Ed W wrote:
> On 20/11/2020 17:54, Seth Forshee wrote:
> >> Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
> >> ---
> >>  db.txt | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/db.txt b/db.txt
> >> index ac32483..cc5ffd0 100644
> >> --- a/db.txt
> >> +++ b/db.txt
> >> @@ -588,13 +588,16 @@ country FR: DFS-ETSI
> >>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0019/136009/Ofcom-Information-Sheet-5-GHz-RLANs.pdf
> >>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
> >>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0013/126121/Statement_Implementing-Ofcoms-decision-on-the-57-71GHz-band.pdf
> >> +# GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0036/198927/6ghz-statement.pdf
> >>  country GB: DFS-ETSI
> >>  	(2400 - 2483.5 @ 40), (100 mW)
> >>  	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> >>  	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> >> -	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
> >> +	(5470 - 5730 @ 160), (500 mW), DFS, wmmrule=ETSI
> > This looks okay to me.
> >
> >>  	# short range devices (ETSI EN 300 440-1)
> >> -	(5725 - 5875 @ 80), (25 mW)
> >> +	# See UK specific notes in ir-2030.pdf, p47
> >> +	(5725 - 5850 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI
> > To echo what I said above, I'm unclear whether this change is in effect
> > yet, and based what I've seen so far I think it would need to include
> > NO-OUTDOOR.
> >
> >> +	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> > I'm also unclear on whether this change is in effect yet.
> >
> > Thanks,
> > Seth
> >
> >>  	# 60 GHz band channels 1-6
> >>  	(57000 - 71000 @ 2160), (40)
> >>  
> >> -- 
> >> 2.26.2
> >>
> 
> Hi all, I dropped off watching this for a while....
> 
> Seems like the update to IR2030 (GB country code regulations) was re-published last year, and the
> relevant sections are in pages 32 + 34-36
> 
> My reading of this is:
> 
> - Other stuff we changed 2 years ago seems ok, caveat I'm unclear when we need to state half power
> vs using mean EIRP?

We have to use half of the maximum EIRP in cases where TPC is required
because Linux does not support TPC. This is why 5250-5350 and 5470-5730
have lower limits than what is prescribed in IR 2030.

Note that many recent rules have also included power spectral density
(PSD) limits, which can also limit the max EIRP in the database since
there's currently no support for PSD limits in Linux or wireless-regdb.
Where specified in IR 2030 they do not impose any limit beyond the max
EIRP for the minimum relevant bandwidth for our purposes (20 MHz), so
they don't end up making any difference here.

> - The 5.9-6.4Ghz range is now good for use (page 35 near the bottom), perhaps add something like:
> 
> +    (5925 - 6425 @ 160), (250 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI

This looks about right. AUTO-BW isn't necessary since there are no
adjacent rules. It looks like this was overlooked in the beginning, then
the pattern was copied.

> 
> - The 60Ghz range seems to available now, but I'm not sure what power number we should have in our
> db.txt, see page 32.
> Says "40 dBm e.i.r.p / 27 dBm maximum transmit output power"
> - There are also some geographic restrictions, not sure what we can do about those?
> 
> So something like this perhaps?:
> 
> > +	(5700 - 71000 @ 160), (40)

We have a rule for this range already that looks fine to me.

> Happy to knock this up into a patch if you can help with a little guidance (although it might be
> faster for you to just commit the 2 extra lines if you agree?)

I prefer that others write patches and I review them, since no one else
really reviews the patches and it's always harder to spot errors in your
own patches. But if you're unable to do it, I can create a patch.

I think the 5725-5850 MHz change from above can also be included too, as
long as it includes NO-OUTDOOR.

Thanks,
Seth
