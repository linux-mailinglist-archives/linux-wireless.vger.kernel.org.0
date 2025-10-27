Return-Path: <linux-wireless+bounces-28317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E44C0E6D8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 855C44E5835
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF425524D;
	Mon, 27 Oct 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IbxCOOrf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0691611E
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574672; cv=none; b=UPCUnLyxKCEVc9qLCswCY30mtTHLuox3rvf+WRIG6mcFrcQGLvaNIHHIRYSUL9Y1BGm5UOFC454Yfyx5dVsM+Z6Dp1pmelna+PB+HOXdZjz+TYLt4S1KM4aMbkvf4hZdbqvQaGKD3vtc5gBLtPTp0wqBbm/iaTzoRhLvrxwciv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574672; c=relaxed/simple;
	bh=eAlHhvZ4anus9LbgNW9JTnqCUn9LAi9uzdco3vsigpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZH94Lho0dW0xe5TozWhIlUIjNGTllhpGN8Ls5m+LnbM21WTON+AGTJGl2cRhmQo5kf5mXjum9FtxdnSoegymEaJH1uShAApOAWTlw0Wfmo6ZbGUcRzWxzxcEudHXCPAVarGox+cel1U+7KMdL25BOQU0Pwr/w5WvbcB4r0W3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IbxCOOrf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8xIWE1164950
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jJ2kKGhDsXRxoSktfJs/yjQlW1TNVJkOf8QNj2m7qgw=; b=IbxCOOrfwhvCxibv
	bmp7+tCrWaA4AMHoZUvAOiUHsVDkU+eOQopiQOteSfq0o0eXof9VUIe7jzC0gfRm
	rnMjtWADZjQziKv8BRXwsX2xY8wlaurUh/6vuWTLoQmi3Yh4VzqACQ/ccz2CH5cA
	yi7s00wKo8N1Tpu7W1Yb8nVRzfk7yq0pPudjxA+ysBRV2wUuMf4lDxzTKbfxFihj
	t+GhVREJw33Ok5rlpPrn0FfrZM/UoekR19MO/qbasECXOVqLygtrwXslWwTVBsfX
	wGiXaLSIt6CyBYnWRP1X+y6JujHpsV9ctuucuGDnUJnnWhekCaeDoF/XxgAN+kWV
	5jGQIw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4g4tu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:17:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc08so11140710a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 07:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574668; x=1762179468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ2kKGhDsXRxoSktfJs/yjQlW1TNVJkOf8QNj2m7qgw=;
        b=giVmNCOEndcZekjlSvwDXxxR8ZKPlB0HBPc39yV3yAroaD63KLy0F4+qdxxOFGlnIi
         83SV+IUwFziOX4k7uyNsC/Hr9pdx92WQYaBxSj+X8lWu29/418TBFrN6lW7KhM5VmxGD
         acLiBIEkdr6gfEvSDzO2igFfOhxDu3Y9Uzq+vl+SUvJG2Pxw9pygj9IzcScgDDlKbzCL
         l/pVrywegeB2Ka+AJGq4ht674CbLXqmKODl4CWJ+p33p/sWAFsjYoBT+c3gMvd40wO9n
         SEpm0YpHMbp5nR8f9Pjgt+2s3IzyYWCPnPQAT+R77cYTHtzFw0Zs8cSi4g2TWCMOUaMl
         elDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTEBgcXuh4KRKQqaurmukrxLlGahVwAMUaMZWHbABzItecFHVkgKxoDxLcjlpBOlPHjArmM+AvURJEv9b5Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt6MZA89iT8c+d2onKkA2yY9G6EtN0OncQYMmKW6d6Am8i/uGv
	9wDXYj2Uapbg85XS+a2rjrItTBFRt0q7xp7i1o8W8Ermx9xUPjIYD+KkbgiMox2HloPPlYfuaLe
	i7hiPyA3Q7cxcQJqkfVTX4sBQjemN2n8kqVt8IuphFS90zOw+6bvLQTr8y2g77p2B+LjGHw==
