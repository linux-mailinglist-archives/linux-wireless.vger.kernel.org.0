Return-Path: <linux-wireless+bounces-11260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E394DD82
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2AA2822B3
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC851662E4;
	Sat, 10 Aug 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="F2HFU594"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DF15AAB8
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723304506; cv=none; b=qA9xtmfu5lfD9fTHNtjVrcBKnIKyaano1kvQOkvu8vuu72IrXQXV+9HIlKlTL/i1SF0DQr416KRMVs0v2ji0EaGDBF75jhCrq95Z5IHCWGZ3w57qfqaasqBQg4HzlK0j4DlZL53U0VDIeZLxu0ItUbujRfopMsJY9i7f80TwYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723304506; c=relaxed/simple;
	bh=o62VIjOPLALNmxGLCiVL2Zsve94rbDHXk3qMOQbZyAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+8FHdgnQ5HD/jGM14bKYhuHVk7/dj3b3S0JEvUps9DOOCNfroOTIK9z8cyX8V6t+/WnphPnNhpmy4dx3PMGKeY/Z2jUtyZCYu3kfUuwaRgCrusri0o9C1AYiGe/8Pi0ZT9F3ONt1IzZpYPEFEohbYpOpkKf+PD1IEUOqCmNNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=F2HFU594; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id cnpBsy1Dj1zuHcoDpssxtQ; Sat, 10 Aug 2024 15:41:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id coDosZ6SdRBkMcoDosLMQm; Sat, 10 Aug 2024 15:41:36 +0000
X-Authority-Analysis: v=2.4 cv=CbPD56rl c=1 sm=1 tr=0 ts=66b78a30
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=oKrQ66Li5qe5zRcEOgYA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=TjNXssC_j7lpFel5tvFf:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=14Lw9ijUqufXCJHVSEUKjfux6K/+0xEy2ibtU/QVJd8=; b=F2HFU5946l41S5Ql/lZv+emjHf
	ihq/ln7mxZ3Ajr7RrEC1PZqsp/JTcThniZQYIlTcFNjZoKfLOVAD8aAvRuIl7SYlBRXSTZ6GYZsw8
	hyCCR6F9wdJyNpkJpehoNtFGNMaOX7I1mLUXXndfIuIrbD+pHwalT8NR6tbxJgLH/20UHucLJKghI
	NEqSTKA4YcQUDnO3Cdi+yriIdP6bzIXaOPTOKqRYswV2vwybfuFJtTPINxRtREZHWBWwzNLm7SCZM
	R0Mu4OIC7w+57NpqRUbpqee03nO2sXMe1+ykVCwacuboFak6O+bvUk2xCLDsm1034geEwOQmOnbTU
	9vA7XxSQ==;
Received: from [201.172.173.139] (port=52890 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1scoDm-0032aY-2q;
	Sat, 10 Aug 2024 10:41:35 -0500
Message-ID: <0070b332-b617-4454-ac7b-85b1d78fef68@embeddedor.com>
Date: Sat, 10 Aug 2024 09:41:29 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: ath11k: Avoid -Wflex-array-member-not-at-end
 warnings
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZrZB3Rjswe0ZXtug@cute>
 <8d31adac-fd43-4cf9-8fc8-655b359a573c@quicinc.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <8d31adac-fd43-4cf9-8fc8-655b359a573c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1scoDm-0032aY-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:52890
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMvC1G8qKozlrFGPEGMShNGzyyKKs5rvjA6cdZ+SYE0P363WFoo/i5wFQgUe3QuVhE/6YPVN6Xf2C84HNio7a5wzG9oB7VHSyOviGsDAiblpkMJWjrDE
 01NjtlLNd7N84TaDlYy2KVv6lm6uUajmR7aEbA0AQzxYMBR1VpcAhxpYtgzb567QWXTBxFw4PmeDT4AQOy0shVqPHplKkTPBLgc5hpSHUbJ027BO5bKvitTh



On 09/08/24 20:21, Jeff Johnson wrote:
> On 8/9/2024 9:20 AM, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the structure. Notice
>> that `struct ieee80211_chanctx_conf` is a flexible structure --a
>> structure that contains a flexible-array member.
>>
>> Also, remove a couple of unused structures.
>>
>> Fix the following warnings:
>> drivers/net/wireless/ath/ath11k/core.h:409:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/net/wireless/ath/ath11k/dp.h:1309:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/net/wireless/ath/ath11k/dp.h:1368:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/net/wireless/ath/ath11k/core.h |  4 +++-
>>   drivers/net/wireless/ath/ath11k/dp.h   | 23 -----------------------
>>   2 files changed, 3 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
>> index df24f0e409af..e283415dccf3 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.h
>> +++ b/drivers/net/wireless/ath/ath11k/core.h
>> @@ -406,11 +406,13 @@ struct ath11k_vif {
>>   	bool wpaie_present;
>>   	bool bcca_zero_sent;
>>   	bool do_not_send_tmpl;
>> -	struct ieee80211_chanctx_conf chanctx;
>>   	struct ath11k_arp_ns_offload arp_ns_offload;
>>   	struct ath11k_rekey_data rekey_data;
>>   
>>   	struct ath11k_reg_tpc_power_info reg_tpc_info;
>> +
>> +	/* Must be last - ends in a flexible-array member. */
>> +	struct ieee80211_chanctx_conf chanctx;
> 
> there is something illogical about this since the vif is allocated using
> sizeof() and hence there will never be memory allocated for the flexible
> array, and it is assigned using either struct assignment or memcpy using the
> struct size which (fortunately) would not transfer the flexible array contents:
> 		arvif->chanctx = *ctx;
> 
> 		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));

