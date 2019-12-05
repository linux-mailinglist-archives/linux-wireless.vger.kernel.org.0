Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86D16114699
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfLESI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 13:08:59 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:59412 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 13:08:59 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icvYf-004MPF-T2; Thu, 05 Dec 2019 19:08:58 +0100
Message-ID: <d8a745a7b0658c65b7e1beb12a9e2e1918cc77c7.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 05 Dec 2019 19:08:55 +0100
In-Reply-To: <CAPB2EAong6X2_gazqJUxs968Kb9EG3Eob2TcSJwCcuMP2p9-7w@mail.gmail.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <CAPB2EAong6X2_gazqJUxs968Kb9EG3Eob2TcSJwCcuMP2p9-7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-12-05 at 18:12 +0100, Toke Høiland-Jørgensen wrote:
> 
> I'm on mobile, so briefly:
> 
> What you're describing sounds like it's TCP congestion control kicking
> in and throttling at the stack. 

Agree, though need to think about the UDP scenario more. It's faster,
but that's expected since it doesn't have the ACK backchannel, and it's
not that *much* faster.

> The "new flows" increasing is consistent with the queue actually
> running empty (which you also see in the warnings).

Oh, right ok. That makes sense, it just loses info about the flow once
the queue is empty.

> My hand-wavy explanation is the the TCP stack gets throttled and
> doesn't get going again quickly enough to fill the pipe. Could be a
> timing thing with aggregation? As I said, hand-wavy ;)

So I should need deeper *hardware* queues to make up for the timing?

Thing is, sometimes I even see the queue empty, then there are *two*
MTU-sized frames, and then it's empty again - all the while there are
only ~40 frames on the hardware queue. You'd think the higher layer
would, once it starts feeding again, actually feed more?

Hmm. Actually, I wonder why I'm not seeing TSO, something to check
tomorrow.

johannes

