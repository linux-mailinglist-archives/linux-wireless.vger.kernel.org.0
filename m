Return-Path: <linux-wireless+bounces-29250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5F3C7CA58
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 08:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC40F345E49
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69B17E4;
	Sat, 22 Nov 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hVxmHiNl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GR3y03g0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF472622
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763798120; cv=none; b=cRyTDRisILYW44x2JDEy/vt1Dcxz+ex8cYJYhadnEUAdoAsQUlolF/rbc11Zh+jjMkKm3L7j2qwH0z8sFNo5m6K9vo7Xi08GSWwTEbIWOTkrufPSPADAcWhHWU6+KZIy0WoDbi/8brKzVpHF9PyLeAA6gHHp9O3IiHdIOZsWFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763798120; c=relaxed/simple;
	bh=IDpc/D4gaVHFHk3BUuwYPzy8z+OGFnnjTy8mnzTzB8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmwajIE9FU268oMUtciwB6h7FDYIV2yAipHKYWfBWhDWq/qtkJoM4UqRU03EJpAw3wCDOwGX4o50GwVBeg4+TFmyBjyQ33oim2RdFjdIuKbTxl8c3smANloMeBxmp/Gh+fZAqeqLaCrLiHFWxbTVP0OMXasW3due0sgxEs1h36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hVxmHiNl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GR3y03g0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AM5HUuQ1717289
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 07:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2RD2ZyZ2uXfQhNzRr2Jzkx26Vt8bPaSsVD2Beg2JUtE=; b=hVxmHiNlni4mT4rp
	ICRhMFlYhSqXba/XGCSYET4NUXFDzYCelDnY2EFSsjfD7vdYXx7OFmtjsNfxybN+
	P/mAMlbgHG5FfTgUVLhN0iPbEprJBq235rXSpdSD1Krb3rSHnjgwHZNpwOfkVZsc
	MnKjrCaeJZ7MeZ3KkUmgQX+s/Yv6q7arfLJqNC8cK+CygAO4rvFCQreiEH72D+A2
	aSjQSN9VlaxxDOgAZh8JS9b+x/TidG/mGB4m4xDLqJTWZwmWIvckXp9G9At0x863
	WQtn4oZTmQuUEZUcBD6dEIqjnXQZ7qXekXgWSJ9SrZVy/0COzFM2kFFhfdg81Nqc
	cU9p7w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak685r998-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 07:55:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-298535ef0ccso29953115ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 23:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763798115; x=1764402915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RD2ZyZ2uXfQhNzRr2Jzkx26Vt8bPaSsVD2Beg2JUtE=;
        b=GR3y03g0EkQLAYAZdmChB3OZhd/2eLjpAzJczn+WGhFQh3ENHvKYsNvFA2YVgywboC
         bs2xrf5d/HREgg74rx+q3Y4g6sJr1jX/2wm9bjOTaHw0FjbatpGY0FkvG9WyKHzvA1O9
         WsMdEcPHLWluO131KAVZQjcg66/uPk0se9PF3kY3H1CReKAB0eE9sqNYTdqqJVYuf/WQ
         YziXSEYPWqO+VInTjasNCGv5KjjXck3ZCMfkkjR7XbdNsH2SXkpUfVnbt++lNE/kO3TA
         xkgppMSU5LC+ZrEIIlkxv+7M0C7+4VRjy//l5USbQynXUntCFrrrQDB6Q5PolHuDJ7Qe
         XEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763798115; x=1764402915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RD2ZyZ2uXfQhNzRr2Jzkx26Vt8bPaSsVD2Beg2JUtE=;
        b=KzqCIZmy9mljnOz/PYsJKPA4mwcR9tMAUiq4fnY/Bv5tSDT/62dAtiLT55THmPuvTJ
         hDiofpaoM4bVTdCcZTUE/234KqGLesTSVZ3QjrbP6fWG2PP3oei5JJuLOXvlg2q3z4jd
         oKKS36j1w/GNU1YCcLrlZSrqeBcppohelTGns2vPc4mFtp7j9IZnjlD30x7V/ozM+N0C
         ocWiT8mfmiiQHcXSPAUD4XNTB7G0jHkTe6Gn5pGRIUSOj0UY7yEJAOUGQ3tkh3HId4UA
         +OfmClpbjPshjmtqpOampWhLYKGtak/DwY3slUKR3L3OY4IdhmvG8tZS1wbS37v3bqbo
         hBXg==
X-Forwarded-Encrypted: i=1; AJvYcCXVsSfhFeaJuMSvYTjvF9NL2XHeUo9+BgEtScLsJmg5tSeHetU0HhKXA3WWLNNqA5DZ6y+gAVLIf2f3lbAxog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OHHqj2QsvaepxJmd9pHfPt+R0HiV1/lgNkDIyx9jnBNbaVdb
	MvBB4l7Px6Hc4Tt4Eho61PUl849pYtyBBLppGhBg5hKfWRD2Xcn0XI3ybY5ZiAXyuwusrrryL4q
	/qqHbK4fG2+X+Zoe3a3YMCFeC9HJ7Gy34HpItbgPfTAk3xXqrisi7TaXxcc1015FxO75GxN3S2b
	eceP6X
