Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E11114E07
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 10:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfLFJND (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 04:13:03 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55338 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfLFJND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 04:13:03 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1id9fY-006E2l-7y; Fri, 06 Dec 2019 10:13:00 +0100
Message-ID: <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 06 Dec 2019 10:12:59 +0100
In-Reply-To: <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net> (sfid-20191206_094144_773877_4A5AF79B)
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
         <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
         (sfid-20191206_020554_916514_C4D7D41E) <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
         (sfid-20191206_094144_773877_4A5AF79B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-12-06 at 09:41 +0100, Johannes Berg wrote:
> 
> Maybe somehow TSO is interacting badly with the TXQs and the tracking
> here, since TSO makes the traffic *very* bursty? A 64k packet in the
> driver will typically expand to 9 or 10 A-MSDUs I think?

No, that all seems well. Without TSO (with the trivial mac80211 patch to
let me turn it off with ethtool) I get about 890Mbps, so about 5% less.
That's not actually *that* bad, I guess due to software A-MSDU in
mac80211, but it's not really the right direction :)

Changing wmem_max/tcp_mem to outrageous values also didn't really make
any difference.

I guess it's time to see if I can poke into the TCP stack to figure out
what's going on...

johannes

