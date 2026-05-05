Return-Path: <linux-wireless+bounces-35945-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHLII68n+mmHKQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35945-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:23:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E99974D1FC5
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7821C303CE19
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBDA3E929C;
	Tue,  5 May 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSJfHgz3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cE0cH8YA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021447DFAB
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001764; cv=none; b=JJ4RBn+8v4xd+6t6EfwAJMJ8IQ+xH2/cIIFh1WAt5T6sW0G/IcRqG/So9+EuQ+O8I01UvXW8PCxX190iydswzntjsAKJ8o1WmKkMKl1J4Bx065Pv00VymbPWlTYNhIcQUnNUpULGJf5/8+jNg5AUGSFCg+73iCsdVwjjHCxNwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001764; c=relaxed/simple;
	bh=RW+K6ZCFNsazpLiODhzyh4vid0CptHGnLwNZ8agsorM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fk1X9enhb6jJ+pXHKhWgRP5hfsboaPrmv+HkAfBOULyqVaFQAZ9kS/VYHSH474hK7zJ40Hb9l8XtfG0lvntbZEFCy0seC1o6hApVYsnwhhb5E7+DMOWVnly2bALa4RYyUF6F9RN65asewa/tbOP2567LtTb+nTjeZpaELvXHCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SSJfHgz3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cE0cH8YA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EK0po912107
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 17:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6LpmOdSwKqZjJwQwTl0UCBPLiRs17tqnTcHQ78riYdc=; b=SSJfHgz3npZPUwnR
	iitgS6O8cHo5IcsljbxSZQRjY3eZVXU7UCGNBvSQJAF598F3T5c53BOwDUHN0bce
	a6kK1nswJu6ix+YMBPEcx6wf1GhXwIl4yqWs6Rca4mb1lt7nOrfp7/krMb6Cc3Qo
	7tOywxbSESBaUEJ1zEKV678wiqXFPIyBpqsNV07VGnK3v1EWVKcee0ZbkDxdkcZA
	Iu8RwbDDI83z4c9C6xXb8MKZ+8fgJZOewmAahf3GKcO41H4toBu1/JnsypXXuAUu
	6fyzN5POgRrGsn7ZbrZEoNymKwlEiUJudyLSw/eY0+N9rQuVFq1u3i7TuIzbIgTQ
	Dd6aBQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj7jgta4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 17:22:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so7780004eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778001762; x=1778606562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LpmOdSwKqZjJwQwTl0UCBPLiRs17tqnTcHQ78riYdc=;
        b=cE0cH8YAKuJPgy3/wdA0saKjnhRulDr25r+4G4n097kiq6ZIOh6WSjvoiNtx8HL2hL
         auk4CXjJsTUK6iAb8Prsaev7QCiQtsI3ZVsQxLjKXOZNFdVBj3ZD6PVBgiKxAmGl2j0E
         7jYuRoNubuYYr9SjAHJrIFvYJXZkWBXTRDjNQV/3VgMCNkLx9pc7yGT9kqdOb5Mlnx93
         8gSdFJm9RuTpYm0srLSc7fpjpZduQIQJIsRTyukVV/J2Y4mVJLAUbCdLsRxH22MviLLi
         ziWrW+SYEGZ6Xprx1S8pVWMkVbWOl0BqlWpignU8ge96mE1UyKlvcLRa4z39sVnNvByc
         dPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001762; x=1778606562;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LpmOdSwKqZjJwQwTl0UCBPLiRs17tqnTcHQ78riYdc=;
        b=UFl82rhF7lCTpiIgyPtcsKImxRCHMXAgr/y9n0J4Z0npGyq4xLC+JDIQfU5pwfBq6T
         RB6GTAZh2dH9Nslp2p/92Dh8gsQ2r+ZyTyXjRLKpvVbDa3LuVB/26eH0HPp4MUy+MbSm
         eEoS1fYlgmG3Gq7a53VAsJiujWa9/zZQEc2B521ToKoDMiLw5Q83ail6p39o4WbS4hkl
         bxo3EFUiT1Poi+DFN8KAgZcV7lFsDXX8TEqBHMz/Amub/H7fet1HtrmiQQbU+HMoYRg4
         eA32dWEvDGwr+HrbvWYE+UIc85Pf+Tk6Ao2JwIYz0DEKNlNAreY1twRy4iMM09bcGWN8
         i3jA==
