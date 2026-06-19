Return-Path: <linux-wireless+bounces-37915-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TU6iJwzgNGpcjAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37915-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 08:22:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E13346A4154
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 08:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=VP1+dqH9;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=iyrRV7fo;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37915-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37915-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64EDC303B718
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 06:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48662E3FE;
	Fri, 19 Jun 2026 06:22:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C888C1F
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 06:21:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850121; cv=none; b=K8TJiTD6dsY+F0gI6XWWdobbUkf39Gx+W+tMLEsVGjLlqh6Y2MwJ0HgI0ehyRABiRHZYVpHbuAE/5dLNm8HkQQD5e/Kb+lEO0IQJKJ/35IRSu96hEzqERB4kuEpZBkAw/2FOzoZwdwEC5DpZcv94LVuhwhODVPj9iFaqA88rQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850121; c=relaxed/simple;
	bh=XkGbxUZBteZ70emmHK/MoFQogvjyQ04hcYBnPIF8RzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UM1o5uuatQEWCh3xAHGJeLcfCrZSHyk6HFmZ3rPy72IAx+WQc8/Dopp2qfjuLggeWkRe4OGh0XdHe+rw6VZopi6IfMILpDBLqhKkGgO10mJR8CYspPbMm9ZByxPZLu0hwYpDaNkDAEpCt0wuMWrNwMN6PGJPOeV3Fm+BIzrtS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VP1+dqH9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iyrRV7fo; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J2ssLC3130956
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 06:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahKfd5WfoSqw0wTb06gbiq8U5qGM5/pMRyhSC9UY/bM=; b=VP1+dqH9ZGgw2hih
	cQm5F82Yk/AHDcP1uzVs/u8hqBmsCHP4DYTEruSrfnrX7+feeIPrEdWBMQeRkzsy
	G18Isyk+S/iYShGvF4M+GQ06kM9FVXdwUdJOqOOseUOkAuMwRG3VFyFkgkvInvrx
	PA5tZ0fACPadi8ek0KPyS1aJo30R19vPZ5GrDUWOPhHEqdK2bJFKTLVHc2fxKSuu
	UAodGgrl97Kj0X5F9Rlejpx21Q2PhHQf6WKUpBgRhrlD4yp/AHjpdV0bRq6FZDmx
	rAuGvYofOTRerKXtF+pvmxc/MSYwwN2kKKGmJtouKXIUOK9HL4DKESHeq2imXrBf
	qgVYrQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp67230g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 06:21:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso1237657a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781850118; x=1782454918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahKfd5WfoSqw0wTb06gbiq8U5qGM5/pMRyhSC9UY/bM=;
        b=iyrRV7fo5Jg8MJExNCWVgVFhwRyNicUrrrAUKgaI0q/fSD7858BWP/Waz7i1jHA5Hq
         bpt5TtV+3J3iuYjDFPKi4MQohs7vjPSM7ASzqDxXE60BsgnTmYJPEVfIjA1ilos9V6vz
         z56uz6ZLpz8wnD99HtQY7qRH6YJjONaOoxmgd2DHp1x4PKTLYmmrHLAl0s/qYg9mIU2+
         gVF0M69Ve3127orFwuEnPoMergdLEsSWLtqXTrGtxc54yM2FIuw0jwIZQocirrSblxMm
         fmw5OBwVny1dYSe2A8kcq6DeqLhdyeDk1eZdLY5kF0dCJ9pZXON/SLMS6DabZGUVqOxf
         4j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850118; x=1782454918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahKfd5WfoSqw0wTb06gbiq8U5qGM5/pMRyhSC9UY/bM=;
        b=po9HCeTuWr9bLMci9yYuEh9o6ozRdhlR7wBMBz1Wx4B8E6hz4s485/WkeUtpWIRSWR
         WHvWK9Y66KyKzlB2449A6rAl731SGOPsAuA2Bm9wQofECIOwv0JHNIQ7FCqmW/XlGrva
         zxEp7u+jirXsZz+7Gjl4K6mDLUVidsTsfgC+XESwPm7MmFN0yDDHb9Cv2MmA413gvirC
         wASGsfocpXBx3iQtHkpVvD8ThUE0OBH8qLafMkO8GdyPMtAD/r7LBmjMCsF4eveg1LEC
         sAnvfxsn1udBf1YvKqeZOO8v3YEQkTnDXOgMJMCOeEHlqTFbtNCO4ZrAFSL1b+ry/L19
         I3yQ==
