Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470B0418E22
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 06:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhI0EX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 00:23:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:55886 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhI0EX7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 00:23:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632716542; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/H6WzJGD04JtDBNYTdt2svMoXCShbLV7vBBRYEn/Lug=;
 b=c7wRtbiKTtdQx1Uq41D8d1KV6sP4MSPWXyN8fLQhu7LjECGQ79LDLcFjuODtLsYi5zkRe6T8
 ZZSGEBZq7fA7E/EPiZUvd2m/pJeA4CBHHLyNjHIzOmxmztNeQ7EKmJuwPi+lHRSnQm++2nvt
 R3Xb1g4eyWnTDUsLAAgjpwXBVaE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 615146e91abbf21d3474b849 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Sep 2021 04:22:01
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9FCA4C4338F; Mon, 27 Sep 2021 04:22:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7EC8C4360C;
        Mon, 27 Sep 2021 04:21:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Sep 2021 09:51:59 +0530
From:   akolli@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] ath11k: use hw_params to access board_size and
 cal_offset
In-Reply-To: <87a6k2rptc.fsf@codeaurora.org>
References: <20210721201927.100369-1-jouni@codeaurora.org>
 <20210721201927.100369-2-jouni@codeaurora.org>
 <87a6k2rptc.fsf@codeaurora.org>
Message-ID: <03d382622d9d8a48b35b923d16ca5710@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-24 20:19, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Anilkumar Kolli <akolli@codeaurora.org>
>> 
>> Reuse board_size from hw_params, add cal_offset to hw params.
>> This patch is clean up only, there is no change in functionality.
>> 
>> Tested-on: IPQ8074 hw2.0 AHB 
>> WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9074 hw1.0 PCI 
>> WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath11k/core.c | 10 +++++-----
>>  drivers/net/wireless/ath/ath11k/hw.h   |  2 +-
>>  drivers/net/wireless/ath/ath11k/qmi.c  |  4 ++--
>>  drivers/net/wireless/ath/ath11k/qmi.h  |  2 --
>>  4 files changed, 8 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c 
>> b/drivers/net/wireless/ath/ath11k/core.c
>> index c97830633f1f..d2ab3b134632 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -37,7 +37,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  		.fw = {
>>  			.dir = "IPQ8074/hw2.0",
>>  			.board_size = 256 * 1024,
>> -			.cal_size = 256 * 1024,
>> +			.cal_offset = 128 * 1024,
>>  		},
>>  		.max_radios = 3,
>>  		.bdf_addr = 0x4B0C0000,
>> @@ -87,7 +87,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  		.fw = {
>>  			.dir = "IPQ6018/hw1.0",
>>  			.board_size = 256 * 1024,
>> -			.cal_size = 256 * 1024,
>> +			.cal_offset = 128 * 1024,
>>  		},
>>  		.max_radios = 2,
>>  		.bdf_addr = 0x4ABC0000,
>> @@ -134,7 +134,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  		.fw = {
>>  			.dir = "QCA6390/hw2.0",
>>  			.board_size = 256 * 1024,
>> -			.cal_size = 256 * 1024,
>> +			.cal_offset = 128 * 1024,
>>  		},
>>  		.max_radios = 3,
>>  		.bdf_addr = 0x4B0C0000,
>> @@ -180,7 +180,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  		.fw = {
>>  			.dir = "QCN9074/hw1.0",
>>  			.board_size = 256 * 1024,
>> -			.cal_size = 256 * 1024,
>> +			.cal_offset = 128 * 1024,
>>  		},
>>  		.max_radios = 1,
>>  		.single_pdev_only = false,
>> @@ -226,7 +226,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  		.fw = {
>>  			.dir = "WCN6855/hw2.0",
>>  			.board_size = 256 * 1024,
>> -			.cal_size = 256 * 1024,
>> +			.cal_offset = 128 * 1024,
>>  		},
>>  		.max_radios = 3,
>>  		.bdf_addr = 0x4B0C0000,
>> diff --git a/drivers/net/wireless/ath/ath11k/hw.h 
>> b/drivers/net/wireless/ath/ath11k/hw.h
>> index 5d150cd793b2..3a03e09563e7 100644
>> --- a/drivers/net/wireless/ath/ath11k/hw.h
>> +++ b/drivers/net/wireless/ath/ath11k/hw.h
>> @@ -128,7 +128,7 @@ struct ath11k_hw_params {
>>  	struct {
>>  		const char *dir;
>>  		size_t board_size;
>> -		size_t cal_size;
>> +		size_t cal_offset;
> 
> You don't mention anything about cal_size. I'll add this to the commit
> log:
> 
> cal_size was unused, so remove that.

Yes. Thanks for adding.

- Anil.
