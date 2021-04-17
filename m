Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD703631A1
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhDQRv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 13:51:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:17756 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236643AbhDQRv5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 13:51:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618681891; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Zjg4k/X6Wnso4JK4y+VH14y0SpAfj2EebAe+dzVaPfw=;
 b=YDuidNvS09cNOQuBgxNxCnjnpxuTtq6U7zkz2dUVDmtItzuN7YO3xN+55n0Y4YEIhOfuoyl0
 n/XcN91PdqGhzmiz66zuY93NqsYmT53/vKK2o5/pV/TqaOHItd26Yz5SaZItqNEtjItWkZHy
 YI19aRPFJHU2BimQPJdi1EWc4CY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 607b2022853c0a2c46871416 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 17:51:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2877AC433D3; Sat, 17 Apr 2021 17:51:29 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48648C433F1;
        Sat, 17 Apr 2021 17:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48648C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wilc1000: Bring MAC address setting in line with typical
 Linux behavior
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210303194846.1823596-1-davidm@egauge.net>
References: <20210303194846.1823596-1-davidm@egauge.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     linux-wireless@vger.kernel.org,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        davidm@egauge.net
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417175129.2877AC433D3@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 17:51:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Mosberger-Tang <davidm@egauge.net> wrote:

> Linux network drivers normally disallow changing the MAC address when
> the interface is up.  This driver has been different in that it allows
> to change the MAC address *only* when it's up.  This patch brings
> wilc1000 behavior more in line with other network drivers.  We could
> have replaced wilc_set_mac_addr() with eth_mac_addr() but that would
> break existing documentation on how to change the MAC address.
> Likewise, return -EADDRNOTAVAIL (not -EINVAL) when the specified MAC
> address is invalid or unavailable.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

Patch applied to wireless-drivers-next.git, thanks.

a381b78a1598 wilc1000: Bring MAC address setting in line with typical Linux behavior

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210303194846.1823596-1-davidm@egauge.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

