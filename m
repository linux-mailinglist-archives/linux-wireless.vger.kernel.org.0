Return-Path: <linux-wireless+bounces-27984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD8BE10A6
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B86EC4E00D7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C843168F3;
	Wed, 15 Oct 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="De7YSXzd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E3200BAE
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571629; cv=none; b=RzbeSst+p0+xwMeo3PkxaH6UWONwyLMHkdB1ec443F6OEYZ4kpBEoF7hEWGB58SbFVX8QA1xJ3A4xzYP3jQ5IANPaoH3wLPr6qtu93sJ9gW11K9rxn/jZ26u5jVt2OY8pgnH6o0/bS3rIOxEZB1e9sMfc29vxhEFE9Eab4+KeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571629; c=relaxed/simple;
	bh=h3lPn4SHDuZ8B/SeJzvXAu0IybbNZk7/BVh6eg+ZpTg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LVDoDvMpB2I5N0sJlwukihTN4p14+SuBUzXGY7qTj5r1WSKoaBhTntOXNOkAyVzCPVStIUoW/uJIc5UbaeIRiTezIu5ZS7OMDIPuDac/DMavxwDbFbmUPLh1X4TAgh24F4GGPNfAI6Q0u3taRsWFcWjVLPZgvS3+gbvQP2vzjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=De7YSXzd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FKUmxn016240
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7k/qdyCf6EY6/xTcquD7+nOtawASYKaJ9vAG7HtJsck=; b=De7YSXzdaieLnFDf
	jAAtQDQYcMJ/o6GYul1Etn/4LrB/zJqPdEf/uWN0/pWIfkUboXuPwujuP0aHd/j9
	PiS9AulMU2aO/+jAstFhKr3Vho61Fm9Ps5a38boqsABgugJoNfEG8ugl4vPuATYr
	susaUsiqRxpxK+vtKbqUW/AFpkLzk5AUgZpAw+K6I3Zk7Sme6wVABkfxmakvs8MZ
	xzSFEdopz1PEPnLlgF53D5boLcn7pqv9oDcO4aAivGZnju0rJ6jnO3uR7vMR+tRS
	b9Il5iLMxjGh/GUgzsDmqB5TEboHcBqBByAyFTee7WmsxkyrIUeX5/8mWyawKm1i
	Bphdxg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdke977-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269939bfccbso2255325ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571625; x=1761176425;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7k/qdyCf6EY6/xTcquD7+nOtawASYKaJ9vAG7HtJsck=;
        b=M55N/AxXCP431dC5RqXZQNt3/YHfouHQ5uLMDRXcAFmJ7bvgpioCHIq2J/kuAcU4Zb
         12ygLWsIRpn6f5cfS/W9bdhsWAudZaRBarUPfrJcHjosH/1ccNjirNW8wjutTP8pMbCw
         ++BSRU3ULNxvzDlgDYBmiT8rJObK1ePCs9ETQhtGnnDX7aBtdaoJ6qVifteC4pS2tCR3
         zfWfVeSnHAOCXwD+2721WwKoQ0gffUJ0FmPLZYSow1VXxqm5xciBjij3LU0afXlTs8NP
         otfBs8MiFfqGGwsDA2OPDSndkrMp9X1dR8/8sIW6BhoJktf0fYw8DnN04w/77r4HLh9j
         62xw==
X-Forwarded-Encrypted: i=1; AJvYcCVuvqZ+TeksCNbaCBK6UZ/d7AAKcIlDlLWvPV25yrUpcBNulg3hMjvq3xZrDNhR1pU1C/btWneNSnECMV3H9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxktMW3pOUO3oVB5xpLDixPOkC0UxpyY/KXjLxJYRK91LemPQcc
	FC5PsH31apM4Z+YmZE4dT4gogQY+Ice2Vk2A3SF9eE4x30dFFNa3Z4Zg4lt8fsNCKwJGtb4VaFc
	gZSc/BwJL813TmJMFa/0eAiUQ0aWjwe5yWBQYuap+GLY3SM4QDfHSIim7LNjv9elcCTcx9Q==
