Return-Path: <linux-wireless+bounces-37885-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pkl5JuGUM2rTDgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37885-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:49:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E401969DEC2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:49:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BmyuCYaL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UvETMRLO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37885-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37885-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 894A53008D2B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1170236AB6B;
	Thu, 18 Jun 2026 06:48:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF723ACF0F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 06:48:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765323; cv=none; b=LJ6jizUnz84B+zsG0cRUKdtQonpMLAaujbTlpZonqCghCaqiAswnyj/PhWwxukPffjrk0c2O0slzTZLFjJVwFLEBWr6MtnBNQRN/C4LGzMW/UMJey1go9i2WSb4JC5YxKTsUT+bDeG0nIgWe7jUueIfRO9aWs0aSfb/92uTCZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765323; c=relaxed/simple;
	bh=2Kz5DttFEkjLVf7W+IhTdU0AhUw+W6YL3uA2M38U74E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bp1jF4c/OD5fnbyaGL+QQK/wK1h6mA7+e88hcFQ5P6sKSzXAw0azSgpPKaamErZZGOLbweSz/kVqs9ua9SV1d+2bpXiw3kD5tIDCSxuYCDtPpVQ6tYIzh4KpjQyDpnKKLOu4UVYOAMlmApgb6ollE9xAH+wCUgNG5qFzHdsKk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmyuCYaL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UvETMRLO; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I5TvOT3525651
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 06:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DrtbwHg7g8B0ePTgRXRw8zIJ6gu911BC8063CDsGf/8=; b=BmyuCYaLWZOqeEcR
	ReR71vFQSmzERD6YQ9tM8buA4DyxJEc7fOXeAsXo4JAmsWBy4NbbmxF+2nVGw950
	y+S/CBeCrAzCzNqaZF2WpJmBg6fL8aCXXQytoEV264lhfzzPwiF+TG5p+JTkgkVH
	LHJQXJYTHcI7WCfwWramiaUHNf835oUb9OQdEf0moSy/2KRN/+JviblpVuDUNGL3
	GlyR9my6z/zSa9+EcgBD/9cqqU4SarrSlig5OmSl8iLpo8ToZOs3m1+H+nMovGe1
	ctCs+XLCYAdxhWOuVYlgqA5++t7kQpwmCXSdlMFhHUdxDRrC53SZB2S0TG2rI6uD
	uI6VHA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1rtt0sq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 06:48:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84540d59430so292259b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781765318; x=1782370118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrtbwHg7g8B0ePTgRXRw8zIJ6gu911BC8063CDsGf/8=;
        b=UvETMRLOiS5nc6/wvlg2QpKykJDuDFVflYN9d0cIKpDtt+CZRRd2WjS/P932naSai4
         WtrvcOfT0cxSFRJ+i8i+9bekX4UEJ6hx9rYigHzg/R6mqIT9uYERZxY/Bvi0pDSFda/0
         /WDseJifnzd8kkqS2Pfh6+0LZOK7BW3bY5swWYcUUgjZAt/orU18TD+5NlDzjd3TmS23
         8vH6JYZjcH7GYb04LALzOffn69WLKS1ts9fvIyzUtxpZU1ARAiJ45aeSXeiw43c+1arm
         wgFq7+m7cqRL8+OKI03z05fexF47RFmOI+s6X+dZjoM7/P1n48MIJvrvDUdDWwyDQZgG
         KPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781765318; x=1782370118;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrtbwHg7g8B0ePTgRXRw8zIJ6gu911BC8063CDsGf/8=;
        b=BKq0MaclWyUf9xiHmgzGPYFymC2T7niqOBpLdffAA6IEg877nnZVRKhG4fnvPY08sg
         0l4W/AA6jqKKNhe0MylbkQnhS4tis6UTGxbkUdZS0YOheYHtf/MnMZWAj7weQbgPLZjR
         fVisRU5uAzFxmSovdfrD/SvdgEk5IIAHz/pGD1GpQUz4tEzX0IpTTk/kiEc9V5phK52l
         Fg2VVhIxuklkheJcbHrPBAiWsb8vwrsS8mzFnJXl24sFWB+D7uUTvougmWPH7Q+VWNlW
         EMhcDUy63VWH9FIxM0LumbeKbJOqL8cRFEMuHkU3STdJNByjS+EIX5IYTySHJV5PQnwJ
         A/AA==
