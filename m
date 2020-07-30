Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F62333ED
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgG3OIe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgG3OId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:08:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FAC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:08:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k19EW-00DZFm-3Y; Thu, 30 Jul 2020 16:08:32 +0200
Message-ID: <65bbc2f69fe966d471eff3287a191919311ac641.camel@sipsolutions.net>
Subject: Re: Lost beacon behavior changed as of 01afc6fed (hwsim)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 30 Jul 2020 16:08:31 +0200
In-Reply-To: <ada14dfad76b93d654606c3b397de059d968096b.camel@gmail.com> (sfid-20200702_001244_354404_5FEC9FBA)
References: <ada14dfad76b93d654606c3b397de059d968096b.camel@gmail.com>
         (sfid-20200702_001244_354404_5FEC9FBA)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi James,

> First off, everything described here is using mac80211_hwsim. I have
> not tested if any of this happens on physical hardware or not.
> 
> Commit 01afc6fed seems to have changed the kernel behavior with regard
> to lost beacons. So much so that it completely breaks all roaming tests
> for IWD and (if kept this way) will require severe changes to the
> existing roaming logic we have used for quite a long time. Plus
> supporting older kernels AND this new behavior is going to be quite
> annoying to deal with.
> 
> Before, the kernel would only send a lost beacon QCM event when it
> detected beacon loss. This allowed us to scan, find a suitable BSS to
> roam to, and then roam.
> 
> Now it also sends Del Station, Deauthenticate, and Disconnect all
> immediately after a lost beacon, and the disconnect reason being
> DISASSOC_DUE_TO_INACTIVITY (4). We handle these extra events as we
> would at any other time, and fully disconnect which prevents us from
> being able to roam quickly (as well as breaking tests).
> 
> Looking at that commit nothing particular jumps out at me, but
> obviously those added flags are causing something else to send these
> extra events.
> 
> Was this change actually intended to cause these extra events? And if
> so, why was it changed?

I don't think that was intentional.

But really that was meant only to enable support for *powersave*.

I suspect that the changes are actually caused by
adding REPORTS_TX_ACK_STATUS, which is in fact necessary here.


But I suspect that it could be that you're testing this in the wrong
way? From your description, it almost seems like you turn off the AP
interface, and roam after that? I'm not sure that's really realistic. If
you wanted to test the "a few beacons were lost" behaviour, then you'd
really have to lose a few beacons only (perhaps by adding something to
wmediumd?), and not drop the AP off the air entirely.

If the AP is in fact completely unreachable, then I'm pretty sure real
hardware will behave just like hwsim here, albeit perhaps a bit slower,
though not by much. And then you'd have the same issue there.

The fact that hwsim behaved differently would likely have been just a
timing thing - it didn't advertise REPORTS_TX_ACK_STATUS, so we'd wait a
bit longer until deciding that the AP really was truly gone. If the ACK
status is reported we just send a (few?) quick nullfunc(s) and decide
that very quickly. But that's independent on hwsim or real hardware.


johannes

