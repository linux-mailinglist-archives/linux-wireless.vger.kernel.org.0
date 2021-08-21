Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9942E3F3B2F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhHUPq4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 11:46:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:55952 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhHUPq4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 11:46:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629560777; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3RW1uwh4hlAKrLsru/9gPgAAu2K8NF/R9jxFVISA6FQ=;
 b=WqWSnn/gxUrMAYB4L/73Uht7Xjz/QMo/71iR/zDxhr6nA5nej4TDEDExygeg6l5J2ZryaeIh
 OLXiS2iWym+WPYWdvyDXolcDxjZy+fwpQvjPMx00O4KgXU0gCN9AlmpV+j/DtoevQWiFjkLg
 8QLaX7oVVVhZWi/0YPYquTrunjc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61211fbb89fbdf3ffe164e5c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 15:46:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 672EEC43616; Sat, 21 Aug 2021 15:46:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABF3FC4338F;
        Sat, 21 Aug 2021 15:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org ABF3FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5] brcmfmac: firmware: Fix firmware loading
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210808180510.8753-1-digetx@gmail.com>
References: <20210808180510.8753-1-digetx@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-wireless@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821154602.672EEC43616@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 15:46:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Osipenko <digetx@gmail.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The patch that would first try the board-specific firmware
> had a bug because the fallback would not be called: the
> asynchronous interface is used meaning request_firmware_nowait()
> returns 0 immediately.
> 
> Harden the firmware loading like this:
> 
> - If we cannot build an alt_path (like if no board_type is
>   specified) just request the first firmware without any
>   suffix, like in the past.
> 
> - If the lookup of a board specific firmware fails, we get
>   a NULL fw in the async callback, so just try again without
>   the alt_path from a dedicated brcm_fw_request_done_alt_path
>   callback.
> 
> - Drop the unnecessary prototype of brcm_fw_request_done.
> 
> - Added MODULE_FIRMWARE match for per-board SDIO bins, making
>   userspace tools to pull all the relevant firmware files.
> 
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Cc: Stefan Hansson <newbyte@disroot.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-drivers-next.git, thanks.

c2dac3d2d3f1 brcmfmac: firmware: Fix firmware loading

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210808180510.8753-1-digetx@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

