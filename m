Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33C33AD11
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 09:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCOII0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 04:08:26 -0400
Received: from m42-2.mailgun.net ([69.72.42.2]:60226 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhCOIIZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 04:08:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615795705; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TTFfeyZWEswLJBSG7E/dJlIStoDFomBMP35/D+YPgo8=;
 b=INrv0hxUfytbEyAt0rJt1z56mOn4CUXZJ3GKxmyLTBNO4lIXGkuhVql4cp00InJx0ZTz0DVI
 dAF8DmPAfDmeWNonn9UgnC21OtjSjgv6Vxgjj7VA5FwIw3XhJY1LteJjR5ZuNFNJrcUcP/bV
 qeQPJIf2YB+RhHoYo4PH9B5ZOW0=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 604f15f26dc1045b7dbcba7c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Mar 2021 08:08:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D04F3C43462; Mon, 15 Mar 2021 08:08:17 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 022C3C433CA;
        Mon, 15 Mar 2021 08:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 022C3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: Fix an error code in rtw_debugfs_set_rsvd_page()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YCwgb/4F4Y+tyE56@mwanda>
References: <YCwgb/4F4Y+tyE56@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Tzu-En Huang <tehuang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210315080817.D04F3C43462@smtp.codeaurora.org>
Date:   Mon, 15 Mar 2021 08:08:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The sscanf() function returns either 0 or 1 here.  It doesn't return
> error codes.  We should return -EINVAL if the string is invalid.
> 
> Fixes: c376c1fc87b7 ("rtw88: add h2c command in debugfs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Why do you remove the num variable? I think the code is more readable with it.

(Sorry, I'm not able to quote the code as I'm replying from patchwork script
and it doesn't support that yet.)

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YCwgb/4F4Y+tyE56@mwanda/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

