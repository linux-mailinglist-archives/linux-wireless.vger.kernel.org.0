Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99C62C2AB2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbgKXPDW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 10:03:22 -0500
Received: from z5.mailgun.us ([104.130.96.5]:61567 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388695AbgKXPDW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 10:03:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606230202; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=L4WZ0ibR8tAd89lb16ty2vuhig9YZseolRbtHPASwsQ=;
 b=s3NoAzYgOh5mgcoz/v2GpTHrNKpj30rdHxtUJGhzHvsXt6iVZ/ZUVPZqdHGogaf5MY6/HA/c
 C4PmbO4/QM1U2xc+f+kOeyfkQmUKK4Yt77wL/zscFF0G1lKCH5qskPKBH+sxPu4XhwtuxadG
 DURjsl+X6LTRXsyP5ei29gBuSjM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fbd20affa67d9becf791dca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 15:03:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 955B0C43462; Tue, 24 Nov 2020 15:03:10 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95E86C433ED;
        Tue, 24 Nov 2020 15:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95E86C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net] qtnfmac: fix error return code in qtnf_pcie_probe()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201114123347.29632-1-wanghai38@huawei.com>
References: <20201114123347.29632-1-wanghai38@huawei.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>,
        <imitsyanko@quantenna.com>, <geomatsi@gmail.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201124150310.955B0C43462@smtp.codeaurora.org>
Date:   Tue, 24 Nov 2020 15:03:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wang Hai <wanghai38@huawei.com> wrote:

> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: b7da53cd6cd1 ("qtnfmac_pcie: use single PCIe driver for all platforms")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

31e07aa33fa7 qtnfmac: fix error return code in qtnf_pcie_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201114123347.29632-1-wanghai38@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

