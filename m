Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1F3FAA2E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 10:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhH2IeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 04:34:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50590 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234912AbhH2IeE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 04:34:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630225992; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=RWglZDg33ZMVE2pHWQ7nH0DWZ/zCCN3Oc7oxZfG5d5o=;
 b=pZZ0I9yO5z9B1RniE4liRLU69F+Hb80qyQEIWySExRE0FyKGZ5ytqcqZO58vzEmcTU+zc7BY
 DIAcjFHNlfp2mZCa3lAyy97hvBxLWWYbcnUJZf3Gu3X+jAUft0gCI4MekBRmk6CQQoOqu0Pb
 EfbGDvu4ssaje4zhR5MF95uRxQg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 612b463397222b4b5b5e41f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 08:32:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31682C4360C; Sun, 29 Aug 2021 08:32:51 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8CBDC4338F;
        Sun, 29 Aug 2021 08:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A8CBDC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: Drop legacy header include
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210821235800.138817-1-linus.walleij@linaro.org>
References: <20210821235800.138817-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829083251.31682C4360C@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 08:32:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:

> The SSB header only uses the legacy <linux/gpio.h> header to get
> struct gpio_chip so inluce <linux/gpio/driver.h> which is the right
> include to deal with gpio_chip.
> 
> Cc: Michael Buesch <m@bues.ch>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to wireless-drivers-next.git, thanks.

81f9ebd43659 ssb: Drop legacy header include

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210821235800.138817-1-linus.walleij@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

