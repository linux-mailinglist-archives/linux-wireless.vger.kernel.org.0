Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED0DC671
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393921AbfJRNsT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 09:48:19 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58330 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392604AbfJRNsS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 09:48:18 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iLSc4-00045S-Vf; Fri, 18 Oct 2019 15:48:17 +0200
Message-ID: <9fc60b546b54b40357264d67536733251cf39ebe.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/4] mac80211: Rearrange ieee80211_tx_info to make
 room for tx_time_est
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 18 Oct 2019 15:48:13 +0200
In-Reply-To: <87imomdvsj.fsf@toke.dk>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
         <157115993866.2500430.13989567853855880476.stgit@toke.dk>
         <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com>
         <87sgnqe4wg.fsf@toke.dk>
         <10b885b3238cede2d99c6134bebcc0c8ba6f6b10.camel@sipsolutions.net>
         <87imomdvsj.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-10-18 at 15:31 +0200, Toke Høiland-Jørgensen wrote:

> Well, let's try to do the actual math... A full-size (1538 bytes) packet
> takes ~2050 microseconds to transmit at 6 Mbps. Adding in overhead, it's
> certainly still less that 4096 us, so 12 bits is plenty.

What about A-MSDUs? But I guess maximum continous transmissions are at
most 4ms anyway, so a single packet should never be longer.

> That leaves
> four bits for the ACK status ID if we just split the u16; if we only
> ever have "a handful", that should be enough, no?

It's how many are in flight at a time, 16 doesn't seem likely to happen,
but I don't really know what applications are doing with it now.
Probably only wpa_s for the EAPOL TX status.

> We could also split 5/11. That would support up to 32 ACK IDs, and we
> can just truncate the airtime at 2048 us, which is not a big deal I'd
> say.

We can also play with the units of the airtime, e.g. making that a
multiple of 2 or 4 us? Seems unlikely to matter much?

> Think it mostly depends on what is the smallest ID space for ACK IDs we
> can live with? :)

:)

TBH, I don't really know. In a lot of hardware using this is really bad
for performance so it shouldn't be used much, so ...

johannes

