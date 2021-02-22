Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECF32198B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhBVN5b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 08:57:31 -0500
Received: from z11.mailgun.us ([104.130.96.11]:28926 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhBVN5O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 08:57:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614002213; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=StrHLgIYsMsp1wqmw6OuWpaJzVoDT6gnlNQwnsB1m0o=; b=L4aF1vvyC2o7mxqbWRCdVqUb9qofJ0siQMXTRIw7aNq49pd7tfojTf4aYn1wqcxLRAetWRWz
 VceGflXVOYz/IVj6tZ9u9xpxZrNsTILbNRBgeMfe5YogbXGMEi+ZmEGmxixtEaFJCGdKfrd6
 Qeu50KyeK7rjRG7t47ymoawagBQ=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6033b81d2a8ee88ea54309e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 13:56:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13FA5C433ED; Mon, 22 Feb 2021 13:56:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6101C433CA;
        Mon, 22 Feb 2021 13:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6101C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     linux-wireless@vger.kernel.org,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Pali Rohar <pali@kernel.org>, ganapathi.bhat@nxp.com
Subject: Re: [PATCH] MAINTAINERS: update for mwifiex driver maintainers
References: <1613998184-20047-1-git-send-email-sharvari.harisangam@nxp.com>
Date:   Mon, 22 Feb 2021 15:56:40 +0200
In-Reply-To: <1613998184-20047-1-git-send-email-sharvari.harisangam@nxp.com>
        (Sharvari Harisangam's message of "Mon, 22 Feb 2021 18:19:44 +0530")
Message-ID: <878s7gfbon.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sharvari Harisangam <sharvari.harisangam@nxp.com> writes:

> Add Sharvari Harisangam to Maintainer list.
> Replace Ganapathi Bhat's email id in Maintainer list.
>
> Signed-off-by: Rakesh Parmar <rakesh.parmar@nxp.com>
> Signed-off-by: Sharvari Harisangam <sharvari.harisangam@nxp.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 99335fd..98fd98e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10685,7 +10685,8 @@ F:	drivers/net/ethernet/marvell/mvpp2/
>  
>  MARVELL MWIFIEX WIRELESS DRIVER
>  M:	Amitkumar Karwar <amitkarwar@gmail.com>
> -M:	Ganapathi Bhat <ganapathi.bhat@nxp.com>
> +M:	Ganapathi Bhat <ganapathi017@gmail.com>

Can I have an ack from Ganapathi?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
