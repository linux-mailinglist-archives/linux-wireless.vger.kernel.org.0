Return-Path: <linux-wireless+bounces-31290-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B4GKaXFemmY+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31290-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:27:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F7AB1E0
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD493007CBA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4C2472A2;
	Thu, 29 Jan 2026 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQmQ+ZQP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OxLaRjaf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B554739
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653667; cv=none; b=IO7z+1u9OTVdAxDrHklacV3fLnXHY6+oWxeMzRaHY9qAnBDPTP7R9GBSHIKIKdp4Ppk0elk8YZT9Oq3IgWG2ZwrE7wGjvWCpb/Ms+zLfs5hB61my60DTBn3Y0DQKIeAioe6cOZKvtUmmWMl7bOR1KgS7RHp2/6dsyFXb4Ua7jfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653667; c=relaxed/simple;
	bh=ZJwWMRPQkjL0DYJTnVoQtSA2OItTVVY0eeDkM8p4C84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h76uUbezAmePE6ZKK6v5cJTwMV5CdV9xhtoNoUCq85oL29u1u7/YPSkMYfQ1emNc+UHG+myel7dnlvcy3XPrHYAfEQzRvRg7Ntve6KY5Hl/nLa8DruJ5aMeaD/9oG+ohFXPg2QQkCmmWR9SfL75K9hHIQoRPrL3X4WEMJ1qjKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQmQ+ZQP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OxLaRjaf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2PWTF1407436
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v8l+S9ANwleyd185ZC23J/8eHolw2Si4CnB7avBT2P0=; b=WQmQ+ZQPyV+TKGln
	JOMfGfaP4rI8lRJSzf6/DEZit9uLAjMNzgfvh5JlZi4JhgufTxQ01A8pEp5lM78h
	lB+XUcKCm2KVORj4Q0EckHmtsVV23l0P/CX3M13x/F3C7/lb4cqvyyM5xXbj/2yl
	70ScYirBfjJ0V3cSISDDm5+4hOSoOjwQa7TLlTmpCyqHN2BPnC4lUq7jVctWd3h1
	DoTPo+CbonYJT2BukpPmE3JYt204Jd9dFkWVVcN2Jv230mtLOoYUeE0iYkPBc2i5
	4IFsodAgW+WYfmhXhXZVMedjDArZBe73/R3ZYdHHuDI+WvimwWQZQNO8RF+Onavs
	uTzEUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byphghg20-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:27:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a76b0673dcso4398645ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 18:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769653663; x=1770258463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8l+S9ANwleyd185ZC23J/8eHolw2Si4CnB7avBT2P0=;
        b=OxLaRjafoH1ED51TXb5027BplepdK6O30gDI0iCnLjoqcFJ0eBT3Yy0KTv+51S1e2E
         AWjFEwAgykCMXqd7M1icIqNZMtkXOVKbcwAiwMmR6PNLmHdSrGtk7ZTH4YX5CKh1izIR
         3a0Kz2nq8wR3msP+oQqCxlxCfV670Zj4NmLKuZadUwy3dk3TVCa8ro8D/E+j62lUfHFg
         RDiDCl/WcffwHlCGzEp2uBwOzG+fih1N127V67WJEPn5l984pGSS5ZdDCfL+8nfLFFzt
         3I18GVDn5+D8sC2CLMFVVVfTFSlOVUgj026dc9mAdd22/H7h0DaPyq/4QYg9tB4AyYjg
         KtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653663; x=1770258463;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8l+S9ANwleyd185ZC23J/8eHolw2Si4CnB7avBT2P0=;
        b=CS6kgdhUnuvcwFmMzS7DoXluHjolrORWJyCcXDxT+9w++wH1ZTOfeDV2SLXgxDpBLP
         evaLRjUbP23wkc5PEPFPBBX4Kek3fHFb2tn5DspBjOHuVNc0sT0G+kczlEL7MC1lvv5o
         rTcD1aBmPU8SivF145e+pv6t0X7yDMiWAywjWTQzS83+Inaar3cJjWPM99CILAZYtPAn
         uogqCR80kl9zhaGvYK1aZn11IvnwZpMrai3uSJPsEdD92qF7SoNoL288INaUtGaVGGjW
         i/LO0HiCajmTCCBZyWX7HN+NC1d4ToE2GLG0/p8/Q5uzQYUOzMzJEqF+XuvGtPbxFWIY
         Ui+A==
X-Forwarded-Encrypted: i=1; AJvYcCXXC+hps6jcVly1R6sESv/lKWswbC+rgWfyGRJS3hL7dDIEir/y89CUo4WwGUB6vQbcnuDGDW1KvjNtInVFhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAS2yU0d+N8mburtOXuLLB0N3KbD7xJ9BwQRP9/loDDAN4LGd
	O0tMygVgcgc8TkN+eMv8ax5caJYgxI5bEYAVyoLat4GSDTzKbxavj2nAZRTksXLQraW9GUsP0op
	obwiNw6C9IR5NfK81RSrQKrMXRVIrqxGldGVssgILhSLq4T1oO/masxou9zhpUQfUgOPPkg==
