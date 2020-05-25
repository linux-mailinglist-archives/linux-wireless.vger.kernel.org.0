Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38941E0AED
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbgEYJoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYJoC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:44:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C095EC061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 02:44:01 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd9eK-002cG6-1E; Mon, 25 May 2020 11:44:00 +0200
Message-ID: <b3859a019b965a7a4053c1946a4cde441c0dbc75.camel@sipsolutions.net>
Subject: Re: Potential IBSS race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 25 May 2020 11:43:59 +0200
In-Reply-To: <CAPv5Ue5DY07E3=JDwjJkuad6Z3cuYtJg=dypUjy0KyBhn=JL9A@mail.gmail.com> (sfid-20200506_174456_293312_214B015A)
References: <CAPv5Ue5DY07E3=JDwjJkuad6Z3cuYtJg=dypUjy0KyBhn=JL9A@mail.gmail.com>
         (sfid-20200506_174456_293312_214B015A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-06 at 08:44 -0700, James Prestwood wrote:
> Hi,
> 
> It appears that when two IBSS networks are started at the same time
> they sometimes don't pick each other up and two separate IBSS networks
> are created. I have turned on IBSS logging and see beacons coming in
> from both networks AFTER each interface creates its own IBSS, but they
> dont come soon enough for either interface to realize there is already
> an IBSS.

I guess that makes some sense. Perhaps the number of scans should be
random, but then of course if they land on the same value, it'll still
happen.

> Is there any mitigation in the kernel or anything outlined in
> 802.11 that handles this case of two IBSS networks being created
> simultaneously (or close to it)? 

If neither of them has any other stations, then it should go into the
merge timer every 30 seconds. But if they're identical, then maybe even
that doesn't work since they'll go scanning at the same time, and again
fail?

Maybe that's a better approach - make the merge timer be randomized
between 30 and 60 seconds or so, so that they can eventually merge.

> Even delaying the second network by a
> full second sometimes results in this behavior.

A second isn't really sufficient I guess, because a full scan will take
5 seconds or so. That's the minimum you'd have to delay, I think. At
least if you're creating the network on a channel that's scanned early
in the scan (i.e. a 2.4 GHz channel).

johannes

