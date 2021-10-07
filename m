Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAD424CCF
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 07:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbhJGFeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 01:34:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11929 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhJGFeH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 01:34:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633584734; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YEWZb9G2+ZymlJEpKYBfqYpSz97eXyWi3y2x/8pv+w0=; b=d5kJD1DwBIZGj52q6ywDo3OVsWSJy+wGoeJ3m988BdAwVcUTHy8JYgANMLp4Uc4cQujQwc3W
 4PkAgkbEn8XjtwIxiVnmKp/6uFbjDLaHtPaFn2rqfvkTBvIEcFLIz195Js6UcF1DI7ExHIfo
 3ZM8w4Tt3JWBhc5NASIeLJbngJA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 615e86548ea00a941f9c0ad4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Oct 2021 05:32:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4277BC43616; Thu,  7 Oct 2021 05:32:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3447C4360C;
        Thu,  7 Oct 2021 05:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C3447C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 10/15] ath10k: add support for pwrseq sequencing
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
        <20211006035407.1147909-11-dmitry.baryshkov@linaro.org>
Date:   Thu, 07 Oct 2021 08:31:57 +0300
In-Reply-To: <20211006035407.1147909-11-dmitry.baryshkov@linaro.org> (Dmitry
        Baryshkov's message of "Wed, 6 Oct 2021 06:54:02 +0300")
Message-ID: <87a6jle6ya.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> Power sequencing for Qualcomm WiFi+BT chipsets are being reworked to use
> pwrseq rather than individually handling all the regulators. Add support
> for pwrseq to ath10k SNOC driver.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Please include a Tested-on tag so that it's documented on what hardware
and firmware combination you tested this:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#tested-on_tag

Otherwise looks ok to me. I assume this is going via some another tree
than my ath tree:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
