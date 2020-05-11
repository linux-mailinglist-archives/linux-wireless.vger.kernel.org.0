Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC621CD8CE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgEKLrk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 07:47:40 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:46022 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbgEKLrk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 07:47:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589197660; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Y/T1uybKMDjv6JlOODaJCIJW6ZeqT90BHJeaHwt6R8A=; b=v5mmR79g29AXWO9Y6YPKZinOEPAL3TqdYii7VkGiCx1VBwjiQOZS9exJ8Jvm3yrqHHX4oMbK
 l6cUfSdosfKrqmJcV68xuXsmdqi6pmscVuXxVhkg9PLgFYfr2HfPLtETS2ozhB9s9LVMRjhL
 GQXU4eWFG1vI/LHXYMhgYvVYHyU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb93b54.7f8bef84d7d8-smtp-out-n05;
 Mon, 11 May 2020 11:47:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A397AC433BA; Mon, 11 May 2020 11:47:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44509C433F2;
        Mon, 11 May 2020 11:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44509C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/11] iwlwifi: acpi: evaluate dsm to enable 5.2 bands in Indonesia
References: <20200508140802.558267-1-luca@coelho.fi>
        <iwlwifi.20200508170402.37266bcfa0a8.Iac74a6ffe45aff887cea13ee1d31b100ca11e249@changeid>
Date:   Mon, 11 May 2020 14:47:27 +0300
In-Reply-To: <iwlwifi.20200508170402.37266bcfa0a8.Iac74a6ffe45aff887cea13ee1d31b100ca11e249@changeid>
        (Luca Coelho's message of "Fri, 8 May 2020 17:07:56 +0300")
Message-ID: <874ksm66cw.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Gil Adam <gil.adam@intel.com>
>
> Evaluate the appropriate DSM from ACPI to enable 5.15,5.35 GHz
> bands in Indonesia. If enabled send LARI_CONFIG_CHANGE cmd to fw.
>
> Signed-off-by: Gil Adam <gil.adam@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> +static int iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
> +{
> +	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
> +				      DSM_FUNC_ENABLE_INDONESIA_5G2);
> +
> +	IWL_DEBUG_RADIO(mvm,
> +			"Evaluated DSM function ENABLE_INDONESIA_5G2, ret=%d\n",
> +			ret);
> +
> +	return ret == 1 ? 1 : 0;

Ugh. If it's _really_ important not to return anything bigger than 1
maybe "!!ret"? Or maybe even just change the function to return boolean?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
