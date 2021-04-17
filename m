Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D8363169
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhDQR06 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 13:26:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16597 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236759AbhDQR0x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 13:26:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618680386; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ApZzjsS2OvM5s5Ay6sUV3KgMatlZ7G7HCFMrTUBYwiw=;
 b=xWj49KeAhrZkKFOAf6e5NOQZP3s8/9IJbT6q8qotOVacmUUUA8XaJ/SdGJIfOHV3Ek/L3ne6
 IOAZSpqP1fNro0G/70tdu6xjV7cJlbJW7cn70uYUIKJidk8is2IlGhYyDSkRmDJUvlNbmsnN
 BZy6n+Ue4uKLMueQISp4wd5jzeo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 607b1a3e2cc44d3aea598e2f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 17:26:22
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15277C43217; Sat, 17 Apr 2021 17:26:22 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25E1BC4338A;
        Sat, 17 Apr 2021 17:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25E1BC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] cw1200: Remove unused function pointer typedef wsm_*
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1613449833-4910-1-git-send-email-chen45464546@163.com>
References: <1613449833-4910-1-git-send-email-chen45464546@163.com>
To:     Chen Lin <chen45464546@163.com>
Cc:     pizza@shaftnet.org, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Lin <chen.lin5@zte.com.cn>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417172622.15277C43217@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 17:26:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chen Lin <chen45464546@163.com> wrote:

> From: Chen Lin <chen.lin5@zte.com.cn>
> 
> Remove the 'wsm_*' typedef as it is not used.
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>

Patch applied to wireless-drivers-next.git, thanks.

9dc5fdc8c4f8 cw1200: Remove unused function pointer typedef wsm_*

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1613449833-4910-1-git-send-email-chen45464546@163.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