X-Gm-Gg: ASbGnct/PKXyp4VoLGFrYhYZYnthjZIidMOXzbGFSRAKo3OXS5D2ZMu8XyM9aO/goyy
	8hH9kgNVXro4z3AQoz7fY+ubrSlH2E/YoQKCTAChO+5DUBtKFTb6Yx5b5PzFxLe/OSq0WIMzHVM
	ZqEwyBs2C1Z0+ehmO5DxwSh2NRR5aauFHReF6B6HnV3rcNg1YKZMq9i3sumCYH0qCANkNnwCGYd
	nmUNfdN4dk+E9GQHaT/tzXB/EE7APM1O6Nxa05D2qNXtF9OKuuxDBkH7r8Ul7T3SE8dwhImERaz
	3wJm/wbbh8diFZ8WI8cqeZCey6OOE1/J4YuSZTkglgayqm+HAAmgxbnpqRoK6y5Xn5bJcjmTjZI
	PGDxi5/cOGzJo/LUcMMQ0SgAvPnQxDs2FRg1oP1oJrTF00xzbhaUNZ02NikoJTqVWwBF5wc2Viw
	xy
X-Received: by 2002:a17:903:1aec:b0:297:e252:9e50 with SMTP id d9443c01a7336-29b6bf5daffmr65072435ad.42.1763798115073;
        Fri, 21 Nov 2025 23:55:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRs9bRWrH/OoYHItewF5ZOfSV4YMZWHn9fAM2sQIhPxQ1m4GC0AqeSRMQ+4cpwyXcnqCbdbA==
X-Received: by 2002:a17:903:1aec:b0:297:e252:9e50 with SMTP id d9443c01a7336-29b6bf5daffmr65072225ad.42.1763798114604;
        Fri, 21 Nov 2025 23:55:14 -0800 (PST)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111e01sm76424885ad.7.2025.11.21.23.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 23:55:14 -0800 (PST)
Message-ID: <35c554a3-efdd-425c-ac34-858a927bbe15@oss.qualcomm.com>
Date: Sat, 22 Nov 2025 15:55:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
To: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_yuzha@quicinc.com
References: <3f355c8a-5bf2-4a74-9b35-daa8ae479736@oss.qualcomm.com>
 <CAKEyCaD4=qeQZYYOv4BTrqUJkZa+jnea1b3BL434X1iGMA-_xg@mail.gmail.com>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <CAKEyCaD4=qeQZYYOv4BTrqUJkZa+jnea1b3BL434X1iGMA-_xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Woom8Nfv c=1 sm=1 tr=0 ts=69216c64 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=F-1DhEWBYv2ISTzAllIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: iFKz1q3idmMgZGaBNvwll3NJAG95WbR-
X-Proofpoint-ORIG-GUID: iFKz1q3idmMgZGaBNvwll3NJAG95WbR-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDA2MCBTYWx0ZWRfX/ebsa6zxvC7c
 5gCaOgjUyu5d7qJVCM4DqnQ3mXn/7C/Au+skthRLi5HktTFN/3RHxAxKYTXtzX4TOfRFFeC3PRF
 5OZn84AsKqzII0Y3xN9TrhRICSigjPUgvyBZ8p59Xs+9x/Z1sO7TShg4lFQk//4JdcC45jqYoGc
 3Q2WOViiRbA3WbHVa0Y3XeZe/kYbqo+hPKGJplt1/sJsA7kZ0mv+j9x9/3NbsVhs5Nrdh4vdUOf
 6kUBa2cPI0p8LOy63jDsZS4J+fLeLzXyR8IAKJQzo5LezkFTi4HfQoMtJKM9zPl7OBoUmsuCB+U
 l1homJmBxsZ2Jp2BdHSJ3AgQPIjRcBr03s08muf27wRNXuRVauNj+ziAVN2Wrqph6+OWDWWxS3e
 WZq7ckOVjaBLaBOQY66JW8dOqG8P5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-22_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511220060



On 11/21/2025 4:41 PM, Paweł Owoc wrote:
> On Fri, Nov 21, 2025 at 6:00 AM Yu Zhang(Yuriy)
> <yu.zhang@oss.qualcomm.com> wrote:
>>
>> hi,
>>
>>   From your log/calltrace, I didn’t see any errors related to MU EDCA;
>> what I saw were related to SMPS. Did you also add changes related to SMPS?
>>
>> Yuriy
> 
> Hi Yuriy,
> 
> Thanks for your reply. The ath11k driver is version 6.14.12.
> Everything works if I remove the mu_edca setting without any other changes.
> 
> The problem doesn't occur with the newer IPQ8074 firmware, version 2.12-01460,
> which hasn't been publicly released.

So the newer IPQ8074 firmware fixed this issue, great.

> 
> More details: https://github.com/openwrt/openwrt/issues/20702
> 
> Regards,


