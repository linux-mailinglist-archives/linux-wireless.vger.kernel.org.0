Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0074B9DAB
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394099AbfIULtW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 07:49:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbfIULtW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 07:49:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CCECA61196; Sat, 21 Sep 2019 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569066561;
        bh=ktJ6zeHiaiXJq+CeabslabaI0JgFMHZNOK+gpbAFFA4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cfnf1/OfXeKkBfGDUzC/pyJKI5JiosdeIBdM4BzWT68wnNVU0hyBtHkVwclLohfec
         ChPKsBtiBICalODk28PSc6Mj9Vexs/cyF+0pewJpPhxAisPG9utlx5XvDvPIU/LiLy
         N3t2KKiGlfW6zs2B/llLop8rUrIqvDxrFuDkhW8Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4243F61196;
        Sat, 21 Sep 2019 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569066561;
        bh=ktJ6zeHiaiXJq+CeabslabaI0JgFMHZNOK+gpbAFFA4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cfnf1/OfXeKkBfGDUzC/pyJKI5JiosdeIBdM4BzWT68wnNVU0hyBtHkVwclLohfec
         ChPKsBtiBICalODk28PSc6Mj9Vexs/cyF+0pewJpPhxAisPG9utlx5XvDvPIU/LiLy
         N3t2KKiGlfW6zs2B/llLop8rUrIqvDxrFuDkhW8Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4243F61196
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add fw coredump for sdio when firmware assert
References: <1567132338-7407-1-git-send-email-wgong@codeaurora.org>
Date:   Sat, 21 Sep 2019 14:49:18 +0300
In-Reply-To: <1567132338-7407-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Fri, 30 Aug 2019 10:32:18 +0800")
Message-ID: <87zhixamyp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> When firmware assert, it need coredump to analyze, this patch will
> collect the register and memory info for sdio chip.
>
> The coredump configuration is different between PCIE and SDIO for
> the same reversion, so this patch add bus type to distinguish PCIE
> and SDIO chip for coredump.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
> +{
> +	struct ath10k_fw_crash_data *crash_data;
> +	char guid[UUID_STRING_LEN + 1];
> +	u32 fast_dump = 0;
> +
> +	ath10k_err(ar, "begin fw dump\n", guid);
> +
> +	ath10k_sdio_check_fw_reg(ar, &fast_dump);
> +
> +	if (fast_dump)
> +		ar->bmi.done_sent = false;

After looking more closely, the ar->bmi.done_set checks in bmi.c does
not look necessary to me, I have never seen that warning. I would remove
those and the done_sent field altogether from ath10k to make the code
cleaner and I avoid hacks like above. This should be done in a separate
patch, of course.

-- 
Kalle Valo
