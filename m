Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AAE458CE0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 12:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhKVLE5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 06:04:57 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:26283 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhKVLE4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 06:04:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637578910; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=5PJwp4Hjp/TsAspgMfWnnLrezZBNJy5qgkcHErwlc00=; b=gw7hrg7kzu2+a5eNnJbboKgA4uR7X8uFvcYsaC614bPiX8CDRi33ivV4jtNVQT2vw59mHse3
 oOoJSq8aCaC64jEESIx9zz9yWcb7YzVw09/VE6wg6NqUEXvPbkOEPSTUxkSme0dDYD26P2zj
 6JsdEdGKNzW0xK1uL0rAGM38Q5Y=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 619b788f6bacc185a520dd8b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 11:01:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 229DEC43619; Mon, 22 Nov 2021 11:01:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 632CEC4338F;
        Mon, 22 Nov 2021 11:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 632CEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] brcmfmac: Configure keep-alive packet on suspend
References: <1637571856-1191-1-git-send-email-loic.poulain@linaro.org>
Date:   Mon, 22 Nov 2021 13:01:25 +0200
In-Reply-To: <1637571856-1191-1-git-send-email-loic.poulain@linaro.org> (Loic
        Poulain's message of "Mon, 22 Nov 2021 10:04:16 +0100")
Message-ID: <8735nobgje.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> When system enter suspend, there is no more wireless traffic, and
> if there is no incoming data, most of the AP kick-out the client
> station after few minutes because of inactivity.
>
> The usual way to prevent this is to submit a Null function frame
> periodically as a keep-alive. This is supported by brcm controllers
> and can be configured via the mkeep_alive IOVAR.

This is with brcmfmac in client mode, right? Wouldn't it make more sense
to disconnect entirely during suspend? Nobody is processing the data
packets anyway during suspend.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
