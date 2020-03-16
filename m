Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16A3186ED2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2020 16:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbgCPPmc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Mar 2020 11:42:32 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37732 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbgCPPmb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Mar 2020 11:42:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jDrsr-00GkBO-Nr; Mon, 16 Mar 2020 16:42:29 +0100
Message-ID: <fb4be9f4353193a789e4a6cdc4b35c096d2efd7f.camel@sipsolutions.net>
Subject: Re: Simulate Radio wave interference
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Masashi Honma <masashi.honma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 16 Mar 2020 16:42:28 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

It's a bit over three years ago you wrote this, so perhaps you won't
really remember, but I'm not sure I can make sense of the code and
wanted to ask if you can help out.

In particular, I'm wondering about the timing aspects of this
interference simulation.

The commit message says:

> In real space, there could be interference of radio waves. This commit
> considers a radio wave which has signal strength under
> CCA_THRESHOLD(-90) causes interference. This commit accumulates such
> radio wave signal strength and decreases it from tx power.

I don't see this - the signal strength is just taken as is, and
overwritten, so there's no accumulation going on?

And the timing is just odd - the duration of the interference is added
to at the *end* of each transmission, and every 10 ms the duration of
the interference is calculated into a probability?


I'd have expected this to be something like have a list of signals, with

 * transmitter (location)
 * signal strength

added to the list at the beginning and removed at the end. Or
alternatively, perhaps easier to use, for each destination station the
cumulative noise received at there from far away transmissions, already
weighed by distance (though that's tricky since stations can move).

Then, when actually "transmitting" the frame, check that value, or sum
up all the lists by location/fading by distance.


I guess my question really is how what's actually implemented is meant
to map to the physical world?


Thanks,
johannes

