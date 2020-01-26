Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8544149B86
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAZPmt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:42:49 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:63483 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgAZPms (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:42:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580053368; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pGkhpKrR4CRPCZ9NCtBbX44MpCjk6yi3sXW3YqTak7s=;
 b=SByr3btbpo2PMrIkJgmSKP7UICO4vFNiTQjuwijVkzZIZg+AOTN1313EXeua/ZdNRaho8oNg
 UTAGtF2LAF8vDHDa7GBPhQWtAYGUrrrHGzOUIW0c1BfZo1RZQoS+AuPDf0ieq0z49E8IUb/e
 rVX3DH4W2VdkZkYzlNiJiN6NtnI=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db377.7f90b74392d0-smtp-out-n01;
 Sun, 26 Jan 2020 15:42:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BD18BC433CB; Sun, 26 Jan 2020 15:42:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06455C43383;
        Sun, 26 Jan 2020 15:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06455C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix potential NULL skb access in TX ISR
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200107080807.14433-1-yhchuang@realtek.com>
References: <20200107080807.14433-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <mikhail.v.gavrilov@gmail.com>, <rtereguloff@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126154247.BD18BC433CB@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 15:42:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Sometimes the TX queue may be empty and we could possible
> dequeue a NULL pointer, crash the kernel. If the skb is NULL
> then there is nothing to do, just leave the ISR.
> 
> And the TX queue should not be empty here, so print an error
> to see if there is anything wrong for DMA ring.
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

f4f84ff8377d rtw88: fix potential NULL skb access in TX ISR

-- 
https://patchwork.kernel.org/patch/11320567/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
