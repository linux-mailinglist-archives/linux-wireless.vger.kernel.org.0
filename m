Return-Path: <linux-wireless+bounces-37891-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8x6/BBuyM2qsFAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37891-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 10:53:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CA469E9F2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 10:53:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=byYBBqlk;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ROSunSbF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37891-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37891-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 231463075376
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF4343881;
	Thu, 18 Jun 2026 08:52:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91284282F23
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 08:52:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772752; cv=none; b=P6/032CFde+Q7i83Mn48piObKlztTIVDKZfEifY8yUlWjwNxtdHDjIZrlZnjtYq/by5+hkA1mNzJb2lfZyz5cL894+8/OlbYYIclmxOju5Ob+yqZpFuZDRhd4PC8yeljcRB6HkVBFnbtdLD76onwnT1x0t+Gkz/chKknJzPACKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772752; c=relaxed/simple;
	bh=e75vCEzh3l2zveir/S3wwI4qH6Y5BkHXfDJ5xMIq2kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jui4LUika5b8xIOGJ5fYs06HDv3rYNDxTJINw/Tc1K2Ypop9LVsYXjApn2qaerfSLBsQF3g+Yve67F7LyX3nYGtkz15u47hFdwXvmfOIBvIPWQ6h5C6AvR75ddD2fHcqGMG34+5KJvNR28VOFJdj4SypVeuP5ImCZZhBNqKIJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=byYBBqlk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ROSunSbF; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8FuGT1252621
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 08:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OrpjNUrlYYQ2QNk8EUZ5kS30hXTdfkfIzBBCbiSoGMk=; b=byYBBqlkJLVYSBBr
	7neLPa6VcrPFO339GHYccB5mcv3P4S8ZgKMy+onnfMH2QvITWhQLzDc2jS7hzDPG
	BmJ0H0EjMS7pmdGe5jf3bYMWVuMSHj33+adnrKH9nz3LdUN1edn70UkEHtQKHDY/
	bY1dHAsgZftxdFYXpf/X5Mw+rTb8lQ/5qSDlhmQ34aQXxf2BfJoRE1RHfi2Xqbua
	On2v5O+ei1kMFUuxCdT+jrySE2i8grGNivdPwxXHWuerqVWfjC8JLKkFvKp1w2eY
	HkaXa/ipCCA4YzM4OLgBRSJqKJtsd9NsskO+a1sEQWoAHSYu7YMS0c+blTdGacZS
	AxPp7Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7juyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 08:52:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c2b64850easo15986205ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781772748; x=1782377548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrpjNUrlYYQ2QNk8EUZ5kS30hXTdfkfIzBBCbiSoGMk=;
        b=ROSunSbFJFF5GLyN0pAKx1+cOQthjZ5iikohsiLAaWm8GxZY2p5pvmWXlghaeFIXAL
         QvJAK3cBCYUVhzCz9Y+gU8IQ4Qh+E1SWoATNgIWUkn1puzBIaVyJ9Q8VoZQIgsRHNnqb
         vDC/ODOj6Rafns82ofCGJr1FL8zqDVrz2M/1/onYAef+1G6Q40c4MMkZbs+fNOsEMjyy
         jZqgUplvCWuTI7qSUOJsK6vfynhrFrWin/R+Pj5Ssb86aIp/1+sMNpwc5wBzhKZQ9Nv6
         P6wlhQcPrnFmXb2XmxKkRo3p1gCjwufJ4NtPxvSYGwZHszP8ME4zBhezM+uQlI97M/7K
         hNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772748; x=1782377548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrpjNUrlYYQ2QNk8EUZ5kS30hXTdfkfIzBBCbiSoGMk=;
        b=QdyoFTK/zp3PaGM7T5sLmVtZtvboLJ0cqI4WcPiUGJJ6qe0LshXjlbLwAm1AkUo7/3
         PM9AFpiZXyB7hHVej0pQ4wIJCYeWy24JMQZYUl5EzTnT10HJyXb4JL2GYRHVyz73Ujwf
         rnFI9zrRgYsEygMMnN+vSP59k4ZMzcyGKBhpgf+wZPU48e68aCxJlKxdCNFZYusvt0z+
         vNX4y+ti7ADlEaBw1U77eW47KGAmxTIpRqtULwLq/lQcwMhw5iGOecyYcfwG36ShJrAX
         5qFElKYuHz/OPlUgI8wpWcmapI1ec1ORw979lBX4VAeNGMvgcwp/8gax5PJKPbI9w/xP
         yshA==
X-Gm-Message-State: AOJu0Yxg1lKED32tub/DSeRcG5P6+APDzq1MfwfcKXB2ffIJxlho3jh8
	4E/7yJkJQANn/fMV4H5jrsNNaQRxPA8V0S+NKe+kT2g+d8eKojCFJXCeMdHt0qqzk86yzzCKsas
	LcyECnUFHOtqnSvPndiFXpyOcKcXpWVuQigDeE9yWLfo1C/yBMXrY1dKHp+9ETzO/DxCSNA==