X-Gm-Gg: AZuq6aJ09bvGlDU6X+hCzAiKLKFKHBnRIgY55bkF3kpMNizlwyNrGex399sdKFikj4j
	58bBJI+BIZaDzKC5yM9AQwWoZIjZObdNz4DPnJNlEHKLuKMbX1cz3Poj483v6tSiidvDWafqsqa
	8rPL+niadOW3Nf+PBwafc4PSVlHxudAMIWsSFNlrel+NO3rGGkcwBzq91XWVgOXh8r4c9SU8h+m
	1Zd6XSgMIXOaJ5j4fT4U3bmbvEAxumPfCOtzbjAaALEz1vwC3cQh/f1SiSqFrhB383cDFYq8FN2
	lXCibzpdAY+ii7vDmZ0dePmE3xM7rZPZYrSFP/+p8+oflLkIiZno0iqTA+b0r2RI0WKOGNtmBSR
	kGWjLP6T9Hk/6oyqI+STjXI+gPFWxEDEcE9btEF9dCU6Wztz0plhYR+Ms4givp54/l7c1R/keYf
	DGuLJo/qk=
X-Received: by 2002:a17:903:3504:b0:2a7:6460:74f9 with SMTP id d9443c01a7336-2a870dd5466mr62599415ad.24.1769653663129;
        Wed, 28 Jan 2026 18:27:43 -0800 (PST)
X-Received: by 2002:a17:903:3504:b0:2a7:6460:74f9 with SMTP id d9443c01a7336-2a870dd5466mr62599245ad.24.1769653662608;
        Wed, 28 Jan 2026 18:27:42 -0800 (PST)
Received: from [10.133.33.202] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e5ac4sm33022645ad.86.2026.01.28.18.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 18:27:42 -0800 (PST)
Message-ID: <7fb6b431-58ea-47bc-b251-5144575db17d@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 10:27:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev
 list is empty
To: Saikiran B <bjsaikiran@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kvalo@kernel.org
References: <20260126095244.113301-1-bjsaikiran@gmail.com>
 <20260126095244.113301-3-bjsaikiran@gmail.com>
 <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com>
 <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
 <CAAFDt1s8HPQWJpSiDDk8PmUAKqkQHELcJj_F0faZ1C9RfiYu6g@mail.gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAFDt1s8HPQWJpSiDDk8PmUAKqkQHELcJj_F0faZ1C9RfiYu6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CSouutkEmCldNfCEsG9KPkBoudNZu79b
X-Proofpoint-GUID: CSouutkEmCldNfCEsG9KPkBoudNZu79b
X-Authority-Analysis: v=2.4 cv=J/inLQnS c=1 sm=1 tr=0 ts=697ac5a0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=danhDmx_AAAA:8
 a=pGLkceISAAAA:8 a=wpMiBxZ-6fOymbzk10oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAxNiBTYWx0ZWRfX4vzDRv58rWS9
 V3CIANylkuALhelzxZ9EA2fqT6YPSiVuueAl2OdVmV7cKQTJd8zf9rvL6rO7Me9BGqhCTEiHTju
 8Y+14R8YlbAJESFv6bDMAbBZM/pRkzosppN2fG0rGZgs61MpYzwXulebzOxWZPFGpAPrgxyJnkt
 Zw5KAzImepwM3flMLWIdj9TAXWVAS50xibbusTG02IqiR7LXd3sMhXdEKGA+7BpWvFXQzJbFwzz
 2rjvCDf+cwXk5fxcwqLijpvj3+bObLKQzDk70eIRN80f7flaMa1KKld3ln8fNfa1fn7wJXntw9P
 hxBESaBOsPo4eLEbqMWw0Ce/Hjwf4n5OHiH4OJMcY/bW7N0Ga1FGAtkH2CQNItsljjVZO1fjJum
 aXRTjrMa6kowTYFzXO8TYYhb0Sy6NPlHYhlxgqCH8+7eqf1y3/11mJ9i/WLGBrG7JfspNqnTR45
 eDExPCsIHs6Yn5q2B2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31290-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 087F7AB1E0
X-Rspamd-Action: no action



