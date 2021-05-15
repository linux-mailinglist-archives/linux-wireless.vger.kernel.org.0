Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458D3381877
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 13:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhEOLoq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 07:44:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:20979 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhEOLoo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 07:44:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621079011; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3SbwwlZ6XxzArZbGPQMkPyC8ode6fhn0PX5S0gThA+Y=;
 b=TGHtJV3KIgf6XUr1HypLROP68XCdPphj+medcekVqvHt0l5ywf6ipDBuW5K5GGndLnkS/GeG
 pZvWDWIVModM7toCX8amubU21ZYRvUHYfqZT2Y57esezsYjf2P1UH/QxoEMOaZ2axA+og8US
 o/vzc0cblUFbmov2IneJWsYq8FI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 609fb3e0b15734c8f9ff82b1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 15 May 2021 11:43:28
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C95AC433D3; Sat, 15 May 2021 11:43:28 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EF8EC433D3;
        Sat, 15 May 2021 11:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EF8EC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] mt76: mt7921: fix possible AOOB issue in
 mt7921_mcu_tx_rate_report
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <91a1e8f6b6a3e6a929de560ed68132f6eb421720.1619187875.git.lorenzo@kernel.org>
References: <91a1e8f6b6a3e6a929de560ed68132f6eb421720.1619187875.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210515114328.2C95AC433D3@smtp.codeaurora.org>
Date:   Sat, 15 May 2021 11:43:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix possible array out of bound access in mt7921_mcu_tx_rate_report.
> Remove unnecessary varibable in mt7921_mcu_tx_rate_report
> 
> Fixes: 1c099ab44727c ("mt76: mt7921: add MCU support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

2 patches applied to wireless-drivers.git, thanks.

d874e6c06952 mt76: mt7921: fix possible AOOB issue in mt7921_mcu_tx_rate_report
6061fcf4820a mt76: connac: do not schedule mac_work if the device is not running

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/91a1e8f6b6a3e6a929de560ed68132f6eb421720.1619187875.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

