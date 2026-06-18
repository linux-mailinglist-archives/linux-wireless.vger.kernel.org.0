Return-Path: <linux-wireless+bounces-37909-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EEEMFGZ+NGpgZgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37909-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 01:25:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 970776A3132
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 01:25:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Im2H85t8;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LnOE26UI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37909-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37909-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CEB3020D4B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 23:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DA2D0C7B;
	Thu, 18 Jun 2026 23:25:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5561C84D0
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 23:25:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781825123; cv=none; b=Ov/yc4dKRIrcTff/MnEOQzX/wt2h4XJMLX1K1FwqtBvgc3IoOios4xB3trga3XhWrnZZ429MqC+iYv7DJdHWeBjeqfYj7vEPB+3WUx2YnoCgJDFSP2JYD/dU5I5MVcNlIgZ/WZIOtO5BqK/xl7m4Z32VsjjsQGN3Ax0kaL5wQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781825123; c=relaxed/simple;
	bh=Pslo6pp/6v+aEdGhI7QLmY+jR+dRDNxuSROC1qsCUW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7FSbE8BTbnp0jtnupy70IOgqQRerxWVUH+3HTP/sQLTEDGB81DrOS34eIfQnmh7StW74EyJPokilEuD+LtaD3IldQCOEumoRjXCuuLQ7qsMPuyYBHPH+5BpfPD0yJW2FTo6C+213d06rejP5eoH16Za2CLN2ZgqDvYUD6A1LjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Im2H85t8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LnOE26UI; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ILsX5v2820397
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 23:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9qXUzXn3LdTYjBBbXkLUO37GGMdGJbECqEM7fvxt1Q=; b=Im2H85t8vqOhGtwL
	Uy1BmZZOugYrGfUN+vsdEg93HnvxRNO3+2zLpD0vBfFuLwFWXuHs6LgEcs18AP6K
	jks0lu3DnomSS3KrVZ12b7o+PyfIlvkFSpR5XggwbLNTb4y/ezpQPnhtumqKtgTb
	8ZtcS7ukg5FCKtwppUaEPjPrDyQb/rg0OqIX1a1Qi2XzfG2+voGvI0OuSOnWYAst
	u2BMRVfHo4jySsBtiZCuXn01GFIqX5gpu3vEpuRNW34kLZjSS0x14IYfCfza3/r0
	oxTDiiyBL562UWrDcchiPNJ40HfKvgB3moiY7cwWM/QiMMjSUDs8kZPZU0LxcR1x
	5DCU9Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6s944p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 23:25:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so34365eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781825119; x=1782429919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9qXUzXn3LdTYjBBbXkLUO37GGMdGJbECqEM7fvxt1Q=;
        b=LnOE26UI/JD/GSUD0yYzNBdwFSiXyjlf5sw4qT/zrGPKyi0xFgOusEYuOGXOUeeuNe
         Woudknn2DHV6rs9kl+S6OaWCpjuczz6R0PG4IWXslHzegvlW92DPTYpoHUZ6QmtuLQdD
         Bs3Qty3bo3juCypv1gHupKMDRR4x+vm/T6/kM9MSjdWyV/doEy4fGW+lqXAyL6PPFK1R
         AQP85xesQpQXjaRB/mYmkBk4FmnLQCueDm77UmutY0wvfeIhD0sPJDTCT/9I8Nw0qS+a
         218B1WzGFA1jdnKOGawcV1f0NVyxXYVO4Mjo1aWuN9PqhKPh7CJKEJT3ZOWVB35KC9aP
         o4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781825119; x=1782429919;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9qXUzXn3LdTYjBBbXkLUO37GGMdGJbECqEM7fvxt1Q=;
        b=er2OYApz7+AUBGKzUYdYXb5ruhqUeJWm3B/fPiihZHlapAB+1WoYEz/DoY69iOpaLo
         EzsGtf9bxDcgaRLtM6QEfUqtra5v3lLNlonX3S6/k/ExOh6eb7DeGFMc+nCptW5GUXSW
         QX9jF2JprFmAgav6pK1LJH54zUPAhjS4CH48SUIyzA0kBC+Q0/D2ZcwT0YDUdcmhPtdE
         qqFo1r4QvAM5ctQaDK82iNdIa6jmpeIshn3CKiWxBw2CBvjDI/cesH0E2QtEJJiYrmjv
         VYFVA8kYbY9V4yVvBD8SJM9/RwDhqg/skOzSOP7JUpwCb9sNICrpM76gGjw9epWtf3/M
         X5Yw==
