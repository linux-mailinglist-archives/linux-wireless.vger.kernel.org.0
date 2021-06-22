Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70A3B0D3E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhFVS5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 14:57:05 -0400
Received: from mout02.posteo.de ([185.67.36.66]:33267 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhFVS5E (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 14:57:04 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 98CBF2400FD
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 20:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1624388086; bh=LdmLRkclcLoEv8LKf/cCoIimgviHSWuqyqwNEtjzJK0=;
        h=Subject:To:From:Date:From;
        b=T49dWTR4n7xhMlsShZbtYiO33KDTgOOJWBdWA8y2KpQPd8+a0chR15foPoABgIVJ6
         lEwloY4naxlJWj+PfebILZftMbCUZdqk5AN0PK8URGlPwRysDVm+jyFahuVY+nAgpo
         ArzI3e9iJ6xBr2vxISWdNLCN5raLCiJVffCHYMqXrR3/g0u7RST028hJauu7t/NtOn
         ZtWI2up3FvHYsHljL5LeKxwwZWCR0mQVrV60RE+HN8DQl396bf8WwHk1IkwMF9Aqp6
         vRZWta0H7GSqk/ABZtTuVHyBRlHTyVGUbMR6tTPMwn4pm2pkbwwODBghvIXxFPAmT0
         IOcOPyZO7nW1g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4G8bDP6g6dz6tmH;
        Tue, 22 Jun 2021 20:54:45 +0200 (CEST)
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
To:     Koen Vandeputte <koen.vandeputte@citymesh.com>,
        linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
 <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
 <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
 <8a3718e1-e988-c24a-d94f-34ba0f5349f4@citymesh.com>
 <339f7aa7-b7ee-b7a8-2e87-a96634c00a32@posteo.de>
 <bba886f3-4ce1-94b0-ea44-89ddc8c84e2b@citymesh.com>
From:   Petrosilius <petrosilius@posteo.de>
Message-ID: <ca99a4cc-eb7d-dfca-1d26-5b504a57e31f@posteo.de>
Date:   Tue, 22 Jun 2021 18:54:45 +0000
MIME-Version: 1.0
In-Reply-To: <bba886f3-4ce1-94b0-ea44-89ddc8c84e2b@citymesh.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22.06.21 14:03, Koen Vandeputte wrote:
>
> Thanks for confirming that.
>
> What would really help is a small table showing this:
>
> Real physical distance? (in m)
> ack_to reported while stressing the link:
>
> 20MHz: xx
> 10 MHz: yy
> 5 MHz: zz
>
> I'll try to simulate the issue somewhere in the next days.
>
>
> Please do note that ongoing effort is currently going on to improve
> dynack on lower distances.
>
> It was observed and reported by me to Lorenzo that ack_to was way
> higher than fixed settings when
> real distance is <6km
>
> Some testing patches were cooked and tested in the field last month
> covering long and short distances (1km up to 24km)
> and these are matching fixed distance ack_to very close now. (speeds
> using dynack were also higher than fixed settings)
> It's not finalized yet.
>
> Also do note that dynack only shows (any) benefit when having links >3km
> Below that, timing jitter and processing time seems to have more
> influence on ack_to than actual distance.
>
> Regards,
>
> Koen
>
Here the testresults

real physical distance: 1m

BW: 20mhz
ackto: 50
iperf3
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  86.4 MBytes  72.4 Mbits/sec    0             sender
[  5]   0.00-10.01  sec  86.0 MBytes  72.0 Mbits/sec                 
receiver

BW: 5mhz
ackto: 50
iperf3
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec  45.2 KBytes  37.0 Kbits/sec   14             sender
[  5]   0.00-10.07  sec  5.66 KBytes  4.60 Kbits/sec                 
receiver

BW: 10mhz
ackto: 50
iperf3
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   127 KBytes   104 Kbits/sec   30             sender
[  5]   0.00-14.10  sec   107 KBytes  62.4 Kbits/sec                 
receiver

Also longer iperf3 tests didnt change anything on this behaviour.

After this test we were actually able to get the ack_to doing something
for 5mhz (ack_to 641 - ~12MBit iperf3) and 10mhz (ack_to 258 - ~14MBit
iperf3) by doing some random wifi-restarts (using openwrt 'wifi'
command) and reboots, but this is not really reproducible.

We got the gutfeeling that there might be some issue reseting of the
dynack part when changing the bandwidths. This might explain, why for
the test above the ack_to doesnt change at all from the 50 of the 20Mhz
BW. Or is this normal behaviour that the ack_to doesnt change after a
bandwidth change?

Another observation: Is it normal that 'iw dev' doesnt show 5 & 10 MHz,
but always 20 MHz? (We verified that we actually get 5/10MHz Channels by
checking visibility of the AP with other clients).

To rule out a hardware problem: We used the same hardware successfully
on a 8km/20MHz link with dynack.

Regards,

Julian

