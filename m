Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A937415ACF4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 17:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBLQPu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 11:15:50 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:47864 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgBLQPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 11:15:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581524149; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sgiuuusP76gbyngpNVF5rQ+q6gRC6jwJpjoJQOZqq24=;
 b=sWOf7cBb07QxTMBMjRqg5YYrUma3JgecwJtIV44Lncgfpr1OQ8R+3M2DmkSEVWYpu/HCzyYS
 Yup7dtIVPLyr1bxqe7sVTj6Lfjv0zQH7qMj1WzrpYKWmH842E84wqdG+qkkUFdgmLGc4KpGd
 Q3/CShK4LAHjNuW//JkLNqlhdJI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4424a6.7f2c87700810-smtp-out-n01;
 Wed, 12 Feb 2020 16:15:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 226E2C447A3; Wed, 12 Feb 2020 16:15:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92AEBC43383;
        Wed, 12 Feb 2020 16:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92AEBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200126193339.167346-1-sandals@crustytoothpaste.net>
References: <20200126193339.167346-1-sandals@crustytoothpaste.net>
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
Message-Id: <20200212161534.226E2C447A3@smtp.codeaurora.org>
Date:   Wed, 12 Feb 2020 16:15:34 +0000 (UTC)
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

Patch applied to wireless-drivers-next.git, thanks.

24f0bd136264 brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2

-- 
https://patchwork.kernel.org/patch/11351949/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
