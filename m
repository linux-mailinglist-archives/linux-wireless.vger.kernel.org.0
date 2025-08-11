Return-Path: <linux-wireless+bounces-26240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC82B1FE35
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 05:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C7817719D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7818CC13;
	Mon, 11 Aug 2025 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WC/qE3sm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60DF3FE7
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754883547; cv=none; b=Mln9qrlJ6pWBClQAHxr6utjVdLNWiJh2N7mbE7vUlwQ7JNB9UtXsbyXB8do7LSjcxGOuX8yNZLC7Y3M0iBMQSohjkuaEE/hlI4uKLTdtOhb8Rn9sc3Rq4dGvljA1i98Zg2tVdpdXhtImn3dcSrUVxI5WYOzFfgY8or2BwuvPDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754883547; c=relaxed/simple;
	bh=UKXIMrT2Im5is+rCn4dnrZDMosC6fGU2BCT6Wq0lgPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2k8mmSpRu8WnF4jFPBy6/aCAbWi1YgbpOAqvC5e4mfr9T081BNkxOUfXy1NO5kFzjb53+eGXaUUCj8fiBKcyl8/AJH9tjQmBA5Wsb02puz1EdzT+Jqax6W9a/r+1V+od3qVAqWZS9GAgo59BaEkI0Ljirjk9Z2WBmr0YzWSnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WC/qE3sm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ADHKJP013685
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 03:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDApZTk2nZE28clF+a8J2J6VpLUbqhxAq5BNgHbqkVQ=; b=WC/qE3sm/sFHSjfM
	Eq1frOQdIz3EYmhZ/Rt+FViEcfWEgdAeMTwPSnPbL/VqwNyR5jhuunseF/GN9Huq
	GPy79k0grjX9xI1Cdz7+J2tDjgmVxiPasq5QMmkrKOyrF4XwjKaAterf4BUe9fVF
	VJltC44rz6NCghASUn0WxQHi+uYetcrzDOWwOK0TkVBdfr+dWRy3xy+naMiK67Rd
	XMWPuPS63gAqfTKpagrsDZNt6fCossLsL0I+uZpgYMoNYI9a+NWT7P3522VB3Ljf
	qu5gSVAeVzJmZFQHt01QfkbfzCp9HZzehFQ4+qV57AhlKi1q8SvSy0yruPqnSSMP
	I/LuOA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmaxbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 03:39:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so8720730a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 20:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754883544; x=1755488344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDApZTk2nZE28clF+a8J2J6VpLUbqhxAq5BNgHbqkVQ=;
        b=JAfT8qoP/46IO0Muj2oL19jHLSF+6oYsaBnCHp0+y43BzXw8rPcHUCYOmEx2pX6BtV
         2NaMHiM1nRqvTwyKJscmPrTVvqw8wPT1ysX6fS5AO7owRY4jiJaVcpZd1S0a6iB3wuhc
         gl/ht2A3lwgSZ2wpAZd9I7DqANtCJBrY3qjAz2+qGCqeV7A2XbE3Hkl5caW9lqVRwksm
         n4uu/8ul/U0CxY3l5P1Vh9KylkBngpvwd8cZsPwK9I6BcAnauVUQGuP61Z/NbPxWBGq4
         8sqU8bqQO9OSLOeLMSzi/hw3mLIIpW7AO90vQiGUaRbPneUgg/Fe3SIbekRVvvS9bCc0
         OX1A==
X-Gm-Message-State: AOJu0YzO+HPiurGt63GjSYzSV1YCcnV/9A+cE/2LjgGR+QmskzBoOVOq
	p5PHo5GPhwBq3yZEfzbMDnvs8YdPTAZf4yadIrt1sVTrp1nCmI5po5ZME9dHuf0mkKxjoWbAK/7
	2OKE/0U1kj0+G4J2qliWHbztk6nhf5yem9S0EYikfoGdSOYuDgngvvBWnRarcRBoNeeKZcA==
