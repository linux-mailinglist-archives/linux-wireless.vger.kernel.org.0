Return-Path: <linux-wireless+bounces-30728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3834D16D07
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 07:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 761F730019FA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 06:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3102F6925;
	Tue, 13 Jan 2026 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFOrzsBK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T3DJpcwF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBFF366DDF
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285368; cv=none; b=oz+/kKmzfgXRvFjGm85hrERVzd+5jBELpA2XOjWc+7Z3TEDjrHvmYi54/vfuHdlKGaD4eAt14Coge1tXVa5ZKjzvlW2k+AYb0+8+gXZWa+XQYYD2ncf/RQvUa5fZd/2gT49OiL/TF1gU6ZygX3227P+zIxYXNTFifpUNAoTgokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285368; c=relaxed/simple;
	bh=HWweMk83kOSb8RU2zogQS3wDk7LdH26td708tanU8/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJWldCKlojUeEcf0lfoRA6s/FyKoQ+mq70B5H3xZGFTTzb5wFajwn8au964CHh0xrs2VDWrvFqq69VZ1o8jYZdKnSXjxvKduocp1mcz7tVhndawD7u6IRSt2Te/qJ844bnfKIMzQzbWngSc2WJJDzuTTdQk+Sv8GzB8cd3gKTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFOrzsBK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T3DJpcwF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D5ap0d3636918
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GSUcEqMp6FMsBB+2t9djtaujijmMdZGCATYEu/OcPlo=; b=VFOrzsBKvYEvZibK
	YLio5qvnKIbvfvG1dP8dDrTh1kSrVtAdOV2N66K43EzfUUulx4k442LZGxPbL3Pi
	L/U/jEpj5YwNIhhTQdB6xdVJKnAe/GlV2W4Ro2xydqgB3PF1T2cvrPOkLZzyje2s
	dP8oKJ55XZFjT+wt2sjcm8XIi7t0f/JOGYQ0amf81eDKXHFpT3QZVqQTvhyd5I/r
	9UQgCqzKWWxeh979UkhnsVNQ/gC+/x/fKpPhNIcKf5jMJ2gB2SN27SlZVV1l8IGX
	mH/lvYUSWj+Rf5EQSycUuL2d0z3OE6FlK7AlzP4eQ+A9SCB1+5BsjwuSsQKjlIC5
	mFGIyw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng2c04j8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:22:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so75240265ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 22:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768285365; x=1768890165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSUcEqMp6FMsBB+2t9djtaujijmMdZGCATYEu/OcPlo=;
        b=T3DJpcwFun7bebHpGWHA4WK+bBZClpjNkpqoDrNSFIAcZJKnj1eNv7qzNeCsQAHvhA
         QlmeB4KLpNAlktsQkN+LjYY5Ifvwx42BBLSqj03VcVDJJF7U8NoqhD9Oyr/KlrjBFX4R
         T7WI0TQyvQrb3qFXOQPDdbcgw8/6tzdfzV3CchOu2KHES68cExyhuqgNtARkzsSok1l9
         tN5rXfrMWxvZIXzrCk8lss+GPHwh2ZYU3ajoymRACO55bQM3AIJnByg2ciL8o6dQDewV
         SlBR5s9SyXguyfWx3E70IIAB+X7aKQJuij89K8nnCshzCD5pOeKDQPPxFfBAJ7wfQm3p
         e+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285365; x=1768890165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSUcEqMp6FMsBB+2t9djtaujijmMdZGCATYEu/OcPlo=;
        b=uj1ftyf5EPaBtpGlvt0z5ivnZN3EcYOt4DcXI9v7m4EhigvSLMjOefOiMtnSkwvBEZ
         4kvm+oxeAMmiKD8+cOnRoOwlhgG3HqMOrKOOgp3Q7CBH1gtdDmaZCSP2q02iMPMeGNQc
         I6R8d/CJYqYm4HMxZKs7Rl5m9O1Vc8EbO0aP1srtWxBbJczhY0SGpdA0L1713v7kgYVt
         uFknq2eYtbYYCg6rzucPRInyGODRVhkTuGFczBdS1xjLoCWMOn9qEmpqqjQ8fE4EbEuh
         bDPig9J4CkDP4ScffRPSEecL6gRmM1oJbOZp9nV9F7J0CXgYhpWC0hFe/WVhA9IraSi4
         RETA==
