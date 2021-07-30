Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF53DBDFE
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhG3R6b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 13:58:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51578 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhG3R6a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 13:58:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627667905; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=pcX06MqcSw9/apMXsA6DluESiB7193aiqpxewaeCpcA=; b=RfkYIR03Q5IYUmF5hzS/qGY+TJHhJfe5NcX1vG4cu5n5qqetyboY0U6GNAHSv1A7AMDMTTh8
 6mr3fl9sS6XYgaMPNAvgxlPSnwJyPb1jx6P79YUEr2872nf+ENEDghygYGUMFTPxaR1oZG3z
 RgsimGDSfXgftNX6++3nW8IOr1s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61043db838fa9bfe9c7b1ff3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Jul 2021 17:58:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73393C4323A; Fri, 30 Jul 2021 17:58:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5C35C433F1;
        Fri, 30 Jul 2021 17:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5C35C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        phone-devel@vger.kernel.org, newbyte@disroot.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
References: <20210711231659.255479-1-linus.walleij@linaro.org>
        <CACRpkdagx71ZnOYt7M7PZFkW4UgD-9a_7+ZsMjowaWJmZrCsUQ@mail.gmail.com>
Date:   Fri, 30 Jul 2021 20:58:07 +0300
In-Reply-To: <CACRpkdagx71ZnOYt7M7PZFkW4UgD-9a_7+ZsMjowaWJmZrCsUQ@mail.gmail.com>
        (Linus Walleij's message of "Fri, 30 Jul 2021 11:21:40 +0200")
Message-ID: <8735rvfzv4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Mon, Jul 12, 2021 at 1:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> After some crashes in the 3D engine (!) on the Samsung GT-I8530
>> it turns out that the main firmware file can be device dependent,
>> something that was previously only handled for the NVRAM
>> parameter file.
>>
>> Rewrite the code a bit so we can a per-board suffixed firmware
>> binary as well, if this does not exist we fall back to the
>> canonical firmware name.
>>
>> Example: a 4330 device with the OF board compatible is
>> "samsung,gavini". We will first try
>> "brcmfmac4330-sdio.samsung,gavini.bin" then "brcmfmac4330-sdio.bin"
>> if that does not work.
>>
>> Cc: phone-devel@vger.kernel.org
>> Cc: newbyte@disroot.org
>> Cc: Stephan Gerhold <stephan@gerhold.net>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Who can pick this up by the way?
>
> The patch is in active use in PostmarketOS and work fine there.
>
> Kalle?

Yes, if the patch is ok I can take it to wireless-drivers-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
