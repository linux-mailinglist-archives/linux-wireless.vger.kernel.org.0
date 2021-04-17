Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC273631AA
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 19:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhDQRzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 13:55:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19663 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236760AbhDQRzY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 13:55:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618682098; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=//tt+92mj+eYFVIm05nfExvtVOpazpB/GHsyCOcGeeg=;
 b=lzdhiobvTIatAimp7mQFeuWaOKPVYHwUVUYGN6AarJHMiECClTYoTtKoTyEuDhZOPiaGRRLw
 jIcYJyxJGD7nPaCFo37Ql6edEPqiL4XfZB0qMnNZyfFxU21GRMPZYoR78Qyfks2mbtGBqV/u
 0OjF3lgPzr8IR4usEkag7YKF8bw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 607b20ebe0e9c9a6b6c81a4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 17:54:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D342C433D3; Sat, 17 Apr 2021 17:54:51 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C08B1C433F1;
        Sat, 17 Apr 2021 17:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C08B1C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wilc1000: fix a loop timeout condition
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YFS5gx/gi70zlIaO@mwanda>
References: <YFS5gx/gi70zlIaO@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        David Mosberger-Tang <davidm@egauge.net>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417175451.9D342C433D3@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 17:54:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> If the loop fails, the "while(trials--) {" loop will exit with "trials"
> set to -1.  The test for that expects it to end with "trials" set to 0
> so the warning message will not be printed.
> 
> Fix this by changing from a post-op to a pre-op.  This does mean that
> we only make 99 attempts instead of 100 but that's okay.
> 
> Fixes: f135a1571a05 ("wilc1000: Support chip sleep over SPI")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Ajay Singh <ajay.kathat@microchip.com>

Patch applied to wireless-drivers-next.git, thanks.

2f51061edab9 wilc1000: fix a loop timeout condition

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YFS5gx/gi70zlIaO@mwanda/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

