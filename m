Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1062DFF5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 16:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfE2Ojy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 10:39:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2Ojy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 10:39:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1C1D609F3; Wed, 29 May 2019 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559140793;
        bh=GoraqmyLl/t/CwnESZbHZ3gb5qzZKBQnSVA2JiMmzRo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LT+5ckYywf3dp41gOHV2ra07Jffw64/YYit0SmT7u0taqJ3Lr+P9Qzip9DpIYsuuA
         AjAsqf1w0mct/Bgm7EstqGuSa+yZ8Y8e7vB3aMk9SvT7lRylDPKVoVKOcgH/e/j9Sq
         h82XX66GMEuPttZHYCKKCy7eTmefUkjhB2aEiBCY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32EB2602FA;
        Wed, 29 May 2019 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559140793;
        bh=GoraqmyLl/t/CwnESZbHZ3gb5qzZKBQnSVA2JiMmzRo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LT+5ckYywf3dp41gOHV2ra07Jffw64/YYit0SmT7u0taqJ3Lr+P9Qzip9DpIYsuuA
         AjAsqf1w0mct/Bgm7EstqGuSa+yZ8Y8e7vB3aMk9SvT7lRylDPKVoVKOcgH/e/j9Sq
         h82XX66GMEuPttZHYCKKCy7eTmefUkjhB2aEiBCY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32EB2602FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: [PATCH 4/7] iwlwifi: print fseq info upon fw assert
References: <20190529133955.31082-1-luca@coelho.fi>
        <20190529133955.31082-5-luca@coelho.fi>
Date:   Wed, 29 May 2019 17:39:49 +0300
In-Reply-To: <20190529133955.31082-5-luca@coelho.fi> (Luca Coelho's message of
        "Wed, 29 May 2019 16:39:52 +0300")
Message-ID: <87pno12ukq.fsf@kamboji.qca.qualcomm.com>
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
> Read fseq info from FW registers and print it upon fw assert.
> The print is needed since the fseq version coming from the TLV might
> not be the actual version that is used.
>
> Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> +void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
> +{
> +	struct iwl_trans *trans = fwrt->trans;
> +	unsigned long flags;
> +	int i;
> +	struct {
> +		u32 addr;
> +		const char *str;
> +	} fseq_regs[] = {
> +		FSEQ_REG(FSEQ_ERROR_CODE),
> +		FSEQ_REG(FSEQ_TOP_INIT_VERSION),
> +		FSEQ_REG(FSEQ_CNVIO_INIT_VERSION),
> +		FSEQ_REG(FSEQ_OTP_VERSION),
> +		FSEQ_REG(FSEQ_TOP_CONTENT_VERSION),
> +		FSEQ_REG(FSEQ_ALIVE_TOKEN),
> +		FSEQ_REG(FSEQ_CNVI_ID),
> +		FSEQ_REG(FSEQ_CNVR_ID),
> +		FSEQ_REG(CNVI_AUX_MISC_CHIP),
> +		FSEQ_REG(CNVR_AUX_MISC_CHIP),
> +		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM),
> +		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR),
> +	};

Can fseq_regs be static const?

-- 
Kalle Valo
