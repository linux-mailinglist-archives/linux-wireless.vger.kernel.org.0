Return-Path: <linux-wireless+bounces-29631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81107CB21B5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 07:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202DA3035D04
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C91F3BA4;
	Wed, 10 Dec 2025 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j66zKzMb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f36iSYZq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526419F48D
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349198; cv=none; b=WX9Gn4YS1qSbh2S0XtN1A9xqBAMbe0tYmF1X8hPHBg78pwSw93o7Kk3neCD76sqjTFK2wHHiUU30KMSjOKrM8U9gdCoI/gXnnj4OnhZJAy4ZdSkzrVxB0rSWQzZThmTGswvnMriVR6W30iFfjcH8t8HVeEyITz7W5jwEsgBMOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349198; c=relaxed/simple;
	bh=41S1yzf3bUyGSjHbAGyM7fTnwiYcCJyZgF27/5Ro+SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0/Uoa16sopnb7RRthtIgMc4KuiHtwvqbY4tfwiJIox0OhXGD1LxZ7nU+LCvNeQRQCvidLmhi963GzZ6Dir/M+aIvarwHK/SLfCHQQpxfP5z5opWp7oIDfrDsiMJZxdf7O37jw87iKmgz2s1dogoKRf/1ad7lqT6squ2QHB4ZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j66zKzMb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f36iSYZq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA6Dw4I1779514
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 06:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+iRPms9B7iFzeDhFGJSewFfbFC3pyljCFjAM3tAMS7k=; b=j66zKzMbNlzNvZlb
	oQpMD+EDgFVwMGbouhZyQn+w2HgnbjCtaPG1lJY6+x4rEbRLSFZJUCMMrq/QS7Rx
	Eo+Xl2Gd4ylXW1GosPNvr2tQqE7aUkYE9Q+zuvs9bEFOWagX9nxEPiyC5Ngo2M6U
	wa9MOid5WSyRBjomTfP0yEDpdZeeJQB+yDQSzORQU8npP56QsLKFMz0LtAi7g7hI
	abQqpwpuVjg8znPQR4a21WcLyoycG3rBUz004keGCJyUyBVcBjvPrWsfQ8lgE90p
	DuziKmcomO993QojIEf8iwuoTA4SkNH0JUEXvfhHBcESQ73MK7WD+XrcEsWP5Efv
	7l3jKQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axrhma54n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 06:46:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7bb2303fe94so7543585b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 22:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765349195; x=1765953995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iRPms9B7iFzeDhFGJSewFfbFC3pyljCFjAM3tAMS7k=;
        b=f36iSYZqgM1xdA/dI0zthkxjWdmLPyA3ydC3eo3LUGtt+JNqt3HDYq3VZDpvrQJy9G
         nrPeP1lfTMBghAniRdJ0ngWIDYy6JdC4s/RHEC1AjqO/duBw2Tn4KDLEwX7Tcj+6uBKa
         u0YZE0suFfH6RdOpvHlFtexO9EO2yKo1CCJpdZZh30xtF0bc1t865ALtyNFJkg20nHHc
         bq1i1lFwNvujdW84PsIGXvJMLqxVjyYZMvSwnpa6nXpXKO93iV7lNFDR9o6rtWbJErk7
         dOTUDxpO2B6DXOJM0yO6CniNi6iGPTqegqme7St2Mwl2LKAQ2buF74AqOHHDg16wgoTI
         FzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765349195; x=1765953995;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iRPms9B7iFzeDhFGJSewFfbFC3pyljCFjAM3tAMS7k=;
        b=EbCMSYC5Xx22bjQx5ECMIMewIfRHLd/4farmbDJttqNRGFzvtHuHRl3CsiVhjm7DEV
         3FVHGbG8rdc75N1laOodvUZXSljga8LBGOh7r3dGcLecuhr1WtVuYUYgSftKCq6DU3Sq
         RsNOIYG8Ftqs/Qo+83M1UF8RfTwYXKJybyrRZEv0T5fodKfdCgj07fi/TkCquZJxfyC6
         JBqr3L7SkjZhsNjFquWrHIkTbBA68cYtSGut4qLEAnJ6OAkNDbTInjzIxVhpx+7idMRL
         n5yn7/J/JcESCXvHiYhQoKm950eeh90ToO1X/qJywCdATRGyzTWbgUhlIZ/U4Nc9+8gH
         vexw==
X-Gm-Message-State: AOJu0YwcA6gxtw4OJO4kJMkUEe0eNZtT8M6HOfy6ftE6eyer06u9YdIF
	HjFluzGarKU6RyScTFAQ94pbStlwWxLdXbgMEEPMbOw3BGEd5YL6StSpOu6CosHW0j/u/vadMJi
	fJj/UNT6bmxU0YpdMJAUqU2CzhhsM5QBcO1EB+FTNg3Ky4mqqY2fxHwx5Q8Q+dGECGOsb0Q==
