Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF16C8F9F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfJBRTX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 13:19:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBRTX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 13:19:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A8A861156; Wed,  2 Oct 2019 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570036762;
        bh=imE2p37CSqor8L69mmMVfy+EnI7tKW4jVxuM6K6bv+0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UtWYVxTwRfZt2vGfyFBwWZtJnKkjmPjWW+kZMH1GxUEF4NSAIb1xQoXOEmLBOimmS
         JhFDQbRSos1ooeG4aXdBouD9/Y430SH9zjk093WEPPn4dUuN6a5fs/xAlw0yX2Zx3c
         n4xE/m1J+QN5RrjvmpP16RmSaSzwOfjA5QE+pMxo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6637360A78;
        Wed,  2 Oct 2019 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570036761;
        bh=imE2p37CSqor8L69mmMVfy+EnI7tKW4jVxuM6K6bv+0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=T3sIHtVzzjQP3abRNcto4X7LY9am3e34E+K+9XieUyd0RW4W7iFrv2OhoKI4fC/pU
         VqN204pWOOmKKZV66MmBAdZ/o/g/DtyW1CJIymvFssOtdB3Xy48Bke41dESTNS1D86
         Us5hwPDYRWMl8tgvMrQdHTkacMPOwuNYWoY8HdYs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6637360A78
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: restore QCA9880-AR1A (v1) detection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190906215423.23589-1-chunkeey@gmail.com>
References: <20190906215423.23589-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191002171922.8A8A861156@smtp.codeaurora.org>
Date:   Wed,  2 Oct 2019 17:19:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch restores the old behavior that read
> the chip_id on the QCA988x before resetting the
> chip. This needs to be done in this order since
> the unsupported QCA988x AR1A chips fall off the
> bus when resetted. Otherwise the next MMIO Op
> after the reset causes a BUS ERROR and panic.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a7fecb766c8 ("ath10k: reset chip before reading chip_id in probe")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f8914a14623a ath10k: restore QCA9880-AR1A (v1) detection

-- 
https://patchwork.kernel.org/patch/11136089/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