X-Gm-Gg: ASbGncuheUArNw7MgEgSkF1jeLtAL1CjL4y90IXo3VjA1gve9x7R/6P0KGPFUZRlBYN
	IfIM8PLJKfwKt+M7KMeWh3BEUPjocUaKX0ftJokyQvqRRhmyJZKmuh6Cr/8vJUWqJfRV6WNMn9N
	gPxltRXNGzQI7bLrAKcwQB421ItAziioPxmbQvinUwaIUXAoyP0VdYCNhoKo6/TOUq3n+PEYBLY
	VmimtvdjO4i/sae+J+3mx/9NS4lRa1BR5llhfYTGSL1PZE6jtwATKTvIcdznmGFo9ngdkySDtQC
	P9UO+9f8U8kTeKvV9ronJDJBXzo818u0EC9diJvBwOeOHogAo2Ub72Z+MJnF6m4jU8t+n9xdU2h
	CPViv9GCK8u229BiXKMPekezbtetL9mV26lhrY5f2FWC2zdMSLfU=
X-Received: by 2002:a17:90b:2fd0:b0:33b:ab6a:87d7 with SMTP id 98e67ed59e1d1-33bcf8fd36amr51679069a91.26.1761574668185;
        Mon, 27 Oct 2025 07:17:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6NLUUnhhcm8QZSzKECdU2YISlOCjBFk6QtuFursTSt/wHazRqtdyXVSrd3nowHBnE3Umk9Q==
X-Received: by 2002:a17:90b:2fd0:b0:33b:ab6a:87d7 with SMTP id 98e67ed59e1d1-33bcf8fd36amr51679021a91.26.1761574667590;
        Mon, 27 Oct 2025 07:17:47 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.193.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f3aeesm8658471a91.14.2025.10.27.07.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:17:47 -0700 (PDT)
Message-ID: <419c5d98-f54e-2956-b78f-c597fbb7603f@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 19:47:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-current] Revert "wifi: ath10k: avoid unnecessary wait
 for service ready message"
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: klaus.kudielka@gmail.com, yannick.martin@okazoo.eu,
        andreas.tobler@onway.ch, mathias.kretschmer@fit.fraunhofer.de,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20251027-ath10k-revert-polling-first-change-v1-1-89aaf3bcbfa1@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251027-ath10k-revert-polling-first-change-v1-1-89aaf3bcbfa1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aZt9VN9vW53tYK7gET-p4AT2jKJvgu5M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzMyBTYWx0ZWRfXzCATskdogglQ
 276BMLGqO9UgsspwjXOqpiASw4yVcyDF0PPtrozifeeKnGmsMm7V/RxnIZITXw+yRtbrIeESj40
 PxrpjAxSGIEPLH1gXqwW0WsQXRA2alH1Gs8MMOSpP7pgHDchSQ7BUXLInezvguMKk9ndMLlf04U
 yHtt7Tfl9kJx99EKbqMVN/OBWNS86VQ/b0+MyfercT0t1hN97MJLjYtAk4jpA+NYzKETUADRLsK
 qQp0BdF+uJQuBMLfQlosy30MwuL0oSkmotWlbzGNufXku7j9tL7huEmEtcSJq6779lqKrrq5UKW
 qJyURfv/4ETWGK8/4txn2RRLrD1RxeKYuU/Rne1XhkRlMYkzO+ELZScsNa2KSWCnp3CLCtikQOa
 gMWcOMtUOk/mBHwKtcEq5g96VsmKVA==
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=68ff7f0d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=HVeQatgKw7Z0Li/6oOn8eA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=luumQYm6HDKSWQkYg1gA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: aZt9VN9vW53tYK7gET-p4AT2jKJvgu5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270133



On 10/27/2025 7:19 AM, Baochen Qiang wrote:
> This reverts commit 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a.
> 
> Although this commit benefits QCA6174, it breaks QCA988x and
> QCA9984 [1][2]. Since it is not likely to root cause/fix this
> issue in a short time, revert it to get those chips back.
> 
> Compile tested only.
> 
> Fixes: 51a73f1b2e56 ("wifi: ath10k: avoid unnecessary wait for service ready message")
> Link: https://lore.kernel.org/ath10k/6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com # [1]
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220671 # [2]
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

