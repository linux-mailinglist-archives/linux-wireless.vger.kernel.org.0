Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4115C48E001
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 22:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiAMV7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 16:59:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59756 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiAMV7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 16:59:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA2CC61C14
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 21:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4D4C36AEA;
        Thu, 13 Jan 2022 21:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642111153;
        bh=F1zXefHp3rLvfmHib8b5uVoxPX3G7+ZDlnh6gyOGpqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3TxsFulhUmzROxoSpW1exWdWtIVAWVCIAqnYWtJL6Om+8HwKtqAcC6JRqOYe4iFV
         XkI2sZc/5MN0lkV4hs7yfDmG+jhh6niucX3uhzSGxkRI6dt7ZGARur/s8qRYh4E1pF
         +/rtMmcXdD6YaQ0p5eFiVY5AXiG3Tf/O8inOTMAoyeCm1/HO/10kb39zyVgV6Jccpa
         2a3fUiezssBSxU531+J/XQEYLKa45/mf9Vc36d/N6ruWokaF7x8acImykprWsDXa7U
         WvJ+CPZxOqsf663exxDF2kLcU2Q4OofUNh3fivEzK3c3OX8FnlLB3koP+2FNYCw7X7
         3UiumvJUgtvjg==
Date:   Thu, 13 Jan 2022 15:59:12 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for South
 Korea (KR)
Message-ID: <YeCgsJPwqFQiSmpa@ubuntu-x1>
References: <20210929172728.7512-1-mans0n@gorani.run>
 <20211024113821.51538-1-mans0n@gorani.run>
 <YXmVLUzVEgrAMLwL@ubuntu-x1>
 <4f05b6b1-084d-9046-4c63-6975c25d7615@gorani.run>
 <Yb0JAXsCnjnIQ9c9@ubuntu-x1>
 <b2288492-cdbd-0310-0951-cdee77fc3a79@gorani.run>
 <YcDxNCSoQh2XejK8@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YcDxNCSoQh2XejK8@ubuntu-x1>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 20, 2021 at 03:10:12PM -0600, Seth Forshee wrote:
