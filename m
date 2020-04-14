Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA11A8114
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406711AbgDNPDp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 11:03:45 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33048 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406579AbgDNPDf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 11:03:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586876614; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pfxKUtYTsFHDcgDRbl7GC4N22kdCLkpizjWvQYmlPdk=;
 b=HbC3qwZ1d45IndAgR00NjJuQcVELhsLCKnZroyIa2khTDyb6rjO6DqVXEq1bWg+1eKEMVATz
 tqc3YFTi0iSH3GFedqfeC/CgCwDnEhV9zTtCgWw0AizAU83VlKi95EGtKxX7qvFEJqkKCxSR
 OO1bgbmyj+f8xxqcQKQUezWLOsY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95d0be.7ff5cce9b5a8-smtp-out-n02;
 Tue, 14 Apr 2020 15:03:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 024A9C44798; Tue, 14 Apr 2020 15:03:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B4ABC4478F;
        Tue, 14 Apr 2020 15:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B4ABC4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: fix wrong location to get firmware feature
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200330052528.10503-1-jh80.chung@samsung.com>
References: <20200330052528.10503-1-jh80.chung@samsung.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414150326.024A9C44798@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 15:03:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jaehoon Chung <jh80.chung@samsung.com> wrote:

> sup_wpa feature is getting after setting feature_disable flag.
> If firmware is supported sup_wpa feature,  it's always enabled
> regardless of feature_disable flag.
> 
> Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Patch applied to wireless-drivers-next.git, thanks.

c57673852062 brcmfmac: fix wrong location to get firmware feature

-- 
https://patchwork.kernel.org/patch/11464609/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