X-Forwarded-Encrypted: i=1; AFNElJ9nFA9DiLw+9ypldFRB42pY1jXv0om0BCvtVH6Itj+3gECVitw/jd0ZvpRejtWWj+38B+SkuKTu67UUj7RSkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBTU0XfMVugIroNRgZIyT1Zu/eEfTZEq+mdzrynmPry9SoCQG
	y+hSOr4AKpMQBj+3nioPHrjF+YH0eJtjEDP5F48PoU6iaYdYVXMo7VDh88RHoSUWfGXLX8zqai7
	0nuMzEv2BLvsnQoL0Zptwivlipaa2iQA+30aBs4lCk8j9qhTlkdIiWqYkW1nCHwwFyg9tWA==
X-Gm-Gg: AeBDieu9xcB/riEmG7bJZhKL1oxoWqQJH59Zm3czQiZ6yRdnn47MVLvl/DNRRaSqeGu
	p7U/dZsiypVP3bWD8/amtr5x894ZSCiukKqHlO2ZSGOm4/X2ny0glhmFNosFGlBHAcD7IWOm6+Y
	MB1FdeXDZGm3CFyWGWOjIjni8KiHBxqKd/093OiS0finvIWK4eegEzRDvvFrMZ/rWLfSmkt//V8
	3IfO4OHCNMliVvagLlJ06jtJ6jYn02OxD2bwqm/qL6oBwjj25RcZEUtWLsUyssg+XQGXe8MhRvv
	4ZgBCrnE0Fbz2EsRDoF8O1+phhdETwLG1ERy9hGnyqOIeuVOf67kKzDoYOicfbdRiE5CVdwngYE
	RDely5CpCuSRDoWJ7ntkhjeYaiBBDV0/jWJh+yipk218g8/7Ic3U1dfELL7MvdMxWf0Fuw+ddxs
	YsX4gSszBAwBsKrb8/
X-Received: by 2002:a05:7300:e78d:b0:2d0:239a:23c9 with SMTP id 5a478bee46e88-2f54a7840c2mr78133eec.16.1778001761731;
        Tue, 05 May 2026 10:22:41 -0700 (PDT)
X-Received: by 2002:a05:7300:e78d:b0:2d0:239a:23c9 with SMTP id 5a478bee46e88-2f54a7840c2mr78101eec.16.1778001761032;
        Tue, 05 May 2026 10:22:41 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3537d300sm25724426eec.0.2026.05.05.10.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:22:40 -0700 (PDT)
Message-ID: <69fd7b6b-ebda-4203-a798-6227feba7350@oss.qualcomm.com>
Date: Tue, 5 May 2026 10:22:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS
 reporting in monitor mode
To: Tamizh Raja <tamizh.raja@oss.qualcomm.com>,
        kwan1996 <laicheehou9@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20260505040920.57521-1-laicheehou9@gmail.com>
 <CABkEBKbVG-UGWOQUgi0Q4M9HkMqOF-nc2gWTwBn9gebC8s7U8Q@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABkEBKbVG-UGWOQUgi0Q4M9HkMqOF-nc2gWTwBn9gebC8s7U8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2NyBTYWx0ZWRfX6lkNdrRG4J6X
 udBPdURWSh07BHdFM7Kugh0GhH5NQkJJ69cW4hrz9s1nOwWDGcKTsk+bxQ105opBT5nz9H7oyde
 2END4W3lk/owDz5gRZUXJXf/LiC7BHy37nX2PB1Zi9QKHff4Y++MFusQamBtA/EFmZDy+C89KUQ
 Y8/FdDMrNH9aocilC5rTRj9piEyY5RGEMwXpIfz0vusnweEAIxQb2YeJg+sQfzo6Fnl1JZ49z1X
 wuJwz9ZDZCI1NjqcE+SFrwbH4nOnQHOz6zt6BHl7ajN7AdnNVSZ/mm6g7qyD3zYN894cKhUp2qG
 USFeZvNkXrGqVj6PyBD7dB5Msx3ngCgm86VVcB+OwhE0pZArDUgz1V4HOVDZpWbDj5Q4LG7GSPd
 MuaVEY3+UHfML7lS0ZGLOVfTJ5QQvW5FtOdGiGExfqK7FLKv8yBTd87KDbJI3mp7mPajFjth2o9
 8+rsjvdYqhPeyVxMM9g==
