Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB026F4553
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 12:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfKHLFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 06:05:16 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55324 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731784AbfKHLFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 06:05:16 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT24o-0000J9-9W; Fri, 08 Nov 2019 12:05:14 +0100
Message-ID: <e7c7ad18d83eaf24809ac1a41604f38098e9bd57.camel@sipsolutions.net>
Subject: Re: [PATCH v6 4/4] mac80211: Use Airtime-based Queue Limits (AQL)
 on packet dequeue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 08 Nov 2019 12:05:12 +0100
In-Reply-To: <877e4afx83.fsf@toke.dk>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
         <157182474399.150713.16380222749144410045.stgit@toke.dk>
         <0b43c4822ab83ea4d33a5a32d8ff6c7a56eff6c5.camel@sipsolutions.net>
         <877e4afx83.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-08 at 12:01 +0100, Toke Høiland-Jørgensen wrote:
> 
> My reasoning for doing it this way was that we have another set of APIs
> dealing with airtime which doesn't do any shifting; so keeping the APIs
> in the same unit (straight airtime) seemed less confusing.

Fair enough.

> We could add (inline) setter and getter functions for the tx_time_est
> field instead to avoid sprinkling shifts all over the place? :)

It doesn't really bother me that much, but yeah, perhaps that's easier.

johannes

