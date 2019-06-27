Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5E8587A6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0Qv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 12:51:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42876 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfF0Qv1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 12:51:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F0DCE60159; Thu, 27 Jun 2019 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561654287;
        bh=irekG6thQX34gyXWtiXWY57LwZBdDKVmXlbJNG5ysvc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dZ1TsDWWkdoep4Ac4dCC1D/vEIuRPPNQAj3/D9k7VUaeDJQPN4MxohdBwW1d3yEab
         Ys8jmftJPwu1aQfTQz9MVDTr+HQEai707HzkqUaeYE2KPeu+fmy8OOAJ428NLGpuYk
         O5/LNB4dAMvqlYNON0pI//FZNiHA4dMSaAn3CNUM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60BF660159;
        Thu, 27 Jun 2019 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561654286;
        bh=irekG6thQX34gyXWtiXWY57LwZBdDKVmXlbJNG5ysvc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=h9aAGd2ub/FCnsr/gPGaEFths60IuSW0AQfcJSof80rzky6ODMjIYPWQvWTrmmJMc
         x+GP8Rd6t80WzhAV5GSR2s1V5U2sfv207PfTMb+raUexgcH/HllF2ySuVJESOv0c/Z
         pF9t4RygKBPVgVP2uHz56BCQUJ0NzGnucbvZcbVU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60BF660159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] mwifiex: dispatch/rotate from reorder table
 atomically
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190625174045.125223-2-briannorris@chromium.org>
References: <20190625174045.125223-2-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627165126.F0DCE60159@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 16:51:26 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> mwifiex_11n_scan_and_dispatch() and
> mwifiex_11n_dispatch_pkt_until_start_win() share similar patterns, where
> they perform a few different actions on the same table, using the same
> lock, but non-atomically. There have been other attempts to clean up
> this sort of behavior, but they have had problems (incomplete;
> introducing new deadlocks).
> 
> We can improve these functions' atomicity by queueing up our RX packets
> in a list, to dispatch at the end of the function. This avoids problems
> of another operation modifying the table in between our dispatch and
> rotation operations.
> 
> This was inspired by investigations around this:
> 
>   http://lkml.kernel.org/linux-wireless/20181130175957.167031-1-briannorris@chromium.org
>   Subject: [4.20 PATCH] Revert "mwifiex: restructure rx_reorder_tbl_lock usage"
> 
> While the original (now-reverted) patch had good intentions in
> restructuring some of the locking patterns in this driver, it missed an
> important detail: we cannot defer to softirq contexts while already in
> an atomic context. We can help avoid this sort of problem by separating
> the two steps of:
> (1) iterating / clearing the mwifiex reordering table
> (2) dispatching received packets to upper layers
> 
> This makes it much harder to make lock recursion mistakes, as these
> two steps no longer need to hold the same locks.
> 
> Testing: I've played with a variety of stress tests, including download
> stress tests on the same APs which caught regressions with commit
> 5188d5453bc9 ("mwifiex: restructure rx_reorder_tbl_lock usage"). I've
> primarily tested on Marvell 8997 / PCIe, although I've given 8897 / SDIO
> a quick spin as well.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Ganapathi Bhat <gbhat@marvell.com>

2 patches applied to wireless-drivers-next.git, thanks.

ce2e942e32e8 mwifiex: dispatch/rotate from reorder table atomically
8a7f9fd8a3e0 mwifiex: don't disable hardirqs; just softirqs

-- 
https://patchwork.kernel.org/patch/11016151/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

