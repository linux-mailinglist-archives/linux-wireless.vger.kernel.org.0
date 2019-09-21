Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53393B9C78
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 07:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfIUFvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 01:51:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfIUFvG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 01:51:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 296A761359; Sat, 21 Sep 2019 05:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569045065;
        bh=n0Ws074/MDrbfrb+vO4pu/beY0J+Jf2yuRfusYBPM1E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pJUxCdBgqctPm7Mzgv3xYrjOn/uv57hqe5vX5As4HQEh7iDzPLfpYIHUkfjLY1jNN
         UCNYk06C1Xl0SpNNYJbL6OVUrtx/j3szYoDTmS+maPdH9icGdqYyCUXy7w+Wz3JiGj
         31gyA4V9ZRrWJU8rbaRoRhWvJh8Pccb4oRl+ETgs=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD19860C72;
        Sat, 21 Sep 2019 05:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569045064;
        bh=n0Ws074/MDrbfrb+vO4pu/beY0J+Jf2yuRfusYBPM1E=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=htfMHQqTc6AmCRBBcCgYdiAu/6CJGmWwbqoZj54Fze/wdUssTSipIC/+i/Usrot70
         dy9fSyGBIoOtQgiXZSyZ85q6yW1McPS6Hb+FJAr+J4OyWdU7oCcw3orEQ0iUSkuCod
         7VERACDU4tVCNaippGZFivkUXvAbl8EdFuwFnq2I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD19860C72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/15] rtw88: configure firmware after HCI started
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1568617425-28062-3-git-send-email-yhchuang@realtek.com>
References: <1568617425-28062-3-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190921055105.296A761359@smtp.codeaurora.org>
Date:   Sat, 21 Sep 2019 05:51:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> After firmware has been downloaded, driver should send
> some information to it through H2C commands. Those H2C
> commands are transmitted through TX path.
> 
> But before HCI has been started, the TX path is not
> working completely. Such as PCI interfaces, the interrupts
> are not enabled, hence TX interrupts will not be issued
> after H2C skb has been DMAed to the device. And the H2C
> skbs will not be released until the device is powered off.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

This didn't apply. Please rebase on top of wireless-drivers, mark this
as "[PATCH 5.4 v2]" and resend.

fatal: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw88/mac.c).
error: could not build fake ancestor
Applying: rtw88: configure firmware after HCI started
Patch failed at 0001 rtw88: configure firmware after HCI started
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11146411/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

