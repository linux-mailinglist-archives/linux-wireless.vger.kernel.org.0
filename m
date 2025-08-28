Return-Path: <linux-wireless+bounces-26747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C70FB3993D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 12:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7278D1C80359
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE093081B6;
	Thu, 28 Aug 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eijA1TPg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA9308F0A
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375794; cv=none; b=JTTaNmOqrluBaoCyl6afNHF5N6wAIgUpixkK+MxtReQ/Pf5i0KEdwzPVYle0YRaWwVTER6V5cMunz4/NJVCnU3f6olMVZDsyYb4hZ7jyTviU0FBue9gJYqy7E8B1smQvpIT8oiYfnftrqowdeR1wDLseCJMIxkLXf952KzysNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375794; c=relaxed/simple;
	bh=XZkMs0q1IZswTvGI7E1MF3jAJtw/c1tPAx2tjBjJ2/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2j3Jd7kugICEXKBE7VBGnXyJzqv1DVKZ+0y20t0b6WJ78AEoUkJwBEKSuRXAM5qFhQ4esn2y1d/xQL1uO4o+rTI8wUUWDWf8a3+v0kE3d5K3lUZ1+l9WlezSoVLFUr9enN8QOykbP4Zqk6uZaShzAz/M7hvhoBCbV7TntvY7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eijA1TPg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S61YvI030523
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 10:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UqgurbLM0i0b/3Fa2GVuloXpJqW5YZENzWf48Jlvkps=; b=eijA1TPgYaih5vQB
	NaGOA2QESdZmvxbfhzSoCjhL4XLqQhuEevGFAv9OtWR2tdjZGcNez6RNXCUBpgsx
	oKv/pYyftp+y+lawwgTSLEUbrbl2fJIlQMlf6MUaffahzF276B7IIXdZExsq+jBc
	sHoelQi61InRyIuVJVGylqG0nXgFRRZhWXkTgvZd91X33/pVjVJJ9CptYiBuw2m/
	kI5RSnCUhhF2MdUGZQE7Tcszqc31YQ1ybvExhQ39u/jPDjCV6zb86wQ0zUu7jpIW
	dhwdQBQgUKqiNUmF5LO/b6UYcUQpopwESQuoQIJ1vFJB8gJD5l9SIrsfNo6g9EMr
	CV4n9w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unynwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 10:09:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-771d7aa1470so679752b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 03:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756375790; x=1756980590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqgurbLM0i0b/3Fa2GVuloXpJqW5YZENzWf48Jlvkps=;
        b=nGZZb3b7yP8pkUDXa/UR9bRvEOTvGnvlB8epTuj11yHFySxA5fdcsHmdji0rhGwcX5
         ZG8L4RSfIPTCECvcTh+GX13XgI67dAHkn9CYK8yZ2OkcYtGal9pmZ7b0SDspTAvX2SPX
         iraeIOQ1Ya4uQxI30bcR6DSNZLPSbjtrATIVRsWUuD2jlvmRYU3uN5xIBz90aNSNr45d
         +MvFbXjpLNaozw9CdoRWgl4TBXAcd56YPqV+0MDz+YNq/mr411tr278F9rtuRxzsntqP
         8X6f4MwX4+7RkipJsYTgzODLOSQysIy021wW4YtHdNt0sCsuCcs5NtvJm5HSf2ctlVT1
         XC7g==
X-Forwarded-Encrypted: i=1; AJvYcCUO52J0BM7EQlvQq93JIYOVz6N3s/dnRxhUT/1+AsA1ylF2rTs51yzblefJ9wpglXSCzA0F/9NN39yAoBlVOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQyb9D4mezOePhtkpsyqnibIyJ8UuYYE2aY4usuWWbPB3W8Pn/
	jEWheGxFpfanU4wVZp3Crs21IJffV7g79ZngThDSC2VPgqExeWHN9JMD8t+pv//NNuQxKFFrrgn
	XThhlfJc6WoR7VmlOkmPHyF8XqLyzags4fD64X2usYt0v2GZ5attQQCF2/tEJfiEao1sPHoGG6P
	37tg==
X-Gm-Gg: ASbGncvcBhedLyyP+qOTRLyzCjPU3rcKmVuVHjC/UfMmx9AgOQ+vcHVhtxdRJ1hHJhI
	rxFLcHz3b1s/PQWSVNDZzNehzzgLDICs1zxPcWDcDT14aJcEM7Ckux+8heBUGdAaRU1oe5VhT+j
	8Xuxae0YesWlVFky6xcy1wMcCUQmlkdpcvnICrgpDGyW6K6vZf9ZMjFCwS+bC8ZF6wfP1IXNJcn
	cx0Y7UZlj7g8FnvP1MsjEfJktgRCoVxnEf7XSWzZehiHSH4aSVWhUxPfquexd6Tz1VKkihFyxFJ
	3UmegLIqZkFAl3d6tUgK5dDPbWKooIuIiWxe9DPaetXuHWUrVyNN1Ekpd+U3ichQKc0czY3XCKh
	LPHTySg==