X-Gm-Gg: ASbGnctZmoppiZhQ6y8kskDJqrSL2hduzdoT6b9qKNurk/yYMTF6LmqzksTSlEYoqEA
	0AVC8TXgXkisSsVcFF3OM4UWwsHVh1HOPva5Yq+UXOF0nik9m5gVqsUSEnE6sBQzmGPY7fPxddv
	FJaldCmvlG1g7nouAZX96lg9HqkuxyzTWNZFpG0vWAW/RlXY/mgCXgHVH3b34UK4LL5IbTYGxQ+
	fIt2nb4N/HBqNhZN+aRWhxUKOSWw0BxYVa84yjdMW58LBgxglhdZ2qp3Y7XeGZjBDvkQW9lRdDl
	pHKZzFKmfUZvmVQIxYui0gGgw0y935AbNZRoYJ7sikNuCq4K1X6S6VQbi/NAsLU0jkKY6phMrjE
	ru1K8eaT7ouxq6CQDHw1Th6S77BtUfAf8RCSxca8kcR/kAu1fMx6zEoN+v3il3hSaq4X5eEiiy9
	6V9lsgLUQ=
X-Received: by 2002:a05:6a20:7290:b0:35d:be42:92de with SMTP id adf61e73a8af0-366e170cc7amr1362805637.21.1765349195238;
        Tue, 09 Dec 2025 22:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE65f7VgpKX1toP+VOD+uRyYC2xSY370jW2fBx9NgXa+YET7tXhNnG6VxOvmHuqpf5eJGCdvA==
X-Received: by 2002:a05:6a20:7290:b0:35d:be42:92de with SMTP id adf61e73a8af0-366e170cc7amr1362784637.21.1765349194821;
        Tue, 09 Dec 2025 22:46:34 -0800 (PST)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bfa0ad20207sm14737009a12.11.2025.12.09.22.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 22:46:34 -0800 (PST)
Message-ID: <5a5b4961-904c-45e6-aca6-b58a122e2134@oss.qualcomm.com>
Date: Wed, 10 Dec 2025 14:46:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, ath11k@lists.infradead.org,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251210024036.3965135-1-mr.nuke.me@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251210024036.3965135-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d7X4CBjE c=1 sm=1 tr=0 ts=6939174b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UC6oHK_YC1xWRw2yuZ8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA1NyBTYWx0ZWRfX2nMK/eoCUESg
 1MWS/AwRGmFRp4XSAEpZvq/29dHpeCB8JnlG/g5uXHe8qVAfcZxDuUU2GKKpvPaqa+hFGiWf94R
 BjUslUjgY7IxCQ9gTnW87+JynVohct+7V0xwZmOFSkH0ebf0Qp14vRqi6GVwAyFpNvQ93zdUzw7
 hViq5JmSduIsKpW3aU76F76fqfKojjxpCQNo8XPd0q8diZB0WDpdjDoxg1KiQo0NInrlqcG6pZN
 7pgaiKOLKNPe0DTeyzNT43s9v+NBPesa7gJJQjAlvqcfXOG50I7v7VUSr/neEMIeknkDwXr0Nm4
 hrvhlCHqZ9g1d1okjjtDvcX17wQibIx+8EmPQE64d05TFlFt9nUV4RbAQxB9QsjlN50Cmunvusg
 LYyXxIjHLGL04PuRNAHFhD2977M03A==
X-Proofpoint-GUID: F6EiKFBvfufiFjFcknYMQ5zuUo2Zc7fO
X-Proofpoint-ORIG-GUID: F6EiKFBvfufiFjFcknYMQ5zuUo2Zc7fO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100057



On 12/10/2025 10:40 AM, Alexandru Gagniuc wrote:
> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
> is initialized in, core.c, a different file than the array init. This
> spaghetti-like relation is fragile and not obvious. Accidentally
> setting ".max_tx_ring" too high leads to a hard to track out-of-
> bounds access and memory corruption.
> 
> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
> ".tcl2wbm_rbm_map". Use ARRAY_SIZE() instead of #defines to initialize
> the length field. Remove DP_TCL_NUM_RING_MAX_QCA6390, as it is no
> longer required.
> 
> The intent is to make the code easier to understand rather than fix
> an existing bug.
> 

Even the code chane works, I am not sure whether we should do this. Because, logically
max_tx_ring represents hardware capability which is static. However the change actually
implies max_tx_ring varies on tcl2wbm_rbm_map definition.

If we are going to add something to avoid the potential out-of-bound access or to improve
code readability, how about something like

	ASSERT(hw_params.max_tx_ring <= ARRAR_SIZE(tcl2wbm_rbm_map))


