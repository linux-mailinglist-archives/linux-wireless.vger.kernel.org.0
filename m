Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6E3F3AE0
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhHUOJA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 10:09:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50973 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhHUOI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 10:08:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629554900; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=C6UtDOvdMIlq/YdLmc9o2DCdspCE21+q4vqRBnIsYGE=; b=E4jaLYWOrV2NnIHfPkseT5aqB7RqELuWIJ1MRRkjhtfKsyONNM0pYGdtiQpkii1Y3mgZCzcb
 SQGsNL9fIOgGsZTZ4i+Mj3OVIf1WrAizj1roXMNUd/1evXv4x4Z2qkYw9qPva+kCs+Y3MGfQ
 EiOvL3ym53L/AfQOxeWyy+ZzCWI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 612108c19b8228d0d0a892bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 14:08:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64AD9C43460; Sat, 21 Aug 2021 14:08:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C64EC4338F;
        Sat, 21 Aug 2021 14:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2C64EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 10/12] iwlwifi: Add support for getting rf id with blank otp
References: <20210820110318.260751-1-luca@coelho.fi>
        <iwlwifi.20210820140104.8f8ce6f25ecd.Iec9b2e2615ce65e6aff5ce896589227a7030f4cf@changeid>
Date:   Sat, 21 Aug 2021 17:07:53 +0300
In-Reply-To: <iwlwifi.20210820140104.8f8ce6f25ecd.Iec9b2e2615ce65e6aff5ce896589227a7030f4cf@changeid>
        (Luca Coelho's message of "Fri, 20 Aug 2021 14:03:16 +0300")
Message-ID: <87tujisxfq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Matti Gottlieb <matti.gottlieb@intel.com>
>
> When having a blank OTP the only way to get the rf id
> and the cdb info is from prph registers.
>
> Currently there is some implementation for this, but it
> is located in the wrong place in the code (should be before
> trying to understand what HW is connected and not after),
> and it has a partial implementation.
>
> Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> +/*
> + * struct iwl_crf_chip_id_reg
> + *
> + * type: bits 0-11
> + * reserved: bits 12-18
> + * slave_exist: bit 19
> + * dash: bits 20-23
> + * step: bits 24-26
> + * flavor: bits 27-31
> + */
> +struct iwl_crf_chip_id_reg {
> +	u32 type : 12;
> +	u32 reserved : 7;
> +	u32 slave_exist : 1;
> +	u32 dash : 4;
> +	u32 step : 4;
> +	u32 flavor : 4;
> +};

This doesn't look endian safe.

> +	/* Set CDB capabilities */
> +	if (cdb & BIT(4)) {
> +		iwl_trans->hw_rf_id += BIT(28);
> +		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
> +	}

Magic numbers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
