Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCDE125000
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLRSCy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:02:54 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:61426 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbfLRSCy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:02:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576692174; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mmxYwqlNnvfhoGG6sDIZwqTCpf9MHzspknNWWIvr9Cg=;
 b=DMxHUkFLNFni4d2drjGslb1kQIqTHMG9HGtD08SQioBdg/c2xg4ki/pjySGt35Ld5Dra0zeK
 01zzQK/e9/1iRBBY9eHM/gLKhWYh8QmjQES/Arx5cQMcQneP1rAQzw6ZcLxm8IAX/+fMg67H
 lrVzSdOgZDwTDlPcM3MSDeZmI64=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa69ca.7f5b12e079d0-smtp-out-n01;
 Wed, 18 Dec 2019 18:02:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD8A9C4479C; Wed, 18 Dec 2019 18:02:49 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3F9BC43383;
        Wed, 18 Dec 2019 18:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3F9BC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: disable HW_CONNECTION_MONITOR
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191217141247.14387-1-eduardoabinader@gmail.com>
References: <20191217141247.14387-1-eduardoabinader@gmail.com>
To:     Eduardo Abinader <eduardoabinader@gmail.com>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218180249.DD8A9C4479C@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 18:02:49 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Eduardo Abinader <eduardoabinader@gmail.com> wrote:

> Whenever the signal stregth decays smoothly and physical connnection
> is already gone and no deauth has arrived, the qcom soc is not
> able to indicate neither WCN36XX_HAL_MISSED_BEACON_IND nor
> WCN36XX_HAL_MISSED_BEACON_IND. It was noticed that such situation gets
> even more reproducible, when the driver fails to enter bmps mode - which is
> highly likely to occur. Thus, in order to provide proper disconnection
> of the connected STA, let mac80211 handle it, instead of wcn3xx driver.
> 
> Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f998f9fcf903 wcn36xx: disable HW_CONNECTION_MONITOR

-- 
https://patchwork.kernel.org/patch/11297683/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
