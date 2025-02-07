Return-Path: <linux-wireless+bounces-18633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69AA2C2C0
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B237A73D2
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0529A1E5B9F;
	Fri,  7 Feb 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JqEriTBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19A1E0DE5
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931386; cv=none; b=pzgwN9qC0uQSTT4kXdEex2Ds3AXGHLQ2jOgMJnrgo09dxoJzEH78BOQOWw7ZK0rhWmWreCZtdZIcKJ6WT7uRvn9CFkie0jKcgxW8qK9WpwJ2xGBot7KSBkvRUv02STW4BZ7ghkbilkfPAqnnnFnH7j0AcYH+2Dj5z79LYD44tkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931386; c=relaxed/simple;
	bh=ZS+zbTjLB7E+l9TzDSxs5E6BkJNPY8DE9qg/9FrsNS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxN2fW4w/WSsI1yB2ww5s0sbVVmn5QGY9L+jWB4ZbS/6/OH1u5oNXDaXPacdMWFSsag4ooPJkGnyBZvR3KqBvr3VpmG/3T10yC2AqVUeS6DcRA43ifehMwHVF8Za83QCqIHfP68YmINro6uothylcBHL0cnu0z8Vjc2UgzwY4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JqEriTBm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517B2bts003103
	for <linux-wireless@vger.kernel.org>; Fri, 7 Feb 2025 12:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XTtt5Umzl8f0MQQ+FEWfSkt/Y1ZvsGI7KUtBBOh5RVw=; b=JqEriTBmUmINhpcB
	U6YaZyNOvO7+OnfiwA84V4sHc/SRJPbK+ssav26b+mDgyZFblWXtENivYToVrFki
	VTDuAtuhomV8EkuHDVj0F9b9+IAEnm5CFGVzpOgxyz5+btYKVsYnYeD3SpzefggJ
	yy7NKAMo++klsI/VUp/hsr/XTwGPUmIGCNIDq2CXqjSjc3tnIXvMqO7DfElGP5Ft
	Qilg4YoySdYLrhU2CxAdKCZxwmgdi/EkgzTuipX9rVI3f2eklGX6xnU52SHJaGgN
	gow7WrtURMsZd9l+7chi+ppMLP3D2NxiBI0wtq/EATafWBbzboKNb2854CEePE1t
	rTc48A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ngy106t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 12:29:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa34e65bc1so685768a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 04:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738931383; x=1739536183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTtt5Umzl8f0MQQ+FEWfSkt/Y1ZvsGI7KUtBBOh5RVw=;
        b=N6g8rDtr5ljAGuXMtfbXr/xIX+cU9Uz5oKHf6RngF8wnJlGeJVkgZjaZfoYnwJyfHN
         rxh1XINnzU8ptovk5JuhqP9goqHTAUw+jhewum8A5xcYLdzReUOVeeYGh5sW9hqHwtCG
         6hvjSUnEZhFPOA98n02/9XZy6zyxK2sLpyIyW4uNnu/VtB54MnITEZ8isM0GdGqDTA3P
         clhdMIClPk73KseXH7raakpzQC7PjincrigbKF4N9a56nyqxKPLvQXUoAGPuBTJ+4j3B
         pgb8iJ+RDwR1Mfz0GreO3AebrhWpMBEsdYQRXBoWJWx/Wmp3XuKwkvS9LIvsKSjARARG
         S1Jg==
X-Gm-Message-State: AOJu0Yy11DGIvMCCvhaSxp8upWyNFAEnjmf972eXNnxOQEHOWTPCZmc1
	eCXn/jArvFNL4VfgDk/7xbNjMsViqLjqvq1nmhe47X3/BQ1ja2u5tVLeeu74gbsBGzlleoBwNyv
	P1K/AfRvOlIS/VXHXF38vr58pgss3iZZJysqrT7SyrHOwnUNYH1K4vhf3JZxGR2tu1aM3n+xUeA
	==
X-Gm-Gg: ASbGnctOgNmLDz+WFzgXvFRVZ653moOdxhhCEQZGKAqC+XZbGke9qMSpcQ6e4dN9/yu
	mVWgxSFMOJZs4NMQx4x70IQKqkx2AbkNNEdIsHJHMcnanCaoICDhzcxVup15CjyPfNcrodu+aMK
	P9ZaM+dev8K6MNHncxa7ddRevk2NzCLDwhc1m8olzv5NUcEadR5qUOfa3WajxQvKVaJOuJyAB8J
	Vm4bJz/oOmi8BFUYHc5yuzENC61pIadYYswlcAjRQlzGXp+IR1y9j80/2mIh8YHg78XJtKUYiXX
	cYTq2ywPT/wjZcAERr5BJefdnXrbu4e5z+tEOuGYfKH371U7rr3Rlg==
X-Received: by 2002:a05:6a00:3e22:b0:725:8b00:167e with SMTP id d2e1a72fcca58-7305d519851mr5004587b3a.16.1738931383388;
        Fri, 07 Feb 2025 04:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7iwW1U2hCTOhBuPmVr7QSQt/y+YyOQdKeda/GZ2s/XJbbBsfpeQ0wf7CsFf7CJd+zi2GgvA==
X-Received: by 2002:a05:6a00:3e22:b0:725:8b00:167e with SMTP id d2e1a72fcca58-7305d519851mr5004547b3a.16.1738931382919;
        Fri, 07 Feb 2025 04:29:42 -0800 (PST)
Received: from [192.168.225.142] ([157.48.120.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1413sm2964269b3a.98.2025.02.07.04.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 04:29:42 -0800 (PST)
Message-ID: <02c47980-b766-1478-7338-74c0ff8554f1@oss.qualcomm.com>
Date: Fri, 7 Feb 2025 17:59:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] wifi: ath12k: Enable MLO for single split-phy PCI
 device
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
 <20250207050327.360987-4-quic_aarasahu@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250207050327.360987-4-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qNgE7xpliGh4MO8pb3PcEjoSR_OUBwDH
X-Proofpoint-GUID: qNgE7xpliGh4MO8pb3PcEjoSR_OUBwDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=759
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070096



On 2/7/2025 10:33 AM, Aaradhana Sahu wrote:
> The single split-phy PCI device can perform multi-link operation (MLO)
> within its own radio, and the MLO-supporting firmware also supports MLO
> for split-phy PCI devices.
> 
> Therefore, enable MLO for the single split-phy PCI device.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

