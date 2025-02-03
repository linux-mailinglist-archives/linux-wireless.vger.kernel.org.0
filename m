Return-Path: <linux-wireless+bounces-18274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7EA251BA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 04:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91373A1985
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24AC29A5;
	Mon,  3 Feb 2025 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMPxvXhC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583225A62D
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738553774; cv=none; b=tTe+UKMFUqQL2GiNL/cL0zDfxB3HULJrOLqJAqFcOinCig0bhl/VvDdWPFttaBY9Yh592Xm6ea0rcrn6SrwAHFgCptGkklYBEwAEt9RTcOEXpFOSSDZqJQseBuj53N27iA5FNAnWiSlnDyvwU3YUg61+WvF0H2OMcRJfQ3lqMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738553774; c=relaxed/simple;
	bh=eqFBdZm3ZsFe2cN2WZKwXEZlfHlT2sO0EOfyzqgV8vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvSc5WgOIHKYsx7JJBalszlf66NAJitiwVpVr5ESiXvBV7lp+UbSI40uRGWbzv+chhzf/IeRAfQQdq58PQaIXRANLFPs/UIv/xU8sDpMONYbVdlfThSMLnAjagsZJfoLBL9m4rJ8UzRrYX/UT+9UHA8A8xh3I9nYpZh/Jcelga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aMPxvXhC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51311mpH021040
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 03:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P9XMzfRW9jzjbAmoToE16yqekltPnI7Dhph0+hZplT4=; b=aMPxvXhC1mk1l+Pj
	XSadx/e7PBy15L2+09LRs2cUjF5ZA6KVv9hhW4zk3I/Y+V4Id2V5462Ckf62MZHE
	pQ3XHwZECa4TrVzaoxB2LTx4NWv6AcPcI6DTUec8Yf/EcfOs0FZ9zaY0SkYh9Pog
	QO5GgygmAu/yy31jdtFxk2Thwxcs1Pf7tX4PEwOQB0FykdkwplNlxb0moh5DSIEL
	RGEF+M93Mg088BXdoYUUg0ZKXy0CCIF9cudpN2sWTUIpKj1kgb9TfFA/yWAmTc0Z
	nZyYDGpAw1Ve1StBTnJSlmfVAmjcgJEPaGFU//GT/vBC8KGGsTLhkcODV8NO8AvT
	8LLMGQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44hd5pk3k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 03:36:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso9413464a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Feb 2025 19:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738553770; x=1739158570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9XMzfRW9jzjbAmoToE16yqekltPnI7Dhph0+hZplT4=;
        b=RnLSA+7OiAgHis5Yfm/Gu+OxWLeE/bBaY6pbx5wqM5xupvNUgxlyGqGi9lwjIg+GAW
         pihI69FhCIXgK3QXw4bTLTVWHEavRojn+dJFGOlxc9OIfjYXDz+8Bd2/Txkvx4Rv2pxI
         CSVzPjRuFcdf4XHjc1UoQGofrxycpkjY3iD9BUf2yZ/2FpgkuPFOgrghpPRsGpvd0ubk
         EB0FELL3nM/uLHC3gVUNCt2OUFTpkkCUbWntHgtyhU4LeENdQbg+Y1eZUT1bp9SA/Mns
         xZSvkAwps4B6HAFDqm6b5oW56RD4BpPFHBKPKOoq7iEyTEVEMscYGEXWawCIdmW4/bTW
         355Q==
X-Gm-Message-State: AOJu0YzqIzlQNwU4HkC/0xQ46awRZUWh4kqAIsbLBGAoDtaiM8n7Mkmu
	cvGnRqMH9Edabx3yKnl2bkTiXGf1uUC8HWyri+nQLN4y78nHkTlbtuTuXDR0PCNSYUvVKvo+x9k
	XNe6Svx4UTY3W2l/0YHf7XDOZGzknRoXU5Xzog7UvDvMUoZWDq3zLrbtaNAphu/7NRA==
X-Gm-Gg: ASbGncs6YapRSmi2yFCNSBHUIc7HsEXr7UxBph092KHPuu6KD8IfTPViQ9S4J1ATWY4
	eoGSVkV+oRsmrVl5jdNuMCRL8xzlWakVe9VljzGc2RZJfNfc1jLcU7i2bIJlvpOBjIYaRhbILLi
	XfORLT2vk4x5obnpQVn069mfQPBEzFmkAj+YhgBKiG6D6W5OTCEj+rlTfHCiUxKlORkRS9Bph29
	Ma4jTAtztB/pL7GYuZWqcTL6AxNqpT8hBhv/Ql92vwr5ZY7J74v395/AWr/fZP+Mw1QKarc4wAh
	fdao4hQECQMZo4guaR+xdVTYzCuenD2Yno4LddY=
X-Received: by 2002:a17:90a:fc43:b0:2f4:4431:51d4 with SMTP id 98e67ed59e1d1-2f994e5000emr19927237a91.6.1738553770455;
        Sun, 02 Feb 2025 19:36:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNhbgC+sGkK+l3sx6RBqEzjNY01E3D5ZcUn3ADllOXPHG4uVtSywlZybhdX/wqmRfGHMdZng==
X-Received: by 2002:a17:90a:fc43:b0:2f4:4431:51d4 with SMTP id 98e67ed59e1d1-2f994e5000emr19927198a91.6.1738553769993;
        Sun, 02 Feb 2025 19:36:09 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc97d32sm10046455a91.4.2025.02.02.19.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 19:36:09 -0800 (PST)
Message-ID: <f31557e9-88d3-4800-aa77-14a76857f797@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 09:06:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] wifi: ath12k: Support dump PDEV transmit and
 receive rate HTT stats
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
 <a215f6a8-dc62-45bd-9feb-bec178e4ad5b@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <a215f6a8-dc62-45bd-9feb-bec178e4ad5b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: V4OcBQR4GbXjPqTrAk91IkA8fV1Q8xtM
X-Proofpoint-GUID: V4OcBQR4GbXjPqTrAk91IkA8fV1Q8xtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxlogscore=811 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030029

On 2/1/25 06:40, Jeff Johnson wrote:
[..]
> 
> pushed to pending, please verify the following edits:
> 
> patch 1/3:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=d971a54bffcda2421038fd09848b0781244f15c1
>   added 2025 to Qualcomm copyrights in
>     drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>     drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>   aligned = in
>     ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE	= 9,
>     HTT_STATS_TX_PDEV_RATE_STATS_TAG	= 34,
> 

Looks good.

> patch 2/3:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=64cf8cc8f141ad47ca831649f3173fae25c5010b
>   aligned = in
>     ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE	= 10,
>     HTT_STATS_RX_PDEV_RATE_STATS_TAG	= 35,

I see alignment mismatch in macro 
"ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS". Can that be fixed?


-- 
Aditya

