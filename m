Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229A921ED3E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgGNJwF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:52:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35763 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgGNJwF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:52:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594720324; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=PIbsQHHcEmkVz6Bn6zUMref/5TUIC2QCjHYkJG/fWJ4=;
 b=U2/n68/y7kQskSG6+0L2++99io6ohleQofdfbjldTlWou6JBtO2ODzavi4D+7TRwzisoRWdx
 Xgl5A5lAHYYzkSlCrNFffPZDiqIZo6EZPQzlG+xT4IF+MnzEErTmzBjkqWItxjVslyiPakSk
 ADBgR6tVuYbn23+F1AvYTsr27F4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f0d802fd3d6508422d1b7f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:51:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42F65C43395; Tue, 14 Jul 2020 09:51:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C715C433CB;
        Tue, 14 Jul 2020 09:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C715C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcm80211: brcmsmac: Move LEDs to GPIO descriptors
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200711210150.4943-1-linus.walleij@linaro.org>
References: <20200711210150.4943-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Frank Kao <frank.kao@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714095143.42F65C43395@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 09:51:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:

> The code in the BRCM80211 BRCMSMAC driver is using the legacy
> GPIO API to to a complex check of the validity of the base of
> the GPIO chip and whether it is present at all and then adding
> an offset to the base of the chip.
> 
> Use the existing function to obtain a GPIO line internally
> from a GPIO chip so we can use the offset directly and
> modernize the code to use GPIO descriptors instead of integers
> from the global GPIO numberspace.
> 
> Cc: Wright Feng <wright.feng@cypress.com>
> Cc: Frank Kao <frank.kao@cypress.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to wireless-drivers-next.git, thanks.

b424808115cb brcm80211: brcmsmac: Move LEDs to GPIO descriptors

-- 
https://patchwork.kernel.org/patch/11657979/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

