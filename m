Return-Path: <linux-wireless+bounces-37896-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7m63L1K7M2pdFgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37896-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:33:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A969EE68
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:33:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=faK3GOey;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=R3AAnxYc;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37896-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37896-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E71AC3057606
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56213C76BD;
	Thu, 18 Jun 2026 09:29:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1BA3D9DC5
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:29:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774961; cv=none; b=gGP7tt+MCqhhQrrOXdMHtAvR1w0nxMNVQmQPll64WkZQppJ6WF8HQfLBT1I61ud58zqUdby/EA7fikRv4VKZ8GRaFal5/1NY7chWhn/WpLvkazp9TCzIzawphOkN+Y8AKFHpHoYrZdOkqYsJd6n/xlOIZGtcfrGoNRjgiHym3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774961; c=relaxed/simple;
	bh=VXCdMz7jouQx7i8t+dDa2BZUgklsd5hKP9QxdaoMSiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDppLWrsiWsekrZ6kR6DMOn9VcFH6AeJcobQCXzSEcSbfpLkjVVvzeWkYQ9Su7pmb28fQiNuSWMK7bQ6EmTvtt5drSivSoedhuc5jcku9JOxStzmQHieLdLNFXSYyL1fhDGhjCEvaJ/iWY//rqDc3ik1Vqh3s2Hb1ZpHYCjqdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=faK3GOey; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R3AAnxYc; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8Dt3q2246972
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h/SLGDVSPRDEUNYHuypX30EWs1xc9l3jLHZ+M27X13U=; b=faK3GOeyMd43FnHm
	d/IPRnww+uj/Oa+Mt6K5zZR7NlSMMDG7D2J8zr+kkO3RfUWCeDINgvW8QnF5JlnA
	Q6e1InJc0dl4ZTCBsFz2Rl31JcWKxEUCVkvQ8Gd2YdHWgQmF7QoBG5zWRN16cjq3
	etor/UDOccF12nr203JRmz5G1UmY0TDSGH5TzZJToqsyQZUk4lIXZlpCn91ZbQnV
	Pp5f3o3yCP6C6KQmLomtT+cLE1Z0uQR9M5nRo0e4A7FwvVNz9z0AIih+k8i33qWa
	IrQjmgVF6FrPt/N7BNKB5JENRx2adbCJUrHcViiwSitXdOy2/JOpzG6Ea3awYvxN
	ZF9oXQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vm8h3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:29:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84245e2bb00so721162b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781774959; x=1782379759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/SLGDVSPRDEUNYHuypX30EWs1xc9l3jLHZ+M27X13U=;
        b=R3AAnxYcvYm4ARA1zdZTwZ/yIdXujPzqdfwn7pGoZtowxYobyTCaCz4/VS3Pl3SjZa
         Gwiz0Gvsj0tXdghkdVV7eX1YQ7ldGlEz4m0MkEcvJrk/zfiBFoyoQ0O9jc5WFMG9aEdd
         r5gHReIQOMbNEOgOBE/gSOAaEY/G25zl3PFH6iB4wlHsvO1qJr0UoVGRQ2xAaaYa9MRt
         fpSVqsPxBQfGqtqJYh8i96v6f3RXP59ZY7+fGrklO6v5dxv3xvZEjUVJM5qDTtn3HSVq
         5WLYCQ7I0M3d5GiI3nj/6win2LHeXY/b6foKSZhrVTWye3pM8uQRvz3Ew1es3BNl9ceE
         3MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774959; x=1782379759;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/SLGDVSPRDEUNYHuypX30EWs1xc9l3jLHZ+M27X13U=;
        b=QU7drSHLD8PtJi3kyQIFFRTA+Hv7v6P1MtCH5mGAr68pfORToeWdls65Pw+Pf1PY/t
         QHD8TApkQcZq3IHAJwvW6x51YrmQzKOgB5UVu4ZJ6kU4Ey69HapGS6CBfoKD0CQF9fo9
         bThGATirZwLRbUNyZ2cLE9qI00cx/BOhr2f4/yX/aceEBfBSEkalyk2SCVwPXIZM9h4O
         99hT4YdIJCee73FZqHzDp+M2daButfAyoAxGht2256YUbOEAC0PnFdrJ04YFg1qhXGxA
         Dx0q2/I681W5uoIDowfpxf9wfFX//h66rtU3hOuSQ9VGQ3/ffhCnPCobZN1Ho+vZdIa7
         ToEg==
