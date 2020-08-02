Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BAF23582B
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHBP1I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:27:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33400 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgHBP1H (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:27:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596382026; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=YBlDXLER9UdLdLTyQYoxGiMqCrwXu615eejcDT+aPII=;
 b=nbS5yABLyOYFHMr+fJgD6OpMkoJfhaNKw/pttr2Q7BEuU+JV8svZILG+jNrTrvouy1miljXj
 5Zcm3dxs2jfWPmmgN1JJ3EQT8BOE3l7fZ0nos60ewj5+gW7rTYiCn/8YWRufX0DrBeTWYK2t
 HMVkUH+sIiQR8JIqMpRXZ3bBKCw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5f26db4aeecfc978d39fc127 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:27:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77A8BC433C9; Sun,  2 Aug 2020 15:27:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53BFCC433C6;
        Sun,  2 Aug 2020 15:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53BFCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bcma: gpio: Use irqchip template
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200722111725.210923-1-linus.walleij@linaro.org>
References: <20200722111725.210923-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802152705.77A8BC433C9@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:27:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:

> This makes the driver use the irqchip template to assign
> properties to the gpio_irq_chip instead of using the
> explicit call to gpiochip_irqchip_add().
> 
> The irqchip is instead added while adding the gpiochip.
> 
> Cc: Rafał Miłecki <rafal@milecki.pl>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to wireless-drivers-next.git, thanks.

a080ecb11ae2 bcma: gpio: Use irqchip template

-- 
https://patchwork.kernel.org/patch/11678335/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

