Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718771B37B3
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDVGn2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 02:43:28 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57950 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgDVGn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 02:43:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587537806; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=MhadrjD6wrcZES5GZ8r8n4iG7AMqQlccgK3i8GcHrT0=;
 b=dKypVEkd52NjEm+Qe5ZmbxdqeM5hP+U0GRXDGzR59F6DE7or+YPn76oVkwDj430ILp47sRDe
 GHqfPVHCjaGzk/dxZ5TstdbRJ1ViN4dbvTY+1JM3luQb4MUr3izt0voiuhHgq7ek1JvVBj0E
 zHeBYH4w6UAV/XHRTFBBA9+dbPI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fe779.7fe1d876e7d8-smtp-out-n04;
 Wed, 22 Apr 2020 06:43:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7659C433F2; Wed, 22 Apr 2020 06:43:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35B2FC433D2;
        Wed, 22 Apr 2020 06:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35B2FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: remove conversion to bool in
 ath11k_debug_fw_stats_process()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200420123745.4159-1-yanaijie@huawei.com>
References: <20200420123745.4159-1-yanaijie@huawei.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <davem@davemloft.net>, <colin.king@canonical.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jason Yan <yanaijie@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200422064304.D7659C433F2@smtp.codeaurora.org>
Date:   Wed, 22 Apr 2020 06:43:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jason Yan <yanaijie@huawei.com> wrote:

> The '==' expression itself is bool, no need to convert it to bool again.
> This fixes the following coccicheck warning:
> 
> drivers/net/wireless/ath/ath11k/debug.c:198:57-62: WARNING: conversion
> to bool not needed here
> drivers/net/wireless/ath/ath11k/debug.c:218:58-63: WARNING: conversion
> to bool not needed here
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d81709346cea ath11k: remove conversion to bool in ath11k_debug_fw_stats_process()

-- 
https://patchwork.kernel.org/patch/11498785/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
