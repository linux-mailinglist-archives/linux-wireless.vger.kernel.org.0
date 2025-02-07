Return-Path: <linux-wireless+bounces-18631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4EA2C2BD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5E07A721B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8C1E5B80;
	Fri,  7 Feb 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c0M7KmVp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755481E5B71
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931329; cv=none; b=CwbxtgMLz7rCG5x1UisxXBwil0AYBCrWkPa9eHJuDmQDnk8kg6dio4FoI0m/UQkdZwrrGtIypuO9XtJfYmKa1dNdfFfrTceGsLj8bdyW0XJiS1gXMXLREa6woG3ThDyHhFRqVTcHJteRi1q7khU8Btfu5CS5GMzvyzMEKDEWRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931329; c=relaxed/simple;
	bh=lezO3dnXYP5P57rwdKnU/bGkoE4uiwi/mJb+gXdV4zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAhijuR+vNonlB8aLBgPTN/nN6uNkepjZ4Vt4HhskliqLO7JPAmNAwyshqdnNc5zmJVoKSC56I4dj5egKQbzLGmqElKh+prI3qtmop4HoyQW56uz9Q9R5xda8VBPj2Tw7cbmiEV1r6BFMHWLHj+Ui9XmdhrveDngEawDAVRiveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c0M7KmVp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51770ULB030010
	for <linux-wireless@vger.kernel.org>; Fri, 7 Feb 2025 12:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ysuuPyUUK+0epAqbvA1e4WDKKAmXNm8xC4UpLLzT+1I=; b=c0M7KmVpKWb2EApx
	F6av/a02YIyzZeA28gN4PQxdASRXeSsXqQskcjVt/NUqyk7mXs4/chU865oY0vu6
	SXrvmFdOwkI7LhP5VrvYOCA4ikp049f8D37sAWfHd/7QngiJgEXxVmoTAAPCBnkY
	csEWLE0SdlN6rWlsj2I4UxqOjr8CsXIttr+/mvoR1eUMYsg5fg3q2zKrUSGNlOkA
	LtkzznJi1dSwDMWjdBGOR06/BXMZ/s24VgYX6wiKXigZkIkfE0FQuPPC1f4oW/RD
	ZyPKiPZh3JB857tM9lzW1CeR2J5OGm2hYrU7uQEBtV3wBm+4znM42XMfraJQqbS6
	esdOQg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nddjgt9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 12:28:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21dcc9f3c8aso30986045ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 04:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738931325; x=1739536125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysuuPyUUK+0epAqbvA1e4WDKKAmXNm8xC4UpLLzT+1I=;
        b=WsY0Fi4IYlQLULY+XoPJnoR+IJTBe9ZahhKiHl8gSNk8negpI1/hjaoN8+wfhkvlij
         PnX2SKrDGD7P6V8kSx6P2sPR/dybQiggcHIPR4N5Ocxn89ta5bR75Qs5CHOcBk4CSk0A
         lWQuWeuSSDlUfTJREdj3bqhee/InXdIgLbyBsK4x+HaCZYzYUxFCz/J2hxS1kP6l84ae
         pb3NNe5M1mLo8rv4hZUYvymtFNHhllHhKS9b7dJrMpRCM5avAWTTXOrXUeZohm19vmj2
         WT6UT0ELsy9B55LwVa9c2EbcjNdbriOywX+r1G3Apbr+1RI/+p8HsZy7xzYmijI9Db98
         MYvg==
X-Gm-Message-State: AOJu0YzYHkrVvTalFxW7VdLzI8VMsxCvFPIUJr/K19A2AJrlbA2RCYlo
	QwJV1pOPMtBifj96Q1N7hDUfM2Z4kMkQOXtiPSxwmEDoY3EhnuJ4/JmS+MVKnhsH1LkH2hFlaVA
	HK/1VFCZ9zif9JpXEJk6+f79UdOBn9UJeDlTc0d+MrbrZSs3eKZQjpdWh7QB3XtEhUiv1M2LhOA
	==
X-Gm-Gg: ASbGncv/b3LbPokMcna9lNGKsrtgfwIqUZyAu97AQY5cL9WknH/9PGDan/wyThKOClV
	GcVi/Rv0qe9AlgFaJcXIfXfdh/gBpl/9iZ7Zo50Ad6T3UTaBM6x2r3ptc5e30cZ6OVderk4sUgc
	fWTCrPIdKaAykPbIBhR1ZCst1UZUbMRPKuERti3l1Z6dinkY3AyBGfIyL/rWX7nDjNZMppbTgm5
	Q9cPitSnW+seqBBGQ/R6V1J2iKVoPaO/A/kcpG5cxmg8CclJV1JR6lZ1cIpEycJAQeCFgJfNlBs
	U3eAro3aMW700xJLBqoLr0aCVQUFCB6p+KhYOC7URKwwRNNH5/WTXg==
X-Received: by 2002:a05:6a20:c705:b0:1e1:a0b6:9861 with SMTP id adf61e73a8af0-1ee03a3d16fmr5318880637.12.1738931325248;
        Fri, 07 Feb 2025 04:28:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwq2PgMFum5JkNjGwJN4Ri6j1kKhv1CFdvYxi3UKKeJkwlDtfymX+g9idDLXGWUnY6tIz/Rw==
X-Received: by 2002:a05:6a20:c705:b0:1e1:a0b6:9861 with SMTP id adf61e73a8af0-1ee03a3d16fmr5318860637.12.1738931324929;
        Fri, 07 Feb 2025 04:28:44 -0800 (PST)
Received: from [192.168.225.142] ([157.48.120.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d282sm2859151b3a.6.2025.02.07.04.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 04:28:44 -0800 (PST)
Message-ID: <68712744-837d-ceb8-e7de-6d1cdb14c998@oss.qualcomm.com>
Date: Fri, 7 Feb 2025 17:58:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] wifi: ath12k: Enable MLO setup ready and teardown
 commands for single split-phy device
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
 <20250207050327.360987-2-quic_aarasahu@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250207050327.360987-2-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WD-KVGnRLztW9kWvvDv6rLGhEcZTzUxb
X-Proofpoint-GUID: WD-KVGnRLztW9kWvvDv6rLGhEcZTzUxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=987 priorityscore=1501 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070096



On 2/7/2025 10:33 AM, Aaradhana Sahu wrote:
> When multi-link operation(MLO) is enabled through follow-up patches in
> the single split-phy device, the firmware expects hardware links
> (hw_links) information from the driver.
> 
> If driver does not send WMI multi-link setup and ready command to the
> firmware during MLO setup for single split-phy device, the firmware will
> be unaware of the hw_links component of the multi-link operation. This may
> lead to firmware assert during multi-link association.
> 
> Therefore, enable WMI setup, ready and teardown commands for single
> split-phy PCI device.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

