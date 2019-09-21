Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8EB9DA6
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 13:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391948AbfIULi5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 07:38:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391840AbfIULi5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 07:38:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7071A613A3; Sat, 21 Sep 2019 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569065936;
        bh=gtYhQeg/21GWcRbAWVIoleIi/D4OfJWAySgPFth563E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Gasq7a7D11UJZZv4Tpu3aNJv233VM4j3FKDMmmX+xa5004yBqMRQQ/hhjALYtXaaz
         zY4YPGxmBIyEJzXPiZHCcdGMsjaWyZgrVveN7A1x6ze/NiCK/Dr3lasbKZborSWoXU
         tO+DybnPD7IsK7Euon4YPAayxZ+QbNMk542ApXd0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E672060364;
        Sat, 21 Sep 2019 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569065935;
        bh=gtYhQeg/21GWcRbAWVIoleIi/D4OfJWAySgPFth563E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IG5Be7gG/Ruoj9ixMfugFz4onA02AMlRiPTPwbWEcsYWvgsaugs7SdXIaLgxjKJFq
         tG6tqULvXGqZSXfhiLD6q6EiLttbWB84wA0iMzhK0xDJMc6OnYxWpYr76oH1sBOaca
         5DTJrCi5jyDjWuAlUvTBqedxVOm0YIqjx8fbiaEo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E672060364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add fw coredump for sdio when firmware assert
References: <1567132338-7407-1-git-send-email-wgong@codeaurora.org>
Date:   Sat, 21 Sep 2019 14:38:52 +0300
In-Reply-To: <1567132338-7407-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Fri, 30 Aug 2019 10:32:18 +0800")
Message-ID: <874l15c20j.fsf@codeaurora.org>
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

> +static int ath10k_sdio_read_mem(struct ath10k *ar, u32 address, void *buf,
> +				u32 buf_len)
> +{
> +	u32 val;
> +	int i, ret;
> +
> +	for (i = 0; i < buf_len; i += 4) {
> +		ret = ath10k_sdio_hif_diag_read32(ar, address + i, &val);
> +		if (ret) {
> +			ath10k_warn(ar, "unable to read mem %d value\n", address + i);
> +			break;
> +		}
> +		memcpy(buf + i, &val, 4);
> +	}
> +
> +	return ret;
> +}

What's wrong with ath10k_sdio_hif_diag_read()? AFAICS this whole
function duplicates just what it does.

-- 
Kalle Valo
