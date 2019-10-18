Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A594DBDDA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 08:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504502AbfJRGsM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 02:48:12 -0400
Received: from jake.logic.tuwien.ac.at ([128.130.175.117]:41276 "EHLO
        jake.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfJRGsM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 02:48:12 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 02:48:11 EDT
Received: from burischnitzel.preining.info (a-fhn3-09120.noc.ntt-west.nsk.ne.jp [61.198.85.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by jake.logic.tuwien.ac.at (Postfix) with ESMTPSA id ADB87C03F7;
        Fri, 18 Oct 2019 08:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=logic.at; s=dkim;
        t=1571380979; bh=yXPJe8f9/EMHqnWtnxOaRN7s6KZqxS+PLBVMczjpsx0=;
        h=Date:From:To:Subject:From;
        b=S+Cri1OtrooI4HCtVJndn0MgvSFGd5kPOYw9HcBC4ZVrSg25uZ/+O6KP6H4ik8mqx
         JOnDpnjXQ3nryp3eJcbptOZZxEXWxp8kxGrQ6HmetP6QmaQp1/4gKOTnu7gVmEqeTT
         Tq5wBZWMhzCYKHV69j4I0JrJ84yrvIg2/wYN52DU=
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id EEEF66D2658A; Fri, 18 Oct 2019 15:30:22 +0900 (JST)
Date:   Fri, 18 Oct 2019 15:30:22 +0900
From:   Norbert Preining <preining@logic.at>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilw@linux.intel.com
Subject: IWL AC 8260, suspect GRP implementation, broken connectivity
Message-ID: <20191018063022.6bqunomkyqabgljc@burischnitzel.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear all,

(please cc)

linux 5.3.N (currently .7), but also older kernels
Debian/sid
Thinkpad X260
iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
iwlwifi 0000:04:00.0: loaded firmware version 36.8fd77bb3.0 op_mode iwlmvm

In one particular location I see completely broken connection: dns does
not work (resolve does not work), ping, ssh breaks down, http breaks
down, it really sounds like a really weak connection.

The problem is that:
- the *same* laptop booted into Windows works at high speed connections
- other computers (2 Mac) around here work without problems
- mobile also connects without any problem

There are no RX/TX errors whatsoever. I tried reducing MTU, to no
effect. The only warning I see is
	TCP: wlp4s0: Driver has suspect GRO implementation, TCP performance may be compromised.


wlp4s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1400
        inet 172.17.1.166  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::fddc:f32e:f9cb:fded  prefixlen 64  scopeid 0x20<link>
        ether e4:a7:a0:66:6d:f4  txqueuelen 1000  (Ethernet)
        RX packets 11164  bytes 7459009 (7.1 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 13204  bytes 3062515 (2.9 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

I am a bit at loss how to debug this, or better, whether it is possible
to get back normal connectivity?

Thanks a lot for any pointer

Norbert

--
PREINING Norbert                               http://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