X-Gm-Gg: AfdE7cmpbz0jV1birgR9UkpEb6Gf1HsM57gPTmK1x8WiKEEBSP1j6PULRH4FnQEmmF2
	N78fDD6XWFb1gVG23ULhlZAOpSMjIl3HCSAnU6mMPZvVnxbGhFHpUSCYLyEQRth1uZhGA9kYgih
	hZj8HTmFuYAdU/lBpR3oqCpCHLxHfXeJaKjTYpq/rnyRPcVqHsCFzAiBx/MH+qjwGV5ted4ZHxX
	9SawKydStFA6rfofog9uW+WR3upaoMc2Oc1YbYXKDjmoYLFYFSkNvzw2OzGQvkgN49DLcQgiaoG
	xVj5azRXS1LLK5BGx0TSn3hv7P5c6JFDMa2N9ZF/lv99T1ANjKJmiKxZIVbaZlJLvyt75Ia4KQ1
	opyKoK/+EsidxptDIUNVjXGpg+0sOrTTKRblixEZ+1Fxa
X-Received: by 2002:a17:902:e752:b0:2c2:5446:30e1 with SMTP id d9443c01a7336-2c6e4745fa8mr30200425ad.11.1781772748170;
        Thu, 18 Jun 2026 01:52:28 -0700 (PDT)
X-Received: by 2002:a17:902:e752:b0:2c2:5446:30e1 with SMTP id d9443c01a7336-2c6e4745fa8mr30200075ad.11.1781772747684;
        Thu, 18 Jun 2026 01:52:27 -0700 (PDT)
Received: from [10.152.193.243] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac7fbsm203955715ad.42.2026.06.18.01.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:52:27 -0700 (PDT)
Message-ID: <4fc10b44-3107-4e0b-9b1f-793713c28e0f@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:22:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: add QMI capability negotiation for
 dynamic memory mode
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260601031850.3715354-1-aaradhana.sahu@oss.qualcomm.com>
 <7f3f0f10-3493-49b7-ac6d-cc5efca24746@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
In-Reply-To: <7f3f0f10-3493-49b7-ac6d-cc5efca24746@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MCBTYWx0ZWRfX/W5PwfZJz05m
 fF5Bj+TVzOktTvo6Tf6SbN2fgd84jPxPo7YFuKBsUKlduY7li/FxiijahZNfTUBP4zle5kOEiHc
 +PsB38fBi8bis6M1VjY7PxMGCdiXTAxW7VrD4uhyF0LR8FAgYY7Ti6JgpZnWaicz/USrpLOF6hd
 C8ayfvIitUGJiLqPWhApC11qfx4A1ZMWcOWEhGVKmPLlBkpXUvJRMGZHp05v6352qmWBWg6J2Px
 Asj/jdY/g984NeMjYH+UMYekFZHY9CXp+dtktgmWsKzp/voMueMDCi2ahC88ioHcd0C8fWakP6b
 JDKluTyEL9UdBAyCiOaryDmiDHlPCyzHUmfnJsvRgKGZZcBM69AkhgBWktDXnRHnapNNgpcsnxF
 RW3LdylTZNDhNlLsZ4b7XumCV93ch9tDusA5oHUzmfOEabiOTSwGuM+vURNf7L+26Z723J/2myO
 shEkK4J5KrNTjIj5Bbw==
X-Proofpoint-GUID: nlzM3EmRIe8Rq4SN2ItOvSfVZlyTJHTC
X-Proofpoint-ORIG-GUID: nlzM3EmRIe8Rq4SN2ItOvSfVZlyTJHTC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MCBTYWx0ZWRfX9ecqB5oj8Br3
 D+SP+xE0rNM6LrQxpkUZ4hp12eVD++Hw68HwwnvVcBlwC/2znS7REjv0+WSXuuV+Z7Y2LHBUsuB
 SBjjRfx4ylUat3CLLp9XklIOO79a8RM=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33b1cd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BKLcScISXldYRKvFntQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37891-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rameshkumar.sundaram@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73CA469E9F2



