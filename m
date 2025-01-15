Return-Path: <linux-wireless+bounces-17570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65652A12C19
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 20:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896F8165471
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0521D86C3;
	Wed, 15 Jan 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VgqTkLrY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE041D6199
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971000; cv=none; b=nvfbwxrUyMWyJeT9hb+9nD5dmZ4tHlZjM0yMYYAHuUrnNMDyetoWrH1u39dqm1TvTPvAIfhyh5iOA4Po2yCBtOWRdYsIzQ2X8bEhx/xrdCRtaMwzYtBwdXVIXeS6mckgS3gZvnncmDSHJwVS9bOeu2quoFoT4C/oP/UAhApxCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971000; c=relaxed/simple;
	bh=MBxgq+fF3Bf8Sfv2pMTGZqiJego5AOQip+s0k40bE6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chLMXDNHvlavIgwJlGA5b5NmhE4C/aclgr9+6YYuQRU+8imx2OEfxHI+o+9Rc7JnGDCfNH0HTn3z26j1y/WKSKlmcfMW7N33dZnVzTvW8GeRy9Edhyzoaye9gkrhBwr8ujmr1COAeyxjCTIqWP5kSO2aDYcV8cKk82WWu//cNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VgqTkLrY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FGoOLZ030506
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 19:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MBxgq+fF3Bf8Sfv2pMTGZqiJego5AOQip+s0k40bE6w=; b=VgqTkLrYnUqxkq7a
	QS/+iCw568w9SP1VwKtEjLyy7f7MFvwzscEtbkaNZ/hC5DQcaWdsNx2igLAJrHZ9
	eHYbQML+dfu+eKbTGTT/RGNzSn64Bos6jeDuLLveu+COEmGyJPzFP45pJrAB2gk3
	Vb3AJKXyW/R6ciPLEtBLTtS5qWHZHj4IpBsKXfN12xK2IMXzAEOOa/JLUtQSlmJ5
	WosjWgrqAHGtW3cE7DbWpFgOU683fAJkIIUejwzAwJlynHb+sJRIRXr+TsiE7nuX
	1xf+5TA3qar15qBuua8k+9dbNq+y0fc5nzxUXv4jYxi0JnQ0vQcOVOt5DTEdhXeL
	9r0KMQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446fgm0npk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 19:56:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216430a88b0so1403625ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 11:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736970996; x=1737575796;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBxgq+fF3Bf8Sfv2pMTGZqiJego5AOQip+s0k40bE6w=;
        b=JRwICbrP0C+Gs0qjvD8tPuYOWlRm6WH2SvoMGWCSnr3qITyRemumZdcKujkaGMLKba
         67YTnGaFqrJ4subqRS2IQQ/t86m/Z205TWhcAro+NrogcxUV15ndGDK1ENeVZ9cZErSM
         J3xpqJt2luGIUhYCgYX6XNHCiq//qVTYn+eZhLtr81OIp9z7aImeP96f85cZGhrr7hsn
         1zLvblfbJEEe3IRVJnSI9+862VLGsZ+/b9GJtvQ4gisgWNImmqdB1dqvrJWWPP7trQKC
         8Ghj2nVJlSwtydm46eNXQQJ05m53tOcUtlZVb7S7M4yypPP0nSznmv/DvdP5aHrLI/g0
         J26Q==
X-Gm-Message-State: AOJu0YyRfbVzC7Lb6hF5Oz4NeX1mSS+Oge7iOs+orT6+eEktkFhaw1M2
	71m1takSmX/mMQMAy/lzjltjHEPFnKcWmeVKct0PJ3DfWMbAEeoRUlwKy4grJ1k++66zhLPGBJL
	vjCWfwSEoR6aqupLnIrMToSsLVhl8YMvUUpGbRokYKFQxc2QdKUcue/ussi1OXPStLg==
X-Gm-Gg: ASbGncv9ZolU3ECmXOXUTGhFnHxApWlzwAZcfJuyHWGMUmYXVrLwkeOSiETycyCZLiS
	B8d+28+ZKKVwNn956f4wmnONJukopPwY1Cs9KSwYHD2ERQ6Wm9cIMkgSFTEXRiqnl+QoaIalu9C
	UOQrlr8q9cgOfChWEwK4gqgXggRH1ZATQnhgcyQvjR1vhHMo7koFmndCZsfkSOWEMZsJ0LzCp5/
	Qku9jm5UJvPnyv+uuAwLTi8tRvjlxxznz9jEaeCLhdk52LfBe0yEf4CtHrEav1adW+0+o9kvYy+
	l04NOz25WUwMI1Kbl90LaSOEuRzHdo0FxT/m
X-Received: by 2002:a17:902:c94f:b0:21a:874e:8adf with SMTP id d9443c01a7336-21a874e8c72mr434838285ad.45.1736970996163;
        Wed, 15 Jan 2025 11:56:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeTR2FRj8Xbv1MavBnjJoyI+eD1M3/x5bpuMpqPWpDV3KQidnFCBBEf0x8ksBK0i5ww8nFUA==
X-Received: by 2002:a17:902:c94f:b0:21a:874e:8adf with SMTP id d9443c01a7336-21a874e8c72mr434836925ad.45.1736970994463;
        Wed, 15 Jan 2025 11:56:34 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07ccd6sm10128090a12.8.2025.01.15.11.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 11:56:34 -0800 (PST)
Message-ID: <247ad29a-8c54-4046-8e75-8435c2addf75@oss.qualcomm.com>
Date: Wed, 15 Jan 2025 11:56:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] wifi: ath12k: Add monitor interface support on
 QCN9274
To: Nicolas Escande <nico.escande@gmail.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
 <D72U91ZG2PNM.2IXUT304LMEC0@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <D72U91ZG2PNM.2IXUT304LMEC0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WfgxiTT-3NW2kSAM11hF1WNj6CWh-ljy
X-Proofpoint-ORIG-GUID: WfgxiTT-3NW2kSAM11hF1WNj6CWh-ljy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=956 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150145

On 1/15/2025 9:55 AM, Nicolas Escande wrote:
> This is on split-phy QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

I don't know if it will help, but I just pushed out

new firmware WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1:
https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/commit/a289ab4de56345be86d2c89c81aa12577c2c5a30

new board file:
https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/commit/bd2ca865d78f3d7d899e06cef57e5bbb9da60bf7



