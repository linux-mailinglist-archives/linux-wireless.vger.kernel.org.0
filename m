Return-Path: <linux-wireless+bounces-37894-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oU6pNFq6M2omFgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37894-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:28:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3490D69EDE6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jiYzsvUd;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=iSC7ABjk;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37894-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37894-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742F830EF1E6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB33D813F;
	Thu, 18 Jun 2026 09:22:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA753CAE9B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:22:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774546; cv=none; b=CTaUVYLPqx8p8JbUK8t5SuG8ABinyGYBF++HQR+ZBk9iSWvUU680/66lbLieGXzDDxqtm43gCYR8n91GOa+Qdfb1Plle2Ea0sfVnqoK6wy8lZLRzyp2SgdpYAs2uMxsEEfG8vnNvDMqiyKGzHc1KP0cIjr3dFQFYlc+5WoHoQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774546; c=relaxed/simple;
	bh=3DmURfmH9AtJOZGA5mvvycSPMWXyC2JxOKLJnWr29W4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TbSfRArutv4kHd5nPtD0nWvsATyAddVmq4xJjRTWt5Kw8lK7SAJDdz4iTFGlBdvASbxAiL8XhsN0LI6uxrkxJ68JK4FX1lnx2dzCMvYLII6TnZIJjU4em6KTzDilcVzmJlUfGyZ07FkjCrRLTPdfh2ZBozoSp/l+0vLIiPAp1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jiYzsvUd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iSC7ABjk; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8DZ0N3399910
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ymu1pZtY6Qzkufo8znnNgsaolHtKmq4ib+tAPwdv2dQ=; b=jiYzsvUdYkkGcfQT
	uYJjPMIvJAKYooqcW/rpZxHfMuZ24DwMjSddeNzkdU4lKdlHQDzy7XpA1KymqsMa
	tgz1knuW8renpZP3odni5MrwULG0IiYoGOLEFTlJO5hYN20sqxewW7qTZfjX94Ec
	Aj6Iz3QDRO4NOXOgpkIgbrfSS0dRGXfU994nhjnadkCg9vp4iU2fvZoAL8w1pAeK
	1XgkYuo/4OKhATZF5jF1RAao6H5Q49rLa9G+tioXeJNjbyGYrkhO1jBXKkb7H6ss
	7KVyMjhyb7QNX7IPV7O17BTZ9fTsKfSxMNN2dDavgOESNTGjMNrUGr7XaadxhLcg
	rUvCOQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vk2qxa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:22:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84240683a82so539083b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781774543; x=1782379343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymu1pZtY6Qzkufo8znnNgsaolHtKmq4ib+tAPwdv2dQ=;
        b=iSC7ABjksvi+edjdzeRtCzgaOgkYk/I+QHATriWFQJ47ziEYWKisKPD+cciCjDMlx8
         XSvhImInl/irlBIJJu2qkOgwdlci8SkUrPVbSBYy0DvKlcmRBn1iiT6NPPsNPz9+1aK1
         Kyo2lVabj4MmA8/p/m8H1dUWVJt8NMIYwA4oRrIyJI62b2LuB24Bc5zg3DqwyjJ2aoip
         YjW9f43KcTblfIw6FCEhcj49Gqqj1tUmrTopD4tZTL2YscwuS63rESL1j8AAUEcxEFX1
         SvjD7v7CjxDV7FejL67OYBOt1EGNaVS+dwy51KY64A15iX7jQVWnTdBcGY8r/CcuGQYz
         a2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774543; x=1782379343;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymu1pZtY6Qzkufo8znnNgsaolHtKmq4ib+tAPwdv2dQ=;
        b=YHqtqxYaye1Jl3ieiePQdN0RtsfuWya4o31Ud3qkMfvPVIv0x5vGu9/Rmp4uPumZpx
         HP8hilc+sAXiMQK9C/+i5KhdbxqLesawbAH3GBNOa8xqsvTTbW1QZSMI/yKCsXPSrJhF
         NORpwCIjtLeRFu8+G86JMD5ZtrYMMTJ3f3B4ZzHc3KsDLv4Q6xlYzdNHXr0FqN+i8BwB
         Ta2khWv+QctPUuHbJLdXF6sG7A0Sr/K9nayfVK9AYE3LA5tzcy8pEqpwSz2l2RTGJiS/
         a4GYbHyG3P0SYWICJDOob18uTKTXVhLvuRbuYeaEG8eZsxhikF9+rfSTR5Nj7iTwlCPY
         pQOg==
