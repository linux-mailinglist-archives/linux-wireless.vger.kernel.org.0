Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376331A9592
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635404AbgDOIDb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:03:31 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:36134 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635403AbgDOIDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:03:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586937796; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=q7T8KxiVu+YFV5YwNwOoJ3HkGx85UIrkt+/kfz40cJg=;
 b=BSV146iCbiOVddjVrkLVGXnmEcnZMJFuyu6SalUr8+K4PwTaGHm+FxWJ1T8hwAGkkILGCcCa
 rts/JD3u6ty0fnhGVCqRs+MrCaprey2tC8Po4Im/2eCigBixQj0C1FdqUsk6xFcarm497G6t
 1sc6DKdI6k5NSY7aIXEzu5zeuJQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96bfc3.7fd0427c3dc0-smtp-out-n03;
 Wed, 15 Apr 2020 08:03:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4A5AC432C2; Wed, 15 Apr 2020 08:03:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E6E1C44793;
        Wed, 15 Apr 2020 08:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E6E1C44793
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix typo in warning messages
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586715875-5182-1-git-send-email-telumamatha36@gmail.com>
References: <1586715875-5182-1-git-send-email-telumamatha36@gmail.com>
To:     Mamatha Telu <telumamatha36@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Mamatha Telu <telumamatha36@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415080314.D4A5AC432C2@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:03:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mamatha Telu <telumamatha36@gmail.com> wrote:

> Fix some typo:
>   s/fnrom/from
>   s/pkgs/pkts/
>   s/AMSUs/AMSDUs/
> 
> Signed-off-by: Mamatha Telu <telumamatha36@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

8a7968bee8d0 ath10k: Fix typo in warning messages

-- 
https://patchwork.kernel.org/patch/11484661/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
