Return-Path: <linux-wireless+bounces-37446-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 98d1KuNqI2o2tgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37446-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 02:33:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4474E64C053
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 02:33:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="eenqV/qC";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VMuHf7ob;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37446-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37446-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D978B3019F23
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 00:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AB91D130E;
	Sat,  6 Jun 2026 00:33:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5119E819
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 00:33:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780706008; cv=none; b=mXnaPeNKvulkqUh67+TwufN2Nx5T2Mno2n2uSF+YSANk27GPYy7/ev6qQjHpmia5j9KZbhZCikFNSGPoxXJjeE1gYAra7tkwST2O0mpbdQBCr4KBmtQa3ZIMZ2wmEGchaW2nhLVzq+1K/OoEnZcGk7lWB/mHyc9W705/D+7ae8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780706008; c=relaxed/simple;
	bh=sQRBjDxFXr3SfHUmFdjcdaAOIAmTB/unuKO7H8NrGb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMuenRaSBGBLNEAgnfNI4otzrUX8eUoc2YBVuVnVZhCIfjh54XUf+RRQwM0m+7NWkHpS7cuJhITUTZifZ/Im2k2iLXCpIdT/0X4rncegwtHhPBwnWpVemuUe34lZXcm/QO5Av5YP1CZQwoBvbPnlCS2IjVMPfrFb7+OXM034mOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eenqV/qC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VMuHf7ob; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655NtGY12096785
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 00:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2cEb65BDmKUbcUgyRPqAttYJTDUaCl9UW5rhJynFMpQ=; b=eenqV/qC61m15tn6
	2tffW4cyC3KQEVfSxK7kIVASuL1UPl7EwYf/4xq1Ez9iWzV5/nmPPkG3HR881zw2
	b3DMF+ssQYSKyzF/+dAEs0nXOWo3xsVx66n6rbbmq2rm2Wct49/Uj7eMUiiE/eA8
	DPaYE+2ONSw+I36xZhc57zm0I5PgXd8WaBSI+L04C2jjhPdqlOWnamqpoJ4sumqx
	hYTK22lQDlyTCb6jqcQwLADc1c0MIpaOVSHfYHoqsWIRozfhPapTq6QTsrTDqw3C
	VqAlyhE5VMhcREcIAMszvSDy44VXBXwQcTER/mM/e3caT1McSJnCFvsOf1Atpv7o
	0YxsSg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eksf8mews-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 00:33:26 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-13815cb1507so205146c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2026 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780706005; x=1781310805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cEb65BDmKUbcUgyRPqAttYJTDUaCl9UW5rhJynFMpQ=;
        b=VMuHf7ob1gjvYOlsp0gNfplJ5AP5w4EZus01LMYUbyTU72XliRlpY7Kz/7beKAbD6e
         aj2lb1bVg4fnd4VX3KbGlveT9+kHEvq4Zg6H++LNadXWSzk6+LqfdUQ90QDMCEhsSrcb
         qM7ZlDJRu6s5NSBWA9KIcPvksi+Ktb2zrR8B/PAV5Cl+m4I0N46ZDgVpDf6gU1sLsjtq
         VW8pRz265ytKaB8S4jqX3eqXpSMRI3drBAWfxrdcyGkAldLZql6/vc6RQq2+Cj6oGIj9
         JkNQ7Dih09ckLYUpxucUNFze/J6567QJyzvL33Wo4Ak4LiFwH8rF58jajq+pVm/Kk9fE
         v2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780706005; x=1781310805;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cEb65BDmKUbcUgyRPqAttYJTDUaCl9UW5rhJynFMpQ=;
        b=p9wv+jVy7L4d9W36vl5tQv5Iu08ijJK0BhLOWcFXk9BDSpAhJi/fEBxp7Mcy9U7Z+j
         iW1uoHkSHYTuUdQTgfJ0o1u8Y6dWTROfEMAFmBsedXh+gZhpacjyT9i0QE/rwGH2zPk0
         Cuqbw9RNWS0nj1xBYLVmDG0sHi5grGvyPBqhCHIA3NXnu5RX1QXvhRsM6Ok1bQiXLVYR
         pDjex6QAVUDJFW0jejZ7d2tQp25Qt26t7QvuUfzTDTNd1OZZSG4nWevZb1axrw80nXV/
         GyHSh0vWfdXL7e7Chyo0HZIVOYMVAb/hBF419PcT0ztqEq6pMXnkgE+FLMl3w52QGLKo
         Jicw==
X-Forwarded-Encrypted: i=1; AFNElJ8hkJy3UcJZeDaOSixyNWjED+3MIoDj/lqSrbvF9rNAv+MggTzhp2af/iLzhe17xCLaWo6la4rM81Ju8vHgww==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqg5SHZTth8IqG6KLpNj9kiekEu/aAAhc78bLH+5J1Yo1YxsWa
	b4Pn9nFOSCV8PYx/AwvRjYBqgoySgf+PI/kvl4EwN/VTjXOEaSfA6J67rO+kEug5z8G1I5rAR10
	GARzIapKXdPC2svxskrW9sO30PfMJAwNxbW5leCDZvGFnm8MVrS/N8GaxctNXw+hDmEJFNw==
