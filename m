Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBDB1D19E9
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 17:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgEMPvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 11:51:20 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26242 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729121AbgEMPvU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 11:51:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589385079; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=csZZbG31zF1WE66cIFM96ULqblY3Kv2MtlJ6cz+gqG0=;
 b=l/M0gFVFvXb/gvy/j1CX7Bq9tsRNt02CoqPhgTEzvdDeTXwmEUe3sTCH2B3vwKp2C8iREfmU
 ODL4CAr8MODgFp7Gv7KMZyYueaYavSF5Q9ea7C071lnuefrmJA5NZwee/JCH1t3oIrjG2C5k
 2tFBegOfs8gBLIYlfOtrQO1jf4Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc176c.7f22206160d8-smtp-out-n01;
 Wed, 13 May 2020 15:51:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 596DEC433F2; Wed, 13 May 2020 15:51:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7F2BC433D2;
        Wed, 13 May 2020 15:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7F2BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/7] rtw88: extract: export symbols used in chip
 functionalities
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200512103120.5280-2-yhchuang@realtek.com>
References: <20200512103120.5280-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>, <kevin_yang@realtek.com>,
        <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200513155108.596DEC433F2@smtp.codeaurora.org>
Date:   Wed, 13 May 2020 15:51:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> In the current design, various chip functions and tables
> are built into rtw88 core. That causes kernel to load its
> functionalities even if a chip isn't currently used. We
> plan to make each chip's functionalities a separate
> kernel module to reduce rtw88 core. And kernel will be
> able to load the necessary.
> 
> Before extracting chip functionalities, we export symbols
> inside rtw88 core which will be used in chip modules.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Fails to compile:

ERROR: modpost: "rtw_read8_physical_efuse" [drivers/net/wireless/realtek/rtw88/rtw88_8822c.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

7 patches set to Changes Requested.

11542857 [v3,1/7] rtw88: extract: export symbols used in chip functionalities
11542851 [v3,2/7] rtw88: extract: export symbols about pci interface
11542861 [v3,3/7] rtw88: extract: make 8822c an individual kernel module
11542853 [v3,4/7] rtw88: extract: make 8822b an individual kernel module
11542859 [v3,5/7] rtw88: extract: make 8723d an individual kernel module
11542849 [v3,6/7] rtw88: extract: remove the unused after extracting
11542855 [v3,7/7] rtw88: rename rtw88.ko/rtwpci.ko to rtw88_core.ko/rtw88_pci.ko

-- 
https://patchwork.kernel.org/patch/11542857/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
