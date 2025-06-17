Return-Path: <linux-wireless+bounces-24223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37570ADDEB7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 00:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD947A02F7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D230202C48;
	Tue, 17 Jun 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdCyq9Lc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AED2F5312
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199247; cv=none; b=B7RYXR9zqfSZqA0IOJwWVkp+5bqn6qQXUDZM8gNV2hHpjQJI1Jvk/Ot4qOGwOzVzRyeeGBeY3F0GQ3u3T2KBcpsKOZNJlXpumUHwLCz9ULnlteV0hzZFERPNmstqxrrmQtwEVl8UFM5s4xVpM3mS1BDN9mXW9vk8Xk5q+Ivvaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199247; c=relaxed/simple;
	bh=Zo6caNkTaxSQuFs4USbWJPEtAXEMb5HoSvosMqIjnwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJSkebJBGDdmgUTWzqMdsB0qiH0dQerGqmDJ7CzxmjdIGfdQ3s2l51vOPiUukFPLFEzY6CxE9es6DFkGrR922anYByFZQ5mmiWNtT52woDQIQznSYn4JEW98d30EnCq+K73sIs6UCGyTK8V/0fl/CEhblftnwQOka/1VUDr6q+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdCyq9Lc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEe1X3005078
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 22:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7HY/3IWATJYR6mbYj3hie7CvubufmPfkBqjVsoDRYTE=; b=gdCyq9Lcq462H05P
	PiIY5LpDSJphX4tbaNGTyRMEDcrZOOjKnfUM+KP+itWtsUZondDwhxJVy0Kra4E/
	XSCTRYICr0/5v/DtXggGBArVW2O4T9stQZ4n/kavR4EtKqt9j94QYeGZMz1/Q2ut
	FGLQ8lSSF6Atm2Q9phzBfBJ30hdEcroQYhHIRLFekq/UX6APBeNutJTgEpdf5Psv
	hBjvXONcW6JT42ZmGen0JqVr8Fkk5bm24Mk1LcpbVjQtaUG514ZEiROZdSSw28a8
	FxcSxyuMXUyvB2DZ708orqc4FWmPlhKOvkDuT8VRucyHo6AIQSL72eZbjRjWkeDq
	YHwj8g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag2360ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 22:27:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2363bb41664so1153175ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 15:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199243; x=1750804043;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HY/3IWATJYR6mbYj3hie7CvubufmPfkBqjVsoDRYTE=;
        b=Z5Mwe2rz0m745RShTUTeHFRXu3YC6AUFxboSWe7qwi8CUiJ/BhUE9vovP54qm36lH2
         DoZE35Gw1S7OWGK+Ah8cvfajYGYY0E6liY+mMcmbFWaoMiRQWFb9fXSeGQN50v5ckmlB
         eR/Q2Q/6dFZqlUsbVcJ3qpEyoz8YJeGgPuYlfBc+K1IHOl2EIeuJcN9IgI2w9QnS+QNH
         ps7qectsIbtV+M1ghnB+wfktdKmLdDBbbBYbCD8JIIRlcMuanFw6ZjSNMlEGmjTsI9x5
         0m+p8Fh14JcG4aQa/5LWB3rPosPlWEiQ2kaiQbCTc9t5ll6BRcRbbMDHJ8hjmxYwpVC3
         AG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5qp2C9GL1tyfdLrYOT8m54qA2gVa8yFu3jsM1C5oZiZd7fs7CRlLcjOnGfW4IdpzIwYnaXUnzGOrtaABRdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd49sSPYXFhpT9Nj9J7l05EoOJAu/rq4aNh3zs5eEJuCQsXql6
	uHaE4fCC/FRGXb3XtRruwS6tfBibf4ZZkgPvRUdd3poCqSIlwLNKUcihNaorkN+O6LaChy4467k
	uWnr/xvhjvFmlvtArYYsVZfDctPVrVR74xyBryWT8lSzCsCNCLm0P3IVdzJhqX7bRM1ddmw==
