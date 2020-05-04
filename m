Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275A11C35DF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgEDJho (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 05:37:44 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43399 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbgEDJho (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 05:37:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588585063; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jvDJv8FHyDjUsVzxPiq5yfDM6HScTqopUDc+IZlUt/s=;
 b=A/K2mMoytfL1uoyG4zT23J5jj6k6HV5ifXwUNRdQ0EVTBhvtfPkS8ioG01NM85Y0ct3wISWK
 sya3HkUNbx+kvfJMRHln9Fqy1OLnDLSBPYkidusRIrA2AiDoXefMsBdUdUzjbtmZDPf3V2CI
 fBt72avTReScAy0DHztMHoZ6W5U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafe255.7f7375401d88-smtp-out-n03;
 Mon, 04 May 2020 09:37:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6FC5EC432C2; Mon,  4 May 2020 09:37:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F870C433CB;
        Mon,  4 May 2020 09:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F870C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: mac: Make some founctions static
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200425083503.149656-1-chentao107@huawei.com>
References: <20200425083503.149656-1-chentao107@huawei.com>
To:     ChenTao <chentao107@huawei.com>
Cc:     <yhchuang@realtek.com>, <davem@davemloft.net>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200504093724.6FC5EC432C2@smtp.codeaurora.org>
Date:   Mon,  4 May 2020 09:37:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ChenTao <chentao107@huawei.com> wrote:

> Fix the following warning:
> 
> vers/net/wireless/realtek/rtw88/mac.c:699:5: warning:
> symbol '__rtw_download_firmware' was not declared. Should it be static?
> drivers/net/wireless/realtek/rtw88/mac.c:863:5: warning:
> symbol '__rtw_download_firmware_legacy' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>

Already fixed:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=3d8bf50860c7de09c9713b97ec2f87ad42338c7e

-- 
https://patchwork.kernel.org/patch/11509743/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
