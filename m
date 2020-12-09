Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02B2D3BCE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 08:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgLIHAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 02:00:02 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:44986 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgLIG74 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 01:59:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607497175; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dBTZkN4in/h4cStfLOfA5ED2vJbrY3uxWvpyDqz/lFc=;
 b=u4CEGTvsQ7Z15h1QhhvmoLSw1yxN4UfFs4ipqpd39eQ3vJLo3BblcHRB9dAxMm1zureyI1XR
 cCjmomj7Xfbyuq6Re4SPvZ9DKczucnWJLldKvcYwW/OHmxJODkYQgQIFh1xV4P9nqok6WG7F
 Z9KcSDTcWq6CNRJWQfYEn/0Eg+w=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fd075d708e2259978f0b4c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 06:59:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56397C433ED; Wed,  9 Dec 2020 06:59:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24D14C433C6;
        Wed,  9 Dec 2020 06:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24D14C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix "rmmod ath11k_pci" failure after QMI sequence
 fails
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201120020028.12063-1-bqiang@codeaurora.org>
References: <20201120020028.12063-1-bqiang@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201209065934.56397C433ED@smtp.codeaurora.org>
Date:   Wed,  9 Dec 2020 06:59:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> wrote:

> If board.bin file is missing, QMI sequence fails,
> which results in failure of "rmmod ath11k_pci".
> This patch fixes this issue.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>

Anil submitted an identical patch:

https://patchwork.kernel.org/project/linux-wireless/patch/1606916215-24643-1-git-send-email-akolli@codeaurora.org/

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201120020028.12063-1-bqiang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

