Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A978BDCB3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbfIYLGv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 07:06:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfIYLGv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 07:06:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2B2FB6013C; Wed, 25 Sep 2019 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569409610;
        bh=6L6FYCjLqIhNO3YvWkZc19bbhmfyCNtdIhmbzGPQN5A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hOurBEyPolU+418fZqyLv3/g3NVpnd+aGK5a27yEg515iY9DEXQ/VOcbTAJIjgeQQ
         erG1+XYczKk68qpXX5fU/tTE5o8+fn0FNko0V9Bu5nGusTKc8RAAjlQjv7ivg07uG3
         XpwOvRG9SchqVrdF35Y9hCrhTuGAn9evhLE6Uyxk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-1-23-nat.elisa-mobile.fi [85.76.1.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93010602B7;
        Wed, 25 Sep 2019 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569409609;
        bh=6L6FYCjLqIhNO3YvWkZc19bbhmfyCNtdIhmbzGPQN5A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=J22mM7shqJVgLlvpUlz9rRd3GQWgQNqBs6W9IvBT6ZLXUKYs+0rPMWUkLRu3zyJSD
         5yd8/E6R9q1ezl8a7j1/SbXkZ9SsqfhfCMbQIiw8ASiab4geGq92Cc0CPrZ6cFR5rY
         PfYtVClKBw4xn3fUzpdO+V+BRN+WNC/E5k4ePci8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93010602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Solomon Peachy <pizza@shaftnet.org>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cw1200: Fix a signedness bug in cw1200_load_firmware()
References: <20190925105943.GJ3264@mwanda>
Date:   Wed, 25 Sep 2019 14:06:45 +0300
In-Reply-To: <20190925105943.GJ3264@mwanda> (Dan Carpenter's message of "Wed,
        25 Sep 2019 13:59:43 +0300")
Message-ID: <87o8z8zlbu.fsf@codeaurora.org>
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
>  drivers/net/wireless/st/cw1200/fwio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/st/cw1200/fwio.c b/drivers/net/wireless/st/cw1200/fwio.c
> index 6574e78e05ea..da767c33dfbb 100644
> --- a/drivers/net/wireless/st/cw1200/fwio.c
> +++ b/drivers/net/wireless/st/cw1200/fwio.c
> @@ -321,7 +321,7 @@ int cw1200_load_firmware(struct cw1200_common *priv)
>  	}
>  
>  	priv->hw_type = cw1200_get_hw_type(val32, &major_revision);
> -	if (priv->hw_type < 0) {
> +	if ((int)priv->hw_type < 0) {
>  		pr_err("Can't deduce hardware type.\n");
>  		ret = -ENOTSUPP;
>  		goto out;

Isn't there any cleaner way to fix this? Like having 'int ret' variable
and assign to priv->hw_type after the error handling?

-- 
Kalle Valo
