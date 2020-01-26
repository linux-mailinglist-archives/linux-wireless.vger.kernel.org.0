Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAAD149A1B
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 11:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgAZKaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 05:30:16 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:36378 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729268AbgAZKaP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 05:30:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580034615; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4aEVqIqI9+SlQqawbAs7IiU8R7BwwIk/UJc+UVjYgSw=;
 b=eOZ0qR1Wki9xa2C/9TSwhCklFI3CIyk6DVZx1dDOqKH0+VTo8em3Nd2/dCmVjYxbPufk6pJP
 IjbluZma8zrGG46Bm0fGe+4dr6iipXRvQVHE89ZIqARqMrJ+iSvwqhCx2w3e322TCHKt+AOA
 fXXyVC/ljMQatpewT64iekJPbI4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d6a33.7f2016c10fb8-smtp-out-n03;
 Sun, 26 Jan 2020 10:30:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6424C4479C; Sun, 26 Jan 2020 10:30:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 792C3C433CB;
        Sun, 26 Jan 2020 10:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 792C3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next 4/6] ath10k: use true,false for bool variable
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1577196966-84926-5-git-send-email-zhengbin13@huawei.com>
References: <1577196966-84926-5-git-send-email-zhengbin13@huawei.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     <yhchuang@realtek.com>, <davem@davemloft.net>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <zhengbin13@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126103011.D6424C4479C@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 10:30:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

zhengbin <zhengbin13@huawei.com> wrote:

> Fixes coccicheck warning:
> 
> drivers/net/wireless/ath/ath10k/htt_rx.c:2143:2-31: WARNING: Assignment of 0/1 to bool variable
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

0f7ab288ade9 ath10k: use true,false for bool variable

-- 
https://patchwork.kernel.org/patch/11309357/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
