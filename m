Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52D31F554
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 08:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBSHSW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 02:18:22 -0500
Received: from z11.mailgun.us ([104.130.96.11]:44628 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSHSW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 02:18:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613719084; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=XnPBplKTeEgUlkIKsgNEBe4CAwle6UDe2Wk1H160kyM=; b=kp16gZ72ZucjCnrMC/h8ATxrIL9Hf+cFj3i/COIQxmCuqk5v4JWbNjHL4HDgNe4l3Siw0tG9
 JZAs/77uWutl30mx6KXbSNbAvT6j7nOUwBOf2HR8n4Gq6rElSQMnA8bfj6Pj43zAHPDrQ2cI
 hV/3Dxmcqd7h26VpOVlqrz0GB1g=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 602f660b37f02eb714b0ee71 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Feb 2021 07:17:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7500EC43462; Fri, 19 Feb 2021 07:17:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76430C433CA;
        Fri, 19 Feb 2021 07:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76430C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: 8821ae: upgrade PHY and RF parameters
References: <20210219052607.7323-1-pkshih@realtek.com>
Date:   Fri, 19 Feb 2021 09:17:27 +0200
In-Reply-To: <20210219052607.7323-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 19 Feb 2021 13:26:07 +0800")
Message-ID: <87zh00jzlk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> New parameters with new format and its parser are updated by the
> commit 84d26fda52e2 ("rtlwifi: Update 8821ae new phy parameters and its parser."),
> but some parameters are missing. Use this commit to update to the novel
> parameters that use new format.
>
> Fixes: 84d26fda52e2 ("rtlwifi: Update 8821ae new phy parameters and its parser")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

What does this fix from user's point of view?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
