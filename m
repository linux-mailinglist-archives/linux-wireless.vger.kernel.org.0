Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE7164D6
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEGNnS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 09:43:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfEGNnS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 09:43:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 540BD60A42; Tue,  7 May 2019 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236597;
        bh=Z+9Shnu/Y9mDEfGOnI3HHEAypekxIj94n9ZZ3Y/GRUM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LOEn3eB8gbJnDf1Bov08Pnm1Wui/C0Nc8zCMEs02zNbU0jsymIhzmetJ1fQ4GFuu6
         XHj6sKYWPymxDYE2o2IoASyuDBk6lYdKe0uJ/2BD/KPgra/fjqT/QRkLuB3h0HSjQu
         3SRVAd0VZzaCRrvGkwcpB+1MxG0zqEUqMcSRnCI8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C196160A42;
        Tue,  7 May 2019 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236596;
        bh=Z+9Shnu/Y9mDEfGOnI3HHEAypekxIj94n9ZZ3Y/GRUM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=m0ygB0IqsVfLsQVTW1HdbKRsL7YKNzjsN4CNFy/tBOqyzp4/mwG4foYuiP52e6lN4
         u2hfFYwAMui5hJhjhcFns/iYguzhRh4odeWzutyVcIHQ6C3YKhJn+SiNjFT26O8W/F
         wctLcVSm9S7j9//MVtccbN3Eyih8zm4prv1RwgII=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C196160A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix the tx stats bytes & packets parsing
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1552365219-16842-1-git-send-email-yanghuan@codeaurora.org>
References: <1552365219-16842-1-git-send-email-yanghuan@codeaurora.org>
To:     Brandon Huang <yanghuan@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Brandon Huang <yanghuan@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507134317.540BD60A42@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 13:43:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brandon Huang <yanghuan@codeaurora.org> wrote:

> In tx_stats debugfs, txrate->flags may contain multiple bits. For
> example, RATE_INFO_FLAGS_SHORT_GI could be set, and tx stats bytes
> and packets will be not updated correctly.
> 
> Fix this issue by using bit operation to check txrate->flags.
> 
> Tested HW: QCA9984
> Tested Firmware: 10.4-3.9.0.1-00007
> 
> Signed-off-by: Brandon Huang <yanghuan@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9e0b341a3d66 ath10k: Fix the tx stats bytes & packets parsing

-- 
https://patchwork.kernel.org/patch/10848577/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

