Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F988318558
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 07:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBKGt6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 01:49:58 -0500
Received: from so15.mailgun.net ([198.61.254.15]:54987 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBKGtu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 01:49:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613026167; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=stqQCaxm15MvA0NArwtcC1pcpTiUNnyTegBfuwvg6Hc=;
 b=kf6NTxQYSD/9ZQKNiGBXuiGlUO9pFqpNw/vFPmgcHiVhGw5dRgMRpafiUR2Bq4JhKHTrMfxR
 n4Em06zRFFeXKFlP0MS04vyI5f8niSyksmvAyqsGHAQzg3iKH3wRyvPpEXohEBG0xXi7n4Dv
 Xl4XCgHQmip6q1nd/XvEvKJzVmE=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6024d35a81f6c45dce3edc5c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 06:48:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BAD4C433ED; Thu, 11 Feb 2021 06:48:57 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A57BC433C6;
        Thu, 11 Feb 2021 06:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A57BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add support to configure spatial reuse parameter
 set
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1612843714-29174-1-git-send-email-rmanohar@codeaurora.org>
References: <1612843714-29174-1-git-send-email-rmanohar@codeaurora.org>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210211064857.9BAD4C433ED@smtp.codeaurora.org>
Date:   Thu, 11 Feb 2021 06:48:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rajkumar Manoharan <rmanohar@codeaurora.org> wrote:

> The SPR parameter set comprises OBSS PD threshold for SRG
> and non SRG and Bitmap of BSS color and partial BSSID. This adds
> support to configure fields of SPR element to firmware.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01164-QCAHKSWPL_SILICONZ-1
> Tested-by: Muna Sinada <msinada@codeaurora.org>
> Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b56b08aec57d ath11k: add support to configure spatial reuse parameter set

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1612843714-29174-1-git-send-email-rmanohar@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