X-Gm-Message-State: AOJu0YybH432e+dq54PyLs9OfbjbKdSN3/XzjKiG/3wJz5WZl7l7zn94
	mKsw/ZdtHcT5b5zFrDevtUFkq3wlQxamaW3L894varS4yG9pgSaD4gIABanTGRRZQSUPGGznfjG
	elbYK7ALJoqfL8ZKUzSS8LJFrNpxTO1dc9+bdaVEkmZzsFTXbfi0kZb4uTVkKWqUuIAMpGg==
X-Gm-Gg: AfdE7clxYjGWtE2SdwOXGmK4qdUJ05UpAKWpLfE63mLWdUUMdgV1HDBmazJZxn0N/EG
	4+Sd6iEWLjPeJTc2abR86qvxooYywwpBSNLhjc7p+2RPHyCpEHVZ7PT6FLzWs7ZChVrfju8lutB
	EyYxu2dIbhLx7MfA6PyklexmCltiQVs71TnvKoRtANWsvz6eSKQ+SSlJxbA2HJwJFjBR8PWwWyI
	1ENMnDrYdJKath6iHpjJ9pIHngUBOROsJwnUETWXC3U5lXb4R9cjMpdCuxN1OXMyd9Bo2fkmiHO
	mwv6ZxWgtUZvxjup7C08e5pCZ+5I8Fok7vbR7YEgV622IGfHqcukS0lle6RrOtF1g6A4vfgQavc
	vqzr5Wvs1Jc35+SiC0KCXIP/iJoCExUNTh4f7UH+LANPE
X-Received: by 2002:a05:6a21:e098:b0:3b2:8685:118b with SMTP id adf61e73a8af0-3bb33f48a7fmr2634547637.20.1781850118437;
        Thu, 18 Jun 2026 23:21:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:e098:b0:3b2:8685:118b with SMTP id adf61e73a8af0-3bb33f48a7fmr2634506637.20.1781850117953;
        Thu, 18 Jun 2026 23:21:57 -0700 (PDT)
Received: from [10.152.222.171] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8afcb36977sm647159a12.17.2026.06.18.23.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 23:21:57 -0700 (PDT)
Message-ID: <35d384ae-c28b-4ca6-9f90-71a89b112aac@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 11:51:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: add QMI capability negotiation for
 dynamic memory mode
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org
References: <20260601031850.3715354-1-aaradhana.sahu@oss.qualcomm.com>
 <7f3f0f10-3493-49b7-ac6d-cc5efca24746@oss.qualcomm.com>
 <4fc10b44-3107-4e0b-9b1f-793713c28e0f@oss.qualcomm.com>
 <96953b10-379b-41d9-a151-68982b9a9854@oss.qualcomm.com>
 <17927ece-f0e3-4014-9143-891a15344bef@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
In-Reply-To: <17927ece-f0e3-4014-9143-891a15344bef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Pm6ntjKWKNa2nxCe3U7-sH8UamSHo9q_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA1NiBTYWx0ZWRfXyQ8nhMrrO62g
 1V30fiQ/nF9q/UzcDy2Mj7KoopgFS9jB5v7LdAwQ9JOoDKB7k72PP+FLiSexcEJs9hHWEG7m4zw
 BuYtIzbLlsoqguL2Yd7CqXsqiZ862CrRssZVCsu6VIpPKgycyedSo+Y1FCiYFHgxjCfeOaoCNXr
 4cdV9ltazFUO5P43VY6JuLVKTd9DPcHW/q9aTiulYmYR6XyxoLwuIImn8+QL3d4Xw536XaN7LzS
 Dd9G84Ywf+7lzMoYItjBAagWFUYtDkkIjBgXtuckNnIqw1buEerhuh4N1nTIT+oZaFF4LcCcy2y
 EJelBMYpTYWaMXV2k8IKm2h237AAs35kZ6GolAzFUxgNn4Ld5jf/v7TzKG8ZZAT04vs0ITwq8td
 MwPghsWHNuh0LhItQzxFua3+QPe/yayoSO/+Wq9hBzBJMotZxGJiOcaMp3bKTLxifbkiRJMJL7y
 2m4l7IDFHpJPwdyjN2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA1NiBTYWx0ZWRfXzbRDZEuF67Jf
 5NlQ461Tb/c4gbNCps075ChzbCEOGmfXiB1BZD9wvbUFEVUQl/CGRML4dVm3BKdVHePld69819Z
 OfnSO5bHknlaKyYYD9pWL5OxqbI8Eks=
