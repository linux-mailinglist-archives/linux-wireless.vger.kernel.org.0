Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCAF4520
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 11:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfKHK57 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 05:57:59 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54884 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHK57 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 05:57:59 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT1xk-00006s-GM; Fri, 08 Nov 2019 11:57:56 +0100
Message-ID: <4ce4c199522ef112362efb8db8823e31d5c41944.camel@sipsolutions.net>
Subject: Re: [PATCH v6 2/4] mac80211: Import airtime calculation code from
 mt76
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 08 Nov 2019 11:57:54 +0100
In-Reply-To: <87d0e2fxi0.fsf@toke.dk>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
         <157182474174.150713.17459330922820192258.stgit@toke.dk>
         <42266e95f45d5772e04c9c016bd6179ea14ffefa.camel@sipsolutions.net>
         <87d0e2fxi0.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-08 at 11:55 +0100, Toke Høiland-Jørgensen wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > On Wed, 2019-10-23 at 11:59 +0200, Toke Høiland-Jørgensen wrote:
> > > From: Toke Høiland-Jørgensen <toke@redhat.com>
> > > 
> > > Felix recently added code to calculate airtime of packets to the mt76
> > > driver. Import this into mac80211 so we can use it for airtime queue limit
> > > calculations later.
> > > 
> > > The airtime.c file is copied verbatim from the mt76 driver, and adjusted to
> > > use mac80211 data structures instead (which is fairly straight forward).
> > > The per-rate TX rate calculation is split out to its own
> > > function (ieee80211_calc_tx_airtime_rate()) so it can be used directly for
> > > the AQL calculations added in a subsequent patch.
> > 
> > Any way it could be exposed by mac80211 back to the drivers, perhaps, to
> > share it?
> 
> Didn't I already export some of the functions? My intention was to do
> that, certainly, and to patch mt76 to switch to using them once the
> trees have converged...

Yeah, I think you did. Sounds good.

johannes

