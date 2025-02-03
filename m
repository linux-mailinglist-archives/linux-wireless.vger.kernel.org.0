Return-Path: <linux-wireless+bounces-18324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272A4A2669D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 23:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF427A2B1E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957F20A5C7;
	Mon,  3 Feb 2025 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5JaPwpl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8D1FF7B4
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621935; cv=none; b=g3O7h0GMTtBFZ9i52Yue6eXdaUYZioclRQnh2aLJrpel3Kru4sn7IqWJaiwdH6+Tq4vsOZYJk892/gumJB/7+svz/tcwovY7E92d1KGjlF+WHuvbxVWaRNr2HmyFh012LLoCFriCy88mizsKl24u7IL8v1pzJoRQNGaUCLH4saM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621935; c=relaxed/simple;
	bh=+EePZydkqOVyzVDYpxnlZDu68C1qxhVTTamAgWEH8bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh0EL/rvW17A1lqm1UcpHgM/5TwaBKxbK9NFVWenH2wuh4h9DqUQQaK1c54T+mPDCIRnxJxpBWDPyxzFMsVLI1/+cX5IxrtkvItRsOfEcsrB3bBq3WIWj8GqSPgvl5pIkxUejUeZt2Dd4/JPtuGXeTcama3S/0Kix54f7gAvePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5JaPwpl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513Ipr3L006227
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 22:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ta7nKKd/iplZB8kvjsRtDq9z5h0gEi9TTphLdCMJBeY=; b=D5JaPwplONOWsOfe
	Blh+Ni7LmKp4SxOy8z31iXq3rEgP6F/Asn5auyZpMnZpBTezaJMkOudu9ABooN4I
	uDnqvuWb3QVYSOtlWMn6Vw9meS7UuLBAOkykOCDm2YadFuLSd262hbpIuPCTtZz3
	EDdIkRM0E3lyIKSP1ykBTHdvllPwiF23nTUBp3NRqq64oFZF78zUDHUSnIdXyhXJ
	Rbxi/lIy4b+sYY4kykDJVUrFs8AeB2e28TE5qoZrSIJKZjsF8TwfIMsqt2azNGgc
	DfImoUiScdemv9Jp1nQyQqaL2W4ZZnFSLGmcQdOysoSLi1xjUpyeIWvkR1UMGUsZ
	DTo8jg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3ex0dy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:32:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2166e907b5eso89129775ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 14:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738621931; x=1739226731;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ta7nKKd/iplZB8kvjsRtDq9z5h0gEi9TTphLdCMJBeY=;
        b=qb9ohT4/45TwNlbgLGNuxgMH7B3y8b7fxHR2PSilK+RavU7VwiWAObhCtT2s6mGG4p
         QM9U6xkIBQ/N+s759GWnNdkOJ60dAZzrS1u5Q2pJbA6l3i6MsQhcZ4C+MSNk1TXFKEdr
         KTzC4Kri3ZG/Sim2FJcD+nLJTuu+ZARBcAw5R0JwR78vQeGX1L4WaKnRnwutLxIugLq9
         TW7eeZ7icYrDnogO5NPAYebTIjQiyAZ1gXveFUMHBlIbFyF+xim2o2hITAoOoHmzV5k4
         pXxd6BmFScRa/dP1adDI7tKPYaDLJ5iPNT8TXoO2bBai6QnQx7pYDfYFc9BxeC96Dp21
         oIIg==
X-Gm-Message-State: AOJu0Ywrw+qS7AqEWuYM0gyIPY8EOAPJ4iTXqo4gKpbQI6AarlahUOmQ
	YUgu5Ssjgp8mdizVzp04FMa8IUjYtDs1Aj8Bl7LTwI8SoOKDraBxUsjhtehQyQgv0KEBy9L/C7K
	eR9sZdHTTVJC15lIF1Ewos3C+YdQrpRU7lrBfcEAWzcwNFcxUQueHFKE/jpQwYsiRskJEhEsnrQ
	==
X-Gm-Gg: ASbGncvIFBrF09uEFdzUnANHIZeF1OiswsK2ccQc91brWcTTFr2Hxctsezr80WMTISo
	fcNES1tLzoGpY+Jv/59qYnhCCPXIGwOMvqPIT97U2HomC4k8u5go1B6lgMjxqDFyjQVV9o95f4G
	B4nH3JmrtQsgFX062sCRf3r15NNHuQrn2xnBnkco3aKx2coYznKYIyvfhAAIM1sNaajTJoUVCms
	J4zimcnXU8GGf/F8uXdXxC84LWTSEgVqCJ5d8u+Jhfr5FF/UG0cdEGAP+A3ehQ0v4hWzOddSl2D
	jt1C+xEykSntKIkQ0EL7zpPjjhc3i/IjfB114QRUdabhTCJIT1UcPOzYPiPsWfgxegWveW8eTg=
	=
X-Received: by 2002:a05:6300:197:b0:1e5:c43f:f36d with SMTP id adf61e73a8af0-1ed7a5f901emr42504728637.18.1738621930664;
        Mon, 03 Feb 2025 14:32:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGy+pXdaTMlFqgRixZAdNAYTB0DyQXIKFwBL0IT3d+qifuvK87o3muHMcLtg2s7I2sGVyS1Q==
X-Received: by 2002:a05:6300:197:b0:1e5:c43f:f36d with SMTP id adf61e73a8af0-1ed7a5f901emr42504698637.18.1738621930313;
        Mon, 03 Feb 2025 14:32:10 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04794bcsm8616362a12.51.2025.02.03.14.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 14:32:09 -0800 (PST)
Message-ID: <fe37fb46-bb48-47c9-bff2-6b64acba01f7@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 14:32:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] wifi: ath12k: Support dump PDEV transmit and
 receive rate HTT stats
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
 <a215f6a8-dc62-45bd-9feb-bec178e4ad5b@oss.qualcomm.com>
 <f31557e9-88d3-4800-aa77-14a76857f797@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f31557e9-88d3-4800-aa77-14a76857f797@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qs-Acg2PXr-8De6RF7K2fvNTuIkJA4yS
X-Proofpoint-GUID: qs-Acg2PXr-8De6RF7K2fvNTuIkJA4yS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=839
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030164

On 2/2/2025 7:36 PM, Aditya Kumar Singh wrote:
> On 2/1/25 06:40, Jeff Johnson wrote:
> [..]
>>
>> pushed to pending, please verify the following edits:
>>
>> patch 1/3:
>> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=d971a54bffcda2421038fd09848b0781244f15c1
>>   added 2025 to Qualcomm copyrights in
>>     drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>>     drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>>   aligned = in
>>     ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE	= 9,
>>     HTT_STATS_TX_PDEV_RATE_STATS_TAG	= 34,
>>
> 
> Looks good.
> 
>> patch 2/3:
>> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=64cf8cc8f141ad47ca831649f3173fae25c5010b
>>   aligned = in
>>     ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE	= 10,
>>     HTT_STATS_RX_PDEV_RATE_STATS_TAG	= 35,
> 
> I see alignment mismatch in macro 
> "ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS". Can that be fixed?

That actually aligns in the code, but looks unaligned in the patch.
The reason is that the leading "+" from the patch pushes the first tab to the
next tab stop.