X-Forwarded-Encrypted: i=1; AFNElJ89qiU3tjtbcI94LoV+zcCnnARefyKc5h1uyq55oqmEq2M0NqapLk/SjMRW+AIh+IkQAhkCzzmUAxD+WRH9sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHwXzx4WAtB0uMpUjonInOIdxoibFv7WyNij838JsUGksr13d
	EjAcznmbI8x7xQIag4F41lSGjMzyXC4d25+6JnjKjws0B7eZNnBkVhwYXWBOL7uy3ur3/NuX3e8
	y3ENs/PxYufDizzaHrW1O+cMFcdOsCGHngEJctURdq5eO2Pily/TSDMabLtmshs9aw5MdtQ==
X-Gm-Gg: Acq92OGUVrbZhiiWE4ZY7P8YiHXATvkKcCyYKynjG1yRds5fT8QIKRislZFjb6BfWLa
	bIC1/BYNjX+f9cYFpF9LrlTT/OGKyp6MaswglLHORTrz4nv+GMXifeHKZ+SuHiP9Ko/L7F6J52M
	Gm5WMEuF3wso8FeS1jdHnAsryeSDyQ62jMh/6H7k9nkwHGBd+Xpe36KTsPBdCfpehOiGDlCfe0x
	7hRkljFlG07HaS9h9l3qjQL3IGgMf+DvDn2YTpIYVHXz633y8iE6FDsvC4YT7S0f8Z8StP0lGg0
	KMGpQ+SYHgBBmloZ+0DUOo8tTaWyxE+6YU9q4yYkLOrIZ21X45WVx4iHHhwSG2Fu/1PfDj+tPN7
	sXQUVSbQQmg1H2UsszpIS6jRSHX+5WcqOeCmTKFYo+y0n4dTWARilbI1aYIE=
X-Received: by 2002:a05:6a00:812:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-845391e1084mr2643988b3a.13.1781774543337;
        Thu, 18 Jun 2026 02:22:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:812:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-845391e1084mr2643961b3a.13.1781774542841;
        Thu, 18 Jun 2026 02:22:22 -0700 (PDT)
