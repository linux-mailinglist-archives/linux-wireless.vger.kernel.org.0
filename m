Return-Path: <linux-wireless+bounces-37855-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7LmMDN5hMmoqzQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37855-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:59:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A7F697B97
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:59:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="WW/lgSv1";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="O/LXH607";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37855-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37855-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C73E30777FF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635A83B8939;
	Wed, 17 Jun 2026 08:57:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4F3815FA
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 08:57:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686649; cv=none; b=HjDNGXnTJoF1ppAWYJOYQAiuzVcHjMDdZf81PoMqQEHKOVHOpmS5edlVYZXkRHM4dLdgzBSiAMcmGq7uCBcPrR80OEKnKcv/6+HjD6zcPtXzCkCzKorJyKS8oPTkiV1EUIL/DL87kdQLyXBkGM1+uilktitwkXaCStH7eFwpfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686649; c=relaxed/simple;
	bh=iNCtC1BKov+nqzDd8hY1eaLt+oppkNjv2ipWmjQrW4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GamE+ZW8Cr6Tb3DThfOJtLfpCdmBfzbYY1msHJNGLVCBldqIzOwChoR0sak/EWUyqSgws/3syqQsxvtohKfIsh9UxnXc/1qCm3cr0jtGw5njU/klU8jnfYFkiFDJM8uGBfpfCDZeIHxGRcXSV2+gOU+oAAebnzRh1DE44VDeMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WW/lgSv1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O/LXH607; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8W0Ic2056639
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 08:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hMpAUzpU0LmZD1M8HGd6uBHGdfd6f50CVhY6PFwoV0Q=; b=WW/lgSv1eOypdk8A
	ScGuozPDfBApDPcOzDy5skC2ZhlhS2R/UoOmseCKLga1umOvQN5P602TBVphGHd7
	AnVuQoSSrDktdoKKWlM3+hI4DG1+9LLqmAXn+v5+7+K2fAPcyg42r4U/kqV34Td8
	yWoOGg598XDXDk+ZwdcaXhApqNBMgGqVXDxm3rBAVachBXjmT65Q46kiiy+wdlKS
	+7Slko33pIjdnFUek+Y8+LfkFLxnqBYnEYLtiufky1lsZ1xCgpp5cHqMvW0xoDLt
	rRFeDsGacJ2s42tUehrplK2faMhZ47+Fl+rCPL8GTTv8UGMGNrmF32EKTRhwXeF9
	EYjs5A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesa9tp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 08:57:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf11699875so9195825ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781686645; x=1782291445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMpAUzpU0LmZD1M8HGd6uBHGdfd6f50CVhY6PFwoV0Q=;
        b=O/LXH60735wu2g7Bk/9pOjWXEyazCZ/iu+UfQTMTe5s2ux1GDjrSVpLoIzenh+gzm7
         eTMOo8zM505WCcbZtrt8uBWOvLTrSW2h8gCQkRdddUr6bGJuQmFDKApjHTlyZvt4Iuin
         lIqcL8AebcUXo2/TDT2JydqHDb/QhKJq6iHlMkEndZA/LcLYAL16HwQxT9zJuPF60xxs
         Wnjgo5oQ5pn6ftG0DqJ3mpK82UgaGMnDAmolev527N3wE7v4t6RZ6Md9aidhJz64pmr/
         J6aFfu0TnqqSwWdhaLKOeUKrZXi/ixOYjIN3Ix5Vqcu8ymqE8b2ZUNNsA9U9CbxW60yT
         Fzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781686645; x=1782291445;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMpAUzpU0LmZD1M8HGd6uBHGdfd6f50CVhY6PFwoV0Q=;
        b=QecZZDyUtNdiUJtQzpXJgZt8ormgwJja4RP/AwrfYTmzIfrBDYIwf4CqGqD0W+mmUa
         7jof+PKr9E5MVFXv5d82hGEW4T2Lctg7akooO7Ay12WtftZyjiWon/Eq6Qb8aLC/5uP9
         H6Z+1gpdIdjJL7TD00rrVxqZZ5chndr2UHt4mfLdUMvhcCUGDNnsGa/rcSV4fpFjBR4r
         iJ6KvZQV7MqPwgOm+0DGE7NWiIYaDP6U3vBCXIaQr+PydN7JNuIsCEebeIm0ig0whNXj
         siVuJ7duX3dz7+O3l9UXA5utuwH9CjX/cnxjxlprGQIHiChNqP/URB1iDCJgn5FairiA
         1/+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/pnWXLaIV6eo+9lrsQJpWGR5hSQvEqf7dWDEfgIJ+BXeLOXGwgQPR/yLEWc3jRhcBlUIN2f5qIVgNDq/0+hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMXzPIQZuGL3ILK79lJGLCr63o3N2x2fvGBDhBpMnImhInFcz
	2A+YQbKM3PuFI4g3cN+JuYSAW/w6pAqI0ZJ0jNzz6zVd++8WlxHeOARD6VrXCFIQQOOHopvwKSr
	C5a+PHS77dSqo/qiXxVucfsUof8iWChvVVfTbnTk1Z4oBKdm4dVLAIp1IA5N7iafoNvJm3Q==
