Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C97417710
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346872AbhIXOvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 10:51:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40525 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhIXOvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 10:51:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632495008; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=IPy3De90pi9TJLFW7o3m3ltgiGwyZvzoByewFFcLi2Q=; b=s4PhRQ6eRJgzrLjD546ctUPGd3i2jOefbHZwr+cF11AngWU6OAxRRRUK4wCTRj0h/wKPJJzf
 +asM88xRt5lAi/uvWTDIRKBXXqut60UZzbuv2TRJCTfdwMCGJD9j+HRs2k/6pDVurqo+32ZT
 ZKo8HK0H5E9FLy3PMXf1EUSbHNM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 614de596e0480a7d6ff8699c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 14:49:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8687EC4360C; Fri, 24 Sep 2021 14:49:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F726C4338F;
        Fri, 24 Sep 2021 14:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9F726C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATCH 1/4] ath11k: use hw_params to access board_size and cal_offset
References: <20210721201927.100369-1-jouni@codeaurora.org>
        <20210721201927.100369-2-jouni@codeaurora.org>
Date:   Fri, 24 Sep 2021 17:49:51 +0300
In-Reply-To: <20210721201927.100369-2-jouni@codeaurora.org> (Jouni Malinen's
        message of "Wed, 21 Jul 2021 23:19:24 +0300")
Message-ID: <87a6k2rptc.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Anilkumar Kolli <akolli@codeaurora.org>
>
> Reuse board_size from hw_params, add cal_offset to hw params.
> This patch is clean up only, there is no change in functionality.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 10 +++++-----
>  drivers/net/wireless/ath/ath11k/hw.h   |  2 +-
>  drivers/net/wireless/ath/ath11k/qmi.c  |  4 ++--
>  drivers/net/wireless/ath/ath11k/qmi.h  |  2 --
>  4 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index c97830633f1f..d2ab3b134632 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -37,7 +37,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.fw = {
>  			.dir = "IPQ8074/hw2.0",
>  			.board_size = 256 * 1024,
> -			.cal_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
>  		},
>  		.max_radios = 3,
>  		.bdf_addr = 0x4B0C0000,
> @@ -87,7 +87,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.fw = {
>  			.dir = "IPQ6018/hw1.0",
>  			.board_size = 256 * 1024,
> -			.cal_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
>  		},
>  		.max_radios = 2,
>  		.bdf_addr = 0x4ABC0000,
> @@ -134,7 +134,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.fw = {
>  			.dir = "QCA6390/hw2.0",
>  			.board_size = 256 * 1024,
> -			.cal_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
>  		},
>  		.max_radios = 3,
>  		.bdf_addr = 0x4B0C0000,
> @@ -180,7 +180,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.fw = {
>  			.dir = "QCN9074/hw1.0",
>  			.board_size = 256 * 1024,
> -			.cal_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
>  		},
>  		.max_radios = 1,
>  		.single_pdev_only = false,
> @@ -226,7 +226,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.fw = {
>  			.dir = "WCN6855/hw2.0",
>  			.board_size = 256 * 1024,
> -			.cal_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
>  		},
>  		.max_radios = 3,
>  		.bdf_addr = 0x4B0C0000,
> diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
> index 5d150cd793b2..3a03e09563e7 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.h
> +++ b/drivers/net/wireless/ath/ath11k/hw.h
> @@ -128,7 +128,7 @@ struct ath11k_hw_params {
>  	struct {
>  		const char *dir;
>  		size_t board_size;
> -		size_t cal_size;
> +		size_t cal_offset;

You don't mention anything about cal_size. I'll add this to the commit
log:

cal_size was unused, so remove that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