X-Gm-Message-State: AOJu0YzpjFTSnIhpVA/oBXgMzN/5wpylsErUp8XYrO1I69gUP5H5NxHl
	T2lrUOX/pPILBWmertk0htbD/D7muq9f6g/ux5ejXYuvnoppNonjgOrWcW9pTJhbHhiANaIXzCj
	itAoI0hANqhjX/e/n6PIT+eCgiD4ASM8p172oQMRQqEfvt1OQBgEobngdWEV4GQWvPmS4WQ==
X-Gm-Gg: AfdE7cnwFKkWBqbEgtG6hx4HNwQuX3iq2tnj900hwkLeC9EjxJaulPCawFdejIFH7r/
	bvyJVIqCyZi/ZidgB0AdhczWvcwVUJIYOI528m91kgUkWZQECF+YBtAZlhWgWmYvdKaSmTYJ4ri
	I//d24D0QSHgxgKtyHAAx+IhNxhOMiKAD7D/oV8Y4KiDR9H+psI/gmFCN1B7MkDpN4oH5K9w33+
	qVMC/KaHkXNDA0sLsppmvHqHFlTCLysA8720NtTjoFZa3A0G9Z5Vii+Y36uiqCr5T5xDn5R6wFo
	EmGohrRsOeQbspqLH4WxQmVY6/T3KoyBOsNPc0WMwjPpiPfzgdHe+t+i8pg43Joe0j0y0Vus4OS
	11OrujNTTwrOw1llj6kkauxvoQz+zDpCdI1URzLZnCbvrEMEgiihchbXiSm8YyetpFxGzEByxkO
	TGzxU=
X-Received: by 2002:a05:7022:6890:b0:138:4023:8c1 with SMTP id a92af1059eb24-139a4eca6f2mr86578c88.11.1781825119366;
        Thu, 18 Jun 2026 16:25:19 -0700 (PDT)
X-Received: by 2002:a05:7022:6890:b0:138:4023:8c1 with SMTP id a92af1059eb24-139a4eca6f2mr86561c88.11.1781825118803;
        Thu, 18 Jun 2026 16:25:18 -0700 (PDT)
Received: from [192.168.1.31] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139a3668243sm429870c88.14.2026.06.18.16.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 16:25:17 -0700 (PDT)
Message-ID: <17927ece-f0e3-4014-9143-891a15344bef@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:25:16 -0700
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
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org
References: <20260601031850.3715354-1-aaradhana.sahu@oss.qualcomm.com>
 <7f3f0f10-3493-49b7-ac6d-cc5efca24746@oss.qualcomm.com>
 <4fc10b44-3107-4e0b-9b1f-793713c28e0f@oss.qualcomm.com>
 <96953b10-379b-41d9-a151-68982b9a9854@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <96953b10-379b-41d9-a151-68982b9a9854@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Site0f_TSyijskW9PCy91sGWmyGYTNyS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIxNCBTYWx0ZWRfX1SRA3rnm+ZfN
 +Xb2QLCJRWLTzo24QvehywdYqcittcFeh3hwXj8PAF4hVknaj18YNFV7RcBvCqQL/py9tnPDDWy
 dnlC15fU0RlBPR6SYXnGzBX7RpoWwIB1tF5+qf4Tnriea6XmT891tVVMXh8gAxvW8dtLwGVu6BY
 o/fTwp5sgodcogoRXctsRHLBkyv9o6MfTnoBLilLzsgVukwcTAteEz8i/AYcDrecPpdzAyrpxUC
 eSMJ/21cbGNlgMke9Nh3qsgPBTEFpyVm2UitJQTNwehhDdMV7trYnAHJK0yq7mVmN+7+LE7fcuj
 DmKuNBTELwG6MQ8VdIU9FDvj8Jew1bR7GV1qwJpIDSxulsKTnRpWWqGXNblozmTFobK5ExDT60o
 A7Tz3CresUNHyzNTTYIUdu5tXQis8aoXOvV5KWomELdMpYFtUK1VfSDeSpXH5PtgpCVxBj3ATHL
 M+x0xnIxjuSx47FT+Lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIxNCBTYWx0ZWRfX7mo3oKrQXTHf
 hi0cwWbJ1jRgtdDO6LjXrm//armAW9wVRLLAnF7hhtNQARVhX4+rQ/6uyY0yR12DbMzKEEDsq03
 xNiZriYzrBrRXpuEEDUrAQZI/44BLjM=
