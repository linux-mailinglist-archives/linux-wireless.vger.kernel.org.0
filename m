Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7BF14CC13
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 15:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgA2OFk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 09:05:40 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:64227 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgA2OFk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 09:05:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580306739; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=15AGAb6xpQISvcFQW1tkjmK4LdTdUPgvzOyitjXpL0s=; b=du9gqOp3GwnFgOxmnLkEqDOvaSyKhRw177X3Y+gCsIIi9m87cisdTiq0m41XeXTQmgO0bmoN
 leLBUQs3VgJN3bTvzowfmDvvzijkDs8+J3avWUgrRnUzFASJLMKiqnxmxdJ50z+MDNss8POe
 ImwQ9fHeLckR4b7B3MZGS6rYoJg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e319133.7f32a97f3d88-smtp-out-n02;
 Wed, 29 Jan 2020 14:05:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 590FBC447A1; Wed, 29 Jan 2020 14:05:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28446C43383;
        Wed, 29 Jan 2020 14:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28446C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: Re: linux-next: Fixes tag needs some work in the wireless-drivers-next tree
References: <20200127114221.52ba6027@canb.auug.org.au>
Date:   Wed, 29 Jan 2020 16:05:32 +0200
In-Reply-To: <20200127114221.52ba6027@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 27 Jan 2020 11:42:21 +1100")
Message-ID: <87k15a8ij7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> n commit
>
>   6ba8b3b6bd77 ("ath10k: Correct the DMA direction for management tx buffers")
>
> Fixes tag
>
>   Fixes: dc405152bb6 ("ath10k: handle mgmt tx completion event")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Doh, I missed that but naturally there's nothing we can do now as the
commit is in Linus' tree. I really should implement some kind of
automatic check to my patchwork script for this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