> On Sat, Dec 18, 2021 at 04:31:17PM +0900, Sungbo Eo wrote:
> > On 2021-12-18 07:02, Seth Forshee wrote:
> > > On Sat, Oct 30, 2021 at 01:12:08AM +0900, Sungbo Eo wrote:
> > > > On 2021-10-28 03:06, Seth Forshee wrote:
> > > > > On Sun, Oct 24, 2021 at 08:38:21PM +0900, Sungbo Eo wrote:
> > > > > > This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
> > > > > > Equipment Established Without Notice"), officially announced on 2021-01-06.
> > > > > > 
> > > > > > The PSD must not exceed 2.5 mW/MHz if the frequency range includes all or
> > > > > > part of 5230-5250 MHz and the bandwidth is equal to or less than 40 MHz.
> > > > > > This leads to the following:
> > > > > > * 5230-5250 @ 20 -> 17 dBm
> > > > > > * 5210-5250 @ 40 -> 20 dBm
> > > > > > Here the power limits for 80/160 MHz bandwidth are also lowered to 17 dBm,
> > > > > > as it's not possible to set different power limits for different bandwidths
> > > > > > at the moment.
> > > > > > 
> > > > > > Extend the last 5 GHz frequency range to 5850 MHz.
> > > > > > 
> > > > > > WiFi 6E is now allowed with the following restrictions:
> > > > > > * Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 250mW EIRP
> > > > > > * Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25mW EIRP
> > > > > > Here only the former entry is added.
> > > > > > 
> > > > > > And also update the regulatory source links.
> > > > > > 
> > > > > > Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> > > > > > ---
> > > > > > v2:
> > > > > > * split 5150-5250 MHz band rule to accommodate the PSD limit
> > > > > > * remove AUTO-BW flag from 6 GHz band rule
> > > > > > ---
> > > > > >    db.txt | 17 ++++++++++++-----
> > > > > >    1 file changed, 12 insertions(+), 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/db.txt b/db.txt
> > > > > > index 6e8dbef..387ac93 100644
> > > > > > --- a/db.txt
> > > > > > +++ b/db.txt
> > > > > > @@ -862,15 +862,22 @@ country KP: DFS-JP
> > > > > >    	(5490 - 5630 @ 20), (30), DFS
> > > > > >    	(5735 - 5815 @ 20), (30)
> > > > > > +# Source:
> > > > > > +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196972
> > > > > > +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196973
> > > > > > +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196974
> > > > > >    country KR: DFS-JP
> > > > > > -	# ref: https://www.rra.go.kr
> > > > > >    	(2400 - 2483.5 @ 40), (23)
> > > > > > -	(5150 - 5250 @ 80), (23), AUTO-BW
> > > > > > +	(5150 - 5210 @ 40), (23), AUTO-BW
> > > > > > +	# max. PSD 2.5 mW/MHz in 5230-5250 MHz frequency range
> > > > > > +	(5210 - 5230 @ 20), (20), AUTO-BW
> > > > > > +	(5230 - 5250 @ 20), (17), AUTO-BW
> > > > > 
> > > > > Even with 5210-5230 split out like this, 5210-5250 @ 40 still gets
> > > > > limited to 17 dBm by the 5230-5250 rule. So why do we need to split out
> > > > > 5210-5230 separate from 5150-5210?
> > > > 
> > > > I did some tests with regdb and I found out that the rule to be applied
> > > > depends on the main 20 MHz channel. With the rules above, if I select
> > > > channel 48 (5230-5250) and enable VHT40, then the TX power is set to 17 dBm.
> > > > OTOH if I select channel 44 (5210–5230) and enable VHT40, then the TX power
> > > > is set to 20 dBm. I'm not sure whether my result is really correct, though.
> > > 
> > > I'm sorry, when I saw the v3 patch I realized that I forgot to reply to
> > > this email. I had wanted to take a look at the kernel source to try and
> > > understand the behavior you described.
> > > 
> > > I took a quick look, and from what I'm seeing the minimum of the power
> > > limits for the two ranges should be used. This is the behavior I expect.
> > > Can you provide more detail about how you're getting that result?
> > > 
> > > Thanks,
> > > Seth
> > 
> > I've got the result on MT7623+MT7615N AP with OpenWrt installed. (kernel
> > 5.10)
> > I set the channel and bandwidth in /etc/config/wireless (in OpenWrt-standard
> > way) and checked the tx power with `iw dev wlan0 info` and Android WiFi
> > Analyzer app.
> > 
> > # channel 48, htmode VHT40
> > type AP
> > channel 48 (5240 MHz), width: 40 MHz, center1: 5230 MHz
> > txpower 17.00 dBm
> > 
> > # channel 44, htmode VHT40
> > type AP
> > channel 44 (5220 MHz), width: 40 MHz, center1: 5230 MHz
> > txpower 20.00 dBm
> > 
> > The WiFi Analyzer app also reported higher RSSI for the channel 44 case.
> > 
> > I also had a quick look at net/wireless/reg.c and it seems you're right.
> > Perhaps my tests were bad, I do believe your comments more than my result.
> > ;)
> 
> That definitely seems odd. I'll try to have another look and see if I
> can figure out why that's happening. I'd have suspected that what's
> displayed by iw might just be a result of how the information is
> reported or displayed, but the higher RSSI argues against that.

I've spent a little more time looking at this. I think the issue is that
the regulatory rules are only used to establish channel definititions
for 20 MHz channels, and these channel definitions are what get used
when establishing tx parameters. While the flags are checked against the
chandefs of secondary channels, only the primary channel's power limits
are used for tx power. So I think the behavior of the kernel is incorect
here.

However, I think the regulatory database should reflect the regulatory
data as accurately as possible, so I'd prefer we not split out 5210-5230
and try to get the bug fixed in the kernel.

Thanks,
Seth
