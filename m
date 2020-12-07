Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289F22D15AE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 17:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgLGQKB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 11:10:01 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:45546 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgLGQKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 11:10:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607357375; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qAZe6d9tpJ8VY/5j4szmbFRAcyVTwJYe5rvjnT/Z0FM=;
 b=bsDYWVKgMrF3h5Wq6U1ShM/ZamKvcvfOSpoBBH8YoRmvBI7SIJSG3CR7sOoT52qzZ6G+8TO/
 c8wzMPsU3bDKfpkAdKDqEgY7bMRUrUTmEKpWpMX3FJNX2d5Ivkyy/c7mKUMBIiFL+6PaZifE
 HYafPqaWtG0FZVAoqgEb/b6yPZ4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fce53bf0ce450987a7b420f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 16:09:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8E04C43461; Mon,  7 Dec 2020 16:09:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49522C433CA;
        Mon,  7 Dec 2020 16:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49522C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Ignore resetting peer auth flag in peer assoc cmd
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1606369414-25211-1-git-send-email-seevalam@codeaurora.org>
References: <1606369414-25211-1-git-send-email-seevalam@codeaurora.org>
To:     Seevalamuthu Mariappan <seevalam@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201207160934.B8E04C43461@smtp.codeaurora.org>
Date:   Mon,  7 Dec 2020 16:09:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seevalamuthu Mariappan <seevalam@codeaurora.org> wrote:

> Incase of hardware encryption, WMI_PEER_AUTH flag will be set by firmware
> during install key. Since install key wont be done for software encryption
> mode, firmware will not set this flag. Due to this, seeing traffic failure
> in software encryption. Hence, avoid resetting peer auth flag if hardware
> encryption disabled.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01421-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

1daf58b23a1e ath11k: Ignore resetting peer auth flag in peer assoc cmd

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1606369414-25211-1-git-send-email-seevalam@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

