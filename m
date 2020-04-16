Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76151AC177
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632877AbgDPMjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 08:39:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35516 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635851AbgDPMjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 08:39:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587040756; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=gxuTGmhRi0u25Gp9sTe5nLTggXf9KJ5ShQ/dHi+p8ys=; b=cU22KRKJr2IAXv/CKy4uAWft/0koOrHNnAoDeXLm93sNPaz5vPAi5bxXPeiVduhtOYz4fLEJ
 1rrnQH94jWANNgLaJZqz9gg8bXVaOyACM0zLBqCjwZc1ErysIr8sU6RJrmkuw23i116fo2SX
 XnzI4GLgcqdcWvwPvBgAO0JMcZY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9851db.7f30ab2b8ea0-smtp-out-n05;
 Thu, 16 Apr 2020 12:38:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87BBAC433F2; Thu, 16 Apr 2020 12:38:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2268FC432C2;
        Thu, 16 Apr 2020 12:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2268FC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: improve power save performance for sdio
References: <0101016ed9241282-73dd8b35-e2e5-4f37-9b50-cf2fb6524dfc-000000@us-west-2.amazonses.com>
Date:   Thu, 16 Apr 2020 15:38:48 +0300
In-Reply-To: <0101016ed9241282-73dd8b35-e2e5-4f37-9b50-cf2fb6524dfc-000000@us-west-2.amazonses.com>
        (Wen Gong's message of "Fri, 6 Dec 2019 02:57:30 +0000")
Message-ID: <877dyfr4fb.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> This patch is to set register to allow the mbox enter sleep status
> if it does not have tx traffic and wakeup it if tx traffic arrive.
> After mbox enter sleep status, the soc will enter sleep status by
> firmware, this will save power. The power consume drops from about
> 90mW to about 10mW with this patch.
>
> This patch only effect sdio chip.
>
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +static inline int ath10k_hif_set_mbox_sleep(struct ath10k *ar, bool enable_sleep)
> +{
> +	if (ar->hif.ops->set_mbox_sleep)
> +		return ar->hif.ops->set_mbox_sleep(ar, enable_sleep);
> +	return 0;
> +}

I don't think we need to add another hif op for this. I sent v2 which
uses existing op.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