On 6/18/2026 12:18 PM, Rameshkumar Sundaram wrote:
> On 6/1/2026 8:48 AM, Aaradhana Sahu wrote:
>> On AHB platforms, firmware operates in two modes: fixed-memory mode where
>> firmware uses hardcoded addresses for memory regions such as BDF and does
>> not request HOST_DDR memory from the host, and dynamic-memory mode where
>> firmware expects the host to provide memory addresses including HOST_DDR
>> after the Q6 read-only region and relies on host allocation for all memory
>> types.
>>
>> Introduce QMI capability negotiation to support both modes. Add a new QMI
>> PHY capability flag dynamic_ddr_support which is advertised by firmware to
>> indicate it supports dynamic memory mode. When the host detects this
>> capability, set the dynamic_mem_support flag in the host capability message
>> to signal the host is ready to provide dynamic memory allocation. This
>> triggers firmware to send the HOST_DDR memory request and use the
>> host-provided address.
>>
>> For backward compatibility, if firmware doesn't advertise
>> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
>> where firmware uses predefined addresses.
>>
>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
>>   drivers/net/wireless/ath/ath12k/qmi.h | 10 ++++--
>>   2 files changed, 54 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>> index fd762b5d7bb5..85406d6e6da1 100644
>> --- a/drivers/net/wireless/ath/ath12k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
>> @@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
>>           .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>                          feature_list),
>>       },
>> +    {
>> +        .data_type    = QMI_OPT_FLAG,
>> +        .elem_len    = 1,
>> +        .elem_size    = sizeof(u8),
>> +        .array_type    = NO_ARRAY,
>> +        .tlv_type    = 0x33,
>> +        .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>> +                       dynamic_mem_support_valid),
>> +    },
>> +    {
>> +        .data_type    = QMI_UNSIGNED_1_BYTE,
>> +        .elem_len    = 1,
>> +        .elem_size    = sizeof(u8),
>> +        .array_type    = NO_ARRAY,
>> +        .tlv_type    = 0x33,
>> +        .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>> +                       dynamic_mem_support),
>> +    },
>>       {
>>           .data_type    = QMI_EOTI,
>>           .array_type    = NO_ARRAY,
>> @@ -602,6 +620,24 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
>>           .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>                          single_chip_mlo_support),
>>       },
>> +    {
>> +        .data_type      = QMI_OPT_FLAG,
>> +        .elem_len       = 1,
>> +        .elem_size      = sizeof(u8),
>> +        .array_type     = NO_ARRAY,
>> +        .tlv_type       = 0x17,
>> +        .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>> +                       dynamic_ddr_support_valid),
>> +    },
>> +    {
>> +        .data_type      = QMI_UNSIGNED_1_BYTE,
>> +        .elem_len       = 1,
>> +        .elem_size      = sizeof(u8),
>> +        .array_type     = NO_ARRAY,
>> +        .tlv_type       = 0x17,
>> +        .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>> +                       dynamic_ddr_support),
>> +    },
>>       {
>>           .data_type    = QMI_EOTI,
>>           .array_type    = NO_ARRAY,
>> @@ -2248,6 +2284,11 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
>>       if (ret < 0)
>>           goto out;
>>   +    if (ab->qmi.dynamic_ddr_support) {
>> +        req.dynamic_mem_support_valid = 1;
>> +        req.dynamic_mem_support = 1;
>> +    }
>> +
>>       ret = qmi_txn_init(&ab->qmi.handle, &txn,
>>                  qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
>>       if (ret < 0)
>> @@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>>         ab->qmi.num_radios = resp.num_phy;
>>   +    if (resp.dynamic_ddr_support_valid)
>> +        ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
>> +
>>       ath12k_dbg(ab, ATH12K_DBG_QMI,
>> -           "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
>> +           "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %d dynamic_ddr_support %d\n",
>>              resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
>> -           resp.num_phy_valid, resp.num_phy,
>> -           resp.board_id_valid, resp.board_id);
>> +           resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
>> +           resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
>>         return;
>>   diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
>> index 2a63e214eb42..dbde76e5a78d 100644
>> --- a/drivers/net/wireless/ath/ath12k/qmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/qmi.h
>> @@ -156,9 +156,10 @@ struct ath12k_qmi {
>>       struct m3_mem_region aux_uc_mem;
>>       unsigned int service_ins_id;
>>       struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
>> +    u8 dynamic_ddr_support;
>>   };
>>   -#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN        261
>> +#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN        265
>>   #define QMI_WLANFW_HOST_CAP_REQ_V01            0x0034
>>   #define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN    7
>>   #define QMI_WLFW_HOST_CAP_RESP_V01            0x0034
>> @@ -258,7 +259,8 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
>>       struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
>>       u8 feature_list_valid;
>>       u64 feature_list;
>> -
>> +    u8 dynamic_mem_support_valid;
>> +    u8 dynamic_mem_support;
>>   };
>>     struct qmi_wlanfw_host_cap_resp_msg_v01 {
>> @@ -267,7 +269,7 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
>>     #define QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN        0
>>   #define QMI_WLANFW_PHY_CAP_REQ_V01            0x0057
>> -#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN        18
>> +#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN        22
> 
> this is not used anywhere, but since you're touching it should this be 26 ? response TLV 7, num_phy 4, board_id 7, existing single_chip_mlo_support 4, and new dynamic_ddr_support 4
> 
> 
> -- 
> Ramesh

I checked the driver and found there are several unused QMI_*_RESP_MSG_LEN macros.
Since this macro is not used anywhere, I think it is better to remove this
change from the current patch.
I will send a separate cleanup patch to remove all unused QMI macros.

Hope that’s fine with you.

