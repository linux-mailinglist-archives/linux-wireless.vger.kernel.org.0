Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DC7149B10
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 15:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgAZO16 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 09:27:58 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:28471 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387401AbgAZO15 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 09:27:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580048877; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=0rPOLB0oMazvkqBbmaIrXbhKMlza0H/GTIy0jvYRGbU=;
 b=qLk8PZtzzOJhdd/3tiAs0PzitA9eBF+iy4zQIxdDaPmfWi2DRO+3lfEfJzj1l+IPsJsZ3Kz3
 zMx/T5KytHxH52rGaorfuXk0vkjwImSKY3AsyYZndk0XiEvnVUyhNVWVyV3DE7ZjDULPW3sH
 JcVSKQTDyecnzFYiPm1lDIPXomo=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2da1ec.7f28a8cc8650-smtp-out-n01;
 Sun, 26 Jan 2020 14:27:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F4214C433A2; Sun, 26 Jan 2020 14:27:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43F1BC43383;
        Sun, 26 Jan 2020 14:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43F1BC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: htt stats module does not handle multiple skbs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191217172200.7470-1-john@phrozen.org>
References: <20191217172200.7470-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126142755.F4214C433A2@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 14:27:55 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> This patch removes the "done" check from the stats handler thus allowing
> the code to parse more skbs.
> 
> Reviewed-by: John Crispin <john@phrozen.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

s-o-b from John missing

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11298295/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
