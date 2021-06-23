Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10943B168E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFWJQk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJQj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 05:16:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E3C061574
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 02:14:22 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lvyxf-00AV70-Pb; Wed, 23 Jun 2021 11:14:19 +0200
Message-ID: <e1798568decc6df9b44ce97f48be523bdc92bdc4.camel@sipsolutions.net>
Subject: Re: [PATCH mac80211-next v8] mac80211: Switch to a virtual
 time-based airtime scheduler
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, Yibo Zhao <yiboz@codeaurora.org>
Date:   Wed, 23 Jun 2021 11:14:18 +0200
In-Reply-To: <20210507094851.180838-1-toke@redhat.com> (sfid-20210507_114946_866610_98578A77)
References: <20210507094851.180838-1-toke@redhat.com>
         (sfid-20210507_114946_866610_98578A77)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-05-07 at 11:48 +0200, Toke Høiland-Jørgensen wrote:
> This switches the airtime scheduler in mac80211 to use a virtual time-based

Generally, we prefer <=72 columns in commit messages ... I started
reformatting, but then your code also has a lot of places that go over
80 columns, so I gave up ... Can you please do that?

Some refactoring, e.g. in sta_apply_parameters(), may also be in order.
> +/**
> + * struct airtime_sched_info - state used for airtime scheduling and AQL
> + *
> + * @lock: spinlock that protects all the fields in this struct
> + * @active_txqs: rbtree of currently backlogged queues, sorted by virtual time
> + * @schedule_pos: the current position maintained while a driver walks the tree
> + *                with ieee80211_next_txq()
> + * @active_list: list of struct airtime_info structs that were active within
> + *               the last AIRTIME_ACTIVE_DURATION (100 ms), used to compute weight_sum
> + * @last_weight_update: used for rate limiting walking active_list
> + * @last_schedule_time: tracks the last time a transmission was scheduled; used
> + *                      for catching up v_t if no stations are eligible for transmission.
> + * @v_t: global virtual time; queues with v_t < this are eligible for transmission
> + * @weight_sum: total sum of all active stations used for dividing airtime
> + * @weight_sum_reciprocal: reciprocal of weight_sum (to avoid divisions in fast
> + *                         path - see comment above IEEE80211_RECIPROCAL_DIVISOR_64)
> + * @aql_txq_limit_low: AQL limit when total outstanding airtime is < IEEE80211_AQL_THRESHOLD
> + * @aql_txq_limit_high: AQL limit when total outstanding airtime is > IEEE80211_AQL_THRESHOLD

This is also needlessly way over.

Thanks,
johannes

