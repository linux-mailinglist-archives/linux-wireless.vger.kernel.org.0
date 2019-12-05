Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE7114825
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 21:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfLEUf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 15:35:29 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:33240 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEUf3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 15:35:29 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icxqR-004ec7-2i; Thu, 05 Dec 2019 21:35:27 +0100
Message-ID: <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 Dec 2019 21:35:24 +0100
In-Reply-To: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net> (sfid-20191205_173422_269617_0F8319D0)
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         (sfid-20191205_173422_269617_0F8319D0)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-12-05 at 17:34 +0100, Johannes Berg wrote:

> What I think is (part of) the problem is that I see in the logs that our
> hardware queues become empty every once a while.

I made a histogram of A-MPDU sizes (or singles), and out of the ~11k
frames in the log snapshot I took, I see only ~72% full size A-MPDUs (63
subframes, don't remember why now but we never use 64) but ~9.5% singles
or A-MPDUs with <10 subframes... The rest is pretty evenly distributed
with a small peak (2%) at 62.

So looks like I could get much better performance if I was able to keep
the queues full, not that I'm any closer to figuring out why they're not
...

johannes