X-Gm-Gg: Acq92OGlNlRP9z89QZD6FLfzfeaYpBXEnmrggBMVx1TJbfrZJUZoDNiTvv6DpDoSZGZ
	i9gdDILvEGZpwrKJ7dn3bqs9S4Jwl1Xd/QgF00Sxa7l+PWK3mYdWuX0m5p5Y7VRW3IRlNk4MmC8
	BIjWVwZA0dL6A46K5ib+6yaOCiQ5Z7/bzKfN7kV9IH/u+YZeBW95qeOpwarmjovugA7r4w/bvSU
	HI4A7P790Ok6URq4fbL5O/SxHmHPZEaKY3BIIs9xQZWkuQFPR7CoYPN7qZhCYdD9g/ZG2F9ZcfQ
	PNcO97IHvm1GDnI2hgPs/+xcXsCSEHDC0XxHkB1ecWI69jL+1kqMvaFKKl+yGF0Q4kM+Nhk5f9x
	YNVJPyRajhIBwMTpgCHv7bxvavrYlNjkT+IAjn/TWozkzM8faURsNITHwv83e6PbMpuG4rgXwAB
	oO/zbhAVAWA89ILfH+F7apsjtE
X-Received: by 2002:a05:7022:6999:b0:138:104:439b with SMTP id a92af1059eb24-138067234ecmr3107185c88.19.1780706005091;
        Fri, 05 Jun 2026 17:33:25 -0700 (PDT)
X-Received: by 2002:a05:7022:6999:b0:138:104:439b with SMTP id a92af1059eb24-138067234ecmr3107155c88.19.1780706004568;
        Fri, 05 Jun 2026 17:33:24 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f548ade9sm6695047c88.2.2026.06.05.17.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 17:33:24 -0700 (PDT)
Message-ID: <ecad737b-ea4c-4f32-b519-f338cfd6d48e@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 17:33:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] remoteproc: qcom_wcnss_iris: Add support for
 WCN3610
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Kerigan Creighton <kerigancreighton@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com, wcn36xx@lists.infradead.org,
        andersson@kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260306004344.10968-1-kerigancreighton@gmail.com>
 <20260306004344.10968-3-kerigancreighton@gmail.com>
 <4f94c20c-d06f-48e5-95fb-5380c84a1b99@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4f94c20c-d06f-48e5-95fb-5380c84a1b99@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDAwMyBTYWx0ZWRfXzzRk9C9G+BEw
 l+ugkqIox6umKeNBEEn8Sn1H4DodFP5gNOGpdqVB6FC6FBWDS7Idq5FiPaRY6f0Ij2K8cv4yYV3
 fnOCTc2ips82aFFMDsFX3xiHW9FNqIyqWzJMqUtFsNRu8r+6i8ZldGvqkPpd3zEZ32RXQ3wXFJp
 Cpr2AoUiuba4KM1VJUN4PzWF18xEW5MIHS5uu8sz8I8+TYO53YjclvbPN2uO//tc4G2zKUJg3qO
 bpdD0/zWg+5V0OE9ykqMY3XLDVdENj5q6jzFkrOJpC6Ly/dVjP80w6jcYTD2Bj0nOS911LOoUVt
 eN2XEL96uDwAsdYdoVaJH0X13GkI2PlJEzz3T29HcslFqHeMgtWaJEER+CR13TvyOX152EnmhFd
 hyrRT/ZzhnvxNY4+FwztBVtoNl4ZkIuUVZoZYbURUJxKsxaStmmelYTKDXJ+Tyj8p+sTz05lWFd
 ch3xLd/EmIHdpLP9itg==
X-Authority-Analysis: v=2.4 cv=K8sS2SWI c=1 sm=1 tr=0 ts=6a236ad6 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=P-IC7800AAAA:8 a=95oUNTv8Wr7FWHs3mqgA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: bBQb1L5pkwMUW05RgPI9gCGK_GzJaGLG
X-Proofpoint-GUID: bBQb1L5pkwMUW05RgPI9gCGK_GzJaGLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060003
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37446-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:kerigancreighton@gmail.com,m:linux-wireless@vger.kernel.org,m:loic.poulain@oss.qualcomm.com,m:wcn36xx@lists.infradead.org,m:andersson@kernel.org,m:mathieu.poirier@linaro.org,m:linux-remoteproc@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4474E64C053

On 3/5/2026 11:25 PM, Krzysztof Kozlowski wrote:
> On 06/03/2026 01:43, Kerigan Creighton wrote:
>> WCN3610 has the same regulator requirements as
>> WCN3620, so in qcom_wcnss_iris, we can use wcn3620_data.
>>
>> A separate compatible is needed for WCN3610 because the
>> wcn36xx driver uses it for chip-specific configuration.
>> Specifically, it sets BTC (Bluetooth Coexistence) CFGs,
>> disables ENABLE_DYNAMIC_RA_START_RATE, and disables
>> STA_POWERSAVE for this specific chip for stable
>> functionality.
> 
> This goes to the binding description where you describe the hardware,
> how I asked.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
This series is sitting in my patchwork queue.
Based upon Krzysztof's comments there should be a v4 that moves some
descriptive text from 2/3 to 1/3.

Bjorn: Once v4 lands, do you want to take this series or should I?
(Need to know if I should wait for ACK of 2/3 or give ACK for 3/3).

/jeff