Received: from [10.137.71.130] ([106.197.93.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accbec5sm18638584b3a.16.2026.06.18.02.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:22:22 -0700 (PDT)
Message-ID: <e8cd11fa-944d-4936-9a57-d1b0d3d856e0@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:52:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 3/5] wifi: ath12k: add HAL ops for monitor TLV
 header decode and alignment
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
 <20260509025819.1641630-4-miaoqing.pan@oss.qualcomm.com>
 <aa5e214f-2d9e-4c97-b45f-7181c81cf023@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aa5e214f-2d9e-4c97-b45f-7181c81cf023@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kdXoa4w9fS9WTN9NpQdPVh-XkTAXhh2h
X-Authority-Analysis: v=2.4 cv=DNy/JSNb c=1 sm=1 tr=0 ts=6a33b8d0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=wlpA7Av3g41Jdys7FXR3eg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=REP3-BY0cBNZE2ghv4IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: kdXoa4w9fS9WTN9NpQdPVh-XkTAXhh2h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4NiBTYWx0ZWRfX8kz2HoIUCiq/
 oCxOifuuPzVsVDls4p8aD4tVmmL0mTCTT7HdpwifGmRVZfygEcFUjT2cgaDAKo+0MfsL5/Jtlxl
 sVJd4fWcLwvvKsU0qfBhufRGxE2/nxc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4NiBTYWx0ZWRfX7iX/FobxPEPx
 wK0IPrXEjaAoduhbFeFsbyxM0W9xSuL3sBiykBT4cMCmFTKgojSrR0umkxhuSvs8mk5nVK1reFw
 zGAX1WzaEkJTgkWx2bqlSeh/abc7eBUvJKpYc6pD2wQtDT6+bIPHiW3Rn/cdK3pB6sgSG+Zrtmd
 oJwwGIbU2VwlXE9putoyBmjd0KjCqOrMcoJROwL6q0e9NAHx7y0mnImL52stHuDduEd2jZ5H6+d
 5D1AKNsMQGhu6llSJI/6dlnogfJghP25Rfq6PVuwvMl8LlUhSbGHCE9Fu2+h2boG0A1GuGiAsA7
 HR5JE6OuiVpQR6Pywr5Q7GOj0Mq6YYVrxvIevBgKqYhdVKN0umyvg0cLXI4WI2AfTNGTg7tGOQI
 e4yhticiXqiLowFhhC0tg1Bfsus69dn4Cs4MPcMetseOv08kCRMYK+Gcm1vaGMp5WpRhgiNcKjG
 9AIgp3AFUAvAbnN7etg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180086
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37894-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miaoqing.pan@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3490D69EDE6



On 6/18/2026 2:43 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 5/9/2026 8:28 AM, Miaoqing Pan wrote:
>> Wi-Fi 7 monitor RX status TLV parsing needs to decode TLV headers and
>> advance the pointer with the correct header alignment. Different targets
>> use different TLV header layouts (32-bit vs 64-bit), but the HAL ops for
>> dp_mon RX status header decode and header alignment were not populated
>> for all wifi7 targets.
>>
>> Add dp_mon RX status TLV header decode callbacks and TLV header alignment
>> helpers to the wifi7 HAL ops for QCC2072, QCN9274 and WCN7850. Export
>> helpers to query the required TLV header alignment for 32-bit and 64-bit
>> TLV headers so the caller can align the TLV walk correctly across targets.
>>
>> Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
>>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/hal.c               | 12 ++++++++++++
>>   drivers/net/wireless/ath/ath12k/hal.h               |  4 ++++
>>   drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c |  2 ++
>>   drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c |  2 ++
>>   drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c |  2 ++
>>   5 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
>> index d940f83cd92f..c0c3d2f047ef 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal.c
>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
>> @@ -875,3 +875,15 @@ void *ath12k_hal_decode_tlv32_hdr(void *tlv, u16 *tag, u16 *len, 
>> u16 *usrid)
>>       return tlv32->value;
>>   }
>>   EXPORT_SYMBOL(ath12k_hal_decode_tlv32_hdr);
>> +
>> +u32 ath12k_hal_get_tlv64_hdr_align(void)
>> +{
>> +    return HAL_TLV_64_ALIGN;
>> +}
>> +EXPORT_SYMBOL(ath12k_hal_get_tlv64_hdr_align);
>> +
>> +u32 ath12k_hal_get_tlv32_hdr_align(void)
>> +{
>> +    return HAL_TLV_ALIGN;
>> +}
>> +EXPORT_SYMBOL(ath12k_hal_get_tlv32_hdr_align);
>> diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
>> index 3158c1881c76..312993d3d5d4 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal.h
>> +++ b/drivers/net/wireless/ath/ath12k/hal.h
>> @@ -1439,6 +1439,8 @@ struct hal_ops {
>>                        u8 *rbm, u32 *msdu_cnt);
>>       void *(*reo_cmd_enc_tlv_hdr)(void *tlv, u64 tag, u64 len);
>>       u16 (*reo_status_dec_tlv_hdr)(void *tlv, void **desc);
>> +    void *(*mon_rx_status_dec_tlv_hdr)(void *tlv, u16 *tag, u16 *len, u16 *usrid);
>> +    u32 (*get_tlv_hdr_align)(void);
>>   };
>>   #define HAL_TLV_HDR_TAG        GENMASK(9, 1)
>> @@ -1553,4 +1555,6 @@ void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
>>   void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len);
>>   void *ath12k_hal_decode_tlv64_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid);
>>   void *ath12k_hal_decode_tlv32_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid);
>> +u32 ath12k_hal_get_tlv64_hdr_align(void);
>> +u32 ath12k_hal_get_tlv32_hdr_align(void);
>>   #endif
>> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c 
>> b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
>> index c0583c3a2191..80ffadc47d48 100644
>> --- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
>> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
>> @@ -490,6 +490,8 @@ const struct hal_ops hal_qcc2072_ops = {
>>       .rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
>>       .reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv32_hdr,
>>       .reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_qcc2072,
>> +    .mon_rx_status_dec_tlv_hdr = ath12k_hal_decode_tlv32_hdr,
>> +    .get_tlv_hdr_align = ath12k_hal_get_tlv32_hdr_align,
> 
> ops get_tlv_hdr_align() seems unused, may be patch 4/5 is supposed to
> used this ops instead of removing the alignment?

My bad, somehow overlooked it, it is indeed used in the patch 4/5.

