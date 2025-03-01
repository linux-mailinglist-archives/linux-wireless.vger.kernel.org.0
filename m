Return-Path: <linux-wireless+bounces-19627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E4FA4A8AE
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 06:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CBC1887435
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2FC1B043A;
	Sat,  1 Mar 2025 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJAqei/e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC4199FBA
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740805760; cv=none; b=ouDZw7rVDtsQeI+83vWe2op6Utqj4CzRMvf8PlV7mLXXQ85yaDESix8787jef3S23i1P9mGSK8aLeZzYAqmFkDqjK7tn2NYMFYI0xrM0EkochIXijLbVXLZzrw6+JAh2brcdOSQuAHKzOjq080CmUNChGqN8/nHIP12b+cvsOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740805760; c=relaxed/simple;
	bh=tVSYEjvp7xfSqBqeTRApW6xii7D//ggjGpoVG0pjgcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIXXCTrzzsK44N2m1b0tncoc3yd3UEhkJ0Evb3ge71TM/ZlJq1D0hu1hVqCV6NNj9+k01ItArol135LK4PIu1DjO3NdcbOnjupwz75R5w4wEMJistzsgBzVyIxLVD5/etOYfffUJvCFjMXYeMXdn/zaD/Kr0WYLfmBqK09wKUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GJAqei/e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214ld86019801
	for <linux-wireless@vger.kernel.org>; Sat, 1 Mar 2025 05:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TIlk+ajMDuZH7zWgdOUVSBHCH+1wYAtnZW1d/mXvgbc=; b=GJAqei/em8uLud4q
	6x7RQPezu+SEwT3VvtF3gus25OQabyrxMNVjrVi6AvBuVNjFHk6EHFiLS1VGpZvO
	ZLIeCP45+Ad/PwcBXPvecr7t06wEKXsTx9fuWESHUX1cU1uJQULHXNPcmKSe6+7w
	CxoUx8biWWtY/FHliEOa3Bvu8ftKOPtgqCKlQWpbSRq9HimqYByrhKeJSPv8ejkb
	PaEGIFiBDU26lGLgPzEXEp9HQxRyBlCFl6iI9MxwlRWWtvyEyETqiU/HXjfQT4uN
	l8CBJWNVZHwMLTElZUWMVJVFhgLZXg/UCZhJES+nPoh7Mg4Ko7afAL6c+wsvvftv
	6sXhmw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh700xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Mar 2025 05:09:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f816a85facso5728872a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 21:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740805757; x=1741410557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIlk+ajMDuZH7zWgdOUVSBHCH+1wYAtnZW1d/mXvgbc=;
        b=SL7NgO5Y6OMbUZQoi7f8swHXAiVGXeBGcvzmuVlkdbkWRSaU+z+Oery0hl1sO3jLPj
         u1Yr3WWXWnaPiyByMfRZgSslBq+5PWjbtZkz5T5LHPCj6vmYO871zQ0jqpo7mP11Mp9Z
         fHldjjSiJVH8WbQm0v2skKHQCtTuXd0d+nYCvMMIjWTmzuD2tXWXj3DyUWTH/awfS10M
         oQa7RJXpKjZacdfYc30g/jRXzsY49FrAxGspwSVjlqDlEXVlNo3DvfdzMCq7C2kBbs4T
         EB/8j0N9XGD0/ETg5aPHeUzGriwx493vPaJt6kGsPuaY4XyfIyV7Fy9xCey2DV52ce8H
         0thg==
X-Forwarded-Encrypted: i=1; AJvYcCWLBA1M98CYbZ0lvwkO/rFEsBhrskNxGSPMT/AK8SEO16EurqQ9FEdHNJprzb+MSTCpyAyq0cpoWM2DaRuZHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDtWoFPMpLCQZbfBSIJhZiCFRlagpVni4MfcmMU68CgwNCNx8
	m4uBQ68c3qnb+NmwpokfQGxdxPvujUE3Rv2HkRBVy2W3L0xt40AiwUauhxdCA7EOLJY4fX89q/i
	NYloeyw0boUNZ9ebSmwG6QA5IUjOV1DieZSaI5M9T/Weam7K3iPPahzVDjfEOL0I6dA==
X-Gm-Gg: ASbGnctMbxtN9bOclI/R+85TxyiQ0JhWKVtCwieESFazoe4UcSBrygAEg3U/vUV5Nu0
	lT86Fgy/497d9SadzDbwZicsxwe4D92fsVTdULSgXp/iqRtYlG1yBa0cq9EwNB2/hWqpDszRj8C
	XY5Lk9nK7kpfYrepvA4gudWxYtFozPuwlTHGzfy8mEP5j4UJNqstHV+7cMKLLN/HppAy57LUJoY
	Gm5Tw5zHPJG8GRk0ZrNWDldWqXGmAjrpVS0USFOl4ORXFkZ4Mb37/NWpU3DdObrauIMYBAcvg5+
	NV91rHfIFgSJvrhr2puSc6uTBA7hyEkV+GUzp9396NlNvTJ+9/IQynd79GuwQYc=
X-Received: by 2002:a05:6a20:918b:b0:1f2:f20f:67ef with SMTP id adf61e73a8af0-1f2f4cc6306mr10875006637.12.1740805756976;
        Fri, 28 Feb 2025 21:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENJiGALApkF6kplPsgtv8JXeWGop0YeyYL3iNVBG+FhHdCgcP7xLV38B79Z64l3r46ha845Q==
X-Received: by 2002:a05:6a20:918b:b0:1f2:f20f:67ef with SMTP id adf61e73a8af0-1f2f4cc6306mr10874973637.12.1740805756581;
        Fri, 28 Feb 2025 21:09:16 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af14cd45d19sm1569783a12.35.2025.02.28.21.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:09:16 -0800 (PST)
Message-ID: <92c2e144-6769-7c32-b04c-04071ac8d6cc@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:39:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 04/13] wifi: ath12k: add ath12k_hw_params for IPQ5332
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-5-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-5-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FVn1TsxKINiAWUumUxWmc4mr_r0IEpUc
X-Proofpoint-ORIG-GUID: FVn1TsxKINiAWUumUxWmc4mr_r0IEpUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=719 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Add ath12k_hw_params for new ath12k AHB based WiFi device IPQ5332.
> Some hardware parameters like hw_ops, wmi_init & hal_ops are same
> between IPQ5332 and QCN9274, hence use these same parameters for
> IPQ5332.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

