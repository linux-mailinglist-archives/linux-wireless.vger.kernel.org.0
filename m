Return-Path: <linux-wireless+bounces-21521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB7A88FFA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 01:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D014189A7E4
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968FC8FE;
	Mon, 14 Apr 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODSJNq/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5881D7E4A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672441; cv=none; b=EG7d6CEWnrVFkaby1vzVZeyk4UNef6aBqX/DXHWb+vJhdq7v1Pb2Mia1jFTjiaSNEkCyhup2PODtsiF4PVwQHQ83OsoPHAThOXZGNScaKBBEmWkLaexR9tgLJhghwlri8mAyWG+fXpMvVm6TH1DrHGVVDTrhRbbihpULpzQ5Ayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672441; c=relaxed/simple;
	bh=yPfPn0ulSbIC/J+Uuwv9JEyNMDCVTFwR5j85W+lqPo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQOSmqZAUd0rLQvnOducMjcuGYlQl8lysGJfpw2VGEQgSDNpf1PGcw5o/01nRbPg6DG3gsDLEi5rtSwgz3Lxc34cgIUncENcgz8UyvTpPGVLo9IIRfdWWpzx6jHku4841x3Y5VYyfWr8dK9WKqYOajnu/Rdi830TVawycigxacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODSJNq/o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EKdiYO011096
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 23:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qmeX/479BKv3qKmBj2le1lVL00q3aHxi+GaUMpOQmEo=; b=ODSJNq/oE8CuFHCK
	KcqkYEUwTPgXFKU6lVyCbd1/GR+2xJt5LY5cncUyKdRdq/qbpKsHdObLXb0B5IrM
	qxqB8CXTH+9Vm/0DbjLBypGxNj2NyIuPgJuA2oM9XmVj4pJHFx6r9h0rTSWhCv32
	t1In9d8fR6H35RBPTWW8/Y/mrIqy8onIrvBVfexc/+Zoaq93WISLBds5O/TgVvo2
	A3Zeo3MyCUuDV5f6rkP8/Z6v/2V//RkEy56+ZqQgSqWg6afd/PDqLZ6kWCck4evd
	CyyFVtXfowx8AWjxjTGJhM4b4ygiKw8WsII1Gwj7T0xO0JsGeKvQMBpph6J2S7Ne
	JXKKUw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcwwv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 23:13:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22410b910b0so33271695ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 16:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672437; x=1745277237;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmeX/479BKv3qKmBj2le1lVL00q3aHxi+GaUMpOQmEo=;
        b=GEBpWoOiMjpVufNC2PWKQes7KwEauKUmcvIinoshO68IVwDd1zdxGrLweRs1UVOzm5
         pk5zkvItEAxiUl1WtsEKam3GW/roXcBQAMiYbAKSf02x9J3NrjOpkeVkuIcWIZ/cW3N9
         MeLViwm0ctS/U4GKX2TWpvpRPU4FlSsRfPWXbkKs99JSUklLAV+zV6dSTkQeJTTJ2kdd
         QCVfSWnpt/X8mYn5Otfrkv0szYUk7fr5qfl/jmGEYScZzXAIvS9nMqMVJ9FfVeT4oa6D
         JK3/yyHkpIFX0Kbo2DaLPSDgsPq3B6BA9gK1SDexzMLeo6APl9e8ob4Q4hYy73jOr5KG
         yaTQ==
X-Gm-Message-State: AOJu0YzAs2FLpVRLapKdRYIOPSIPYl2TTU3PZ3E5H3Qq3wAQHn0uPAf7
	atFG/Drz8+CQl1ev/n+MYKwDLrIw2dOaoL7jSo2st+V0tSS6+IJkqYwKCfmVVJluy8UKfJf6GJ6
	0mfbvfJ1Y5vg3wGRbvuC2ZAUx5uyRqdxSfDR/DAa9OZRX1+2F0unK0JRo9kOQzfi5Zg==
X-Gm-Gg: ASbGncs2NUOkquhZmj4EfSuXda7X6lRM/pK3Ymc79Z2CJ2KcJwSYOHf2qw842yf+PNM
	tSOtAM/8Yd3r1MmzAbOwyIV2VHnsy6dybH+/mf5KNm7+C3Ja0ye55L7VxrD9lscjbBi/08Zsv+Z
	a3OCcC+HGeuWHVScNCYKBJvSUxKcMePC/kel4F0U1Wg+iMHYuoG5CCq69/W4v300PkVk92fwUCa
	nMPcqrVflMcYAHA/oKqJD2Me/ILikwoouOdxg5JObtKCZ+4HftYRrqxPfb7I46DycMxxgrcE2ux
	AaEhpC+XhsSIk4HWO4xhzIZoSvi+0Ai053++gUrnFnYXzvZ8xorHwbE78WXfGLoit4vsfb4aj8A
	kpTXd
X-Received: by 2002:a17:902:e544:b0:21f:5638:2d8 with SMTP id d9443c01a7336-22bea5174ffmr219282295ad.53.1744672437280;
        Mon, 14 Apr 2025 16:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1PLRVUfgCNDjQtJLJ9u7XHiAQVtUCmKhzT9Rv2mGdyHdvZgOc0YNkpBbEu1SGUWwSapbFmA==
X-Received: by 2002:a17:902:e544:b0:21f:5638:2d8 with SMTP id d9443c01a7336-22bea5174ffmr219281985ad.53.1744672436813;
        Mon, 14 Apr 2025 16:13:56 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230d697sm7169819b3a.123.2025.04.14.16.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 16:13:56 -0700 (PDT)
Message-ID: <702c843b-8462-4594-91d0-75721ba5dc48@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 16:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] wifi: ath12k: monitor mode cleanup and state
 handling
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250107025621.1907-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250107025621.1907-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fd96b6 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=q3iC_Zviv3GNssnXIB8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sF8YJy_mgezXd4sWrTTwKVHKFxZDm5G_
X-Proofpoint-ORIG-GUID: sF8YJy_mgezXd4sWrTTwKVHKFxZDm5G_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140167

On 1/6/2025 6:56 PM, Kang Yang wrote:
> This patch-set do some cleanup and handle state variables correctly for
> monitor mode.
> 
> Note: The quantity of this patch set was 11 in the previous version. 8
> of them were merged:
> https://patchwork.kernel.org/project/linux-wireless/cover/20241022110831.974-1-quic_kangyang@quicinc.com/
> 
> v6: update copyright for each patch.
> v5: rebase on tag: ath/main(ath-202412191756).
> v4: rebase on tag: ath/main(ath-202410161539).
> v3: rebase on tag: ath/main(ath-202410111606).
> v2: rebase on tag: ath-202410072115.
> 
> Kang Yang (3):
>   wifi: ath12k: optimize storage size for struct ath12k
>   wifi: ath12k: properly handling the state variables of monitor mode
>   wifi: ath12k: delete mon reap timer
> 
>  drivers/net/wireless/ath/ath12k/core.c |  7 +++++-
>  drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++------------
>  drivers/net/wireless/ath/ath12k/dp.c   | 30 +-------------------------
>  drivers/net/wireless/ath/ath12k/mac.c  | 13 ++++++++++-
>  4 files changed, 32 insertions(+), 45 deletions(-)
> 
> 
> base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f

If these changes are still applicable, can you please rebase?

Applying: wifi: ath12k: optimize storage size for struct ath12k
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/core.h
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/core.h
Recorded preimage for 'drivers/net/wireless/ath/ath12k/core.h'
error: Failed to merge in the changes.
Patch failed at 0001 wifi: ath12k: optimize storage size for struct ath12k


