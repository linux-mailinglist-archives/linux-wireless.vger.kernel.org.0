Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598F718FB83
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 18:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgCWRah (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 13:30:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:41098 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727372AbgCWRah (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 13:30:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584984636; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=beW3neEbD2l7ePHYdP9+6I+i4KNemNKMexcFJx/fAqw=;
 b=jcLlQ8aIxOpGlI8Ewl0SLvbiW9kOM39i2+ykm4NzaMfvtYQFxBQTHFrgUSz+O7tgEqGj3QpY
 whG+amyJYYo4KEGBe8l245HiAlbQ5+x2oM0ngIRvPeUftIV4gt4drkMdV2GpKtJPkHTSUL93
 VMFoF/EtgIgKN+/XisAaAA6d7qU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e78f236.7f6574652110-smtp-out-n02;
 Mon, 23 Mar 2020 17:30:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8C57C433D2; Mon, 23 Mar 2020 17:30:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73B07C432C2;
        Mon, 23 Mar 2020 17:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73B07C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] rtw88: don't hold all IRQs disabled for PS operations
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200312080852.16684-2-yhchuang@realtek.com>
References: <20200312080852.16684-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200323173030.C8C57C433D2@smtp.codeaurora.org>
Date:   Mon, 23 Mar 2020 17:30:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Brian Norris <briannorris@chromium.org>
> 
> This driver generally only needs to ensure that
> (a) it doesn't try to process TX interrupts at the same time as
>     power-save operations (and similar)
> (b) the device interrupt gets disabled while we're still handling the
>     last set of interrupts
> 
> For (a), all the operations (e.g., PS transitions, packet handling)
> happens in non-atomic contexts (e.g., threaded IRQ).
> 
> For (b), we only need mutual exclusion for brief sections (i.e., while
> we're actually manipulating the interrupt mask/status).
> 
> So, we can introduce a separate lock for handling (b), disabling IRQs
> while we do it. For (a), we can demote the locking to BH only, now that
> (b) (the only steps done in atomic context) and that has its own lock.
> 
> This helps reduce the amount of time this driver spends with IRQs off.
> Notably, transitioning out of power-save modes can take >3 milliseconds,
> and this transition is done under the protection of 'irq_lock'.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

5 patches applied to wireless-drivers-next.git, thanks.

57fb39e24775 rtw88: don't hold all IRQs disabled for PS operations
da14a0409e3f rtw88: extract alloc rsvd_page and h2c skb routines
895c096dab36 rtw88: associate reserved pages with each vif
a5697a65ecd1 rtw88: pci: define a mask for TX/RX BD indexes
aaab5d0e6737 rtw88: kick off TX packets once for higher efficiency

-- 
https://patchwork.kernel.org/patch/11433447/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
