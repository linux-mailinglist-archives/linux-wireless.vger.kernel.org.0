Return-Path: <linux-wireless+bounces-20479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD610A667FB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 05:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60D618908C6
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 04:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E385C1A2567;
	Tue, 18 Mar 2025 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U2hCufXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596D3BBF2
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270537; cv=none; b=OA3DZg7xGH1V0urYo+tZRko49/rddvxdneE/OItarALXEBQ7g0+dQTHOBpcScYDH0XjdGNsbvGd89JfLWGwVHAIrsRAegs3CgxqEEidBms/OJnN59QiSOT//DqJl+8VRfW05riGh7MDv/uppfTL9ZNX3sEg34asEOpDlB3UEMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270537; c=relaxed/simple;
	bh=YE+BglfvgMmVVlGY/1wSFf/cUHxgjA9f7nPDdKf7uTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFVH8fBnHgEFwGN9N58xjCLqV2YSfvGaoB1LEA8AbLOM6kNbM6nY62WVab4uQ1GTAMV4D057ivxuH8tpbf13z91xQyQ5xe94v1uGjLVMQrF1HmsAjj0Oe6vVHTSQqsRR3momk6MLbz6BpMxiS6ukVp0eYDI08wf01jtbEF+IhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U2hCufXU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I1A2OF011301
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 04:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	evxBLxF0vJkO86a539w8EsrBTfuvbVoib+/2TU9Ycto=; b=U2hCufXUfpZVqgvE
	m9WMkyz4XJjMLsMOD19uVu7sD7AzpFDZfhfbcIBEdLUfzConP9sUhVwxylhqiVPm
	4KWhW7ETSxeBFGPoG99VgiqsA02vaZheTE1ToJDnYDZR8vZJUwsjYDErr85PmXQJ
	uKjekdmJhKWG0ssb+WnVwpJLsha9VHPSKmw+y0RhwJCR3Iqzs4YJnN1OMDTETDFa
	jtNXSVq70vhit+nZPbPua9Wr/Ivscv/C8N5Uai9wjEvHvzNntEP9aJjzF4FaJ2QQ
	j7D+gouFdDjDXdjQT+eMOw893YSsipMsc/CabN6zJNJpcMIgj6BThhlFTMkpRlMb
	DSsxCQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx30c93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 04:02:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2255ae39f8fso105045805ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 21:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742270534; x=1742875334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evxBLxF0vJkO86a539w8EsrBTfuvbVoib+/2TU9Ycto=;
        b=fakgGdVNzASdF3ay3XivTpGTZqKbrAJ6twUsqI/FZ7tQx38eoBMscfp4INAkAP8EVr
         GeQmC54mc/igj+6R43QIl7K2Vx5fWXoDGP21szQSr6EF9ssoYOKXUnL8i6ZQbqB6gNlu
         QgVsz7VJpxV+mctCI0uR7iFP+wX6zmfDQGqA3aWax5nek38UxCWIYJXkvhFdDf57gbds
         FhVJmaGdw0V40lTZc/H0SGdodlLOECGL7hyEOTgqYiSHBOfIwfUfBW1dF5I/YG6tNzS3
         UipfWeC634PzA5Ngc+hxpf21J3vLhmAiujkf2eyMuWvGmvYXS2nb7uKc5Mkn/wRBIu/r
         rPhA==
X-Forwarded-Encrypted: i=1; AJvYcCUUYvDuY2IMVGvCxAf8e7zSHTE6jqRsVeUe4SECzh5jSJDly1Cbl17RO8wZ7uuynEI1TIkHZkJw5FgxtVNqpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfmIzruhNeKReMv2RmJT/srMGm/T5WNT3hWauNIAiz+lpV1CT
	5lu3gIBXxDXOLrphcVZSwjfc3+sdWpROjstaqOna3vwFTQghU2Lzr1w6TD+p77N0ND5iH2Hlg+o
	xYaT5Tks94fbpPVPRiNc6jtfYn0gKDAhDkdtWW32OthbqsMzF0nX3jmgTB3JHolIiWQ==
X-Gm-Gg: ASbGnctIHJmZtt4fYXve4F7Kb4eMnT34aV1K+78RN62c/OESGd+LkqPpzn4aiTH2lBG
	J+wSKOTOoAH9vKr75KDy1H8mnXEdpWT6Gtni4nkK5WKdLELRbLFcifyzJekwJgFH9bGweAvKXHs
	5BH2kl8YY87T+346K5x94NnqoNodV+JUjISF7SpGZekMbrhnbd2w9a/Hv/8JSL0GNr9h4+ITQcL
	4Fgm2wRUjumYfHuLJKNC4axYOawoJoUPRgXZg5+oPOWffMR/T3HnBAvf2Md3MVpBwjZItWfjXQE
	v07eeGfpdf1cx8RWphAAbBcW0JkhTnLSRlAv+UTE2Ack/LuGYN1+kXeOKw==
X-Received: by 2002:a05:6a00:908d:b0:736:aea8:c9b7 with SMTP id d2e1a72fcca58-73757764898mr3353860b3a.2.1742270533952;
        Mon, 17 Mar 2025 21:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfTlJDWwrgB/atBHiVL6o/A1R1cqHfM05IhNbPgNmLuzKd0jt55qXiKn1o6c6a9erICRKnVQ==
X-Received: by 2002:a05:6a00:908d:b0:736:aea8:c9b7 with SMTP id d2e1a72fcca58-73757764898mr3353821b3a.2.1742270533558;
        Mon, 17 Mar 2025 21:02:13 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711578e09sm8465029b3a.73.2025.03.17.21.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 21:02:13 -0700 (PDT)
Message-ID: <f7f9ab59-2667-19b1-98a3-47843f5b3e83@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 09:32:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v11 13/13] wifi: ath12k: enable ath12k AHB
 support
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-14-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250317204639.1864742-14-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67d8f046 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=w_ZfqNI5J2udKohul8UA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: pQ76OJ7cilQDWExsg_c2egM6Oz3pfYUE
X-Proofpoint-GUID: pQ76OJ7cilQDWExsg_c2egM6Oz3pfYUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_02,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=729 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180026



On 3/18/2025 2:16 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Currently only PCI devices are supported in Ath12k driver. Refactor
> Ath12k module_init and module_exit to include Ath12k AHB support.
> 
> Add Ath12k AHB support in Kconfig with dependency on Remoteproc
> driver. Ath12k AHB support relies on remoteproc driver for firmware
> download, power up/down etc.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

