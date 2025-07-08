Return-Path: <linux-wireless+bounces-24899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB46AFC194
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 05:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420664A1AFB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 03:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825F22B8CB;
	Tue,  8 Jul 2025 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhITuDGx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD602E36E2
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 03:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751947131; cv=none; b=JIHt+gr4xoqesGy9ANpP2MLneogPiMa+lrCUjRmjMxVQeNU4pcZl6Y5WpVi8y60bbXjVniZAb/S0M6Typ9fAMNQbFJZ6jJpHlnijDNld7UfewsedgV8Zxfv/EDYXj1fmn4arl/vpnD55j/EHrCOirg+u6SSmgAM6upc6cwXCJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751947131; c=relaxed/simple;
	bh=3AKkxcfvUlMu5TUYKLPTuhhBUALR+VAT3BG3ruqNIDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vA5yREW3yMzzpuErTja8j3TIiJMN5oLt6aeLhMniF101JVinWBXmWvAZa41Dj6UdTmrfBnAJI6j6ilQ3xREg406GlD85009HN/BlNOozJopp0U3EA5rsMtGTa7dMDpfcTdja3tKHWXYWo1aIwit2FQexlip8X59C5c4bmhrAb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhITuDGx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567L7UI3001122
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 03:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yVmdwoyRmqDc17tvesd0pZRhto/8N/zF0tcxD1+SpSA=; b=RhITuDGxVaX2nn3X
	I3OQEFd2qRV3Kz5NsAafp+ON6RCsUZKC4B2/PEnO/FrGl0an5Ym41eu1adpgG07X
	Wl+bq49fI/gfgZ+YQuHMFYbbDMrV/8I2pUVIEgYvBgb/gv4ewG8VusvkqiNVnk2N
	oj9qT7nKfu0peyx/Plqz32GFtLrZYN1k0/y2GjefjVfIbh83ouCrxJRtHIY67yIf
	3kc3rSjoBdD4Ya1dygCCSzaHHM/V7XySI7Ir8YzB8WZkRA1xdHmwzSr9gbl7MtQ/
	8ktNx9ptWCZXYRwfJi4js8DvJpTXmxLPS1itVWAKOu/iDPhCq//859dNnBIhcy5x
	FtVnLg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pw7qj0hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 03:58:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235196dfc50so36899555ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 20:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751947126; x=1752551926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVmdwoyRmqDc17tvesd0pZRhto/8N/zF0tcxD1+SpSA=;
        b=hemZ+YGmjLpuQ06+FV9Z1wzaZsz0ywt3BgQvM+FKDANYqQ6/fDaSOmr2LhaK7H14gq
         bAKBdOKHsgtpqdPtQQo5tvquSRZHkyPccxYIG6RFIF2Xab9xVjmeiWwxoZ6KOYL//s6Y
         rPtb/2W08yNoCH45Cns52Spj8A4IeOhfJIWUcq/y8GBJiFVV+3LD4hjsigk4KqzwWHhX
         HkcGXPL48jJfksRoWwnk4+0fy2TaczlwvEZE0BW/rZTcpQl17ohRSfB4bK4v5D324pyn
         eXYo99GJhb7Jd4IQ063XEVZO/pwm8+FofMBRrsUSf8gEkDtFNtn68SBeyeQXnxEwmBqB
         s/vA==
X-Gm-Message-State: AOJu0Yy4CnbVP7nQ/Bd8tGtEptNDz7fR6EZwkmNvA6zt+LASinBeSU1j
	jvj9q6sw4UDb44dtpKOzI5h9JuFPn8gLDwSrYwxdzdXLmlJeRsXxg17dOa3CLd5fyNjuDEnpXw+
	JsY29hs1Sl17biPru99IZo+QMXCYYdt+8BFO0z6ByFCNEPV5OeWjFPen9TfQJgfEoq/JePw==
