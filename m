Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD91072EB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 14:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKVNPN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 08:15:13 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:45332 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVNPN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 08:15:13 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY8mF-000496-P6; Fri, 22 Nov 2019 14:15:11 +0100
Message-ID: <994e486e8e82c01e70150eacf59dedf61b80fc65.camel@sipsolutions.net>
Subject: Re: [PATCH v11 2/4] mac80211: Import airtime calculation code from
 mt76
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        yiboz@codeaurora.org, john@phrozen.org, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com
Date:   Fri, 22 Nov 2019 14:15:09 +0100
In-Reply-To: <87imnc3vk9.fsf@toke.dk>
References: <20191119060610.76681-1-kyan@google.com>
         <20191119060610.76681-3-kyan@google.com>
         <3e7bea0cc643714ec90978a7999022544a39b118.camel@sipsolutions.net>
         <87tv6w3w92.fsf@toke.dk>
         <dea9da1dd31900306c886c308c555691552290f5.camel@sipsolutions.net>
         <87imnc3vk9.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 14:11 +0100, Toke Høiland-Jørgensen wrote:
> 
> as in bitrate = 1/airtime? Dunno, maybe? How important is precision to
> the bitrate calculations?

Not *that* important, it's just sort of advisory for userspace.

Though I think there's at least one place in mac80211 related to
radiotap that actually does use it for airtime calculation, which should
probably be changed to the new code now ...

> > Or maybe we should keep both and use them as a sanity check for each
> > other :P
> 
> Hmm, yeah, it should be possible to write a selftest to iterate through
> all rates and compare the output of each calculation, shouldn't it?
> Where would be a good place to put that?

No idea ... make a new kselftest thing for wireless?

johannes

