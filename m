Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F966318FD8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhBKQYt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 11:24:49 -0500
Received: from so15.mailgun.net ([198.61.254.15]:12902 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbhBKQWm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 11:22:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613060541; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=rvz/UFuBm7K8XYeVz4DbF3kwxCtTxu51wzKIUanxBOk=; b=g3uu73kaNqE8ThMnxAI+X83YDAsSw9LbEumD0ONIwCi6gEXVimYvyVU/U+DV7fO6pMHC/shV
 DPGS8b9B8SR5unsbUOlGTlNE+bExqO1e7BOuNBfwDV/q7jETgdlaIUay8Uv92Uxu0n5HsfCo
 DVUKg6uE6oXEEYp4KyfyRai+1pc=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 602559a0e4842e912827d14f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 16:21:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 580FAC433CA; Thu, 11 Feb 2021 16:21:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10B50C433CA;
        Thu, 11 Feb 2021 16:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10B50C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] iwlwifi: pnvm: implement reading PNVM from UEFI
References: <iwlwifi.20210211015026.289084803334.Ie234805047df3be84f4235f9dafaf4cdecf0db9a@changeid>
Date:   Thu, 11 Feb 2021 18:21:47 +0200
In-Reply-To: <iwlwifi.20210211015026.289084803334.Ie234805047df3be84f4235f9dafaf4cdecf0db9a@changeid>
        (Luca Coelho's message of "Thu, 11 Feb 2021 01:50:41 +0200")
Message-ID: <87sg62shgk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> We now support fetching the PNVM data from a UEFI variable.  Add the
> code to read this variable first and use it.  If it's not available,
> we fall back to reading the data from the filesystem, as before.
>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> --- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
> @@ -10,6 +10,7 @@
>  #include "fw/api/commands.h"
>  #include "fw/api/nvm-reg.h"
>  #include "fw/api/alive.h"
> +#include <linux/efi.h>
>  
>  struct iwl_pnvm_section {
>  	__le32 offset;
> @@ -219,6 +220,88 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
>  	return -ENOENT;
>  }
>  
> +/*
> + * This is known to be broken on v4.19 and to work on v5.4.  Until we
> + * figure out why this is the case and how to make it work, simply
> + * disable the feature in old kernels.
> + */
> +#if defined(CONFIG_EFI)

The comment doesn't really make sense anymore, can you send a followupb
patch to remove it? No need to change the tag because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