X-Proofpoint-ORIG-GUID: Site0f_TSyijskW9PCy91sGWmyGYTNyS
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a347e60 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=RrAT5ANuwF0vCIftLWUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180214
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37909-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rameshkumar.sundaram@oss.qualcomm.com,m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 970776A3132

On 6/18/2026 2:29 AM, Rameshkumar Sundaram wrote:
> On 6/18/2026 2:22 PM, Aaradhana Sahu wrote:
>>
>>
>> On 6/18/2026 12:18 PM, Rameshkumar Sundaram wrote:
>>> On 6/1/2026 8:48 AM, Aaradhana Sahu wrote:
>>>> On AHB platforms, firmware operates in two modes: fixed-memory mode where
>>>> firmware uses hardcoded addresses for memory regions such as BDF and does
>>>> not request HOST_DDR memory from the host, and dynamic-memory mode where
>>>> firmware expects the host to provide memory addresses including HOST_DDR
>>>> after the Q6 read-only region and relies on host allocation for all memory
>>>> types.
>>>>
>>>> Introduce QMI capability negotiation to support both modes. Add a new QMI
>>>> PHY capability flag dynamic_ddr_support which is advertised by firmware to
>>>> indicate it supports dynamic memory mode. When the host detects this
>>>> capability, set the dynamic_mem_support flag in the host capability message
>>>> to signal the host is ready to provide dynamic memory allocation. This
>>>> triggers firmware to send the HOST_DDR memory request and use the
>>>> host-provided address.
>>>>
>>>> For backward compatibility, if firmware doesn't advertise
>>>> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
>>>> where firmware uses predefined addresses.
>>>>
>>>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
>>>> ---
>>>>    drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
>>>>    drivers/net/wireless/ath/ath12k/qmi.h | 10 ++++--
>>>>    2 files changed, 54 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>>>> index fd762b5d7bb5..85406d6e6da1 100644
>>>> --- a/drivers/net/wireless/ath/ath12k/qmi.c
>>>> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
>>>> @@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
>>>>            .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>>>                           feature_list),
>>>>        },
>>>> +    {
>>>> +        .data_type    = QMI_OPT_FLAG,
>>>> +        .elem_len    = 1,
>>>> +        .elem_size    = sizeof(u8),
>>>> +        .array_type    = NO_ARRAY,
>>>> +        .tlv_type    = 0x33,
>>>> +        .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>>> +                       dynamic_mem_support_valid),
>>>> +    },
>>>> +    {
>>>> +        .data_type    = QMI_UNSIGNED_1_BYTE,
>>>> +        .elem_len    = 1,
>>>> +        .elem_size    = sizeof(u8),
>>>> +        .array_type    = NO_ARRAY,
>>>> +        .tlv_type    = 0x33,
>>>> +        .offset        = offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>>>> +                       dynamic_mem_support),
>>>> +    },
>>>>        {
>>>>            .data_type    = QMI_EOTI,
>>>>            .array_type    = NO_ARRAY,
>>>> @@ -602,6 +620,24 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
>>>>            .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>>>                           single_chip_mlo_support),
>>>>        },
>>>> +    {
>>>> +        .data_type      = QMI_OPT_FLAG,
>>>> +        .elem_len       = 1,
>>>> +        .elem_size      = sizeof(u8),
>>>> +        .array_type     = NO_ARRAY,
>>>> +        .tlv_type       = 0x17,
>>>> +        .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>>> +                       dynamic_ddr_support_valid),
>>>> +    },
>>>> +    {
>>>> +        .data_type      = QMI_UNSIGNED_1_BYTE,
>>>> +        .elem_len       = 1,
>>>> +        .elem_size      = sizeof(u8),
>>>> +        .array_type     = NO_ARRAY,
>>>> +        .tlv_type       = 0x17,
>>>> +        .offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>>>> +                       dynamic_ddr_support),
>>>> +    },
>>>>        {
>>>>            .data_type    = QMI_EOTI,
>>>>            .array_type    = NO_ARRAY,
>>>> @@ -2248,6 +2284,11 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
>>>>        if (ret < 0)
>>>>            goto out;
>>>>    +    if (ab->qmi.dynamic_ddr_support) {
>>>> +        req.dynamic_mem_support_valid = 1;
>>>> +        req.dynamic_mem_support = 1;
>>>> +    }
>>>> +
>>>>        ret = qmi_txn_init(&ab->qmi.handle, &txn,
>>>>                   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
>>>>        if (ret < 0)
>>>> @@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>>>>          ab->qmi.num_radios = resp.num_phy;
>>>>    +    if (resp.dynamic_ddr_support_valid)
>>>> +        ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
>>>> +
>>>>        ath12k_dbg(ab, ATH12K_DBG_QMI,
>>>> -           "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
>>>> +           "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %d dynamic_ddr_support %d\n",
>>>>               resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
>>>> -           resp.num_phy_valid, resp.num_phy,
>>>> -           resp.board_id_valid, resp.board_id);
>>>> +           resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
>>>> +           resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
>>>>          return;
>>>>    diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
>>>> index 2a63e214eb42..dbde76e5a78d 100644
>>>> --- a/drivers/net/wireless/ath/ath12k/qmi.h
>>>> +++ b/drivers/net/wireless/ath/ath12k/qmi.h
>>>> @@ -156,9 +156,10 @@ struct ath12k_qmi {
>>>>        struct m3_mem_region aux_uc_mem;
>>>>        unsigned int service_ins_id;
>>>>        struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
>>>> +    u8 dynamic_ddr_support;
>>>>    };
>>>>    -#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN        261
>>>> +#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN        265
>>>>    #define QMI_WLANFW_HOST_CAP_REQ_V01            0x0034
>>>>    #define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN    7
>>>>    #define QMI_WLFW_HOST_CAP_RESP_V01            0x0034
>>>> @@ -258,7 +259,8 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
>>>>        struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
>>>>        u8 feature_list_valid;
>>>>        u64 feature_list;
>>>> -
>>>> +    u8 dynamic_mem_support_valid;
>>>> +    u8 dynamic_mem_support;
>>>>    };
>>>>      struct qmi_wlanfw_host_cap_resp_msg_v01 {
>>>> @@ -267,7 +269,7 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
>>>>      #define QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN        0
>>>>    #define QMI_WLANFW_PHY_CAP_REQ_V01            0x0057
>>>> -#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN        18
>>>> +#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN        22
>>>
>>> this is not used anywhere, but since you're touching it should this be 26 ? response TLV 7, num_phy 4, board_id 7, existing single_chip_mlo_support 4, and new dynamic_ddr_support 4
>>>
>>>
>>> -- 
>>> Ramesh
>>
>> I checked the driver and found there are several unused QMI_*_RESP_MSG_LEN macros.
>> Since this macro is not used anywhere, I think it is better to remove this
>> change from the current patch.
>> I will send a separate cleanup patch to remove all unused QMI macros.
>>
>> Hope that’s fine with you.
>>
> 
> 
> I couldn’t trace the history either.
> My guess is that the response-length macro was retained either as schema 
> documentation or to keep it consistent with the generated QMI definitions.
> 
> Jeff may be able to confirm the original intent.

I suspect this was from the code generator and was just pulled in.
Concur we should just drop this (and have a cleanup patch to remove any others
that are unused).

And this V01 naming convention seems broken since we've regularly extended
messages and yet still call them V01. I would have expected each extension
would have incremented the version number...

And I also think it is strange to pass the message length anyway since the
serializer should be able to figure that out -- having the clients pass that
means the clients must know the details of the serialization algorithm which
is a layering violation. But that is a preexisting issue with the QMI interface.

/jeff

/jeff
> 


