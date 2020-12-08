Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050E82D26AB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgLHIy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 03:54:59 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:34451 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgLHIy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 03:54:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607417680; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dPCdplZ+XxOGGp7/+lsbg8A1a02KAIt7v+rAxEUucJU=; b=JqRUmmAyCLjy6XWKrL95yMWfQQZl+50K5GrJ8a10h3m8lFCstA2N4531EKNn4fP7NcQ1d0E1
 rjBFhCwbQtsz51dkVFRJ78U+yKJcrECB9uApVO33QEmhSvIlEN5EcDNf+R9zmiqdr/uMYlmE
 /BN1LoeZhwcChiYlHQUAO2Hv99k=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fcf3f334afea88893f32a71 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 08:54:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 595E0C433CA; Tue,  8 Dec 2020 08:54:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24025C433C6;
        Tue,  8 Dec 2020 08:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24025C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the wireless-drivers-next tree
References: <20201208194944.19ee46f4@canb.auug.org.au>
Date:   Tue, 08 Dec 2020 10:54:05 +0200
In-Reply-To: <20201208194944.19ee46f4@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 8 Dec 2020 19:49:43 +1100")
Message-ID: <87im9cel02.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> After merging the wireless-drivers-next tree, today's linux-next build
> (powerpc allyesconfig) failed like this:
>
> ld: drivers/net/wireless/realtek/rtw88/rtw8822ce.o:(.rodata.rtw_pm_ops+0x0): multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/rtw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here
> ld: drivers/net/wireless/realtek/rtw88/rtw8723de.o:(.rodata.rtw_pm_ops+0x0): multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/rtw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here
> ld: drivers/net/wireless/realtek/rtw88/rtw8821ce.o:(.rodata.rtw_pm_ops+0x0): multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/rtw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here
> ld: drivers/net/wireless/realtek/rtw88/pci.o:(.rodata.rtw_pm_ops+0x0): multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/rtw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here
>
> Caused by commit
>
>   2e86ef413ab3 ("rtw88: pci: Add prototypes for .probe, .remove and .shutdown")
>
> I have applied the following patch:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 8 Dec 2020 19:35:18 +1100
> Subject: [PATCH] rtw88: pci: "extern" is necessary for header declarations of data
>
> Fixes: 2e86ef413ab3 ("rtw88: pci: Add prototypes for .probe, .remove and .shutdown")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/wireless/realtek/rtw88/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
> index cda56919a5f0..7cdefe229824 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.h
> +++ b/drivers/net/wireless/realtek/rtw88/pci.h
> @@ -214,7 +214,7 @@ struct rtw_pci {
>  	void __iomem *mmap;
>  };
>  
> -const struct dev_pm_ops rtw_pm_ops;
> +extern const struct dev_pm_ops rtw_pm_ops;

Thanks, just an hour ago I applied an identical patch from Ping:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=91aeaf09a6eed83cae0d0fad20a97699b1c8b812

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
