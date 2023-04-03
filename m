Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1D6D4D66
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjDCQTV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 12:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDCQTU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 12:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D7171C
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 09:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC9262110
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 16:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BE3C433D2;
        Mon,  3 Apr 2023 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680538757;
        bh=qWTCnLpgEni9/pyyMoun3r0gjRpTuUfI9r1kM+yuz2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfnIh2LZR1T78+uAdScowJY5wJMz/NfMjcHxEysNUZL9YzjhnVGOGKCh5P9iSRzIi
         5IJyzHBASaoKQ3vC4daYit+G8ReMoptjBYaU4wTKubrJjC1x99FylVcurplCWLJ4Xn
         ZlpycnRrZsmn9+n+Djhmrnd/LeCiM7tsamb3ds/sc5FtQL364oO9c+/rDrUcoDxugT
         a1xwIUJ6V7n4pBLvswZEtLIFEQ7mi+D7uW/5F8ithY21kHCT8Q0jWnHoZX3wz+dANo
         KKwaHokq9guefgaqSqJFucoyuxiQefTsrlJjVTPnB824We2cn3tjuMxoShFpcQ0f2F
         80QJsbLy1AK2A==
Date:   Mon, 3 Apr 2023 11:19:16 -0500
From:   "sforshee@kernel.org" <sforshee@kernel.org>
To:     Eric Sellman <gak_action@live.com>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: wireless-regdb: Update regulatory rules for USA on 5GHz
Message-ID: <ZCr8hM7gJpAVHSLQ@do-x1extreme>
References: <SJ0PR22MB249552E61991E3B2FAC911978F8F9@SJ0PR22MB2495.namprd22.prod.outlook.com>
 <ZCdSShqbJQ43gZZR@do-x1extreme>
 <SJ0PR22MB24959C931D27BDB56488B1DF8F8F9@SJ0PR22MB2495.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR22MB24959C931D27BDB56488B1DF8F8F9@SJ0PR22MB2495.namprd22.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 31, 2023 at 09:38:24PM +0000, Eric Sellman wrote:
> So who do I need to go to next to get this fixed?

It could be potentially be changed in the kernel, and
linux-wireless@vger.kernel.org is the right group of people. But there
are a lot of systems around running older kernels where the
wireless-regdb might still be getting updated. So we'd want to at least
make an effor to see that the change makes it to all the supported
stable and distro kernels, open AP firmware projects, etc before we
updated the database. That's likely to take a while.

I was about to propose an alternate idea, but then I went to check the
kernel source and I think that it already does what I was going to
propose. AUTO-BW means that a range can be combined with adjacent ranges
for what you called "band straddling," and it also allows the kernel to
automatically determine what bandwidth is supported. So all it should
need to do is not just consider the bandwiths for the individual ranges
but for the entire range which can be created by combining AUTO-BW
rules.

And I think it's already doing this. reg_get_max_bandwidth_from_range()
is called to determine the max bandwidth for a channel when the matching
rule has AUTO-BW set. This looks at the rules before and after the
matching rule, and the rules before and after those, etc, until it
reaches rules which are no longer adjacent. Then it returns a maximum
bandwidth which is the span of all the adjacent rules it found.

You haven't said if you're seeing an actual problem using 160 MHz
channels or if you just noticed the bandwidth is not 160 MHz in the
database. If you are having trouble, please provide details about what
you observe versus what you expect. Also note that a lot of wireless
hardware now comes with it's own in-firmware regulatory database which
will override the one loaded from userspace; you can run 'iw reg get'
and see if your hardware reports a "self-managed" set of rules.

Thanks,
Seth

> 
> Get Outlook for Android<https://aka.ms/AAb9ysg>
> ________________________________
> From: sforshee@kernel.org <sforshee@kernel.org>
> Sent: Friday, March 31, 2023 2:36:10 PM
> To: Eric Sellman <GAK_ACTION@live.com>
> Cc: wireless-regdb@lists.infradead.org <wireless-regdb@lists.infradead.org>; linux-wireless@vger.kernel.org <linux-wireless@vger.kernel.org>
> Subject: Re: wireless-regdb: Update regulatory rules for USA on 5GHz
> 
> On Fri, Mar 31, 2023 at 08:30:09PM +0000, Eric Sellman wrote:
> > First, I would like to state that I live in the USA And that this is my first time submitting a correction to the wireless-regdb.
> >
> > According to this list here >> https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/db.txt#n1727
> >
> > I only see VHT160 allowed to be utilized for 5500mhz to 5640mhz but there is no mention of VH160 being allowed for use with 5180 to 5320mhz.
> >
> > And according to this presentation here > https://transition.fcc.gov/oet/ea/presentations/files/may17/31-Part-15-Panel-UNII-UpdatesDT.pdf
> >
> > And this paragraph from this FCC document here > https://www.federalregister.gov/d/2014-09279/p-65
> >
> > "Band Straddling" is allowed with U-NII-1 and U-NII-2A. 5150mhz to 5330mhz
> >
> > Therefore, I would like you to add to the db that 5180 to 5320 can be used with vht160.
> 
> You are correct, however the kernel rejects the database if the max
> bandwidth for a range exceeds the size of the range for a given rule. So
> unfortunately we can't set the max bandwidth to 160 MHz.
> 
> Thanks,
> Seth
