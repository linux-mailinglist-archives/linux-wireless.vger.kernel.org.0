Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8372F54F79
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfFYM6w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:58:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfFYM6w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:58:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 78CB560300; Tue, 25 Jun 2019 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467531;
        bh=a8Rca21arwvNo+iIyTeF4mU7wZ/+IYY/W7PLD8V0MaU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jYUsyjhsWEPvPGUPvMjb5s1HE8IvJZ4VC/Fw/0vok5fAIUoHtxtgOTQ2P6uiHAJ2u
         VDzizHexxXzBfpTIowMVuCXpNtgXTxdK1ubQlXswXvXN8NlOiIRFEkTrjgYmDGemxw
         hD5bqJu0ln8eXzsqS6qp5QnUG2CBjmzx7H2eSO1E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6CE6601B4;
        Tue, 25 Jun 2019 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467531;
        bh=a8Rca21arwvNo+iIyTeF4mU7wZ/+IYY/W7PLD8V0MaU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=n49b72GnReoYeQbLR0U6ni1ZKl+EZbJBYvF9TyXel8akMEfgKKDkeoYS/gWtD4bke
         iAh3CPMrxVMajg8Z9FHtJvM0ISHXgGekw6VKrhhx/TI360ljG7anf6He+zm9aPyalh
         K6N8aXhT4PbVl/DMj5PfSNayxoSWhcVk3MN9Uo1I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6CE6601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: add missing error handling
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190523071534.254611-1-tientzu@chromium.org>
References: <20190523071534.254611-1-tientzu@chromium.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org, Claire Chang <tientzu@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625125851.78CB560300@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 12:58:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Claire Chang <tientzu@chromium.org> wrote:

> In function ath10k_sdio_mbox_rx_alloc() [sdio.c],
> ath10k_sdio_mbox_alloc_rx_pkt() is called without handling the error cases.
> This will make the driver think the allocation for skb is successful and
> try to access the skb. If we enable failslab, system will easily crash with
> NULL pointer dereferencing.
> 
> Call trace of CONFIG_FAILSLAB:
> ath10k_sdio_irq_handler+0x570/0xa88 [ath10k_sdio]
> process_sdio_pending_irqs+0x4c/0x174
> sdio_run_irqs+0x3c/0x64
> sdio_irq_work+0x1c/0x28
> 
> Fixes: d96db25d2025 ("ath10k: add initial SDIO support")
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4b553f3ca4cb ath10k: add missing error handling

-- 
https://patchwork.kernel.org/patch/10957013/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

