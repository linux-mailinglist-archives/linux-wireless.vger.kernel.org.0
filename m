Return-Path: <linux-wireless+bounces-19521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7DA47553
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 06:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D9E188BFF8
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 05:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E574F207644;
	Thu, 27 Feb 2025 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dAKs/ia4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE31FF618
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635000; cv=none; b=Ftac4yn9/xuFos3rckAsMJYld5AWmqtpRl1J12HLCrafGpu+FMiWLUOWnxbiFdWur8tSVuQXs5mm00mliJHdav2FVxoNXOQscgOnUGk7LzbYbu5PLuOoXLuwu1zOsPMorLMbR82e/wRrYEo8JycsaT3pjzX+ZmZA2v56xkf6eS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635000; c=relaxed/simple;
	bh=AF3U93ELVNENVABu3OP1UEFdB34ToqfhjPrp1MsPDgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OZ4a9yq260Z9xY9dZ++9sS6Atksio3UH+AzX0YImxj+oLSMs8CJ2k8cVP1fBP7JNlpPYwAWVlFNM7Ol+00MnN0uPcxAgJSjny0f6aj66VcZLukfSTACSjjx5kUeDaDuKU6MNHuxGScZ+tkbfNlebwLbm+EpPzIzoy6Cwovl19KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dAKs/ia4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1bUEN000441;
	Thu, 27 Feb 2025 05:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ki6BeIg8JJVB5zdMdG+8IfD4Mp7vXWTp8/O5AWKYXDw=; b=dAKs/ia4Yy8SEOYT
	nPdjdH10ViuS6D88txfmH7jL7m9jNhkc77bX2HuxwFPXSnCuocp8Iutc7VJKJsml
	iBderwORSosSra3qszdP0lW5YvUvnwQ73welXT4XronRomNqqx0Nl8rATsa7IaOi
	U2ua0bwUFYBQVBsNg2+LnP5ZnFTmywYpmfqn13gi+RcBezfGYxbK1+sJZmtCG89t
	/wXx7sGu9U2xsy8z97WoWJBU72iEyYy8O2C+Gyb8mpXmV3Za5q1dpoK803UE0mvo
	WR7BcwE2SbQilthPv5qjxMNDpr49D6gyrEmaKj+gOxy+g/JfqWWYAqRje6NZQxp7
	2JotjA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4522sktfj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 05:43:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R5hDcc000813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 05:43:13 GMT
Received: from [10.216.32.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 21:43:11 -0800
Message-ID: <0d8bad5a-4616-17ce-5b27-c5eabd7e7877@quicinc.com>
Date: Thu, 27 Feb 2025 11:13:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/5] wifi: ath11k: refactor transmitted arvif retrieval
Content-Language: en-US
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
 <20250210182718.408891-2-aloka.dixit@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250210182718.408891-2-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EPBGp0Orq9FwlE9wV-2_I0d-IRzVJnQs
X-Proofpoint-ORIG-GUID: EPBGp0Orq9FwlE9wV-2_I0d-IRzVJnQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=598
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270042



On 2/10/2025 11:57 PM, Aloka Dixit wrote:
> Create a new function ath11k_mac_get_tx_arvif() to retrieve 'arvif'
> for the transmitted interface of the MBSSID set. This will help
> modifying the same code path to reflect mac80211 data structure
> changes to support MLO. This also fixes an issue in
> ath11k_mac_update_vif_chan() where tx_arvif is not reset to NULL
> inside for loop during each iteration. Compile tested only.
> 
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

