Return-Path: <linux-wireless+bounces-9145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B78C90C950
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEDB1B24D18
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A98213AA48;
	Tue, 18 Jun 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V5veSNsK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7FE7F489
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705953; cv=none; b=YLJSU4WZMjiS5HFZJ8Nl59ZvoxVu46DhenFKJXOHL0BIf5iDMI4f1ZTvCIblItnrg+j6tNZKYJpk+ZKjjjDtPEXzdYESw5QW3O511pmAD4/zvuhr3AXF8sTS3quV6tly9xLqSoipLN/KUbePwrv0MD+pS7zLcVoixez4J7cNIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705953; c=relaxed/simple;
	bh=YD7zDmmn1MxXpVpXmrQK2O6Mt6z9u+z0YUhS3anNutw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R9DRMOV9SI93QdmdVHU0Op4phVOhlxS1cC27yk7fXEs2NZCdfIXepcv0tkTTTRcCbvDP79GF8vSSStzzvTj6QmFsmXiU6ABCNU1BKjxrsmdrHUpaZIrn7abuPJ3nDA2zlOGVRY06MUTaZKu3K00lWpdQrd1YHhp9R2jdVmKV40E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V5veSNsK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I387Lf019209;
	Tue, 18 Jun 2024 10:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbs0erw5OqnlYwGFkBSfxJZnMphNTdjPSZw8vQCCnn8=; b=V5veSNsK+srIs9QQ
	yO6Q69h4F28y8W7Ez7Y6s923skrJry9LtMg75cFMVw1UE0Rw1RmyUDKW7VRDiQN3
	6KpqByDyknkaCrGlPtKmlcBB+5ZoJlS18ePZNiqmKxu9PRLSQ4JX6h5uMGwv7LCZ
	CtFxgJjjH4WvpjDKxbxlzyC/rCC+D6q9Co60eFfsJ+oQyu0QPNB06tiNPjv4z/nh
	f2APWsCYGZBXJ26svzXVGMFVNrSv2mTgS7G0S6mLd3SIMhWdTIZAxakUgvSzY1oI
	A1GYtCYHot9K3IIpNxCYyU7qMoEBvK+J3nrV43MHFcYJtXA9Us9rTnkIBB+dk3vJ
	bulhfg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu22grvex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 10:19:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IAJ4V8024670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 10:19:04 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 03:19:03 -0700
Message-ID: <29fcda42-8d83-40e4-856a-d98e56981091@quicinc.com>
Date: Tue, 18 Jun 2024 18:19:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath12k: prepare sta data structure for MLO
 handling
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20240617131650.3288118-1-quic_ramess@quicinc.com>
 <20240617131650.3288118-4-quic_ramess@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240617131650.3288118-4-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uAEbIrKkJC0h08fgwvRjr0je8nCN0btq
X-Proofpoint-GUID: uAEbIrKkJC0h08fgwvRjr0je8nCN0btq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=807 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180076



On 6/17/2024 9:16 PM, Rameshkumar Sundaram wrote:
> +static inline struct ieee80211_sta *ath12k_sta_to_sta(struct ath12k_sta *ahsta)
> +{
> +	return container_of((void *)ahsta, struct ieee80211_sta, drv_priv);
> +}
> +
better naming as ath12k_ahsta_to_sta()?

