Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7B149B95
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAZPqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:46:07 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:26938 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgAZPqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:46:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580053565; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6jaEmpwz6jpkWQuPKd4hK97dQSPpMAL12hKkiJaEFZ8=;
 b=jdZsgpzF1SeQfawjFGSp6p7y3x2Y2Zv9H3LBIOGDAJ7x6z47iXtzvb7z6dIWAy0/QddHb/1Q
 mGVpgev8Jtm9p3Wk2y3pKIT6pH2tlj6NUkbocCm2ImDTBOB0JhKvS4tXUxZzIBvrKp3W0KyO
 v0qXxSAML0Xqsoca2L2KkTCd9sI=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db438.7f70576a4378-smtp-out-n02;
 Sun, 26 Jan 2020 15:46:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8C14C4479F; Sun, 26 Jan 2020 15:46:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BF89C4479C;
        Sun, 26 Jan 2020 15:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BF89C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8821ae: remove unused variables
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200121020958.27548-1-yuehaibing@huawei.com>
References: <20200121020958.27548-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <pkshih@realtek.com>, <davem@davemloft.net>,
        <Larry.Finger@lwfinger.net>, <yuehaibing@huawei.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126154600.A8C14C4479F@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 15:46:00 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:142:17:
>  warning: cckswing_table_ch1ch13 defined but not used [-Wunused-const-variable=]
> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:178:17:
>  warning: cckswing_table_ch14 defined but not used [-Wunused-const-variable=]
> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:96:18:
>  warning: ofdmswing_table defined but not used [-Wunused-const-variable=]
> 
> These variable is never used, so remove them.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

cc071a6f26aa rtlwifi: rtl8821ae: remove unused variables

-- 
https://patchwork.kernel.org/patch/11343035/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
