Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C9319ADC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 08:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBLHsi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 02:48:38 -0500
Received: from so15.mailgun.net ([198.61.254.15]:14228 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhBLHrv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 02:47:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613116051; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vm0EATJ1RNCjtHSDsiLFvakaGudSqDJpL8m06Bm4kD0=;
 b=AcYLb89SuZpRVOudYFy/u+Vh+ZdLxmHUShwZdJVtJp8qroVSkFM6Fg8Bnrt9HUiAByF5ty10
 6tmBO2Sn5c0PqS51GW47CZLKX+C5PYrQMAlwPktytEwlk1q1rZTrvFS+LLirb9vKNx3H1ccg
 uTF0Yi/dwNeq3xsrjKFlKgBuQD4=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60263275e3df861f4bc553f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Feb 2021 07:47:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 17A3DC43461; Fri, 12 Feb 2021 07:47:01 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E282DC433CA;
        Fri, 12 Feb 2021 07:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E282DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: remove incorrect comment in pnvm
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20210211223049.40d545a0fa89.I04793aaa5312b926335c8db32131f000432df511@changeid>
References: <iwlwifi.20210211223049.40d545a0fa89.I04793aaa5312b926335c8db32131f000432df511@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210212074701.17A3DC43461@smtp.codeaurora.org>
Date:   Fri, 12 Feb 2021 07:47:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> We use this driver as a backport that also runs on older kernels (as
> part of the backports project).  So we use some checks to backport or
> prevent code from compiling in incompatible kernel version.
> 
> When I took one of the PNVM patches from the backport, I accidentally
> left the comment that a certain part of the code doesn't work in older
> kernels.  This obviously should never be valid for the mainline.
> Remove this comment.
> 
> Reported-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers-next.git, thanks.

3304b6f937a3 iwlwifi: remove incorrect comment in pnvm

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20210211223049.40d545a0fa89.I04793aaa5312b926335c8db32131f000432df511@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

