Return-Path: <linux-wireless+bounces-21588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB398A8AEDC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 06:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795663BD0E2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A611B808;
	Wed, 16 Apr 2025 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KtFBvZ1y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379781DD0F6
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744776945; cv=none; b=oXX6VOqH9ZbWhp0qCBr1LM/n6TvyeAtc6egHse/IboN3mu+F2+I6LPLWr/s7nwD/7N9RKKMzHRVXtPAtOTxZs31qNti6HCDfKxFgHejJhRKC5zU1W3eJYmMRdq8bg8XZlAN0fv3gEuTwHsE6L6uit6pc+PnYb2skKsKw0lqNPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744776945; c=relaxed/simple;
	bh=1Hkweghb0d9I+emcCcQ8TMgPo2v2ikcrbUwdq47ai2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onDMnLw2Vc667b6EXVH7yo+DV2fv29h8v7+U6jUb+cTsh2xt46l/jI3tcxKc0gejGbo7dLDfrybPsH1bNZcMwkK6R10Uq+6AFxmV0W98lOdvbIkOiMs9ivVHye/PZMgOzXH+6K9f0zI7HnWgj4DPObBSvDasaCRYng4QR8NS+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KtFBvZ1y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FIKT6Q025102
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NlVeRCT/HA9mQOyGA1sJmvRkxB5EudIduIEIN3zmjlw=; b=KtFBvZ1y1C24+NZf
	OGKkTg8VhzNHDmujeBxEO5sMKPlv5/8JA8ufH95inITQ8+LBUUqiNVdqvv42h7db
	0Q13LUjWIac8uCszS2h7zrF/lt8S7FNSwsXG8EaDEOOCMmd5Rsf25AKmkL8wf9vv
	Wnpef9xt20yniwz87JBbUEJhZO7E+6JpB9uLWWLMHQBrxqw0K+7VXHkOkQCKikHR
	A2nY3lRbrfuWA55OPCgNiiJuDztUNexDfxuG9v5t3X2Auj9bUP9dYMflZue2J10w
	ylVb2iVqRiJZJS/qeAAQeoC9K6WIRBOy+xE2M2QdfFgvbhQOIwMyyUA3wEhBHU/K
	OWSB0w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wj990-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:15:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224364f2492so51809425ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 21:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744776932; x=1745381732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlVeRCT/HA9mQOyGA1sJmvRkxB5EudIduIEIN3zmjlw=;
        b=NjTY7x2EfJlklITQz+EKmh2qdukvMbO34THpbP5j/baj/+s1qUddcMM/Qc+3h8MV+m
         7AGwduupMyw/QRm0kBUo69Tk6NhQ1gLWMZTrasCs0RcIcg6BFsceTOQG+NJo0i7si/cU
         s/XauQFaIduMIGAl57HAHbZzQL4xoDHRuAScAKNMAHqZB2p4wGkF3+VFO7SiHhcUEEJm
         1cj71xHps9v0jUrFp1Vxosd04kYEZVywPPsKZDDNRksZWVHJ1YSxiLy3iILcUGAid9sD
         FunsajrIAYku0ZXhvO2TqjtXDKRkf1mJdkD51YZCFKBh4CkWBw0sVal5Y1yRpLkHj//B
         nm7A==
X-Gm-Message-State: AOJu0YzIpbfS2vfU9lYB+beN9YqzcGtcIzHNScIDzvWLoj93PpDqbt1l
	CgxpG828+FDJknQHnMYkzKXdJoqRM+zfXxJUho9deo73lVk58Z8cuNOzJ/fE7SYU0emedcHr15h
	BNNVlDADhr2dT/1hjb3Ss249UKJNV6188NESzNDi3iHC69TW630b8IePayIh91XTqww==
X-Gm-Gg: ASbGnctAFBFuifqTEEQbyI2MP3IWGy0ItFrIDZIbpj4Ty9NmjiBr+nF675gX+LaF1RC
	91l7Dva/fYwXSA1EPe326tVQSosh66u/r7Z45KGLF1eFy4U7XG0F2hIF7IiLS+ZTkeoOXbA7REW
	oLxumU6atG5JvHs7h7J8cAjlzAkpXaeQ+Gz6/JJjlrHuS8+mjtq88BXMnDk7Jq7hKUA4tuD9KWZ
	+2ZUreKgfyiHczqnmDDxuNP6KMDF/cPTSgDvcoVj3Uk8s5OW1LY82yUGlvP6ExNi/Zji95IDnyJ
	HoAYXKlezDLwlPYeYfix6ZKFz6+JorgtVleMUHWX4SAHdcP+ncC5cQ==
X-Received: by 2002:a17:902:d508:b0:225:ac99:ae0d with SMTP id d9443c01a7336-22c358c6242mr6403005ad.10.1744776931851;
        Tue, 15 Apr 2025 21:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNbUcsphdCZulTD41frbm9bdQ26Xj3upjZXGFRDutPmwJby68S/93G28AuRuuGBzA6SCDIxw==
X-Received: by 2002:a17:902:d508:b0:225:ac99:ae0d with SMTP id d9443c01a7336-22c358c6242mr6402795ad.10.1744776931448;
        Tue, 15 Apr 2025 21:15:31 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f120csm9366343b3a.85.2025.04.15.21.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 21:15:31 -0700 (PDT)
Message-ID: <ffffb810-93fb-91b5-0e4a-b48512acd20a@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 09:45:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 3/3] wifi: ath12k: Update frequency range if reg
 rules changes
Content-Language: en-US
To: Rajat Soni <quic_rajson@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
 <20250408042128.720263-4-quic_rajson@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250408042128.720263-4-quic_rajson@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67ff2eed cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=fFU-EB1XsUR2F5_1Te8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: f1vQizS57kvUgH5HLRic9mCTGBeXlRvz
X-Proofpoint-GUID: f1vQizS57kvUgH5HLRic9mCTGBeXlRvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=926 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160033



On 4/8/2025 9:51 AM, Rajat Soni wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> During the hardware register, driver updates the frequency range
> during boot-up. However, if new regulatory rules are applied after
> boot-up, the frequency range remains based on the older rules.
> Since different countries have varying regulatory rules, the
> frequency range can differ. Retaining the frequency range based on
> outdated rules can be misleading.
> 
> Update the frequency range according to the new regulatory rules in
> the function ath12k_regd_update().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