X-Gm-Gg: ASbGncuvNUp29A8Qr0dU1aMpGDoXd91Ex95asnyHKBo1qPAuxzYU27VgqAEfwrKthhj
	srAIPdxUwPbTKFpP9picuIiN+Ji5Obi6996ZaLbtwi1+LJiPG7iSCAhD6pAzbbRR9C+pqO5rmRO
	qVTIwS6BH1ojhro7TNKO7PN+fNa9S0E63ekK27ZEVsPQTI/ahDC0sWXj47REhilMYq/3nxMHH3I
	KGFnsr85KxiDPDgGiZ3c108E6K6pMC42rYjxUr5s9cFaLVn6d8BFtRc+zx5gymoyCEeuOaPmQYf
	laOmqP+zwtewdIY66aQFK3ECINOL0+PkA+YfXa5Veo0YySGcYSaYJQOL45QkfK0ti0nN1vcpCjt
	TZQji0RxNVoLm1Lk=
X-Received: by 2002:a17:903:3bc4:b0:215:b1e3:c051 with SMTP id d9443c01a7336-237c2067437mr3385555ad.11.1750199242923;
        Tue, 17 Jun 2025 15:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHg1pNwijz5niwTkHv+TCISz3PdpT0OXsl8+WHm1FdxkayEpygCAVGF018pdcMzcGXDaSa0w==
X-Received: by 2002:a17:903:3bc4:b0:215:b1e3:c051 with SMTP id d9443c01a7336-237c2067437mr3385375ad.11.1750199242512;
        Tue, 17 Jun 2025 15:27:22 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea9031sm85624075ad.147.2025.06.17.15.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 15:27:21 -0700 (PDT)
Message-ID: <4c6505d2-7383-4f5f-af42-649d0c0535e6@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 15:27:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: ath6kl: remove WARN on bad firmware input
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
References: <20250617114529.031a677a348e.I58bf1eb4ac16a82c546725ff010f3f0d2b0cca49@changeid>
 <bc04fea3-1a51-4113-8dda-5a3a38000ef0@oss.qualcomm.com>
 <c6b6378e726137170fe960742e7b3fbc76834b46.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c6b6378e726137170fe960742e7b3fbc76834b46.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BPP9wGXFgvDPEGbsSs7k2gnoWb8YXsfC
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=6851ebcc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8
 a=qgCmFUKqvXwzVjs-wioA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE4MiBTYWx0ZWRfX2iNwpSxdvWPR
 t2W8LzcDaJPT1vx2JYWpER69H0dgXnE/Erack/Hj7IKBPT7zyqDQMcxsRtj1ZB14pAyqolPQApD
 27wEc01B4Lx8CfUqlDt7qcVMlvVh0WBybynraIJ+DdAdSSgTja2O7JNI+XvCxx1MRqncGGlb5tb
 AoGBi4mr43jLqta/P3DZ4V9GxXRO0h7thum29OVGHtjVpcrxpuA28yDnPtDdovEplSZBGMTec3p
 pO5fV5dwueweICF5FYn/JOcHsatqETkE5jV6zIdeYEjnYFBuzrFxhaQzAegdhqDH8dUqJs8nHp7
 RmBUTDwAV+V1oCfPYmHmRo0xRk5uYlxTCEyJBJAyOZvJGf3y0qSS7KYguua4ugsMdOBYSXAzqLQ
 1CyuDqPimNEqahQ8QU0/+shgQd/Zzu5EKZgdWM4CR/vgYXesr8ust9dwk89W4CPs5CrqXkxX
X-Proofpoint-GUID: BPP9wGXFgvDPEGbsSs7k2gnoWb8YXsfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170182

On 6/17/2025 12:25 PM, Johannes Berg wrote:
> On Tue, 2025-06-17 at 12:10 -0700, Jeff Johnson wrote:
>> On 6/17/2025 2:45 AM, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> If the firmware gives bad input, that's nothing to do with
>>> the driver's stack at this point etc., so the WARN_ON()
>>> doesn't add any value. Additionally, this is one of the
>>> top syzbot reports now. Just print a message, and as an
>>> added bonus, print the sizes too.
>>>
>>> Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>> Since you used the wireless tag I'm guessing you'll take this through your tree..
> 
> Oh, did I mix that up? I think get_maintainers said it was orphaned.
> 
> So yeah, I was thinking I'd just take it, thanks for taking a look.

yes, it's orphaned but the patchwork rules had assigned it to me

