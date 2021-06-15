Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE73A811E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhFONpL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:45:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12160 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhFONoX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:44:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623764538; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=LpvfzkgIaVmaQburodx8yVj8C6jCwH9ZkpYikiRXR64=;
 b=Ad/nQFP5BHVZjPhWfrxSShhUiCVuLRDuq1lhOSRqHNhnffEJkL98HlDfeIBOnSbp4dJsyu92
 oONdjOijLpjdTtEcs01xhnP9aJ9zItnJG95PQi42DC9EILUawgYCaqq4FBi6LNdqcLDasCj7
 k0uYf0RHWwATS2CLNMwyhuO5qdA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60c8ae23e27c0cc77f2716fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:41:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D73BBC43146; Tue, 15 Jun 2021 13:41:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46E92C43144;
        Tue, 15 Jun 2021 13:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46E92C43144
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] libertas: use DEVICE_ATTR_RW macro
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210523040339.2724-1-yuehaibing@huawei.com>
References: <20210523040339.2724-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>, <yuehaibing@huawei.com>,
        <libertas-dev@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615134154.D73BBC43146@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:41:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> Use DEVICE_ATTR_RW helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

8667ab49a6e0 libertas: use DEVICE_ATTR_RW macro

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210523040339.2724-1-yuehaibing@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

