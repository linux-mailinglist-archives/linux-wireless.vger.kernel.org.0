Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730FF1CEF78
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgELIt4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 04:49:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:20527 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgELItz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 04:49:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589273395; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=bODdbw+BN4whwW7tni2jfwgHoW4JPV0Q/pO25Yjh/PU=;
 b=vsmJeDwOEE97daMBWKU2+kyA5hbPe9dU7gZApmEnciBpjcg2uVpXN9D1GdLrLqELCOwzsPsq
 IoVf17P/BV7Uye/mOOzn/k3Q+KDtuq9dRau549gNv2okGw1DNTEl8+C/zaq+2aL3Ac8lEc2b
 zbpB8OdlKJwCpSirQrYjCavDJlg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba6327.7f1ffa0cd148-smtp-out-n05;
 Tue, 12 May 2020 08:49:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 606F4C433BA; Tue, 12 May 2020 08:49:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7761C433CB;
        Tue, 12 May 2020 08:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7761C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/9] rtw88: 8723d: Add LC calibration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200507042151.15634-2-yhchuang@realtek.com>
References: <20200507042151.15634-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200512084943.606F4C433BA@smtp.codeaurora.org>
Date:   Tue, 12 May 2020 08:49:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> LC calibration is done by hardware circuit. Driver sets the LCK bit to kick
> start, and then poll the bit to check if it's done.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Failed to apply, please rebase and send v2.

Recorded preimage for 'drivers/net/wireless/realtek/rtw88/pci.c'
error: Failed to merge in the changes.
Applying: rtw88: 8723d: Add shutdown callback to disable BT USB suspend
Using index info to reconstruct a base tree...
M	drivers/net/wireless/realtek/rtw88/pci.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/realtek/rtw88/pci.c
CONFLICT (content): Merge conflict in drivers/net/wireless/realtek/rtw88/pci.c
Patch failed at 0001 rtw88: 8723d: Add shutdown callback to disable BT USB suspend
The copy of the patch that failed is found in: .git/rebase-apply/patch

9 patches set to Changes Requested.

11532385 [v2,1/9] rtw88: 8723d: Add LC calibration
11532379 [v2,2/9] rtw88: 8723d: add IQ calibration
11532393 [v2,3/9] rtw88: 8723d: Add power tracking
11532389 [v2,4/9] rtw88: 8723d: Add shutdown callback to disable BT USB suspend
11532387 [v2,5/9] rtw88: 8723d: implement flush queue
11532375 [v2,6/9] rtw88: 8723d: set ltecoex register address in chip_info
11532377 [v2,7/9] rtw88: 8723d: Add coex support
11532383 [v2,8/9] rtw88: fill zeros to words 0x06 and 0x07 of security cam entry
11532381 [v2,9/9] rtw88: 8723d: Add 8723DE to Kconfig and Makefile

-- 
https://patchwork.kernel.org/patch/11532385/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
