Return-Path: <linux-wireless+bounces-38257-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /+POJvESQmr1zgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38257-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:38:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0984D6D6646
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:38:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=WBE7FiYd;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=e7mhpLZ8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38257-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38257-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5110530088AE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A746399CFC;
	Mon, 29 Jun 2026 06:38:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D838F64D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:38:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715113; cv=none; b=SEpN+UCuIkwVJhebxZ0eLgfMC89GF81jp5qF7mX5VYtS/mvSQ0Xlc9oSQ5nS/xttAEvQZomYwb8Wo+YpjnBh3xiGgInIWp8vtwLGA6G9RyPGFPrIOfXDQNifQUjucjC9pKhHjBFcb2+xm5angmEcC2/LNa6zrvqqs2boVxMlUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715113; c=relaxed/simple;
	bh=mzj5fbq5Xz8PSbZ2cvCP1MtVC8k+PSJwe1iO+mfwVKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pl6gOcoMmFAakxDzw39+wi09WoZz7xLtzw1JI19WKhjImZBle84DdHeA/d1EVkM8fXI7dWUL8My0Yx618Ma72HDXttmpA71CaYS8/KwyCGgfs+y0wRRJ344BcR8BaNI51r/Tp9kgLkwfRan8+kDhOW7h9Vtduq/+AhuGAt1K8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBE7FiYd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e7mhpLZ8; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NFB21729604
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	arlpIOlawXzNPeVHxL/YlpYmCKpbjQtKKgS9w8+/iH4=; b=WBE7FiYdOcRV5RoI
	ZgCHZiGTTkIeVVcljhxf+ooY3c7zEAA5Y3tuf/jL0bV128X5uUOlwPTB2xvyjk4t
	OR3sGq5S5tDTzd+MxZ8mUbe2041LcUs9P+lHZuNam3Qg0IkD0XuSLZkLGQr+tVCT
	8czz/nqcbpM6y8xvYIlzwYFb0BiVYNNyJIgbXzamxHI8QpuvpvQNWUSwkyQmT9Ek
	zImrYUQClYQGQs9emODSGawT5UKLCREyt3uZLMlfr/wzcJu1156Cqa8/OAc0CPY3
	FJyV8Pnf3lSi21wOtfWDPLTo1I5Rp0oZCyXHu75s02OOXOZFENqx0RZvnKs9bgnK
	cAbXrw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7vupg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:38:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88e0f04e51so1447010a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782715043; x=1783319843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arlpIOlawXzNPeVHxL/YlpYmCKpbjQtKKgS9w8+/iH4=;
        b=e7mhpLZ8cQOS9aLEp050lpa83O5eZHKeT6zmQJwj4W/3t6iXiXiKd1LvEBgpwWL1lX
         nNXIXw9fQirE0VPwHINuNe2zPl9wTyYyTecRRFwNODGSvZp8r6mT++lOSbfoLMGtYKCd
         nkEkDJNP6ttjr+QWKHLWSoaxHSH3kDTceE5iZfjPmFAI2POJOlZFAJhy6ilrnRsJ9Qp9
         sBVlICippxTwlxqLNtLYylMkdRUqqKsfV8VK4AQGNA2aLg1eQ9A1bCRHmMCRnyvqGRO5
         rwsy1i2Ns4LuWxt/PwTpbjKouTv+BwN5a1QPMwlhRBAuUlF3iEBZqWxHQsoQS/HSm81H
         hy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782715043; x=1783319843;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arlpIOlawXzNPeVHxL/YlpYmCKpbjQtKKgS9w8+/iH4=;
        b=Wy1C1UVDha8dSrlbMv9YLkfotEKrzLlI0uOE6S9G60IysHTPJsti94IyhO91jrf0+q
         o46sf8gNQqOxkwG5Zz2tYqVHSGsDy3cylD5pIbO85lARurV1NY56gOEro1AL+hNqeB7Q
         FelIImdAdc200obQSSt/ol6flYQ0i5SEduBVdywb+S7yt7skDqjX7QudH1fqi6RZ/8yA
         Wj83P/fTb3mP8iqVTEijhTzp57NbGhmIa/JqZaTeGRc1qp7V0IhcIt0itZJKT2zeo7R4
         x2HmQuAQxvkewpysWx4aDpEm/8R3Vmm2ArRgsEVUEX0x35XEHEnnZws4TLZzg/M+Se6G
         sHAA==
X-Forwarded-Encrypted: i=1; AFNElJ81MkmEuhFHEkYfrUcvfepqcyGewVSRMzSb1ZDRcsby2JEpbmDle76LOvkwtpwDHl4PSh0HrS8YmhSWdeOQbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYqlZTARlH8CvFAauFU1zMnFcRpGn4pGcmWTEhScsqkK35W8w
	krz9udDVJ182MbsgZ/7lhvBhqe52Msax0pGhYhNfp16LVKFbGebBY1NYQmmz/2B+NKfb4UruvTD
	xzHPK97XYDJCDAdrxzvzWUcerERBqMWO5BA+FrS1yqgBzF0WfEzQyW4qsqnXVCDKLxyM8ew==
