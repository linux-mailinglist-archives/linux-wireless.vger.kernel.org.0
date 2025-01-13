Return-Path: <linux-wireless+bounces-17448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175BA0C194
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D98A16CC80
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781A1CCEF0;
	Mon, 13 Jan 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c3F+CtPQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C81CCB40
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796824; cv=none; b=hcTFP91mX+3hjUxpnInQDvBx0JqrFe+Ofv21DG5dnog/5tvMl4qTU276Kaj7XVg8Asb1hDos/NumUz5cTzCronxm3nuk59CIRy6Byj2qwZZbsn0VwSTP7dlEtWYJ6WciA/S7Hmh2hUlQtlYSi2T+Ll/WptulC38GN5IKhA06dEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796824; c=relaxed/simple;
	bh=WTBsWM0BtuLqetF74KPC7GY7Sih+X1b916nVSQ6wHKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1gbLeOwSEttvNzRb0SSfPQ+3JOtEToNXXk9fm8a0Xna/YTKLXJWhlnHcNruxeUcV/7ehUAQTGkpl8MFT+jRuE7vu2erbR6qnz3CHwBTIXhVR/KiuThw1gZ7KYfg8Q27kjz2sp1pCFTkRQSKsc3WJJgnuFZjckE56zdFz8EjxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c3F+CtPQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCsoAG001730
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOkL3JbfQvnmr39m5p2LmwihbhxevGv8EorHUEwfkXI=; b=c3F+CtPQN6jQ7DdY
	DuMm7+VS2N45U8pCD5XxG8jXrFCod9xVA5D5aZf6vuWyorPC0MhiM9SNIK7AYHOO
	+W+bmPXhY93U6gHTpTPsQSlogW8cqKdF4rztWHUwBRUknXmCEOGFDtCvNWeKVQxy
	PKdBJUXZzrtM2oSWG4/JVd1z7aO9Vw+WA6oN2hnu0WhHnYesKa2tDXnoy6cm1ts9
	fhl1xlmaTLfMPv0gejVpFanSyEWH6bmnMy6a6R6iI3EsYghbUyJ6fBhNFT2c6RWD
	UC9FgklseaCYjm8KAm327rSHVJKnHXeKxpJKHDW0ms24crk3AGBHXl5QpyoalNiW
	UEDwGw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44538jgyc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:33:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166f9f52fbso142576415ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796820; x=1737401620;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOkL3JbfQvnmr39m5p2LmwihbhxevGv8EorHUEwfkXI=;
        b=B2szMyRLMdzt8z3NKdReCt3cqgDd50qJQ4E3OpCsOaiuitJvfBjv16PT0ojns1pr/r
         QmR1ViVu6GGrfRUlVp8k4Om7+xTGJvxz54rbKuYDS39FQE2QC9Rbsiw+iDH+Dv0GXGP/
         T60qv5KoTnjrzqJJHfQl1fjxvvFm1NQd8o7fX/DY9WEOyAF84rIhxxRIDVfr4IMVQ6LR
         t42BungO3G8CuRKKTMKufUpBBlg2OLRJBsK+8maR5ux7l2+yhTAjtqChDy660x9lPG/u
         iZ/+7A73gAHeZ8yzAPiFGdOV26hWKLnXKdsPGNuP4RvE0v/orOHntZCGxgsPNykUV0ng
         QHHQ==
X-Gm-Message-State: AOJu0YwASMMLwtYUi2Wb7+w0oTNiOpCPebBeZa0DHI5TE41z7dpUhx62
	ZjPcqbXrgufZtutI0Y1qu1bEypEsOfVzW2TXGJNRyI565ABSzjXfTlOIq/Fcg5uc/Zi7JZ5W0rs
	gMdmlb1/26t5w/SLKffX5/eZ4oahcsOVvnUd6SC3EoojxweWErCsv05SEHbJbYhKCIA==
X-Gm-Gg: ASbGncvuZ+PdwKQ1+jBakBIrfQLfnc3NiizEZyQzneZmVeIILX+8oILX0P131TYN3cL
	dcKoBQgJ0cs9VkD0E8GQXvGHmxGJAZUq7NBK2zdfU7pDkkIsiUjA7uK76zr4r36N1If5eIFppIz
	Ii9V0s1YievWU/tm9FJks9XWsS/nJpIOg57XCXIYIpT2gPsY6OMh5kE9a8PVggvFQF8ZBFK05/8
	q1GwoqOJ9ysamzth7XchquMcNYSKcKVibYfB1diXQuFklUpbb6FJk0+c5mdcj36Kyo9nL8+py7o
	xlzJZKeYMpZUJhEoEJU0AMoTbk903hxqEiCHPXjaG+eoFdel5A==
X-Received: by 2002:a17:902:ec8f:b0:215:7447:ebf0 with SMTP id d9443c01a7336-21a83f665c8mr357466325ad.29.1736796820029;
        Mon, 13 Jan 2025 11:33:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHATqAu5V4y7367LQkH2b6xsDqecYPRfONvLJI+8/ZT0c7pbtjgzQXvxrx8IE0lFzetz7EWGQ==
X-Received: by 2002:a17:902:ec8f:b0:215:7447:ebf0 with SMTP id d9443c01a7336-21a83f665c8mr357465995ad.29.1736796819613;
        Mon, 13 Jan 2025 11:33:39 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c958sm56884745ad.174.2025.01.13.11.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:33:39 -0800 (PST)
Message-ID: <003bb2d4-b1d2-49f7-b889-b4b32c3e986b@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:33:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add support for link specific datapath
 stats
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250110205912.2585850-1-quic_bmahalin@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250110205912.2585850-1-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bUXl7hT767dE7VSK_lS2RcrDCydkhP61
X-Proofpoint-GUID: bUXl7hT767dE7VSK_lS2RcrDCydkhP61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130156

On 1/10/2025 12:59 PM, Balamurugan Mahalingam wrote:
> Add support to record the number of frames enqueued, hardware
> descriptor type, encapsulation/encryption types used, frames
> dropped and completed. This is useful for understanding the
> datapath performance and tune the peak throughput.
> 
> The link specific stats can be viewed through the below debugfs file
> 
> cat /sys/kernel/debug/ieee80211/phy0/netdev:wlan1/link_stats
> link[0] Tx Unicast Frames Enqueued  = 9
> link[0] Tx Broadcast Frames Enqueued = 78689
> link[0] Tx Frames Completed = 78698
> link[0] Tx Frames Dropped = 0
> link[0] Tx Frame descriptor Encap Type =  raw:0 native wifi:78698 ethernet:0
> link[0] Tx Frame descriptor Encrypt Type =  0:78698 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0
> link[0] Tx Frame descriptor Type = buffer:78698 extension:0
> ------------------------------------------------------
> link[1] Tx Unicast Frames Enqueued  = 0
> link[1] Tx Broadcast Frames Enqueued = 78689
> link[1] Tx Frames Completed = 78689
> link[1] Tx Frames Dropped = 0
> link[1] Tx Frame descriptor Encap Type =  raw:0 native wifi:78689 ethernet:0
> link[1] Tx Frame descriptor Encrypt Type =  0:78689 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0
> link[1] Tx Frame descriptor Type = buffer:78689 extension:0
> ------------------------------------------------------
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


