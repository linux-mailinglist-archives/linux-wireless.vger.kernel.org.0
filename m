Return-Path: <linux-wireless+bounces-18259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0DA2460B
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Feb 2025 02:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7181B1889978
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Feb 2025 01:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21F4C6D;
	Sat,  1 Feb 2025 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCATuRhr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CBD629
	for <linux-wireless@vger.kernel.org>; Sat,  1 Feb 2025 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738372237; cv=none; b=MfDRDaVtEaJ3vocK+24slumqlrlq/8ZFriT8BlF5GNtbffdlBohRANjXa3/75Dj/cOsc85mFsyUMKYmJd1506spIOMHzurlkJBH0FhFX6k6HSRvSCQ/TDWkwd77RunPmHnb8iFSBN0NpB/7MnLAoZbPTiNW0pfAKQckZiDt3Jso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738372237; c=relaxed/simple;
	bh=8ji4a4Fq2NWLfigy4LPxHQsN/wO6izSUKA21+Xulloo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjkJz+SmC7k8NyQZiB7f49mkpbr7bgbQfN2SItbAN11i6KeKmxDIIGRgGsthTC17lygb4jHs3/yKRKbvleYBlXOIOZ6zd0J8HOjszHqAcM8s3LmUgGo/Nv1iisXv84hJZjGnx177ZSlvmwcn9yKsYM4PIr9t2a0JdGeBtzOdC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PCATuRhr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VEWdMM022508
	for <linux-wireless@vger.kernel.org>; Sat, 1 Feb 2025 01:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U/m04xN808cRZHBo6SrtoBJ89jdzWCq8bSyEuXud4NM=; b=PCATuRhr38qDVTUV
	A1Kndd/HpXhdcvSrdx91qp79vh+Q5zRSYDsqNCcFFGEeyxH7iHTGXyQ6JN4pBYfY
	n5jmxY1gQ37AE26Jb/GZ7UKCOaZNwLni3Ksgf+bVa8s+MxnMN8LNnLVsJJESRpux
	fpG6zD8Ia/tItJ7VQyP2ya55yNuyO0rwMxr8hejZoaD1Tk27XYmNi/+2ymGPWeUu
	lF41bQokf8wH5TxDyuQ+mWM7fRb7qWX28d8WjsZwRXXODYHbxyVB1kBnaECavN8p
	gDsGLxnHsKFV3B6l7Z2Y2Zru+lhMNfQbrpS3EwmgBUUJ41XW+a2JuJhX1cI51bH0
	8+4aeg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44h0cgs7n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Feb 2025 01:10:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef7fbd99a6so4929636a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 17:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738372232; x=1738977032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/m04xN808cRZHBo6SrtoBJ89jdzWCq8bSyEuXud4NM=;
        b=BzJdCHdEx0MgpEOYUim/3+/z274wp8iGyRk14i1eAg4atthNdpDxAm/wcLTzXmGdkd
         e23l7CTMJOWhtnZtF1Pb0H+jvp+EjFzCU1ce1zJpzdfQF+HIRHqETneIB97DIHIiFz/R
         15kOPpfGQBxvW/BTropGq7aE/E+rc08j32jrcG8xb09/Y/ZN2vlRpxc0Vq7qZpldaLzq
         xUa6vIpAlu5l/FKBEuY0gjKTcZSdlembwVOtc/KS1fTygtmkvdaqc9KasWsJ76oXmt/n
         RuGRvgf6cXqAs+raV/llxlPrBLZlUdfMoRENYjDB/J5xrvQzzWlWREo2lv3qzc/TOdDl
         D6tQ==
X-Gm-Message-State: AOJu0YzQmNb1a465f6AQB8jU5RobXPj52YRpxowH3wNnkBhoSZmqWvj3
	/kqTC3T+j1ZWSPKp5d1vaYLhBLlLHEFnT38vVaLQLmbLwE10/uImMfH2nCnZqZSDIFGsLPUB8Kg
	0MVZkslZjygLtm76I22cJTBofwysW+MJ6luq/dTGTk//iMU1adczCZKJZKzVbVm+K+lFz6/jTZg
	==
X-Gm-Gg: ASbGncskB4mxolu3geqpTvzlPPMMM94DrQ5bqzVLiHqsNY4fdE9phTgaQtPt8JCBO6I
	gsGRlQ8agbZjdF6YGqwTjMyCNdu/qzf954t3rLK4qiBdzog3PgdOSHfaSeKN/6mxWNr/uoSsVV7
	1n5uvYWSXL7jmz8oprnI3vE1DieBPokFGhmzLLxqc/CD5qHOTNm7p6OzrNH4cK9OxrhKusfpmaf
	GxbRW0c+VwdnIPTRAhHMxR/yAw3tFUop9OtPR3nUH6CJhqQZySy8pSL9T8yw5GvrHIkkvfsMBti
	ubwNWiVyxq+ZCeTGbge8hvrdzhdBplQctYYmpRjQBBs1bXStIZ6djsol2qt//RTYD1pi70nj8Q=
	=
X-Received: by 2002:a17:90a:fc4f:b0:2ea:5054:6c44 with SMTP id 98e67ed59e1d1-2f83ac86bccmr18174856a91.31.1738372232278;
        Fri, 31 Jan 2025 17:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGag6maRdPrxE8IC9TevBY0D6X91fAgeJoEYMPn9LVgyvp8pNG36emajnrskUbL8ZUzJNlq1A==
X-Received: by 2002:a17:90a:fc4f:b0:2ea:5054:6c44 with SMTP id 98e67ed59e1d1-2f83ac86bccmr18174825a91.31.1738372231873;
        Fri, 31 Jan 2025 17:10:31 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bfbfe6bsm7258366a91.46.2025.01.31.17.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 17:10:31 -0800 (PST)
Message-ID: <a215f6a8-dc62-45bd-9feb-bec178e4ad5b@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 17:10:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] wifi: ath12k: Support dump PDEV transmit and
 receive rate HTT stats
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250113071758.19589-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ly7MshX2pe9EYrXQ8ryDflp-GL7OVfSL
X-Proofpoint-ORIG-GUID: Ly7MshX2pe9EYrXQ8ryDflp-GL7OVfSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=866 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502010007

On 1/12/2025 11:17 PM, Lingbo Kong wrote:
> Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
> Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
> Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.
> 
> v4:
> 1.used tab(s) to align the = to match the existing code
> 
> v3:
> 1.Rebase again to 48322e474f04
> 
> v2:
> 1.use TAB to be consistent with existing code
> 
> Lingbo Kong (3):
>   wifi: ath12k: Dump PDEV transmit rate HTT stats
>   wifi: ath12k: Dump PDEV receive rate HTT stats
>   wifi: ath12k: Dump additional PDEV receive rate HTT stats
> 
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 500 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 182 +++++++
>  2 files changed, 682 insertions(+)
> 
> 
> base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256

pushed to pending, please verify the following edits:

patch 1/3:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=d971a54bffcda2421038fd09848b0781244f15c1
 added 2025 to Qualcomm copyrights in
   drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
   drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
 aligned = in
   ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE	= 9,
   HTT_STATS_TX_PDEV_RATE_STATS_TAG	= 34,

patch 2/3:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=64cf8cc8f141ad47ca831649f3173fae25c5010b
 aligned = in
   ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE	= 10,
   HTT_STATS_RX_PDEV_RATE_STATS_TAG	= 35,

