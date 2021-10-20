Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79DC434810
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 11:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJTJnD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 05:43:03 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:30286 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTJnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 05:43:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634722848; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Jw0qwnVbtQVBvOKBbA2/WDtiwWKWIHq9kZePYBRYIv4=;
 b=JQLcTjyekSqRzo1XQHUnFJX9P7CING1Wflw9BFehe7kyoY9PiXXAZuRnyO0K976L8qvy6uxu
 RXW787rlJKxtCYPZmGzEBqyYiK1FpnoTgblc96t5Z9b+c7Eqe6s1/z7XyLUBlzij68i7W9QB
 7UCjNUCnsxraa78BJwcdrrQTplg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 616fe4155ca800b6c1687d1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 09:40:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6898EC4360C; Wed, 20 Oct 2021 09:40:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 456ABC4338F;
        Wed, 20 Oct 2021 09:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 456ABC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/15] wireless: use eth_hw_addr_set()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211018235021.1279697-2-kuba@kernel.org>
References: <20211018235021.1279697-2-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163472283126.20863.6496781362278299379.kvalo@codeaurora.org>
Date:   Wed, 20 Oct 2021 09:40:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> Convert all WiFi drivers from memcpy(... ETH_ADDR)
> to eth_hw_addr_set():
> 
>   @@
>   expression dev, np;
>   @@
>   - memcpy(dev->dev_addr, np, ETH_ALEN)
>   + eth_hw_addr_set(dev, np)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

14 patches applied to wireless-drivers-next.git, thanks.

708884e7f7f3 wireless: use eth_hw_addr_set()
fcb79f31d906 wireless: use eth_hw_addr_set() instead of ether_addr_copy()
8fac27fbc80e wireless: use eth_hw_addr_set() for dev->addr_len cases
f2e2a083be8a ath6kl: use eth_hw_addr_set()
c7b6128a8db1 wil6210: use eth_hw_addr_set()
251277af9c4f atmel: use eth_hw_addr_set()
fba610c5bf70 brcmfmac: prepare for const netdev->dev_addr
e3f90395c4f2 airo: use eth_hw_addr_set()
d8a416def4c8 ipw2200: prepare for const netdev->dev_addr
2202c2f428e1 hostap: use eth_hw_addr_set()
0341ae70ebf0 wilc1000: use eth_hw_addr_set()
6dedb2742b7a ray_cs: use eth_hw_addr_set()
18774612246d wl3501_cs: use eth_hw_addr_set()
2ad96cb5b4f4 zd1201: use eth_hw_addr_set()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211018235021.1279697-2-kuba@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

