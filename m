Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15283F3A15
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhHUKHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 06:07:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23984 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhHUKG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 06:06:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629540380; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Hnw6FYIayv/MUd+AsNjmj9Piv5gp3FoqGWZBDwAUJ5M=; b=UKdmTK+XSHnqPQ58Q0vxi+I5Hh/Aa1p6amyCI2mKyNoNp87i/dRyqLz7SIMSn/bdMOh3AhR1
 1k+p9O4BW40Ze2RENpVWZeo2al54um/H/uTybumE/EpclR0zOhOkVh/1w0DjS3HhRTDbizzr
 pUp0pbMBta58zN2n/E5jyENRrZs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6120cfff9b8228d0d0160279 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 10:05:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1D83C4360C; Sat, 21 Aug 2021 10:05:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2222EC4338F;
        Sat, 21 Aug 2021 10:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2222EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zajec5@gmail.com>, <hauke@hauke-m.de>, <linville@tuxdriver.com>,
        <wanghaibin.wang@huawei.com>
Subject: Re: [PATCH 1/2] bcma: Fix memory leak for internally-handled cores
References: <20210727025232.663-1-yuzenghui@huawei.com>
        <20210727025232.663-2-yuzenghui@huawei.com>
        <8943a493-aee8-3fe5-e63a-f3b61eaead14@huawei.com>
Date:   Sat, 21 Aug 2021 13:05:42 +0300
In-Reply-To: <8943a493-aee8-3fe5-e63a-f3b61eaead14@huawei.com> (Zenghui Yu's
        message of "Sat, 21 Aug 2021 11:28:09 +0800")
Message-ID: <877dgfun7t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zenghui Yu <yuzenghui@huawei.com> writes:

> On 2021/7/27 10:52, Zenghui Yu wrote:
>> kmemleak reported that dev_name() of internally-handled cores were leaked
>> on driver unbinding. Let's use device_initialize() to take refcounts for
>> them and put_device() to properly free the related stuff.
>
> Could this be picked as a fix for v5.14 (_if_ it does fix something)?

Why should this go to v5.14? Most probably it's too late for v5.14
anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
