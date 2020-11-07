Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4871E2AA685
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgKGQCS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 11:02:18 -0500
Received: from z5.mailgun.us ([104.130.96.5]:60720 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgKGQCS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 11:02:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604764937; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=B0HWvgWIXIhrcaT+3qYwbxKMtikroegxBuXMY24osGQ=;
 b=hEAJKZE+bqqMGzy0slvloRxqYR2x5ECpWZsP4ZdJCFSNEkaGpZp3sSait8dNvy1ysu952XnH
 Jr50BVTnwCJfYnu0dnFMv+4H2F+aEaifimbpRAAInqrdzLedHLs+NdyLEK1sPHDgIZw9d4Ay
 t4C52XeIdqYKIwM22TXECSabG/s=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fa6c4ec8c0d6573143e4756 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 16:01:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C60CBC433C6; Sat,  7 Nov 2020 16:01:47 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C06E4C433C8;
        Sat,  7 Nov 2020 16:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C06E4C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 17/41] intersil: hostap_hw: Prevent incompatible function
 type
 cast
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201102112410.1049272-18-lee.jones@linaro.org>
References: <20201102112410.1049272-18-lee.jones@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jouni Malinen <j@w1.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107160147.C60CBC433C6@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 16:01:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/wireless/intersil/hostap/hostap_hw.c: In function ‘prism2_init_local_data’:
>  drivers/net/wireless/intersil/hostap/hostap_hw.c:3173:48: warning: cast between incompatible function types from ‘void (*)(struct tasklet_struct *)’ to ‘void (*)(long unsigned int)’ [-Wcast-function-type]
>  drivers/net/wireless/intersil/hostap/hostap_hw.c:3175:2: note: in expansion of macro ‘HOSTAP_TASKLET_INIT’
> 
>  NB: Repeats lots of times - snipped for brevity
> 
> Cc: Jouni Malinen <j@w1.fi>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Already fixed in wireless-drivers-next

Recorded preimage for 'drivers/net/wireless/intersil/hostap/hostap_hw.c'
error: Failed to merge in the changes.
Applying: intersil: hostap_hw: Prevent incompatible function type cast
Using index info to reconstruct a base tree...
M	drivers/net/wireless/intersil/hostap/hostap_hw.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/intersil/hostap/hostap_hw.c
CONFLICT (content): Merge conflict in drivers/net/wireless/intersil/hostap/hostap_hw.c
Patch failed at 0001 intersil: hostap_hw: Prevent incompatible function type cast
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201102112410.1049272-18-lee.jones@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