X-Proofpoint-GUID: dA9VTx71vP9AEUosgacLrQvrOf1HEnYi
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fa2762 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=lPGbPuhWIpbB3OlBjl0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: dA9VTx71vP9AEUosgacLrQvrOf1HEnYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050167
X-Rspamd-Queue-Id: E99974D1FC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35945-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/5/2026 9:43 AM, Tamizh Raja wrote:
> On Tue, May 5, 2026 at 9:40 AM kwan1996 <laicheehou9@gmail.com> wrote:
>>
>> In monitor mode, the driver incorrectly assigns the legacy rate
>> to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
>> frames, ignoring the actual MCS value parsed from the hardware.
>>
>> This causes packet analyzers (like Wireshark) to display incorrect
>> MCS values (e.g., legacy base rates instead of the true MCS).
>>
>> Fix this by assigning ppdu_info->mcs instead of ppdu_info->rate
>> for HT/VHT/HE/EHT frame types in ath12k_dp_mon_fill_rx_rate()
>> and ath12k_dp_mon_update_radiotap().
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220864
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ
>>
>> Signed-off-by: kwan1996 <laicheehou9@gmail.com>
>>
>> ---
>>
>> v2: Fix indentation and formatting issues in v1.
>>
>> ---
>>  drivers/net/wireless/ath/ath12k/dp_mon.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> index 39d1967..4119bb8 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> @@ -1925,6 +1925,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>>                 }
>>                 break;
>>         case RX_MSDU_START_PKT_TYPE_11N:
>> +               rate_mcs = ppdu_info->mcs;
> 
> Can we assign this rate_mcs before the switch case? Since in all cases
> we are assigning unmodified ppdu_info->mcs.
>>                 rx_status->encoding = RX_ENC_HT;
>>                 if (rate_mcs > ATH12K_HT_MCS_MAX) {
>>                         ath12k_warn(ar->ab,
>> @@ -1937,6 +1938,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>>                         rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
>>                 break;
>>         case RX_MSDU_START_PKT_TYPE_11AC:
>> +               rate_mcs = ppdu_info->mcs;
>>                 rx_status->encoding = RX_ENC_VHT;
>>                 rx_status->rate_idx = rate_mcs;
>>                 if (rate_mcs > ATH12K_VHT_MCS_MAX) {
>> @@ -1949,6 +1951,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>>                         rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
>>                 break;
>>         case RX_MSDU_START_PKT_TYPE_11AX:
>> +               rate_mcs = ppdu_info->mcs;
>>                 rx_status->rate_idx = rate_mcs;
>>                 if (rate_mcs > ATH12K_HE_MCS_MAX) {
>>                         ath12k_warn(ar->ab,
>> @@ -1960,6 +1963,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
>>                 rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
>>                 break;
>>         case RX_MSDU_START_PKT_TYPE_11BE:
>> +               rate_mcs = ppdu_info->mcs;
>>                 rx_status->rate_idx = rate_mcs;
>>                 if (rate_mcs > ATH12K_EHT_MCS_MAX) {
>>                         ath12k_warn(ar->ab,
>> @@ -2259,13 +2263,13 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
>>                 rxs->encoding = RX_ENC_HE;
>>                 ptr = skb_push(mon_skb, sizeof(struct ieee80211_radiotap_he));
>>                 ath12k_dp_mon_rx_update_radiotap_he(ppduinfo, ptr);
>> -               rxs->rate_idx = ppduinfo->rate;
>> +               rxs->rate_idx = ppduinfo->mcs;
>>         } else if (ppduinfo->vht_flags) {
>>                 rxs->encoding = RX_ENC_VHT;
>> -               rxs->rate_idx = ppduinfo->rate;
>> +               rxs->rate_idx = ppduinfo->mcs;
>>         } else if (ppduinfo->ht_flags) {
>>                 rxs->encoding = RX_ENC_HT;
>> -               rxs->rate_idx = ppduinfo->rate;
>> +               rxs->rate_idx = ppduinfo->mcs;
> 
> rate_idx should be assigned with ppdu_info->rate only not mcs.

why is that? documentation says:
 * @rate_idx: index of data rate into band's supported rates or MCS index if
 *	HT or VHT is used (%RX_FLAG_HT/%RX_FLAG_VHT)

ppduinfo contains separate rate and mcs so doesn't one or the other need to be
copied to rxs->rate_idx based upon the current PHY configuration?

btw looks like the struct ieee80211_rx_status documentation needs to be
updated for HE & EHT (and UHR?)

