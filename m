Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F3BDC50E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfJRMfo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 08:35:44 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56620 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633850AbfJRMfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 08:35:44 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iLRTp-0002Kb-8n; Fri, 18 Oct 2019 14:35:41 +0200
Message-ID: <4bc17c32337888a57a78a0e2c874abd462faef21.camel@sipsolutions.net>
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
Date:   Fri, 18 Oct 2019 14:35:40 +0200
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
> Kan Yan <kyan@google.com> writes:
> 
> > The "tx_time_est" field, shared by control and status, is not able to
> > survive until the skb returns to the mac80211 layer in some
> > architectures. The same space is defined as driver_data and some
> > wireless drivers use it for other purposes, as the cb in the sk_buff
> > is free to be used by any layer.
> > 
> > In the case of ath10k, the tx_time_est get clobbered by
> > struct ath10k_skb_cb {
> >         dma_addr_t paddr;
> >         u8 flags;
> >         u8 eid;
> >         u16 msdu_id;
> >         u16 airtime_est;
> >         struct ieee80211_vif *vif;
> >         struct ieee80211_txq *txq;
> > } __packed;
> 
> Ah, bugger, of course the driver that actually needs this is using the
> full driver_data space :P

Looks like you could shrink *this* fairly easily though.

E.g. most likely vif == txq->vif unless txq==NULL, so it's down to 22
bytes plus a bit/flag for knowing whether the pointer is a vif directly
(if no TXQ) or a TXQ.

> > Do you think shrink driver_data by 2 bytes and use that space for
> > tx_time_est to make it persistent across mac80211 and wireless driver
> > layer an acceptable solution?
> 
> Hmm, the driver_data field is defined as an array of pointers, so we can
> only shrink it in increments of sizeof(void *). I think it may be
> feasible to shrink it (as in, I don't think any drivers are actually
> using the full 40 bytes),

It doesn't have to be defined like that, just was most convenient as
driers were using pointers there.

> but doing this in a way that will gain us a
> 2-byte space that is also usable in the case driver_data is *not* used
> (i.e., it needs be able to align with a field in .control and .status as
> well) would require some serious surgery of the whole ieee80211_tx_info...

Yeah, good point, this doesn't help at all ...

johannes

