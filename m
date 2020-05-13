Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD381D19E3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgEMPtz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 11:49:55 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26242 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728490AbgEMPtz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 11:49:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589384995; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Jug67h5L2f2qR0zK/YV04dkwwclKohdB+umF477pb7M=;
 b=aUuO3xqByg8uYHV4gVswb074rIqpJAt0v044Gd37oHPqOvu0xFMmEvXzfwu2K3h+XmWNAffG
 QQmpdLRPUyhcKDp3sWu59JdoYWYRDuIYSTDqTLW/RR9GuuP+nyGQFKatHUqzwIV9COQFncAn
 XXM1pBuYinhEx6itY/UZ/FcsuNQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc1713.7f1673e64618-smtp-out-n02;
 Wed, 13 May 2020 15:49:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFA75C433BA; Wed, 13 May 2020 15:49:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B2D1C433F2;
        Wed, 13 May 2020 15:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B2D1C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/9] rtw88: 8723d: Add LC calibration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200512102621.5148-2-yhchuang@realtek.com>
References: <20200512102621.5148-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200513154938.AFA75C433BA@smtp.codeaurora.org>
Date:   Wed, 13 May 2020 15:49:38 +0000 (UTC)
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

9 patches applied to wireless-drivers-next.git, thanks.

f71eb7f60317 rtw88: 8723d: Add LC calibration
1d229e88e53c rtw88: 8723d: add IQ calibration
608d2a08f842 rtw88: 8723d: Add power tracking
05202746ed70 rtw88: 8723d: Add shutdown callback to disable BT USB suspend
7d754f974ac7 rtw88: 8723d: implement flush queue
7e14936881ca rtw88: 8723d: set ltecoex register address in chip_info
d1391c490085 rtw88: 8723d: Add coex support
504e2b288258 rtw88: fill zeros to words 0x06 and 0x07 of security cam entry
f5df1a8b4376 rtw88: 8723d: Add 8723DE to Kconfig and Makefile

-- 
https://patchwork.kernel.org/patch/11542827/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
