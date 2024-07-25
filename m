Return-Path: <linux-wireless+bounces-10525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08593C87E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E5BB20DE7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83823741;
	Thu, 25 Jul 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bTdn/kJF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2515208A5
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933323; cv=none; b=SYQBlvj2wi+WT2QOpvb2IQfZDn5EJdIFqIZOibI3hLVRXJy90s9jTW0KaWPbDK7ZYwwvrBlABMQEye5ATDtK/PApdAKPpM4GTlEa6sD7t8yjRsnMHAFgs55Qmt+CSVBl9M4geb+10HWgjvWcNUim9JzwhxiRdRV3CJOr1dsApEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933323; c=relaxed/simple;
	bh=KQfxYAXEspdaXIw7U+ITY4gVM8NjMXnWqJsBypdFvG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iuVmYGxxzYAAXwFGQqX66dFR2bR/LVxeeCv1+tpnYlGw9nvIlbfmc8MqbvOBnKkmf9+Fde9+OMCwYcnbeb8akrtXeI11yXjb3nYt0KQqSYMQgwPwoW865mrH7iruaa80IpEqpactN+Pzlf9kO9Srex3AGzKio3jV81+u2zT2mGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bTdn/kJF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PA1UIY019617;
	Thu, 25 Jul 2024 18:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	atTuAT1d+WP+JmcUTjKIb003juBpeadAgbOBQ8ShZSA=; b=bTdn/kJFial/TPXG
	zwR5KJdkHWNcx59pQGV7jADaRSzHwNg7wBSVoKXJCX9R5bX9Tp4nSHMwuSqUF6s9
	IcGRPWfi1xV29Ksi7YuwIWiPi2NGLjY0SqwYRbcJs81lDB2Sa9QPi+pXdnPt+JU+
	NCI+6rtqG7BSIyn+r7Y2oI8Dn9u5cm5yqplun0O0ek4hmG07bGnQjIn4QSl9B/3T
	/Y9UYvtS6kLT+RcHQCr/5nhtPxNDR/YBJgW/I18bOkNCUDLoCoB1z0t4RyXsZpp3
	M8VyMCEtJq60ZDHR9f8Oj+e9tJjLqec/MrG5zd5br3DLa3xRgfA+MzEzqg+XRmD7
	Xfrb2w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487p1e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 18:48:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PImZwi007611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 18:48:35 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 11:48:34 -0700
Message-ID: <7c67918a-98e3-401e-b1d1-bd2f1e08b2ac@quicinc.com>
Date: Thu, 25 Jul 2024 11:48:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: prepare vif config caching for MLO
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240725094836.287448-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725094836.287448-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wrSKANme3x7uJR5lcCVIwYX7PcUhNd0S
X-Proofpoint-GUID: wrSKANme3x7uJR5lcCVIwYX7PcUhNd0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_18,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407250129

On 7/25/2024 2:48 AM, Rameshkumar Sundaram wrote:
> Currently vif configuration cache pointers are placed in arvif and
> caching is done whenever a link vif configuration is received before
> driver created vdev for it (i.e. before channel is assigned),
> this is possible because current code only uses default
> link(ahvif->deflink) which is preallocated.
> 
> With MLO changes the ieee80211_vif drv priv is now ahvif and its
> arvifs(link vif) other than deflink can be allocated dynamically
> during channel assignment. Hence maintain link level cache
> in ahvif and whenever channel is assigned for link vif and vdev is created,
> flush the corresponding link vif cache from ahvif.
> 
> Current code uses cache of ATH12K_DEFAULT_LINK_ID(0) which is the cache
> of ahvif->deflink.
> 
> Co-developed-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


