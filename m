Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8C1A0686
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 07:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgDGF1V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 01:27:21 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:54507 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgDGF1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 01:27:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586237240; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=R/TYLHzT9rYrI+2mJ2RiF+A6ZAqi7MIncfulqfKTyVY=;
 b=IkM0QfJBTBQKcGut/vmEHFuWBVyXAvYdqwQwwsTS7nQCr4M9nxAiML+GxLtLLYIDnh5JOmks
 vumZQP0+1sg72SQGDkhfCVQiQURSfTOOyTr4EOAHi93M5KBB3YVUHVdCiK0IY9e48ZKleCn4
 R4mpw8XSbca3+Fv+40LK7dISdww=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c0f37.7f53bf4da1f0-smtp-out-n05;
 Tue, 07 Apr 2020 05:27:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 958BFC433BA; Tue,  7 Apr 2020 05:27:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FB8DC433F2;
        Tue,  7 Apr 2020 05:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FB8DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] ath10k: add ppdu stats support for QCA6174/QCA9377
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016e82883b59-e52fb973-84a7-4c15-a236-c7a01390087b-000000@us-west-2.amazonses.com>
References: <0101016e82883b59-e52fb973-84a7-4c15-a236-c7a01390087b-000000@us-west-2.amazonses.com>
To:     Yu Wang <yyuwang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200407052718.958BFC433BA@smtp.codeaurora.org>
Date:   Tue,  7 Apr 2020 05:27:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yu Wang <yyuwang@codeaurora.org> wrote:

> When QCA6174/QCA9377 working in station mode, after connected
> to AP, tx bitrate is always '1.0 MBit/s' in output of command
> 'iw wlan0 link'.
> 
> That's because the parameters to calculate the tx bitrate are
> not well updated for QCA6174/QCA9377.
> 
> To fix this issue:
> 1. Add processing for HTT_T2H_MSG_TYPE_PPDU_STATS_IND which includes
>    the peer tx stats;
> 2. Map WMI_TLV_SERVICE_PEER_STATS_INFO to WMI_SERVICE_PEER_STATS to
>    enable the feature.
> 
> Tested with QCA6174 PCIe with firmware WLAN.RM.4.4.1.c3-00031.
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> 
> Signed-off-by: Yu Wang <yyuwang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This has new warnings:

drivers/net/wireless/ath/ath10k/htt_rx.c: In function 'ath10k_htt_process_ppdu_stats':
drivers/net/wireless/ath/ath10k/htt_rx.c:3746:21: warning: variable 'arsta' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath10k/htt_rx.c:3751:18: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath10k/htt_rx.c:3751:18:    expected unsigned char [usertype] num_ppdu
drivers/net/wireless/ath/ath10k/htt_rx.c:3751:18:    got restricted __le32 [usertype] num_ppdu

-- 
https://patchwork.kernel.org/patch/11250999/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
