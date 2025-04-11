Return-Path: <linux-wireless+bounces-21426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63605A854D2
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1406A8C3D4A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35F27D788;
	Fri, 11 Apr 2025 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuAFOCv8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8CC20468C
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354573; cv=none; b=pgeeLJN4BzpqKNnTkAt/wHhdLGCTMrPqq7l5F3whpR2C5hfGL86K4Uz538ORCCot8EoMmHQ93ERkjxSSl5d2V0iU6Q3SdmOPZjrzIYGKHi06iVZ24uVGgHiPkBsoDuB04foOl5xjviy1HvTDmHbnpg49Vqj0EMh35wRiM5RLQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354573; c=relaxed/simple;
	bh=Gbmtu28VJw+J1AQ+xIFxuJv/ZYzkHGFqNFK18nNaMFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/XzvK73MUpulHZHMgZXqOOuXVGvNhnPbOjyFT3RHevkySnXCJGZhsccJuS3nI7JxHpQbZJj8yAITrlPi946U3A10FwrdT9uGzeB2qwI4/Pnm2FJSWumHlfLsMvc9xR5FazuHEHqZ1t/k9XDQKsxe81oObjyCNDyR9a3YoasMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YuAFOCv8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5Rc5B019670
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CiiequRrKcm+lo+qIl2btPR525geysQq/gH0qcu5+2I=; b=YuAFOCv8L7iVDDEm
	6oB2oUXzQltKca/AdA7udmr5DhpFpu6Z9qYILyxc6ZAbRNCalSRpJiOYye/LNP/8
	wxPIE2xV9Ux63hXR59J2N/noklMyj0XJK9H5Ym77gVWImacf9ejWAQFeutATWElh
	g4JRM7aLbobKTgKVp+eGXyn/KV/WtvL7DSF9qhJTOh+I4cLSV/N+oS5qlLjY3+4r
	+rYMXZ3+pqrMOQEBEv2aU/D4WnKEIh4gs9XoiaNNUp6l16SdfyRPDf4ZxAssaltN
	LOlLh4UzO56j83/CldIZKylQSQ1Lwn+v/UNIHHVS0iFQs0EP8VIt2jfmYtuHm09p
	6bxjdA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrsmy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:56:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so1412880a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354569; x=1744959369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiiequRrKcm+lo+qIl2btPR525geysQq/gH0qcu5+2I=;
        b=wr1ixtccEInm4gnCKNHD5GvisQods4LZV0SYUyQpq3GdsOcj/oia3m53HqGESiiwis
         PGm+Lyx+rlCoAKZEBe0ZoXFs4h5eLJwH1Xmf7uVxFr1Yj1t7yBGdu9SmlLojZSCMv+A2
         06cDdWIpu2KQnJBTE5qbeR5dl05YmazE9ePYrp6uqE35zFKOyfws6nVAiiNGsn9l5Kv+
         KrSbOTD0cnfywO1ZgpwpM859Tixi49dCMeHRwNeCySLO/32I9ExyEzsuO2Nnu9bE8FWA
         ps/94sEZYzPlzOdrpnmwKMfuqL4pbFUh9f8ItiabxK6fapc0Mkp3EVv0Mk55qGL2v91m
         6G/g==
X-Gm-Message-State: AOJu0YyKnR+M+cwdUfmGVxeNQk0jostslFupnZRjGtczFf9Fszzvt2JY
	mB7cxry3W5V30n+VZHRURCIN1zrYFlNB5TFtQrjoJ7kO9L7PpdvCYCOAJtekQOyV+u58Nka7gNE
	alo6TLgZE1GJOs6k/DMnq5cPlgGnXJBien0MHrUbsjnFAavanF7I8AtAMdfXhLrkkzFAfTBQlWw
	==
X-Gm-Gg: ASbGncvlArNyybfvSvP96ElxWVU0TL1yDkMv1FCbQqxvuxEeqMja1U+d8VRlsHQBcIA
	oCBOQiW1ydnmr0RfLiyR5sMAjL6TVsR49B3b27UeMKzDE9SvQ8X03t2xftTKxP5oODg1WQlDDhH
	AsVk+YdjCiKQXAQXBLu7G3PbTeqOdeY5xRNtIpV7XuPCIabm2FlKEFZsTbsODhG1swBvxr7i2wo
	iHj35pMTKy1BtqMVddBzB18jOfRoSa5TlYY8aaFbW2Xu9z3jnAvDOib/EsX48M7qKFXEYs8OiCV
	WrBAMRFdzF5BbZFfkllaISGr4cP1nsFpWjkuIaKnTIej4izr/7tcDQ==
X-Received: by 2002:a17:90b:270d:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-30823642a6bmr2614624a91.10.1744354569151;
        Thu, 10 Apr 2025 23:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpzI1X/jSBvldR6lCh+yFWg82aMisBzy3PEVWIcLBVGeaKXJVbXpIhAAcQZ1Q5KR0dTZP3lQ==
X-Received: by 2002:a17:90b:270d:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-30823642a6bmr2614585a91.10.1744354568694;
        Thu, 10 Apr 2025 23:56:08 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7caf86csm41951135ad.164.2025.04.10.23.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:56:08 -0700 (PDT)
Message-ID: <c94a03e4-ac96-4598-faeb-49a07f6011ce@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 12:26:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v3 2/4] wifi: ath12k: Refactor tx descriptor
 handling in tx completion handler
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
 <20250411060154.1388159-3-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250411060154.1388159-3-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gjoX6TTHpT351OJ9MF33_vw5rp8fom4M
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f8bd0a cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=oqcirPVkTUn42Gpn5_sA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: gjoX6TTHpT351OJ9MF33_vw5rp8fom4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=711 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110048



On 4/11/2025 11:31 AM, P Praneesh wrote:
> Current code uses mac_id and msdu parameters in ath12k_dp_tx_free_txbuf()
> and ath12k_dp_tx_process_htt_tx_complete(). Since these parameters are
> already encapsulated by struct ath12k_dp_tx_desc, passing them individually
> results in redundant arguments.
> 
> Introduce struct ath12k_tx_desc_params to capture the skb, mac_id, and pass
> it to the corresponding functions. Refactor these functions to use struct
> ath12k_tx_desc_params instead, reducing the number of arguments and improving
> function argument handling efficiency. Additionally, use struct
> ath12k_tx_desc_params in ath12k_dp_tx_htt_tx_complete_buf() and
> ath12k_dp_tx_complete_msdu(), which will be utilized for fetching extended skb
> in a future patch.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

