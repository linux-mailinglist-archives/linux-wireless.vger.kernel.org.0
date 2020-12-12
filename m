Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084882D848E
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Dec 2020 05:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438310AbgLLEnV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 23:43:21 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:12752 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438296AbgLLEnF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 23:43:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607748166; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Y6BZJHh66i14KwdNCSs/SauH5PyGv74T3SxNFkoKHZ0=;
 b=ibWR3OA+Xbe0rs3QFC86zXMCEo9Sp/pXfi0a2TyGVzFMPzstCWOrdo9X8AvGCu6cb3xA7QQV
 QhkDwmGC4MYp7F8aMa+h1YY4zP3EIblcJriPny3weBTroVarBWyjYCScNbjgObujXyRwhPzH
 KDxl3EmXdAt0DNA3bDZBjkrbN8o=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fd44a26fa3411972b7361ff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Dec 2020 04:42:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 144ABC433ED; Sat, 12 Dec 2020 04:42:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3E78C433CA;
        Sat, 12 Dec 2020 04:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3E78C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] ath11k: mhi: hook suspend and resume
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1607708150-21066-2-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201212044214.144ABC433ED@smtp.codeaurora.org>
Date:   Sat, 12 Dec 2020 04:42:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> MHI suspend and resume isn't hooked in ath11k yet, so hook these
> functions needed for suspend support.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

10 patches applied to ath-next branch of ath.git, thanks.

34fb81e4eb92 ath11k: mhi: hook suspend and resume
fa5917e44ee8 ath11k: hif: implement suspend and resume functions
f6fa37a4928f ath11k: pci: read select_window register to ensure write is finished
d50370c953bc ath11k: htc: remove unused struct ath11k_htc_ops
8733d835ec43 ath11k: htc: implement suspend handling
840c36fa727a ath11k: dp: stop rx pktlog before suspend
2151ffde188a ath11k: set credit_update flag for flow controlled ep only
79802b13a492 ath11k: implement WoW enable and wakeup commands
d578ec2a0d5c ath11k: hif: add ce irq enable and disable functions
d1b0c33850d2 ath11k: implement suspend for QCA6390 PCI devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1607708150-21066-2-git-send-email-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

