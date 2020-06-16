Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F77C1FAAE6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgFPIPk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 04:15:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48184 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgFPIPj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 04:15:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592295339; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=YEiA02SDqVr8cjsLe3LZUmW/DEL/4e/9LtlFmKvmpk4=;
 b=R9M5sGAjwBr7SAQL71lRCXtlAr/qYXctIGUr1sNVwNWSE1PpVlBRHzL/c5UwqouYcarP70Ev
 eCRHE3WPi4GNvKm3C4NJWkiBC6pkhgvC1IAS+nfIiBDGAWZ+fc1ORgNHv9v0LGPo6eS+0246
 Dj/g0uXJ8bnsrCkQR9+kaqXPCqg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ee87f96f3deea03f375e11f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 08:15:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E97A1C433CB; Tue, 16 Jun 2020 08:15:17 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85E1CC433C9;
        Tue, 16 Jun 2020 08:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85E1CC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix retry packets update in station dump
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591856446-26977-1-git-send-email-vnaralas@codeaurora.org>
References: <1591856446-26977-1-git-send-email-vnaralas@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200616081517.E97A1C433CB@smtp.codeaurora.org>
Date:   Tue, 16 Jun 2020 08:15:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <vnaralas@codeaurora.org> wrote:

> When tx status enabled, retry count is updated from tx completion status.
> which is not working as expected due to firmware limitation where
> firmware can not provide per MSDU rate statistics from tx completion
> status. Due to this tx retry count is always 0 in station dump.
> 
> Fix this issue by updating the retry packet count from per peer
> statistics. This patch will not break on SDIO devices since, this retry
> count is already updating from peer statistics for SDIO devices.
> 
> Tested-on: QCA9984 PCI 10.4-3.6-00104
> Tested-on: QCA9882 PCI 10.2.4-1.0-00047
> 
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

67b927f98208 ath10k: fix retry packets update in station dump

-- 
https://patchwork.kernel.org/patch/11599289/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

