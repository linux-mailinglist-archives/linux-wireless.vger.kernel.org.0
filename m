Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65A42877D8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgJHPsD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:48:03 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:43374 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgJHPsD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602172082; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+o2kSz2gN9J3h/9I/J/XnDlXfVvlcvWffQQPZwm72/g=; b=BPdC9EnDTF+rtVikC9Ouc4PT3q+BIA2RbNiR3OLvetAmfxhx2XkLIM+9Yga8b7ITZ8T1AUCP
 S0B2YdsKetiznyZkb7rgxo6tnfxUWxSDRSJAADujk4kmV186T2ZLOD95SRg7zTFkFXAtFz5b
 +dL4a7aoiDVKlpub0vvEjwIJ4EQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f7f34b2856d9308b5c4d035 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 15:48:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0A1AC433F1; Thu,  8 Oct 2020 15:48:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F805C433CB;
        Thu,  8 Oct 2020 15:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F805C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 02/13] iwlwifi: pcie: fix the xtal latency value for a few qu devices
References: <20201008151250.332346-1-luca@coelho.fi>
        <iwlwifi.20201008181047.d0e2253c282f.Icd2ff00adff52f6c96fb261c34fbf129ce67a00d@changeid>
Date:   Thu, 08 Oct 2020 18:47:58 +0300
In-Reply-To: <iwlwifi.20201008181047.d0e2253c282f.Icd2ff00adff52f6c96fb261c34fbf129ce67a00d@changeid>
        (Luca Coelho's message of "Thu, 8 Oct 2020 18:12:39 +0300")
Message-ID: <87pn5s1zyp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> We were using 5 ms for some qu devices, but their xtal stabilizes
> much faster than that.  Reduce the value to 500 ms.
>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> index 60e0640d07dc..8b97c2eb2632 100644
> --- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> +++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> @@ -253,7 +253,7 @@ const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
>  	.device_family = IWL_DEVICE_FAMILY_22000,
>  	.base_params = &iwl_22000_base_params,
>  	.integrated = true,
> -	.xtal_latency = 5000,
> +	.xtal_latency = 500,
>  	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
>  };

The commit log doesn't make sense, I'll do s/5 ms/5 s/ during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
