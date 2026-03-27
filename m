Return-Path: <linux-wireless+bounces-34027-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI+KJ83zxWnbEgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34027-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 04:04:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F120D33EA41
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 04:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8131930078DF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 02:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C621F9F7A;
	Fri, 27 Mar 2026 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MB+ZRLJd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hz6LJec7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7231F982
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580057; cv=none; b=TTfsOAY62KOhFwSIeQgBcPFDho4p/SAy6Xd4Mx1MIqY2zb2rGzRAkX5xZbBfOTmYBo8/OmCo9nZP8ZY4kD4ny1i3Q6lItiWPuJf317KRFy3/qm6Ieew8G7SEE02h1xnGXMsG95XrhlZPv0pV03X1RRaLwzmjXOT2g7zbUZ9Cvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580057; c=relaxed/simple;
	bh=AUWmmdc2m9h2FA9JffWtTwohq/32pT3HwcYrhDhck28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlbTXg6jyJSaAdA6CeNagseWBZlelSOjrB760TurDC4XyxD7Og8swCfyR3Fd0QDs3wgS8rIrSvao9vffpHZCNhzD1ruj3qfE1bjpwjg1isqkDYMsTjLz0+FYZjoykDTJYP6Sqaz95HIKqe6Ke7n8BcwH0kmhYGGEL17oBpULbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MB+ZRLJd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hz6LJec7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QMD54K2584764
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 02:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dBu33MtmGdnbpd1MrIxjWk6xCAYbN7QbGKHAkXreDX4=; b=MB+ZRLJdbe1gERQh
	NpCJDU9U5VgacYBeIALXVNar0VTJJPbfPobJu9UzY5c5JRS0tf8sknWhiZa7sHff
	Ko/mXQ/zZxZhsgbSGa2RmZKmsqd3vxJwyIJt0bhFl6JFK750HmJm9EzNrf39aP+2
	pPzrEZhhRQWpkRkSp0IgaReroZxSFMYrnedAEay2LSBCJF+N4oHhW6lErCu1k3K6
	EtiFNEyItSIJkEwEq4j71QHfZKHaVKI/quLPfdIUHJB2gGwFWLCYPvEgyMAJ+h94
	+VCFNSjaFWS9S4Pdg9Nnm4aOSXyeVUnheA1/DYr2oCdcdhwSIdftlo5ajcw+G6j2
	SKEUqQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5dd6gnny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 02:54:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c76666c3ec2so1105825a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 19:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774580054; x=1775184854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBu33MtmGdnbpd1MrIxjWk6xCAYbN7QbGKHAkXreDX4=;
        b=Hz6LJec7fvXs/FjlHDrOkTbMeyrbcNx7xWaUrvRy51tISaI23aUJxrLvLMDjo3EmmB
         Bv+avKuynMC/qRJSPK3BWXdVkodmn4q6rhrucp6nx0XOyUbNw7mwVheKKPc3PZXKaVAw
         4Z9Qhb4gObjJFwORN9jQq3ozWDYyeiqrKNVUuFYJnVKgv/cDC4c1BOcEKMNF+qE9nNVo
         9SSNzqg5MUi+QnCM5YPHVuoBDpO6B3LHbXnShMqSBMdg7tgDN8jQApxQJx8seFYhCdRa
         Jf5uNIKKS9DG6IkeO4CD9LLOUtXgvH6k+clJy5Fl9CUNzE+b3+9MbEu+rQ2O3TiEKr8J
         JrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580054; x=1775184854;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBu33MtmGdnbpd1MrIxjWk6xCAYbN7QbGKHAkXreDX4=;
        b=SqxsTatSbcYvCKMP25W44frQWXJR6nxFq9f5bBSIbTxSo+4ozv5i901WF90VIAhhmS
         bVzPLs8lgVOP0oCvYPBicfAkeq1etALfo7D7D9yE+90ED5jdismY4aZH0uLDkCg13E/w
         7WBABqAM0k8vs7UrFtFh0+7Bp3s7Vmxbn5I1Lu7bLGq7kfgTyhjekFwD9cpnWychNutB
         +LaShymyd7Bt3mtNylGER63gtzLrobEAoIOAFjHc3mm8z79wat8MFSib+zOnFCNcblCh
         MIY9WJ2Zi46QRSGoJlOPNbBRUs3KNXTriZrorUPHozQxmkJiLgR2UwS02ND7GpnxQPyP
         m4rg==
X-Gm-Message-State: AOJu0YxKZvk7zw3okonJ+7tQ6xNi2HpTih6pdlun2m5zrqDFLbm7QhHZ
	UuNrtmAq1+YzTaoAILsmmMUbEe43FNT0+hOmucOxuxbj7DJ9xTfXJq+AUEN/kaQ+PwrRLxmZ9a8
	5H0+M0ECOHk/6Z389yEdISoKkYj2X2peqbrgu3+aP5R0FqTrTSkrnKmIcbrr2vrwJsI/j6+SQkD
	otJg==
