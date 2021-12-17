Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03844796CE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 23:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhLQWCo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 17:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhLQWCn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 17:02:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A2C061574
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 14:02:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AFE623E7
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 22:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51344C36AE2;
        Fri, 17 Dec 2021 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778562;
        bh=P0TnB0kDykwRRWMRFMst20dm5CBDqBM0RDMlHX4bydY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoiY//Q9pk19B4dJEjQWFK4RTRr9SnDpAoqXCayk0RqISznsKtjsJ8lM0jhDZ60cL
         7AsddbnM1GzXoJiMwHxSFHzFSszjF9fmFXjknqtWyY8rOGwVKlworuTkc6RtF2T4jg
         JnQpqEjI8PRm/mLTAHPT+thZ2nKSO6pKYXfMZDhOYhfwawp0rwIQxfI9k3A1Qz+wgT
         XCS/cUG4EtnSp/0hHSurgS8G5uoCq2kQJKG7UOUe3DywNmAU4o01oFQr+bZg4HMqIl
         FhhQ03lZCrEBuAVNmTJ5J2mdWlLZhmj4vkBXWBrmQMyRbJPb3ay2HbTCC16c65Z4jK
         /swjR1MQvjgiQ==
Date:   Fri, 17 Dec 2021 16:02:41 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for South
 Korea (KR)
Message-ID: <Yb0JAXsCnjnIQ9c9@ubuntu-x1>
References: <20210929172728.7512-1-mans0n@gorani.run>
 <20211024113821.51538-1-mans0n@gorani.run>
 <YXmVLUzVEgrAMLwL@ubuntu-x1>
 <4f05b6b1-084d-9046-4c63-6975c25d7615@gorani.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f05b6b1-084d-9046-4c63-6975c25d7615@gorani.run>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Oct 30, 2021 at 01:12:08AM +0900, Sungbo Eo wrote:
> On 2021-10-28 03:06, Seth Forshee wrote:
> > On Sun, Oct 24, 2021 at 08:38:21PM +0900, Sungbo Eo wrote:
> > > This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
> > > Equipment Established Without Notice"), officially announced on 2021-01-06.
> > > 
> > > The PSD must not exceed 2.5 mW/MHz if the frequency range includes all or
> > > part of 5230-5250 MHz and the bandwidth is equal to or less than 40 MHz.
> > > This leads to the following:
> > > * 5230-5250 @ 20 -> 17 dBm
> > > * 5210-5250 @ 40 -> 20 dBm
> > > Here the power limits for 80/160 MHz bandwidth are also lowered to 17 dBm,
> > > as it's not possible to set different power limits for different bandwidths
> > > at the moment.
> > > 
> > > Extend the last 5 GHz frequency range to 5850 MHz.
> > > 
> > > WiFi 6E is now allowed with the following restrictions:
> > > * Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 250mW EIRP
> > > * Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25mW EIRP
> > > Here only the former entry is added.
> > > 
> > > And also update the regulatory source links.
> > > 
> > > Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> > > ---
> > > v2:
> > > * split 5150-5250 MHz band rule to accommodate the PSD limit
> > > * remove AUTO-BW flag from 6 GHz band rule
> > > ---
> > >   db.txt | 17 ++++++++++++-----
> > >   1 file changed, 12 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/db.txt b/db.txt
> > > index 6e8dbef..387ac93 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -862,15 +862,22 @@ country KP: DFS-JP
> > >   	(5490 - 5630 @ 20), (30), DFS
> > >   	(5735 - 5815 @ 20), (30)
> > > +# Source:
> > > +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196972
> > > +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196973
> > > +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196974
> > >   country KR: DFS-JP
> > > -	# ref: https://www.rra.go.kr
> > >   	(2400 - 2483.5 @ 40), (23)
> > > -	(5150 - 5250 @ 80), (23), AUTO-BW
> > > +	(5150 - 5210 @ 40), (23), AUTO-BW
> > > +	# max. PSD 2.5 mW/MHz in 5230-5250 MHz frequency range
> > > +	(5210 - 5230 @ 20), (20), AUTO-BW
> > > +	(5230 - 5250 @ 20), (17), AUTO-BW
> > 
> > Even with 5210-5230 split out like this, 5210-5250 @ 40 still gets
> > limited to 17 dBm by the 5230-5250 rule. So why do we need to split out
> > 5210-5230 separate from 5150-5210?
> 
> I did some tests with regdb and I found out that the rule to be applied
> depends on the main 20 MHz channel. With the rules above, if I select
> channel 48 (5230-5250) and enable VHT40, then the TX power is set to 17 dBm.
> OTOH if I select channel 44 (5210–5230) and enable VHT40, then the TX power
> is set to 20 dBm. I'm not sure whether my result is really correct, though.

I'm sorry, when I saw the v3 patch I realized that I forgot to reply to
this email. I had wanted to take a look at the kernel source to try and
understand the behavior you described.

I took a quick look, and from what I'm seeing the minimum of the power
limits for the two ranges should be used. This is the behavior I expect.
Can you provide more detail about how you're getting that result?

Thanks,
Seth
