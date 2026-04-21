Return-Path: <linux-wireless+bounces-35116-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I9LeESAP52ms3QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35116-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 07:46:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E390F436890
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 07:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B493009B2F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 05:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83232D0CC;
	Tue, 21 Apr 2026 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="lNx6Fzxa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959A1E885A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750364; cv=none; b=j7nj0JTrflf9ucChZsZqtm/dxh0ccXbE9EZf6B6xirJVtVBMDiGCz1WvZIVpTzcUya57HsghARjyufE7WNc1AT5zf8ZKiaxsAoVTYxpg9nsG5OOSEpEKqz/NLrKPkZT7m0wlojnQ2qx4VhZD1WNvpFH17ay9Jv01gpWxIfOcPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750364; c=relaxed/simple;
	bh=ugc6+ZYGJyMCOUkhMb6FWkMm6dpDUkzS58ll+uEljko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdvKBwA7DywuuS8ywPE2nOPFty13lda0Ju6wP1+BsuTLQd+14t8c2QxkVbYSLJEGZmgNOv5WL8gsF7P4+fnbkZP4FAsUDOG+xqX68i84cBmCF91EfY8ZYMZuOTtCtR01MXbAonHihQFiScddMQLBKA5HZArth2JtD6CaIdEWtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=lNx6Fzxa; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id F0QGwyG2yc9KCF3vnwlfJ9; Tue, 21 Apr 2026 05:45:55 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id F3vmwzGPweVHCF3vmwsiUe; Tue, 21 Apr 2026 05:45:54 +0000
X-Authority-Analysis: v=2.4 cv=TfSWtQQh c=1 sm=1 tr=0 ts=69e70f12
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=BW2cartU-NgVh40cIl0A:9
 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k2MujxfBQqzgiiXQDSt6oAK7PDUCOtwHcqJ4Zb7jY+Q=; b=lNx6Fzxa2OtxX8oxQ8tkG0Jm6I
	BDArh2UzLFuoRAH0cFfrRqN61RBcnXDH/4cBIziLdh7CHgDgqnTUB8QRmdX42kEGovwUMoWv1W3eM
	NraZM1HrIbBJ05Avu/DGymTgIHKu4FxW5nmgrthwdrFwqgLE6zcvtajuyBtjs9FSq1aUpc0CvRY3i
	Zxg1e8tmTlwL8uS02gvSNre/rpXy/3+VMvLZW4kwnT480tc1R+S371sXfVRAoI64+NSG9lvB6KHtV
	J06RT/9IlW9N/V5rE3DIITJfm4Jd7nus/2BCyEL450r7k8stqQQSupbzaOZBs/dK5PJVRYp2cXpxa
	o5XkBoJA==;