X-Gm-Message-State: AOJu0YzZ4R2RACQr0fM5vhPhHL7Vhr23WsWJrIrBAjbnzVEhm/np85KT
	/MJhPgU5nHgfKFoUUH1DMfi0JRKuFhBKAAC/2KlnH44ep3AKym/Ko4wzpdYkQ9dgaBb8Q6KQIqK
	Vu1VW5cgZDIP+BI+qGzRLkogWil31/Nm4WCCGJFptWBAXehoh94FkXcM5ScWQq2KSUImjoA==
X-Gm-Gg: AfdE7clWR/Z/JNJFU4PyY9PM7M1Fuitzhb+BX2nYRilSPX/aT+Y/zA50uzzDzrUVEBj
	3zYRAla4FORYyJyhEjDl3R8NMgLk9Yyq5u/lCfH7cTCq2moFhCgHRCTVm0eBTQjYyCyjxJmnZFH
	bR0vka0IYz0satyWvS24z7PzAu6QnrsCrlWO8DDVSRg7vLP2bjgjyZiOoFhxwlB8Itzg/V2ifO1
	lgRxn8ohbBkgNwfEbnsiu35CeUiJlbtzNe/LEYsR9+n0rpS0QnYsVrXoclByYm7yIOXvcLcjQ6I
	p7Dik/TjIfW9nE8VrnT9r0Jd3xjx9IskGjk98ClmcyoUJsTqKr5wVDrr/0kBEZcSES0pFu4Q0Lr
	PRwPqGNTr8Jg3B8dwxS/RjnNezBD6u+Np7vGCrxoseIm+dMHM6Gk=
X-Received: by 2002:a05:6a00:ac8:b0:842:8500:95f1 with SMTP id d2e1a72fcca58-845245bbf8emr8134943b3a.40.1781774958754;
        Thu, 18 Jun 2026 02:29:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac8:b0:842:8500:95f1 with SMTP id d2e1a72fcca58-845245bbf8emr8134883b3a.40.1781774958138;
        Thu, 18 Jun 2026 02:29:18 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434aca3041sm19249025b3a.5.2026.06.18.02.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:29:17 -0700 (PDT)
Message-ID: <96953b10-379b-41d9-a151-68982b9a9854@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:59:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: add QMI capability negotiation for
 dynamic memory mode
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org
References: <20260601031850.3715354-1-aaradhana.sahu@oss.qualcomm.com>
 <7f3f0f10-3493-49b7-ac6d-cc5efca24746@oss.qualcomm.com>
 <4fc10b44-3107-4e0b-9b1f-793713c28e0f@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4fc10b44-3107-4e0b-9b1f-793713c28e0f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C0aLclrbg71ak7WjNTEdsovtqGODJpq4
