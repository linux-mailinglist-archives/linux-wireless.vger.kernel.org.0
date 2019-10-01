Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0789C334F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbfJALs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:48:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJALs3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:48:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 97B8961213; Tue,  1 Oct 2019 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569930507;
        bh=Wb4lZwb9g/pt0+rJG1lh2i9/SJ75BfIWfkH1h3/wW6I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=b/HodGGaZ5tj3cvwJmHcsizgDyBgLF+R7FtNIsHGI2U9UubElKQUZMvQGJ6nZu+Tu
         P95lP7Ii8EAoVQjf+NN7a+GVvQDgHauDyNrCdmq1K7QPRD2WZpzYQrSNCswMPMLvuV
         mAmAIK9pP9vrU8x+YdnF2+jqZaIqHOxXLsONlWYA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE6E0616B8;
        Tue,  1 Oct 2019 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569930505;
        bh=Wb4lZwb9g/pt0+rJG1lh2i9/SJ75BfIWfkH1h3/wW6I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fiLr0KMZ5m5Gw/1f0MApBKZcaT91lJB9Q4m1K/X8q6B0lxh9h7xoiU0GcbUTZxWRQ
         RggROlIuKgqIRmgN+UTKRBORyJhGccovfTPmSOLocSZE5es5LRrP6p1MYzkDnyQFOC
         +njiN3AoVkPntpYPc+jo8SVE7t2pJU1qQZfee5E4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE6E0616B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ath10k: switch to ieee80211_tx_dequeue_ni
References: <20190617200140.6189-1-erik.stromdahl@gmail.com>
        <20190617200140.6189-2-erik.stromdahl@gmail.com>
Date:   Tue, 01 Oct 2019 14:48:20 +0300
In-Reply-To: <20190617200140.6189-2-erik.stromdahl@gmail.com> (Erik
        Stromdahl's message of "Mon, 17 Jun 2019 22:01:40 +0200")
Message-ID: <87eezw660r.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> writes:

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

I already applied this, but I still want to check _why_ you are changing
this? Is it that you want to call ath10k_mac_tx_push_pending() from a
workqueue in sdio.c in a future patch, or what? Because at the moment me
and Johannes were not able to find where this is called in process
context.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
