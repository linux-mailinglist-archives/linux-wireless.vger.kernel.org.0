Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60F211E144
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 10:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLMJ4Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 04:56:16 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:45458 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMJ4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 04:56:16 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ifhgE-009eL1-3i; Fri, 13 Dec 2019 10:56:14 +0100
Message-ID: <94471b2381bee394f9708eae8ba47129f3facd03.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] mac80211: fix issue in loop scenario
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org
Date:   Fri, 13 Dec 2019 10:56:12 +0100
In-Reply-To: <1576221593-1086-3-git-send-email-yiboz@codeaurora.org> (sfid-20191213_082426_564220_0827923D)
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
         <1576221593-1086-3-git-send-email-yiboz@codeaurora.org>
         (sfid-20191213_082426_564220_0827923D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-12-13 at 15:19 +0800, Yibo Zhao wrote:
> In a loop txqs dequeue scenario, if the first txq in the rbtree gets
> removed from rbtree immediately in the ieee80211_return_txq(), the
> loop will break soon in the ieee80211_next_txq() due to schedule_pos
> not leading to the second txq in the rbtree. Thus update schedule_pos
> to previous node once the node of schedule_pos is either removed from
> rbtree or move to other location in rbtree due to airtime update.

For my understanding - this is a fix to the first patch in the series?

I guess you didn't squash it because that's Toke's patch or something?

I tend to think you still should, and annotate the changes, but I wanted
to understand it first.

johannes

