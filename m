Return-Path: <linux-wireless+bounces-17198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0289A060E3
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 16:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42D43A70F7
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9404C1946DA;
	Wed,  8 Jan 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N91i3mMt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAB1A23A7
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351725; cv=none; b=LS+rnifhoVd5HsnJjH8+koowXU+6uxVDsXiSFQssoJvztWqPIRTYSPmC2OWFex5nutmVGDYWoicswQiRoZTqwTihz9KJhEel/dQI/yYeIBKdEe/LZDrD5bj3DEJo+vrP4UaL8pMxxhrIFjQt8KK7TP/8kH4+LnRcnEAkBZ3FYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351725; c=relaxed/simple;
	bh=JwAC9/qPrLxlA5HPkFlTAfgdvTf84XVdqMe0TQZDPmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxLZq57XO01SPRdLx7tl1L3dbemlE0cK00DK3f8fmGerC5FG1XxUcwTPO1k3nov7Hpxa7yvWhQIExdfxoaAa/bHgOTKoGLeNBo4KduUXM+WNhB/G9/JxpQjTUfSSI/BKVXGuWVR2xXBnuZHM+PnGK3oa7rcv/DXSIt2h6KRC5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N91i3mMt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508CLb8v028209
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 15:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzJXpnxpbDhQRUUNG2bg5ox3iaMmNxH3xkMCkyytqk8=; b=N91i3mMtytBm+nMA
	/XM0CFQTtP6X1I0DLT5L/Qt/uFOhOGUD4wjM+TmhDimLOBrJsk0R9q1SJhkMZspb
	jHdNR2w63nUYgHSJFDLavoJ0D22cvKrTVqHlC/W0wIE9d594bMTOzDaR+k/qtlH/
	VrGrM/RY8qXQIfs5jxfUwPD+Q6qDsRRveFcR7YJAnYzEKivVE6mybhDCAiL7fbuG
	yjumjKvrL6WDLpiK9iekDAFBgdw9Wl3UJAGvjxWGW/4TYD6dAUlfZRQdWdbjpWb0
	PXheC3mP/iM4MpY3hC2mY2cfWaziYyoR553c78HbmgOxMf1eqOpxEnaDcjQPQdP3
	3aScUA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441sa28fd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 15:55:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21a7cbe3b56so26001055ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 07:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736351722; x=1736956522;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzJXpnxpbDhQRUUNG2bg5ox3iaMmNxH3xkMCkyytqk8=;
        b=Q9HiqcHbDopJE3KBEoTzgLbPrwIUKVvM6nFruJa2cYW1k7WGplhVMUg8e9tUp1P87w
         jcLpsA0ifwsN8APtKt77any7NKGBFMbAoMWkKH1Q7KsM5WdwdgZqCD+ok1Cspg3vLvQ/
         T+aEoL0VwaJ/feb/L/0ZQpdBeNQm+Nj1yxTexulJkYdSgZ8hK32A84yJLidXLmSVY/57
         0p6zad2BFb0TANnwXzwapiKR4mGPRZN7E/KHSyZSTS+5e4zfJHvZbqX046xWLEDPzr2M
         VYB/CNydJVVf4YNHHRN/DVByQzHyZU/UPKuXtE6wAIywiNKgyJhx4APOnmIAQYqZCYu+
         88vg==
X-Gm-Message-State: AOJu0YwAGAXqEfaFK1q7Ne2WDvPazoPpD2Y9qlB4BTSLIcFrxfb35SVX
	zZOCAAhSQCeWnk6Pdk/yfyrcFpafi/dWo6i79yCVUsXMepwAqVWH5sIa53EkrYL4Vq67R5Q1VuI
	62QOtHGhacj1BR+AWMjoDH+vVaYeHhzCCRUJBWvrTyCEDRg8DiGlnTkRtKQcnWRiRcA==
X-Gm-Gg: ASbGncupynx8mi4cIWvg/63JqWU/XC81CeWyFBEcd2s0l87zTYN2R++xiYVLAQTyQhk
	mRTuULEk/QkR6VTYTf7HgIqS8BsseMck2z9/v2ejzslqvumem34Npfyldv2zkiyGML/VG8qAb49
	DntozCsk2ROYwMyYGCMMklEpB5zauMfETH1Qm6JlT2dAizx35DZB7bO8EqhtEGI3/bROkIPZjJD
	UoT3vBywIQ3gX2v9Q5qjalPFNr/lgmza1H+0UyUjGce9clm5d1Xu9FfJigWbpHhf3+rKEGRMe+y
	+t32gZeF0q/RMIPBogC26OQu0v2fLPfwJNlxnomJ4qzKES9idg==
X-Received: by 2002:a17:902:d4c4:b0:215:9ea1:e95e with SMTP id d9443c01a7336-21a83f591c3mr47578515ad.13.1736351722039;
        Wed, 08 Jan 2025 07:55:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9nXlV4OJFC634uTvp1BP/oG1W9qxY5GSUwAl9t+gx7yULZafg7e3yjy6PiE0GwXnpLo1g0A==
X-Received: by 2002:a17:902:d4c4:b0:215:9ea1:e95e with SMTP id d9443c01a7336-21a83f591c3mr47578255ad.13.1736351721669;
        Wed, 08 Jan 2025 07:55:21 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4495sm329558215ad.113.2025.01.08.07.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 07:55:21 -0800 (PST)
Message-ID: <b86a2af5-2276-4875-9b53-c3f43392eb5e@oss.qualcomm.com>
Date: Wed, 8 Jan 2025 07:55:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] wifi: ath12k: Refactor monitor Rx handler
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241224143613.164921-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241224143613.164921-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YXr6Lgiz5DwaM16VpFLUu5VATUnwVbXz
X-Proofpoint-ORIG-GUID: YXr6Lgiz5DwaM16VpFLUu5VATUnwVbXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=664 impostorscore=0 clxscore=1015 mlxscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080132

On 12/24/2024 6:36 AM, Karthikeyan Periyasamy wrote:
> Currently, monitor support is not added. However, in the future, the
> monitor will be enabled. Therefore, refactor the monitor handler, which
> help to add monitor support in the future.
> 
> v3:
>  - Remove the Acked-by tag

Why?

If you did not significantly modify the v1 patches, you should have propagated
the Acked-by given by Kalle.


