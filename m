Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35CEDC70E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634131AbfJROOY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 10:14:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58758 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633946AbfJROOX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 10:14:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iLT1J-0004cj-98; Fri, 18 Oct 2019 16:14:21 +0200
Message-ID: <78035e38264feac9d15a761b009c89b9738b4de1.camel@sipsolutions.net>
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
Date:   Fri, 18 Oct 2019 16:14:20 +0200
In-Reply-To: <87d0eudufu.fsf@toke.dk> (sfid-20191018_160136_042961_4FF7E805)
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
         <157115993866.2500430.13989567853855880476.stgit@toke.dk>
         <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com>
         <87sgnqe4wg.fsf@toke.dk>
         <10b885b3238cede2d99c6134bebcc0c8ba6f6b10.camel@sipsolutions.net>
         <87imomdvsj.fsf@toke.dk>
         <9fc60b546b54b40357264d67536733251cf39ebe.camel@sipsolutions.net>
         <87d0eudufu.fsf@toke.dk> (sfid-20191018_160136_042961_4FF7E805)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-10-18 at 16:01 +0200, Toke Høiland-Jørgensen wrote:
> 
> > We can also play with the units of the airtime, e.g. making that a
> > multiple of 2 or 4 us? Seems unlikely to matter much?
> 
> Sure, that's a good point! Increments of 4us means we can fit 4ms is 10
> bits, leaving plenty of space for ACK IDs (hopefully).

If you do need more bits (e.g. to be on the safe side and have space for
8ms) you could also steal bits out of 'band' (we only need 3 I think)
and 'hw_queue' (not sure what the limit really is, but there aren't many
users, seems like only iwlwifi/dvm and hwsim care, and those certainly
don't need >32 queues).

Of course if you leave more bits for later that's good too ;-)

johannes

