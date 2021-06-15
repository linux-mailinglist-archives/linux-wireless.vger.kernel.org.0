Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B455B3A8045
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhFONhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:37:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63350 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231602AbhFONhm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:37:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623764138; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=IvhcmHK9rrc0H3C7Q/rH7Dq5/EUXIwP0eRrpBUHzJik=;
 b=FcLOk/kuPjuX0HRfqYwOYBos338UE03wVnzjC8kZLR7l9wtcJLMyUjflp7+wImqtNVZhd1/Y
 il1o3YomEzXuP0ynw390O1T2pvVCRvwVOCWT4YndBXvMIPw3VPXhwA4M9VgPXEV7YNkMvF6b
 GMBxcGtRQWCJyBxFA2PTvv8cNWI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60c8aca7e27c0cc77f1ddd22 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:35:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A213AC4338A; Tue, 15 Jun 2021 13:35:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8EA2C4323A;
        Tue, 15 Jun 2021 13:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8EA2C4323A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wilc1000: Fix clock name binding
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210428025445.81953-1-tudor.ambarus@microchip.com>
References: <20210428025445.81953-1-tudor.ambarus@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     <ajay.kathat@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <gregkh@linuxfoundation.org>, <adham.abozaeid@microchip.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cristian.birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615133534.A213AC4338A@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:35:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tudor Ambarus <tudor.ambarus@microchip.com> wrote:

> Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> requires an "rtc" clock name.
> drivers/net/wireless/microchip/wilc1000/sdio.c is using "rtc" clock name
> as well. Comply with the binding in wilc1000/spi.c too.
> 
> Fixes: 854d66df74ae ("staging: wilc1000: look for rtc_clk clock in spi mode")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Patch applied to wireless-drivers-next.git, thanks.

d4f23164cff0 wilc1000: Fix clock name binding

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210428025445.81953-1-tudor.ambarus@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

