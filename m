Return-Path: <linux-wireless+bounces-33269-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFHNBoJ9t2muRgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33269-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 04:48:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB0E29477A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 04:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A31D300612B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38D82C375A;
	Mon, 16 Mar 2026 03:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ET8V6mjH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KA/EquwE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B730B520
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773632895; cv=none; b=POJ4aDZk6ztSc5FFzHS4q3BSJ3d1+UKqW8CuHYSYrZJpEcHJ1ZkgKFXLfsFqjxVI0g9k/2dygNLxfs4iElXMdP+c5CbU8xRySGJ6nnvhaq3OTwUwd5gk8eTPemheu0QWdFljf/wx8ddX0nJ47a+Kt+BoQr5qkJcy8uSvuxTYdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773632895; c=relaxed/simple;
	bh=gx4LcNDW3zM7wSDx9iYZ6099oCEvSoozWeW4zOybpWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1SZ9Ye4fNFy6H4UtOIQ2cP6XikyjXwnvxKagr62RpYWmOeK4R0U6zzAXXKpXmbyd+WMiLhXY5eFig0j9nF3DK3Xp46K5pbaknWnZvypsz+mHCCPOwE8N1yTMXYPu8R7NWSGTddtk+9CjOyzD1KX3XUpHNWfhuo71HTHyExTvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ET8V6mjH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KA/EquwE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FJbP7D3632638
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 03:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fT5rQ+5gT8sJC6asjov0bMTamVqtx7ocsFfxmTjg43Y=; b=ET8V6mjH1+Mc1EeX
	sERmDtgXzeuhRsI/+wxgy57MikUsvrH/J+JI7YQbDDHmLbZu6gNoZzctgjSf2LJG
	DN+2S4GDMYn44muztN23AtyRMIZAbNyo97OEN24tqctvXCfF9M0EkDgENNurun2G
	M2TSIQ5y0WY6b2xeu66Ix1LzE8u5O8SatWVIhpMT8IVBPALTmFabook3n4cQSFHQ
	RpFOUIK0p3njICVGyM4cESyPzTUwwxC0juG434iuOgE6O0gx+BGWqc/c17BHSM1f
	VO/dMoPnJSrWDRk6t09bb+qiK/XtsQtGnOGU98mVohM7vusn8CZitF5nr4HfGkh4
	JFAsyw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00bc3v0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 03:48:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70dd30025fso19740397a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 20:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773632892; x=1774237692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fT5rQ+5gT8sJC6asjov0bMTamVqtx7ocsFfxmTjg43Y=;
        b=KA/EquwEaxB+EmHyNM+auWnLa8WxiXsXgDy2kzlR2qbCGVEctIMf9u8IFj/w4B5aMF
         3NkjEBGQqilmYA606qWM6HeSudNgujuUnZjiJgDEUYBh6jrIbObBHEF75KTC/k2W3/MC
         9hsKEWAa9y1QN45TW8t5lWBb4NejSlFbfBk9vkrZ3PMisCygdYpAHMCVqhrRGVSA+vQN
         7AtWtFyJHbJ6Yul/IJ/LkOaqxFeVMPKwuYHNZJYahTT8Xx1fxFvnUb4RS6RJOPF9KANh
         t50vAgeS+qBuW5kdnDNF4DA6qXFBVEyVkXE1DA4lCkXBUT6HyNi1V/NZkd/d62eNyWyT
         bcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773632892; x=1774237692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fT5rQ+5gT8sJC6asjov0bMTamVqtx7ocsFfxmTjg43Y=;
        b=RcDL8hooUGAcs51s8Xnrujeg77l/++HyS7sxGjGg5PXnYFTb0fsKyPjiY9nLoyLGhF
         MRXXKW6MzsB76oJvpo8K2dQXDdIji19Pg1a4z22jBtDKpWGAF2KD3ogjb0jcnMYfjqNK
         wFlUzW1RIyzc1RcsdiCQwZWud/UJvEyPPmg6A2Fs0s263VorehrODZuBg2F/Xzj89/IL
         LRWU6MKEL4BpIXAh4YnlA33jPCZe44bcmzPA2xY5IM535Cbygsrz6618DOp/h279b+Ls
         XuPVuCp7uoeo6kxiTZUpAl+mjkaWDDNempY42bLeuqXcvIFrAgzORmsAIIMhgakUreUE
         zyzA==
