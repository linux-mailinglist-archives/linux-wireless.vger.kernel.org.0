Return-Path: <linux-wireless+bounces-28412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF3C21558
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4FF3AC73D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AAC1D618C;
	Thu, 30 Oct 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+BwifcZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MfPJCAlW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7712D661C
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843193; cv=none; b=mbgRW98wPfSolthVyph4AB14SSUQrYWmglbkO7MSoqq8A8qimzV7c0iEJDwUMV46QEVcvaFiFHFIAZj7xZ+DuFNtWN7R5YHYIOoJPTaa4s+1DsI4oOfAVZp0JDydPXAJwGEYTHdt62PagYk2wBaLJt/mP+CEqR+MKFV2YdIQZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843193; c=relaxed/simple;
	bh=wI1qfDINZoZ69SmZPsy+J/0JWAeeCtQ9RHZAcYval10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9Jgghx0pAWRQgxdRKEj52QEeOY6a84+4YrNy0pOY8Jnxyu0HFUZXLytrTKa+wj+jeAh/ckxiUNL13eXm9okkjNDk2s0OWdwvPmOiDHDkh98vbfVpUED5Qz4Jg6ygbDlz/Ll3/ErTT2iIyDx6RgpmOnZBsZOuwawxRCZk5LWh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+BwifcZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MfPJCAlW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UB8c3p3808775
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LPJIDdM+jhr8MK7g+RWoUM45XPB9dqtyKuSE/Sz40MQ=; b=M+BwifcZrLHt2HCg
	/8uBQLXUzPDP30Gehqz0uK05++441mFLkaBCXBEmOuTMnGQNOsDGMA33EtHV+GS0
	49gubNVrZkScxyFaO0LNmSyV0b+UDoPTZ5vRlDQs41QMYZeJyT9ydclIyI+xsR6w
	OzD5l/OHEY7T5kNrRZWOkFZqSr0xFmzy0yKJJMy5LztFx3GP3lZotLZxkMaXnfhM
	K+p8kRrLrFzucibqdElXONdeGOyMIza4tGa69l1EPohMxm4XMI7C+3W1i8FlyroG
	RBdlv61RLrQ2gJls5t2t0VeJ8Ie2NQpI7Vr2O3hYGPII85TwfBts/0E+4UpQkysG
	2n1Hsw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a46vv8y60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:53:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295093f614cso6881765ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761843190; x=1762447990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPJIDdM+jhr8MK7g+RWoUM45XPB9dqtyKuSE/Sz40MQ=;
        b=MfPJCAlWZYxpxDKVHT35wS6DY/0/8Nszo+iU38LjTJwK2yCGlLI6k6xpeKXXhJxJ3J
         KRFpRtzdf2dnZtmng93fO6ocyy9bFKF4ZBmXUv/tbLwJHA6d8J8J6CVQZEG+qdKHEoW9
         ZyDHViOF7mnws/59IQMGqX1/NqEOL0jYz/1Lhw/kT6JQq/RkqJn/UHXhTvgGecs6PMB2
         Qk5YmjtbJAm+yalANVzbgOt8LtJ4kfEqYdgkDrvHeXWz0+q4HFCW4xtJiJu6pHeZMfOv
         NYZ70qFvp02tRo0uDqL9A447lIkLg84S3qpcSSYAoziExm7br/JEzrUThX+HHwxAFihL
         cQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843190; x=1762447990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPJIDdM+jhr8MK7g+RWoUM45XPB9dqtyKuSE/Sz40MQ=;
        b=YFyUbVkAf82M0nAA7rl2Yznu9uWehXv6Atl9Lx1TxnQYcoFY2L1PMh58edwFG/wrY9
         pmW1ZP1eTVxGTrgcZhVP8cBbS54ZDEW1zhaLUAKOXl1VTRiJZM91kV8a9TQ3hpHlwCoq
         a723NW+yhcdzywlMBEsoPhrYilUAk8jPeYkbn7g7AhmSLJgzfftSEIm6wUizBwjVGgcQ
         8622pY/6M845BBfLhOZVQ4apFd/ilQOI7LUzHtL5OJIumAyG3NJDPNv4BtzagPEKEirt
         YMh/QlN45Pvsx9lIfsqq39eglSIofxZ7VpXoODh3ce7pmzz/y0t2VrXa9mm2agFmFLel
         279Q==
