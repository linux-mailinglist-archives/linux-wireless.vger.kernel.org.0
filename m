Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AC02FA5C8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406137AbhARQO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 11:14:27 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:16349 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406447AbhARQOW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 11:14:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610986443; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=JptED8yK1s6VmsIxjHWFnW5B+xMdYTFUM0naR74bGOI=;
 b=hoEuHh24zKIMo1wQxDtRZCanRgDHUno5LljGOCuQ+hWKhUb1RAhnWtNTvsUNyXcwNhiodI5e
 002h5cpXOxk4wCxd9R5ifdmkGnTuFeVVkyAZmaUhgCUHZu+Iw6cn5nsi5MwbtfJycYaaiHkM
 RZv6EoF41KQhwFY6Q23maFuHTf4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6005b3c5859d74370d91d429 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 16:13:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1C50C433ED; Mon, 18 Jan 2021 16:13:56 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77C93C433C6;
        Mon, 18 Jan 2021 16:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77C93C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: remove duplicate function declaration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1608304793-20612-1-git-send-email-periyasa@codeaurora.org>
References: <1608304793-20612-1-git-send-email-periyasa@codeaurora.org>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210118161356.E1C50C433ED@smtp.codeaurora.org>
Date:   Mon, 18 Jan 2021 16:13:56 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <periyasa@codeaurora.org> wrote:

> Removed the duplicated peer related function declaration
> from core.h since those functions are already declared in peer.h
> 
> Founded in code review.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

cf8480d338a1 ath11k: remove duplicate function declaration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1608304793-20612-1-git-send-email-periyasa@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

