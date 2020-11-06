Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C567B2A9006
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 08:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKFHLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 02:11:09 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:19275 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgKFHLI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 02:11:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604646668; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=M7Jbb2/KtYXppLcxnwTJFUrf47vGgmwOSsDkYg4ptJQ=;
 b=SF62lS5RbPPzO/cOgjOiN8DIljpKgIDQqtuLmD/CbxBEi2agC9ZqoIdYpMc11Ou37uZoFhMS
 Lv7A38+FazW5/SQD73c7AAykoMI9Rhxg10BAX6fsDZW90LqZm0r7MqMKT6bUefS7evrMbaAG
 scyXEze5nfjpB6dc8Z296fL1+us=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fa4f70b42c6e77b6539057e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 07:11:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7CE3C433C6; Fri,  6 Nov 2020 07:11:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF211C433C8;
        Fri,  6 Nov 2020 07:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF211C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, kuabhs@chromium.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201106071107.D7CE3C433C6@smtp.codeaurora.org>
Date:   Fri,  6 Nov 2020 07:11:07 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Abhishek Kumar <kuabhs@chromium.org> wrote:

> In some devices difference in chip-id should be enough to pick
> the right BDF. Add another support for chip-id based BDF selection.
> With this new option, ath10k supports 2 fallback options.
> 
> The board name with chip-id as option looks as follows
> board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'
> 
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Abhishek Kumar <kuabhs@chromium.org>

There were few checkpatch warnings which I fixed:

$ ath10k-check
drivers/net/wireless/ath/ath10k/core.c:1501: Alignment should match open parenthesis
drivers/net/wireless/ath/ath10k/core.c:1512: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/core.c:1521: line length of 92 exceeds 90 columns

The first one was also what Doug commented. I also added Tested-on tags,
thanks for those. The updated patch is in pending branch (soon).

But is this patch ok to take now? I didn't quite get the conclusion of the
discussion.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

