Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3871A96F1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894718AbgDOIjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:39:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37357 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2894709AbgDOIi4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:38:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586939935; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=AMzv0dTiXtbC/nSmu3Wb4uhLamK6lblQmo4jjWC2e0c=;
 b=AvMJoB45vjJtjeJp5X+wh7UcAnbhY2WA5FWoC0rqTOzUrqgb5DzMfx6OW4uyLxp9Ptemnn3j
 VQqDMVShtYLKgSFQjK9CT5wKavLGDz5V8eZxx05ltJQKp8F2vxeCl9IIiHg9p29VSu3KyvEr
 s4jjAN+MI8zoLVAWe2Tjnrj/p5o=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96c81e.7f7c1e073880-smtp-out-n02;
 Wed, 15 Apr 2020 08:38:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6B04C44792; Wed, 15 Apr 2020 08:38:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65A8AC4478F;
        Wed, 15 Apr 2020 08:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65A8AC4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] cw1200: make cw1200_spi_irq_unsubscribe() void
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200410090910.27132-1-yanaijie@huawei.com>
References: <20200410090910.27132-1-yanaijie@huawei.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <pizza@shaftnet.org>, <davem@davemloft.net>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415083853.D6B04C44792@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:38:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following coccicheck warning:
> 
> drivers/net/wireless/st/cw1200/cw1200_spi.c:273:5-8: Unneeded variable:
> "ret". Return "0" on line 279
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

80efb443ea03 cw1200: make cw1200_spi_irq_unsubscribe() void

-- 
https://patchwork.kernel.org/patch/11483037/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
