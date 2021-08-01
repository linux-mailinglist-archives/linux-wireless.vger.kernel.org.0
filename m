Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AEF3DCB18
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Aug 2021 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhHAK1U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Aug 2021 06:27:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55239 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhHAK1T (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Aug 2021 06:27:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627813632; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kYUGpLNLoNe6hOlrkiiQolDKGlFSL90Ma12ZjZ661fQ=;
 b=pR1mwfqwdFQWUX6Oijo6ZxwC72JjazrKQ592y/gzFQi8Sx1LfiSjMReri3s4BL4GMhAdQsHg
 ruVsx3zqUGns5FvzM/keJPd4yO0oBknnDG9x5cbunhNyJVVZVxpLHkRFT9jKtuKBLD88wSa2
 QKFYjMKjD8f+dXitXRQCfb+U0/A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 610676ff17c2b4047d61a739 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 01 Aug 2021 10:27:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C541C4338A; Sun,  1 Aug 2021 10:27:10 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CAFEC433F1;
        Sun,  1 Aug 2021 10:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CAFEC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210711231659.255479-1-linus.walleij@linaro.org>
References: <20210711231659.255479-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        phone-devel@vger.kernel.org, newbyte@disroot.org,
        Stephan Gerhold <stephan@gerhold.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210801102710.9C541C4338A@smtp.codeaurora.org>
Date:   Sun,  1 Aug 2021 10:27:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:

> After some crashes in the 3D engine (!) on the Samsung GT-I8530
> it turns out that the main firmware file can be device dependent,
> something that was previously only handled for the NVRAM
> parameter file.
> 
> Rewrite the code a bit so we can a per-board suffixed firmware
> binary as well, if this does not exist we fall back to the
> canonical firmware name.
> 
> Example: a 4330 device with the OF board compatible is
> "samsung,gavini". We will first try
> "brcmfmac4330-sdio.samsung,gavini.bin" then "brcmfmac4330-sdio.bin"
> if that does not work.
> 
> Cc: phone-devel@vger.kernel.org
> Cc: newbyte@disroot.org
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to wireless-drivers-next.git, thanks.

5ff013914c62 brcmfmac: firmware: Allow per-board firmware binaries

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210711231659.255479-1-linus.walleij@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

