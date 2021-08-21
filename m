Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2D3F3AE5
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhHUOMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 10:12:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:43330 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhHUOMn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 10:12:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629555123; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=y7KRQfSobmPWNsi4qdqc6wl0Af72yr3bwElTiTzZROI=; b=cP5ij0ElEEpV1sYeJ7w28F/JX5gDoDhL8HKp7ps15Z0pOFuNWuVuRO7uGYVhrmBiJF80E0Gw
 Z/zBkmi7ransUZqQ4vxY8OHxR5wBdHbVcG3NDsyy5Z5y415b4ox59LvufD/OGuCdVXTdoTYm
 NmUpbDpAgv183Msl9PmR8wnjy+E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6121099ff588e42af19f30d5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 14:11:43
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33CF5C43460; Sat, 21 Aug 2021 14:11:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3DC3C4338F;
        Sat, 21 Aug 2021 14:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org F3DC3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     stas.yakovlev@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipw2x00: no need to initilise statics to 0
References: <20210817115438.33449-1-wangborong@cdjrlc.com>
Date:   Sat, 21 Aug 2021 17:11:34 +0300
In-Reply-To: <20210817115438.33449-1-wangborong@cdjrlc.com> (Jason Wang's
        message of "Tue, 17 Aug 2021 19:54:38 +0800")
Message-ID: <87pmu6sx9l.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jason Wang <wangborong@cdjrlc.com> writes:

> Global static variables dont need to be initialised to 0. Because
> the compiler will initilise them.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
> index 47eb89b773cf..6bfe55d79ce1 100644
> --- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
> +++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c

[...]

> @@ -7197,7 +7197,7 @@ static int ipw2100_wx_set_txpow(struct net_device *dev,
>  {
>  	struct ipw2100_priv *priv = libipw_priv(dev);
>  	int err = 0, value;
> -	
> +

Unrelated change.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