On 1/27/2026 12:40 PM, Saikiran B wrote:
> I have analyzed the logs and code flow in depth to provide more
> definitive answers for your questions.
> 
> The log entries showing the failure are:
> [  563.574076] ath12k_pci 0004:01:00.0: failed to pull fw stats: -71
> [  564.575896] ath12k_pci 0004:01:00.0: time out while waiting for get fw stats
> 
> 1. Why are other stats populated?
> The "failed to pull fw stats: -71" error is not the initial failure
> but a symptom that appears after repeated operations. The leak happens
> during *successful* calls prior to this error.
> 
> Code flow proving the leak:
> - ath12k_mac_get_fw_stats() sends WMI_REQUEST_PDEV_STAT.
> - Firmware responds. ath12k_update_stats_event() parses the response.
> - ath12k_wmi_fw_stats_process() is called, which splices 'vdevs' and
> 'beacon' stats into ar->fw_stats.vdevs/bcn.
> - ath12k_mac_get_fw_stats() returns 0 (Success).
> - In ath12k_mac_op_get_txpower(), the check `if (!pdev)` fails if the
> pdev-specific list is empty (but vdev list is NOT empty).
> - The function exits via `err_fallback` WITHOUT calling ath12k_fw_stats_reset().
> - Result: The 'vdev' and 'beacon' stats that were spliced into
> ar->fw_stats remain there, leaking memory and accumulating with every
> call.
> 
> 2. Exact place where -71 is printed:
> The error "failed to pull fw stats: -71" is printed in
> [ath12k_update_stats_event()](drivers/net/wireless/ath/ath12k/wmi.c).
> It corresponds to "ret = ath12k_wmi_pull_fw_stats()" returning -EPROTO.
> This propagates from
> [ath12k_wmi_tlv_fw_stats_data_parse()](drivers/net/wireless/ath/ath12k/wmi.c),
> when buffer validation checks (like `len < sizeof(*src)`) fail.
> 
> Conclusion:
> The fix in my patch (resetting stats when `!pdev`) is critical because
> it ensures that the accumulated 'vdev' and 'beacon' stats are freed
> even when the 'pdev' list ends up empty.
> 
> Let me know if you need anything else.

can you please try below to see if it can fix your issue?

https://lore.kernel.org/r/20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com

> 
> Thanks & Regards,
> Saikiran
> 
> On Tue, Jan 27, 2026 at 9:47 AM Saikiran B <bjsaikiran@gmail.com> wrote:
>>
>> Hi Baochen,
>>
>> Regarding your questions:
>>
>> "Are other stats populated?"
>>
>> Yes. When ath12k_mac_get_fw_stats() returns success (0), it means the
>> firmware response was received and valid WMI events were processed.
>> The firmware response to WMI_REQUEST_PDEV_STAT typically includes
>> multiple stats TLVs (vdev stats, beacon stats, etc.). Even if the
>> "pdev stats" list ends up empty (e.g., due to specific filtering or
>> availability), the firmware should have populated other lists (like
>> vdevs or beacons) in the ar->fw_stats structure. If we don't reset,
>> these valid entries leak and accumulate.
>>
>> "Where exactly is -71 (EPROTO) printed?"
>>
>> The log "failed to pull fw stats: -71" is printed in
>> ath12k_update_stats_event() (wmi.c line 8500 in my tree). This error
>> code (-EPROTO) propagates from ath12k_wmi_tlv_fw_stats_data_parse(),
>> where it is returned when buffer validation checks fail (e.g., if (len
>> < sizeof(*src))). This failure suggests that the accumulated state or
>> memory corruption from the leak eventually causes the parser to fail
>> on subsequent events.
>>
>> So, fixing the leak is necessary for correctness regardless of the
>> specific side-effect error code.
>>
>> Thanks & Regards,
>> Saikiran
>>
>> On Tue, Jan 27, 2026 at 8:57 AM Baochen Qiang
>> <baochen.qiang@oss.qualcomm.com> wrote:
>>>
>>>
>>>
>>> On 1/26/2026 5:52 PM, Saikiran wrote:
>>>> The commits bd6ec8111e65 and 2977567b244f changed firmware stats handling
>>>> to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
>>>> after using ath12k_mac_get_fw_stats().
>>>>
>>>> In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() succeeds
>>>> but the pdev stats list is empty, the function exits without calling
>>>> ath12k_fw_stats_reset(). Even though the pdev list is empty, the firmware
>>>> may have populated other stats lists (vdevs, beacons, etc.) in the
>>>
>>> 'may' is not enough, we need to be 100% sure whether other stats are populated. This is
>>> critical for us to find the root cause.
>>>
>>>> ar->fw_stats structure.
>>>>
>>>> Without resetting the stats buffer, this data accumulates across multiple
>>>> calls, eventually causing the stats buffer to overflow and leading to
>>>> firmware communication failures (error -71/EPROTO) during subsequent
>>>> operations.
>>>>
>>>> The issue manifests during 5GHz scanning which triggers multiple TX power
>>>> queries. Symptoms include:
>>>> - "failed to pull fw stats: -71" errors in dmesg
>>>
>>> still, can you please check the logs to see at which exact place is this printed?
>>>
>>>> - 5GHz networks not detected despite hardware support
>>>> - 2.4GHz networks work normally
>>>>
>>>> Fix by calling ath12k_fw_stats_reset() when the pdev list is empty,
>>>> ensuring the stats buffer is properly cleaned up even when only partial
>>>> stats data is received from firmware.
>>>>
>>>> Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-driven")
>>>> Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
>>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
>>>> ---
>>>>  drivers/net/wireless/ath/ath12k/mac.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>>>> index e0e49f782bf8..6e35c3ee9864 100644
>>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>>> @@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
>>>>                                       struct ath12k_fw_stats_pdev, list);
>>>>       if (!pdev) {
>>>>               spin_unlock_bh(&ar->data_lock);
>>>> +             ath12k_fw_stats_reset(ar);
>>>>               goto err_fallback;
>>>>       }
>>>>
>>>