X-Gm-Message-State: AOJu0YwGngCo2dE3+gno9oaMexXMNGHm0ozl5GA0anFAkiQyxqm8Idcl
	Jr2pzZ/edyCqxyJlHKxviFw2seAgs2hUBQpiw9hEmtAlgmsxj5E8dtK/R+xGcQbS7oQWCgTBPq5
	6bjsfeOHxLxU1PNLhg9h7rfuusblW6QIBC1Oa+wxKY/jzldSANlhELU8GYxHMF85GDMw4nQ==
X-Gm-Gg: AY/fxX4w9+Mc66OZ7frRnLfD6lrK14iczO4E+btjhmBXPRsRSUx33k6hkhqlkFsoSYm
	jEwBE44ssMzsnf8sTDcNFJEXQcgJPVe8TnKoycF1rk4h+n36Su5xJoXxe+RymAl7yLpIj6M53sD
	L2uvJHy9XAQIRLRLWmJMILSzW7a69YaDtzZZrlugM9PxIbgbNKUIg7TbVkGBbxi+opPXpwxY9in
	pvJtHaCwEJb4uF3l6cJ2k2tOz0fkSVdr1etkd3Y5GD29UtPKjtelimnPc858aYbfMMMRBnYSGB1
	e3po9HcMzJVvmNdRcyKHUrgM+QJeTNy3G0Rj1O5ElnKXWPbzfhln9EboK3Vs52NFN1jNYVKIryw
	vaulUH5rOksb5Bf3DuHyRvspIZHwTxdyzOVUCl38OIIVma4K4K2Jepfo=
X-Received: by 2002:a17:902:e841:b0:2a0:9411:e8c0 with SMTP id d9443c01a7336-2a3ee4b580emr203607795ad.32.1768285365253;
        Mon, 12 Jan 2026 22:22:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+nkOMKgu3hsqz9xVAOUonSf7usnx+s2nDVg5IBWdYS+wNZayH73RGVJAdh1kT2DpMgRkCxQ==
X-Received: by 2002:a17:902:e841:b0:2a0:9411:e8c0 with SMTP id d9443c01a7336-2a3ee4b580emr203607585ad.32.1768285364744;
        Mon, 12 Jan 2026 22:22:44 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7856sm193322855ad.68.2026.01.12.22.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:22:44 -0800 (PST)
Message-ID: <fb802027-84cd-4b2d-b921-e4b7346bc4ea@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 11:52:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix wrong P2P device link id
 issue
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260113054636.2620035-1-yingying.tang@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260113054636.2620035-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfXz3RQT54xXx6z
 qOP1S8IUZAGlAtu5xDxOMU7HkvSSiIV5xofH7ksj1YQejdOqJIRLsokJAsjaPfCiiBZL2e4+oFz
 pzITYVJH1V+LfoT7Kj3IBstlMMbpKAUEhw8ys8sBK15SckPbNZz3oM2+/QXXth8+6F/GQX3VNbv
 4W1KvL9bRrDvCMn471JmlsiohOUOxuO/MuZ2f8MloPmsowMWcSIQYE8E4vhHM2knUTxuUk7/NVZ
 RhJQIX3jH1w5f7VlHFWc7F9LWjFBGmkpMnV5bBRd5JvZI/AuHg+p2kHz4VqbMmi79G2F0DgEsak
 mA48ApfHKcTcSznPbMXee4d3za7vW9i3GvzSHBTOxD7cA7nJJE3cFb6LyFPPAI4UomwQwMx4W4m
 4X5I5G/gjREFz5g6cQFXuk6q6esHEg/TxOb5tRO7eVC3K6yBCoD9Vz1r6QDmM3vSbLZUMywoDtH
 aFwq8pHGdm4fpsmj4cA==
X-Authority-Analysis: v=2.4 cv=C5TkCAP+ c=1 sm=1 tr=0 ts=6965e4b6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2Mo8NHjUZIvW9bQ8WxoA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1JUhFgG9dxHmZooS5eEMfDwNpTCU_ki2
X-Proofpoint-ORIG-GUID: 1JUhFgG9dxHmZooS5eEMfDwNpTCU_ki2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130050



On 1/13/2026 11:16 AM, Yingying Tang wrote:
> Wrong P2P device link id value of 0 was introduced in ath12k_mac_op_tx() by [1].
> 
> During the P2P negotiation process, there is only one scan vdev with link ID 15.
> Currently, the device link ID is incorrectly set to 0 in ath12k_mac_op_tx()
> during the P2P negotiation process, which leads to TX failures.
> 
> Set the correct P2P device link ID to 15 to fix the TX failure issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 648a121bafa3 ("wifi: ath12k: ath12k_mac_op_tx(): MLO support") # [1]
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

