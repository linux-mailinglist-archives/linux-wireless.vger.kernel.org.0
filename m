Return-Path: <linux-wireless+bounces-34478-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFqyArIi1WnK1AcAu9opvQ
	(envelope-from <linux-wireless+bounces-34478-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:28:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 732913B0F94
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5CBE304D669
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD0A371D0E;
	Tue,  7 Apr 2026 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h9Zk+yUO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OyLXgTK3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36DF393DEB
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575363; cv=none; b=URy8Qt2J6INE+rBEW521DUSZwyxB98ztyd4lIi+B5o8772gLca7s+das4THohh/AXbOdU6nvpEOqtlUVyooWMWGyFSYGhk8yQaQA6nFfi4/dp4GDPVRvJ4WpQuUXc17SOuioCPXx72wVs+mumtITcjVUBxN24WU5bj7z1t29yHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575363; c=relaxed/simple;
	bh=ZxSa87c9Q/P2FnV6ZESN6x0uwkWarLp7y4OuMnVA+u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwQxM81lPuFXlMGivpzEnUOjdprtW1Va9GbKugvNmAZq5JS26+pPolygUgrsasdk34leSY1EYDdQCn3gIztCxwQC/bUqEg4EZXjhf33uWl8xNYu1DnXWdGzvvNSq8Ii+QaruWodiJPnpYCAr0y4iKGApcM2jtEtdos1W+flIrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h9Zk+yUO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OyLXgTK3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CN80L1584355
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 15:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYRabF+RiYhaedAndJ0qtT5reBRffHjDq4Sz6B2n9Wc=; b=h9Zk+yUOz23GTOhc
	cZbnl3Ik5WMdcQ2/d8uuw6+rJnsmeDlNEcO5+2nBLXyYNzU/XdjV9DHdnYs20ka8
	2EhdY1VWgNMhRlPh6eelQBq0BWD3zt9+ZQ6FIebuhtCtURACCS3xELiQ7AY3SAb3
	8FJsaHYt47JM+5NR93W2u4TZ9BdrBPFZApBegsoHdr4biA1eyjHTXFrEZcv7i2a4
	fMEGkxDmFx8pZmFAgwaRHEGaz+L9QwIF0LiSdi7Ylc8w75JwJ+jwrcI4wXH/Gv1q
	9Hkg8gXUvbTAnDCkJcBzohsUrrm4bcCKo4q2jiYg3dRbAwwcOHfxMNiSnCZF8UuH
	5L7GGw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr9uc6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 15:22:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so30877382eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775575356; x=1776180156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYRabF+RiYhaedAndJ0qtT5reBRffHjDq4Sz6B2n9Wc=;
        b=OyLXgTK36MQ+u5/3IrfCNDd4CIL7JPQYZXyFFdc3XPgqfhxENYNcuj3vceJK7nznUk
         lsy0hBhbRWMpXybpQ8wIhP4qDpi17zR0XfIYOtzfknF2bURx4+V1dsIJeZSx8X2su8LZ
         h9sSlPY15F+uOZ9+YaQlIoXcikNopFC+Zwdsm5ZxUGtR0NfyewFq6GzEuhHsYPKIiZAF
         5hXCToWopohZ9V9Tab/6WroZrFnxlsO4jnMxwXLaJsAvXXNs8ziCwlHGbl+AAW6Znw0Q
         A3inBlpJT4CO+dDAnboPyWtsfjl5pKJk1L98ynDBLo3M4ZImqYgA17DxZT1Jp6m87Rrw
         lj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575356; x=1776180156;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYRabF+RiYhaedAndJ0qtT5reBRffHjDq4Sz6B2n9Wc=;
        b=AIZcNs42V4oq9D3dTcNDjZaoh5gv53TFbyvQuYkefWKKzionSO8M5OnAR1lvADXHTI
         yV9hBpO+AtCCDGnHJIEFL3kA1yT7Oi/Nlax/BMq64LY2vWB5OBnj/twlG3bRdScA8CJ6
         8lbhuErN3JE/YgLsaUdnLf1PlBxar4TaWLPxXmGwYCIm6RIMnQzvTF8uG3sMzOFVhQSy
         DdFEzg/Y7NnCcFFOJNjAF3M+Yb0VW/EyUIN2cGBOFjn84EOZIL8c/LrZYlTEVgucy3/F
         nLdRoJQoIWNW96+c1EE9w6aJJAtltEKwcUaOcT2t3DjKOBqc7D5iith55gyP/Z8/qHOo
         MKtg==
X-Gm-Message-State: AOJu0YxCqq/ZUFBJMd4dFyYCabRaRxXn9q0WHabkP8zWW0KpNoyAPtO+
	w4GNVFOMjyVWlgmtQPDC6kFD2Q+gvnBrFVzOnOZ67lCo60WSdxuDyK7trdfi6iQDWbnCZXHRWV4
	mkx9mpff1p3cOzyFmpQR3MYzgHPuQDxcEbU2ip9Fz5LpzyalNLDzY5vNeLjOtNsUi+ziZX7wJw8
	UV+w==
X-Gm-Gg: AeBDieuPwQvp4fD9I2s1FNf5qJoKzGVpRQW88eqMSgV5otGZsk4+5j8ABtH84Icsijp
	YNfbK63v4/JrKAyhQJr1WNAUq9e7DtbN6AdsJAcjTUo44bdEw7LoGm61CRGaf6Gq7V8KQAP7/SW
	2m0kE6tp6ZUA7LpkeuEGr9N1ovUQU4BVy0bsfDjXCh61G9xo5ekGdX5JsnKD0AtCndN2L2Z+Usz
	C1mH/fxfSuWfPDhIWwXb8VM9yoe6sbcziTJF2WdR5AwwRD6svgiNp6xV/3Uoe6gN8EkvWix2FFi
	+U99axti+yz5b/N0zTtaH5j9tbTNuKfBIua5ebBkIlQqObQF0kKbn9Td8Dlb7zm4OGcNLJ/Xiqq
	Bna/QfeQatLxf4ZSdRne8fAX5Yd1uF4E+QnAHLKC8eAXlcbnXopWIlYkkdgHfT4DuTozREMPXaj
	hxujV0ow==
X-Received: by 2002:a05:7300:824d:b0:2cf:c1e7:521 with SMTP id 5a478bee46e88-2cfc1e70755mr3066747eec.17.1775575356359;
        Tue, 07 Apr 2026 08:22:36 -0700 (PDT)
X-Received: by 2002:a05:7300:824d:b0:2cf:c1e7:521 with SMTP id 5a478bee46e88-2cfc1e70755mr3066721eec.17.1775575355744;
        Tue, 07 Apr 2026 08:22:35 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm17619573eec.19.2026.04.07.08.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 08:22:35 -0700 (PDT)
Message-ID: <b8248f7b-84c5-471b-af58-3a655a7af95e@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 08:22:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Support channel change stats
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Harish Rachakonda <quic_rachakon@quicinc.com>
References: <20260326050641.3066562-1-roopni.devanathan@oss.qualcomm.com>
 <63acfa83-753c-4b45-8f11-8e18e760cbf2@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <63acfa83-753c-4b45-8f11-8e18e760cbf2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SMdykuvH c=1 sm=1 tr=0 ts=69d5213d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=oa6df1jTVhldLQ0IEBkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfX4hB7XNXcQ4Cn
 8A4v/LaIDHyUd1SyO8y1TgOsHs59RDw2mm3W94V1MCrwMXGllvwOD7xuIw2N6t4XtDjFoF6uQtl
 rOgjL+uMvGeeHsAUfxH1Gtdfd7dcO3JKi4CxC3b3xO0EVo8nHSeRD4khcTqq4cI30MakzKjDuQj
 4yxyPSk+eI64Rbv4qPQhywy9X1kAWb1CVpBtjlheAxJkcSefuEqduLmRKP/h7OHZyx0vQ0fN6fM
 1fJBA2tFWYQd34ZhUFjgyrrAe0uXnhke3a5E1L7quh15yw4wAdz8NdEJZ0wIhpkvzejUZWsEk3d
 B1ATJ45Pv8wXY4uXopkOGStjXUbVtIPpSMGiHZR4Ni2EU9edlYQQQEwJf5wGkJXx0+gRAn9ZQHL
 oVkGlpmx/qlok7i0nNtodvvgsvzxPcKz+rAvb32X8cGAFqdeVDBqe18vt5swWRGLPTWjy3nXSp2
 93jxSFg/SOwkjVFb3xg==
X-Proofpoint-GUID: PtRQh4ahRfXr2ktv_FyWO41sMVnIxdZD
X-Proofpoint-ORIG-GUID: PtRQh4ahRfXr2ktv_FyWO41sMVnIxdZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070140
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34478-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 732913B0F94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/2026 8:23 PM, Baochen Qiang wrote:
> On 3/26/2026 1:06 PM, Roopni Devanathan wrote:
>> Note: WCN7850 firmware does not support HTT stats type 76.
> 
> this note also applies to QCC2072.

I've updated this in 'pending'

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=a9adb8f605d5660f1db49f8cbec51ff73b4b7be8

