Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA512FA32
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2020 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgACQUC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 11:20:02 -0500
Received: from mx3.wp.pl ([212.77.101.9]:27460 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbgACQUC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 11:20:02 -0500
Received: (wp-smtpd smtp.wp.pl 10991 invoked from network); 3 Jan 2020 17:19:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1578068399; bh=Yv7Ci0NICOXQ+VDT8P0hxUqgm3v5amyFowMTqAMfJZA=;
          h=From:To:Cc:Subject;
          b=NIXiI59x9VFHOP3jhUKjGPQjrNt0V2CDvwA5r8D58cYkS/kw0W69sE0CZ92TTBlD8
           n4wUUngu7Rox1WNLZqoT6gGS4BhUeb8YM2NgEMi0NCWsFmx7ORSu7I9Gtod34cPALk
           o0/QJXdaHYVzI+hCkvOWElyZ6Whbhz8GZZ5Rh6iQ=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <dsimila82@hotmail.com>; 3 Jan 2020 17:19:59 +0100
Date:   Fri, 3 Jan 2020 17:19:58 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Daniel =?iso-8859-1?Q?Simil=E4?= <dsimila82@hotmail.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: mt76x0u. Unusable performance while compiling stuff.
Message-ID: <20200103161958.GA7186@wp.pl>
References: <270ccb561149f7af3596470b3f9bb2ec@wp.pl>
 <20200103121849.GA2832@wp.pl>
 <b335da869c0ae7d859a27ec4a26d8c35@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b335da869c0ae7d859a27ec4a26d8c35@wp.pl>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-WP-MailID: 5e9d1dfe29d8aae9f525d216ddc8009c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MZO0]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 03, 2020 at 03:30:18PM +0000, Daniel Similä wrote:
> Ok. I'm happy to test it. 
> But where do i download a patch or a complete tree?
> Sorry for my noobiness.

You can use 5.5-rcX kernel from kernel.org if your distribution
does not provide 5.5-rcX kernels already.

Patch can be downloaded from:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=284efb473ef5f02a7f2c13fdf8d516ecc589bdf1 

> fre 2020-01-03 klockan 13:18 +0100 skrev Stanislaw Gruszka:
> > (cc linux-wireless & Lorenzo)

Please do not drop CC , adding those back ...

Stanislaw


> > On Fri, Jan 03, 2020 at 12:19:20AM +0000, Daniel Similä wrote:
> > > Bus 001 Device 005: ID 148f:761a Ralink Technology, Corp. MT7610U ("Archer T2U" 2.4G+5G WLAN Adapter
> > > 
> > > Driver is mt76x0u
> > > Wifi is 5GHz ~260Mb
> > > 
> > > while doing:
> > > nice make -j16 
> > > 
> > > Pinging my router goes from:
> > > ping _gateway
> > > PING _gateway (192.168.0.1) 56(84) bytes of data.
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=1 ttl=64 time=1.20 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=2 ttl=64 time=1.02 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=3 ttl=64 time=2.12 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=4 ttl=64 time=1.32 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=5 ttl=64 time=2.04 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=6 ttl=64 time=1.31 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=7 ttl=64 time=1.71 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=8 ttl=64 time=0.903 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=9 ttl=64 time=1.00 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=10 ttl=64 time=1.42 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=11 ttl=64 time=1.15 ms
> > > 
> > > to unusable:
> > > 
> > > ping _gateway
> > > PING _gateway (192.168.0.1) 56(84) bytes of data.
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=1 ttl=64 time=167 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=3 ttl=64 time=306 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=4 ttl=64 time=255 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=6 ttl=64 time=253 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=8 ttl=64 time=84.7 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=9 ttl=64 time=522 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=10 ttl=64 time=211 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=11 ttl=64 time=304 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=15 ttl=64 time=2825 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=16 ttl=64 time=1812 ms
> > > 64 bytes from _gateway (192.168.0.1): icmp_seq=17 ttl=64 time=799 ms
> > > 
> > > Running kernel 5.4.6-arch3-1
> > > CPU is Amd 2700X and ram is 16GB
> > 
> > I think this should be fixed by 5.5 commit:
> > 
> > commit 284efb473ef5f02a7f2c13fdf8d516ecc589bdf1
> > Author: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date:   Mon Oct 28 17:38:05 2019 +0100
> > 
> >     mt76: mt76u: rely on a dedicated stats workqueue
> > 
> > and if it indeed fixes the problem, this commit should be requested
> > to stable.
> > 
> > Stanislaw
> 