X-Proofpoint-GUID: C0aLclrbg71ak7WjNTEdsovtqGODJpq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4NyBTYWx0ZWRfXyMu9wEHnRI55
 SsPwSYQ2WV4Wa3H8JumUxlQbdKZcUR8NUQg2i/Js+AVwf1HLHkbT48KdIB9FUM+LNZ/SZ2UZxZQ
 JVbkQn0V9oOeGpoOMKpL/I0AUlk3X4gbrvMbSSjizd9SRS3O4qoqlpDEooZxbDQA+G3jg0vKMUa
 DH0uKa/7VUhLLAERh6ncsBbbjoszrG07tWamV0XbeTc/d1DkXdsOxWNTsXz2sN/kN1zjTtWQQIi
 iblQbypzurX9ARQTmelFE4C544qFwZh2VlD5stqUIt9ry9Qn0E58a+8iZ8z1GsfVrY/uqT5ZYdn
 7o7KjrVumRcL6g3fMRYnXJYly1FZ3Ds1iHsdYGGJ+joMg8+lK7DsLK/vsJnINCPaiQS+KjgsvIB
 d/YRyTzfuOrja4LgKaZrsJtLlNwQhNI/G58CK7OQ49NGO9bcriW0AR8dceoO4Nxu6zasBDIB2Nr
 m3nGAIu0GIvnDMKmkbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4NyBTYWx0ZWRfX3AS6wuKM3rBI
 J07gXhn4U7xlVbn7EMU6FBPkkS/qT4dqkGnvY95gtv/jWBjNpuSbbcxvhsG6KBGNtAzErH8vCb5
 L6vd9QyBZbvitjNlFNOoOZiuG3uBbW4=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33ba6f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=lR1UrLcOgk-yx1UTwkYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37896-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:rameshkumar.sundaram@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 300A969EE68

