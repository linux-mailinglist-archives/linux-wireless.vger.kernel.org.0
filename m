Return-Path: <linux-wireless+bounces-31156-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H3KB13ddmlhYAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31156-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 04:19:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD083A20
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 04:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CC7E30036E2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 03:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90E155C97;
	Mon, 26 Jan 2026 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoU8VHQ7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZTrwB8X+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630881397
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769397594; cv=none; b=XRwkg0xpQq5EGMGdaPzhL+pxtjl9PqprC1TH6tJv2uRe5yKuQXy6LEGWCL7Pzt0WzOuoP6NtjPxWgF5A+kKtvKtvu5ekh8qisku6XJOX73JLak1AkNacnnmMcRiIN2meH4TNGeU8cOlrwMYWkjdKTQpkcVD5+sXXcTYxliZyNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769397594; c=relaxed/simple;
	bh=myzgRlwSpy7lzVgw9FBu7t32UJuM4JPCZlFYUQYWUHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPfQb48Q6H+arke3jb3iGEzW1tgVLhG1CqLvPm/osSI0GPSwfgUhKxlndJMcmz8ZVPyV6fH1G7wDVUO/aZdjy0Ljpsf/kV+vmo2AS4e8I4tnynozSG9ZUSCJc8oDP6/EXWThn3Ny4qdhv9mvm5iKZssyW94214/cdlP4XGC2ReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoU8VHQ7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZTrwB8X+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PL0jen2168691
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+MmwudRmmHBnDd5REUWJhq2FjqC5iYuepuKsWiFkJo=; b=UoU8VHQ7ihkZL6vL
	Ol0LeGWq3FfX+FDCjWLp6Ve4OxS4ANLi34FfEsXpgufzq9LSlRx9XqPzviFrlWn1
	vj1zMY1G+ZRT5EHSITCwAjMu2jEZ6rumfzinJ+AnrGANPODZnGV45b+ZsJzm4mRr
	SkTNeIesg030KGfqkGaLaJsoNBviy3Qu5THvFQI3jmPTZF9cVG0ogfg70YsEFSf1
	OmZkvGC5DOHojyUWVlcQ5cx80hx819HsEu5lxrsGPLL+rhJufIbMsc5Xuq8pFQuZ
	LOwhNA970j/rrzLh9Si+rrSPy0Jn1hMeXx1hjnhXefFPg1V5ffjLq9DAJaOhMuAt
	UOl5Vg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq8dk9vv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:19:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a351686c17so35066615ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 19:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769397591; x=1770002391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+MmwudRmmHBnDd5REUWJhq2FjqC5iYuepuKsWiFkJo=;
        b=ZTrwB8X+0EpyAOQl61C3HvbN93qhsf/D/1DzlfQvkPvRGl1awg8kC/iOIXVaD4eO4K
         Xmo+6weHyWcBjeR297qz8UwENRUPZVpBPPOXQivputyNYgelSqHYwyDhYAJDr/7d3OqU
         Ezbtn62m2H9K1IsgYDiVsxI3sP77zVIcHTzxqJ9WeepfLDwPge1dZ2atnh1/a4x/oRU6
         XDBvJ06aPryfrQMSZDNJ5gWQWTVF6DVn4k6o0O6SnJMJY8GbznKobIkOcPfSFbD6f8U1
         1MdufKMSt0ThqaxbS1uqVi8zbX0kEYjQRLAEXMsElKjCZUQZTUA+f18I9Z0POd0k2Z5S
         k4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769397591; x=1770002391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+MmwudRmmHBnDd5REUWJhq2FjqC5iYuepuKsWiFkJo=;
        b=Q+vRNziQvKHaFyHrrT4Qc/wjbYJl/wg6gxpObRh9B/xt8c/4UCHyUsmv8+c3nLIDku
         4bbiLu+zYrlMOVPkQU7S5xSUcIHwTojrwXoZnZplz+itOkAKnCX6HUy87MveZNwBIUAE
         IMOdIk8jSLnh6OKbg0vojfg8MIRaT7c+Z06xqBxKG26+kFp7v5ufju/n4PW3/cPWDFsD
         cyFFPVqQDIEKwU+aZWyBy3MBTvRohuUBc2sdjvLOmnWcMCRFGrmaKWvgqV9UcgtFKqqR
         JLyYdOJwH7+i8TD+xnxQeKLTdSYwJC4lkV8O+p3q1dBhPwIL3T6ZyQNDplvXpKLDgv+I
         zk3A==
X-Forwarded-Encrypted: i=1; AJvYcCVBu8t17N2xwCsmT75tnGk9BK+ix40KGQ4BGA8Qfy01EmlUpVdb3bJQjfkG5SpUfGW4Un9qqvZiD0LaLFPXbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq1jM6L5zUAOQZBwNvNsmx8gF/sP2EMj4Z+bLqNn83Qx/dxbLr
	Hc8VrPF/jrtZpTe9jvxlDe7KeuKgtyzmF3uR/VeHzZ0Bx/WFxeCvi17qeSDiUH735szEhIeVec6
	rahaTELnRg5MmbQxucm0uOLPeuNP2oBQUJKMXbbXaDqcd3+QZ5/JUNsE64HXd/Y84ZtBrOEI1CB
	LbWQ==
X-Gm-Gg: AZuq6aJWiJxzYVUvt8oOAG5k3XX7VK3zfnMrmwMfpcBibWsKZsYGX/IW9S2tXvs+acB
	UsgffE31PcOaX7ZDjwLzJ2n8HOYa0vTfm/dgcEx3S4nB8PZdfnqbuRyKbF9RDyXHYa4DNvj44vT
	E9Hs7upfsd1vlVi+UuRYCcbz1MU0WVMbfAoRi5rLmwdtvflkbhHl05dRAvpCLKikuGYg7lM0k3B
	kGFF7t7jVFGh+SiOkVtNwRr/LIpybjU2BUQA8cPDdBYvyuZqXrmFg5zWeI75yuRQy17zTEb3bBw
	d5HQXipF2FUhhQNP5GfieNVGfvOQ7DJBK8hBuCT1LOTfuvAL3m8bOxo3rfJNnJ5nY/G5CTv6SNO
	Ec3MmexQdyb37FO4bbuq14MOxjTXphcGi2dgaiv7/Y3jy5xVGKUoJfzyLHZkbFEaOpfDWrJU=
X-Received: by 2002:a17:903:2a87:b0:2a0:941a:6b08 with SMTP id d9443c01a7336-2a845257d1amr25027955ad.21.1769397591562;
        Sun, 25 Jan 2026 19:19:51 -0800 (PST)
X-Received: by 2002:a17:903:2a87:b0:2a0:941a:6b08 with SMTP id d9443c01a7336-2a845257d1amr25027655ad.21.1769397591053;
        Sun, 25 Jan 2026 19:19:51 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6926sm10367308a91.12.2026.01.25.19.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 19:19:50 -0800 (PST)
Message-ID: <40414ef7-4eed-41f8-bf1c-c94038b29cf4@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 11:19:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Add pdev-level OBSS PD
 configuration
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20260123064817.364047-1-wei.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123064817.364047-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDAyNyBTYWx0ZWRfX6Huz4cmwSyap
 OiQ2D18YYatOVWR5ZNtVx92nYeUB/7W8zbUFwxDYv2DMnnyhCyezQvEJ9d+WLZ13G+YPbkM0/hG
 /2Ggtll1jETu7bzaB2oojUHprzYxg1UZx+XKtdns/gDaLkd/jVXe/lgtMG3nSZ/vzz/klko8XLS
 0Z0OqBX3LUbL4Ww623YQQdrWnz8O9Oh8p5L0FXX4r/fkXUShZIwgv5Q+gcI+2oMvI+WbcL/JJaF
 Fd/6PHJr3bnOyteMiJNQe8Qvv2OXDtJ3iiPVx2AafIPsITdQbW1pDIyMWGWbBNGjeZWYEBcLUo8
 ICYWFgoLhNe9k+1RK0VFRaQsBsdiJgU54BVG0nf5821tLePOMH/hHX8PezmzW9jkh26LUJNeIWz
 7/X2dV84PjTicqECfWabLKVy1UNFaZGJ3wdfSZZKJ07xX3gUs7blFbl28uU2tTi57Vy03hoxk71
 bqD1OvHFOstvNym/S4w==
X-Authority-Analysis: v=2.4 cv=RIq+3oi+ c=1 sm=1 tr=0 ts=6976dd58 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4n_vrpepdM3ewlY-ayIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: __OS2XEDBSIhtuKKhqIDnA8lZOqIbcF5
X-Proofpoint-GUID: __OS2XEDBSIhtuKKhqIDnA8lZOqIbcF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260027
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31156-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6EAD083A20
X-Rspamd-Action: no action



On 1/23/2026 2:48 PM, Wei Zhang wrote:
> This series introduces WMI support and AP-mode handling for HE Spatial
> Reuse in ath12k:
> 
> Patch 1 adds new WMI commands, TLV tags, and a service flag to configure
> SRG/non-SRG OBSS PD bitmaps (BSS color and partial BSSID) at the pdev
> level.
> Patch 2 switches AP mode to use the new pdev-level configuration path,
> programming OBSS PD thresholds, per-AC enablement, SR prohibit control,
> and SRG/non-SRG bitmaps based on mac80211 HE SPR parameters.
> 
> These changes enable firmware-managed OBSS PD behavior for HE Spatial
> Reuse.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> Tested-on: QCN9274 hw2.0 WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Wei Zhang (2):
>   wifi: ath12k: add WMI support for spatial reuse parameter
>     configuration
>   wifi: ath12k: support OBSS PD configuration for AP mode
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 170 +++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h |   3 +
>  drivers/net/wireless/ath/ath12k/wmi.c | 142 +++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h |  47 +++++++
>  4 files changed, 359 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 758064145fe77e06d07661b27dfa9c24fe0309a3

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


