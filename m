Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181DB43FD08
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhJ2NHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Oct 2021 09:07:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16015 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231969AbhJ2NHK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635512681; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=vnbg7uJQhyANUTZhJsUI3dIJ6wgzUUdV7/qGuCSCecs=; b=rz1XMDnrVkBrqEP86S8EJFsfQ9YMusOkPTISuds6BiN6Rl/gIv+6eKSH4/Ep9jQcSTjKzmq6
 Shf5EZ9pkktLi8tCJK/xf0WIeA24Ul1HWNZEDDE6whGGFQdjcUnPfhYAxHimnRcmAeamC7m1
 pO4Sa4RXKHwa6CFZNa1/klqKAsw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 617bf169f6a3eeacf9554759 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 Oct 2021 13:04:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 26728C43639; Fri, 29 Oct 2021 13:04:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46346C43617;
        Fri, 29 Oct 2021 13:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 46346C43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     luciano.coelho@intel.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wlwifi: Fix missing error code in iwl_pci_probe()
References: <1635501304-85589-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Date:   Fri, 29 Oct 2021 16:04:32 +0300
In-Reply-To: <1635501304-85589-1-git-send-email-jiapeng.chong@linux.alibaba.com>
        (Jiapeng Chong's message of "Fri, 29 Oct 2021 17:55:04 +0800")
Message-ID: <87y26c2d9b.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:

> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
>
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
>
> Eliminate the follow smatch warning:
>
> drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1376 iwl_pci_probe() warn:
> missing error code 'ret'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 1f171f4f1437 ("iwlwifi: Add support for getting rf id with blank otp")
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>

The subject prefix should be "iwlwifi: ".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
