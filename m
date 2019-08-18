Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE1916DE
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRNzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 09:55:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRNzq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 09:55:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3049D6231D; Sun, 18 Aug 2019 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566136546;
        bh=BL2Kz7p7wIzPYNoIQbrFpMBFEcJ3Ey7mV/4O2AJ3yh0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GXLg8qPx1OaGv4MHsOeL2WLpX5mHd++eTNpLWW/R/mUi1/LeZSWm/XXNcZBSEgFSh
         oID+kJShCpqwP7UAuZoM9FLeJtbUYCPzJg0ARTy9N/EJ8Qiqc1fSv8mYVCLwmQcav7
         xjinLAEXWHTrUzzwYQZ0fHVBl7xIMBR9OvAszAPk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBA02622EA;
        Sun, 18 Aug 2019 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566136545;
        bh=BL2Kz7p7wIzPYNoIQbrFpMBFEcJ3Ey7mV/4O2AJ3yh0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=b/tbY+YNDQ/iLapqj2V+1hbKAEUo4ofqNVwBCunDXYw76WKU8C8/ATm6k0NAJvBE3
         5EkBwd8BjAddwwCPQmlcvXwPPDm+IBdH8GRpYV+V9K6CPFoc0GpuLdrNVLCpxu3fhZ
         QODUG+Gwc6uDKUCQfvgEr4ryWtLahFV+OQlo6m/s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBA02622EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 09/22] iwlwifi: remove iwl-constants.h
References: <20190817065200.9701-1-luca@coelho.fi>
        <20190817065200.9701-10-luca@coelho.fi>
Date:   Sun, 18 Aug 2019 16:55:42 +0300
In-Reply-To: <20190817065200.9701-10-luca@coelho.fi> (Luca Coelho's message of
        "Sat, 17 Aug 2019 09:51:47 +0300")
Message-ID: <877e7abmsh.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
>
> This file is included in a few source files, but its content
> is never used. Remove it.
>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> index bf0b9ee05c44..2aa5320e9d1a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> @@ -414,6 +414,7 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
>  	HCMD_NAME(SCAN_ITERATION_COMPLETE),
>  	HCMD_NAME(D0I3_END_CMD),
>  	HCMD_NAME(LTR_CONFIG),
> +	HCMD_NAME(LDBG_CONFIG_CMD),
>  };
>  
>  /* Please keep this array *SORTED* by hex value.

The commit log does not seem to match with the actual patch.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