X-Gm-Gg: AfdE7clZHSdQX+Aa0fFjD0VB39UWTCmkzOZmNwlOrnCiK+1TUjBP5+u4Y2Ok1P/NCtM
	AZf27BEXMJQ2LzO95GvX31sMUHzcyrORrD4+D8SesJfI8xd1CwKlHFED3s9gbwXHA3WDoRKxsBV
	mfq4W/FCvWNwkV9Cf/89SKMYT8x54eZA53Wo99Gsj1K/gRnpMYjKhCBEpgblKPs0fHx5KPrKXJ0
	iCGtVntQFDsRzGdM8fJL8ZHzdBU9Df51BK/u4ipxDk5CTrdJYmZhVKG6008urUOUSmECu9Q01mN
	oJqU8Pl4HpPbtYHYnL2dHcTQoDDZQKSRYTIfvdJ+9OVK4DjBp+OSiaD2duMqzWNTXHqtImavUZc
	TgndpvsZkxu1DTk/LMVgd+0hs78T9Eo/0v5rkgV7EOgAQdnF8Sju9XcFoighnpGzSSP/u2Dsffk
	AvHdGfs4M=
X-Received: by 2002:a17:902:f605:b0:2c6:b429:f100 with SMTP id d9443c01a7336-2c6bd11cf8emr22459815ad.15.1781686645272;
        Wed, 17 Jun 2026 01:57:25 -0700 (PDT)
X-Received: by 2002:a17:902:f605:b0:2c6:b429:f100 with SMTP id d9443c01a7336-2c6bd11cf8emr22459575ad.15.1781686644813;
        Wed, 17 Jun 2026 01:57:24 -0700 (PDT)
Received: from [10.133.33.65] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac7fbsm167392105ad.42.2026.06.17.01.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 01:57:24 -0700 (PDT)
Message-ID: <97becb25-003e-4156-945f-d45988b661df@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 16:57:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/5] wifi: ath12k: fix dp_mon RX parsing for
 32-bit TLV
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA4MyBTYWx0ZWRfX3L9jW1cf15Ci
 /qvZkilsygJyVZ98eYxR9XOggodO4I2My7qRaCQ+Atguun+252JX3mH8otMU8Bovnrt4A4pcbLF
 L0G/z0MByBgEEKIBbHq4s5vqqlEaDI4=
X-Proofpoint-ORIG-GUID: 9bUsHdIpXpDc6i1Mks4j1agpAtyhJKWB
X-Authority-Analysis: v=2.4 cv=R6oz39RX c=1 sm=1 tr=0 ts=6a326176 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_euX_cPFqkM1mgMQ_kMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 9bUsHdIpXpDc6i1Mks4j1agpAtyhJKWB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA4MyBTYWx0ZWRfX2txUTMYqrNYR
 fYeVweEcyvqdzGxkz+YlZAZ/FLbnGu0ls315gGpyEWMj/+UKgEM4bdhRgSAKupyd3j0KsJwpN94
 fWyZFwf9XmgafqzLZkeydClPLIvmefeY0L/xozcyV1XLqQbLwJTJQPohnxOHNucpa3r7GKXcs/V
 AbtqV1Egg8JBOs927ulxe2v2klv1dZwk75vP/D/M8A7l4807y88NFi4AJTb3utQOsXMw3QMUZ6z
 a3AlBej1j125GwyNUirhq0H/f4twSD1B1+I6t6VzS+hnfZqsBQcNFCUlJtSghiEUeuuEIh7cKS3
 LBNlq27h280F307RvDJsEEGufzo9mjUwD/oVcv5nDg1xjYWkbBSbGXxFGbKGx2xodlyiSAbnGc1
 MATXvR+AaKKTDK9RZTzi5OAV1vBx3Dx3eqVlgOiCH4JBVhNzyjMkUSiPRUCecCB9tSh0xxIe0KY
 LMR1Vab+Fik2YbaK+OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37855-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miaoqing.pan@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0A7F697B97



On 5/9/2026 10:58 AM, Miaoqing Pan wrote:
> This series fixes RX monitor status parsing issues on platforms using
> 32-bit TLV headers (e.g. QCC2072), and tightens TLV decoding robustness
> in ath12k datapath monitor handling.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
> 
> Miaoqing Pan (5):
>   wifi: ath12k: fix TLV32 length mask
>   wifi: ath12k: refactor HAL TLV32/64 decode helpers
>   wifi: ath12k: add HAL ops for monitor TLV header decode and alignment
>   wifi: ath12k: add dp_mon support 32-bit TLV headers
>   wifi: ath12k: tighten RX monitor TLV bounds check
> 
>  drivers/net/wireless/ath/ath12k/hal.c         | 42 +++++++++----
>  drivers/net/wireless/ath/ath12k/hal.h         | 13 ++--
>  .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 59 ++++++++++---------
>  .../wireless/ath/ath12k/wifi7/hal_qcc2072.c   |  4 +-
>  .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 13 +++-
>  .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 13 +++-
>  6 files changed, 94 insertions(+), 50 deletions(-)
> 
> 
> base-commit: 14d99bd40a8e3a80398dc597375fc7516ca488dd

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

