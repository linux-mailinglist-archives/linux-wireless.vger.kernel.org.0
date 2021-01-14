Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9C2F67C4
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhANRcb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:32:31 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:31907 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhANRcb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:32:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610645532; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9qH3IVRNhjrMOUv0NJoR4vJLOQLOtLb8+zpJNAaKVFU=;
 b=LJOYqw5M4fblQA3p849RmQa1zwnvU6kS0V4sXgrWcdZr8FqbePcQN6vUyaQCnMIzuiiJ5CRL
 crsaQmnPPvIUc7tE/c3Hy3xPRHspnUrZUONFLSKE9AADPZvZhncY4/hxORvtYAZsZNFYF452
 2evR3vffkrCCHtFt9DreRr8dNuE=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60007ff3415a6293c5b6ee95 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 17:31:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2207DC433CA; Thu, 14 Jan 2021 17:31:31 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBE79C433C6;
        Thu, 14 Jan 2021 17:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBE79C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] qtnfmac_pcie: Use module_pci_driver
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201221075735.197255-1-ameynarkhede03@gmail.com>
References: <20201221075735.197255-1-ameynarkhede03@gmail.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     imitsyanko@quantenna.com, geomatsi@gmail.com, davem@davemloft.net,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210114173131.2207DC433CA@smtp.codeaurora.org>
Date:   Thu, 14 Jan 2021 17:31:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> Use module_pci_driver for drivers whose init and exit functions
> only register and unregister, respectively.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

0924ba9fbc26 qtnfmac_pcie: Use module_pci_driver

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201221075735.197255-1-ameynarkhede03@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