X-Gm-Message-State: AOJu0YxEiE8fGNUku6hk0STsmPoqkakMacxwoy2Fjo1QxYxa4P3y/424
	lLpxlnYiggJgahAuTkFY0CDcj6eX9VgveJjKxYYrIK6T8OVNU9NZPkQjCuWWn8KMI8vMsCCrqmI
	0gbgKVoa+et06V0uObd3Dk0CfgkQrmxiERDfz1p+2W6xrOTLUa65Rawtlm9hTTSkAeHFVjPGZPn
	/gkQ==
X-Gm-Gg: ATEYQzyEX04CrvL9mFcPtm07Yeb6k/s2qvSsB1hvURGShaAaIiIZ2W0Wit/TaipUDlY
	tVH+YQTrDGmI+jFgrCxmL6ak5sXpaUziQ3OjClSbV6Z1AzpcjGyYHCmvGmw1OkKdWx5TiZq/oYm
	XQ7WdSaOjbzejYc635tz3CcmbmDGqeIeJxC80lD3Z119gILOWW8nubWU84nu46XMr8kEzCOR4FY
	xGjWv6M3pHDcm+eQunP1JlOMRcSLRV2dFVzEcRN/i+j/n1IJlLIuUBAUvaVNGWBXIlSnrfArYgf
	TOQgLDy95tLne5omkGRWOtMI9wKrp/JFGqheHxY76mfoJpyrJZFSo3v4wxZN9R7bCVngjwVAuyS
	2HzlfAIE5pDHqzo1mYiNAnvHFloziBSKgeKAGdMk/KHacnKU2Jfi/xCYWxWw8ptnyTQ==
X-Received: by 2002:a05:6a00:908d:b0:81f:3957:2772 with SMTP id d2e1a72fcca58-82a196f6403mr10117843b3a.3.1773632892542;
        Sun, 15 Mar 2026 20:48:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:908d:b0:81f:3957:2772 with SMTP id d2e1a72fcca58-82a196f6403mr10117829b3a.3.1773632892030;
        Sun, 15 Mar 2026 20:48:12 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a13a2f112sm11418137b3a.12.2026.03.15.20.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 20:48:11 -0700 (PDT)
Message-ID: <80ed7081-b17a-4251-affa-68a17c21e884@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 09:18:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Clean up the WMI Unit Test
 functionality
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IsATsb/g c=1 sm=1 tr=0 ts=69b77d7d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=YydTf4iuvZLm8uLOWi4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAyNSBTYWx0ZWRfX0f1xhveV6zB1
 BAQL9Br1pIlYhb1w4VEpL3v0rEZHCHpYNLZE5HK0zkHZQ6CxsHPoSLPAyXjtlTZctzPLuln/9ot
 G2kg9PHR6nztt6LxNvYNjpF82DtbaAgcqvW9KkYMZAWN0VEBwvIK6Alg9wyUehxy6AAxOZGKAyy
 RhxvjjVTsMC6z4g8BMbMCacJlMiWXPPL6fCztFJZ5eSk7NZJual/VMX1+u2hM5RbHIayRE2YOGz
 64FjisJuMoLygJQr58IrEA6gIZ63VGMQT2pQ5tr3FL7kev4onh1hnDl2/HxlEl3/BN4/fbGm1zL
 k/Mm9meYAEKMYwX67HiAC3+GTolGFoexTxsQmqg8DKsMKZdvsopXVehUs5DE3i+6l2YUH6mApLf
 NZnaK7UOG4LukxXrzrqLFbi2UY9p20sZ5QZhiSdqto3+5HwFixSpYmJGXW3xOcGshTtcZhqsDnS
 KrTXD8y5YsNzp4E37yQ==
X-Proofpoint-GUID: USGZZDDttLBiJF_6HX4G6ZROpMkp_BF_
X-Proofpoint-ORIG-GUID: USGZZDDttLBiJF_6HX4G6ZROpMkp_BF_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160025
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33269-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ADB0E29477A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/10/2026 8:46 PM, Jeff Johnson wrote:
> Patch 1 updates the core Unit Test functionality to address multiple
> existing issues, and patch 2 removes unused DFS Unit Test definitions.
> 
> ---
> Jeff Johnson (2):
>        wifi: ath12k: Clean up the WMI Unit Test command interface
>        wifi: ath12k: Remove unused DFS Unit Test definitions
> 
>   drivers/net/wireless/ath/ath12k/wmi.c | 58 ++++++++++++++++-------------------
>   drivers/net/wireless/ath/ath12k/wmi.h | 14 ++++++---
>   2 files changed, 36 insertions(+), 36 deletions(-)
> ---
> base-commit: 9942b3f80f4ebe6852663e0d35ecaf6b7a97c8da
> change-id: 20260305-ath12k-unit-test-cleanup-07622698c994
> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

> 


