Return-Path: <linux-wireless+bounces-24711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154A0AEF1E7
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193E03A2374
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9415CD74;
	Tue,  1 Jul 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CaXyzlED"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9891465A1
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360027; cv=none; b=A4VtvvUyomlY1YPqRl74jIOfdK2lC2Dl5oQiWYiXZJPdoag8wgiQhTbycNBwoxgCmcC9rKlBYC4hh+hwHfR4Xsf8Dh0RI1wR4B7rHmx17Q0eNN65t27MZaStFr5dqa9dIim+N2081Uo33msp/V6sQGDNVeyakjiIWNUVi6XPQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360027; c=relaxed/simple;
	bh=rwJe18UHj9tgpRT0mdKsRDNAl8poRExqtN7HHTwQPYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTSpVp464IzLYQKFoJnLDZOja3nTKYTJaM7dlltAiT5/sWLhQWRxv+QAYnigfBDeq7mfWiywa0+eGsITzOflVl4NBoneFPz0JwXbVcUj+YksNVOr/zNwXAGNPbbZID00g1sTc9IdCv1YX5TYs7e5mDk4AN0o7FbWtJ3FexDEBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CaXyzlED; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5614hifA025048
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 08:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u8cpz7rgprMP7hZA4IHxthfcErK4vgLbtp2Dp6ZD2ps=; b=CaXyzlEDHvLPluGd
	3VBJQdIvLQiwGTV9IeSPxrU7Pg6uruOV3NVF0+Wtd5uc9QdZ2ZN9q3lbVFQMqQmG
	wwnebIDbUnRdU5Rwu8U2RcVsjIuFs4ApRG0qv7/A5SPTJ2Jal/doDM7UZU1rqM6P
	UCuG9Sx87lNGDZT3onWUDojXY8b253E7zt1r8OJjlN7vFs4bff6LGET+wR5WtkTk
	SIKDVTk0eujm5MEYufKksDOhrW4PmOTLS0vBTMCDOs36Nfr6kmZ88TPBNZquQJZ9
	ZHRAfdsiljJBe0X+574Bg6Da6rViFkE6nDGjiFpAJeIiSdiya+yNLJsOEm5O8CnM
	1GdSrw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j801yu3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 08:53:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso4452909a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 01:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751360011; x=1751964811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8cpz7rgprMP7hZA4IHxthfcErK4vgLbtp2Dp6ZD2ps=;
        b=NWm7DjSEeD/Gq32lc5o8gWx848kBP2YI4i5IS1o9Fei7WG6gmNXeeP1kQHO3c1QBZ5
         iPrNQQRYkeKv0K0Jnq01ronl2zyOc0yTyoBew6feUmaGyDa70P+hNAZETWJxTCxNsd4f
         mk3w98ReBHYv/vSSM9tCEnbixaEPvd0WOIdFV4g7cd2RVVeCBDp6vCpbut27D5Q4vX0I
         yg0UKhG1XWvEIkfhVuqanQAEiKLJ7pa5GXN0Xq7gOVwLKzdxcuT0qFVqBtUHczxBWqlY
         Pxg1z/HsrBopNnEHGMsfWM9t96pZyI6ecvbAV16t5mRdPPFsFAuDangL5pSAwy1Noa+C
         7CzA==
X-Gm-Message-State: AOJu0YzLy9tYIzY6xoTR0VzmV1+hg/jfOFUZVuPUH+MhccNbDSh6pVVi
	wFSrvAGFdj2+vQlMFtYs1fC61duaVpais7//OsQ8Ebhtv8wWG+Yo98c1TOk3+EHeli58WGE4Bmk
	zdDxP04hXMRgpO5VUmmyjOMEYSWS+LNXaR2msKDLILwJigYje+xit1w78D8Rg0cjl+wgJnaL/+Y
	OxMQ==
X-Gm-Gg: ASbGncvNz01yaBjGE1uB93h2bcSdJIKSI7GfBKjZuyUNVXbfxNfpxFgOo+UNwSjBG3Y
	6BOH8zSkiKqqMCrlKYv+ae79Ncvujxi/1eEo/HFFpnB1gGAU0h5ERzZIPs/B1XL5o5I5U81UMkN
	yiI6/22jYoYoSgpvNeg7NaAc54FN3xPFbeiuKyxlEywru+zX72GOr44y4Uu9fMQ7FggjUoQgiDR
	0Q+HgnOivxSOcxOlWPXUfQohqqAxS2VjtjNb632wvW0ifdeABZBMHaxf9KwrgQ8ioundwGNFxpP
	yuiR7EUWRxr80LmbzdqhUtO3IyYKB5alCwHOccWcSbd/6osbMVECl/79yfRt8Z0y
X-Received: by 2002:a17:90b:48c8:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-31939af5b45mr3772079a91.5.1751360010821;
        Tue, 01 Jul 2025 01:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmnbWPYGt0KeI6QrAPCAElYm+GGTe0Qewz+4tB+SrNzfve8F4I+IFLU+0mP3gyDUT2xyyI3Q==
X-Received: by 2002:a17:90b:48c8:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-31939af5b45mr3772034a91.5.1751360010253;
        Tue, 01 Jul 2025 01:53:30 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f539e862sm15071725a91.16.2025.07.01.01.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:53:30 -0700 (PDT)
Message-ID: <b1ebb2b4-8083-0b13-81ee-5aaa9a7e8a07@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 14:23:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Add num_stations counter for each
 interface
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250630044531.3490058-1-quic_rdevanat@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250630044531.3490058-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iemaxo8gXoDzHlRPS8JARYeyY7k-7Hgt
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=6863a215 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=1wtqsGCssgQoBpRYdnoA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iemaxo8gXoDzHlRPS8JARYeyY7k-7Hgt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1MSBTYWx0ZWRfX8c/6KB6kSMra
 Jma0NBQ+eREgwjclUhzNzrHp8BdVaQRSrsA34LjoUstPx18ZhRxHT/kEUpI8uig1YyX08qOe2Ip
 quIieDjuz+2JYZ9wBWA2Ub1fSWowhCxrnI9RnEyfz30AIc9wVWw33bTjSEs9UyhJKPqncTOt1RR
 7b/BTlzOovzRGI7g8KKZ2rYhUZ0mFHecyRMWqRHoEA8b8LnRem0VS7hKgYNzM3/hFweRa0eJDca
 jro76RbyeWebzVK9gIUG72dYlGitzR16xiJRy7dilEmO3yIfqMEmlz2D/IRpT2lzRN1QnSWou4Q
 tRrZGSX8aEIq16ww1cQo92scTtpt4TZ+j3ODlN15hcR1gBsDpZmRbxwVcBOh93auNty17ka/rdi
 wEkpew95/+0+cFrN0MlSpkJ8oZ3r7xJUoiG/MWRgguBWj/+dtZkrEvRzb4Qedu5FpS84N8yj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=860 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010051



On 6/30/2025 10:15 AM, Roopni Devanathan wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> Currently, ath12k driver maintains a counter to store the number of
> stations connected to each radio. However, at certain times like
> debugging, it is useful to know number of stations connected to any
> one of the interface in that radio.
> 
> Add support to maintain a counter for number of stations connected to
> each interface.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

