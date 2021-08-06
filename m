Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3046E3E3063
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Aug 2021 22:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhHFUgq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhHFUgq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 16:36:46 -0400
X-Greylist: delayed 1064 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Aug 2021 13:36:30 PDT
Received: from scc-mailout-kit-01.scc.kit.edu (scc-mailout-kit-01.scc.kit.edu [IPv6:2a00:1398:9:f712::810d:e751])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015EDC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Aug 2021 13:36:29 -0700 (PDT)
Received: from akkmail.akk.kit.edu ([2a00:1398:5:f602:2::2] helo=akkmail.akk.org)
        by scc-mailout-kit-01.scc.kit.edu with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (envelope-from <jreusch@akk.org>)
        id 1mC6Ih-0006iK-Fj; Fri, 06 Aug 2021 22:18:42 +0200
Received: from akk24-int.akk.uni-karlsruhe.de ([172.22.9.216] helo=akk29neu)
        by akkmail.akk.org with esmtp (Exim 4.92)
        (envelope-from <jreusch@akk.org>)
        id 1mC6Ig-0001Et-1c; Fri, 06 Aug 2021 22:18:38 +0200
Received: from jreusch by akk29neu with local (Exim 4.94.2)
        (envelope-from <jreusch@akk.org>)
        id 1mC6If-000YYI-GL; Fri, 06 Aug 2021 22:18:37 +0200
Date:   Fri, 6 Aug 2021 22:18:37 +0200
From:   Jan Reusch <jan@jreusch.de>
To:     linux-wireless@vger.kernel.org, pkshih@realtek.com
Subject: RE: Difficulty connecting to AP using rtw89
Message-ID: <YQ2ZHTCCzbXil+9Y@akk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2551f3d4aff248e29118a2c6339e4d96@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey hey
Hope this works and gets sorted right, i had to manually set the
in-reply-to header.

I'm one of the people having problems with ipv6 and the rtw89 driver.
i've tested it with the debian bullseye kernel and vanilla 5.13 from
kernel.org

It's about a Realtek 8852 in a Thinkpad E14 Gen2 (amd).

> > The driver handles L2 things only, but IPv6 that is L3 that we don't
> > have special deal.
> > Could I know the problem you met?

Yep that was also my first reaction 1:1, but it's 100% repdoducible.
Ethernet connection works, i get an v4 adress and an v6 one (SLAAC), it
works flawlessly with an USB wifi stick, but the integrated wifi only
gets the link local ipv6 address,  an ipv4 one but nothing more.
I've tried to dump router advertisements, but none of them pop up. (As
soon as i attach the ethernet cable/usb wifi stick they're there...)
I have around ~10 other devices in the same network, all of them get
without any hazzle an v6 address via SLAAC and since some other people
seem to have the same problem in the github issue i'm really suspecting
the driver here...

If it maybe helps: this is what i get als output from ip(8) on a wifi
usb stick:
59: wlx801XXXXXXXXX: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
state UP group default qlen 1000
   link/ether 80:1f:XX:XX:XX:XX brd ff:ff:ff:ff:ff:ff
   inet 192.168.64.113/24 brd 192.168.64.255 scope global dynamic
noprefixroute wlx801XXXXXXXXX
      valid_lft 862412sec preferred_lft 862412sec
   inet6 fd00::1245:XXXX:XXXX:XXXX/64 scope global dynamic noprefixroute
      valid_lft 6718sec preferred_lft 3118sec
   inet6 2a02:8071:2cc3:XXX:XXXX:XXXX:XXXX:XXXX/64 scope global
dynamic noprefixroute
      valid_lft 6718sec preferred_lft 3118sec
   inet6 fe80::XX:XXXX:XXXX:XXXX/64 scope link noprefixroute
      valid_lft forever preferred_lft forever 

and this is what i get on the 8852:
4: wlp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP group default qlen 1000
   link/ether 74:4c:XX:XX:XX:XX brd ff:ff:ff:ff:ff:ff
   inet 192.168.64.112/24 brd 192.168.64.255 scope global dynamic
noprefixroute wlp3s0
      valid_lft 863997sec preferred_lft 863997sec
   inet6 fe80::XXXX:XXXX:XXXX:XXX/64 scope link noprefixroute
      valid_lft forever preferred_lft forever 

i'd be glad to help to debug this any further, currently i'm also out of
ideas how the driver could impact L3...


> I'm not sure if ISP limits the throughput or not.
> My suggestion is to have another PC connected to AP with ethernet cable.
> Then,
> do performance test between two PCs to check the difference between IPv4
> and IPv6.

Please do not confused by this throughput problem, that's completely
independent.
The ipv4 performance of the driver seems to be enough, though i did not
measure it, but it's also not noticable slow :)
The only problem for me personally is that i only have a DS-Lite
connection from my ISP, which means for v4 i'm behind a carrier grade
nat - and the gateway (of the carrier) where my v4 traffic is routed
through seems to be heavily overloaded during some hours of the day.
So no worries for the driver here at all ;)

Thanks!
Cheers
Jan


-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread
 If you dont know what ~/.signature means , dont get your panties in a
               knot, you already have a WinSBuLcOkWss virus.!
