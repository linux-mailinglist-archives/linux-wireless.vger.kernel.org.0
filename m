Return-Path: <linux-wireless+bounces-32481-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMo2Cti8qGlbwwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32481-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:14:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEAF208E88
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE6A30699BC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E52388395;
	Wed,  4 Mar 2026 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgJfvyip";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WV7wi5xl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F077371046
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665876; cv=none; b=B8Urm3pAMnyTqFfwM57nZozVnecWCFd2CmHRc8wPflKuSMrrEAa9up2BLRPHZRmjYXQOWliyDY7HgVqJ+opAVy88EExVloB2esYCPfjesT2MjVJp1b6vfvjY87HCibR8ZTkRQ5t2rZeitVo2J/m/n1cZGtDnblGPQbET4NdP5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665876; c=relaxed/simple;
	bh=vOce/JE7LG1p+RGaZuWGSx2EqyEUcANfT1wKL237NiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Og0JXtT4mvmzU2bbGhYEBHaqsqyPSO3GnLgJWz6mftOzS0HePuyQ5pxxYb1BebuxNflTlZUGo+JEdyfyPd20r+Q/Ylj6v+Y+xEMiOBmwFjDaJZCIRuhQrR0L6DeuBMil6AxWTovaWjWlI9N9RRCXyeYG0pdnl2NV8Aew4X9i8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgJfvyip; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WV7wi5xl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624MIEDu1203427
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 23:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NNcYfHKnBv/HC5azm5P6gSUdX5OWno2quQz5/K2vsTs=; b=RgJfvyip2L6F/WAQ
	OWmicuy3GoCjE8kfmR6Zz4nxthsmx8dloIhN8Jtxp974jtkVtfb3ZueOxGaGeFT1
	Yv9L7/94yduQfQwSZfxi3FA7AxolU9trR+2OvbKCzItt2+NYgzYhP9Ir6c/Q88l0
	pmB8bUBgv1nEBDsYh/ip8kctCk5Cz/oJrMkuGvu6qqZlBs0aXcgGVTl9jFQvdxbC
	mdPXBJiubYK/lWSuMY0A4Y8sGzI0PNmKXiy47XX03kBU0Gq7hhxok/RLGWVw72tx
	3g3iADk9I6wW/JLCC1bMBtNJgIgq4a8nWgFfqrUDfy1G+mFT6KSjIyynfCvWUa0K
	IxHRMA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpf9c33xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 23:11:14 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d18d6e6541so35952478a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 15:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772665873; x=1773270673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNcYfHKnBv/HC5azm5P6gSUdX5OWno2quQz5/K2vsTs=;
        b=WV7wi5xl3fNk1PIKpuyMrbkAmtbt3UpC/EX9LzdCytln8SO0JfkcdeRv3CFv7t1cy1
         7rYUYBxCYPJpLvieBEpQQbbVRvxGPwvBTsA21PMEGo3ZkINKTHEv5WAxXrA4zvXOvqOF
         2TuqG++AwTlmfqo0jqHKE+wm4IjcfatEQ+kbBRqAbH+jQcWw4wpdFMK49DdpkKqA0RyE
         AS0vFVyGFnaev3WU5OgfrkIJNDYUXrzmaBHaGv1hMJROzra1Usctk7M7eqAsUNJ5lFQL
         DHoBvn3OXwuLYtPDfNWTClbokVyOPJvqcNrfiOccKhyGYvbkea5hU4epL3AEQAoJfkwV
         enAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665873; x=1773270673;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNcYfHKnBv/HC5azm5P6gSUdX5OWno2quQz5/K2vsTs=;
        b=pJBFix564okVfA1TMYB8F4jOTs/esn3dNl7Gr3q50zKAyTSzLeDgOVfNjGFipMnZAa
         eD8Zt2rdkqLHPJR5Zp+rO2WnERroXPJG4DzEFkS4b+ae8R4mxR/Xj51WXmjZZI7E6iF9
         dETCfquvDfOLHzX1dxTNDWWTJPRDAlaFZoRIPpjvShx3+L5bOqkMLPlNXL+BO2QYGx4R
         VOiygOFTMj+kQvaBPbg5O3AlV1DtBokv37fE5BqYK1gh/fPk26eZfvHwEsNDqp00z31Y
         jZuXswLTgF9HgOhXx08ufsyzkwBvGw01xNJHZRKfjj8yXCHLOJDO6tloO+g8HkrCsOqJ
         05FA==