Yes; this is why I didn't include a 'Fixes' tag.

In any case, middle-flex-arrays are deprecated and should either be
removed/refactored[1][2] or placed at the very bottom in any nested
structures. :)

> 
> since ath11k doesn't actually use the drv_priv[] I guess this change is OK, it
> is just strange to me.
> 
> also makes me wonder why ath11k keeps a copy of the chanctx instead of just
> getting it from the underlying ieee80211_link_data. but that is outside the
> scope of this discussion.
> 
>>   };
>>   
>>   struct ath11k_vif_iter {
>> diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
>> index 2f6dd69d3be2..65d2bc0687c8 100644
>> --- a/drivers/net/wireless/ath/ath11k/dp.h
>> +++ b/drivers/net/wireless/ath/ath11k/dp.h
>> @@ -1305,18 +1305,6 @@ struct htt_ppdu_stats_user_rate {
>>   #define HTT_TX_INFO_PEERID(_flags) \
>>   			FIELD_GET(HTT_PPDU_STATS_TX_INFO_FLAGS_PEERID_M, _flags)
>>   
>> -struct htt_tx_ppdu_stats_info {
>> -	struct htt_tlv tlv_hdr;
>> -	u32 tx_success_bytes;
>> -	u32 tx_retry_bytes;
>> -	u32 tx_failed_bytes;
>> -	u32 flags; /* %HTT_PPDU_STATS_TX_INFO_FLAGS_ */
>> -	u16 tx_success_msdus;
>> -	u16 tx_retry_msdus;
>> -	u16 tx_failed_msdus;
>> -	u16 tx_duration; /* united in us */
>> -} __packed;
>> -
>>   enum  htt_ppdu_stats_usr_compln_status {
>>   	HTT_PPDU_STATS_USER_STATUS_OK,
>>   	HTT_PPDU_STATS_USER_STATUS_FILTERED,
>> @@ -1364,17 +1352,6 @@ struct htt_ppdu_stats_usr_cmpltn_ack_ba_status {
>>   	u32 success_bytes;
>>   } __packed;
>>   
>> -struct htt_ppdu_stats_usr_cmn_array {
>> -	struct htt_tlv tlv_hdr;
>> -	u32 num_ppdu_stats;
>> -	/* tx_ppdu_stats_info is filled by multiple struct htt_tx_ppdu_stats_info
>> -	 * elements.
>> -	 * tx_ppdu_stats_info is variable length, with length =
>> -	 *     number_of_ppdu_stats * sizeof (struct htt_tx_ppdu_stats_info)
>> -	 */
>> -	struct htt_tx_ppdu_stats_info tx_ppdu_info[];
>> -} __packed;
>> -
>>   struct htt_ppdu_user_stats {
>>   	u16 peer_id;
>>   	u32 tlv_flags;
> 
> the second part if definitely ok.
> 
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/ZrOQa2gew5yadyt3@cute/
[2] https://lore.kernel.org/linux-hardening/ZrJqtUpCI+uCeb4D@cute/

