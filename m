Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF97B45F1BA
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhKZQYu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:24:50 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:54593 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhKZQWu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:22:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637943577; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2UyKGzAlpEqfzGAON5YNfHsfmlktAin0ilQb+AKeNS8=;
 b=Ja71sN8TaRCcvtsWDkYc06ljRgiQEtxfnfQZdiSiTAzZFoy/ZD/BZZ5R3n0b1UKxICTU+x06
 BXFVm4sbJ1gOC2zM1s5VFqodYO4pk6k/gb7x/9Yh6iMXl9oKUpCxkxYcopQqUxh7whcB51UE
 c81LtlMq844jn42VFvqnVp2+gp8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61a109185daaeec797a666f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:19:36
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4045C43617; Fri, 26 Nov 2021 16:19:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09C5BC4338F;
        Fri, 26 Nov 2021 16:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 09C5BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200313065114.23433-1-yhchuang@realtek.com>
References: <20200313065114.23433-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794357152.10370.14049415292167225860.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:19:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> It is useful to fix the bit rate of TX packets. For example, if
> someone is measuring the TX power, or debugging with the issues
> of the TX throughput on the field.
> 
> To set the value of fixed rate, one should input corresponding
> desc rate index (ex, 0x0b for DESC_RATE54M to fix at 54 Mbps).
> Set a value larger than DESC_RATE_MAX will disable fix rate, so
> the rate adaptive mechanism can resume to work.
> 
> Example,
>   To fix rate at MCS 1:
>   echo 0x0d > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> 
>   To not to fix rate:
>   echo 0xff > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> 
>   To know which rate was fixed at:
>   cat /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>

So the concensus was that doing this from debugfs is ok, but
unfortunately this doesn't apply anymore. Please respin.

Recorded preimage for 'drivers/net/wireless/realtek/rtw88/tx.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: rtw88: add debugfs to fix tx rate
Using index info to reconstruct a base tree...
M	drivers/net/wireless/realtek/rtw88/debug.c
M	drivers/net/wireless/realtek/rtw88/main.c
M	drivers/net/wireless/realtek/rtw88/main.h
M	drivers/net/wireless/realtek/rtw88/tx.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/realtek/rtw88/tx.c
CONFLICT (content): Merge conflict in drivers/net/wireless/realtek/rtw88/tx.c
Auto-merging drivers/net/wireless/realtek/rtw88/main.h
Auto-merging drivers/net/wireless/realtek/rtw88/main.c
Auto-merging drivers/net/wireless/realtek/rtw88/debug.c
Patch failed at 0001 rtw88: add debugfs to fix tx rate

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20200313065114.23433-1-yhchuang@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