On 6/18/2026 2:22 PM, Aaradhana Sahu wrote:
> 
> 
> On 6/18/2026 12:18 PM, Rameshkumar Sundaram wrote:
>> On 6/1/2026 8:48 AM, Aaradhana Sahu wrote:
>>> On AHB platforms, firmware operates in two modes: fixed-memory mode where
>>> firmware uses hardcoded addresses for memory regions such as BDF and does
>>> not request HOST_DDR memory from the host, and dynamic-memory mode where
>>> firmware expects the host to provide memory addresses including HOST_DDR
>>> after the Q6 read-only region and relies on host allocation for all memory
>>> types.
>>>
>>> Introduce QMI capability negotiation to support both modes. Add a new QMI
>>> PHY capability flag dynamic_ddr_support which is advertised by firmware to
>>> indicate it supports dynamic memory mode. When the host detects this
>>> capability, set the dynamic_mem_support flag in the host capability message
>>> to signal the host is ready to provide dynamic memory allocation. This
>>> triggers firmware to send the HOST_DDR memory request and use the
>>> host-provided address.
>>>
>>> For backward compatibility, if firmware doesn't advertise
>>> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
>>> where firmware uses predefined addresses.
>>>
>>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
>>> ---
>>>    drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
>>>    drivers/net/wireless/ath/ath12k/qmi.h | 10 ++++--
>>>    2 files changed, 54 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>>> index fd762b5d7bb5..85406d6e6da1 100644
>>> --- a/drivers/net/wireless/ath/ath12k/qmi.c
>>> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
>>> @@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
>>>            .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>>                           feature_list),
>>>        },
>>> +    {
>>> +        .data_type    = QMI_OPT_FLAG,
>>> +        .elem_len    = 1,
>>> +        .elem_size    = sizeof(u8),
>>> +        .array_type    = NO_ARRAY,
>>> +        .tlv_type    = 0x33,
>>> +        .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>> +                       dynamic_mem_support_valid),
>>> +    },
>>> +    {
>>> +        .data_type    = QMI_UNSIGNED_1_BYTE,
>>> +        .elem_len    = 1,
>>> +        .elem_size    = sizeof(u8),
>>> +        .array_type    = NO_ARRAY,
>>> +        .tlv_type    = 0x33,
>>> +        .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>> +                       dynamic_mem_support),
>>> +    },
>>>        {
>>>            .data_type    = QMI_EOTI,
>>>            .array_type    = NO_ARRAY,
>>> @@ -602,6 +620,24 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
>>>            .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>>                           single_chip_mlo_support),
>>>        },
>>> +    {
>>> +        .data_type      = QMI_OPT_FLAG,
>>> +        .elem_len       = 1,
>>> +        .elem_size      = sizeof(u8),
>>> +        .array_type     = NO_ARRAY,
>>> +        .tlv_type       = 0x17,
>>> +        .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>> +                       dynamic_ddr_support_valid),
>>> +    },
>>> +    {
>>> +        .data_type      = QMI_UNSIGNED_1_BYTE,
>>> +        .elem_len       = 1,
>>> +        .elem_size      = sizeof(u8),
>>> +        .array_type     = NO_ARRAY,
>>> +        .tlv_type       = 0x17,
>>> +        .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>> +                       dynamic_ddr_support),
>>> +    },
>>>        {
>>>            .data_type    = QMI_EOTI,
>>>            .array_type    = NO_ARRAY,
>>> @@ -2248,6 +2284,11 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
>>>        if (ret < 0)
>>>            goto out;
>>>    +    if (ab->qmi.dynamic_ddr_support) {
>>> +        req.dynamic_mem_support_valid = 1;
>>> +        req.dynamic_mem_support = 1;
>>> +    }
>>> +
>>>        ret = qmi_txn_init(&ab->qmi.handle, &txn,
>>>                   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
>>>        if (ret < 0)
>>> @@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>>>          ab->qmi.num_radios = resp.num_phy;
>>>    +    if (resp.dynamic_ddr_support_valid)
>>> +        ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
>>> +
>>>        ath12k_dbg(ab, ATH12K_DBG_QMI,
>>> -           "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
>>> +           "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %d dynamic_ddr_support %d\n",
>>>               resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
>>> -           resp.num_phy_valid, resp.num_phy,
>>> -           resp.board_id_valid, resp.board_id);
>>> +           resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
>>> +           resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
>>>          return;
>>>    diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
>>> index 2a63e214eb42..dbde76e5a78d 100644
>>> --- a/drivers/net/wireless/ath/ath12k/qmi.h
>>> +++ b/drivers/net/wireless/ath/ath12k/qmi.h
>>> @@ -156,9 +156,10 @@ struct ath12k_qmi {
>>>        struct m3_mem_region aux_uc_mem;
>>>        unsigned int service_ins_id;
>>>        struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
>>> +    u8 dynamic_ddr_support;
>>>    };
>>>    -#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN        261
>>> +#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN        265
>>>    #define QMI_WLANFW_HOST_CAP_REQ_V01            0x0034
>>>    #define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN    7
>>>    #define QMI_WLFW_HOST_CAP_RESP_V01            0x0034
>>> @@ -258,7 +259,8 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
>>>        struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
>>>        u8 feature_list_valid;
>>>        u64 feature_list;
>>> -
>>> +    u8 dynamic_mem_support_valid;
>>> +    u8 dynamic_mem_support;
>>>    };
>>>      struct qmi_wlanfw_host_cap_resp_msg_v01 {
>>> @@ -267,7 +269,7 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
>>>      #define QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN        0
>>>    #define QMI_WLANFW_PHY_CAP_REQ_V01            0x0057
>>> -#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN        18
>>> +#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN        22
>>
>> this is not used anywhere, but since you're touching it should this be 26 ? response TLV 7, num_phy 4, board_id 7, existing single_chip_mlo_support 4, and new dynamic_ddr_support 4
>>
>>
>> -- 
>> Ramesh
> 
> I checked the driver and found there are several unused QMI_*_RESP_MSG_LEN macros.
> Since this macro is not used anywhere, I think it is better to remove this
> change from the current patch.
> I will send a separate cleanup patch to remove all unused QMI macros.
> 
> Hope that’s fine with you.
> 


I couldn’t trace the history either.
My guess is that the response-length macro was retained either as schema 
documentation or to keep it consistent with the generated QMI definitions.

Jeff may be able to confirm the original intent.

-- 
--
Ramesh


