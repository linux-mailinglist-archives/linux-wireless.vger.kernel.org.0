Return-Path: <linux-wireless+bounces-18373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C69A26B20
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5E918877D3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A3017C219;
	Tue,  4 Feb 2025 04:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CztxU1dg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63D14A095
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738644080; cv=none; b=GB3uiYzCQwF1DfNXEwjfv1RENFeuzQ2snD26t/jd4FZm1dXDaUKMPs8P9XwhmD/ImioyAZdi2v36Jm8giUOSTAVMN5FUj+5SCOmyutOQGvz1Mry0weDIP1mWwKg4CtL3FmFadawfmzXv/XA3fVymV9FGcUqZvKfaBIf24IMFkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738644080; c=relaxed/simple;
	bh=UTDTFnxlg34hDREeaAIg2DQKloJbeioXDy2L28YuNn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AIjzR2YH+e8vkemD8ypbZtwNSNz4aKj18CvyocjK9LLTIpl/kIF55M6hMZhWZb/LHN/BfUQMoj+2NNcAv7PAk8f5fG2wmFNsHqLexNkO/ru0Kt9o/l37yL85+TuVNMTucRPvLSgndLw256p2mjwFKPRtnn3h9B8myqMggfU/8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CztxU1dg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513GEeUI010516
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hrogID1pMYZlystqZnXZfqQzhY2nVkZQoJG9ivvC1+k=; b=CztxU1dg06YtwAmg
	qQxlYJoV3Hx/PoontgKTgfIKOWf/Lvg3PVMU7JmSbrbAN6DjrcHtEDiuaOpJ+jOj
	voaK6dWpmk2KDKEZcku6Vcfcbh+AjG0RX85ojRA9tV0XlP8t8BH1zpniycu5rbVa
	L7dYudmfLAO77BVsPxgKjmSKHq9OxW2T3On5sBiXYDCPyf3Hcyz24pNw9KC7q+lv
	tYyZmBetTlpddppx5TPEKDO8++o4IhlmZSari8YWSJ+t4aR3azZjAYV/Rk86YXsI
	kvaP0K9qC9kWUBUWlEqdLQ+9ycsBhr8vMAWGPpeAVUqaUN41eLHAr5o7+KeH7J/w
	qWf+5Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k159hdks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:41:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so9502644a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738644076; x=1739248876;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrogID1pMYZlystqZnXZfqQzhY2nVkZQoJG9ivvC1+k=;
        b=oovu0gCvPZDpEkv42ZnNx/Hcu8HdKIADtTJFYvfdDk06Ka6w2CkU1fVy9oC1zzSTvi
         icozfQvwd6xYKC8te2kdbvdR2eRFlk1gHeFcs47+fvShP46SU/doejkw+V41jp60Tret
         fmMpYvMtvl+6KzFFkIF75M96j8Vfn1g4rEz6Np/R4eAVmLWf4mRfR/HSbagmvLIlDWRk
         L/BoxHua6GO2X/dZFknPk00j9p5IwKEcblwyYZN07pLM747CvOKtc7ilJmuMHjWn4zM0
         IZu+nVluz0yv2iXx8s3YmyReJR4DytztDAnlUQ6zO9A3c7Yo+GIkiT9fPClY0aiUZTG3
         aAJw==
X-Forwarded-Encrypted: i=1; AJvYcCXyF/3kjkVQdThhlvG4q9OZqYwgVHRevhaGRds8758PLvPnIRkuVS/tzcx03nVgAje7Uvn/GMJgh+HvEbF0oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/224C7PZjFH1+MFnfJz5i3iHC4lj+i97c2lrvRNl4hAKZqU8J
	tsmLYF65O/+IZEP8mnXat7nM4kyYI8QVBwElVAymtWCUAHAWztHBqJZg1SS0VNSkZnEO3LULVij
	0OIUN+InphFUl/LLbtadQ6eMZ5fuvlyl+X15AzWpygee+US31JseHmwxCwnUc9xk8cuWeAwbzYg
	==
X-Gm-Gg: ASbGncs/wuM6255UB19D5LdCom/0a6n91KZaRc67nG8naXD/jFPmQS0wmDoJxbrtABu
	4T/oHR6cyJfbpmhScwWxWmIyH5HcZ7fj5oH7zuhrg1ePIT1xwq6eFZQ5wFwWza9RgNyDSeTRs0Q
	PrsISrVf639yLWobF2pmtUrys6Lucpny4cPaCvmTjY9tifaQ246Fw82rmxaB9XqvivP2bmRAc2I
	luZ+21s4pRQwibzTAfqfrBt9nJkd7ean2w75vMgC4zAcpm0ycXLU/YpZFKrHu7CqMaxDnSRoTra
	0WhQEpaOVc+Kpgwe2mkqwz3jMLR+nwbm3luxrt8=
X-Received: by 2002:a17:90b:534b:b0:2ee:fdf3:38dd with SMTP id 98e67ed59e1d1-2f83ac6612amr30911552a91.23.1738644075869;
        Mon, 03 Feb 2025 20:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa1rhkr0CIdh+9HkLCDKMZ42p2q47VXgfsEsnBjGWTHSWtVtyZwBVtud/aKzNYvKs4QXCZmw==
X-Received: by 2002:a17:90b:534b:b0:2ee:fdf3:38dd with SMTP id 98e67ed59e1d1-2f83ac6612amr30911535a91.23.1738644075471;
        Mon, 03 Feb 2025 20:41:15 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33205c0sm85364415ad.235.2025.02.03.20.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 20:41:15 -0800 (PST)
Message-ID: <db16febb-a58e-4a60-ab1a-212c30fb5313@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 10:11:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA
 beacon generation
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
 <20250203214448.1978156-3-aloka.dixit@oss.qualcomm.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250203214448.1978156-3-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 19CRNy-7EYp49SENMYaeWCrR2VTPxxV7
X-Proofpoint-ORIG-GUID: 19CRNy-7EYp49SENMYaeWCrR2VTPxxV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=399 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040035

On 2/4/25 03:14, Aloka Dixit wrote:
> Function ath11k_mac_setup_bcn_tmpl() retrieves tx_arvif only for
> a sanity check and then calls ath11k_mac_setup_bcn_tmpl_mbssid()
> or ath11k_mac_setup_bcn_tmpl_ema() both of which again retrieve
> the same pointer. Instead store the pointer and pass it to the
> latter two functions.
> 

Same, Is this tested? Perhaps you forgot to add "Tested-on:" tag?

> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
> ---


-- 
Aditya

