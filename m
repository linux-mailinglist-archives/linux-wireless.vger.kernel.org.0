Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8655B2DCCB5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 07:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLQGta (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 01:49:30 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:16152 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgLQGta (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 01:49:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608187749; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=IZ5gIE7BXGUIj9BGo/lIosGYRz5aQPB7biVl5MRFOW4=;
 b=KQT6lS7/PdvmJlDc5hzQV9D8g+FgEK53TSJ4VQqHIjnZzv6M3ZTvElGb9OQMMIaW/wEkB5Bq
 Zy7okXRMFpghKn4t2TKSaL3YGwH7FBK8Wb+luotxUVZLK1jmhfukMyMmHfM/OCo0T1quSBI7
 wnQPa7Hfm4dRiBc0wQIBfwynclc=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fdaff49944e4d24476df3aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 06:48:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3188EC43462; Thu, 17 Dec 2020 06:48:41 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 561EAC433CA;
        Thu, 17 Dec 2020 06:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 561EAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: Fix error code in ath11k_core_suspend()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <X9nF17L2/EKOSbn/@mwanda>
References: <X9nF17L2/EKOSbn/@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201217064841.3188EC43462@smtp.codeaurora.org>
Date:   Thu, 17 Dec 2020 06:48:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "if (!ret)" condition is inverted and it should be "if (ret)".  It means
> that we return success when we had intended to return an error code. This also
> caused a spurious warning even when the suspend was successful:
> 
> [  297.186612] ath11k_pci 0000:06:00.0: failed to suspend hif: 0
> 
> Fixes: d1b0c33850d2 ("ath11k: implement suspend for QCA6390 PCI devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-current branch of ath.git, thanks.

9b09456258ea ath11k: Fix error code in ath11k_core_suspend()
30d085039314 ath11k: Fix ath11k_pci_fix_l1ss()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/X9nF17L2/EKOSbn/@mwanda/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

