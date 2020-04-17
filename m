Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643FF1AD802
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgDQHwM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbgDQHwM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:52:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935CC061A0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 00:52:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jPLnB-006kEb-EQ; Fri, 17 Apr 2020 09:52:05 +0200
Message-ID: <cca893de1163db031f00df5ada30a7987945bc07.camel@sipsolutions.net>
Subject: Re: [PATCH v5.7 8/8] iwlwifi: mvm: don't call
 iwl_mvm_free_inactive_queue() under RCU
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mark Asselstine <asselsm@gmail.com>, Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 17 Apr 2020 09:52:04 +0200
In-Reply-To: <CAPuovE+_jWPjesRZ0GFk0zjf-jLmyyqOGxwyZGcawg5DL9CbXg@mail.gmail.com> (sfid-20200403_162852_111476_08446F51)
References: <20200403082955.1126339-1-luca@coelho.fi>
         <iwlwifi.20200403112332.0f49448c133d.I17fd308bc4a9491859c9b112f4eb5d2c3fc18d7d@changeid>
         <CAPuovE+_jWPjesRZ0GFk0zjf-jLmyyqOGxwyZGcawg5DL9CbXg@mail.gmail.com>
         (sfid-20200403_162852_111476_08446F51)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry, missed your comment.

On Fri, 2020-04-03 at 10:28 -0400, Mark Asselstine wrote:
> I was looking into this as part of
> https://bugzilla.kernel.org/show_bug.cgi?id=206971 and had a similar
> fix in flight. My concern was that queue_owner being used outside of
> the RCU might be an issue

Yes, that does *look* questionable, and I missed it completely.

However, that's only because the code makes weak assumptions when it's
under much stronger guarantees. There's no reason for it to use RCU here
for the station lookup, since it's holding the write-side lock (which is
the mvm->mutex).

IOW, we could just change

sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);

to

sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[sta_id], ...);

and then it's clear that there's no issue.

> as now you have no guaranty that the
> eventual use of sta->txq[tid] in iwl_mvm_free_inactive_queue() is
> going to be valid. The only way to work around this is instead of
> storing queue_owner, store mvmtxq = iwl_mvm_txq_from_tid(sta, i), then
> adjust iwl_mvm_free_inactive_queue(), iwl_mvm_disable_txq() and
> whatnot to take struct iwl_mvm_txq * instead of struct ieee80211_sta
> *. If you open the bug you will see the latest version of my work as
> the attached patch. I am not an RCU expert so I am curious to hear
> your thoughts.

You could do that too, but it seems overly complex to me.

johannes