X-Gm-Message-State: AOJu0YzRX24JDfpNAA0M++MsJe0nMom2vbZkxD2DI62yRXd699W5W4me
	3SnrmpTK2XqzryKjs0UQ2NVrqtTr9ha5kyaVhE8jC91FVcvmBNRSkpG2q9Sh1i7JziFniJam8Q+
	yoN+oU5yq3KmzBdGyVrqkdD2SO6K9bPncvfuuBUYWrCFLGwky9tkxnoOXGe5P6c/FvmT3Q8tTre
	iMtg==
X-Gm-Gg: AfdE7cmTEPWDNdCnGzpAAnNpZ8y6rS9Iw6DhSMwfOamvFXnn+Fr08EsPEdR4SHAe0o+
	65HKD8dXUAfOPkrQ6LLh2ekdNn9orQCDTEo4zmirdPv1Q0MYmGj6FPWCA0KuXhCNQ7atFNY4lsT
	4f7ZsK/YDuTc9OmG9TMwsXVwjZapzWx+MIxjjh+enwRTMyrBa5q6Q9xkqfodktjFiCxBik8ZYx1
	ZBOjLg+IQo0Z+Rs18g2C/9k8p8TM7zPQHQw0aqc0Or5Pke5yritWEn1O3BeJRY577Z1Uu4ORbnd
	s/Hmhsee3i4jxqS6Z4SGdcrRoYUwQ3iWKBtkHBhcYsHNIOdoqe+/e98Q1PG/vKBOfUYw8QOR2jU
	wbMGOUGM1MrB6jrvbU3tYm4KX1gsvfDF+Yb8tyBDIvtM/ifiomGc=
X-Received: by 2002:a05:6a00:3e22:b0:845:36e8:7a96 with SMTP id d2e1a72fcca58-84536e8a65bmr3566350b3a.26.1781765317680;
        Wed, 17 Jun 2026 23:48:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e22:b0:845:36e8:7a96 with SMTP id d2e1a72fcca58-84536e8a65bmr3566310b3a.26.1781765317155;
        Wed, 17 Jun 2026 23:48:37 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc825csm17984566b3a.36.2026.06.17.23.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 23:48:36 -0700 (PDT)
Message-ID: <7f3f0f10-3493-49b7-ac6d-cc5efca24746@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:18:32 +0530
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
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260601031850.3715354-1-aaradhana.sahu@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260601031850.3715354-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNpQXsZl c=1 sm=1 tr=0 ts=6a3394c6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=EZ2K36TrA9c0KxPFFEEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2MSBTYWx0ZWRfXxlJh4tAh3sDp
 UViiIE1LF2TnrfYJjta3R+EZVrWc7ttzp9xRAy785h6dk+Ix5RywkOo+czjFf90+CWJ08Jl3rxq
 ZwxJIuGZ+hH1egc61LNmlkTAuGwMoS+3EpRXjt28mgZPcrRgh8zsdoIoh9xkuvR/ioQtXMrvhUz
 j5nyvOnlDrD0hfBT5IAmnqpfyWs3luowDkr0OVnYUhGMXvRyMgEx6B4kqOax9S9khmytXQBQNOZ
 ZYtOeiQwOhwjJBJ8MYwEih9NCpXNDfqfenL6LlEzLgPJtCr6YHw5w4YPAdwNNN2gZKvjyGCqrrL
 dm7eyAN165zf4rnzuBViba8/RqLxo4zx+FJvfSBi0vVyLH2jMEImxZI3TCxJJ0CYoi9lXpyyLZT
 xajXJryhMRofnxx/VIi/WZWOx3+kb/kxxpf3JKLZwbQmgwXwtbiSzBNbiZJPuQ5W+wY7VfZ50Ow
 j2UuMUN7ntOvHpWWsbg==
X-Proofpoint-ORIG-GUID: Pjy7wP0VOmtKQ55xVHZpnSnZV9tStvaP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2MSBTYWx0ZWRfX7kglCG2rSfPR
 SmT9LWADNgO1izQ6009QwnTOWW9iBuLn3YIsw4sh02HMtJFwVAvxuWarQhZPqIpQZH9o/gx/5yx
 +wyTB/8baPdKWLqBMu6v0Kq0qPiG7Zk=
