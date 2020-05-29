Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B911E8464
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgE2RLs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:11:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47547 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgE2RLs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:11:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590772307; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=PwkZeuyBpewwPeV1Sxl1oUuJLFs8EercjU1m0Po6ejo=;
 b=uLFuPvEeMx2BtRIhzlR0y/S0NIcwRNtLpw6VHGgXVGs6yFIp4wrsifv4b/nlki5wLSX2EO6k
 1mWaZJpKLh7kouOQNZTd+uF/w36cTBbaBirHd5swD7wTtJS+Ac0O+C9OOIXmBHbc+RKSNcTg
 Pg1GDICQMKKqNPYNiXz6+l+uEKA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ed1423c5086732481ed0f68 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:11:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E866C433CB; Fri, 29 May 2020 17:11:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14A1AC433C9;
        Fri, 29 May 2020 17:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14A1AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "rtw88: no need to set registers for SDIO"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200520055350.23328-1-yhchuang@realtek.com>
References: <20200520055350.23328-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevlo@kevlo.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529171124.9E866C433CB@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:11:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> This reverts commit 07d0f5534935e2daf63a4e1012af13d68e089fed.
> 
> For rtw88 driver, the SDIO is going to be supported, so there is
> no need to remove the SDIO related power sequence settings. And
> while the power sequence parser will pass in the mask of the HCI,
> the SDIO part will not be used to set registers accordingly.
> 
> Moreover, the power sequence table is released as a whole package,
> so the next time if we are going to update, the SDIO settings will
> be overwritten. So, revert this now.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

dba5a189bf61 Revert "rtw88: no need to set registers for SDIO"

-- 
https://patchwork.kernel.org/patch/11559339/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

