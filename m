Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B996115E66
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2019 21:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLGUJ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Dec 2019 15:09:26 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:60786 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfLGUJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Dec 2019 15:09:26 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1idgOF-00Aana-4D; Sat, 07 Dec 2019 21:09:19 +0100
Message-ID: <c2004c4d9defd9c391e072b2703a845185bd395e.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>, Kan Yan <kyan@google.com>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Sat, 07 Dec 2019 21:09:17 +0100
In-Reply-To: <336996e4-d9fe-bf3a-72fb-6919bd0adcbf@candelatech.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
         <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
         <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
         <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
         <9bcbab4b562669b96198c632f476b1b74956ca09.camel@sipsolutions.net>
         <336996e4-d9fe-bf3a-72fb-6919bd0adcbf@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-12-06 at 15:44 -0800, Ben Greear wrote:
> I did some tests today:
> 
> kernel is 5.2.21+, with the fix for ax200 upload corruption bug.
> AP is QCA 9984 based PC (i5 processor) running ath10k-ct firmware/driver, configured for 2x2 160Mhz
> STA is PC (i5 processor) with AX200
> OTA, about 5 feet apart
> AP reports STA is sending at MCS-9 160Mhz (AX200 STA does not report tx rate it seems)

Yeah, that was an oversight for HE, it should work for HT/VHT. I have a
patch in the works to report the TX rate properly in iw.

> Our LANforge tool is traffic generator, running directly on AP and STA machine.
> 
> Download UDP, I see about 697Mbps goodput
> Upload UDP, I see about 120Mbps goodput
> 
> TCP download, about 660Mbps
> TCP upload, about 99Mbps
> 
> Our hacked version of pktgen, bps includes down to Ethernet frame:
> Download: 740Mbps
> Upload: 129Mbps

Uh, wow, that's not good. I guess after I'm done with this bug, I should
look at upstream ...

> I changed AP to 80Mhz mode, and re-ran the UDP tests:
> 
> Upload 137Mbps
> Download 689Mbps
> 
> Though not confirmed today, one of us reports about 1.7Gbps download on AX200 against an enterprise /AX AP,
> and only abuot 600Mbps upload in that same system.  That is in isolation chamber and such.
> 
> So, for whatever reason(s), we see consistent poor upload performance on AX200.
> 
> For reference, we have previously seen about 1.1Gbps upload between QCA9984 station and 4x4 /AC APs
> (and about 1.3Gbps download goodput), so in general, wifi upload can run faster.

Yes, for sure it can. Would be interesting to find out what the limiting
factor is for you.

Then again, I doubt we've released updated firmware recently - what
version are you using?

johannes

