Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC22C3A7B70
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFOKL3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:11:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61674 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbhFOKL3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:11:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623751765; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5MuSs/oUTz3DWmpj0nLI8zE02yIRN/2yPmxzddIF4qY=;
 b=u1yGGxJjqoV+Q11p0xbqRfkN6ZEwlpsI2I+HrUnc2Hcjjq6CcIXKzStYhFgiQ6gi5Y9uaK/j
 ABofoJCoIchdeOmMPRIgh9q3j5kTI8g5HNAFbHclwZUL1cqonzLTqmIC+tjaA6gx2JlHrJzw
 KZSeyG2wt+aAnFFwuQ07UrdNx90=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60c87c4eabfd22a3dcb9968f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:09:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BDDEBC4360C; Tue, 15 Jun 2021 10:09:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BD65C433F1;
        Tue, 15 Jun 2021 10:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BD65C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v2] ssb: gpio: Fix alignment of comment
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210428160747.qy23g6zpmheiacpl@kewl-virtual-machine>
References: <20210428160747.qy23g6zpmheiacpl@kewl-virtual-machine>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615100917.BDDEBC4360C@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:09:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shubhankar Kuranagatti <shubhankarvk@gmail.com> wrote:

> The closing */ has been shifted to a new line
> This is done to maintain code uniformity.
> 
> Acked-by: Michael Büsch <m@bues.ch>
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

5615eb58b238 ssb: gpio: Fix alignment of comment

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210428160747.qy23g6zpmheiacpl@kewl-virtual-machine/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