X-Gm-Gg: ASbGncuI2gMlKK3MfHFfAIGK/F8skXEOPFmnsyalaQ8Vl4arj69Npa8pwuk8xKhhPyY
	GLJ/3HGPsw/BuBKBjL6yxZ/hr3k8QtgcWi16Onx0JGW5bPKKNKblfo21rXN/nOcR0z1c9fZ7ZVk
	P3LJ9MusG9GsMvtwhK7/JkGN1wFWppCwlJXw4zfat1KFYKaAeBIcTLBi2KYA9UAPQeb/K3GgMXA
	NQOPi5E+Yk5p3jRaRjfNWTUOl5SqQtvtMn1mlsg6vtdq1STZa37EMMn7EcykWbdAAR9vN6T06/4
	JbFAAWgqq/gNA7CbtbKNHHgLiNVbJCAN1IhAQJgCU2+K+7xxQiNpliWYoTi/aLXEGuYMBza0fm+
	Vk0l8gP6dnHshJ3KTBwqnhnfXFVXaAlHnHKE=
X-Received: by 2002:a17:903:1a8f:b0:252:5220:46b4 with SMTP id d9443c01a7336-290273ef076mr338657995ad.37.1760571624946;
        Wed, 15 Oct 2025 16:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3b+nOIPoiIMU331nUi5wbIWwSLiE+vi75IqvlVP09Kz6KjMavAizG2yjkJgPkr30FRstaKw==
X-Received: by 2002:a17:903:1a8f:b0:252:5220:46b4 with SMTP id d9443c01a7336-290273ef076mr338657725ad.37.1760571624528;
        Wed, 15 Oct 2025 16:40:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:24 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: loic.poulain@oss.qualcomm.com, linux@treblig.org
Cc: linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
In-Reply-To: <20251011001038.352393-1-linux@treblig.org>
References: <20251011001038.352393-1-linux@treblig.org>
Subject: Re: [PATCH v2] wifi: wcn36xx: Remove unused
 wcn36xx_smd_update_scan_params
Message-Id: <176057162383.260563.8326792169066963528.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: LUF0-Gjxe9QRi_lPBk0Y1mXTpwxVosPz
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f030ea cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3WJfbomfAAAA:8 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-GUID: LUF0-Gjxe9QRi_lPBk0Y1mXTpwxVosPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXyVBuqh9spFjD
 Lb4reYHdC2r2Knpdtg3GACfhUjuOJILdgV+X+I1V1EO6Pr8oc9DvibRW8T4MkVeppy6V65Tx7o1
 RjnLDsXNlcrXd28Vsh02+itxZuBpUQPheJEzVFHNruKQD+9MRviJTfgFBm6ct4b20bpLl95P/BV
 oxIKad643p1FvUUmJznnh1ihooFocil7h7VC68JGiKsre0LcEhI6mG5rRU1YO65UZMYmYDkDpR5
 mQaZj+v3NMbSKoC9ARaz4KB455g/PJmm7/69iSsTPi1okiiZKpUMHHwpNJvTr+6E/BXVJQnun95
 XCN1vSLU97xHjGh2NYYFuEU5IdRAfzRZMvO0GBCMsuL0vXrXwWW6YG1mjLpZO6nIvlweMq8wE/F
 Q6eAd3+KRKifKkV7BowlOl3wli+Dmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On Sat, 11 Oct 2025 01:10:38 +0100, linux@treblig.org wrote:
> wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
> 
> Remove it.
> 
> This leaves the wcn36xx_hal_update_scan_params_req_ex and
> wcn36xx_hal_update_scan_params_resp structs unused.
> 
> [...]

Applied, thanks!

[1/1] wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params
      commit: 4077d7fb27be990a8ddcff9b49f7e1788a960f3a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