X-Forwarded-Encrypted: i=1; AJvYcCUJQ3rqrixCkuRuQWoAEdt/NIN4adfXtYEEc0PBu/jqcL412BlodACiqu3sw229CYyHaN6tG9AyM/qrvOGUkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9zvKEwig/wABlOuVd7ALsb3aDcr00egXCDO8ZO+PyHsCSRiW
	S97hgviBPZMy+TwDROMloMegcasZCcBHeOZZgz7e6zerVWKRmZpqbOeDQXT7nXfghI/Zk7bUNFR
	epTiWj03mV6xdOGe7CVtTKv7XoSxtxxKnJFbkAYGQ3O7xB4ljgz5dg6RGfpiwu4Cr2H7iBQ==
X-Gm-Gg: ATEYQzwl5VPBfHtuCZT3V4hTl/ejIOJj/juUBxgKUhfq0UQFwx2kLWJgGmOyLjjnN41
	ls1Hr8Us7u14pBdgUhd+fizYRQxrnGxbZc7pmB3q6pBlTixgv2y4cw6bdCeP5dCwUBgp2rokbro
	I9Fp1FJmxGyxcpi/j38z5ao158z+TTOjCzJv4S09wGhxz/FtlJMbMpBq2MxpCbHYXkZYSqfaUP7
	RA8kK2QBbN+rZE0Ijw+vwOK821TUrU8tQlXnEhHPRq8UeOKtVS3/1cNvt0YwNkU7sdxnU/8ffmj
	QSH5YRWEhGnGrq0IsHLvAa65ZEdzDuMTc/RK63gI7PwHYj50j6e+B1lSv9spzXylyai4w5lVb7A
	412pM0mkQm3iUZsmaofYmBBsqbuqMjTeumQmmTWdA+ScFR+SrMRMuX+1IRMtAhzeiAUKFwClftd
	DebDYTD5pr974KZA==
X-Received: by 2002:a05:6830:2782:b0:7d4:5341:475b with SMTP id 46e09a7af769-7d6d13a5653mr2326967a34.22.1772665873587;
        Wed, 04 Mar 2026 15:11:13 -0800 (PST)
X-Received: by 2002:a05:6830:2782:b0:7d4:5341:475b with SMTP id 46e09a7af769-7d6d13a5653mr2326940a34.22.1772665873171;
        Wed, 04 Mar 2026 15:11:13 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644dd3asm16651056a34.4.2026.03.04.15.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 15:11:12 -0800 (PST)
Message-ID: <726aa68e-ef1d-4446-95d7-2d31e867a593@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 15:11:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: qcom,wcnss-pil: add WCN3610
 compatible
To: Kerigan Creighton <kerigancreighton@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com, wcn36xx@lists.infradead.org,
        andersson@kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304192409.927562-1-kerigancreighton@gmail.com>
 <20260304192409.927562-3-kerigancreighton@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260304192409.927562-3-kerigancreighton@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE5MSBTYWx0ZWRfX1+YYme/ZJV11
 MFR33sIc/zxKmTtS01PoDVPcUGt/r9LpKyqpVfwfdZ9xMh1XNOTn35f+taqYlODpWYl1t9OTlTh
 27tDl7S2Y0V3Incj43+JI9gjlGj9PGz6rLX6p415W+k/BqMXqm9Tmm+370zunlO19yapSKJhU/Z
 LlHWISCjjFXS7TUDMl7gwtc/gL/8W63uEq3LKsnAyZRUh9t9+3vA0jwfcGwiBUJKYMGUqgXwEu1
 aFwJJFVKogW3wNhBNTX5Wt4zZQDIJNqEsVz3ivc2I4WLW+WVC9xfadSiQnM1LRTjAC8maQF0uP8
 Qd+YlKthalWZ+OVcuFrkZjPhXSnlI2XoAwxJ6LqdFRTeutGT55NVjM0iOnu9WmjwtDLCkwBsQ9X
 9xxryQf5/MKIu7t/98zYul1VS8P/L0sv+ZaQ8zlE+pONQq/DxpWb2DioZ9YEalo9ZCTwsQggYky
 t3eJsHboOIkCpc8AA8g==
X-Proofpoint-GUID: r75eQr01TD9bzvgVqmCtq1WFKFkHEOsD
X-Authority-Analysis: v=2.4 cv=S4LUAYsP c=1 sm=1 tr=0 ts=69a8bc12 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=qgblvH2Zgt1UI0Rk3qUA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: r75eQr01TD9bzvgVqmCtq1WFKFkHEOsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_08,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040191
X-Rspamd-Queue-Id: 7CEAF208E88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32481-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/4/2026 11:24 AM, Kerigan Creighton wrote:
> Document the qcom,wcn3610 compatible string for use with
> the qcom_wcnss_iris remoteproc driver.
> 
> Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>

https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html

"The Documentation/ portion of the patch should come in the series before the
code implementing the binding."

Also ideally for any multi-patch series there should be a cover letter.


