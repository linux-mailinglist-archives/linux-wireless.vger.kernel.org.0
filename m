Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7BC3234
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfJALQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:16:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbfJALQ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:16:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3E77760A05; Tue,  1 Oct 2019 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569928615;
        bh=7cR0arRKi/SCYXtaaoqTZQnZ5L3q7IfxNdGtWUL6QIU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OoctPRYo+kYjnsAKoqb/C8IdV0mcUTqp5j88KB53c82Lmqz/8PFeiAAZ9oj5zyYo4
         KgSie/TWdJmrXJ/qC9cgoBsHKGFtmK9t3lK23yHe1TH78RtSyGEoFHCNRKUXcWx6Z6
         DcUZqeMgZiviKO9xm9uwhjTcOzZUpikHj7/bh+Tg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F1BC601D4;
        Tue,  1 Oct 2019 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569928614;
        bh=7cR0arRKi/SCYXtaaoqTZQnZ5L3q7IfxNdGtWUL6QIU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=B3KJ+qTXLRTd5OSU+pQoICBuLgtTxcrv+1kb1ucLMz39WstQdZmU7+xAMb7rkB2X2
         RpbP25h0hyHaym53L1aRSkp0DqmgShgiiHTHo3XAHGeQmwyJx+if9mdk30aK4VQ0kX
         cmtWtvGT1gJ8asbRdc+CEJVMuPOrhXXmWsWsCfOw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F1BC601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath10k: switch to ieee80211_tx_dequeue_ni
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190617200140.6189-2-erik.stromdahl@gmail.com>
References: <20190617200140.6189-2-erik.stromdahl@gmail.com>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Erik Stromdahl <erik.stromdahl@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001111655.3E77760A05@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 11:16:55 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> wrote:

> Since ath10k_mac_tx_push_txq() can be called from process context, we
> must explicitly disable softirqs before the call into mac80211.
> 
> By calling ieee80211_tx_dequeue_ni() instead of ieee80211_tx_dequeue()
> we make sure softirqs are always disabled even in the case when
> ath10k_mac_tx_push_txq() is called from process context.
> 
> Calling ieee80211_tx_dequeue_ni() with softirq's already disabled
> (e.g., from softirq context) should be safe as the local_bh_disable()
> and local_bh_enable() functions (called from ieee80211_tx_dequeue_ni)
> are fully reentrant.
> 
> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

306547608c84 ath10k: switch to ieee80211_tx_dequeue_ni

-- 
https://patchwork.kernel.org/patch/11000363/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

