Return-Path: <linux-wireless+bounces-21093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B64D4A7923F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE677A3A52
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296061FC3;
	Wed,  2 Apr 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4QHJivw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6910F9
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608161; cv=none; b=XR8gyGmJ5fn8NEuGZdIg+1qEFHuCwMpCQ0BKbuWvUGcEJ4SVvGM6J7qDfs21bEsAO3xG0Kj4rJwWmJeGSwmnbeesxR8I3IYIJVC6FXCcy2k9j/bFEZpWHlzOu3hIDP8mpAC8rbOz65zfL0PWpNmiJt1pjySCtsImw6ChGoxF9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608161; c=relaxed/simple;
	bh=jClz20EPJQz4hHBN/JKeWfjGOF7LAGouX12Y+egW8j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKnSWIziNj1eNZAueg/vHvdrnnHy2i3Alvx/pAl9wcsCVi3H120cAa39rfDEEZo8/NpXpJpwU1tkzRcun1V7Jly5lGeF86UAJbKFLsnlenp1XGq7xpf2oYrLQftyT7qguIfj0KY2SJvF/CHu1lFO9LwcUP/bPL5TqINK5Iy68d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m4QHJivw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DnPbV008461
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 15:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7cCFCUrQHC5JOqrvRDn37HMRKvypTTEHlrfD0rJZRAk=; b=m4QHJivwBPIOHNLy
	9WzPHeVEyFjmJbwqYDVwhygb8SNLqu4snNMymDHDzlIx7fgRI/JWL7mOesrl7hpx
	kOlhqXUPG8dDfikhb9J3NFi7LqbA4+srH1WEy0T29+mjAtEHZy8m+iL3XMvlmyMU
	Vmr7otsj0ZnY/7Zyb1sSI4BIRG/HuPYTVY5IjEDZC4CudRzd+UI6dZXa+fA8g5h3
	BzFHScH83z++166yAi36ONymirK14WARwxNjGacj2A2aWJk9vQDo0Kb7dJe6hFpT
	g73mh/PxPs+ujb8yAvsqCc+BVIbbuWh9KxDcCEmAQ2/6wAA6xndADj0KNTbn3/Jf
	Kfo1Eg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45r1xnpb60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 15:35:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22410053005so33275265ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743608156; x=1744212956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cCFCUrQHC5JOqrvRDn37HMRKvypTTEHlrfD0rJZRAk=;
        b=BWHjZq8CpIGZErXo28XFzDQP2Ic4pClZnKW2fQRu/nJFxuxatqNKBiF9col5nMpqfP
         uzVIZAJPOmglHu/k/qHM3gB74gJgQ9TdXhsBKwbWVc3gjN1sG+TOIfLNcu+gWerTaZRs
         pMzVgG2dftq8G1R88UmdCpFoovqWh1voStdYdom9b5prcxMiL83KR0jnyIBfFzei61dR
         AYudsxuM8X6oJB0C/Ye+zN04N1dHFwSa/K8CgZhqGOvDeexVKFHPP+F7fLR/rdBlMzjU
         3U4L2kgVyDG782T2BPaxIOU4lN3gG5ScqjREPTKQB65D1HeihaWfcVtdpvxKxCoiKXrI
         crfA==
X-Gm-Message-State: AOJu0YxwuOwC4fZO2XyXZfKh9Oy79z7sZCDdavffdRpBsGFjF5BsOXTp
	I+7hITd5/BGPn0Qbwhm63hb3F+O31YdjGiaRjcFhywkYBhm6WqUkrbrup8d4ewNEtqIOTIicb2Q
	vrDff8asdR7jFjuiFYKzfhfXj1ErmdjVuoHQQuONkOhEw7zf+5njwIR5iQ8g36/SxkFqmUe3GjQ
	==
X-Gm-Gg: ASbGncukwWaJvg2Rz+9RJbXyET4tn1jPxUHq0+d1fwgEpw16vHhHbMzv/DGNAsCNLE9
	TrCUUY31zHB1CN6CgL3V/ZH0xSBN/LpYeLdzg//sL4CbyCRE/BUX2+bSt5XZGEHMHsy28joHR6q
	9lhqzZv3fDueLBES2aFus200RvPQuzorwQf5si3dF5L9xFQ3TPeuptNVEXg9YQNo12ckF7RAxnZ
	EDSDqurbwL71IPsC4CK0Y0W2KT4K5n+xcMzORnb+bxkkWLQp/mUC8v5tPpHzVyxJbg2x5WdaRjZ
	jVzdHlHj+mp/vwZPfgeizpXviiq/9EMO2YxQPcStm5gUALMbzQp5nHAHzpmmaAw=
X-Received: by 2002:a17:902:d548:b0:223:6254:b4ba with SMTP id d9443c01a7336-2292f961fefmr220401325ad.13.1743608156225;
        Wed, 02 Apr 2025 08:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXlf0SUPXiq4h4Kpph5+X3KLRzaw+VTHrDKprYrjJRtQdekEXjhvosj0UnEAz+L/WLG5KlHg==
X-Received: by 2002:a17:902:d548:b0:223:6254:b4ba with SMTP id d9443c01a7336-2292f961fefmr220401105ad.13.1743608155847;
        Wed, 02 Apr 2025 08:35:55 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.201.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedfde5sm109783975ad.78.2025.04.02.08.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 08:35:55 -0700 (PDT)
Message-ID: <13fc2b7b-9810-d4ee-8b8e-f0e44a7d6f6a@oss.qualcomm.com>
Date: Wed, 2 Apr 2025 21:05:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v4 1/3] wifi: ath12k: Fix the enabling of REO
 queue lookup table feature
Content-Language: en-US
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
References: <20250402152529.1649402-1-quic_nithp@quicinc.com>
 <20250402152529.1649402-2-quic_nithp@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250402152529.1649402-2-quic_nithp@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n2MFMW-pvAJ2CtvJBfDu-95R0kx_OE09
X-Proofpoint-ORIG-GUID: n2MFMW-pvAJ2CtvJBfDu-95R0kx_OE09
X-Authority-Analysis: v=2.4 cv=Qv1e3Uyd c=1 sm=1 tr=0 ts=67ed595d cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=HMRESTvIlCqp6qiEfvMpsg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FjUdVDXw5NPAVZ0_mVgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=797 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020099



On 4/2/2025 8:55 PM, Nithyanantham Paramasivam wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Instead of storing the REO queue address inside peer entries, REO
> hardware module prefers them to be stored in SRAM which could be
> directly accessed by REO using peer_ID/TID based lookup table
> mechanism.
> 
> Fix the enabling of the REO queue lookup table(LUT) feature by
> configuring the LUT address information in the REO hardware register
> and setting the host service flags.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

