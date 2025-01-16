Return-Path: <linux-wireless+bounces-17576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F5CA12FF7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 01:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB331888A03
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 00:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E070171D2;
	Thu, 16 Jan 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OBgdv22F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D818641
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987496; cv=none; b=I6JEZWv1lVDTpf3UYhcYBfpRsG1kzZrZWYg+218HQB4dKJiuo79cDKQUkRw9HtxIT27Ubu8XI9XNz9PXAyrcENvI5ugtRGmCfOEeS/kU9QDtSk0PIzfoy1xzT+TtPjVkmJBPOkIa8u98JyHcAn8FenGifxhAwX7/NKrbmR/iBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987496; c=relaxed/simple;
	bh=QRmzKWCW2ySv0aY2QlbLw9Ky05fKweLLfoDH10fEVRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBraUDGgOgyALWjbyLuciDzJ2hRSEr3fB61cit67avl/ZUrVwPnxZPUiJNhgteuD2GVVflVoJHsUKH3w57DFGHPuAK1zR4Pk90Sli05hO1zrBlVLPVFuD/+sKH1AuzgP6HHlUaN7jcVHXe6FNuj3+H99QjTmED4wzTbC5k7wppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OBgdv22F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FGnDvw023754
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 00:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24nISJijUcfm1DaU1riZNqU7FdKoSISIyL0HILrjnYI=; b=OBgdv22FRf6desKf
	bbMT6wLKlsP0a1++ScyguuS9t/8XAw7QoGZChs+i4k0y0QZ7YIqsEHoOXQM5pE7V
	VcP2QIIR/NaiUiK7215EBAsSdOGhwQDC0ImgFCTXcVysUqAhREP+UVFZZgGM9ST3
	ijUSOvGIKyWZDnU3MKoxsXLA6KmyK2WE3WJ/pMd8SOMTnTmjvFVG4RiaAeNtHodL
	FYXQzC8Q80dAsKjsAIcKBe5cKo2QRv45Nngmc93lEkr6LOIggTor/w0//8eFgQ7t
	MDRYjGhBdUwtbxrccluNOnKcOK6PMCpG+JkotyWkgjjhk6QDFDprEOnukww1ctci
	0XcwYw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446fpch4tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 00:31:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21638389f63so4289955ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 16:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987493; x=1737592293;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24nISJijUcfm1DaU1riZNqU7FdKoSISIyL0HILrjnYI=;
        b=lgpBWHvD4vd5rOKx6E/fmJmOZePirx9IEvDs1qHbANUih6gpcmnJZq+NY1Ui/OaKWB
         z75M4oOnaRj6Z3NWfO/VcvqQtlCw695SRcOy1q85q7gxkaJWWcSBuPFID3MKzCuRXTM7
         6tBBdk0+l8b8njo8DWc0RxLE1oNkK4fpPcpvaE3lRsLCIUL9QuWbj/6PSGjYn1mLo5Ih
         78BozYw1fxkgkLkxINFFLgytrO8cqUXhU2OhI8F3KSCnaBLtPsf8BhuWvydUXaWAtXuG
         wEHsvFikOAjW5pkSpg16OcfgLbFAvclTFi8/f0MbVinFTh/F2/DrrMG9gzkvkwMlMQp1
         VSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL0L7k9yOBskYRi0laC34HM/f44wl/yArfAmUtQt7qK42w+51KG4sR5AiPE4NfQX5rN4XaDmH2lATQeV65Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvEiuwkezAmYF6OaLPs3gsE31w6FhOkfk8bUwwemSzwhJydzxj
	7WvCqp8K3ReIEcIOLBrk5ejsC/ICgBSbmvOHXWjA0m16GWwV2FPKVDK14cKwGmUPBdkQ2RRGbat
	OUTHIXdPNN1t05mvtKniI72ehmmNLyBcaMqv0NFRjkeOhw9hSigzw8iKO3ApJNBINzQ==
X-Gm-Gg: ASbGncvP/waP+OtCYjqFJx+mdrjiGSusIycl/QbaBqNqGrK5kJ8CFm7xd6QgM0tlloT
	nvGW4/NhJZacLDspPoQrQKWl75I0QHkOenOJeVxL0OoXoKCts1Tzku+uqpTfPWAA+aLxec9wBze
	J8ku9RNvFS5ljDcCBpTcFwBHBXvrGZ1VZwTtLaw5xaHixTpN+ImKTFqpJf4SLHiv860GJWlJtV8
	2bTf/OVu5lrYAbRq6mwCLzbSNNMhb7OF7QdtkyAnGmgAwEi1oewydwCjmrX0wCBcJe3pQmv/ojF
	KRLkihaep89vpn32jW08UiH+4kFersJ6StvP4c5oKscy1Lyzqg==
X-Received: by 2002:a17:902:ebcc:b0:216:73a5:ea16 with SMTP id d9443c01a7336-21a83f4c84fmr481845955ad.21.1736987492661;
        Wed, 15 Jan 2025 16:31:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDDEx2z8NZI67rabI9agp2qZu2Vs1vvK01ocV4Ucfq3ZanE9qLVvrZo18SctGSEIfpAacFaQ==
X-Received: by 2002:a17:902:ebcc:b0:216:73a5:ea16 with SMTP id d9443c01a7336-21a83f4c84fmr481845545ad.21.1736987492221;
        Wed, 15 Jan 2025 16:31:32 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d13fsm87506545ad.188.2025.01.15.16.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 16:31:31 -0800 (PST)
Message-ID: <748a5a75-1385-4691-85c1-e9cc5eb4ffc2@oss.qualcomm.com>
Date: Wed, 15 Jan 2025 16:31:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, quic_yuzha@quicinc.com
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        quic_cjhuang@quicinc.com, vbenes@redhat.com
References: <d410576f-2fc7-4de1-af51-29fbe8b14948@quicinc.com>
 <20250115130359.138890-1-jtornosm@redhat.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250115130359.138890-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZjcduaXwZOctgbLbhvS4-UQ7H_s42rkW
X-Proofpoint-ORIG-GUID: ZjcduaXwZOctgbLbhvS4-UQ7H_s42rkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_10,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160001

On 1/15/2025 5:03 AM, Jose Ignacio Tornos Martinez wrote:
> Hello Yuriy,
> 
> Thank you for the information.
> My platform, as you said, is just wcn6855 hw2.1, but using NetworkManager
> with the default configuration.
> If this is the only stopper, you can skip and not consider as a wrong case,
> because (sorry for repeating) it is just a matter of the number of available
> resources that can be adjusted after some research from us.
> 
> Thanks
> 
> Best regards
> Jose Ignacio

Thanks,

I was hesitant to take Yuriv's patch since your problem was not fixed. But I
guess you are already broken with the current code, so I'll take his patch,
and then we can work on fixing any other issues from there.

Kalle, can you review? You currently have this deferred in patchwork:
https://patchwork.kernel.org/project/linux-wireless/patch/20240829064420.3074140-1-quic_yuzha@quicinc.com/

/jeff


