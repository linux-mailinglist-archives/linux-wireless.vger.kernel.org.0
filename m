Return-Path: <linux-wireless+bounces-18538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF1A28E0B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 15:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103F33A1FFD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1655FC0B;
	Wed,  5 Feb 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iKHjt8do"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3131519AA
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764426; cv=none; b=i39ZBce4z7Zvh+JH5exx7yQU3fZiAniXw8YK2gD9am14dNPF9cNg/i+MiC7tK8qHKqZ/raB636KOTvr3CUqnrMMsScTItEmtuXx3B3AkSnsvRB2p3dJnAk/QV1bP8qXO7YLZyCm3SXmB5VWcuuX1tFPs/2vAp8bY+Uca7mjTvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764426; c=relaxed/simple;
	bh=q4drDZAiM3wDUOizq6/bdnZ/LPQKneyaguDJKMIL2WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ushm/kyOuIWkstFOLN9WqdBnnefYS1uniuLGM9PVIcqV2pAFpw6PopWvUV/hVLfij4XKN+gjKymWH9ma9gAXvPZ+tZ1QtptB5eXDSzayDR3tkMSmQRZZ4PMHpqFOn/BaOI2cQgpjF2LibyBO4Iu6Woe2Kg9LGkn1oZC/wgfRNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iKHjt8do; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515AghqC024354
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KSZmRSPq40wFKBTzPltndzDZzfXVxqkJjIcUZvnIGeU=; b=iKHjt8doW5PN5Qk0
	GhEnk924AFkRroo31lhxQfOi+Onc3ecTb9XnxwqdGtTwbU31d32o/zeNbK0fhBMw
	BmLJYbOSEXtKKxPwCsiT4PJpqUnN4zS04UPee5oqXzd5+/8u6rQQ6oJAFUVWSVNw
	d5hKzDkXpvCOdb6/jAyEPssDkRP8oKc5/bp4fwEtEG8zEbZrCpBLSAUpJDfv5k2g
	bpqheYTanP8MFpaSG0ZGJ+8ChfV8y9EaIpoJP3/rjTJJ41J58GGKsNGw42uL4+FS
	RNjlMNNDcD7l/MdJ1t9v7j6iJCiHGQZpjoN5QpxZahmcfE9i5Fmfiw7JnVK1dd2a
	x5IeQg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44m6fqrfx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 14:07:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f9e3a00fcdso1505820a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 06:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738764422; x=1739369222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSZmRSPq40wFKBTzPltndzDZzfXVxqkJjIcUZvnIGeU=;
        b=Qe3fa8hsG9pIYSqiknNAyqUx3HpdxJm4tWh98UtKA3fuL01ZUkdmzObfyx8n5j2gaQ
         dszHOZ7+t1HHG1qc5961MsarUCLhYU/VdNgGqg9NLqOoNceK4HquMEtsi224YGNPhYhy
         01sqFoQ8VQK8UqEXZLgSdUSLq0LhjOPsoHYAsKuRtmG3Ap58Bf2Itqr11FSksS2FsFXS
         R7ilkHGgKiEdtf6WHJS2Y/MYFPuF4qiD69gMUiPJUt3/P3iGWtuVnIWTVrQebMiovlp7
         MWo6w1a2MQRSpFfER+gUazEivIBUnUu5CK1Rbo4IgzDrWUiHWW5jTfv3sQnmTDdn+fVA
         FjqQ==
X-Gm-Message-State: AOJu0Yyw77KcblrTYKKKFyO3+Ta9PGUeyfqTeqazdfRCAHVQXxuIkomE
	oizaNa5sbP6TwACTI2Z8XDOpBkABFnsMvmUpcGNOj6xz+fDDrxePCo7//kcjAdPu1Pr9xUY8oLX
	V9Z+X0SREBz814TADmISqx5hN4JGsuIYsVGuCp/D8hULkF4Ex1QMLDstVtFus/up2Rw==
X-Gm-Gg: ASbGncv+nb94z77Pu4L/bXpStiWLNaOplT9UIJ57sTKNDPh9MO0awqVdDga+xXxMwwG
	xXIO87ZcsuhoXYxNLXTM3Lf4i89Bd5FcFuNSScovgx95YyUY1brvZTujWTw6QslMA7kgzlejFZ2
	lW4H7SKQ6NydtABcTTS8HIkT74aU8iNJ/Nze1nlJVNlWkVqQTSd+CvS1Q6XkTSARKD2OeWZH+qX
	feFVr/b1EfjN9ZZ5w33Sk8Ep5zYB4YyqTzUiPQxzJHQ3Yh7qW5Yiz9lwYv/zXukmByLc8iCr2t+
	8p7HJcxpb3nTwmeZL4/V402Go+upySV2s/ymHdFmP7i25rxHleKX
X-Received: by 2002:a05:6a00:ac85:b0:725:cfa3:bc6b with SMTP id d2e1a72fcca58-730350de70cmr5794919b3a.3.1738764422130;
        Wed, 05 Feb 2025 06:07:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLUgOwY0dbNhdxWAhIQrId0UT+5/qpdzoqz2LMH1BjebYEqi4T5j1dk4vDYiR5r8wzmbNTkQ==
X-Received: by 2002:a05:6a00:ac85:b0:725:cfa3:bc6b with SMTP id d2e1a72fcca58-730350de70cmr5794875b3a.3.1738764421697;
        Wed, 05 Feb 2025 06:07:01 -0800 (PST)
Received: from [192.168.225.142] ([157.48.120.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424f5dsm12459515b3a.42.2025.02.05.06.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 06:07:01 -0800 (PST)
Message-ID: <7dec5968-87b8-67d5-0b7c-69f869f61bf6@oss.qualcomm.com>
Date: Wed, 5 Feb 2025 19:36:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/7] wifi: ath12k: Replace band define G with GHZ where
 appropriate
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250204093656.3682278-1-quic_periyasa@quicinc.com>
 <20250204093656.3682278-5-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204093656.3682278-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LCB-bdpA_IG80Eq28cjwUXz9edc6Bahp
X-Proofpoint-ORIG-GUID: LCB-bdpA_IG80Eq28cjwUXz9edc6Bahp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=640 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050112



On 2/4/2025 3:06 PM, Karthikeyan Periyasamy wrote:
> Currently, band define and enum are with the word 'G'. Replace it with
> more appropriate 'GHZ' for clarity and correctness.
> 
> No functional changes. Only compile tested.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

