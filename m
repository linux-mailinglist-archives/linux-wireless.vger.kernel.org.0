Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3143A1CDA09
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 14:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgEKMfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 08:35:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:64162 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729594AbgEKMfq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 08:35:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589200545; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=bWFGxf1v9gJiJPN2DpewHvpFSKS42lqk8cvd4M0GA7Q=;
 b=M9bH89yZU4BLF1yGGBnZI4Nk/K53n8UYNDbYPIDWSNJU4JfQYLIvic3L0I1qttRqXhHsFpNS
 uqhwqfo9vgCjLXN515huTN1hAGTzTEZY1l8AzqvsQE4no1VJFsdtW9ixDW/mj6N3jOCgK5Bw
 JNDmRNQQOFYH/81YWA2UdOf3Ods=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb946a1.7f19b39adb58-smtp-out-n02;
 Mon, 11 May 2020 12:35:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E8AACC43637; Mon, 11 May 2020 12:35:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2398C44788;
        Mon, 11 May 2020 12:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2398C44788
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
Message-Id: <20200511123543.E8AACC43637@smtp.codeaurora.org>
Date:   Mon, 11 May 2020 12:35:43 +0000 (UTC)
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

3 patches applied to ath-next branch of ath.git, thanks.

31858805f91a ath11k: Add support for multibus support
630ad41c195c ath11k: Add drv private for bus opaque struct
27143fa93c3b ath11k: Remove bus layer includes from upper layer

-- 
https://patchwork.kernel.org/patch/11530873/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