X-Gm-Gg: ATEYQzzBVDSY4pafbtt1RJQY0N3G+Ir/0NZ/612q4O+XoaPMGCYw/V5KhxhwXJzDQXl
	jCge6A6LWNv3Kxvov5T2xExTzZLZ0jvKwHOOeWLVQ2fwAzuY5nZ3lS9KiEelmYztvAt3Q9bDzNd
	UW9mcNNV7WE55+dngvdDqJJmwcHkw6sM2bBuIuU5MsaWKQy/PeLEQGqJi/UYjq1H+z7NKDIirF9
	IQ6ahwE4COWph9dceeLJu/bCXrJJ/5cFe9hCOwSBbuiRDf0ens5q+Uu4K1yEstUSoGiQLUvsJg3
	GpWY1q++h/BKT6/uddMA86EK6AP5qVwPZhrlsDeQUYIp+kJJbZ135KEMr5puXvRVUTQCdyM1uet
	QGKOkWtPyhgKwhc0gx6VXNbtbrjsNOPkWHHW0LV6E5Y8JI1gJfipkYZL8XMZ6hcMHelwIXly++P
	ck+GsmYCw0eBxh/LqZUbA=
X-Received: by 2002:a17:90b:38cf:b0:35b:e4f8:7cc7 with SMTP id 98e67ed59e1d1-35c300b9806mr899224a91.17.1774580053602;
        Thu, 26 Mar 2026 19:54:13 -0700 (PDT)
X-Received: by 2002:a17:90b:38cf:b0:35b:e4f8:7cc7 with SMTP id 98e67ed59e1d1-35c300b9806mr899199a91.17.1774580052985;
        Thu, 26 Mar 2026 19:54:12 -0700 (PDT)
Received: from [10.133.33.186] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a52afdsm2856268a91.1.2026.03.26.19.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 19:54:12 -0700 (PDT)
Message-ID: <5033b613-3514-4686-895f-75bb8f523303@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 10:54:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath10k: fix station lookup failure
 during disconnect
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
 <7af13762-3e98-4d77-bde2-c14cdb3b1e3c@molgen.mpg.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7af13762-3e98-4d77-bde2-c14cdb3b1e3c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NenrFmD4 c=1 sm=1 tr=0 ts=69c5f157 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=l6r93IW1dCNhaczwAn0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 6Bw_bfUmwlEcPIGMUREozL57BEx4FqS5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAyMCBTYWx0ZWRfX/tqfoHQEyEbs
 06an56VolH1dTPdkTrOyONyU1HAG+5TUWVpBnqYAHljTrtCp2Lvf3GSD7WLGJuOP+H1D8oFSvlG
 K/x+Uhhln0ZupbJTdzl8JJ749T79BDwYA3BGY/iw0SpeeU3hwW1jy2Kuv0G2Ob3ugdEfZ1jCY8r
 XZK7JGSyUaCTczqQEMB1vYA5IdG2WIeOQeNsXVSavd3BaueTsnPsLC8IFKYRDL5Arww6JEJiuaq
 oIc/CiB1pY7ppe2XDY5hv3Fvm6QSUM1gPsfAy+oYQwQAeR3bs8EGTh9u/tLzQQQ/bvwZrWlPic5
 BRIB9vbbOIZAFx0kx6y2EbA8WdI9khe8B9cPYEbWdahHrpLzGd5MLOEjU5zDfZEdPhTYPjBb6Zn
 wNxlyZMKlSFsYO264AUmVonpoQOSSpQZYQ04pUK9KSTGunyGCFsCyaLSUDtqYTBAy2pDWKMVuAG
 gaOVGIPhTCUfIxLZGdA==
X-Proofpoint-ORIG-GUID: 6Bw_bfUmwlEcPIGMUREozL57BEx4FqS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270020
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34027-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,mpg.de:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F120D33EA41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/2026 7:31 AM, Paul Menzel wrote:
> Dear Baochen,
> 
> 
> Thank you for sending the patch out.
> 
> Am 25.03.26 um 04:05 schrieb Baochen Qiang:
>> Recent commit [1] moved station statistics collection to an earlier stage
>> of the disconnect flow. With this change in place, ath10k fails to resolve
>> the station entry when handling a peer stats event triggered during
>> disconnect, resulting in log messages such as:
>>
>> wlp58s0: deauthenticating from 74:1a:e0:e7:b4:c8 by local choice (Reason: 3=DEAUTH_LEAVING)
>> ath10k_pci 0000:3a:00.0: not found station for peer stats
>> ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
>>
>> The failure occurs because ath10k relies on ieee80211_find_sta_by_ifaddr()
>> for station lookup. That function uses local->sta_hash, but by the time
>> the peer stats request is triggered during disconnect, mac80211 has
>> already removed the station from that hash table, leading to lookup
>> failure.
>>
>> Before commit [1], this issue was not visible because the transition from
>> IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST prevented ath10k from sending
>> a peer stats request at all: ath10k_mac_sta_get_peer_stats_info() would
>> fail early to find the peer and skip requesting statistics.
>>
>> Fix this by switching the lookup path to ath10k_peer_find(), which queries
>> ath10k's internal peer table. At the point where the firmware emits the
>> peer stats event, the peer entry is still present in the driver's list,
>> ensuring lookup succeeds.
> 
> Out of curiosity, how can the statistics be printed?

