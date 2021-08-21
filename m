Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5B3F3B32
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 17:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhHUPsZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 11:48:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:55952 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhHUPsY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 11:48:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629560865; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Vx+2uz0aVOO5SvCZnCXKAqohPPEw4r3qtcRZlo6tx44=;
 b=VSuJNrZoQyEn4/iW6HMDHPKastCNYxHmUEUiIksqSUPPuMuPayiHAJGlQsDeLoZutMuwzhDI
 DQd4mAXBWFa0g9nn50E2l+vboyFHJhjGU7CoC4g6JWQs2sEjto60h/YdnAvbRJUY4PqYK2uX
 OziC/pWhnn9n8LGDFw5SPW458es=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 612120011ea75edcc3374147 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 15:47:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58560C43617; Sat, 21 Aug 2021 15:47:13 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8731EC4338F;
        Sat, 21 Aug 2021 15:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8731EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] brcmfmac: Add WPA3 Personal with FT to supported cipher
 suites
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <d676c466-fb2f-2301-ff5a-9b90141b6df1@gmail.com>
References: <d676c466-fb2f-2301-ff5a-9b90141b6df1@gmail.com>
To:     =?utf-8?q?Pawe=C5=82_Drewniak?= <czajernia@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821154713.58560C43617@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 15:47:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Paweł Drewniak <czajernia@gmail.com> wrote:

> This allows the driver to connect to BSSIDs supporting SAE with 802.11r.
> Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-rc2.
> AP was set to 'sae-mixed' (WPA2/3 Personal).
> 
> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>

Failed to apply, please rebase on top of wireless-drivers-next.

error: patch failed: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1829
error: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: brcmfmac: Add WPA3 Personal with FT to supported cipher suites
Using index info to reconstruct a base tree...
Patch failed at 0001 brcmfmac: Add WPA3 Personal with FT to supported cipher suites

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/d676c466-fb2f-2301-ff5a-9b90141b6df1@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

