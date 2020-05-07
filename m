Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332C01C81CE
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 07:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgEGFlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 01:41:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:27718 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgEGFlq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 01:41:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588830106; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2q++NFCfzVVk+ppqdu86kfSQ6NnXOBLJ1ZfVczm3PRU=;
 b=GJMkLIa0ptJZWHlgMC4r2HWj4WrdLqSUu+sLAe786Ob4fmeWimTd6eVjTvseGaveAX/Fq6fp
 RAZorFKUHIf+HYjezSwkLsHjZzpXC0l9GwbltVmFFCWn4Oc95viYiLEjlu6Gm8+p8C+I/5tO
 yO/8f30z6jB6CV7aZ5yWNJwZ55Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb39f98.7fae5306d650-smtp-out-n05;
 Thu, 07 May 2020 05:41:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB2CDC433F2; Thu,  7 May 2020 05:41:44 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7653AC433D2;
        Thu,  7 May 2020 05:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7653AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ath11k: Add support for multibus support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200506094400.4740-2-govinds@codeaurora.org>
References: <20200506094400.4740-2-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200507054144.CB2CDC433F2@smtp.codeaurora.org>
Date:   Thu,  7 May 2020 05:41:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> Current design supports only AHB interface for
> 11ax chipset. Refactor the code by adding hif layer
> for bus level abstraction to support  PCI based device.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This had sparse warnings, I fixed them in the pending branch:

drivers/net/wireless/ath/ath11k/ahb.c:1020:5: warning: no previous prototype for 'ath11k_ahb_init' [-Wmissing-prototypes]
drivers/net/wireless/ath/ath11k/ahb.c:1026:6: warning: no previous prototype for 'ath11k_ahb_exit' [-Wmissing-prototypes]
drivers/net/wireless/ath/ath11k/ahb.c:1020:5: warning: symbol 'ath11k_ahb_init' was not declared. Should it be static?
drivers/net/wireless/ath/ath11k/ahb.c:1026:6: warning: symbol 'ath11k_ahb_exit' was not declared. Should it be static?

-- 
https://patchwork.kernel.org/patch/11530873/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
