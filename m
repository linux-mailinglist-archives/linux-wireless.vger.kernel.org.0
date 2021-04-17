Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B601A363171
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhDQR1n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 13:27:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38154 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236776AbhDQR1m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 13:27:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618680436; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=S8UiivUxdtK4LL/VhdeDJl8J/GYBDnoKm0pz87KkKUQ=;
 b=L3AqMH80BLU+Q0cQnG0dO3E5hmkDYhYc/n4JscFxYbuwfgLVePNztsPokppbvmEzl0KuY5oR
 2ledYlV29tjqOL5HNboobzDG2VmdG3nANMuUWpwSOND9xfZUj4C7i5891G0i6AJqFnQK+gFG
 hzy4DvCuttwcEf9YDY8/YhtURDw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 607b1a6ba817abd39a1981ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 17:27:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCAA4C43217; Sat, 17 Apr 2021 17:27:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BEC5C433D3;
        Sat, 17 Apr 2021 17:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BEC5C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rtlwifi: 8821ae: upgrade PHY and RF parameters
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210219052607.7323-1-pkshih@realtek.com>
References: <20210219052607.7323-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417172706.CCAA4C43217@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 17:27:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The signal strength of 5G is quite low, so user can't connect to an AP far
> away. New parameters with new format and its parser are updated by the commit
> 84d26fda52e2 ("rtlwifi: Update 8821ae new phy parameters and its parser."), but
> some parameters are missing. Use this commit to update to the novel parameters
> that use new format.
> 
> Fixes: 84d26fda52e2 ("rtlwifi: Update 8821ae new phy parameters and its parser")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

18fb0bedb5fc rtlwifi: 8821ae: upgrade PHY and RF parameters

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210219052607.7323-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

