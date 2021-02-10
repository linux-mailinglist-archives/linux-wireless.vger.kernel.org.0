Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7205C316028
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 08:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhBJHjo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 02:39:44 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:64341 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232539AbhBJHjj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 02:39:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612942754; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=j7EC7yuOLWlK92uihshdkBFebFz3jc9d4BgbYsfx9gU=;
 b=QawEit4bya6qF4Btp1KxK+dQTvnoqvuPEHMPdP3nNEMJMH2QpFvKjqP/x8rgasQiDfl6DaJ/
 lSI6C1sqlMhOj0eO/rwkdWlIMLdnIuFOMl82JAv88DCw/MfFWeGw1u+On/1y6I6d2CH0H8qq
 OpEAbfztq3xMLZ+3m0aF+YqWm/w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60238d9ef112b7872c3f589d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 07:39:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19952C433CA; Wed, 10 Feb 2021 07:39:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD348C433C6;
        Wed, 10 Feb 2021 07:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD348C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8192se: Simplify bool comparison
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1612839264-85773-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1612839264-85773-1-git-send-email-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     pkshih@realtek.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210210073910.19952C433CA@smtp.codeaurora.org>
Date:   Wed, 10 Feb 2021 07:39:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Fix the follow coccicheck warnings:
> 
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c:2305:6-27:
> WARNING: Comparison of 0/1 to bool variable.
> 
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c:1376:5-26:
> WARNING: Comparison of 0/1 to bool variable.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Patch applied to wireless-drivers-next.git, thanks.

15085446c171 rtlwifi: rtl8192se: Simplify bool comparison

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1612839264-85773-1-git-send-email-jiapeng.chong@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

