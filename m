Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11A418E5D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 06:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhI0Edy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 00:33:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53858 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhI0Edy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 00:33:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632717137; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JUvQW6LMLvc2XLMOLos8ZnrwmTTpDeLp9y6A5dmUXok=;
 b=lm/G0To4N196DHU+nnCCOEgX2foywuUwNVbtgeX5Ar6SxY+ZkG+mLXJzJCxFGvQ07QyLjU0A
 OSXh573mVIPGYWuwtLX0ejJLM+uxdamgqt7tiKTLGZUAyFGbDRtVsly/fcukAaH9x611NITY
 4puP66h+Z25cv/BjMYh9wkaFSj4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6151493e5f16bce668f141d9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Sep 2021 04:31:58
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82784C4360C; Mon, 27 Sep 2021 04:31:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9D7AC4338F;
        Mon, 27 Sep 2021 04:31:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Sep 2021 10:01:56 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] ath11k: add htt cmd to enable full monitor mode
In-Reply-To: <87ilyqrsgt.fsf@codeaurora.org>
References: <20210721171905.61838-1-jouni@codeaurora.org>
 <20210721171905.61838-2-jouni@codeaurora.org>
 <87ilyqrsgt.fsf@codeaurora.org>
Message-ID: <f488dec59dbc92e21e231343f798a29c@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-24 19:22, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Anilkumar Kolli <akolli@codeaurora.org>
>> 
>> Add a new hw_param full_monitor_mode to enable full monitor support 
>> for
>> QCN9074. HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to the
>> firmware to enable the full monitor mode.
>> 
>> Tested-on: QCN9074 hw1.0 PCI 
>> WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath11k/core.c  |  4 ++
>>  drivers/net/wireless/ath/ath11k/dp.h    | 74 
>> +++++++++++++++++++++++++
>>  drivers/net/wireless/ath/ath11k/dp_tx.c | 48 ++++++++++++++++
>>  drivers/net/wireless/ath/ath11k/dp_tx.h |  2 +
>>  drivers/net/wireless/ath/ath11k/hw.h    |  1 +
>>  5 files changed, 129 insertions(+)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c 
>> b/drivers/net/wireless/ath/ath11k/core.c
>> index 969bf1a590d9..3179495cb3c9 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -65,6 +65,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  					BIT(NL80211_IFTYPE_AP) |
>>  					BIT(NL80211_IFTYPE_MESH_POINT),
>>  		.supports_monitor = true,
>> +		.full_monitor_mode = false,
>>  		.supports_shadow_regs = false,
>>  		.idle_ps = false,
>>  		.cold_boot_calib = true,
>> @@ -106,6 +107,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  					BIT(NL80211_IFTYPE_AP) |
>>  					BIT(NL80211_IFTYPE_MESH_POINT),
>>  		.supports_monitor = true,
>> +		.full_monitor_mode = false,
>>  		.supports_shadow_regs = false,
>>  		.idle_ps = false,
>>  		.cold_boot_calib = true,
>> @@ -146,6 +148,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>>  					BIT(NL80211_IFTYPE_AP),
>>  		.supports_monitor = false,
>> +		.full_monitor_mode = false,
>>  		.supports_shadow_regs = true,
>>  		.idle_ps = true,
>>  		.cold_boot_calib = false,
>> @@ -184,6 +187,7 @@ static const struct ath11k_hw_params 
>> ath11k_hw_params[] = {
>>  					BIT(NL80211_IFTYPE_AP) |
>>  					BIT(NL80211_IFTYPE_MESH_POINT),
>>  		.supports_monitor = true,
>> +		.full_monitor_mode = true,
>>  		.supports_shadow_regs = false,
>>  		.idle_ps = false,
>>  		.cold_boot_calib = false,
> 
> wcn6855 was not updated, I added that.
> 

Thanks. 'full_monitor_mode = false' to be added.

>> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
>> @@ -1034,6 +1034,15 @@ int 
>> ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool 
>> reset)
>>  	struct htt_rx_ring_tlv_filter tlv_filter = {0};
>>  	int ret = 0, ring_id = 0, i;
>> 
>> +	if (ab->hw_params.full_monitor_mode) {
>> +		ret = ath11k_dp_tx_htt_rx_full_mon_setup(ab,
>> +							 dp->mac_id, !reset);
>> +		if (ret < 0) {
>> +			ath11k_err(ab, "failed to setup full monitor %d\n", ret);
> 
> I changed this to:
> 
> 		if (ret) {
> 			ath11k_warn(ab, "failed to setup full monitor: %d\n", ret);
> 			return ret;
> 		}

Thanks.
-- 
- Anil.