X-Gm-Gg: AfdE7clbtW07YlxwhEWJ/ffWe1h9shNntNPwzI/Ro46UxxulGmlrHwh5tLCphPKJmHK
	+xkCU+wzYj/uwtDEVfryXt99wXqwgjB/1C9a8lUNDDoW/J+8MhGQzQpw2w2NDvsflkkCQMKlBU1
	ShyGg5bSiqb547jPk5O3Ycgr0M2sWgoWmuEbLD/h/nKfFNegldSSmskOWOtR6PMSVCFrSSVkt9d
	9fVleNyOTbMf37fA2nE4ExKNsVy2Smjtr/27g23Hw8VUCnXlU+n10Dx/HZNZyG+GjyixEjB8kI/
	GWGKBCkqwnZB6eZkdatbhLyZx33BEV8scmJTBOmaQ7x392hoG9pc+lk0X89MRSUIIKYgx5CHfbX
	ngxYaNg69MikYxjDa4V5tLzn+yDILyy0UK7Kz8Y3BBeZYmhjtOtVENSnjmiOew0JpM2/1eX2V30
	+tLGjB4Q==
X-Received: by 2002:a05:6a21:4516:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3bd4ae9f317mr15418832637.35.1782715042457;
        Sun, 28 Jun 2026 23:37:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:4516:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3bd4ae9f317mr15418822637.35.1782715042007;
        Sun, 28 Jun 2026 23:37:22 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c96f1f700ebsm2193606a12.30.2026.06.28.23.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 23:37:21 -0700 (PDT)
Message-ID: <3b028746-b00b-4281-a485-49c14c4a026f@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 14:37:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: fix rx_mpdu_start layout for
 QCC2072
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260629061529.1993932-1-wei.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629061529.1993932-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1NSBTYWx0ZWRfX1s8xx/Tdb+ye
 twgb8706sI3iSeW+VviEgzlw4FGBKerzMekp8WhKaMCwinRN1vO0FWFSpJqav7A1MC4wvGePzVT
 OpsXpfI3RwiQUnCUlpwUJwOhtQQ41gurB9x42QmyeSkiIx57pHFBnFLPskhcJ4KTtc/JReytYBH
 3sTH80jyYfqZHxQgTMFSWaKkPiCRXGxeuEFX+btyHaiAX//32Y9sONteI1sSyQzQiiofrl/XdXN
 +S1e2AjnnAangHr5gplrxixsFS3LyUFzyCaRkT1uQC5Y7aEsbyfKZZLs0eUX5mXeSA9inn8bLca
 XO10lc8huFZZJ7W1rZTDNcTGP/ypRnMqIxmbSt1iCLBmbOtj+Fl3jHi6RicNEGdmw2Obmt+cbHY
 /n0dGwSjx647+4YP6ys6HXF3fg97FrNeUxRWPhzPTeG5j2Q3CXWGu6PHFSpGIyp4ZoJuCPeErNC
 wjtaZqkmIbwUh7/C1tg==
X-Proofpoint-GUID: noH4awQ5Z4cTztEE7nJaYeD5slLp92gk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1NSBTYWx0ZWRfX53qDb50cskAv
 /TjOZ2dTUtkaZR1cRkdp+dBmXEXN6yMFIiXfPehG4lkyHZuYl7r8ju1j+YQCcDXYJhAL/kPCPMi
 9ed3VmSaM7ok+ARwGhBVrYgMGe2KqUE=
X-Proofpoint-ORIG-GUID: noH4awQ5Z4cTztEE7nJaYeD5slLp92gk
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a4212e7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=EB44UgcCvd3G_oUa3FEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38257-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:wei.zhang@oss.qualcomm.com,m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0984D6D6646



On 6/29/2026 2:15 PM, Wei Zhang wrote:
> QCC2072's rx_mpdu_start TLV has a different field layout from QCN9274.
> Reusing struct rx_mpdu_start_qcn9274 in hal_rx_desc_qcc2072 causes the
> RX datapath to read the wrong offsets for info2, info4, pn[] and
> phy_ppdu_id, producing corrupted sequence number, PN, ppdu_id and
> mpdu-info flags (encrypted, fragment, addr2/addr4 valid).
> 
> Add a dedicated struct rx_mpdu_start_qcc2072 that matches the actual
> hardware descriptor layout, and use it in hal_rx_desc_qcc2072.
> 
> Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00188-QCACOLSWPL_V1_TO_SILICONZ-1
> 
> Fixes: 28badc78142e ("wifi: ath12k: add HAL descriptor and ops for QCC2072")
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

