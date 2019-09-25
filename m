Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA104BD7D2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 07:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411762AbfIYFlI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 01:41:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47576 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404361AbfIYFlI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 01:41:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 935786119D; Wed, 25 Sep 2019 05:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569390067;
        bh=4DnRI3/6DjoOwEPHvWGENKwNlQJEvOPUUpyFPzCCa+4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Uc8o7j4T4Mi8OdYnJk7heDds0V8D4t+cr21xYpm5ZDz0NgVvF3c1Hh/Vrjo2O0BpW
         l2e3pOnbr6WgJ3EeS8JFm6ZeU6UvY5cTdmM7QDh8Viu7OwtT3brXeOqa93YPe9BbRW
         gdVp9yR+0No5UY8OcO55Y1Y+GTHKqaiwK4QJHGhE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B44E609F3;
        Wed, 25 Sep 2019 05:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569390067;
        bh=4DnRI3/6DjoOwEPHvWGENKwNlQJEvOPUUpyFPzCCa+4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=EvtodZJFV3RV/4RH2bzYXXGQHylIZQbZBLrj4YbbxQHk1khqchloPsTFl8rWrLGQd
         iZX6zoyYbiBgWwUdlZJ0l6G2dUCqi/PEIETXQGMBCTUdEPx/SDTd7bY4eFi3B3frS0
         K0amIrY7L96qVk1FSmU+OIBXVuT4CfwlKlGLVrq4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B44E609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: remove iteration in wake_tx_queue
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190327162906.6010-1-erik.stromdahl@gmail.com>
References: <20190327162906.6010-1-erik.stromdahl@gmail.com>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     kvalo@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, yiboz@codeaurora.org,
        Erik Stromdahl <erik.stromdahl@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190925054107.935786119D@smtp.codeaurora.org>
Date:   Wed, 25 Sep 2019 05:41:07 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> wrote:

> Iterating the TX queue and thereby dequeuing all available packets in the
> queue could result in performance penalties on some SMP systems.
> 
> The reason for this is most likely that the per-ac lock (active_txq_lock)
> in mac80211 will be held by the CPU iterating the current queue.
> 
> This will lock up other CPUs trying to push new messages on the TX
> queue.
> 
> Instead of iterating the queue we fetch just one packet at the time,
> resulting in minimal starvation of the other CPUs.
> 
> Reported-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>

Like others, I'm not convinced about this either. To me it looks like a quick
workaround instead of properly investigating, and fixing, the root cause. To my
understanding the throughput dip was caused by this commit:

e3148cc5fecf ath10k: fix return value check in wake_tx_q op

So to me it feels like the issue has been there all along, just hidden, and the
fix above just exposed it.

-- 
https://patchwork.kernel.org/patch/10873753/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

