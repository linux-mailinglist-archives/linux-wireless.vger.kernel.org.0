Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA523582A
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgHBP0m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:26:42 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26473 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbgHBP0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:26:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596382001; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=GNA5OJNuR29Mlzis21RnUedjUzEFcyoDBxjkgslOWSs=;
 b=MU2jxHXn1vK85Qntq5UzhV8DH5nD/kIzWebLrVllwXwEjS4EdKkFDVmFm5jjbI3ajT/x7LRV
 fHVvavTeHRzC2aECcghTb48BANeyMtdIbt6e07/83muLwQOLxYRSHA/fwjg7qdZnAlAyrz6m
 bot4dWnKv6oWvmYCcsMTGVJ41Pc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f26db28798b102968042635 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:26:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 617D3C433CA; Sun,  2 Aug 2020 15:26:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 009FDC433C9;
        Sun,  2 Aug 2020 15:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 009FDC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] drivers: bcma: remove set but not used variable `addrh`
 and
 `sizeh`
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200721083935.13306-1-zhengyongjun3@huawei.com>
References: <20200721083935.13306-1-zhengyongjun3@huawei.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <zajec5@gmail.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802152631.617D3C433CA@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:26:31 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/bcma/scan.c: In function 'bcma_erom_get_addr_desc':
> drivers/bcma/scan.c:219 warning:
> variable `addrh` and `sizeh` set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

92d26d1abf8e drivers: bcma: remove set but not used variable `addrh` and `sizeh`

-- 
https://patchwork.kernel.org/patch/11675235/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

