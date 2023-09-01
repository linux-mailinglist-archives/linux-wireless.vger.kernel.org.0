Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D77902AB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 21:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjIAT4v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjIAT4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 15:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D05E10FB
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 12:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9533660FB5
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 19:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CB7C433C7;
        Fri,  1 Sep 2023 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693598204;
        bh=quIaNgr0jX447Ru94Ds1oO9oxAf5B07WMji+q1D784A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lted/hl/VMZrRkqxw8EAVIbMRzL/WOUOYnANLyaRj0s/nwpDJkp3UJpzzRPdAaKfD
         HGhxtM3AOqXkUcGozqS+SbtPOq7scM4oySJxbW7HYgjwJR6lWjc9VsdtCcJfGbGwz7
         hj6jj9QHF9101UiIpb1XwkoAdJ2DqjcTIAuEYPbY5Xi1P8OXYKwsMqoqtMymM0dAoK
         DGWiCvqdz/GiHWtTEJxge/hbqhyi0q80pjcRgLQ3ZW+kOA1c8/bxb6SNfacoMcrb4D
         WmARrITG5PWwsYkhJXLfikF71wNf76xnl4uMS249DS1Jkgx4AqEDMH49C2gPWZoWh9
         MQJJRunizqPQQ==
Date:   Fri, 1 Sep 2023 14:56:43 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Adam Nielsen <a.nielsen@shikadi.net>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Australia (AU) for June 2023
Message-ID: <ZPJB+xrFeXtIpRPA@ubuntu-x1>
References: <20230716225604.1d5a136a@vorticon.teln.shikadi.net>
 <ZLsBYjmM3xxFxG6l@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLsBYjmM3xxFxG6l@ubuntu-x1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 21, 2023 at 05:06:26PM -0500, Seth Forshee wrote:
> On Sun, Jul 16, 2023 at 10:56:04PM +1000, Adam Nielsen wrote:
> >  - Update legislation link from March 2022 version to June 2023.
> >  - Add comments for each frequency range referring back to legislation.
> >  - Switch units from dBm to mW to match values listed in legislation.
> >  - Allow 5850-5875 at low power, as this has always been permitted.
> >  - Combine 5150-5350 bands to permit a 160 MHz channel.
> > 
> > Signed-off-by: Adam Nielsen <a.nielsen@shikadi.net>
> > ---
> > 
> > Hi all,
> > 
> > Just a few minor changes for AU.  I have included (5150 - 5350 @ 160) which
> > overlaps two existing bands, however I am not sure if this is the correct way
> > to do it.  From what I gather, having the two bands listed separately (items
> > 61 and 62 in the patch below) would prevent a single 160 MHz channel from
> > being spread across both bands.  I figure adding another entry that covers
> > both frequency ranges (with the most restrictive limitations) would permit
> > the 160 MHz channel to be used, however please correct me if this is wrong.
> 
> Unfortunately this does not work. However, with AUTO_BW I believe that
> the kernel does allow a larger bandwidth when it spans adjacent
> channels, so it probably isn't necessary.
> 
> Otherwise this mostly looks good, but a few changes are needed. I added
> comments below.
> 
> > 
> > I added a bunch of comments pointing back to the relevant section of the
> > legislation document as I found it a bit of a challenge to work out where
> > each entry mapped back to.  So hopefully this will make it easier for the
> > next person to work out where the rules are coming from.
> > 
> > If there are any other issues with the patch let me know.
> > 
> > Cheers,
> > Adam.
> > 
> >  db.txt | 46 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 37 insertions(+), 9 deletions(-)
> > 
> > diff --git a/db.txt b/db.txt
> > index ef4e609..d0b7ec6 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -124,20 +124,48 @@ country AT: DFS-ETSI
> >  	(57000 - 66000 @ 2160), (40)
> >  
> >  # Source:
> > -# https://www.legislation.gov.au/Details/F2022C00281
> > +# 'Item' in the comments below refers to each numbered rule found at:
> > +# https://www.legislation.gov.au/Details/F2023C00524
> >  # Both DFS-ETSI and DFS-FCC are acceptable per AS/NZS 4268 Appendix B.
> >  # The EIRP for DFS bands can be increased by 3dB if TPC is implemented.
> >  # In order to allow 80MHz operation between 5650-5730MHz the upper boundary
> >  # of this more restrictive band has been shifted up by 5MHz from 5725MHz.
> >  country AU: DFS-ETSI
> > -	(2400 - 2483.5 @ 40), (36)
> > -	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
> > -	(5250 - 5350 @ 80), (20), NO-OUTDOOR, AUTO-BW, DFS
> > -	(5470 - 5600 @ 80), (27), DFS
> > -	(5650 - 5730 @ 80), (27), DFS
> > -	(5730 - 5850 @ 80), (36)
> > -	(5925 - 6425 @ 160), (24), NO-OUTDOOR
> > -	(57000 - 66000 @ 2160), (43), NO-OUTDOOR
> > +	# Item 58
> > +	(915 - 928 @ 4), (1000 mW)
> > +	(920 - 928 @ 8), (1000 mW)
> 
> I'm not sure if this is intentionally overlapping, or if 915-928 MHz is
> a typo and you meant 915-920 MHz. Either way, we can't have ranges
> overlapping like this.
> 
> > +
> > +	# Item 59
> > +	(2400 - 2483.5 @ 40), (4000 mW)
> > +
> > +	# Item 61
> > +	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> > +
> > +	# Item 62 (200 mW allowed if TPC is used)
> > +	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
> > +
> > +	# Combine the above two bands to get a 160 MHz channel.
> > +	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
> 
> As stated above, this rule needs to be removed.
> 
> > +
> > +	# Item 63(a) (1000 mW with TPC)
> > +	(5470 - 5600 @ 80), (500 mW), DFS
> > +
> > +	# Item 63(b) (1000 mW with TPC)
> > +	# The end is 5725 but we borrow 5 MHz from the following less restrictive band
> > +	# so we can get an 80 MHz channel.
> > +	(5650 - 5730 @ 80), (500 mW), DFS
> > +
> > +	# Item 60
> > +	(5725 - 5850 @ 80), (4000 mW)
> 
> Please adjust this up to 5730 MHz to not overlap with the rule above it.
> 
> > +
> > +	# Item 22
> > +	(5850 - 5875 @ 40), (25 mW)
> 
> You can't have a rule whose bandwith is greater than the range. And I'd
> think you'd want to add AUTO_BW to this and the previous range to allow
> use of channel 169, etc.
> 
> > +
> > +	# Item 63AA (25 mW if outdoors)
> > +	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR
> > +
> > +	# Item 65
> > +	(57000 - 71000 @ 2160), (20000 mW), NO-OUTDOOR
> 
> I'm surprised at 20W since it also specifies compliance with FCC rules
> which as a max EIRP of 10W (though it does give a peak power emission of
> 20W). But I guess that's what it says.

I never received a response, so I went ahead and applied a version of
this patch with the adjustments I noted above.

Seth