not quite understand your question, can you be more detailed ?

> 
>> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
>>
>> Fixes: a203dbeeca15 ("wifi: mac80211: collect station statistics earlier when
>> disconnect") # [1]
>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Closes: https://lore.kernel.org/ath10k/57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de
>> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath10k/wmi-tlv.c | 26 +++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/
>> ath10k/wmi-tlv.c
>> index ec8e91707f84..01f2d1fa9d7d 100644
>> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> @@ -3,7 +3,7 @@
>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>   #include "core.h"
>>   #include "debug.h"
>> @@ -14,6 +14,7 @@
>>   #include "wmi-tlv.h"
>>   #include "p2p.h"
>>   #include "testmode.h"
>> +#include "txrx.h"
>>   #include <linux/bitfield.h>
>>     /***************/
>> @@ -224,8 +225,9 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar,
>> u16 tag, u16
>>                           const void *ptr, void *data)
>>   {
>>       const struct wmi_tlv_peer_stats_info *stat = ptr;
>> -    struct ieee80211_sta *sta;
>> +    u32 vdev_id = *(u32 *)data;
>>       struct ath10k_sta *arsta;
>> +    struct ath10k_peer *peer;
>>         if (tag != WMI_TLV_TAG_STRUCT_PEER_STATS_INFO)
>>           return -EPROTO;
>> @@ -241,20 +243,20 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar,
>> u16 tag, u16
>>              __le32_to_cpu(stat->last_tx_rate_code),
>>              __le32_to_cpu(stat->last_tx_bitrate_kbps));
>>   -    rcu_read_lock();
>> -    sta = ieee80211_find_sta_by_ifaddr(ar->hw, stat->peer_macaddr.addr, NULL);
>> -    if (!sta) {
>> -        rcu_read_unlock();
>> -        ath10k_warn(ar, "not found station for peer stats\n");
>> +    guard(spinlock_bh)(&ar->data_lock);
>> +
>> +    peer = ath10k_peer_find(ar, vdev_id, stat->peer_macaddr.addr);
>> +    if (!peer || !peer->sta) {
>> +        ath10k_warn(ar, "not found %s with vdev id %u mac addr %pM for peer stats\n",
>> +                peer ? "sta" : "peer", vdev_id, stat->peer_macaddr.addr);
>>           return -EINVAL;
>>       }
>>   -    arsta = (struct ath10k_sta *)sta->drv_priv;
>> +    arsta = (struct ath10k_sta *)peer->sta->drv_priv;
>>       arsta->rx_rate_code = __le32_to_cpu(stat->last_rx_rate_code);
>>       arsta->rx_bitrate_kbps = __le32_to_cpu(stat->last_rx_bitrate_kbps);
>>       arsta->tx_rate_code = __le32_to_cpu(stat->last_tx_rate_code);
>>       arsta->tx_bitrate_kbps = __le32_to_cpu(stat->last_tx_bitrate_kbps);
>> -    rcu_read_unlock();
>>         return 0;
>>   }
>> @@ -266,6 +268,7 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
>>       const struct wmi_tlv_peer_stats_info_ev *ev;
>>       const void *data;
>>       u32 num_peer_stats;
>> +    u32 vdev_id;
>>       int ret;
>>         tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
>> @@ -284,15 +287,16 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
>>       }
>>         num_peer_stats = __le32_to_cpu(ev->num_peers);
>> +    vdev_id = __le32_to_cpu(ev->vdev_id);
>>         ath10k_dbg(ar, ATH10K_DBG_WMI,
>>              "wmi tlv peer stats info update peer vdev id %d peers %i more data %d\n",
>> -           __le32_to_cpu(ev->vdev_id),
>> +           vdev_id,
>>              num_peer_stats,
>>              __le32_to_cpu(ev->more_data));
>>         ret = ath10k_wmi_tlv_iter(ar, data, ath10k_wmi_tlv_len(data),
>> -                  ath10k_wmi_tlv_parse_peer_stats_info, NULL);
>> +                  ath10k_wmi_tlv_parse_peer_stats_info, &vdev_id);
>>       if (ret)
>>           ath10k_warn(ar, "failed to parse stats info tlv: %d\n", ret);
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul


