Return-Path: <linux-wireless+bounces-31278-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMPgG3w3eml+4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31278-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 17:21:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F84A5762
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 17:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 739F430C212F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53623081BD;
	Wed, 28 Jan 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMqyasNn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LYfQFzy/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597152F7ADE
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614953; cv=none; b=JYRIxMcw3DdKDALnedw23ISOO/qYzvgr2/hurs2T1yijX5VnIaMAHK4mipM1iLVC54+9GhuM2OBPGAf5XmS7C/HV4PwSDPNUIE6FW6+IbNKqDk1pt1Cr3AluW8jjhV+dSiD7km5VKzLPOvqNZ3Uu2qhT30spCllS/J6fyFMqiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614953; c=relaxed/simple;
	bh=t9dLjF1QoezjJjk2zw7c53FVpAmlnd2OIVmC6BDJYKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+3zVuHMq0/BllAUnn20F6VTtIvKN3N9wE8JphcG7PLoB7MxWnhVeKdzz59ITLO7dreasRPnJqlu1cOUH9NNatYWduP/vWus9oFJMe9nWMQE5K3bGNEON/+N+cN37rroYQaTw3I5+rJ6xzXOwkmng0rUU5FCdt/J4XMLbXpOmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMqyasNn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LYfQFzy/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SBdvL11750477
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 15:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K8QuYKjVLvret1GsI6cC3h1GiYwud96huRl7c4eEmng=; b=GMqyasNnooSdxV/T
	GFg5h5Y6fi5w1/In5brGktJ8cxiASgFkCh8YBJJQ/RNG1757Fxs3g3JkNGyVM3eK
	0yCG/LfJSx/P2he1/CaHLYXAg0e7hfx4X7JptnAoOnVdzWkAV8rsUul67YhtOjin
	z3rN5t3xroPwmrL+/a51j21jjY7VjMTrToKQ/NRnzi+l39AZHOVWdCRRfhcEo/cV
	kStm0yoWuNNWrgVjE1i6TnCZq8jpeEkOrKwm2XtT11Pk0DcSIyHk3dt5pnVmXZ5U
	As2SmannLcYMOoiE9b3MuaDqC9fQRFEorpBP/bkbU6U3Z/k1Fwq/hteBHXC9CzzF
	/ylALA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byhsj8tx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 15:42:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so13267200a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 07:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769614949; x=1770219749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8QuYKjVLvret1GsI6cC3h1GiYwud96huRl7c4eEmng=;
        b=LYfQFzy/u/2C5W1Ynt+JY8/sgEl0e/l1dYcvPzCg+G9RL0KXghkWm28kCfD+7U3zjS
         Y1W7Yvr7vnmFXqbRkKGAaUlDDaJyjfTmvkRrMWV1+VPWntVKZ2eKiZWeK1JaFmEblBES
         5HK+SJVh4d3C6em1cd+Ze5LEhIpBfKTLEAZtdnFtTsJuB+/OJ2UNNm3S6NSMVKELDLJR
         r9A8S3F5Fg+jbEvGOAnBy5PCJA8IgLCLZk3auccvFvb3pHmnZcDlTXmPjBMRp8Kk+8yN
         LfUoR/saCP6X9DxYUtNzhuKGD0u5w3YZAr0/7tkVtu7ZKg01irjJxnU9SWqrdt/dJzq5
         GMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614949; x=1770219749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8QuYKjVLvret1GsI6cC3h1GiYwud96huRl7c4eEmng=;
        b=EuJ+rDxe4eVih/z7YF371C7xdLeThEPPlFPt+osuOym03AbUXM1dpi+ong0W4MUA6P
         5ErB/2nG8aIitxhkYovVI9VCuC8tulOo+ijhlQkeRQKxV3z7qFGVbjQsyni1n8sndtRZ
         YeTbJwCSFIcbsx8DJeLKaxoS61vuo0uzjrFV3Q2vZH/HWiL0QI/7mXwqKC5aH3mFCoLD
         2u3wQgscwsML3UISwktFAuFyULM/6Wj1ISHJ83e0a7uZPHUXcbUCAALGBVpBFtVyGUEv
         horhiHBp6mtZbbDL3xSPCqmcMalSE5Ld4r9H1R2HHC5Tx++QxNhdU5SURFkKpnGLjoKp
         z0MA==
X-Forwarded-Encrypted: i=1; AJvYcCWiwWHrM0YtkY3RyiD8ochIBkVH9+accJCkBuY6i4Grl94Z/rz/4432K8jo8DFXK6ifnm9hpSJgoVBQoog/UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHaRXZpExpxOjpnyFd+nM0MQ2xn6nr8dlDH9WarHI7+wZEWr3
	+5Xcwgk3TacZQdbuCP+W6WNAosM3nACydWE8Mye5m0XqibN0ToHxbtGYt4PXFnqyD/RwLMqw+v8
	SqjIziODQu/p1DfQntkdIH6OqiRs1J0qHbR+G+y8o2a8gkNoxJy61bZ1Q46vZIieTJrfq5g==
