Return-Path: <linux-wireless+bounces-21612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61CA9125F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199AE189F77E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F4B19ABC6;
	Thu, 17 Apr 2025 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LNWy3jej"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38477E1
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865233; cv=none; b=XH+LEqA8ft50p1ugTYZKAxkR8+4a72Q+Z/kva/M+S/o6lARojvmiSnInHQNKo2KoYvsDNBAzk23mADbMdHTHMj+4KBAvnlAgDPDnTDPTVyBHELnQ+e8K7C/6bBUm9pxy0YjarLM9zADBfOW47DJlNXIq03T5RCqnYIs6cCyEZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865233; c=relaxed/simple;
	bh=wT57qYhwYXZPr97BIglla160CwoX1pNurAgpyJED69w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8OqX2OvPRC1TJXh+SmnoZPws9XQA5JtaYWUaFsm7FU6RwZkodrm5IAihd8c5XIMhfls6P6TSjaFsh6L58F7ck2bpoK6b7aV2QLmHBUx9o9B3I4E3UCd82c43/fQFxxkE76kYAuan9ddCl8jrmb6rt9eQ13xLC39IPzcRb5Gkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LNWy3jej; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLk6nL020618
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nFlHoIzjupgDoxTjH+cWDayJFNrjdRDpixbHZDBCe4k=; b=LNWy3jej/zVVTSdT
	WeG89fV/k9+B7FcwIVzAtC+MAy6HhoCOj8FiuPMWEV33JZkpGGKeBgcqeGu6vnIa
	QiTkDDdmfDvzwnAD/VDxrVw5lVjnKU+0cy7npGbvq6R7LWOif9qdfULozMIk0WDJ
	iU6NI1fvJ1a8cjWq9uUyW4oSt8ZKhKyOesrnn7Q/8r68pRb5BaBBtTO2qBpqj4v9
	Zh5IcaNxQ1djGl69QsHkmKb332nUqp6u77OKmw9Cg5CBrBBilpFaWNTXINcRJzAJ
	6JlNKghYNcgXWl8bagtQi1J7ZgQ35kTJ1onEItssAIKTKHUo/nsQ74i5vFhr+c+8
	hpPfVg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wnp3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:47:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af96cdd7f5bso254863a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 21:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744865228; x=1745470028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFlHoIzjupgDoxTjH+cWDayJFNrjdRDpixbHZDBCe4k=;
        b=SMwEjc4zEx8EH1AOY3JQloWYeV4pjxNa9zSmev8x0382MdTa80eQ10tP6OaC9vgZ9X
         NVbqt1NtTDSKzDuwq6vbn9EIC4+PzAs3hQ2su5ymNeDy1UW1qpq+h4CpYrQsRflvgN+C
         ij9bIgsFJu/KcKhGDbQDuvv2FoHCirQxqBNFe+20Hi3trMXHGqBgH9yCTHGKiuwoopfP
         QIR4kDGQH7mh2s/JHAz6c4JqvX51FoXSZXJ8yssxJtVvyPHv2E1u6XG3E+eMUE2O15ja
         3uAhgGebGXyHI8DuVjeXdrDb55DYiIfX2IDUAZ4Iq73Euz8rxUdRtv1aBlaMT5U3rWI1
         EYEw==
X-Gm-Message-State: AOJu0YxNjW1mRgafgakDiJm7oOJcUHqgm+S4CKmYpr9f3Mtap6ySKAA/
	xtTSGxQySWcWhf3OkAIuEIUJYi6O+tBUyoT42Wa4+FFirE7diGsadzOAnFNknuccv65rvGd2n7+
	FsfIgiWNjCPqMR+qrsWX60XqJVli3K6yIaVvgGB0IiSfzO+jHq6JVVwO9JiomfvHX5w==
X-Gm-Gg: ASbGncs3mA7pD3QNqyxcM6e90+LbTCYvamUgqWBEBuzc5dZWr/Ms0w8A/TVY6RGZuN4
	E8Qb0fK0gVwjfaA3CMO0ydu61XVOAj+Rqf/dX32cfLyyB0MRSPY93ztGq6/hp7hxITJ9haYRTYW
	ac2EBfScYG1izZ4cK/7dmWMjgnwoqiGPtIxGXgaWnJAVhOnpjO+XLbR6iMsbC+/w5Ljqy4LWPPe
	E4L+GBtwbwLAu90eBFKvS/thffmI+0e53n5O8OQjSWAo86EhPuF3qbinhhjkEZNUnxjvvAnDW0q
	jAPLFMMO7Jevwsppq5ymEug0fJUylmiIpBDSpE5zswmXLhLplJvHxA==
X-Received: by 2002:a17:90b:520a:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-3086416f4dbmr6641867a91.29.1744865228264;
        Wed, 16 Apr 2025 21:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS8HqQgRJJ+ClcJyzwKwU9DqAukD1WSTXYMhVy8bq7bnit/LMG8kH73H2ihwINMxe0cy69Zw==
X-Received: by 2002:a17:90b:520a:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-3086416f4dbmr6641853a91.29.1744865227955;
        Wed, 16 Apr 2025 21:47:07 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861365f2asm2590782a91.45.2025.04.16.21.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 21:47:07 -0700 (PDT)
Message-ID: <e9db4da3-136b-3c70-0ff9-feeea08d409d@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 10:17:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix the QoS control field offset
 to build QoS header
Content-Language: en-US
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
References: <20250415184102.2707300-1-nithyanantham.paramasivam@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250415184102.2707300-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=680087cd cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=a1qPrsHmoJbHl_s4WroA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: IMlfz3dETbKIlZ1kKDkYyUBx7yee4wIc
X-Proofpoint-GUID: IMlfz3dETbKIlZ1kKDkYyUBx7yee4wIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=431 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170034



On 4/16/2025 12:11 AM, Nithyanantham Paramasivam wrote:
> From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> 
> Currently, in the mac80211 layer, received EAPOL packets are dropped
> when the HT control field is present in the QoS header. This issue
> arises due to an incorrect QoS control field offset used to build
> the QoS header in the MSDU data, leading to a corrupted header in the
> mac80211 layer. This issue also applies to other frames that contain
> the QoS control field, such as QoS data or Null frames. To resolve
> this, use ieee80211_get_qos_ctl() to obtain the correct QoS control
> offset from the MSDU data. Additionally, ensure the QoS control header
> is copied in little-endian format within the MSDU data.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

