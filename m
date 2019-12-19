Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB2126682
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 17:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSQSJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 11:18:09 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:38680 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfLSQSJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 11:18:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576772288; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/NH2DjkJrdTkA68+6Y5/lVgk8HJ1rui/cM9uWnYe8o8=;
 b=vOaD1arJKJxm+J3w32ky2qE3AYUxqW2THDw1n23gjDe5Q96VHyuHWRiBZGlTbKs5kQQqBtTK
 RjqQEiLXxUmGJxwbhtTW67KRA0gaF3+J5zuLLzYL+OPDZt1HOBCTd/O2pEfFTvCg4RM8pocR
 2QuVAJp3G6RIk2mdWLDUKDzp1FI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfba2bf.7ff4bf795e68-smtp-out-n01;
 Thu, 19 Dec 2019 16:18:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E1B8C433A2; Thu, 19 Dec 2019 16:18:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CA8EC43383;
        Thu, 19 Dec 2019 16:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CA8EC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath11k: explicitly cast wmi commands to their correct
 struct type
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191205062645.6033-2-john@phrozen.org>
References: <20191205062645.6033-2-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191219161806.7E1B8C433A2@smtp.codeaurora.org>
Date:   Thu, 19 Dec 2019 16:18:06 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> Three of the WMI command handlers were not casting to the right data type.
> Lets make the code consistent with the other handlers.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

77ea8b455ca1 ath11k: explicitly cast wmi commands to their correct struct type

-- 
https://patchwork.kernel.org/patch/11274221/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
