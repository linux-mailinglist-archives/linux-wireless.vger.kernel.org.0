Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF65C1E08E6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 10:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbgEYIff (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 04:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgEYIff (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 04:35:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5053AC061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 01:35:35 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd8a3-002aFR-Tm; Mon, 25 May 2020 10:35:32 +0200
Message-ID: <a26a1d1a4d164d17cdf38ec358119ff8c682f991.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Fix station dump inactive time after sta
 connection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Seevalamuthu Mariappan <seevalam@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 25 May 2020 10:35:30 +0200
In-Reply-To: <1588702126-11364-1-git-send-email-seevalam@codeaurora.org>
References: <1588702126-11364-1-git-send-email-seevalam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-05-05 at 23:38 +0530, Seevalamuthu Mariappan wrote:
> When USES_RSS is enabled, last_rx becomes zero in first few
> minutes after sta connection

This is wrong - it's something like "in the first few minutes after
system boot" or something?

>  in sta_get_last_rx_stats. This
> leads to inactive time showing current jiffies in msecs.
> 
> Station 8c:fd:f0:02:10:dd (on wlan0)
>         inactive time:  4294701656 ms
>           .
>           .
>         connected time: 2 seconds
> 
> Fix this by avoid overwriting last_rx with percpu_stat's last_rx
> if it is zero.

This doesn't seem like the right fix - shouldn't we just initialize
last_rx better so the wrap won't cause any trouble?

johannes