Received: from [177.238.16.218] (port=36590 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wF3vl-00000003Qw0-0Sff;
	Tue, 21 Apr 2026 00:45:53 -0500
Message-ID: <2650bb0e-804d-4858-a07f-c4190fb41038@embeddedor.com>
Date: Mon, 20 Apr 2026 23:44:37 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: use kzalloc_flex
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:QUALCOMM ATH12K WIRELESS DRIVER" <ath12k@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260313001434.118010-1-rosenp@gmail.com>
 <a92cb332-b525-47f4-a529-a59080cb33dd@oss.qualcomm.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <a92cb332-b525-47f4-a529-a59080cb33dd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.218
X-Source-L: No
X-Exim-ID: 1wF3vl-00000003Qw0-0Sff
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.218]:36590
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPsgDBMxmuVqcHocS2xXRnpLFWepXzKuxZ3WrT8Wr+svyquRN+F0xxfcs7uqNGRWdKjXe1kfU7u45Y+1GqCUgy9DY75ezVeMmM6kRlAYH3Xc88H+OUFY
 wT3bjU7iaIObdV3Wq5hMDrAxry8XU1tN3LGMqEQkmsANrHAWDSy9M8p08x7k6I9D5kMOvAjFaG8LgX9e4bR22jhDJdw8GfMXQx4F75cihIvTWszjfuKZfV0V
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_SOURCE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35116-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[embeddedor.com];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,vger.kernel.org];
	HAS_X_ANTIABUSE(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E390F436890
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/20/26 20:53, Baochen Qiang wrote:
> 
> 
> On 3/13/2026 8:14 AM, Rosen Penev wrote:
>> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
>>
>> Add __counted_by to get extra runtime analysis. 

>> Move counting variable
>> assignment immediately after allocation as required by __counted_by.

Not true. This should be phrased differently[1]

-Gustavo

[1] https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com/

>>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 29 +++++++--------------------
>>   drivers/net/wireless/ath/ath12k/wmi.h |  2 +-
>>   2 files changed, 8 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 553ec28b6aaa..b7c43a64e37b 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -5611,12 +5611,14 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>>   	if (ret)
>>   		goto exit;
>>
>> -	arg = kzalloc_obj(*arg);
>> +	arg = kzalloc_flex(*arg, chan_list, n_channels);
>>   	if (!arg) {
>>   		ret = -ENOMEM;
>>   		goto exit;
>>   	}
>>
>> +	arg->num_chan = n_channels;
>> +
>>   	ath12k_wmi_start_scan_init(ar, arg);
>>   	arg->vdev_id = arvif->vdev_id;
>>   	arg->scan_id = ATH12K_SCAN_ID;
>> @@ -5638,18 +5640,8 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>>   		arg->scan_f_passive = 1;
>>   	}
>>
>> -	if (n_channels) {
>> -		arg->num_chan = n_channels;
>> -		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
>> -					 GFP_KERNEL);
>> -		if (!arg->chan_list) {
>> -			ret = -ENOMEM;
>> -			goto exit;
>> -		}
>> -
>> -		for (i = 0; i < arg->num_chan; i++)
>> -			arg->chan_list[i] = chan_list[i]->center_freq;
>> -	}
>> +	for (i = 0; i < arg->num_chan; i++)
>> +		arg->chan_list[i] = chan_list[i]->center_freq;
>>
>>   	ret = ath12k_start_scan(ar, arg);
>>   	if (ret) {
>> @@ -5674,7 +5666,6 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>>
>>   exit:
>>   	if (arg) {
>> -		kfree(arg->chan_list);
>>   		kfree(arg->extraie.ptr);
>>   		kfree(arg);
>>   	}
>> @@ -13735,19 +13726,13 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>>   	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;
>>
>>   	struct ath12k_wmi_scan_req_arg *arg __free(kfree) =
>> -					kzalloc_obj(*arg);
>> +					kzalloc_flex(*arg, chan_list, 1);
>>   	if (!arg)
>>   		return -ENOMEM;
>>
>> -	ath12k_wmi_start_scan_init(ar, arg);
>>   	arg->num_chan = 1;
>> +	ath12k_wmi_start_scan_init(ar, arg);
>>
>> -	u32 *chan_list __free(kfree) = kcalloc(arg->num_chan, sizeof(*chan_list),
>> -					       GFP_KERNEL);
>> -	if (!chan_list)
>> -		return -ENOMEM;
>> -
>> -	arg->chan_list = chan_list;
>>   	arg->vdev_id = arvif->vdev_id;
>>   	arg->scan_id = ATH12K_SCAN_ID;
>>   	arg->chan_list[0] = chan->center_freq;
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
>> index 0bf0a7941cd3..190e7a4a92d0 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
>> @@ -3586,7 +3586,6 @@ struct ath12k_wmi_scan_req_arg {
>>   	u32 num_bssid;
>>   	u32 num_ssids;
>>   	u32 n_probes;
>> -	u32 *chan_list;
>>   	u32 notify_scan_events;
>>   	struct cfg80211_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
>>   	struct ath12k_wmi_mac_addr_params bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
>> @@ -3595,6 +3594,7 @@ struct ath12k_wmi_scan_req_arg {
>>   	u32 num_hint_bssid;
>>   	struct ath12k_wmi_hint_short_ssid_arg hint_s_ssid[WLAN_SCAN_MAX_HINT_S_SSID];
>>   	struct ath12k_wmi_hint_bssid_arg hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
>> +	u32 chan_list[] __counted_by(num_chan);
>>   };
>>
>>   struct wmi_ssid_arg {
>> --
>> 2.53.0
>>
>>
> 
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> 
> 


