Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29414248BC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhJFVUy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 17:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239603AbhJFVUx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 17:20:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E861E611C1;
        Wed,  6 Oct 2021 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633555141;
        bh=KipSEYG2JvGtJbo74srEgGzL10+fE/pd4lI1kQ3DUIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZtn7a2KEujuB6uoCZSiskZvZnNvTgXfVm2vjy4MEDdHpQvWi3TAUzt3+afjjc5Uw
         65/1xxHyq1enaT/vtUpLRumYLc+iZ5FP8zaZVMuSkVj5aNh5O6Rug0lj2/U4ogz+E9
         7x/kjkRJQdcge2f44ygX24Gu83CY6xiMELSf3ETHneMtwy3Ot7fS8kGd6bRE+p+3NE
         9XiZ1PY52byMEvtifsyeBGoqy0L1RWE9o6XU1HhQ/C3DpltpGngx+ghn6qYU14nU2J
         nM0kGkaJ5bEA9BxfHykLTnXh046AxpF+3fPvWrXDDBD+SSn2tEOhoSv6dOdT4Lix0f
         8TqM6/IraK06A==
Date:   Wed, 6 Oct 2021 16:16:34 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for South Korea (KR)
Message-ID: <YV4SMhi4BmFDMVgz@ubuntu-x1>
References: <20210929172728.7512-1-mans0n@gorani.run>
 <YV2tukujds7PodAf@ubuntu-x1>
 <a4cb97fc-de32-4d15-47a5-a7ad26bd32ab@gorani.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4cb97fc-de32-4d15-47a5-a7ad26bd32ab@gorani.run>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 07, 2021 at 04:18:01AM +0900, Sungbo Eo wrote:
> On 2021-10-06 23:07, Seth Forshee wrote:
> > On Thu, Sep 30, 2021 at 02:27:28AM +0900, Sungbo Eo wrote:
> > > This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
> > > Equipment Established Without Notice"), officially announced on 2021-01-06.
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
> > > I have two questions.
> > > 
> > > The regulation has one more restriction:
> > >    The TX power should not exceed 2.5 mW/MHz
> > >    when the frequency range includes the whole or a part of 5230-5250 MHz
> > >    and the bandwidth is equal to or less than 40 MHz.
> > > That leads to the followings:
> > >    5230-5250 @ 20 -> 17 dBm
> > >    5210-5250 @ 40 -> 20 dBm
> > >    5170-5250 @ 80 -> 23 dBm
> > > Is it possible to add this rule without lowering the TX power for 80 MHz bandwidth?
> > 
> > I've tried to look at the documents, but much of the information appears
> > to be in images where machine translation doesn't work, and I haven't
> > been able to find English versions.
> 
> Oops, sorry. I should have prepared it in more convertible format.
> There's no English version of it, but at least I could find a HWP document
> file [1] that contains regular tables instead of images. (The URL is from
> the "attached files" tab in the source link.)
> 
> You can open it with a dedicated viewer [2] or an online viewer [3]. But
> those free viewers do not offer conversion to DOC or HTML. (It seems the
> dedicated one has "print to PDF" feature, though.)
> 
> I also tried an online convert tool but it failed due to the long processing
> time... I can send you converted versions myself if you prefer.
> 
> [1] https://www.law.go.kr/LSW//flDownload.do?flSeq=93728653
> [2] https://www.hancom.com/cs_center/csDownload.do
> [3] https://hwp.polarisoffice.com/
> 
> > 
> > Taking the above at face value, I actually get slightly lower EIRP
> > values for a PSD of 2.5 mW/MHz (EIRP = PSD + 10 * log(bandwidth)): 16
> > dBm for 20 MHz and 19 dBm for 40 MHz.
> 
> I thought log(2.5) equals 0.4? We also have 2.5 mW/MHz * 40 MHz = 100 mW.

Yeah ... I did the math again and your numbers are right, guess I made a
mistake the first time.

> > We don't currently have any way to
> > express PSD limits in the database nor a way to express different power
> > limits for different bandwidths, so it's not possible to comply with the
> > PSD limits for 20/40 MHz without also lowering the EIRP for 80 MHz.
> 
> Too bad. :( I'll prepare v2 soon.
> 
> > 
> > > And do we need AUTO-BW for 6E channels? I thought it is for merging adjacent frequency ranges.
> > 
> > That is correct. Since there are no adjacent rules, AUTO-BW doesn't make
> > sense.
> 
> Okay, thanks!
> 
> Regards,
> Sungbo
> 
> > 
> > Thanks,
> > Seth
> > 
> 
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
