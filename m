Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309C21E1FE7
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 12:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgEZKjz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 06:39:55 -0400
Received: from ns.iliad.fr ([212.27.33.1]:38538 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731918AbgEZKjx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 06:39:53 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2020 06:39:52 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1B22221396;
        Tue, 26 May 2020 12:33:03 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ns.iliad.fr (Postfix) with ESMTPS id 0D36521326;
        Tue, 26 May 2020 12:33:03 +0200 (CEST)
Date:   Tue, 26 May 2020 12:33:01 +0200
From:   Maxime Bizon <mbizon@freebox.fr>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Subject: Re: Regarding .wake_tx_queue() model
Message-ID: <20200526103301.GK25121@sakura>
References: <20200504193959.GC26805@sakura>
 <878si6oabp.fsf@toke.dk>
 <20200505131531.GA32619@sakura>
 <87368eo5dn.fsf@toke.dk>
 <20200505152010.GA33304@sakura>
 <ac76e45633dbafb07c2086b0eeee823f5a4f5a0b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac76e45633dbafb07c2086b0eeee823f5a4f5a0b.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue May 26 12:33:03 2020 +0200 (CEST)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Monday 25 May 2020 à 11:47:01 (+0200), Johannes Berg wrote:

> This stuff is a mess. I had a plan once to just rip it all out and
> combine it all with the TXQs, but not only is it hard to test, we've
> also offloaded this stuff to the firmware for our devices, so motivation
> is pretty low.

I understand.

I have softmac type of devices (ath9k type, host side aggregation)
that I'd like to keep updating for awhile, so I'd rather have a
helping stack.

If anyone here has the experience, time and testing capabilities to do
this big rework/cleanup, I may be able to get this funded, drop me an
email.

-- 
Maxime
