Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875EBDC497
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 14:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442707AbfJRMV4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 08:21:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56472 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387570AbfJRMV4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 08:21:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iLRGT-00023f-Lb; Fri, 18 Oct 2019 14:21:53 +0200
Message-ID: <10b885b3238cede2d99c6134bebcc0c8ba6f6b10.camel@sipsolutions.net>
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
Date:   Fri, 18 Oct 2019 14:21:52 +0200
In-Reply-To: <87sgnqe4wg.fsf@toke.dk>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
         <157115993866.2500430.13989567853855880476.stgit@toke.dk>
         <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com>
         <87sgnqe4wg.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-10-18 at 12:15 +0200, Toke Høiland-Jørgensen wrote:

> However, there's a nice juicy 'u16 ack_frame_id' at the start of
> ieee80211_tx_info. Could we potentially use that? We could use the top
> bit as a disambiguation flag; I think we're fine with 15 bits for the TX
> time itself (a single packet won't exceed 8ms or TX time), so if we can
> live with 15 bits of ACK frame ID space, that could be a way forward?

I was going to say that should work as we only ever have a handful of
ACK frame IDs, but ... you still need the airtime even for a frame that
userspace wants to know the ACK status of, no?

We could pull the ack_frame_id out-of-line using the skb extensions
framework, but I'm not sure we should allocate one of the possible 8
extension IDs for that either ...

What we really should do is convert all (relevant) drivers to use rate
tables instead of having all the rates in the TX info, then we'd get a
lot of space, but that's a lot of work ...

johannes

