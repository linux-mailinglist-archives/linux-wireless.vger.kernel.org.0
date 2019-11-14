Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81C1FC99D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 16:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfKNPN6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 10:13:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53962 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNPN6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 10:13:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8C8BA60D96; Thu, 14 Nov 2019 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573744437;
        bh=7Cxj4ZTAH1IfirrIq9+4WeGOEgM8w1vic/fFeGDxF20=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SAeiH3otYpNjT+RQI3uT29hlk2eNyZabfDl3BsXQkLvDBQvjswq2avIaOYDNqKUBV
         Y6B/8MvrO45jQ6gCYM3B9sWTI/RPEuA0twLUulqfi1k2MzM6alG19JCa9KNVJ5vEVZ
         ApaYCZdTOH2Pzd95AIBK9IIsbb6t6KLpUg1cy754=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E88360736;
        Thu, 14 Nov 2019 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573744436;
        bh=7Cxj4ZTAH1IfirrIq9+4WeGOEgM8w1vic/fFeGDxF20=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=D5PKJTieVxhZppGfFPzHC2/QZs2aoNP3+Vjg50pzDDSmqxGZbAyVNN7tD34Ga4m+C
         h56wt5TjeEqzzCSr6rzc13qb7OXSMsUkw5yC/dTaKE8y0sy6pbcymPjofeqwRJ41ps
         A5eJq9lqb9TCuArrpRYvw0RNHlyYbD+3+nsxcPyQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E88360736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mwifiex: Re-work support for SDIO HW reset
References: <20191112124021.8718-1-ulf.hansson@linaro.org>
        <20191112124021.8718-2-ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 17:13:51 +0200
In-Reply-To: <20191112124021.8718-2-ulf.hansson@linaro.org> (Ulf Hansson's
        message of "Tue, 12 Nov 2019 13:40:19 +0100")
Message-ID: <87zhgybids.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
> when the SDIO card is shared with another SDIO func driver. This is the
> case when the Bluetooth btmrvl driver is being used in combination with
> mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
> the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
> point, the btmrvl driver will fail to communicate with the SDIO card.
>
> This is a generic problem for SDIO func drivers sharing an SDIO card, which
> are about to be addressed in subsequent changes to the mmc core and the
> mmc_hw_reset() interface. In principle, these changes means the
> mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
> the SDIO card, as to indicate to the caller that the reset needed to be
> scheduled asynchronously through a hotplug mechanism of the SDIO card.
>
> Let's prepare the mwifiex driver to support the upcoming new behaviour of
> mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
> support the asynchronous SDIO HW reset path. This also means, we need to
> allow the ->remove() callback to run, without waiting for the FW to be
> loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
> called when a reset has been scheduled, but waiting to be executed. In this
> scenario let's simply return -EBUSY to abort the suspend process, as to
> allow the reset to be completed first.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Look good to me. Ulf, I assume you are going to take this so here's my
ack:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

But let me know if I should take it instead, whatever works the best for
you.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
