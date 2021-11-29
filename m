Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4154D46126B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 11:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhK2KbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 05:31:07 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:12055 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhK2K3G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 05:29:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638181549; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=LbaMiVwhMNsdBIPDjbDctvL5CLeWYp5RBcokCRo3RNU=;
 b=wJ82R4wdjq8wK75/SEuRvFmZ5+k6he8AY8/qQpQVqkMlYUMgo2g/Z5fPQhpZmTqhwgRuuFWU
 9LOUIN3DHp6J/TkFCtH4yZW+jRCyMgvS/Kdsf5VyvU3oIGT+IDdlrATTBb+6ish2NwFypIV5
 8vEG6+n4DgeSEgarwyPlqcZlFwk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61a4aaac1abc6f02d07e3ece (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 10:25:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E50EC43617; Mon, 29 Nov 2021 10:25:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61578C4338F;
        Mon, 29 Nov 2021 10:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 61578C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcmfmac: Configure keep-alive packet on suspend
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1637596046-21651-1-git-send-email-loic.poulain@linaro.org>
References: <1637596046-21651-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163818154249.17830.9502816664657102039.kvalo@codeaurora.org>
Date:   Mon, 29 Nov 2021 10:25:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> When entering suspend as a client station with wowlan enabled,
> the Wi-Fi link is supposed to be maintained. In that state, no
> more data is generated from client side, and the link stays idle
> as long the station is suspended and as long the AP as no data to
> transmit.
> 
> However, most of the APs kick-off such 'inactive' stations after
> few minutes, causing unexpected disconnect (reconnect, etc...).
> 
> The usual way to prevent this is to submit a Null function frame
> periodically as a keep-alive. This is something that can be host
> /software generated (e.g. wpa_supplicant), but that needs to be
> offloaded to the Wi-Fi controller in case of suspended host.
> 
> This change enables firmware generated keep-alive frames when
> entering wowlan suspend, using the 'mkeep_alive' IOVAR.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

Patch applied to wireless-drivers-next.git, thanks.

7a6cfe28ae3e brcmfmac: Configure keep-alive packet on suspend

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1637596046-21651-1-git-send-email-loic.poulain@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

