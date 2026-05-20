Return-Path: <linux-wireless+bounces-36681-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFJFM3waDWo5tQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36681-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 04:20:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B51586CEF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 04:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21E4E3011045
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C5301704;
	Wed, 20 May 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bwQiaycg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BqzmPP0Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F902FD1B3
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243641; cv=none; b=lrHdJsRSrY6jCaWFpO8MdvjktnimQ1hkNaBvMJ4I0PJU1oLF5+H3Z7GcnH2armho+XLvMA/UJ2qUVW3Wylw7OgVSsFxPFXNhbMQInJ4nQz1ovzaDHybycrIeF5UX3AEsJQJKmp8djfU8/6dAMTIL+R7BwIesItZW9NBMKJUXOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243641; c=relaxed/simple;
	bh=BvWBt41yZbExDXzOV3Pw3uc/eAHg9QMo2d/GRqCdY0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEyPaMB8f9D+UT4QJSS8v+vrcWEUL7P3ROL8Jrle6HiBqVQ1K7WmuGIkqJSbfHgqo4+kM2Zo94LC+h9gkKIV1LOPmYvcxjgsRSpW4Gb6vaiGDZIzoBbfUS2R7bQo4Ak5OWrfQhnojoQAZBMJ3Thp78gWh9X9GJgeOEKr3fW7YBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bwQiaycg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BqzmPP0Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JMN3WE341538
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9jlWezoZ59nNLOicp/jz/ZV97ZhFIdnReASR8pBr8k=; b=bwQiaycg9jM2kKFl
	311z3FQfhu1GJzvnhwo5LZM16GPPeWwoQLuIjOidZp2Z8m9LUJKFkavQiSOaomEz
	COumBhIycqou+vX1i5vqmUmBLnX7GbUgz5cyHlru8Oc3rt8tLjxcDnQQP1qu0fHM
	QjsmYpLARgSd5f8vHfXpYq04IJ+azkSz/SbwY3ju/wMzq0qtx7AJVQf9ZMg/Qh3I
	cObW62xeTY6nHpr5wZzeQqGTkVmsvWZGlCV+vvKPg215bX4D4Do8RhASJeV/eAYG
	q6E/YFNwgLfeqZMJLUh9u4Xgr8ioxu+sk6Q8xdBy12zTw6/2/1BETMvUp6FpgY1w
	iJAY1A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3vaevx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:20:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c82751074c8so7133346a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779243638; x=1779848438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9jlWezoZ59nNLOicp/jz/ZV97ZhFIdnReASR8pBr8k=;
        b=BqzmPP0YSBALwRTgzfFIzfLhxQ6TE5aPOt0DZdZqM7bkCRehmshndu+ht9+uJrdyqT
         F0x93pAC5W4HFhXMBKXOcYWIjLK7atWTtY9SUqyaF5IexrxepcWPEayUYTroru+TsNdS
         4pSADSBQCmMf4hPtid2v1T3OXE9pQR6+Y4r9JeGJyF4sSqIGrgjO/3gI4X0BTRRSBqW4
         gIPc8cH2Avwr6gq2DGqkzBSIWumotmU/8MSoL70Jv46kM2MPG4kXzZuPwnbGoZeZ+Qjo
         KQ4vcmVX4P4TaW9P1rjZRMr+tKTCm7Sd4cf9lfwRHEsRbifjCnuqj8fAIiDnKFGTtlXy
         sYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779243638; x=1779848438;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9jlWezoZ59nNLOicp/jz/ZV97ZhFIdnReASR8pBr8k=;
        b=f6/HpOqogkZOZEfSptkJQCpHOtXbE1zyP8C+padpuKVb59ovpRBP7xxBUH2vfQNtMb
         MYXPNG7d7CmNgadO0JbjmmfObz4J0pM/p8WlB/KhYl2bhgOPtyaSuSBSZONPBC23ThyD
         1HFlFaCrV/p3TIupQkVEV421ESgQFjE/Gt8/s3aR1SUi8cHbfRiPCFSsJn1KEh3p/x44
         EYPXpbgcq5ofxnOlQ6h64z5ZUixL3dfcHogd7i7x2cqzu5Ebr/78av4mdvqZQFNz2uiY
         mqk/zhWlfpzaqubCPadn16EClqzGwfddc93VPzjftreizTgcNTjruqYqy7PpbEZsZdGq
         jyig==