X-Received: by 2002:a05:6a21:6d86:b0:240:2320:abb8 with SMTP id adf61e73a8af0-24340d41e97mr31450715637.41.1756375790146;
        Thu, 28 Aug 2025 03:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGd/G7ozi3KZV/7PLE6HbC3cWaXqvdWVhYagfcOS7MRIktudGIq4g870oYMHelVYJKVihrnQ==
X-Received: by 2002:a05:6a21:6d86:b0:240:2320:abb8 with SMTP id adf61e73a8af0-24340d41e97mr31450669637.41.1756375789512;
        Thu, 28 Aug 2025 03:09:49 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77058df4db4sm12267790b3a.76.2025.08.28.03.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:09:49 -0700 (PDT)
Message-ID: <53cd155e-f59e-c961-be7c-a80cea8f63cb@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 15:39:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
Content-Language: en-US
To: Balsam Chihi <balsam.chihi@moment.tech>
Cc: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        jjohnson@kernel.org
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com>
 <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com>
 <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
 <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com>
 <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
 <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
 <69f3fef9-017d-86fa-8fbb-2ac2a1df8ae4@quicinc.com>
 <CAONkfw4cQktTqR6e3PGfVhGQPsqPctwjwLSPjdiAvm45tq5qEw@mail.gmail.com>
 <127cb2e9-5371-21fa-1f09-586e6770afcc@oss.qualcomm.com>
 <CAONkfw5K0v7UJ1R8NmW1jVnukF9zsS38JAaV==j0_YXB3RynBA@mail.gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <CAONkfw5K0v7UJ1R8NmW1jVnukF9zsS38JAaV==j0_YXB3RynBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0p2Td6NsFzV-odh0LOclzwviOKKD2j7K
X-Proofpoint-ORIG-GUID: 0p2Td6NsFzV-odh0LOclzwviOKKD2j7K
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b02aef cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=4SYc7Gc41Xra_dyHz_sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX4yAkhVA2MlXk
 FFObWzbTeIzSR/+A6QG3Q3/sW5ic97Z0bUA4SNKN5/8uIP8bE5a1DUcKLnR1szNxTPNHs42q3fY
 eYCZ6MRJQ2YQktCXFBwvXGrh+OfjdnzF3k9lWrjfGJeFfhP/lyIFh3eAVZRlmAWabQUMlJ48bGr
 T3Cg14U9fL3LHPJznPHdBa7qHHF5XRMwT4kR7IWPeTql6kCN8YxOodlDYBMKGFlIVOj8TjDvKhZ
 2UAX7pDMU75drPIym61K1YHnScVV6LPxRC1dGJfHik3p4ynIYqa2+D0PW8Hxezr6sqUsb3ibu0B
 0amIUJx4eJVnk0cHZzqvdGvOcKB44vRUOnWLY6kpZsJh3fh1somHl72T49YQgqP/1uFM6ws4DVX
 u+D4aI+y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031



On 8/27/2025 7:07 PM, Balsam Chihi wrote:
> On Wed, Aug 20, 2025 at 12:29 PM Vasanthakumar Thiagarajan
> <vasanthakumar.thiagarajan@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 8/20/2025 2:03 PM, Balsam Chihi wrote:
>>> On Wed, Aug 20, 2025 at 10:03 AM Vasanthakumar Thiagarajan
>>> <quic_vthiagar@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/19/2025 2:20 PM, Balsam Chihi wrote:
>>>>> Hello,
>>>>> I Have a question on the same subject but not related to the bug.
>>>>> I have many identical PCIe WiFi cards on the system and I need to load
>>>>> a different board-2.bin on each one (1 adapter per frequency band).
>>>>
>>>> So you are using multiple pcie devices at the same time in a system
>>>> with ath11k? Wondering if you are using any private patches to address
>>>> QRTR instance id clash issue [1][2].
>>>>
>>>
>>> I'm not aware of any issue of QRTR instance id clash.
>>
> 
> To clarify: my setup is based on an NXP LS1088A SoC hosting QCN9074
> PCIe cards, using the ath11k_pci driver.
> The cards communicate directly over PCIe, and QRTR/QMI infrastructure
> is not used or enabled in my system.
> Therefore, QRTR instance ID clashes are not applicable in my context.
> Maybe QRTR is only applicable for SoC AHB based integrated WiFi IPs?
> And I did not use any of the patches [1] and [2].

QMI is applicable for PCIe WLAN cards as well. not sure how this works
for you without any of those patches.

