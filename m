Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682723F294B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbhHTJhs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 05:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhHTJhp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 05:37:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FDAC061575
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K171EOOVWf5149Rnv7JwPwLtRHHc2jbs6QoeEdQYOBo=;
        t=1629452227; x=1630661827; b=NHWNyJ2fILYLnOoGy5/GeNMndJjHJCPjp1YBnNhTvEcHcma
        WPvZofp6c+jrzVXLpBvflPQ+l/AeKAMbkfk/kAyqfOrZIueTxaW5yjD1E0ppwkGO7fcRIhO8VADGT
        Vea2oG9auOCT3yfVkfsw0HOSg3P3GHFemeKRqvJ7wCvllkra9YaJXnWofdgu886OY2V0suGp+OzZw
        urBumdPHhVQavDCNJ3v8fb15A18a4vi1TdrQ2txQgvsj6Laj536ExppYv01u7k4HHx+tPprASAQEr
        Orkqs0gKseYBNvzQ3ypTblYiDZwP1NcHfNR6GVgZ1jv3/1jbjg9CCJX6tedTLtSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mH0xV-00DXQi-Rt; Fri, 20 Aug 2021 11:37:05 +0200
Message-ID: <480c17405d7735bed3148c3085f93e3d278acadd.camel@sipsolutions.net>
Subject: Re: 5.14-rc3 lockdep warning, iwlwifi 9560
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chris Murphy <lists@colorremedies.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 20 Aug 2021 11:37:05 +0200
In-Reply-To: <CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com>
References: <CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Chris,

Sorry for the late reply.

> [   17.384143] ======================================================
> [   17.384144] WARNING: possible circular locking dependency detected
> [   17.384146] 5.14.0-0.rc3.29.fc35.x86_64+debug #1 Not tainted
> [   17.384147] ------------------------------------------------------
> [   17.384148] kworker/u16:8/554 is trying to acquire lock:
> [   17.384149] ffff91e2af7d80e8 (&sta->rate_ctrl_lock){+.-.}-{2:2},
> at: rate_control_get_rate+0xc0/0x140 [mac80211]
> [   17.384197]
>                but task is already holding lock:
> [   17.384198] ffff91e2af7d8130 (&sta->lock){+.-.}-{2:2}, at:
> ieee80211_stop_tx_ba_cb+0x2e/0x1e0 [mac80211]
> [   17.384229]
> 
> dmesg:
> https://drive.google.com/file/d/1A5aZNMf_qXFU6arthGyu_FEIYV08V7wv/view?usp=sharing

I can confirm this is a problem, basically we have

aggregation start:
 * take sta's rate lock
 * call driver's rate control
 * that decides to start aggregation
 * calls ieee80211_start_tx_ba_session()
 * takes sta lock

aggregation stop:
 * ieee80211_stop_tx_ba_cb() is called
 * takes sta lock
 * releases TXQ from aggregation-related stop by
   calling ieee80211_agg_start_txq()
 * calls schedule_and_wake_txq()
 * calls driver
 * driver retrieves from, which calls rate control
 * takes sta's rate lock


If you could, I'd appreciate if you filed a bug report on bugzilla.kernel.org (see also
https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#how_to_report
for the product/component)

It's not obvious to me immediately how to fix it, so I'd prefer to track
it as a bug report.

johannes

