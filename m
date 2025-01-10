Return-Path: <linux-wireless+bounces-17334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E0A096E3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 17:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9131695F4
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5B212F9D;
	Fri, 10 Jan 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eEDm02kT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07378212F90
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525573; cv=none; b=dda1B8uScx8egLTqH0WUVC81SK+MVHprapgHkauy3zSmcpot7Nv05VIUaThVqa+tE/9Y6gEGZCbjh6ptze+snj1INWzkwnyPOOJItPkQ78wJNQYDvTiNwghdl+JzA+hLic16gmoPF+loTB7SJbMglV2CsGIbgo9RsKgp1qjwp3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525573; c=relaxed/simple;
	bh=51LGjZp/nE5QY8g9/e2jLADUryXd/ADCf38g53JEP1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDeZ59k4FnnAp64HB78jtW9zVYWws3xDXpZNWcgfEIsu0h+ZNvdHVRESkDdOcsyhbxH6kLs9XlKCrFtKFtRZHUTDl/LU3GKfUEs5KXIstLYTJnAa/wLMSjTKaZtRdf1so8XhwjPPBdv+7xSB0xjbs3/396D77cFE5Ln174RoAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eEDm02kT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ACLWdV004109
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1qnvIQCDqBvB0sPSazWj2d/m7pWHHbXV9UJIQdj+voA=; b=eEDm02kTlH0KWgR6
	D9PA+qeS/ZLM6GXZHt4iCbfunY9vC7oRQer28MXq+qilcGKAvWK39fauFh7uCz/Z
	y7CGfVVVBGJ8YP6BymsN+CEtcbyYvgOPLmE10T27dQOyFm7Du0EjyMR9xOndiHzM
	PtDO6NyzBV72Ae7j8Zgu9JSUmSi2DH/ptr9a9XqgX4yX20pBh30YXW7yzPM4P5e7
	Kw7TyfSVq/wW9krOjKDGHsKXoau/DTc0igNw8xw3O/l0X3T5+AYMH557oTR46uvX
	hizChdeDUZQRlNVYr3gDFlwyRvTAStBAB20ijv9CUtoGw2zAS5oPGrGgPruMGMgo
	lAdILg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4433g0rn5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21650d4612eso57383125ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 08:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525569; x=1737130369;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qnvIQCDqBvB0sPSazWj2d/m7pWHHbXV9UJIQdj+voA=;
        b=K+MquYWFIKdl7gYDs+kVB7Hzn+hugRGj2OG4FbJcnc7cWXrB2XagBRm5B2jFGED7eG
         LgYw8XXqKRBC8J3X8jx0lUvSprbOVHrzuBiCLEBELSanymCzhtBaRYLRDJioW/fVmUQo
         5beeb5TF9km0n9GmcETMm6UKdVDj0GBlnO42N8mZgzpGwqaK/JifVF2AjLEeciNx6nhY
         52pa5onAOcray0CxYy7pe8TA71SYzuLYvr6mmdzi3mQLmla9dLPTvHZCGF4HHVNtL/nD
         ndrt53k8vyw9e8YPerItXzgGFuKB1boxZi+H5VCz3nXzrkjYd61YGh/uRXRmySEbGwvH
         SH0Q==
X-Gm-Message-State: AOJu0YzZNUxVrvxPBijRaWzBQ4M82jZhrFo4nC3uSmgyQE6Yn/Qatt4b
	vAOCIpz87C23+5SZL+XnSwAdPYLCwpKQSZFD9ciJoN8yYzd2kuzMrbcgStpYHMQzesgwEs2DoN8
	VRWpGFR4L4MuUCn5kN+s5qdNK5cuHjHITNXcVfwoYcbQNjFhZ1ctb8zsRbgjese3ejg==
X-Gm-Gg: ASbGncuKqCquCNiZGKA7f7W/7YDC89pnuYMiuJCbeoG0X8ycUHO+9eQZSNo3NGuoAXI
	ieF6FSPVwapDyQox0Ytr7nL+FdA6SMCAXCo4GQY/ypSgfJNzoy8MeDP+kV46UnGCIfkY6cJj10t
	zh0XDggPcHIj9VcDBJOoOSP4wGROrxCc2WI+Wo9l8WyjLNzHzj54htgaWLCG8K3pgT4fgbUvuM6
	GNlgdmhNOvUMKiGvB/3ez3c1ZnMbKjhE51fvGvWijeYoibRbQ2y5IbDMHiPUuKOGPJNxbDpNqKN
	/zNlTSjkPRiHtTs+spNpmCA+wkcUSUy+mN3R+Aovl12WQi986A==
X-Received: by 2002:a05:6a21:789a:b0:1e1:bf32:7d3a with SMTP id adf61e73a8af0-1e88d0478d0mr18342418637.26.1736525569102;
        Fri, 10 Jan 2025 08:12:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvcDBOWh4yGc/eqgeGamPmGgUOzMRPOd61Q6PrOP0krIimFhejT24fBclldFbUIhuwCKSQYg==
X-Received: by 2002:a05:6a21:789a:b0:1e1:bf32:7d3a with SMTP id adf61e73a8af0-1e88d0478d0mr18342378637.26.1736525568682;
        Fri, 10 Jan 2025 08:12:48 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31de807786sm3034286a12.76.2025.01.10.08.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:12:48 -0800 (PST)
Message-ID: <0862448f-8e46-42c7-b1be-175a4be7c167@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 08:12:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: ath12k: Fix uninitialized variable access in
 ath12k_mac_allocate() function
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
 <20241217035920.2683568-5-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241217035920.2683568-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: d_WWQPhwIe6xGzGXLZk8R9N8kZCAoG7e
X-Proofpoint-ORIG-GUID: d_WWQPhwIe6xGzGXLZk8R9N8kZCAoG7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501100127

On 12/16/2024 7:59 PM, Karthikeyan Periyasamy wrote:
> Currently, the uninitialized variable 'ab' is accessed in the
> ath12k_mac_allocate() function. Initialize 'ab' with the first radio device
> present in the hardware abstraction handle (ah). Additionally, move the
> default setting procedure from the pdev mapping iteration to the total
> radio calculating iteration for better code readability. Perform the
> maximum radio validation check for total_radio to ensure that both num_hw
> and radio_per_hw are validated indirectly, as these variables are derived
> from total_radio. This also fixes the below Smatch static checker warning.
> 
> Smatch warning:
> ath12k_mac_allocate() error: uninitialized symbol 'ab'
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


