Return-Path: <linux-wireless+bounces-18783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB01A3134C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140483A4736
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 17:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6B26156B;
	Tue, 11 Feb 2025 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duOG5LTc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E311FAC34
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295753; cv=none; b=aJitHieLVpEu7jicTkBudXKFZ0e9H5DyRvQMXsqwJROPvdQqRs78x5SDbzx6QPPp5z8W+x5qnHQRhGqYwXP9aYrM+KWaaqzOjr8JHCJ4lFZroEV6vXYYpy5Pi/WsO06SGzn6QiHdpySJDv1LcpvVQYqnFya+ceFNswhtB/FgUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295753; c=relaxed/simple;
	bh=sqW1qjjqE9YiD+z4iayFejgv/90auHAAcTCNspndXww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kg0xfAZVOo84+mn5K2c9MnkjRUo7mcxDacOrA0Hb4yhAMXPZAv9bEnQP9Fj/pWoUAuCljrnsbEzTqjz6Rkel2opOgPZTNLf70VaDqjRPqaEwjGBHTuz+yOP8gCWnf+n719aU0gmm1/YdH0AyjeUdcndCsBmsUieBXfX8IJvIxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duOG5LTc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BBHjKF025864
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 17:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vIbwzt88IOlIM7ovEob9ysi+vR63JxcMQw0JjrVkxNc=; b=duOG5LTccppb7HwB
	Ndls1LQwjK1r1KEE9yMJLSYc43cwbqyTIN2GLsUNsH81lsz3BVfAVeocVduZnKKQ
	VUUZYaDEjr/lXH8yqR4Qwqtap5y0yu9+V+FH76UlJNQ6BlRrr4374/slEoAmtHQz
	qlcZ1rcaKgNrlOsZ8/7tm19ujlefIps4nlegbJwnFeoX94ScqpRByokg4hBA5Xfn
	wCe/1Us1tH1X9Q6RMWfxLMjsmC2nazcJsx9FsAb8uDEJloLYaZDg38nLpwfXKjat
	jTVlzuUGQTAemNNyo1zR6P3+xd5qxs9sonBisLUxl7tfPTcrBg73zg50bBONJMkl
	92OTPg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j593u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 17:42:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fa38f90e4dso11862718a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 09:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295749; x=1739900549;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIbwzt88IOlIM7ovEob9ysi+vR63JxcMQw0JjrVkxNc=;
        b=wkkxi/KjoIOpLAwm6E86X3Bt+UOaXOk5ZP28kHhj7TXHUazMYBBoF1WfVGvrQmPBsj
         /2n68A5KQwS+pQDZTzY9v6x5ZnYHBldC8I8IWo+lpA6EEIGu58wg2khjuAESluTDOcEy
         GjlfzXh7LieSAXvEx1vj586+sEoyzCAwvw3HAW0H48ql5OTiyzcDnJfXu7s5AncTUxPd
         dH3BPrnvODMM0o9z7F15dBbhRK+Q+ZyvH5sFGbql6wtio8U129CGxXBh4r9H5ozQGW8u
         /KFvuoYm9QrZilBhRlU8NA+HLZdBbopnwXhW2vLwkn0qHnnXleTcGj+5zW/QNPMQAMCv
         xnbw==
X-Gm-Message-State: AOJu0Yx6jHR2r9eDTQJR4GKWfLXpFIo6PmJ7+BjSVTXbFQwIdra2KpuL
	aOM/Nisi0fpR+ABnhbLSyIYZZyVgbCSDBL4NlGlRUciAy5BmeeKhPq9a5Wgv83qTLnGjpyv2YPy
	Fpxj42BJKcI8Wzop8mPgGuCAFkAegcYBwwWw3+Aweuhs5/7JhSUP9PElCmaWumzfKHNpj2KSiMw
	==
