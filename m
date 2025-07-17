Return-Path: <linux-wireless+bounces-25601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F5B08B6F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 12:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F09A44A11
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1B428B417;
	Thu, 17 Jul 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcCN/7ii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA30136358
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749977; cv=none; b=U8quafn+xJYKpNeqGUwOvpTXYNlCymFv17X3G2BFn2/ftHadfBO/h5Jx7UkdUL5hJknXbfXog3XmnQYIdDeuMmZ2ca+KIqB1Nk/pBdiKx42mH2XswTEMBM54QlPdwXrBINfZVdGJuzS/ULrbhZn94vl5RcYQqRflsrgkhulqyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749977; c=relaxed/simple;
	bh=dFFgXr0V7KJsMFT9bzLI4LKgPjgSk0pPsZwF+/Ain5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfs5WoivPdRKMf25XuyYMYP4UEV2O9tlnDZjlPzOf1caHxIUTKNvJ38smFS23KmTFp1fkufFiPL+b9/RVQIL8WQlutUgAR8j66f85vdF8DLTTHF80V7jv2NlfCGmPfzNKDI/B0msiJWmhuOdBrWotyP/45ymAgnUIs+8bfO1pBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcCN/7ii; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H43h3D022220
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 10:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9m1vcYVumY1HNbRTAgr3tsYxKmOeN38kHcJutqp6GcY=; b=lcCN/7ii+6ET6bQm
	W5JrOXTbbJCbkNfiX90VFzbFNdnsU89a6yKqCm+gzmQQAopy7HKsInmt/7b0KfCW
	CrMJ+zifO1sCVrSDy2XozNYjbi2J1RrZD/ID8aWW3uY+Yd/mej6t901aSHQC/j0F
	UQVMGzHYRRhRkB50lYLjBjKGsdM3r2zolpzCtpWu2vIKhMRg3ygMb6tMGgPLnPUT
	Kddr/9vO2X9atuwi3AJDBKWHI1nTjf9QNJKiwKSu7jUyfAZ/t/DKBmj+D0D5TFeS
	QkXd6PAw4KKQ0oK/6itX5Et1huo/K4b0ul9qLoOi47OgldpKY93VtU5mbagw3LDY
	OUQgOg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy7857-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 10:59:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so827859b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 03:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749974; x=1753354774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m1vcYVumY1HNbRTAgr3tsYxKmOeN38kHcJutqp6GcY=;
        b=LtGWqKmcV9TtSZ2BjjyW38Geg6dF6mq3Tiszx4GEZJwJ0sFCVRC+PloBCGM5eccuhA
         WI3CZrzwv/IPF1a+YKNkl/pZZ5t/mE8cQcguLve6VmKFWiDwy7tkriR3/8/4PciCvlC/
         73qkBBVCfsUIw/x/djQ0sAKC30Hi5cy7uQVfOnFe5SicEhEMHIokwegmdiOsMgT4bH5i
         VldD7+v39rsiZ4HodWcMzEqvA3G+wBYdo8vOLsoUJM6mOUYclf+ZthqsHrNWhCfjVU9K
         4vwl5A8j8/laMvg0Id1CC1ATJAHKuwVREVl1p0tfuz8S5KutZmIxt5LSjKA38WhmR2qe
         xb8w==
X-Forwarded-Encrypted: i=1; AJvYcCXXphiB2sMn6CrDITzN9Ky+PfW4KZk4dubwDEY6NoJABONjYabdRO0YJ9vrF0lrnt8Fp8yaBQIWmKXBaVRwCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhcubTcQj5/6eynehTm/DOlSgABnuPsYdssoXtFx4OSfGvtyLh
	JG3eG3tOUiWlou6wKKTYi7zS8/XL3BjKUHwPxCUIOmTT9hZRso7qwgmmqnlbK8wnm707Xw5S3hV
	lUFSRcKXtMvFJ4EJE6/dhuBqv4VLLQ5lPgEb5vqOpOQwJF7tNDo+BlEafWLeGTDmG9I1ljQ==
