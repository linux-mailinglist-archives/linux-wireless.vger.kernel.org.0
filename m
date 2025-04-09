Return-Path: <linux-wireless+bounces-21303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982C4A81D75
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 08:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A14666C6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D83B8F5B;
	Wed,  9 Apr 2025 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLD0Hp3I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379301B81DC
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181370; cv=none; b=Kw7CQ38EdbsNeY20W3bUmY5GtPXNBo1OlGu9e7mCcwMyqKlVF2tPrGP3WABcGKdJMNC4TPf3nL/iBx7Dom23Wt6HdP+wWxqyy6M8dOoVnNGO4MZCbP7/u+vjqRv17aJzMdBPPefrZF3DTAY6CdPGz1isn/Vk+RLgtJQFmYyLxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181370; c=relaxed/simple;
	bh=EI5HCFAxWMe2A6fYQFgO11Y7fawQvX1huqiE1VQqlcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeKAIukkzgqUrWeMt7McQhp2T4PieAUhzk7iNXUf/68e/qagkZkZmE0OJHCvJ2qjWSp/2seEb60t5MIFFkqm32khdZpg4OGVUiZqOXJNU7/WwtQltaJ8DcPA1WNhUW1HysG+7V5lolvQl6GnD4uJcUHNqu3rC30UNd3et9gGwe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLD0Hp3I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYtJZ002260
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 06:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rtm5+WURYR7LDnys+w3KHESaiVhh5O0NrIKkumDeTQE=; b=hLD0Hp3I/7WqEGzt
	//e5BS0EMAMZIwLcMFlfLzXm/yNJgzq98cZILECYnmvEnoaRwOPaOJWYQ3VPWy/e
	eYVKbcXxW7YMDSIeAZXZlsZMWEHVxESPUyBxgzEa8U4XgEGOMZ4X6sDFtRwCc+vu
	wzN/FQAaC+p+Ar6eQCLrBsU82ARkVZ+3dzNB1qNri5YjG8bxTsW9dd61ICrPaHws
	9voG2xvuVwxT2GTHtMgU5dE44oVI6ruzPPo0zvp3JMasxPqr+IJShuIi13Oh4nCl
	bLiMYWkJmXT6rZIwVpngnSPmrYLmUUamocu//Lx1QAdrI2jQY/uWn2lstC1NMt2K
	lrQwqQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1j87k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 06:49:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2242f3fd213so49357925ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 23:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744181366; x=1744786166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtm5+WURYR7LDnys+w3KHESaiVhh5O0NrIKkumDeTQE=;
        b=duvmcpjmfta9yNqCABCEqZLVMFBpSrh5MOA2stKiySpzdHcLz0/R2YtklosONMv2LS
         FzXkjb6n/qamGomtSBXGSS9z6sr88KcLFeHlBBU0XJF+hzYXgQv3wtm7lqiT3KlhzdIi
         2Yf5aLTurRALEAjU3oLp07l39YgDxcxbfQmUuCQjSr4buJjHpzb+jZExya2pqPI6wEVc
         7hspYOH3j+2GaEC2GE0QkqwnYLLdkzcqUfrfZVMrN8iqVnlwKKHWaqtmsn17DkwcPsHp
         f3AmN2WEh46zor9pSJMmsfjQ+c3IxD2O0iogSDIL1HAhYYyYZ2pi3B+QGjOL5jjFLYEg
         JcvA==
X-Gm-Message-State: AOJu0YyAUrcM7tk2fbimC3RyhPXKo/QXAE4fP1hOyhn42ondb/SdZQKv
	KH1Ua9Pj9vwFw7q+6l2hdcbg3Ghc4GjbEo/Pw95M1U5cy5TbL3YN6p3xOMh5q3VBPOZz/VJbUcz
	dA61Ig89WjvPCBHStHUjWHt7YK2HWXNusWwPjAkLiAQPMLSryXaZ5RMiwkwlv4BITqCLj1EyMrQ
	==
X-Gm-Gg: ASbGncsnlo2/gK2DL5OiDstT+fEzZr8NI3Wxcb0rWVQzXMVyJPjFwUOupMfRx1vAhCo
	Tnq9FrCn4S/zbmQt7FkXwmtsoZhq0a4/Mg8rUAJwHZnJ+a7xIm19wmQ1KfTnJAK5FvbkUh9U06B
	jxAH3q7Cji6fIyu+J5cDR2e99ceBDTBQ6gOORkHp0y29kBVFNG3DrxlFYWlYjEfpuUQz0sA/sBG
	CTw2gKq88E8bi7BZnZSEMHYqFNZk82108Z0MD/ohloOh9hUfmxtL5MnRgecydYlHPK9H+4IaL/q
	rjliy6Us+x+AGSp7tneaCqEsR0RztLL6aTTnM4S5JncVljFLMOuU+Q==
X-Received: by 2002:a17:903:1b0e:b0:224:2175:b0cd with SMTP id d9443c01a7336-22ac3f9b5d1mr20132065ad.26.1744181366298;
        Tue, 08 Apr 2025 23:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwaUx4847dN68nvZ3mRArqhooBQT0lc4ji9IFxcBtNA+IKplf5w5O8crCEFNnyWquO9DyIvg==
X-Received: by 2002:a17:903:1b0e:b0:224:2175:b0cd with SMTP id d9443c01a7336-22ac3f9b5d1mr20131855ad.26.1744181365892;
        Tue, 08 Apr 2025 23:49:25 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b73asm4373055ad.86.2025.04.08.23.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 23:49:24 -0700 (PDT)
Message-ID: <7c76b8d8-e6cd-4779-fa44-e474f492db79@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 12:19:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: fix wrong handling of CCMP256
 and GCMP ciphers
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250406092214.3602182-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250406092214.3602182-2-rameshkumar.sundaram@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250406092214.3602182-2-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: W6IEdzV7N7hjq5lVT1HoNX1fOZ4kMGj3
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f61877 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=5fadYidmWyS_WWcxFVQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: W6IEdzV7N7hjq5lVT1HoNX1fOZ4kMGj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090027



On 4/6/2025 2:52 PM, Rameshkumar Sundaram wrote:
> Currently for CCMP256, GCMP128 and GCMP256 ciphers, in
> ath12k_install_key() IEEE80211_KEY_FLAG_GENERATE_IV_MGMT is not set and
> in ath12k_mac_mgmt_tx_wmi() a length of IEEE80211_CCMP_MIC_LEN is reserved
> for all ciphers.
> 
> This results in unexpected drop of protected management frames in case
> either of above 3 ciphers is used. The reason is, without
> IEEE80211_KEY_FLAG_GENERATE_IV_MGMT set, mac80211 will not generate
> CCMP/GCMP headers in TX frame for ath12k.
> Also MIC length reserved is wrong and such frames are dropped by hardware.
> 
> Fix this by setting IEEE80211_KEY_FLAG_GENERATE_IV_MGMT flag for above
> ciphers and by reserving proper MIC length for those ciphers.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

