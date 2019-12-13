Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA7D11E068
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 10:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLMJNo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 04:13:44 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44424 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfLMJNo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 04:13:44 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ifh14-009YsK-6T; Fri, 13 Dec 2019 10:13:42 +0100
Message-ID: <8faa14caf032ea11fc329eeefa11f0f7159b13a4.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: mesh: only warn if mesh peering is established
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 13 Dec 2019 10:13:39 +0100
In-Reply-To: <20191203180644.70653-1-markus.theil@tu-ilmenau.de>
References: <20191203180644.70653-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-12-03 at 19:06 +0100, Markus Theil wrote:
> The following warning is triggered every time an unestablished mesh peer
> gets dumped. This patch checks, if a peer link is established, when dum-
> ping the airtime link metric.
> 
> [ 9563.022567] WARNING: CPU: 0 PID: 6287 at net/mac80211/mesh_hwmp.c:345
>                airtime_link_metric_get+0xa2/0xb0 [mac80211]
> [ 9563.022697] Hardware name: PC Engines apu2/apu2, BIOS v4.10.0.3
> [ 9563.022756] RIP: 0010:airtime_link_metric_get+0xa2/0xb0 [mac80211]
> [ 9563.022838] Call Trace:
> [ 9563.022897]  sta_set_sinfo+0x936/0xa10 [mac80211]
> [ 9563.022964]  ieee80211_dump_station+0x6d/0x90 [mac80211]
> [ 9563.023062]  nl80211_dump_station+0x154/0x2a0 [cfg80211]
> [ 9563.023120]  netlink_dump+0x17b/0x370
> [ 9563.023130]  netlink_recvmsg+0x2a4/0x480
> [ 9563.023140]  ____sys_recvmsg+0xa6/0x160
> [ 9563.023154]  ___sys_recvmsg+0x93/0xe0
> [ 9563.023169]  __sys_recvmsg+0x7e/0xd0
> [ 9563.023210]  do_syscall_64+0x4e/0x140
> [ 9563.023217]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

OK, I can see how this happens.

However,

> +	if (sta->mesh->plink_state != NL80211_PLINK_ESTAB)
> +		return MAX_METRIC;
> +

I'm not really sure this is the right way to fix it?

I'm sure you observed this only when the link isn't established yet, but
it seems to me that even when a link is established it could still
happen?

Or are the frames that are necessary for link establishment enough to
always set the metric?

johannes

