Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D388342F68
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Mar 2021 20:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCTT7X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Mar 2021 15:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhCTT6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Mar 2021 15:58:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A74C061574
        for <linux-wireless@vger.kernel.org>; Sat, 20 Mar 2021 12:58:51 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lNhkH-00139a-Gl; Sat, 20 Mar 2021 20:58:49 +0100
Message-ID: <e0ca70f2241307c44489653d7074c5017ad93943.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: don't apply flow control on management frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Date:   Sat, 20 Mar 2021 20:58:48 +0100
In-Reply-To: <87h7l6adht.fsf@toke.dk>
References: <20210319232800.0e876c800866.Id2b66eb5a17f3869b776c39b5ca713272ea09d5d@changeid>
         <87h7l6adht.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2021-03-20 at 01:13 +0100, Toke Høiland-Jørgensen wrote:
> 
> One consequence of this is that we create a strict priority queue for
> management frames.

Yes, for iwlwifi that's actually a change. For everyone else (not
setting BUFF_MMPDU_TXQ or STA_MMPDU_TXQ) it already is since it goes
directly to ->tx() and from there to the hardware queue(s).

> With all the possibilities for badness (such as the
> ability of starving all other queues) that carries with it. I guess
> that's probably fine for management frames, though, right? As in, there
> is some other mechanism that prevents abuse of this?

Well, there's just not that many management frames to start with? And
only wpa_supplicant (or root in general) can create them. So I don't
think we need to worry about that yet. With QoS-mgmt frames we might
eventually want to think about that, but even there I'd say we never
really want to drop them.

johannes

