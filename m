Return-Path: <linux-wireless+bounces-18476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE8A27E4A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 23:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171DE3A4EED
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44B021B185;
	Tue,  4 Feb 2025 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPpqvyZG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F621B1AB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738708204; cv=none; b=XYfn+cHbaAY7sBprGo+FwuEsNO4kLbXR/mwF79/h2gCmNsFu66j1/OMyqwM+vFRycs2akaeCpKUxaC1CBwd8ZSj1zpdWKSkSMSFJO/F8tYphSaV8EUPDnmSyaWkg2surzOTB6nxB368rd4nXDWTW2SjqALxwN61nlcunzF/g8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738708204; c=relaxed/simple;
	bh=Cf4Dgl52Wh0CJGnmrjOsG5obxrx5uGCCJeeffGN3Zvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jA6R3/1H7e+0vq0+tSZqK7ujMcUVEOZgL9T8CMmcdetR793rMBDWq3pTJX8sspRlO04Gpxee6EHIeMzt0TrcVNKQD/I4y0Y9isB4xiTc0oj4xeu/vBam/u+baAFkeRDnp8ak9b8xHnPYC7GaFF1/vi6LNjFj95yYNKXCtlcP5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mPpqvyZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514IwHkU014789
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 22:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NNHZx50E0oAdF81Dys7PSkfk7xthq/gSaPIvplbxxGY=; b=mPpqvyZGF4rW7ghy
	6EHLQA+EVraYL2rJj7UkWBxJleex3jZQmtpJpS5009uMECPh99QLoAONWMEj1FVO
	x2hgOWwQikGglgJxh/Ow9GEBed651NWuZF/7+M5RMX2tLsGRW0aFEbkT/7shjWNO
	H51IN2Ggk/QDj8iXbYCs/U79m1kgZsZS3Irtibe7vYY5wbHpH2zQ2Qu7b1mhh9n4
	mnmiTFOgGSoSDBAgAh8n8Wkf7Y3Loc8aUT0WsbciHjcTCxCXpB/NO/OLBRdtVpfz
	C+oM8SAtFY5tEkldD9k+YPhGxULGrhEkKiYXFb7ju3fLcilEXFfcPFRc6iBWtf1T
	neLyjA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44krmygcxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 22:30:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f0d8b7647so20015715ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 14:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738708200; x=1739313000;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNHZx50E0oAdF81Dys7PSkfk7xthq/gSaPIvplbxxGY=;
        b=hhmz11TMoB4dLEnpVQc9OCyGNkrEgo8e76m09RVJ1qPieiZKxxNVfKphUNXBFrNCg9
         epdLHb57tT5dYMxxiBqvdA+Q9qWVgUJ3iJ2IgVfWgO43/5ppeEByA5tcO8Vx2fy5FSMe
         gWg6l4Ky9aw4joS35l+n21WgwfpfNUTWwfJ94I7DhXmQKjRFt6G8d2JXG0wjBZAP5Lr3
         HjDTVuonQ1Ev/cBcN4I201LyRgOzmu5KuTDJLuDTqtopI/SqAAa/SMe6W2OXVCPC0V/I
         6lVTE+g/S4HBGQFmH/6WuQtN8hbbYsmW7BFl5ScDPdCowOQ9tDNaCKuaaQmJxXTE5d5r
         jipg==
X-Gm-Message-State: AOJu0YzNzkWqvqkYkZYc0SHSNlIkwC9XTGMNsOwr/HkRc/xJuIezJc4q
	K0TUWiEfzxBkF8UoKTnTSMZ+NY8u2Xn2kwV0v8WG2FErtzfFvf32bZqeZX5ebD/Fu5JEtBA4LQu
	/z3Jqzv3C+sE3/nnGVzn32uWFwY6cps/bE4/spaR2uNmCfCibiIA23Z0HMYNf7QfcPg==
X-Gm-Gg: ASbGncsN1mEpb6M/3XyDYA4QKbqyKCCeexdLbJOKvgBHeqZ2dNVl2ka5j/5IuekyjdJ
	6lcE/1LPyhjxFvXVn0MR8ga5F6gTMFvQQgiGCwRu08LLE5ACiCA1K5b9ex2iqpBBHlerCeCakvO
	f22CKWjw29ye9aMN9WifJUws4vP8fsTn4PD5LbZKWgB7U2gs03AE8ZuuGu1OzEyUoNRN2+G/DHo
	ajN/mERjGBZ/EbU41hT4SjMzKV11CMjlEMGI/hErMyK4C7g2Z2q9agsCH8HN8rYx/kOXSnGBs+G
	0P+i5c4A7oWyvUCfqKp95+81V+P/xCiJp1WDv4rfwLTumXf34htkB9Kpk4RQlIR77vERUJWpJw=
	=
X-Received: by 2002:a05:6a21:6e41:b0:1e1:a885:3e21 with SMTP id adf61e73a8af0-1ede8814a98mr861428637.7.1738708199798;
        Tue, 04 Feb 2025 14:29:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFou+uiIKHx6A9HwbAswemIiqgsr9G+zNT75FmH4oHmygoIUW46rpy98BkHvvzCTzyV5NNAw==
X-Received: by 2002:a05:6a21:6e41:b0:1e1:a885:3e21 with SMTP id adf61e73a8af0-1ede8814a98mr861400637.7.1738708199460;
        Tue, 04 Feb 2025 14:29:59 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cebbcsm11292656b3a.130.2025.02.04.14.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 14:29:59 -0800 (PST)
Message-ID: <414ca414-d6a4-4228-acb3-dde4bb71624d@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 14:29:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV
 parsing support
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250204035718.3227726-1-quic_periyasa@quicinc.com>
 <20250204035718.3227726-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250204035718.3227726-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: emUA9HI1VRaE3Qt_9y4pdebU8DzZmhG6
X-Proofpoint-ORIG-GUID: emUA9HI1VRaE3Qt_9y4pdebU8DzZmhG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=898 mlxscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040167

On 2/3/2025 7:57 PM, Karthikeyan Periyasamy wrote:
> Currently, monitor is not enabled. However, in the future, the monitor
> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_U_SIG TLV
> parsing support in monitor Rx path, which help to populate the EHT
> radiotap data.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

Normally your S-O-B should be the last tag. Any tags you collect should come
before it.