X-Gm-Gg: ASbGnctO1qYIB8P0Jj3hfiVm1CUOJTBjQdqUqANnuW+mRNlkofwv7jfyjLJPN5pU+5g
	kXgQO1FfIy/rhhjBDDAQ4+DJ4LZ1NRWsZwf5FaizqDo22vvwD1RP481zuYJPyewET/NtKYK+ut7
	p063eT0i+qByTgr0ZD183ymoQ5VXcQojrkydPUJg2D5vqWJ+r4CKVGbFzIsIKSAqCP6EH8OY86H
	kBqBhCawRbcx9BMBvQeI/lgn9n4wH7noRzy8YCLRZuGRz35tDGjq5lWYf2FsDa/zbnT2dVYEUNQ
	Gp6tIweWq+j04Yp3dZIm/cjEQdjpFG+mR1g8+K5HW0Vejgh3KXHiaG9jSoKxpeR7
X-Received: by 2002:a17:902:e88c:b0:237:e753:1808 with SMTP id d9443c01a7336-23dd1b43dc5mr16754265ad.20.1751947126573;
        Mon, 07 Jul 2025 20:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEso3ju5zhTdAEFrj8mTebhXy+yfUOAHYYTDpHBwzag4yfTDCfvyRpYY+6PtKpu5KUVV20vmg==
X-Received: by 2002:a17:902:e88c:b0:237:e753:1808 with SMTP id d9443c01a7336-23dd1b43dc5mr16754025ad.20.1751947126139;
        Mon, 07 Jul 2025 20:58:46 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21edfe37sm824324a91.47.2025.07.07.20.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:58:45 -0700 (PDT)
Message-ID: <074969cf-676a-34eb-c2e3-219cab3658d4@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 09:28:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: pack HTT pdev rate stats structs
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAyOSBTYWx0ZWRfX+1pLvQlwhUCJ
 oS8IebCeRgSDyFORaOmihKaBj6ss9RODC65x/VhrMlckr70cd4kGvXSx6S58lIPYTUZu8kCm6aD
 ROp+8dks75IAaNuGsCwhK9NH4bKKZihUomu8cFIzTr+Im58wAnu/mTV4Wr68CtfjpAVstwSi4uk
 NdE64iWF/fVLtXEHRJjuJfZ4bcmxAH6Zf81GCkSNK43e5JGZDbazOTy5nE9TVmx7sXiLpJ9cE1P
 J20x1Sl81CXcIx6AetviJUn8401uj31NIQ23g6WoEONTQuylExi3AtnrAEtThD4uscGwELIT6YF
 kn2T1GAMjXwm2g1MZVaxDoTD2v/DB3HFbzwoZ4SbjI/PiTTS+XHnsNZzP476e+in276qRusJn03
 SZu5H2ZMNGCeU96JvggDqMZrMJt6MSapUhiH0dKf4WzAP8wOFrf053r0/M8M7DKBZh2X5/xR
X-Proofpoint-GUID: eoX-xlWpsUsS7EVmoyXup7NRh7gn-FES
X-Proofpoint-ORIG-GUID: eoX-xlWpsUsS7EVmoyXup7NRh7gn-FES
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686c9777 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=D7ADwRd3ifBYD-KlsV0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=841 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080029



On 7/3/2025 2:59 AM, Jeff Johnson wrote:
> In order to ensure the HTT DebugFS structs shared with firmware have
> matching alignment, the structs should be packed. Most of the structs
> are correctly packed, however the following are not:
> 
> ath12k_htt_tx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_ext_stats_tlv
> 
> So pack those structs.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: ba42b22aa336 ("wifi: ath12k: Dump PDEV transmit rate HTT stats")
> Fixes: a24cd7583003 ("wifi: ath12k: Dump PDEV receive rate HTT stats")
> Fixes: 7a3e8eec8d18 ("wifi: ath12k: Dump additional PDEV receive rate HTT stats")
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

