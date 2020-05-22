Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5581DE465
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 12:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgEVK2G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 06:28:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63850 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbgEVK2F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 06:28:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590143284; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=BKz/cA+7ZSChChBbA1dHDF0giivBvOUjr7li7On/MOI=; b=my78+ZeXXgx41nvgdKVQJc1W/SiXcquchQM/6cyFWuHyjd5AgQ7m8B5anRswlFo3MHH7acyF
 MDPoyvYgzc/edWlJUrJcth2bMQKDNGJztILY3Xragok7PmY+e/dVFM4iIVbeKPFh4s22yjCf
 wPMFRDtFdAp0AcgEgoin7dVLFf0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ec7a9228075f6e58c3b757f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 10:27:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1E84C43387; Fri, 22 May 2020 10:27:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04002C433C6;
        Fri, 22 May 2020 10:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04002C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevlo@kevlo.org>
Subject: Re: [PATCH] Revert "rtw88: no need to set registers for SDIO"
References: <20200520055350.23328-1-yhchuang@realtek.com>
Date:   Fri, 22 May 2020 13:27:41 +0300
In-Reply-To: <20200520055350.23328-1-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Wed, 20 May 2020 13:53:50 +0800")
Message-ID: <871rncb6xu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

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

Oops, I was supposed to drop that patch but somehow I did apply it
anyway. Sorry about that, I'll apply this revert.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
