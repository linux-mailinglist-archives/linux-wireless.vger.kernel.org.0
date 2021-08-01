Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C173DCB16
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Aug 2021 12:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhHAKZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Aug 2021 06:25:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51457 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhHAKZ0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Aug 2021 06:25:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627813518; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=+Tht/oadIlec4geTdluJd5Vlo6uXIie13sxNodjZpdA=;
 b=chl1fgY8BIRXDNn9s6T0r8N5CN7+g/NWj80So+k1jQLsAl6nX+jesUMOuK+owII81kXcqkPN
 VZBozsIP4pVULsY5ywx22OZZuv9kGO5UodhJMyozen+KrpDfD0wqv1rVHGzNSs2G8Me4zKqd
 UPT2EkQXR10Hz/q5v01EKuz5nRk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6106768017c2b4047d6083d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 01 Aug 2021 10:25:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C56E4C433F1; Sun,  1 Aug 2021 10:25:03 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF196C433D3;
        Sun,  1 Aug 2021 10:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF196C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcmfmac: use separate firmware for 43430 revision 2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210628145412.26046-1-mike.rudenko@gmail.com>
References: <20210628145412.26046-1-mike.rudenko@gmail.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210801102503.C56E4C433F1@smtp.codeaurora.org>
Date:   Sun,  1 Aug 2021 10:25:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mikhail Rudenko <mike.rudenko@gmail.com> wrote:

> A separate firmware is needed for Broadcom 43430 revision 2.  This
> chip can be found in e.g. certain revisions of Ampak AP6212 wireless
> IC. Original firmware file from IC vendor is named
> 'fw_bcm43436b0.bin', but brcmfmac and also btbcm drivers report chip
> id 43430, so requested firmware file name is
> 'brcmfmac43430b0-sdio.bin' in line with other 43430 revisions.
> 
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Failed to apply to wireless-drivers-next, please rebase.

Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: brcmfmac: use separate firmware for 43430 revision 2
Using index info to reconstruct a base tree...
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
Patch failed at 0001 brcmfmac: use separate firmware for 43430 revision 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210628145412.26046-1-mike.rudenko@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