X-Proofpoint-GUID: Pjy7wP0VOmtKQ55xVHZpnSnZV9tStvaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37885-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E401969DEC2

On 6/1/2026 8:48 AM, Aaradhana Sahu wrote:
> On AHB platforms, firmware operates in two modes: fixed-memory mode where
> firmware uses hardcoded addresses for memory regions such as BDF and does
> not request HOST_DDR memory from the host, and dynamic-memory mode where
> firmware expects the host to provide memory addresses including HOST_DDR
> after the Q6 read-only region and relies on host allocation for all memory
> types.
> 
> Introduce QMI capability negotiation to support both modes. Add a new QMI
> PHY capability flag dynamic_ddr_support which is advertised by firmware to
> indicate it supports dynamic memory mode. When the host detects this
> capability, set the dynamic_mem_support flag in the host capability message
> to signal the host is ready to provide dynamic memory allocation. This
> triggers firmware to send the HOST_DDR memory request and use the
> host-provided address.
> 
> For backward compatibility, if firmware doesn't advertise
> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
> where firmware uses predefined addresses.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
>   drivers/net/wireless/ath/ath12k/qmi.h | 10 ++++--
>   2 files changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
> index fd762b5d7bb5..85406d6e6da1 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
>   		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>   					   feature_list),
>   	},
> +	{
> +		.data_type	= QMI_OPT_FLAG,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(u8),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x33,
> +		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
> +					   dynamic_mem_support_valid),
> +	},
> +	{
> +		.data_type	= QMI_UNSIGNED_1_BYTE,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(u8),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x33,
> +		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
> +					   dynamic_mem_support),
> +	},
>   	{
>   		.data_type	= QMI_EOTI,
>   		.array_type	= NO_ARRAY,
> @@ -602,6 +620,24 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
>   		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
>   					   single_chip_mlo_support),
>   	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x17,
> +		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
> +					   dynamic_ddr_support_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_1_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u8),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x17,
> +		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
> +					   dynamic_ddr_support),
> +	},
>   	{
>   		.data_type	= QMI_EOTI,
>   		.array_type	= NO_ARRAY,
> @@ -2248,6 +2284,11 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
>   	if (ret < 0)
>   		goto out;
>   
> +	if (ab->qmi.dynamic_ddr_support) {
> +		req.dynamic_mem_support_valid = 1;
> +		req.dynamic_mem_support = 1;
> +	}
> +
>   	ret = qmi_txn_init(&ab->qmi.handle, &txn,
>   			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
>   	if (ret < 0)
> @@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>   
>   	ab->qmi.num_radios = resp.num_phy;
>   
> +	if (resp.dynamic_ddr_support_valid)
> +		ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
> +
>   	ath12k_dbg(ab, ATH12K_DBG_QMI,
> -		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
> +		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %d dynamic_ddr_support %d\n",
>   		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
> -		   resp.num_phy_valid, resp.num_phy,
> -		   resp.board_id_valid, resp.board_id);
> +		   resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
> +		   resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
>   
>   	return;
>   
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
> index 2a63e214eb42..dbde76e5a78d 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.h
> +++ b/drivers/net/wireless/ath/ath12k/qmi.h
> @@ -156,9 +156,10 @@ struct ath12k_qmi {
>   	struct m3_mem_region aux_uc_mem;
>   	unsigned int service_ins_id;
>   	struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
> +	u8 dynamic_ddr_support;
>   };
>   
> -#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		261
> +#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		265
>   #define QMI_WLANFW_HOST_CAP_REQ_V01			0x0034
>   #define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN	7
>   #define QMI_WLFW_HOST_CAP_RESP_V01			0x0034
> @@ -258,7 +259,8 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
>   	struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
>   	u8 feature_list_valid;
>   	u64 feature_list;
> -
> +	u8 dynamic_mem_support_valid;
> +	u8 dynamic_mem_support;
>   };
>   
>   struct qmi_wlanfw_host_cap_resp_msg_v01 {
> @@ -267,7 +269,7 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
>   
>   #define QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN		0
>   #define QMI_WLANFW_PHY_CAP_REQ_V01			0x0057
> -#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN		18
> +#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN		22

this is not used anywhere, but since you're touching it should this be 
26 ? response TLV 7, num_phy 4, board_id 7, existing 
single_chip_mlo_support 4, and new dynamic_ddr_support 4


--
Ramesh