X-Gm-Gg: AZuq6aKJXjHBSK8AveHKctxPvsKPbzWgmA4DiQWXDDWeaWHFN9hjH4nn+2jNh2P8apX
	cuSqi//eFQLMn7sH6lpHctJ8JzBGN8vdnRHTAoIY1KjnWajETDjzDgMDj7Cep6mOxGvbyw51fim
	Z9ITlgo6FhrbItMRRxKxNFuGrcAvQKNpcJQP7yRU3fuNwIlaxj2Zl3i2fx2Nf9LyupJ8Mqt/xXs
	TROr9ZB5fYATd+rWK5rlsGCcu8cvS0oLVBOpWFQL1MbxLN8+w7yRk3g7baJc5zj37hoQPFEqqfE
	aZsQrNIu8hjkBV/tmJWKei7Ca9ZYXzvvQYhNTLzQpm4Ba0U7RD41tmvlOIaxtxKPjjpCWLUe6W7
	MJsFLxHF/WJAzinee6bf2C1BQ0OqFFHXo/4PAqHb6pjioJU98MxABHjp60kcuDA==
X-Received: by 2002:a17:90b:4e90:b0:353:41e:1f51 with SMTP id 98e67ed59e1d1-353fedb0be5mr4436637a91.32.1769614949169;
        Wed, 28 Jan 2026 07:42:29 -0800 (PST)
X-Received: by 2002:a17:90b:4e90:b0:353:41e:1f51 with SMTP id 98e67ed59e1d1-353fedb0be5mr4436616a91.32.1769614948628;
        Wed, 28 Jan 2026 07:42:28 -0800 (PST)
Received: from [192.168.225.142] ([157.49.251.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6128942sm5836935a91.5.2026.01.28.07.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 07:42:28 -0800 (PST)
Message-ID: <ea99fca7-c51a-43f8-8fb7-f228b36d3eef@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 21:12:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 ath-current 1/2] wifi: ath11k: add usecase firmware
 handling based on device compatible
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com, krzk@kernel.org
References: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
 <20260121095055.3683957-2-miaoqing.pan@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260121095055.3683957-2-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _dSddRifYJeWg4byxkP76W4BCuAfWKZl
X-Authority-Analysis: v=2.4 cv=GbMaXAXL c=1 sm=1 tr=0 ts=697a2e65 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ayGwEbGGg2t4nIWcsuXnMg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3bhG5mAFE4JtUZ8DKu0A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: _dSddRifYJeWg4byxkP76W4BCuAfWKZl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyOCBTYWx0ZWRfX3FoGl7YeEDwU
 ZBd/W8QSYbNh1ifGhi3c/wlJ/ULgwXLDGw0cCOgrE7y8prELzFz7fZdG4xwrON43BWdWIWiGlM2
 T714qYHwozCvdkoyaA7E+RS97lTcLIF0J6XEZWl4lCk7Mss+4/Zmg07eRtOhWMD6u142CMOmKMm
 DhPpZDcNk6l+Yyt8w9pjxOmGawpA3iCmpPifUdIiP+t0JZVWJofKih74a1AW7dBiU1gzMw070f6
 t47L3hqUUZatnvzGKObZnmdr4ucZ83Jp4nm2JKHm6eWTFzf0B5u2y0Na9CdO9g+ZwiduGO44W0m
 PwX/QWYIVGDu0azeHXIcnVxN8YMw2U1tr1BGRJKpqkL9BPuldtpLah12bI0eEdVAK6F7BGjbraC
 3pwzd3bisS52vZn4gN1A/Z0iAObPFhWSLRR7+/RN49Y3BfcaZpAifdXYiVgJ/qP/gnNUn2FIkm0
 sO/I8TKyUfR5YUiV1yQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280128
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-31278-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RSPAMD_URIBL_FAIL(0.00)[oss.qualcomm.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[vasanthakumar.thiagarajan.oss.qualcomm.com:query timed out,miaoqing.pan.oss.qualcomm.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 14F84A5762
X-Rspamd-Action: no action



On 1/21/2026 3:20 PM, Miaoqing Pan wrote:
> For M.2 WLAN chips, there is no suitable DTS node to specify the
> firmware-name property. In addition, assigning firmware for the
> M.2 PCIe interface causes chips that do not use usecase specific
> firmware to fail. Therefore, abandoning the approach of specifying
> firmware in DTS. As an alternative, propose a static lookup table
> mapping device compatible to firmware names. Currently, only WCN6855
> HW2.1 requires this.
> 
> However, support for the firmware-name property is retained to keep
> the ABI backwards compatible.
> 
> For details on usecase specific firmware, see:
> https://lore.kernel.org/all/20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com/.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Fixes: edbbc647c4f3 ("wifi: ath11k: support usercase-specific firmware overrides")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

