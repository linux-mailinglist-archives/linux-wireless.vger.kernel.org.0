Return-Path: <linux-wireless+bounces-21306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF1A81DB5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 09:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6736C8A1E38
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 06:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2840212FA2;
	Wed,  9 Apr 2025 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pIxa1fdh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078762139B6
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181895; cv=none; b=kZZrecSQUnhsN/eVneaXV/ots+rZphdxdzj/H+xCd9hYnB9iDtNGLHV6JE3juSg3yMETt/zZChaHaihVILVjKdiP2BNF0TKZnLBcwlwBxEuuuTSu/s2gzbFZHJ3uXH20CKWmlo8yehYVCvpgvx5IzFdHHVaoSY458YZysWVP4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181895; c=relaxed/simple;
	bh=y+wuo40SJc9hMBDgl0IU9Y8nV9x8Sov01QQuwitS5Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1L9pR6gLUUEhdwY7kbRiEY4rEh1apq1NX4u0gjf4MXk8IrtJiYlOEtHtDHWvnNtmLjhF7t5qypHp1UZsAKp42Tdw0pvHW6Q5fC78h+aqtsiOltvcjnGkaqCt9npa7Ch8aIztVV70yf8SdenKhN2YXa13R4pvJXfAN40Lz4i1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pIxa1fdh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JZRbS007424
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 06:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LDX8YJzyiVNIZEne3diuCHe0nF2mXF9Tug0+bsBWuy0=; b=pIxa1fdhKIr0Kgpk
	+HeLISnTAsY+Ti5SUVGpRJ3q12+3+3HiRNClCFpXIw+qgyMWRSULHAJQu/9uQe1U
	cBFEp0b1tVN2jvy16ajZlr6Rc24T1YxaQRiRXonobdZzTlsoXENO9wfWTZ1gKAgU
	oGNRIKcR4r0UgLUpt0giUEx3hwVL/9W8QESEvj0mK6C5ngjHcmopxJaHK9blv0nk
	j5tveVx//z0zW3TwENVe1twEHPPv/2vPSXw6LBO48rnmtrd24vrXTQ0ygiDu5Ifw
	3hWOod5LP7GFxhm+fDvWd9DFa5vbcH/dbj7tUoRTXTdnEeZyKCvRRVi7Jo0fbfZQ
	3i6VKw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3jb5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 06:58:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-73691c75863so8138765b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 23:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744181891; x=1744786691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDX8YJzyiVNIZEne3diuCHe0nF2mXF9Tug0+bsBWuy0=;
        b=T/5eVsnZC5ICW1obK+wId8dNDFOZQcFaPTxPHSerV6GhbIFrrQ3ZC8cCbHEFgRWkIw
         4CUklBOareeaFYg5cudYhgJAkkfVUE/id5wMXXWLE6qV3PyXMNaaGi8ODkV8mQJQpqxt
         3DELgt30HjXOPcwed3qeT8BUCPFXVFz3+PUOOCh3T/l06D0jAvC9DO3tffQBmooCggQB
         zed5ajzgZ4b+MZIVIfl4+uGJmUn7AhH6lpnN2goiG452mL/mUN1uqQiudxmIWISrBon5
         s/O5EMHSACVPCTmhM+fz7jdSqRgJHm11WYAe7Bs/f1dpnLegfheqCD/s913e4Js2WSqA
         8rwQ==
X-Gm-Message-State: AOJu0Yy6YNlnRdtzMjniacSrthgHT/FK3xPBP2YqiDxKtPBnNsViaQS+
	Ta+BsvlZBjwHP3ZSYvE0J9KGkvsqDIpJbeloq9msD7Abf8LIDZxmKlYX34uftwMF58tJwO2nmtQ
	JxMklfPpNdxe1k4kK8g8DcjlV9SF0xzHXfUNsR+6qAGHi3kbiu1YU34X5jY2lH5QbKg==
X-Gm-Gg: ASbGncv6BSmnT0/MGX7h2Eu4wr8rH9C7SIQUJrWmUpbkXcBqYyeFJgQnuKiBpRIKhBV
	pUGg0zWbVJOuOEWRTuesTre9pSPjC+pIgRjQcHfe9O2iFcsUOWAVJHWnkCV3HIQh82+kqfELsfK
	9jQbcz46Wc5bAZkVLJAoOYdc23nTqXAWf73cKOJSQ8USJiPUb642a9DJLNg76JRxz7mamcd5YYh
	BF6CQvgv2E1saMTMf11H8Wz5a7ZaQrsF6CwJKEs/h67I2wbeUVrT7JiyoH4Cv5ZAXUTb6ycREz9
	tUEpXh6vZJ336XL8lH2naP6NfMmepVb1kWoB+ZKRB8Opkqo9hDbewQ==
X-Received: by 2002:a05:6a00:2408:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-73bae496ce6mr2718139b3a.3.1744181891165;
        Tue, 08 Apr 2025 23:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+lRENUCiHOAJoETYT0kQNEPx+s9B4CvJPFLRQNt5kQrX1sc7+PSVrbp1iVpvNthcUFGQxEA==
X-Received: by 2002:a05:6a00:2408:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-73bae496ce6mr2718107b3a.3.1744181890699;
        Tue, 08 Apr 2025 23:58:10 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2b20esm549148b3a.2.2025.04.08.23.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 23:58:10 -0700 (PDT)
Message-ID: <9631a28c-f21c-5128-e813-9fab656d35a5@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 12:28:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 2/2] wifi: ath12k: replace the usage of rx desc
 with rx_info
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250402182917.2715596-1-praneesh.p@oss.qualcomm.com>
 <20250402182917.2715596-3-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250402182917.2715596-3-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kTUbiCZrOaTdxk7mhv8rW4pjpeE9Zcwl
X-Proofpoint-ORIG-GUID: kTUbiCZrOaTdxk7mhv8rW4pjpeE9Zcwl
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f61a84 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=lXdbdz2q_JjRoMiL39kA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=577 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090028



On 4/2/2025 11:59 PM, P Praneesh wrote:
> In ath12k_dp_rx_h_mpdu(), during the undecap to native wifi mode, the rx
> descriptor memory is overwritten. After this function call, any subsequent
> accesses to rx descriptor related memory yield invalid values. Fix this by
> replacing instances where rx_desc was used with the pre-cached information
> in rx_info. This ensures that the values populated from the rx descriptor
> are accurate and prevents invalid memory access.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Co-developed-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
> Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