X-Gm-Gg: ASbGncvA51YM657eNtj1LpFUdPTddG0vV4ag6F140paCnWcC4UPhFepFQ1sIs8tyIv5
	92jLfGIBl/1rdMT9OXEL5AWLofVx0Tt4GsZ/JcXqylu6HGG7/MBz781NqNPBvX0BIesjTr3rb6F
	vSl9KwLwBaqSk2Bf10oZpCWoc/aZsAlAiQeQLJa155oopVo3ylhL+4Z8T7xv3nwIoS2FVm75/dZ
	SWaEOWvgQ3gFtdJN81LeTNUgeqlt7VomUkFJdOkWY9p9keZSS29oCoGYv7hSgGRnK5/m3ZtRvmK
	eTu435xyuRio5K83Nx/SoSLRBolodHV2N0J8dcDDyu/1USrfx99BTgM8q1byt6KSxAcT2IaAEUF
	/cUyf2ufzcnq7o7bX+AYCQwGAJSjRDjPh
X-Received: by 2002:a05:6a00:1945:b0:748:ed51:1300 with SMTP id d2e1a72fcca58-75722869e2dmr8491719b3a.9.1752749974367;
        Thu, 17 Jul 2025 03:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS/1Q6FwFVvJNpwEqbklIvf1jeMXGBNVBGHmlE5Rp/k57dq0BzAzgcVPz3GfhsuMeAZ0ucYA==
X-Received: by 2002:a05:6a00:1945:b0:748:ed51:1300 with SMTP id d2e1a72fcca58-75722869e2dmr8491687b3a.9.1752749973872;
        Thu, 17 Jul 2025 03:59:33 -0700 (PDT)
Received: from [10.133.33.245] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-75914e6f81asm309433b3a.152.2025.07.17.03.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:59:33 -0700 (PDT)
Message-ID: <c4a4d594-a705-4de1-af08-42a72ec44023@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:59:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
 <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
 <03806d02-1cfc-4db2-8b63-c1e51f5456e2@oss.qualcomm.com>
 <5502b2eb-f6d1-4ece-b918-1c8561a92607@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <5502b2eb-f6d1-4ece-b918-1c8561a92607@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5NiBTYWx0ZWRfX41RkLe2zKFmd
 jIlR8/GqTwdlhU+GrGjzfI9Sa9JCFo1rSBzdeWU+X069eBsvE0oKfgn5vG1RGbAeiV4dhR876XI
 mKzJQ8WUm6hz7Vc9+jH/95sTsRPkiKHZvl5cocL75c7c4N19pcD1X5DB+AGHC9witRQosP+B8DO
 NUptXQC6ecflpROooCOEr3MZtFeE/pdGdNrP7oBe6Sr7rwQ3Gj8IkcM7ZyP0Op8+CDakgztlmG/
 Qwpo9Seh+nPCvXrb6MmjsKgkPzTmZVI2dJ70QG9UOupPweif8OYZLaCuHLhOsNZn/yk7VDReKxI
 /lnQqn8J/NE/SF45H5+T4CWLc6rhEGOszyp5282p3ozP3NpybFdBd6uuYZHFIDV+Wu9cmlESFpK
 /HQUieS4ibuAIF7xIpDygvDXV1X4NMyETZBtHrok862F7AkGDOzLUs3oVEjn0Vx4pBXqrtV6
X-Proofpoint-GUID: l_d08MUgO2gKWz-_3zxKkzdHKNqYDdOu
X-Proofpoint-ORIG-GUID: l_d08MUgO2gKWz-_3zxKkzdHKNqYDdOu
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6878d797 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Ghoe0wLkBCzmZIYDIaAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170096



On 7/17/2025 6:55 PM, Konrad Dybcio wrote:
> On 7/17/25 12:46 PM, Baochen Qiang wrote:
>>
>>
>> On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
>>>
> 
> [...]
> 
>>>> In addition, frequently I can see below AER warnings:
>>>>
>>>> [  280.383143] aer_ratelimit: 30 callbacks suppressed
>>>> [  280.383151] pcieport 0000:00:1c.0: AER: Correctable error message received from
>>>> 0000:00:1c.0
>>>> [  280.383177] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Data Link
>>>> Layer, (Transmitter ID)
>>>> [  280.383184] pcieport 0000:00:1c.0:   device [8086:7ab8] error status/mask=00001000/00002000
>>>> [  280.383193] pcieport 0000:00:1c.0:    [12] Timeout
>>>>
>>>
>>> I don't see any AER errors either.
>>
>> My WLAN chip is attached via a PCIe-to-M.2 adapter, maybe some hardware issue? However I
>> never saw them until your changes applied.
> 
> It'd be useful to know whether that's a Qualcomm platform running
> an upstream-ish kernel, or some other host - we've had platform-
> specific issues in the past and the necessary margining/tuning presets
> were only introduced recently

It is an Intel based desktop, so not a Qualcomm platform. But it is indeed an upstream
kernel:

	https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git

> 
> Konrad