X-Gm-Gg: ASbGnculQ+tVDT9FjX7tpcyDHyG8/Xwq1kV54kfVbF/LcWiTr5/71NCc5uPR4NHQHFb
	AqMmjrJVe/mXpfldUsq74DlPMUsEPQAq1JRNRegcArdEy1PS/P1pIrDAC+aEcFb5Jdj5xLc0e08
	8TRCgbAQqHH7H1DwPK90mqp+XnHfAj0Yth9xPuy5jk61zLGFOLrx3Gbfo7eVo1+3C1n3lX0JRvr
	vN3yRnjjx9ETmrRmnOUI1zG7yaZcbCiuwvM1BYy2pNd9RLWc/NiPYRuIChXYVYO+MJYmhcU/XjR
	r5dsGq7LFoMqDfqKBc4AzvcLk5hSJZGMGs02PQaRZZY2crM1NgUGfG7V7e6O
X-Received: by 2002:a05:6a00:2e9b:b0:730:888a:251d with SMTP id d2e1a72fcca58-7322a70a1a1mr995111b3a.20.1739295748676;
        Tue, 11 Feb 2025 09:42:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe0Uq/rWJQikGAk1hh1Z55Tn1Qz/ssH5a7k8aQ/7KisDVypi6ZarIlRlks1fwopusQNqa5RQ==
X-Received: by 2002:a05:6a00:2e9b:b0:730:888a:251d with SMTP id d2e1a72fcca58-7322a70a1a1mr995073b3a.20.1739295748234;
        Tue, 11 Feb 2025 09:42:28 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730918f6f04sm3763928b3a.24.2025.02.11.09.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 09:42:27 -0800 (PST)
Message-ID: <927acc4f-c227-4146-8897-96477bf96ae2@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 09:42:26 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] wifi: ath12k: add 11d scan offload support and
 handle country code for WCN7850
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250121104543.2053-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250121104543.2053-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nyj0QiKla7JtYg5uT7bQxY6LoM6rnuWJ
X-Proofpoint-GUID: nyj0QiKla7JtYg5uT7bQxY6LoM6rnuWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110115

On 1/21/2025 2:45 AM, Kang Yang wrote:
> This patch-set mainly does four things:
> 1. Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware.
> 2. Implement 11d scan offload, and report country code to firmware by
> WMI command WMI_SET_CURRENT_COUNTRY_CMDID.
> 3. Use WMI_SET_CURRENT_COUNTRY_CMDID to set country code for WCN7850.
> 4. Store country code, and update it to firmware after device recovery.
> 
> With this patch-set, WCN7850 can do 11d offload scan and update country
> code to firmware successfully.
> 
> Note: This patch-set is an old patch-set in public review written by
> Wen Gong. Just resend it for him.
> Link: https://patchwork.kernel.org/project/linux-wireless/cover/20230914090746.23560-1-quic_wgong@quicinc.com/
> 
> v9: update copy right in patch #1, #2, #3.
> v8: rebase on tag: ath/main(ath-202501172342).
> v7:
>     1. rebase on tag: ath/main(ath-202412191756).
>     2. rewrite commit message for patch#2.
> v6: rebase on tag: ath/main(ath-202410161539).
> v5: rebase on tag: ath/main(ath-202410111606).
> v4: rebase on tag: ath-202410072115.
> v3:
>     1. use wiphy::mtx lock instead of adding a new lock(patch#2).
>     2. rename struct according to wmi naming convention(patch#1, #2).
>     3. update copyright in reg.h
>     4. modifiy patch#3, #4 due to struct name change.
> v2: change per Jeff.
>     1. change alpha2 length from 3 to 2.
>     2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.
> 
> Wen Gong (4):
>   wifi: ath12k: add configure country code for WCN7850
>   wifi: ath12k: add 11d scan offload support
>   wifi: ath12k: use correct WMI command to set country code for WCN7850
>   wifi: ath12k: store and send country code to firmware after recovery
> 
>  drivers/net/wireless/ath/ath12k/core.c |  34 ++++-
>  drivers/net/wireless/ath/ath12k/core.h |  17 +++
>  drivers/net/wireless/ath/ath12k/hw.c   |   8 +-
>  drivers/net/wireless/ath/ath12k/hw.h   |   3 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 167 ++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
>  drivers/net/wireless/ath/ath12k/reg.c  |  72 ++++++++---
>  drivers/net/wireless/ath/ath12k/reg.h  |   4 +-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 160 ++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  40 +++++-
>  10 files changed, 486 insertions(+), 28 deletions(-)
> 
> 
> base-commit: e7ef944b3e2c31b608800925e784f67596375770

Can you please rebase again?

CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/wmi.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/core.h


