Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD732114DB8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 09:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFIlm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 03:41:42 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54524 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfLFIlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 03:41:42 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1id9BD-006A2o-9P; Fri, 06 Dec 2019 09:41:39 +0100
Message-ID: <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 06 Dec 2019 09:41:38 +0100
In-Reply-To: <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com> (sfid-20191206_020554_916514_C4D7D41E)
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
         <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
         (sfid-20191206_020554_916514_C4D7D41E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Thanks!

On Thu, 2019-12-05 at 17:05 -0800, Kan Yan wrote:
> > Anyhow, do you have any tips on debugging this? This is still without
> > AQL code. The AQM stats for the AP look fine, basically everything is 0
> > except for "new-flows", "tx-bytes" and "tx-packets".
> 
> If the "backlog" field is also 0, then it is a sign that the TCP stack
> is not feeding packets fast enough.

Mostly, not always. One thing I do noticed there now is that I get like
64k packets into the driver.

Maybe somehow TSO is interacting badly with the TXQs and the tracking
here, since TSO makes the traffic *very* bursty? A 64k packet in the
driver will typically expand to 9 or 10 A-MSDUs I think?

> > One thing that does seem odd is that the new-flows counter is increasing
> > this rapidly - shouldn't we expect it to be like 10 new flows for 10 TCP
> > sessions? I see this counter increase by the thousands per second.
> 
> This could be normal. When a flow queue is completely drained, it will
> be deleted. Next packet will be in the "new_flows". This is another
> sign of the bottleneck maybe at TCP stack.

Right, Toke pointed that out too.

> >  CPU load is not an issue AFAICT, even with all the debugging being
> > written into the syslog (or journal or something) that's the only thing
> > that takes noticable CPU time - ~50% for systemd-journal and ~20% for
> > rsyslogd, <10% for the throughput testing program and that's about it.
> > The system has 4 threads and seems mostly idle.
> 
> What's CPU usage for software irq? Is CPU usage average of all cores? 
> Maybe the core that handles packet processing or softirq is maxed out
> even the average is fine.

Agree, I didn't really say that well. I'm really just ballparking this
by using 'top', but even the *most* loaded of the 4 CPUs (threads?) is
at >80% idle, <6% softirq and <12% sys for the duration of the test.

> Are you using iperf or netperf? increase the TCP windows size may
> help. Adjust things like "net.core.wmem_max" and "net.ipv4.tcp_mem"
> maybe necessary to enable iperf to use larger windows.

Chariot :)

Anyway, this had no effect. I'll go play with the TSO next, for some
reason our driver won't let me disable it dynamically (I guess I should
just fix that).

johannes

