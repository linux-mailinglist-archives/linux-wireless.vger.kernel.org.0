Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2712D3C17
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 08:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgLIHWg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 02:22:36 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:26761 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIHWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 02:22:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607498531; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cS+Sez4BXo4LbUu76aUenEiVdbaAtY/eksAS4QNfXj8=;
 b=eobUnpKNdD4x17Ds9Bwxl2Yls827jMcoy/hQuYLVuhdopbDbxHsj3HzlpGH51HtWoMq3hYmm
 l2Cj8jT68yP/w2b+eNhAWMq7mmLXC/U1HpViDQhQTBGepF1aECi/MpRaUiyBJAcnuFam/ACI
 /FBusf4tpA+mVrgd0XwLJ0DvbHM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fd07b179927dcfd34eda124 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 07:21:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 354AAC433ED; Wed,  9 Dec 2020 07:21:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 269A2C433CA;
        Wed,  9 Dec 2020 07:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 269A2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] brcmfmac: Support DPP feature
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201012084347.121557-3-wright.feng@cypress.com>
References: <20201012084347.121557-3-wright.feng@cypress.com>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        chi-hsien.lin@cypress.com,
        Johannes Berg <johannes@sipsolutions.net>,
        wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kurt Lee <kurt.lee@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201209072159.354AAC433ED@smtp.codeaurora.org>
Date:   Wed,  9 Dec 2020 07:21:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> wrote:

> From: Kurt Lee <kurt.lee@cypress.com>
> 
> Let driver parse DPP(Device Provisioning Protocol) frames from upper
> layer and do corresponding configuration to firmware.
> 
> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>

Failed to apply:

Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c'
error: Failed to merge in the changes.
Applying: brcmfmac: Support DPP feature
Using index info to reconstruct a base tree...
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
Patch failed at 0001 brcmfmac: Support DPP feature
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201012084347.121557-3-wright.feng@cypress.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

