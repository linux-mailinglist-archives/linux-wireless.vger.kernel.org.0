Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB946D36E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 13:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhLHMnY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 07:43:24 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:32616 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLHMnX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 07:43:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638967192; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=y6ZVfcg+sVRy5P1hPdcn6foFe/ecLIz95SvVzkTCvfw=;
 b=uq4p+fiYxf2rX75Nu1RwSecavvMkR4lv+XAC0BotiZLzodU90HOlOZ+rVMsT19To5PQ3G37E
 wbn6ZMi/wktbl595QZG/IK1t7JZhdVLWuvU5BoBgG+TrXx5wBIGqR2nNCxUkd9vJrHGAcVHA
 PWXtYS2eIgE/YRm1vMk3zk/N0v8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 61b0a797642caac31880dfe8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 08 Dec 2021 12:39:51
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82281C4360C; Wed,  8 Dec 2021 12:39:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4942C4338F;
        Wed,  8 Dec 2021 12:39:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Dec 2021 18:09:49 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: Re: [PATCH 12/12] ath11k: Change QCN9074 firmware to operate in
 mode-2
In-Reply-To: <871r3lkcqc.fsf@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
 <20210721212029.142388-12-jouni@codeaurora.org>
 <871r3lkcqc.fsf@codeaurora.org>
Message-ID: <2918b38bca0d8d1fac8f1edabe5ecce0@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-12 13:49, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Seevalamuthu Mariappan <seevalam@codeaurora.org>
>> 
>> In mode-2 QCN9074 firmware uses 15 MB of host memory and firmware
>> request 1 MB size segments in QMI, whereas in mode-0 firmware uses 45 
>> MB
>> of host memory and each segment is of 2 MB size. In mode-2 firmware
>> operates with reduced number of vdevs and peers.
>> 
>> Tested-on: QCN9074 hw1.0 PCI 
>> WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
>> Co-developed-by: Anilkumar Kolli <akolli@codeaurora.org>
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath11k/core.c | 23 ++++++++++++++++++++++-
>>  drivers/net/wireless/ath/ath11k/core.h |  6 ++++++
>>  drivers/net/wireless/ath/ath11k/hw.c   | 14 +++++++-------
>>  drivers/net/wireless/ath/ath11k/hw.h   | 20 +++++++++++---------
>>  drivers/net/wireless/ath/ath11k/mac.c  | 10 +++++-----
>>  drivers/net/wireless/ath/ath11k/qmi.c  |  2 +-
>>  6 files changed, 52 insertions(+), 23 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c 
>> b/drivers/net/wireless/ath/ath11k/core.c
>> index d2ab3b134632..9f2c9795767e 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -77,6 +77,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  		.supports_shadow_regs = false,
>>  		.idle_ps = false,
>>  		.cold_boot_calib = true,
>> +		.fw_mem_mode = 0,
>>  		.supports_suspend = false,
>>  		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
>>  		.fix_l1ss = true,
> 
> [...]
> 
>> +static const struct ath11k_num_vdevs_peers ath11k_vdevs_peers[] = {
>> +	{
>> +		.num_vdevs = (16 + 1),
>> +		.num_peers = 512,
>> +	},
>> +	{
>> +		.num_vdevs = (8 + 1),
>> +		.num_peers = 128,
>> +	},
>> +	{
>> +		.num_vdevs = 8,
>> +		.num_peers = 128,
>> +	},
>> +};
> 
> I am worried about this array. It implies that _all_ hardware support
> these modes but is that really the case? I would guess that these are
> very much hardware and firmware specific values.
> 
> So because of that I would feel clearer to have num_vdevs and num_peers
> in ath11k_hw_params, to make it clear that the values are hardware
> specific. And then have fw_mem_mode, num_vdevs and num_peers in their
> own struct within struct ath11k_hw_params, just like spectral has
> grouped valued together.
> 

Sorry for the delayed response. I will make num_vdevs and num_peers part 
of hw_params.
and post next version.

Thanks
Anil
