Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B6F2D246D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 08:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgLHHfS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 02:35:18 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:56447 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgLHHfS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 02:35:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607412893; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dARHXs6dUDlMbspQanyw1r2sRpOHp/oRb+srQlhnSWg=;
 b=WQIATwa5RmqU6u9Ek546NIt4C764wQAGdLf9+ROPnIIbIjotwxk4FPZAgLGckTJ4nF6ZuXO3
 /KC/dei9WZTZm+yQwM3w1YayLvoArJWWXrkoKkHIhGFMFN9Jw4jqf9w03i7UJyLWD1SxeT7C
 MMIsapwHZ8zXNNuFr80UhnL789Y=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fcf2c9bb50fb3818a8e49aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 07:34:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D0A3C433CA; Tue,  8 Dec 2020 07:34:51 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A699C433C6;
        Tue,  8 Dec 2020 07:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A699C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix multiple definition of rtw_pm_ops
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201208013746.11065-1-pkshih@realtek.com>
References: <20201208013746.11065-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201208073451.0D0A3C433CA@smtp.codeaurora.org>
Date:   Tue,  8 Dec 2020 07:34:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 'const struct dev_pm_ops rtw_pm_ops' is declared by pci.c, and it should be
> declare as 'extern' in pci.h. Without 'extern' causes every file including
> pci.h has an individual instance of rtw_pm_ops but not reference to the one
> declared in pci.c
> 
> If kernel config, like test robot, doesn't build driver as module, it leads
> multiple definition.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 2e86ef413ab3 ("rtw88: pci: Add prototypes for .probe, .remove and .shutdown")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

91aeaf09a6ee rtw88: fix multiple definition of rtw_pm_ops

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201208013746.11065-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