X-Gm-Gg: ASbGncu1PUtWxSfmOcrMzDDkOwq82nlrbI/cjAgWhCYaQ/O2FwWy2RO9UbZ05T02siv
	f/VFP+DtABzmjkCc0ReWHdTT7lFwZ3hHGYogkcINwkwCzpOP6oa9r6NvI5/tiAVK417g76L8qiS
	Kp36tGCltnXuMKwAEWpU6NtG9Sir5F4WN+4bn//jTeHZMyf45rgOzxELYuTQBYqTeBrepx6/v7Z
	df36vPd8138Cj2MGvRwRW9wgJqNlxOSNsHC22movvYcBRR9Mwyqnz6erLgq729/9MZn+d3kRUaX
	K00fQ7RLndSWQUKyCOdZTFcLIMQBIP/2aVxzOHy2GhvMBeINyv3Td40Qa+MaBCit0S5ivJ/7SzN
	s3Ute/7KZnSuK3usUj2yk4JyW2pMaQ6Y=
X-Received: by 2002:a17:90b:3846:b0:321:a2cf:9da9 with SMTP id 98e67ed59e1d1-321a2cf9f2emr7030255a91.15.1754883544151;
        Sun, 10 Aug 2025 20:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzovdnuZMOGoG7rJstD57pdUxuFXM7ZTxP1dKosD3H+FktIX9xerVzG52tcd1z3eHsTxfakA==
X-Received: by 2002:a17:90b:3846:b0:321:a2cf:9da9 with SMTP id 98e67ed59e1d1-321a2cf9f2emr7030228a91.15.1754883543728;
        Sun, 10 Aug 2025 20:39:03 -0700 (PDT)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b43c54fbce4sm3786625a12.55.2025.08.10.20.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 20:39:03 -0700 (PDT)
Message-ID: <d52c8078-7416-45c9-8b5e-e3a80ef6ed1d@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 11:38:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
 <81440d36-9729-4eb5-aa30-d94d0f85b7a1@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <81440d36-9729-4eb5-aa30-d94d0f85b7a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX0rATbqcNNDAQ
 li2h13xhzSkhMiCRGtXGiM+QDlFoIqYcORvUjNpF8Wj9racY1G0EVh1PCw0onBQemgFTNs3pN2f
 tGyyxeRrYwSF1yzH5YUT96vx9qsTHMU0B2QYjZ9bAAv4Po9eST2uiV15G+N83EkRPckmj7Q3XU9
 KP3ol0Eij5MVGZgWl5BPA4kZDTcQQCbdctq23OUX71JzDAjn0JevI++3qiwvX4QrgBtFfceM8O+
 IO+BDBZWBvdqwdgjLBMmP46DrADv/VJTRLsNfljvC4oHiwcSSvVow0gVULZdVRLy3wcX761T8Oy
 5o3J+jKw6EPIu0Fsq38jIwutYnAqJ2RB6CulXdiqC0CDSomEAnS7DvPgaGMPnzfEp46lgQe7k56
 IyeRE7VI
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689965d9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=4rEXVySGOu1P5TZAaAMA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: RqGv7KDPxPqr7dA1YjoYWz_OWEagozAo
X-Proofpoint-ORIG-GUID: RqGv7KDPxPqr7dA1YjoYWz_OWEagozAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035



On 8/6/2025 10:10 PM, Jeff Johnson wrote:
> On 8/3/2025 8:03 PM, Baochen Qiang wrote:
>> Fix below two Smatch warnings:
>>
>> 1#
>> drivers/net/wireless/ath/ath12k/mac.c:10069
>> ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
>>
>> 2#
>> drivers/net/wireless/ath/ath12k/mac.c:9812
>> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
>> drivers/net/wireless/ath/ath12k/mac.c:9812
>> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15
>>
>> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>> ---
>> Baochen Qiang (2):
>>       wifi: ath12k: initialize eirp_power before use
>>       wifi: ath12k: fix overflow warning on num_pwr_levels
>>
>>  drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> Since this is fixing smatch issues I plan on taking this through ath-current
> instead of ath-next.

Sure, fine with me.

> 
> /jeff


