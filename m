Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B6D88EE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2019 09:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbfJPHHV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 03:07:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35154 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388897AbfJPHHU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2864260D83; Wed, 16 Oct 2019 07:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571209640;
        bh=ct0U9ls+FqMa1rgNABCzniSk8y4nLfvmP8x5b4RyyRw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PxsEyyufcmpL6/G4IUydIoDCsQMQog2LvCFMCP0YUXbMXER9ZtAzTu+7N5hNRoJtS
         m5cHXUnFJWGd+qHhsnSmZg8T7qq2NU/mCMfwMs3z18rCLTPnKqcB3Ltwhs09neM2TH
         9hmLy7b7noBfbj60jbNRW9UyFdjcUtKMlT7EmW3E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (176-93-78-119.bb.dnainternet.fi [176.93.78.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D24A60D4C;
        Wed, 16 Oct 2019 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571209639;
        bh=ct0U9ls+FqMa1rgNABCzniSk8y4nLfvmP8x5b4RyyRw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cWcD6tFjFshge7xRdW6qitUSkb2jQJbyynDANBHM9ebgbKTJVCWKB29PL7rHwBv+Q
         yA5yGamTe0YcRuqr8fXyUk2A2+tvZvvNZxAXTx/dLlQvvJ8coU1+7TNkCZo0kyTX48
         f19ppn8Yq1dHjgEMfKo8DTqo+hE6Azxh2Ck7j4E8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D24A60D4C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 12/16] iwlwifi: dbg_ini: support domain changing via debugfs
References: <20191014072019.1254-1-luca@coelho.fi>
        <20191014101813.7e2742c1e22f.I65d0d5e782864f53b4ed8a6f43e72c50a09d9fd9@changeid>
Date:   Wed, 16 Oct 2019 10:07:15 +0300
In-Reply-To: <20191014101813.7e2742c1e22f.I65d0d5e782864f53b4ed8a6f43e72c50a09d9fd9@changeid>
        (Luca Coelho's message of "Mon, 14 Oct 2019 10:20:15 +0300")
Message-ID: <87pnixkw2k.fsf@codeaurora.org>
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
> Allow to change or read the debug domain bitmap at runtime via
> fw_dbg_domain debugfs.
>
> Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> +static ssize_t iwl_dbgfs_fw_dbg_domain_write(struct iwl_fw_runtime *fwrt,
> +					     char *buf, size_t count)
> +{
> +	u32 new_domain;
> +	long val;
> +	int ret;
> +
> +	if (!iwl_trans_fw_running(fwrt->trans))
> +		return -EIO;
> +
> +	ret = kstrtol(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	new_domain = (u32)val;

Why not use kstrtou32()? Then there's no need to cast anything.

-- 
Kalle Valo
