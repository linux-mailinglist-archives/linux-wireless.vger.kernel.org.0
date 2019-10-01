Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6026C33AD
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfJAMCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 08:02:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJAMCk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 08:02:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A1C5360AD9; Tue,  1 Oct 2019 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569931359;
        bh=QT2tNqnnlIdmUauWjnASbr4IMyXi0R64P5A0OYTYtKA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jslPBATYEaLkWJoZ64yyx5OT6FjxvqR3FwCr960ub9CS1VSzYhmlrlxx18rvxa8IW
         OnWH2P8IkVkTgepfWAW2XXG8JFcnE0J9Cmx8LFN1vVabIXzNmeKneOXp8cr/dtHdeE
         b0PU2JVRCnCdwIrMmeTHed/bRfqeaNfy/VmcAIz4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9CA260112;
        Tue,  1 Oct 2019 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569931359;
        bh=QT2tNqnnlIdmUauWjnASbr4IMyXi0R64P5A0OYTYtKA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jslPBATYEaLkWJoZ64yyx5OT6FjxvqR3FwCr960ub9CS1VSzYhmlrlxx18rvxa8IW
         OnWH2P8IkVkTgepfWAW2XXG8JFcnE0J9Cmx8LFN1vVabIXzNmeKneOXp8cr/dtHdeE
         b0PU2JVRCnCdwIrMmeTHed/bRfqeaNfy/VmcAIz4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9CA260112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Solomon Peachy <pizza@shaftnet.org>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] cw1200: Fix a signedness bug in cw1200_load_firmware()
References: <20191001114501.GA6550@mwanda>
Date:   Tue, 01 Oct 2019 15:02:35 +0300
In-Reply-To: <20191001114501.GA6550@mwanda> (Dan Carpenter's message of "Tue,
        1 Oct 2019 14:45:01 +0300")
Message-ID: <87a7ak65d0.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> The "priv->hw_type" is an enum and in this context GCC will treat it
> as an unsigned int so the error handling will never trigger.
>
> Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: better style and preserve the error code.
>
>  drivers/net/wireless/st/cw1200/fwio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/st/cw1200/fwio.c b/drivers/net/wireless/st/cw1200/fwio.c
> index 6574e78e05ea..2a03dc533b6a 100644
> --- a/drivers/net/wireless/st/cw1200/fwio.c
> +++ b/drivers/net/wireless/st/cw1200/fwio.c
> @@ -320,12 +320,12 @@ int cw1200_load_firmware(struct cw1200_common *priv)
>  		goto out;
>  	}
>  
> -	priv->hw_type = cw1200_get_hw_type(val32, &major_revision);
> -	if (priv->hw_type < 0) {
> +	ret = cw1200_get_hw_type(val32, &major_revision);
> +	if (ret < 0) {
>  		pr_err("Can't deduce hardware type.\n");
> -		ret = -ENOTSUPP;
>  		goto out;
>  	}
> +	priv->hw_type = ret;

Thanks, this is indeed much better.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
