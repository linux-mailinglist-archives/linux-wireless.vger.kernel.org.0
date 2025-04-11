Return-Path: <linux-wireless+bounces-21425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA16A854CB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996274C2B8D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BBA27D797;
	Fri, 11 Apr 2025 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cS2JzPUK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254527CCF5
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354459; cv=none; b=ERsT0m/PumIcgkNN7p+j2PKblYmPIcQqCO36b8esdGJ+eseUVFdYO5iy/1YLmXr04XfVyyuwAmoxgmqIjDzrPErsUZygBvIJRxBZ9fnBS40EHdznUlpEZ2rzN9+oeotwl0NUAhNxx0eXB0z5NMatv0BS7DEwr5rWSnP2bDHL4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354459; c=relaxed/simple;
	bh=viicrh1VzjP98n1XXPRbtbw52cuHCzuGcW8EPcafCow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgyIhdXSdLInOXCUkckVosyQWEwOnR24xPpbq45tVPJwovsYnZunkk+SYzStKoiAgtKwtorcKkqNaTtn5aHEKECqLz1fd88ibI/CiWL9vBznQV/+j6S+HHjxjVTi/2XMAQRqT68cB5+6W+rtPw62JjRkNNsu5RJGC+0481R33TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cS2JzPUK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B4o30W018368
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jTxAYR76YQwGa7rd/2XeqHZ0oIwh4VwoTWtUFb5rfp0=; b=cS2JzPUKKfqx9Apr
	kM11DEx6n8CAvNvrOPQTD/Vvv6idp/8bvm9GGB3II+Q9iEZLu9wCY50Jh0mFfdve
	5jsUb+KYZa496OOL1fDIGpjetm/hM/5NZkMmGJHxMUWXzYG3ZhfssfkmyE4uBStd
	t58aebxAz9bIRGAEiB+vCnakcHIEx4rVA5vKHT+R0TT+DrLECbovHa6N0VL0HCd9
	bFXkwFRMs4eWShWJWeltpJ+Y2bwBD9QnxYGGrFjJEPFJ2FZBMnTN8WosvCH/hAx0
	gNVVdthqEGFh3y6WynLcR8/80sJV4C0hyc2IOA4ZTOWIYsfFu9joRw2ZFlouQMqM
	W31HvA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb9kek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:54:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so1647362a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354456; x=1744959256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTxAYR76YQwGa7rd/2XeqHZ0oIwh4VwoTWtUFb5rfp0=;
        b=KObJcD4moenQH73T4/1NBBEdGyNgUKyI7cuR6mC95R4lTCi/lxQhLJf1xrnG4cjRRL
         KKXyWU1k9IR3IKFRY3W/mvTdmG+yMG59y8FYOLD3tCk6irFvs8G3HRujAY8sXdAWcuyM
         BH8Phs20eLp+qNc6F7Ivr24MIcwo/YQiSjAu45YUVmsY461GCXB6SJuGJpcYaP/CC3NI
         BhJKn8AIfVP0431aySvrMwu0ju/31/WCkMn/uLSIiqqgCuC7w9ozBr03QcSAXkrfNDK8
         7tSqqK/anxrmkBjpViLsqALegulfSK/LSWtfM/OhT48K9VuUZ0ULjg+v4uz3aYyxgzx3
         xY5w==
X-Gm-Message-State: AOJu0YxITs1VTUdp5vgtZEcAvpSZ4sPTbt4DOi2tfwCZymXVPpVgeeIN
	Va8+IBNmHD57ckcvEs6YYB0UiqFmfvCS1hDUE9gqEP/c2xSgfQTVICCvJ/tqtnWUQR4Lb8Rb1/2
	VWWCT/XCIBZLHsqtXMU8WsSeGV8DZAOa+dTNl5JcWPLXvt/KifpVJvkAwogY0jc0kJw==
X-Gm-Gg: ASbGncsfMn9rkcDMl0PLm36QX/AjqxYdzKoDh+GOed+92bDAxGoYbmGLNWD6bQNp5rL
	b5mRdEJhLFKtoZi+kUWKlLSKVXwpjth5+zfMOR0l/cDv8H5iR2L0V+coJCpkrtmqDDWpMHHhJA1
	3Lv3u8I+mBSiNlEzNEDQkhTMCO2uD/jgpTmJXX0O8NIkejTN8I7E7Zp1wMBWKAm/PfpLhKf6a79
	bN2KkMp/0AduMEETFk+WjHI/8KUdSsln8c31y11GeIIat1Fp5ehTghpGWGjLx+eqlnSM9LE2AA2
	m7D32qZtngHDEs1LKogJvSF4X/JOwcmj7bdNWnqH0yGWyY9DRYscdw==
X-Received: by 2002:a17:90a:c105:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-30823670d04mr3285208a91.14.1744354455630;
        Thu, 10 Apr 2025 23:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeC58txkECQ9p8jz6zEL4PoGbXJS1At8JwDvfBzKEVAaeTIAQUE9nQTOZcb33MGqjOJuz8nA==
X-Received: by 2002:a17:90a:c105:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-30823670d04mr3285181a91.14.1744354455265;
        Thu, 10 Apr 2025 23:54:15 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm4710786a91.45.2025.04.10.23.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:54:14 -0700 (PDT)
Message-ID: <b93212d9-7dbe-d093-6f59-52f55e703f88@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 12:24:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v3 1/4] wifi: ath12k: Handle error cases during
 extended skb allocation
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
 <20250411060154.1388159-2-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250411060154.1388159-2-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pZA_pGZaQ3zPCNfoUU80Sf85Ct0euO2I
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f8bc98 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=z795QP5gvOIlqM3UEbwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: pZA_pGZaQ3zPCNfoUU80Sf85Ct0euO2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=965 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110048



On 4/11/2025 11:31 AM, P Praneesh wrote:
> Currently, in the case of extended skb allocation, the buffer is freed
> before the DMA unmap operation. This premature deletion can result in
> skb->data corruption, as the memory region could be re-allocated for other
> purposes. Fix this issue by reordering the failure cases by calling
> dma_unmap_single() first, then followed by the corresponding kfree_skb().
> This helps avoid data corruption in case of failures in dp_tx().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

