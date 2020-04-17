Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F501AD65B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 08:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgDQGmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 02:42:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56350 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728248AbgDQGmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 02:42:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPKhN-000KMG-AC; Fri, 17 Apr 2020 09:42:01 +0300
Message-ID: <1c6acee636c0463c4c293ff910053f8b25b4da92.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Mark Asselstine <asselsm@gmail.com>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        johannes.berg@intel.com
Date:   Fri, 17 Apr 2020 09:42:00 +0300
In-Reply-To: <CAPuovE+_jWPjesRZ0GFk0zjf-jLmyyqOGxwyZGcawg5DL9CbXg@mail.gmail.com>
References: <20200403082955.1126339-1-luca@coelho.fi>
         <iwlwifi.20200403112332.0f49448c133d.I17fd308bc4a9491859c9b112f4eb5d2c3fc18d7d@changeid>
         <CAPuovE+_jWPjesRZ0GFk0zjf-jLmyyqOGxwyZGcawg5DL9CbXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v5.7 8/8] iwlwifi: mvm: don't call
 iwl_mvm_free_inactive_queue() under RCU
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-03 at 10:28 -0400, Mark Asselstine wrote:
> I was looking into this as part of
> https://bugzilla.kernel.org/show_bug.cgi?id=206971 and had a similar
> fix in flight. My concern was that queue_owner being used outside of
> the RCU might be an issue as now you have no guaranty that the
> eventual use of sta->txq[tid] in iwl_mvm_free_inactive_queue() is
> going to be valid. The only way to work around this is instead of
> storing queue_owner, store mvmtxq = iwl_mvm_txq_from_tid(sta, i), then
> adjust iwl_mvm_free_inactive_queue(), iwl_mvm_disable_txq() and
> whatnot to take struct iwl_mvm_txq * instead of struct ieee80211_sta
> *. If you open the bug you will see the latest version of my work as
> the attached patch. I am not an RCU expert so I am curious to hear
> your thoughts.

I asked Johannes to check your comment.  For now, I'm going to drop it
from v2 of this patchset, so we can go ahead with the other patches.

--
Cheers,
Luca.

