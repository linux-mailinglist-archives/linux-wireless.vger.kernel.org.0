Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99E5149BAD
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgAZPvO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:51:14 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:64697 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgAZPvO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:51:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580053874; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=M//iV9VeZy53EXY85Oj15i0m4EuHcMfq/Q0I8BahX8E=;
 b=wBek6ViBNc7XDvsw0H4xPxjlna21QlxOxWP1W8Pa7TlQfDcOHlIo72Q7wG2UvYSNCc1WUkP2
 +qS+R/eNDmoMzBg9zeghwLbd8N37fLhH+ucSYySeFhmIWutUOMqDEX1BbXACsVGygoIbbp7o
 eRxf5VLrTBUjSbSgQy/Br8iqsyo=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db56c.7fd237ee1c70-smtp-out-n01;
 Sun, 26 Jan 2020 15:51:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 555ABC433A2; Sun, 26 Jan 2020 15:51:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E45B4C433CB;
        Sun, 26 Jan 2020 15:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E45B4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200125210514.126312-1-sandals@crustytoothpaste.net>
References: <20200125210514.126312-1-sandals@crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126155108.555ABC433A2@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 15:51:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> The 2018 13" MacBook Pro (MacBookPro15,2) has a Broadcom chip, the 4364.
> This chip appears to be specific to Apple and is not found in other
> hardware.
> 
> Add this chip to the brcmfmac driver so that it can be recognized
> automatically.  Note that the PCI device id is 4464 even though the chip
> is referred to as the 4364.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Failed to apply to wireless-drivers-next, please rebase and resend.

Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c'
error: Failed to merge in the changes.
Applying: brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
Using index info to reconstruct a base tree...
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
Patch failed at 0001 brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11351701/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
