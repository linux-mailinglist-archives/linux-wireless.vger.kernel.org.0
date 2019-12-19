Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1886126692
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 17:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfLSQTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 11:19:00 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:38680 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbfLSQS6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 11:18:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576772338; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WWzgqMCs3OvjqZLCaMbpY7f3izcNFaVnzcUYiTYGFw0=;
 b=QKDcqsJUmv0QC04bIdfe9DasYOetxmG3koEfc6TVLUCLxfU0hbuoc/CAaBSqZtzB9aMC2g+D
 EeioPwiYrI6e8LgFd0L4vkJRfR+z7bBq6Z72JAxkVq1N0jpfXfCnE/HtQXylDas/1RBvB9ti
 JD6DdUUp3uZeSu7zZTGEHYN//rM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfba2f1.7fb23f4df0a0-smtp-out-n03;
 Thu, 19 Dec 2019 16:18:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6FD8AC447AF; Thu, 19 Dec 2019 16:18:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F4D8C43383;
        Thu, 19 Dec 2019 16:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F4D8C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Use sizeof_field() instead of FIELD_SIZEOF()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <201912181657.CE7D3CE33@keescook>
References: <201912181657.CE7D3CE33@keescook>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191219161857.6FD8AC447AF@smtp.codeaurora.org>
Date:   Thu, 19 Dec 2019 16:18:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> The FIELD_SIZEOF() macro was redundant, and is being removed from the
> kernel. Since commit c593642c8be0 ("treewide: Use sizeof_field() macro")
> this is one of the last users of the old macro, so replace it.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ca0e477931c5 ath11k: Use sizeof_field() instead of FIELD_SIZEOF()

-- 
https://patchwork.kernel.org/patch/11302533/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
