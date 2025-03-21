Return-Path: <linux-wireless+bounces-20627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67EA6B385
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 05:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EE4664CE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 04:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760619AA63;
	Fri, 21 Mar 2025 04:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZE/JBddu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039DA944
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 04:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529755; cv=none; b=tHMemhPTF1qFbkgJu1gL8QiP0AFDU8FXmEAEehXUSmqdnkjHs6yUBiI1u+mQRHLw1uDWH8tBsoff7S19m4UhnN2ZBnfNF7Aiy8+2s4IzAg/9XHtBkVONuuSTl0MykVD1+vvohLSTsPpLu46nfNuCQq3EC0vz2QQcaC7OseoyjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529755; c=relaxed/simple;
	bh=an+uYG/h/Zdjdhrw5SaB0N2O/kgJT5Z58hGUP7E1tT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLP0rmxEYgC0q/1iIsz+b/VM5qRE5MTFLFHyT4owVtOZL+GeU7S7RogwjmamlKDomopN0qLWaFXawM30AnHfd3HSeO7+dVEL5h268oT0wrQRufBbr5Tuq22hLVCkRAf8aojK4a1KAm2TyYTVhx7W7tK+LpKP/v1sVLz+6mQSgIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZE/JBddu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L1WSh6018729
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 04:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JD18WbhBUdIOb7+GpzfnfouBv5NCmtlMczJlG3+q3Mo=; b=ZE/JBdduxtVkRBDs
	vkFJrV7p105h7NJDggX5RXarzgZFACN0aT/c3JPN7jrgq+d0nuvRqbtUIrFAl1Gf
	I34gmyoJYiwys0DFuiO5QX9Frb1NVxUk+dybLBmLNFhnNK4LT8xt7TRm197prOBW
	nhk5XEtblmJovUDTR5gp8GiZxHBJ/91GeOANSPSimrsS68+bROGrTXq8Ly6+ekO5
	yRa7j3nTQn9rEh7VFZoWegc2Dwu8geVvmpXaw6ZcxiovE71vE2eBp2FsylOnK4GY
	4o/MwykIpvJxALQpsyP2y97G/GuWG4wUjXggZLBShtd2lF/GSH8nK1y6wufTx2p0
	5j2wEA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g09f5bar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 04:02:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2265a09dbfcso40244095ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 21:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742529738; x=1743134538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JD18WbhBUdIOb7+GpzfnfouBv5NCmtlMczJlG3+q3Mo=;
        b=PccwY6Zb+YZDnPMQe1H4rQan+eZRcyQ9PKq0h2+anrqL3rvxVo6CG7OAkWQkx3DzvG
         +uA2jbPPABEwLfas8seMkONeUu1JANWZokrt+w1OVCFHR/3m3Imh7A3USYXgN2PN4nf1
         zTN/jU8U7g1ZKK0lDCk70lNbApC9JX3iZaB+lrCAg3p+aGPa4yW3W0we2+0MoXqEWX4T
         stDqHhETgtZpy3+HmeYdIdUOnLU7om87Qq+XhJD03qBsmh1ZCOPVUFWLVEpv9JSY2wFc
         p9+Def845N+aTFraellJV+UWjgCrl6hNs+FNVZuk8QI3/SaBWDvvFRuSXsxgiR8GR02E
         8wYg==
X-Gm-Message-State: AOJu0Yw/KFKHq1x3r7StI8evXxLgSSJSRpYXheYe+0lkyvaCp+sZZCWo
	cwwAlNhBy8fftRgdnbW793ARFvBBJfah8GhXHAEWIrIEQQsq+cm3Bdtt0yASJEgSwa9bVP/SJWh
	c8t1p0cSkdIcMwbZQeaC2FaN/qtpGIV3gupNkcJeyrvjIu9hRejw5DiKCQLjobpQIxg==
X-Gm-Gg: ASbGncvpk+5+STuc1DybHTKHR1qUU+hyNsHcsV3rfLY9TdBlvCQXB6hl8Fy2Ed2ZcdB
	9LGh/cqx7PnigrywZnb9l8N4dsYeJ9dRhG8e1ECbbr8d0A2RCzyyWdnGRklVvkH47FFfJPOAWmL
	ZmmLN8FqXzqiRvGJOS3l6+uhFFq3UMLI7/iG037Ak0ui+VHSUTS4FY4DWtrdQ/Mj5bPpXSRB3zj
	qgOBq42RrjWsslPoVm4y6jpQHiWwNkmC3PrenuT+PyAF8HSURmytvSDQNkmUIjPMayOlNVn1C0L
	llU/yHalXdNf15be+9wMo22pDovHMlI1eEzCDdTChCRBx28Wq6qmHynuX13PA6Mn
X-Received: by 2002:a17:902:d2d1:b0:224:24d5:f20a with SMTP id d9443c01a7336-22780e231a1mr32879945ad.48.1742529738324;
        Thu, 20 Mar 2025 21:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOORXpSCrIooWpg+Hh0W+iLzidTxU6JhELu6gC9LuhonlQLlvNzNwqYRFOtv+WzcHkmGjgww==
X-Received: by 2002:a17:902:d2d1:b0:224:24d5:f20a with SMTP id d9443c01a7336-22780e231a1mr32879295ad.48.1742529737727;
        Thu, 20 Mar 2025 21:02:17 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.201.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3964bsm6494675ad.32.2025.03.20.21.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 21:02:17 -0700 (PDT)
Message-ID: <34578e55-f537-fe3b-0782-c79ca18b2f8b@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 09:32:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v3] wifi: ath12k: Fix incorrect rates sent to
 firmware
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20250320112426.1956961-1-quic_rdevanat@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250320112426.1956961-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BvKdwZX5 c=1 sm=1 tr=0 ts=67dce4d8 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=13kUIL9uG/hLjppKjZ3b/g==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=YRjURhDjmDyyyRhygVUA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 84rPG4FS7JmlAOSrBperNd4JmOWPOa8T
X-Proofpoint-GUID: 84rPG4FS7JmlAOSrBperNd4JmOWPOa8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_01,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=863 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210026



On 3/20/2025 4:54 PM, Roopni Devanathan wrote:
> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> 
> Before firmware assert, if there is a station interface in the device
> which is not associated with an AP, the basic rates are set to zero.
> Following this, during firmware recovery, when basic rates are zero,
> ath12k driver is sending invalid rate codes, which are negative values,
> to firmware. This results in firmware assert.
> 
> Fix this by checking if rate codes are valid, before sending them
> to the firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

