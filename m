Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164853633E9
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 07:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhDRF5v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 01:57:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29208 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236430AbhDRF5u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 01:57:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618725443; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vNAqgDa7X0EcUsfQLVk3fPMT8JupPO1Lvnt2QflVHQA=;
 b=J+cJqs4LAfj/zRl6l05X48yjriXNTUBSaZQUedEFm8oTNTHRXaAgrmkK02f+Cx/sWtoN0kOt
 hvdeT3psu//ITToNKtAYCJ4INgswtoRwHugww5btYthLYe6AAaaUfashT+pOw3pnSFyb4Wcs
 KysVRQkW6x3UfCWSih1eoT6hHz0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 607bca3ca817abd39abdc1e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 18 Apr 2021 05:57:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BF12C433F1; Sun, 18 Apr 2021 05:57:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DD80C433D3;
        Sun, 18 Apr 2021 05:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DD80C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtl8xxxu: Fix device info for RTL8192EU devices
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210323193617.3748164-1-pterjan@google.com>
References: <20210323193617.3748164-1-pterjan@google.com>
To:     Pascal Terjan <pterjan@google.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pascal Terjan <pterjan@google.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210418055716.2BF12C433F1@smtp.codeaurora.org>
Date:   Sun, 18 Apr 2021 05:57:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pascal Terjan <pterjan@google.com> wrote:

> Based on 2001:3319 and 2357:0109 which I used to test the fix and
> 0bda:818b and 2357:0108 for which I found efuse dumps online.
> 
> == 2357:0109 ==
> === Before ===
> Vendor: Realtek
> Product: \x03802.11n NI
> Serial:
> === After ===
> Vendor: Realtek
> Product: 802.11n NIC
> Serial not available.
> 
> == 2001:3319 ==
> === Before ===
> Vendor: Realtek
> Product: Wireless N
> Serial: no USB Adap
> === After ===
> Vendor: Realtek
> Product: Wireless N Nano USB Adapter
> Serial not available.
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>

Can someone review this, please?

Patch set to Deferred.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210323193617.3748164-1-pterjan@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

