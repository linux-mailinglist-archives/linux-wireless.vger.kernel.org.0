Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1823F3ADC
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhHUOFg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 10:05:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51836 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhHUOFf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 10:05:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629554696; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=yPCLxteyz/xlxZXhwIcbkVbDkQXJmXAzBM77r0uwhsY=; b=JvTLOpXGWzhOoJ9UGRriGfdhYfjALoH76aqRBw8k7ZbjMNNk16hTDGIl9Fqy+LU4MSlB/xyN
 btk3H+JQO2DIuRml9Fm49V0kS7H7X4OFm9aPDHtea4C6+GU/5PGUlDDLXgUV+D+bNBwvVmY+
 jmnTX+2lg9OJPnKtsc6stjutdWQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 612107fef588e42af1980a5d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 14:04:46
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2FC0C4360C; Sat, 21 Aug 2021 14:04:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 844A6C4338F;
        Sat, 21 Aug 2021 14:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 844A6C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 08/12] iwlwifi: export DHC framework and add first public entry, twt_setup
References: <20210820110318.260751-1-luca@coelho.fi>
        <iwlwifi.20210820140104.b5c7c6613634.I53b8d9fb194b88070a0df6613f7f57668ea0eaf8@changeid>
Date:   Sat, 21 Aug 2021 17:04:43 +0300
In-Reply-To: <iwlwifi.20210820140104.b5c7c6613634.I53b8d9fb194b88070a0df6613f7f57668ea0eaf8@changeid>
        (Luca Coelho's message of "Fri, 20 Aug 2021 14:03:14 +0300")
Message-ID: <87y28usxl0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> Export the debug host command framework and add the twt_setup entry.
> This will allow external parties to use these debugging features.
> More entries can be added later on.
>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -92,6 +92,12 @@ config IWLWIFI_BCAST_FILTERING
>  	  If unsure, don't enable this option, as some programs might
>  	  expect incoming broadcasts for their normal operations.
>  
> +config IWLWIFI_DHC
> +	bool "Enable debug host commands"
> +	help
> +	  This option enables the debug host command API.  It's used
> +	  for debugging and validation purposes.
> +

Why a new Kconfig option? Those should not be added lightly.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
