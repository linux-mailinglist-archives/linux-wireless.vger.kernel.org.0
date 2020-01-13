Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E0138ED1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 11:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMKQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 05:16:00 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:15649 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMKP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 05:15:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578910559; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=BljZPdbyLz1oIxLZQU2DxQV4e8yNWqRV7wN1KDuFTC4=; b=I6Nux/uQNMZLpohE+N0bUnIxg4qRliSsOkzs6Rccc0/pXZ/A6jEqctIobwgK0duwZCKghfos
 HwkZn37vXs8Wqg2ni8A6UrwZVez1sCkDU2mBxu3ni1GRfpqqxJjDgKeVbgsG6kS8UYyku3R5
 ujYYnqHZL2CN8kJxBlM1UwewZu0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1c435d.7fbe123dfea0-smtp-out-n02;
 Mon, 13 Jan 2020 10:15:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D793C447A2; Mon, 13 Jan 2020 10:15:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F01E4C447A5;
        Mon, 13 Jan 2020 10:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F01E4C447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Sachin Shelke <sachin.shelke@nxp.com>
Subject: Re: [PATCH] MAINTAINERS: update for mwifiex driver maintainers
References: <1578391915-3960-1-git-send-email-ganapathi.bhat@nxp.com>
Date:   Mon, 13 Jan 2020 12:15:51 +0200
In-Reply-To: <1578391915-3960-1-git-send-email-ganapathi.bhat@nxp.com>
        (Ganapathi Bhat's message of "Tue, 7 Jan 2020 10:12:09 +0000")
Message-ID: <87sgkj1x2g.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <ganapathi.bhat@nxp.com> writes:

> Rakesh Parmar, Sharvari Harisangam & Sachin Shelke have started
> to take a more active role in mwifiex driver maintainership.
> This change is to add them to the list of MAINTAINERS.
>
> Signed-off-by: Rakesh Parmar <rakesh.parmar@nxp.com>
> Signed-off-by: Sharvari Harisangam <sharvari.harisangam@nxp.com>
> Signed-off-by: Sachin Shelke <sachin.shelke@nxp.com>
> Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d095198..d371843 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9955,8 +9955,10 @@ F:	drivers/net/ethernet/marvell/mvneta.*
>  
>  MARVELL MWIFIEX WIRELESS DRIVER
>  M:	Amitkumar Karwar <amitkarwar@gmail.com>
> -M:	Nishant Sarmukadam <nishants@marvell.com>

What about Nishant, you don't mention anything about him.

> +M:	Rakesh Parmar <rakesh.parmar@nxp.com>
>  M:	Ganapathi Bhat <ganapathi.bhat@nxp.com>
> +M:	Sharvari Harisangam <sharvari.harisangam@nxp.com>
> +M:	Sachin Shelke <sachin.shelke@nxp.com>
>  M:	Xinming Hu <huxinming820@gmail.com>

I think there are too many maintainers now. There should be just one or
two maintainers per driver, not six. Maintainer is a different role from
a person actively working on the driver.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