X-Gm-Message-State: AOJu0YyL6IMMSdSZPOuXD0SAFQPDPwzRq8W3dYlFbFfGeuQ2IcpqAm1s
	e9SE95Rta2kYLVfECJ2oFM/ALMZ324b8g0hZlndNmQcAyu9BmXCiobSbz5inat2H2Pl44HZTXf3
	iRNJyVM8P05bbwgUl96Dr4GHjTFnYdXFSauzcw5mGFNiFKX4ARdmbFG/sRjhF6IlxItT7GQ==
X-Gm-Gg: ASbGncugj4yi+mvK2hDVSQh/tI99dCkHTsSUw77RrEg9LeOv3W2EqXrcXBflQ7+7/UM
	ZQSx9tUM6T327kAdhFM8wiQpGkiBNkXka6GsjEqEfcbN8qly3dOJ8yeUmlgcut667hVMIMIMEOQ
	TPGcUer5l4XNbA6dlrA6t0fxMgVkGLvhITWdOG0EkAoH1PRUIWyJg3T8e/8/4Qa/PhOiuAtcvq0
	YyrFdbbYrwMlbng0AjBWqAjWVYz2PPdHFV0VgoGu0YQVaE3qV3DhjfLjgJsw16mK3KqKVGr70oU
	l661AM6D06kR1+at8QoYJQt8rDCFrx6Jzh35OuYd89hLCxdBrzbSc5gNK3LtIccGNHfVm4+EKCr
	umyem/tjS+Z8pyGe2PX3Ivp/PNqEyaW+qvHgrYEfQc1ENiCadJCQ=
X-Received: by 2002:a17:902:c40e:b0:27d:6995:990d with SMTP id d9443c01a7336-29519978855mr6012995ad.19.1761843190250;
        Thu, 30 Oct 2025 09:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS1PSRFIXepbR3PUacQ2bP3alzWBJP4R6wSxqFdhGG+l00bAGA7f8PDipn7+VeN6k3LHmHBQ==
X-Received: by 2002:a17:902:c40e:b0:27d:6995:990d with SMTP id d9443c01a7336-29519978855mr6012685ad.19.1761843189695;
        Thu, 30 Oct 2025 09:53:09 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.207.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40166sm190649375ad.67.2025.10.30.09.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:53:09 -0700 (PDT)
Message-ID: <993b6232-0e47-d331-2a68-a1a58979685e@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 22:23:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: handle vdev create errors and
 ensure limit checks
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mPgrMPtbXRzZE8_lAd9eSWYqCXfmvI8j
X-Authority-Analysis: v=2.4 cv=dK6rWeZb c=1 sm=1 tr=0 ts=690397f7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=CMr6UP9dfYAYc02HN5pMZg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gvBvQFtS0oAN2tB_OWIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: mPgrMPtbXRzZE8_lAd9eSWYqCXfmvI8j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEzOSBTYWx0ZWRfX6SEyy+dvOt5o
 pNNe35nTCARVs8Jq/M2vnzEY32fAOgj6Jc86SkufNcPgb7h4ghIeHgnr4UPuzzQNVMTxUbjQ9lp
 BjSt2gk8FAhUcvD9T2g2YGfhAomKO8S8N42nFF4H32SuKzJuSQUCtDe5PYtMoVH3sp6zYf2mPd+
 HtWBFTo4Wph4j8DFBHF1MxiDzI+CDkXN3Gc3O/02zl/P9rzAfHx8MvJU1dd+kpAjhDLPUGYcxUI
 wFjAZF9ccmT3BnWPGNanh0jxZkMDzkapyowRSHR2YQAiiVfWoTgeV7ps7RRq64IIJ4IR121jycN
 0/0buAcNLnzbiAS3Q5HrVo6pJfhEl15s2lWmM0zrTsfR4WQ84NtR1nisByzFUNZ8MRzB6Y6TJAA
 LNQzUm/coOzvNhMdeslyVqUpCfvWUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300139



On 10/26/2025 11:52 PM, Rameshkumar Sundaram wrote:
> Centralize the vdev limit check in ath12k_mac_vdev_create() to prevent
> exceeding firmware constraints and triggering asserts. Ensure stale arvif
> is unassigned when scan vdev creation fails during scan and
> remain-on-channel operations. Return accurate error codes to
> improve error handling and cleanup.
> 
> Rameshkumar Sundaram (2):
>    wifi: ath12k: enforce vdev limit in ath12k_mac_vdev_create()
>    wifi: ath12k: unassign arvif on scan vdev create failure
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

