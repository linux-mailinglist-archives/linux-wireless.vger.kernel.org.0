Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C60B9DA2
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437748AbfIULf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 07:35:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46654 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407576AbfIULf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 07:35:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 41CA9614B6; Sat, 21 Sep 2019 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569065758;
        bh=Sa6iWhDUkvaHshrTDTfsw1RXV00uclcGvBV40ItW+uQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d1MZjgGyEBrftbNdvNSjHlxSBEVZSPjIJNF/+EJcnEXWqaQ19KrVLq+Adred4l8Tt
         e5i+Xr7o1OtHp2nEy3ZAWJWR6yUSYLZgvR+di+ujxulJmLiLZ1zHHIzb/SLQbEb94w
         bJyeK3fHFr4zmVPVRGjvfQvdsviO3iwprD+EZmCM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E794660790;
        Sat, 21 Sep 2019 11:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569065757;
        bh=Sa6iWhDUkvaHshrTDTfsw1RXV00uclcGvBV40ItW+uQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=B4QpphBypAxeJ7sPnuF+2jsp/m5eIeMoMHzLFhQ0NBAv7NQdbE7x4B8T7Azep52Cn
         jaxgdoRPsY0l9Zc2D7uTglKTpZPhhVJHtyo3a+bzC7AXR63E9Oyzqh6PTbcuzl5Tuq
         K0CTM7bQLXKf0ZisOcJyswK98dZS6SPW6EXSs5SU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E794660790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add fw coredump for sdio when firmware assert
References: <1567132338-7407-1-git-send-email-wgong@codeaurora.org>
Date:   Sat, 21 Sep 2019 14:35:54 +0300
In-Reply-To: <1567132338-7407-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Fri, 30 Aug 2019 10:32:18 +0800")
Message-ID: <878sqhc25h.fsf@codeaurora.org>
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

> +void ath10k_sdio_check_fw_reg(struct ath10k *ar, u32 *fast_dump)
> +{
> +	int ret = 0;
> +	u32 param;
> +
> +	ret = ath10k_sdio_read_host_interest_value(ar, HI_ITEM(hi_option_flag2), &param);
> +
> +	*fast_dump = ((param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW)
> +			     == HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW);

The commit log tells nothing about fast, it should always document the
design decisions. Why this fast dump, what's the benefit? Why not always
use the fast dump and forget the slow dump (or vice versa)? There needs
to be really good reasons to have all this complexity to support both
slow and fast dumps.

> +	ath10k_err(ar, "check fw reg : %x\n", param);
> +}

This is a debug message, not an error. And debug messages should use
format "sdio hi_option_flag2 %x\n".

-- 
Kalle Valo
