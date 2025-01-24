Return-Path: <linux-wireless+bounces-17901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BFCA1B394
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 11:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C723D1886FB2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5011CDA04;
	Fri, 24 Jan 2025 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aOfrJOqm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4691CDA01
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714975; cv=none; b=kxzzuOgC/CMluLi9K0edghYZR2XATT6dPOJQe9D1NCsUx3BxYAhPFgkQH2rPgfmbe3FXNu6hjrZLPxkODVh1F8XdUXoWuvgrmXIpnkpCsQadWkDW+Tt5EfdH6esm+FZvo7X2MudNDXcXN3n8p+fxbp+KY6cNnADPa4N3casYPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714975; c=relaxed/simple;
	bh=oITfbcyNzwRs7B7Q5Em0NLeIkaGT4Dojhc4Hxf2gUaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSmXRTs3rqeG/iJ8XKPN9sPBZzaJY1MRNr16ByAn/dGbs4L5TCJuOifNE5AFvTECjLkh4VpDvyckv8JswRjgovya5dpbCYlqKWSjB8UG3XOjqobHUcCivWY+JJCVKwWneuzn6TtK7LN0LH0YW6cECti6lB9804aPNH6IHuDrW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aOfrJOqm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O3ImDY027174
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 10:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6uGGIdlXXldRtFwWbGzDvOc99qkYb2v0wFM5jLExT9I=; b=aOfrJOqmIdO1XdRH
	kDXtDzAgjiFiNCoC1NsisokOtcbacpOMPEhth8f1/5uM42cu15X055L0lukfoSSz
	X5uLUhsLDwC1j8u0miAyWarmClcI+IOTk9JZgo5B31z638O32LpaEEWTVn9po142
	FOEuQVZmHbqePwYjQN0s0L6rJERgTMY1uP7+LGAVdQYHjlRvykKiC42BzXRHC5xs
	VwZCHQGksOWVfDcL+0GUR/MqI6gtRzpMgcLQcBjzjfcjMbI3SXVgQoCtb2RnXRww
	fxsAKhdRGdTCO2Ip3evYQ6AB71xg+BJHmPn+6PR3+Vmwr7EJSO0zy7rEmGobkpmm
	9VLRTQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c2uj91q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 10:36:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so4127888a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 02:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737714972; x=1738319772;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uGGIdlXXldRtFwWbGzDvOc99qkYb2v0wFM5jLExT9I=;
        b=fgz5hBXbrs1ZPT/7HDZS+tMe40FjurPIIT6PHQJi0diEI/9/q2ed9saCZcMOuC+2rZ
         uC5yRKVHUGSQPohfzyazuSltcTtl1+GoGkHIjjU1gAcD2pjpsfPk84dJ3VXeFMdtqIi2
         Gj4Ba9lpfThr0QQR6FtkZ5ptTDvcCLMngP04hwOhwuJosToDusqCZOAYq/FTuyCNti0G
         C97F2RyTLfcxyyHglBCknWZZyWGU6sB/CPuMqjERljXPIw4Au1yKpJ20BajwdMNdGAfn
         Z+08obTCjWkgOSS24nrW5oHzxQy2P9mGkjvxflytmgSOKPaQRiCNF4Oo71AdYKolhb6D
         7Jrg==
X-Gm-Message-State: AOJu0Yxxe5yau/8KLdErlPblUtgz+I/R7qMTN2hOMobewCFbKcuefov2
	ADqu6DbYDy7Bqgg8FdFdFUEwwafCEJwuRImHVTPzZV3Aq2ObRCZ8cwknh+/EBeVrvnNq/rHslth
	RJ8YQQvwS/BspIa5/UjQGqj8i4TL84+fzBP2A0J6LMz+ztQmfcuNPxIshBSPbDNGPouPKh/RoQA
	==
X-Gm-Gg: ASbGncvz/jKF99xvu/tlcoKNezWJqmDBEZHtRqYZ9DOIRPUcA9mroAAPsK1eY6+gVRQ
	pPEqNv8XJJh3T/jbExlPAZ1/IS26itBtXZbGkdwAvfeO75gOUiFi9e9bocQ1UFMNGd9TrIO/hN9
	xMG2LMGtstFm0sSLuEO+nlKF909I3aijzKDUP4IkNgx3IcKi3rbRm02EO+RERSs7wAtal/z42ck
	V11MtF5OfLaqfuunPK2kUCwfB7b0+Ts/3M/g8i5TM4//Nx+/JWbSXfp3ghXSBa60VgQK9tGVAzI
	WRhuuAnPl61zTsoge9hA5RWxZWE3
X-Received: by 2002:a05:6a00:4085:b0:72d:8d98:c256 with SMTP id d2e1a72fcca58-72daf945d6dmr40816774b3a.6.1737714971722;
        Fri, 24 Jan 2025 02:36:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsJ2btK7ALifFinqP3IJ+s5UmpKuFPTgyA1L0BdCWIQ+RzjQUpPrO/7uP19boOYwhg7kbo3g==
X-Received: by 2002:a05:6a00:4085:b0:72d:8d98:c256 with SMTP id d2e1a72fcca58-72daf945d6dmr40816755b3a.6.1737714971352;
        Fri, 24 Jan 2025 02:36:11 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c816sm1550749b3a.149.2025.01.24.02.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 02:36:11 -0800 (PST)
Message-ID: <9dd584c1-3fb5-4528-9171-45f94690c187@oss.qualcomm.com>
Date: Fri, 24 Jan 2025 16:06:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Abort scan before removing link interface
 to prevent duplicate deletion
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124093352.481-1-quic_lingbok@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250124093352.481-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZNksdBLjxjReJpSy6zpEq0eHCG1huEIO
X-Proofpoint-GUID: ZNksdBLjxjReJpSy6zpEq0eHCG1huEIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240076

On 1/24/25 15:03, Lingbo Kong wrote:
> Currently, when ath12k performs the remove link interface operation, if
> there is an ongoing scan operation on the arvif, ath12k may execute the
> remove link interface operation multiple times on the same arvif. This
> occurs because, during the remove link operation, if a scan operation is
> present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
> from the firmware. Upon receiving this event, ath12k will continue to
> execute the ath12k_scan_vdev_clean_work() function, performing the remove
> link interface operation on the same arvif again.
> 
> To address this issue, before executing the remove link interface
> operation, ath12k needs to check if there is an ongoing scan operation on
> the current arvif. If such an operation exists, it should be aborted.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong<quic_lingbok@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