X-Proofpoint-GUID: Pm6ntjKWKNa2nxCe3U7-sH8UamSHo9q_
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a34e007 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nT0Eqzq0tNwubFL82DkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37915-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:rameshkumar.sundaram@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E13346A4154



On 6/19/2026 4:55 AM, Jeff Johnson wrote:
> On 6/18/2026 2:29 AM, Rameshkumar Sundaram wrote:
>> On 6/18/2026 2:22 PM, Aaradhana Sahu wrote:
>>>
>>>
>>> On 6/18/2026 12:18 PM, Rameshkumar Sundaram wrote:
>>>> On 6/1/2026 8:48 AM, Aaradhana Sahu wrote:
>>>>> On AHB platforms, firmware operates in two modes: fixed-memory mode where
>>>>> firmware uses hardcoded addresses for memory regions such as BDF and does
>>>>> not request HOST_DDR memory from the host, and dynamic-memory mode where
>>>>> firmware expects the host to provide memory addresses including HOST_DDR
>>>>> after the Q6 read-only region and relies on host allocation for all memory
>>>>> types.
>>>>>
>>>>> Introduce QMI capability negotiation to support both modes. Add a new QMI
>>>>> PHY capability flag dynamic_ddr_support which is advertised by firmware to
>>>>> indicate it supports dynamic memory mode. When the host detects this
>>>>> capability, set the dynamic_mem_support flag in the host capability message
>>>>> to signal the host is ready to provide dynamic memory allocation. This
>>>>> triggers firmware to send the HOST_DDR memory request and use the
>>>>> host-provided address.
>>>>>
>>>>> For backward compatibility, if firmware doesn't advertise
>>>>> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
>>>>> where firmware uses predefined addresses.
>>>>>
>>>>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
>>>>>
>>>>> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
>>>>> ---
>>>>>    drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
>>>>>    drivers/net/wireless/ath/ath12k/qmi.h | 10 ++++--
>>>>>    2 files changed, 54 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>>>>> index fd762b5d7bb5..85406d6e6da1 100644
>>>>> --- a/drivers/net/wireless/ath/ath12k/qmi.c
>>>>> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
>>>>> @@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
>>>>>            .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>>>>                           feature_list),
>>>>>        },
>>>>> +    {
>>>>> +        .data_type    = QMI_OPT_FLAG,
>>>>> +        .elem_len    = 1,
>>>>> +        .elem_size    = sizeof(u8),
>>>>> +        .array_type    = NO_ARRAY,
>>>>> +        .tlv_type    = 0x33,
>>>>> +        .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>>>> +                       dynamic_mem_support_valid),
>>>>> +    },
>>>>> +    {
>>>>> +        .data_type    = QMI_UNSIGNED_1_BYTE,
>>>>> +        .elem_len    = 1,
>>>>> +        .elem_size    = sizeof(u8),
>>>>> +        .array_type    = NO_ARRAY,
>>>>> +        .tlv_type    = 0x33,
>>>>> +        .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>>>> +                       dynamic_mem_support),
>>>>> +    },
>>>>>        {
>>>>>            .data_type    = QMI_EOTI,
>>>>>            .array_type    = NO_ARRAY,
>>>>> @@ -602,6 +620,24 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
>>>>>            .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>>>>                           single_chip_mlo_support),
>>>>>        },
>>>>> +    {
>>>>> +        .data_type      = QMI_OPT_FLAG,
>>>>> +        .elem_len       = 1,
>>>>> +        .elem_size      = sizeof(u8),
>>>>> +        .array_type     = NO_ARRAY,
>>>>> +        .tlv_type       = 0x17,
>>>>> +        .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>>>> +                       dynamic_ddr_support_valid),
>>>>> +    },
>>>>> +    {
>>>>> +        .data_type      = QMI_UNSIGNED_1_BYTE,
>>>>> +        .elem_len       = 1,
>>>>> +        .elem_size      = sizeof(u8),
>>>>> +        .array_type     = NO_ARRAY,
>>>>> +        .tlv_type       = 0x17,
>>>>> +        .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>>>> +                       dynamic_ddr_support),
>>>>> +    },
>>>>>        {
>>>>>            .data_type    = QMI_EOTI,
>>>>>            .array_type    = NO_ARRAY,
>>>>> @@ -2248,6 +2284,11 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
>>>>>        if (ret < 0)
>>>>>            goto out;
>>>>>    +    if (ab->qmi.dynamic_ddr_support) {
>>>>> +        req.dynamic_mem_support_valid = 1;
>>>>> +        req.dynamic_mem_support = 1;
>>>>> +    }
>>>>> +
>>>>>        ret = qmi_txn_init(&ab->qmi.handle, &txn,
>>>>>                   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
>>>>>        if (ret < 0)
>>>>> @@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>>>>>          ab->qmi.num_radios = resp.num_phy;
>>>>>    +    if (resp.dynamic_ddr_support_valid)
>>>>> +        ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
>>>>> +
>>>>>        ath12k_dbg(ab, ATH12K_DBG_QMI,
>>>>> -           "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
>>>>> +           "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %d dynamic_ddr_support %d\n",
>>>>>               resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
>>>>> -           resp.num_phy_valid, resp.num_phy,
>>>>> -           resp.board_id_valid, resp.board_id);
>>>>> +           resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
>>>>> +           resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
>>>>>          return;
>>>>>    diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
>>>>> index 2a63e214eb42..dbde76e5a78d 100644
>>>>> --- a/drivers/net/wireless/ath/ath12k/qmi.h
>>>>> +++ b/drivers/net/wireless/ath/ath12k/qmi.h
>>>>> @@ -156,9 +156,10 @@ struct ath12k_qmi {
>>>>>        struct m3_mem_region aux_uc_mem;
>>>>>        unsigned int service_ins_id;
>>>>>        struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
>>>>> +    u8 dynamic_ddr_support;
>>>>>    };
>>>>>    -#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN        261
>>>>> +#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN        265
>>>>>    #define QMI_WLANFW_HOST_CAP_REQ_V01            0x0034
>>>>>    #define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN    7
>>>>>    #define QMI_WLFW_HOST_CAP_RESP_V01            0x0034
>>>>> @@ -258,7 +259,8 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
>>>>>        struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
>>>>>        u8 feature_list_valid;
>>>>>        u64 feature_list;
>>>>> -
>>>>> +    u8 dynamic_mem_support_valid;
>>>>> +    u8 dynamic_mem_support;
>>>>>    };
>>>>>      struct qmi_wlanfw_host_cap_resp_msg_v01 {
>>>>> @@ -267,7 +269,7 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
>>>>>      #define QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN        0
>>>>>    #define QMI_WLANFW_PHY_CAP_REQ_V01            0x0057
>>>>> -#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN        18
>>>>> +#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN        22
>>>>
>>>> this is not used anywhere, but since you're touching it should this be 26 ? response TLV 7, num_phy 4, board_id 7, existing single_chip_mlo_support 4, and new dynamic_ddr_support 4
>>>>
>>>>
>>>> -- 
>>>> Ramesh
>>>
>>> I checked the driver and found there are several unused QMI_*_RESP_MSG_LEN macros.
>>> Since this macro is not used anywhere, I think it is better to remove this
>>> change from the current patch.
>>> I will send a separate cleanup patch to remove all unused QMI macros.
>>>
>>> Hope that’s fine with you.
>>>
>>
>>
>> I couldn’t trace the history either.
>> My guess is that the response-length macro was retained either as schema 
>> documentation or to keep it consistent with the generated QMI definitions.
>>
>> Jeff may be able to confirm the original intent.
> 
> I suspect this was from the code generator and was just pulled in.
> Concur we should just drop this (and have a cleanup patch to remove any others
> that are unused).
> 
> And this V01 naming convention seems broken since we've regularly extended
> messages and yet still call them V01. I would have expected each extension
> would have incremented the version number...
> 
> And I also think it is strange to pass the message length anyway since the
> serializer should be able to figure that out -- having the clients pass that
> means the clients must know the details of the serialization algorithm which
> is a layering violation. But that is a preexisting issue with the QMI interface.
> 
> /jeff
> 
> /jeff
>>
> 

Thanks for the clarification. I will drop this change in the next version and
send a separate cleanup patch to remove the unused QMI response length macros.


