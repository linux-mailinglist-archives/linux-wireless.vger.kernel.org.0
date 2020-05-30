Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2FF1E9206
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2020 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgE3OTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 May 2020 10:19:04 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:28806 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728979AbgE3OTD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 May 2020 10:19:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590848343; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dpw+1kDMnFkzOFQL5lNzqbxZZHq9A4gb7QzDms9lhFM=;
 b=Pufgia9DOoz/mPik/7i2tJg9i3Ch6c43B8ncoEaTqTYC4M+zv4hEKCVWY0nQcatnbLFmQ0WN
 fmo2Pvti7mHN0CKVLKZpwKMxIGMqww4ud5VSW/SGU0Ob4POZ948c6lSs+2BHU46+VxpZX0C7
 GBoMjJem4tdr0+3zyg2NaezQihE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ed26b4576fccbb4c8d82bca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 30 May 2020 14:18:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5430CC433C9; Sat, 30 May 2020 14:18:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F24DC433C9;
        Sat, 30 May 2020 14:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F24DC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Remove ath10k_qmi_register_service_notifier()
 declaration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200528122105.1.I31937dce728b441fd72cbe23447bc4710fd56ddb@changeid>
References: <20200528122105.1.I31937dce728b441fd72cbe23447bc4710fd56ddb@changeid>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Govind Singh <govinds@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200530141844.5430CC433C9@smtp.codeaurora.org>
Date:   Sat, 30 May 2020 14:18:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Douglas Anderson <dianders@chromium.org> wrote:

> The ath10k/qmi.h header file contains a declaration for the function
> ath10k_qmi_register_service_notifier().  This function doesn't exist.
> Remove the declaration.
> 
> This patch is a no-op and was just found by code inspection.
> 
> Fixes: ba94c753ccb4 ("ath10k: add QMI message handshake for wcn3990 client")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

23cc6bb5a2e6 ath10k: Remove ath10k_qmi_register_service_notifier() declaration

-- 
https://patchwork.kernel.org/patch/11576663/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

