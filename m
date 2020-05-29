Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065F31E8517
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgE2RhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:37:13 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19157 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgE2RhN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:37:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590773830; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/cLuSEw4Fy8K3p0QAS2u6F1JupxWsEtl5aIbyjK63rg=;
 b=nwk0OCd8Ik6A0HJILIRy8p2rl5N3OKTMTVEIpYW3VNv0c4OrZCCOH9kOtKicaYaABv7BFbMH
 TzMJV5cCrXkaZeCpM58fZ8zBnCT4c7y1pIPyKxawAU/m+KNV4FT1z8rQVizBjLjGQ3BtIk4I
 W2qnOWuuoaLezIUCihxeQ3ED9vU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed1483acb04586933abb4cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:36:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B28FC433CB; Fri, 29 May 2020 17:36:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0990C433C9;
        Fri, 29 May 2020 17:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0990C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: 8822c: fix missing brace warning for old compilers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200522035521.12295-1-yhchuang@realtek.com>
References: <20200522035521.12295-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <oliver.sang@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529173657.9B28FC433CB@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:36:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> For older versions of gcc, the array = {0}; will cause warnings:
> 
> drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function 'rtw8822c_power_trim':
> >> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning:
> >> missing braces around initializer [-Wmissing-braces]
> s8 bb_gain[2][8] = {0};
> ^
> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: (near
> initialization for 'bb_gain[0]') [-Wmissing-braces]
> 
> Fixes: 5ad4d8957b69 ("rtw88: set power trim according to efuse PG values")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Patch applied to wireless-drivers-next.git, thanks.

4e1a341580f2 rtw88: 8822c: fix missing brace warning for old compilers

-- 
https://patchwork.kernel.org/patch/11564651/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

