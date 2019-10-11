Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E433D3BB5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfJKI4U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 04:56:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfJKI4U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 04:56:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 87D4960B19; Fri, 11 Oct 2019 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570784179;
        bh=bpNA8VsKhnHl0p2xyTrJDz/NNJoB6iv7vDsRgC/Sn5M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EQDVt9ax8d7L54V5ZNQmSksIGOyh+VYOEWv96tBhCoZREHNC70FGBF/cNcIyuJ4KH
         hlmG1dSqyLaUR9B1N8YeNPDnegiNVd+gH5J/ulvcTxuVO/W+jUveVOSeOUOZFFWeTY
         aUeN84gPTVNOW4A3qom04DdeYHpKBC/lSD65BS9c=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C513560709;
        Fri, 11 Oct 2019 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570784178;
        bh=bpNA8VsKhnHl0p2xyTrJDz/NNJoB6iv7vDsRgC/Sn5M=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=IqxomHHhYYmjNRR+J6pxRfKaHPBumQrQO+yIfrJI+MzQbbzuRaMjNJNIo/ooCYwYi
         +SZkEC200Aduv7c6qstpPea0jif2sxDNIY91kewJstJGcCfoX8gAnSuU0SFI212c03
         Z3B7SxuM6wN81BjR9ElGLab1wRTLep71+ZLLhhJ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C513560709
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv3] wlcore: clean-up clearing of WL1271_FLAG_IRQ_RUNNING
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191009165006.41567-1-tony@atomide.com>
References: <20191009165006.41567-1-tony@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Eyal Reizer <eyalr@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Guy Mishol <guym@ti.com>, linux-wireless@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191011085619.87D4960B19@smtp.codeaurora.org>
Date:   Fri, 11 Oct 2019 08:56:19 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:

> We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), but clear
> it before interrupt handling is done in wlcore_irq_locked().
> 
> Let's move the clearing to the end of wlcore_irq() where it gets set,
> and remove the old comments about hardirq. That's no longer the case as
> we're using request_threaded_irq().
> 
> Note that the WL1271_FLAG_IRQ_RUNNING should never race between the
> interrupt handler and wlcore_runtime_resume() as because of autosuspend
> timeout we cannot enter idle between wlcore_irq_locked() and the end of
> wlcore_irq().
> 
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Eyal Reizer <eyalr@ti.com>
> Cc: Guy Mishol <guym@ti.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied to wireless-drivers-next.git, thanks.

4633d30b61ac wlcore: clean-up clearing of WL1271_FLAG_IRQ_RUNNING

-- 
https://patchwork.kernel.org/patch/11181621/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

