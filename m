Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3053149A71
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 12:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbgAZLh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 06:37:26 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:32016 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387422AbgAZLh0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 06:37:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580038646; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=o7Z67Njt6M7BftRiSC70I/zPhgR1uwAuSo7PHvYIVPM=;
 b=M0TbBDjYrzp6Bgyz5HAuoJbmmoXWtogLQfpE5koYVeLV+xZnbl+p1KsFfYjXPAcGrwDws40R
 B13nKZfP3h9geP/tKP2jPz1tQsR1oc3qIX0tWWXCGTlqx/byLthoajYQ4MArIOXSJfVmJVCJ
 +7kszpEIsdH5YENMOZ9XwDvWyp0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d79f2.7f18535f7458-smtp-out-n03;
 Sun, 26 Jan 2020 11:37:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8991C4479C; Sun, 26 Jan 2020 11:37:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B869CC433CB;
        Sun, 26 Jan 2020 11:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B869CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: drop most magic numbers from
 mwifiex_process_tdls_action_frame()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191206194535.150179-1-briannorris@chromium.org>
References: <20191206194535.150179-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>, dan.carpenter@oracle.com,
        solar@openwall.com, wangqize888888888@gmail.com,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126113722.D8991C4479C@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 11:37:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> Before commit 1e58252e334d ("mwifiex: Fix heap overflow in
> mmwifiex_process_tdls_action_frame()"),
> mwifiex_process_tdls_action_frame() already had too many magic numbers.
> But this commit just added a ton more, in the name of checking for
> buffer overflows. That seems like a really bad idea.
> 
> Let's make these magic numbers a little less magic, by
> (a) factoring out 'pos[1]' as 'ie_len'
> (b) using 'sizeof' on the appropriate source or destination fields where
>     possible, instead of bare numbers
> (c) dropping redundant checks, per below.
> 
> Regarding redundant checks: the beginning of the loop has this:
> 
>                 if (pos + 2 + pos[1] > end)
>                         break;
> 
> but then individual 'case's include stuff like this:
> 
>  			if (pos > end - 3)
>  				return;
>  			if (pos[1] != 1)
> 				return;
> 
> Note that the second 'return' (validating the length, pos[1]) combined
> with the above condition (ensuring 'pos + 2 + length' doesn't exceed
> 'end'), makes the first 'return' (whose 'if' can be reworded as 'pos >
> end - pos[1] - 2') redundant. Rather than unwind the magic numbers
> there, just drop those conditions.
> 
> Fixes: 1e58252e334d ("mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_frame()")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

70e5b8f445fd mwifiex: drop most magic numbers from mwifiex_process_tdls_action_frame()

-- 
https://patchwork.kernel.org/patch/11277011/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
