Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4FD45F161
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378363AbhKZQPr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:15:47 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:29899 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378335AbhKZQNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:13:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637943033; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=GgL7LawouRRgLh6eAlg5OphgkjtWy6orWomDbMGgZwk=;
 b=qY32YgByHxEWBqz4jwn9V6FF+fuQXE3F7TdFyTMUPZXRjkBYphzMooM3fk1X8D/GajBoLPu2
 I3pD0hmA768rFzTDQcUe8upFsGAmIR3AQftSjqHCaNfMAJoFIny1uGiAczkfXUAew+uEvzu6
 /+/ocS02/+c33ePpEwM1VVHgrCQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61a106f7e7d68470afbc44a6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:10:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E17E6C4360D; Fri, 26 Nov 2021 16:10:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72924C4338F;
        Fri, 26 Nov 2021 16:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 72924C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] rtw89: fill regd field of limit/limit_ru tables by
 enum
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211101093106.28848-2-pkshih@realtek.com>
References: <20211101093106.28848-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794302653.10370.6462635548410582842.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:10:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> This modification just replaces the number filled in the regd field
> with the corresponding enum. No assignment of a value in a table is
> changed. Doing this first is because the follow-up patches may adjust
> the order of enum declarations.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

4 patches applied to wireless-drivers-next.git, thanks.

023562266926 rtw89: fill regd field of limit/limit_ru tables by enum
542577149794 rtw89: update rtw89 regulation definition to R58-R31
ebaae2c2c3bd rtw89: update tx power limit/limit_ru tables to R54
08e16498e01b rtw89: update rtw89_regulatory map to R58-R31

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211101093106.28848-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