X-Gm-Message-State: AOJu0YwReujW7CvIqGFBJqya0Nl0FFxp6r+c0qTp6JG1q5xfgrnrN9rE
	QlgGy0WsbIC7J3YyOK5IlPoRnDHXJtYK5ZELIfwMSoKZhLvzJp7aJfxr8x8pRqWKC2yoGLOwF8K
	O0Zkx/PAZQ2R5RlQ22hcmHUQlU8E5rN6iDi90RUgV30Oq14/IWfh4ETkv8LBo4H5jaYzPvQ==
X-Gm-Gg: Acq92OEpnwnhwYXwMmA+3J8YGsLNVHbsMZi/pY0xnuONZ5NOdRBJ0T+Kxoc1H0HC1H+
	iGyXHzAcuki6104Y3g58bvnNzwEZq54LC81gWst1B2j1mHeUoMgqVKijzoWZ8Qos1IBxREdBQf+
	dlXVboU+TgJtRY/Hec4VSxA/toL5wNgVi/COYE2dHsgr1phax9F0U0AAOQKrK3/FBJ9U4iyGYXE
	0XUshEFhjq7OLp3U0fTAD/J4Xe5FZ8TuZ448ydJINEnKHbCQg5N6yb9U3zrToOdLxa0+kVw1UL/
	/I1WxLpQX2Xn7fh4sXLkwzs75YIHB85dswLAT0giqo6II1GIZUy3BCbiA9dteJLapajfyUkvZ/a
	AEnk9xxkodGRJ6V1icyhdU+VZTsNJve6MaH9AAR8MbMKhj0Rm8rFFvDK3i2RjEa3dQ8zF6tz+RN
	tYuIaN4T5+TjsUJKCK/A==
X-Received: by 2002:a05:6a00:3922:b0:83e:2c38:f5d5 with SMTP id d2e1a72fcca58-83f33d96f27mr22803997b3a.28.1779243637620;
        Tue, 19 May 2026 19:20:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:3922:b0:83e:2c38:f5d5 with SMTP id d2e1a72fcca58-83f33d96f27mr22803972b3a.28.1779243637110;
        Tue, 19 May 2026 19:20:37 -0700 (PDT)
Received: from [10.133.33.93] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc8bsm19872167b3a.55.2026.05.19.19.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 19:20:36 -0700 (PDT)
Message-ID: <da065adf-b572-4ffb-a428-0ba967e87587@oss.qualcomm.com>
Date: Wed, 20 May 2026 10:20:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: fix error unwind on arch_init()
 failure in PCI probe
To: Ripan Deuri <ripan.deuri@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260519192815.3911324-1-ripan.deuri@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260519192815.3911324-1-ripan.deuri@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CVNxVKpp_IKWTV1Alu897wcCOXQVNMW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAxOSBTYWx0ZWRfX84qowWT31CAi
 NyMFWGwMvccuHjL4Ofk0pPFbdrgiyelGPGGH7mJn1k5c0UtvTq8nTbr012KR/viHutX7la71fnm
 kZxqkH4TLx4Ljs0pwgGomSt8OzqfAtqdKTMACY9PiLk4qPLJnfSXwJ+oMVXoF8Kd76YsAuVJs6F
 5fFSLyHW6Lg+M6NhvzL8F7xO0Ac/2516KtmP/5q9512leGDuJKZ8M1GY8PrLipCiSpDxDlEB9AP
 4hIyJMs+V7PUCExv9wut4OB3Wgsav6qfHiy/SRx/bT7cySbFLo5u0pI6eikEJgQH4OrvbO0zVYo
 BgiW32De4jS1lmBV2KERuHgUqOQHxQJl6QFKFaot4McuBaY+LoiMRmNHCQC7TtMYl1uYWgjgos3
 B/3OY65WqbINjfe1WMwG67ZgA0ed0wHhsMWtC4WSIei6l9s0SxMmZxXw92d5pWv82b1sXPbgmGf
 1TMaLzWDY3Qlf8JLOdA==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0d1a76 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=hhaimfcYFxIno_I0_EEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: CVNxVKpp_IKWTV1Alu897wcCOXQVNMW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36681-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 48B51586CEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/2026 3:28 AM, Ripan Deuri wrote:
> From: Ripan Deuri <ripan.deuri@oss.qualcomm.com>
> 
> When arch_init() fails in ath12k_pci_probe(), the code jumps to
> err_pci_msi_free, leaking resources in teardown.
> 
> Redirect the failure path to err_free_irq so teardown matches the setup order.
> 
> Compile-tested only.
> 
> Fixes: 614c23e24ee8 ("wifi: ath12k: Support arch-specific DP device allocation")
> Signed-off-by: Ripan Deuri <ripan.deuri@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

