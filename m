Return-Path: <linux-wireless+bounces-21094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D19A79246
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB273B4EB5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8D13774D;
	Wed,  2 Apr 2025 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eAqWKt1R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744F2E3372
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608274; cv=none; b=nFeYID9v440BVM6GhDqkea/FvHi4Xa0oW0lKmtvl7dxDdWq8uDU7TYudbuo8ZGcrwTZ2lXvL1b0lpumLa7WOR4U04enfhooZSaMz2c2Cymkj7ggx82jTtgwJOs1sQmh+iaSee/4deV1bv97u5zS1xjr45eK2u0td2AqIhv1c8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608274; c=relaxed/simple;
	bh=F6Omr8x/wNAcPd/W304xFB2WuLASzm+88LkTF2KVehQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsxOxd3tTsJAGk8zQ0DVTw0OjpINkPwXzkSKKghXGCn3nfiJcb7Y28awlcuIDXUm2PmOqN1/I72D1q6BoVhpfT3Y69FcCR2r//vIZ8lYwtcoGME9OutWtxC/aAoKhBo6UtHGF69iZuHU5l61Wcg+mX+l1zDCV9ruGrWwDH2mP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eAqWKt1R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532B2SgD001275
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 15:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9RLDiMmXysIlGMlCO7Egquj+Dqvq5IbDsVXrOdvbut8=; b=eAqWKt1ROOYubYXG
	N8zhxo5D1bK3H27yJB13kag36rCWw6iYDEVBpBu1O2eHUwNOXvwijAvYfNsvEnQR
	wq2Vn/EIFAUWCsE4Rvk0W1UheWHOm+dVQ+fbocQNyGbT4ehje9mHPoRBEL+e5Jlk
	UuI2r+PQzkGJjiBhaHSKSa43OXTPUn/n+UISr6/47ryqh0+v8hIiML6F9JnKoXyA
	1obfG+AkZj3/BLNnE6EqBdae2M6gg+MHCDQfkYnutsvM05VBZo2Oh73B1Bc9zrbF
	HBLssIw5dujKnvWLWsWIZXFNCBIfNOt14jD8Cyk09KJ5OIlddRsqF00wJG9K2xJW
	rC8K8Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qm7kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 15:37:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225107fbdc7so62565ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743608270; x=1744213070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RLDiMmXysIlGMlCO7Egquj+Dqvq5IbDsVXrOdvbut8=;
        b=BKo1WKMKixqThc56uNuqKLcOlnOnYce78ICpB7Yp3W2/1uwElnggTge2tQQIc6tYoK
         pj4tIcXcNhA/bnoIjuKkX1UWk8/uLOWS54UAdTGghAGJNy71XxLcWkDs0i1gk9OR4qFi
         ca7w4hMpmqt2LRcX3CBEpwsfOGWHL7AndOjKNGAC00hzcD5+1BVPkMsz2NTsOv4ymzbW
         bOtLL3NPw9FoZrYm1UAD86I3X1GwScpMgYWGCdhNV2LZ/1xIulbX8R42nc2EwdIUgK2X
         XBEBZFV4Kzjs5wdJ8eoJmy5FyebU03GIRSY+RXi+InhfX4vNEvKXhg6w5Tig3OLBCZkQ
         HDIA==
X-Gm-Message-State: AOJu0Yxg3sEQ3dbpkHREwfv/2cPBFOGjYlLIdcFIhbcfet+Oj3Z5KY7E
	f89L5WkK3nn1bJJxLuR/d9x0+Q7IVrdlTSkjfYUNE9kGcq/dc7ei6FiZlHUbPD/31XgYgVPj8xN
	iVoW1GqCnOP2s/kBgvJbcvcMrVL6WGrMRxQM7DS1NNEwmOB5aCtZ/PVYj7uVVeF+FDw==
X-Gm-Gg: ASbGncubCsP45d0lGGXbjs3/1z6ZS1x+mqITmRmTjxqk9nshymDU8+YnNH/4eKW0BDW
	gdH6+bSKhxuJ5HHiRvsVZARNByiSldP3UoUVxq8nuup0bWDjNkwKd8jmfP93BAy8AnaqF/LXM5y
	ctZZwDP3J2iweh30r9mxal3zKCAlo3Y8pyZ8RrvtVS0tEoKWuWVvK1ZELWt1xGR6Ts2Jc0DuTlp
	DcIEu6HC2D69BoDqnWa2n/pjp8yVupZdWjlj4k54hksfZWsN7aRxT1XvELsGu6lVjMAGXzajxZW
	gvI2IHIngBPGfgotELzzj1xFW/OcdwyK22szKyc9h9eImXKOTQRudFT8o2r3nZc=
X-Received: by 2002:a17:903:46c7:b0:224:162:a3e0 with SMTP id d9443c01a7336-2292fa050c7mr294289465ad.49.1743608270373;
        Wed, 02 Apr 2025 08:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0OH2FJnITjMPKmfuTm0DY9atT/FD4nOqsDUoPSjHD2dC/SJdy81wArZuzwTl8gRgbPJvzuQ==
X-Received: by 2002:a17:903:46c7:b0:224:162:a3e0 with SMTP id d9443c01a7336-2292fa050c7mr294289185ad.49.1743608270044;
        Wed, 02 Apr 2025 08:37:50 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.201.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f84fcsm110188425ad.228.2025.04.02.08.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 08:37:49 -0700 (PDT)
Message-ID: <42c4d4ca-de5e-c7b4-e77d-489509dddc02@oss.qualcomm.com>
Date: Wed, 2 Apr 2025 21:07:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v4 2/3] wifi: ath12k: Add support to clear qdesc
 array in REO cache
Content-Language: en-US
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Balamurugan S <quic_bselvara@quicinc.com>
References: <20250402152529.1649402-1-quic_nithp@quicinc.com>
 <20250402152529.1649402-3-quic_nithp@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250402152529.1649402-3-quic_nithp@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ed59cf cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=HMRESTvIlCqp6qiEfvMpsg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=82-Y7rt2ZJAcIzJ_90QA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5btUGKu1tmniDOKAgwa6P97El4kMx6_W
X-Proofpoint-GUID: 5btUGKu1tmniDOKAgwa6P97El4kMx6_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=676 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020099



On 4/2/2025 8:55 PM, Nithyanantham Paramasivam wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Currently, the existing code lacks functionality to clear the qdesc
> array in the REO cache. As a result, any updates in the LUT are not
> reflected in the REO cache. To address this issue, add functionality
> to clear the qdesc array in the REO cache during a peer TID update.
> To do this, set the CLEAR_DESC_ARRAY field of
> WCSS_UMAC_REO_R0_QDESC_ADDR_READ and then reset it.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

