Return-Path: <linux-wireless+bounces-21422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41CA85410
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F117917DC69
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0091EF09C;
	Fri, 11 Apr 2025 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TS5mc+k4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D61367
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352642; cv=none; b=Ay3P2eqDVXj4x4gTchXzdpG2hv2vT/QnZaa+RuqD6rOaZ5FTjRYJNAB7TyEgyMHyNptojWHzcwOskGpzAeMmAEhPeLFEALtyQGSIjsIBJxNThqZWNh005GdSyll8YW+pbla4K+d8stXwYzI+6H+IC7DSOs/IENe85wR2JDq8cnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352642; c=relaxed/simple;
	bh=PplJ7O3Olzr0SKBXmInOezBUYMTbe83VfRKFjn7T0WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E72k6rIUFcEUZx30w7gicXvRRSo27Tm7KYGTtxwQsTDdDwAOZW1FqsEsHGfB4QfzJ/tlmjY00HAoJWH1Pp9dyX18aE2Wsk0yL1vH6bOloU82PWQQPEQENkTvlEOUyEltztHbsuBeLPRwqJ/hnnmdtQlNULx+QwDzys8CGx/IO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TS5mc+k4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B6AdA9032003
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7zcD+oP6GvXt5R/I9S/KcXAmPsCSi6ByG0SKvGfDorM=; b=TS5mc+k4z2bTQ95d
	lPu8Jeu888XdGhqBVmhz1elYZINuZawuS4WL02im0gUk+WedPHKLJYW3YW870jNO
	Hdjhdwe2YBxamXE6G4k0JieDRxp+4S4UoWSw4j2d+UO9+JsAffjxRnRc34Le92F3
	mCRaC80IGuk9U9MPM5UQBSrECEcuoCd31mycK0xSj2E8DmCTc6ikodF7wKDp3OGI
	mbge53Ygpuwm5QOt51Ku4sZgv7frHqwr0ztUzq/H/+6bycbEphhBcSriRY7zsedv
	LTZRIYxW5rJqOjnQzY1C0iM65UDWOBPdtm3C9HO9bMK7KLo6xBxHLVp+TBHO1+OY
	4tlORw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmhaqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:24:00 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736a7d0b82fso1962322b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744352639; x=1744957439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zcD+oP6GvXt5R/I9S/KcXAmPsCSi6ByG0SKvGfDorM=;
        b=D4BuLz1FiFN41OMvJd1NmNwgb/uxxTwiVW5a0C5aRR8Tmyo1dMhhmljyIBoCqTLnU1
         57O/LZFoqOA54Sea1cCzlZq2cqSDt8CGza6hIxK77tLXkt/Pu2o9dI7f6b12nTTgewxi
         iheJUNDQv6+rdlp08Hz0hnvyxEgTOxNAl4PQ97Js/j2uQ0U3q1DkMW996OIR0P3h4ew1
         RmOVgfRzd2qsPUJYYDNIN1dAskkgI1SIQ7uQVaAzmVh4XBe5I6+jpkrcvPIbJ/5mg/lN
         6sIH2Lcu4ubCBvkYFxYjAE5CqyJb4TNbVtSI9d3VVsiH2JH6UqvNPHyG83Qa/LLs6c/H
         7Wrw==
X-Gm-Message-State: AOJu0YxtKinedaAAoJ5EuQUilTUMSpKp+1135jY74XU8ws/hw88VxVBA
	WVk2NPW9OUpatAFX5LQqIbEJ/jwhRLb4HlMCSKPdknWx02UEWvwRd9ONdrPC7mvF/JL0LuhnMMg
	xSKYYkoDmpbihKat++h/wrPla3gtMiQcNmkJhtDD/UXfjpcMX9JEtad7Zd/j+nJFxiw==
X-Gm-Gg: ASbGncv3ApdAfhi90xxg50tiitjbhRljgY+MapiJI2MG1r8uyjipwjCy+fDJC9L0Eix
	/ThA8TqiIBh6VLCR/xaXIBPiWQoikbetogqQzybMsxmpXGzQ5OKXvnonvnufdHNfI3btJFJqvZJ
	RovY2w/VZFhh1/u7RMLx5BQ0PqCJ+EI24A18HnyKMlG1mumvrIa605ny58lu3QSacf1ACPGSTs/
	10xbbjWEh/f325Fd3wvP2wor2HzdS6UuBhcpZTBhYHr4yMQhL4Y3cV+DUKQddJgM6P6cI4oc8H4
	h6ZZIm4zuTxyns4qyymREzMZWALzD5c1MEvsITS9Oj0RUFdOtTt/Iw==
X-Received: by 2002:a05:6a00:18a9:b0:736:3768:6d74 with SMTP id d2e1a72fcca58-73bd11f3e42mr2227956b3a.7.1744352639047;
        Thu, 10 Apr 2025 23:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVfk6/e27wgKqyLLbgLdDuaIDOgW7c2iQyZ9sMb+9PxZtgHGtKsTOcxiEckdElpEFhYypNsw==
X-Received: by 2002:a05:6a00:18a9:b0:736:3768:6d74 with SMTP id d2e1a72fcca58-73bd11f3e42mr2227939b3a.7.1744352638645;
        Thu, 10 Apr 2025 23:23:58 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c62ecsm700849b3a.62.2025.04.10.23.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:23:58 -0700 (PDT)
Message-ID: <e35aadc1-6e03-b688-7d56-e048ebd38bd8@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 11:53:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2 1/2] wifi: ath12k: using msdu end descriptor
 to check for rx multicast packets
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250411061523.859387-1-quic_sarishar@quicinc.com>
 <20250411061523.859387-2-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250411061523.859387-2-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XDbvNM8ZgZrK_m33owTZMi3h-AOjHgsM
X-Proofpoint-ORIG-GUID: XDbvNM8ZgZrK_m33owTZMi3h-AOjHgsM
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f8b580 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=j1rpJKVYEw2CWFf7B6oA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=446 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110044



On 4/11/2025 11:45 AM, Sarika Sharma wrote:
> Currently, the RX multicast broadcast packet check is performed using
> bit 15 from the info6 field of the MPDU start descriptor. This check
> can also be done using bit 9 from the info5 field of the MSDU end
> descriptor. However, in some scenarios multicast bit is not set when
> fetched from MPDU start descriptor.
> Therefore, checking the RX multicast broadcast packet from the MSDU
> end descriptor is more reliable as it is per MSDU.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

