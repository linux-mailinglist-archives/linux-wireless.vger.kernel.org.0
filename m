Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D44E18F175
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 10:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCWJLU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 05:11:20 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43406 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgCWJLU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 05:11:20 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGJ77-001kWE-Q9; Mon, 23 Mar 2020 10:11:17 +0100
Message-ID: <1a1f5c11f51c4c2fe2a5e82e32e431986f88bddb.camel@sipsolutions.net>
Subject: Re: Simulate Radio wave interference
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Masashi Honma <masashi.honma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 10:11:15 +0100
In-Reply-To: <8f783032-8999-18aa-5980-8a87427fddd8@gmail.com> (sfid-20200322_013435_732971_2F177BB6)
References: <fb4be9f4353193a789e4a6cdc4b35c096d2efd7f.camel@sipsolutions.net>
         <8f783032-8999-18aa-5980-8a87427fddd8@gmail.com>
         (sfid-20200322_013435_732971_2F177BB6)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-03-22 at 09:34 +0900, Masashi Honma wrote:
> On 2020/03/17 0:42, Johannes Berg wrote:
>  > I don't see this - the signal strength is just taken as is, and
>  > overwritten, so there's no accumulation going on?
> 
> Right. The signal strength is not accumulated. The commit log is wrong.

OK.

> The interference model is accumulating frame duration to calculate
> probabilities.

But it's doing it on the *previous* interval, and then affects the
*next* interval, right? In terms of timing.

I don't really have any objection to this, just trying to understand it
- mostly because I'm trying to use wmediumd for simulation and want the
timing to be better at least in that case.

> I think I should explain the concept of this interference model.
> The interference model assumes signals which strength is under CCA
> threshold are interference signal. The model accumulates the duration
> of such signals. The model assumes (accumulated duration / time slot)
> is probability of occurrence of interference. When interference occurs,
> the model reduce the max signal strength of interfering STA from
> transmitting STA's signal strength.

Right. What threw me off was the fact that it's accumulated over a
previous period, and then affects the current period, which seemed odd
because I was thinking about my simulation more than just an arbitrary
model. I guess it's fine for whatever you were trying to achieve, and
simply doesn't fit what I'm trying to do.

I'll need to figure out how to reconcile the different ways of thinking
here.

> Though the implementation is not among the concept of the model. The
> signal strength from node A to B was calculated and wrongly accumulated
> to interference duration of "A to all".

Heh, ok.

> I fixed it to "A to B" and sent a Pull Request to wmediumd.
> https://github.com/bcopeland/wmediumd/pull/22

I _really_ didn't mean to coax you into fixing anything, just trying to
understand. That said, those changes look good to me.


> To get closer to real world, it is necessary to consider the phase of
> radio wave. A radio wave could be weakened by radio waves which has
> opposite phase.

While that's true, is it really necessary? Even if the signals are in
phase, you're going to have a hard time differentiating between the two,
and the frame will be lost either way, no?

I think from a timing aspect, checking if two signals are in phase will
be practically impossible - we're talking about less than 1us timing
differences (0.2 at 5 GHz), if I'm doing the math correctly?

> Calculation of radio wave phase of multi signals could be described by
> electric field created by mesh node antenna. By using this electric
> field model, we could accumulate some interference signals as vector.
> 
> I have an idea of implementation. Though I need some more time to
> implement this.

Again, for the record, I really just wanted to clarify that I was
understanding things correctly! Not to coax you into implementing
anything.

Thanks for the help!

johannes

