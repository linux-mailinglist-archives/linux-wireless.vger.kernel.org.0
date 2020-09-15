Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B485526AC97
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Sep 2020 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgIOSwq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 14:52:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11977 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727587AbgIORZJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 13:25:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600190693; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=DKVOWuRIvVr3LdsiDDsJWMyWPpeEViaBGb/zh4ecPl8=;
 b=JP+E+3zYO9RJqOdratQ9Mef2CsaZxPZsAaO5xiNirvW2vmp4mZtJyx0zJuEGjeHmKou57QbA
 38CxczBffVOgGByxOG5upkzjdg3AcUGmnV8ORiEYUs5xwj2YWw7xurIpK7maoXlh49Assx6g
 n+AM7TIvtrm+fnI78Bl0Xas/B78=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f60f258885efaea0a8bbd59 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 16:56:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E163C433F0; Tue, 15 Sep 2020 16:56:55 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3C44C433CA;
        Tue, 15 Sep 2020 16:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3C44C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add support spectral scan for IPQ6018
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591688888-30237-1-git-send-email-periyasa@codeaurora.org>
References: <1591688888-30237-1-git-send-email-periyasa@codeaurora.org>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200915165655.8E163C433F0@smtp.codeaurora.org>
Date:   Tue, 15 Sep 2020 16:56:55 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <periyasa@codeaurora.org> wrote:

> IPQ6018 supported with 4 bytes FFT BIN size. so supported 4 bytes
> parsing logic in FFT report process.
> 
> Tested-on: IPQ6018 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
> 
> Note: This is based on below patches
> 	1. ath11k: add IPQ6018 support
> 	2. ath11k: add support for spectral scan
> 	3. ath11k: Add direct buffer ring support
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Does not apply anymore, please rebase. Also you should investigate how
it works with QCA6390.

error: patch failed: drivers/net/wireless/ath/ath11k/core.c:26
error: drivers/net/wireless/ath/ath11k/core.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/hw.h:117
error: drivers/net/wireless/ath/ath11k/hw.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11594815/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

