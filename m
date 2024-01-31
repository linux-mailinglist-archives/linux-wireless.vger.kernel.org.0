Return-Path: <linux-wireless+bounces-2902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC47E84495A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7127B23B8A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C8238DF1;
	Wed, 31 Jan 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FovGJSHJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920738DDA
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735081; cv=none; b=GSTFNaNt+GV8SK0khxcMljpqq5e5d3ZEqVx7GgwK7eT11fpcL4gy6TJdsKhX3eix2dn0NuJR/e8Iw8Fh+pqpZXjAvvJ8+2N/YZczCSI5Z3KR0tD5xQqrh928n986Nd/l0pC8qQfl3yMqere8mBMCoNJHI3GDDziibjZuTmh9j6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735081; c=relaxed/simple;
	bh=6ulep5EsGpf+z1oiWhEah56SzGfL6H+c3lXikdiz4RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a+vJ9/VULft6hXzf9JYGYjtsWRSpsDVwhShEHu+CBvL+WAgCQoM6AxTHem7WMrLVQt5YALoTr3CsnCnurgA10QxqzgSzI36mRE8n6/6iTGIb0nnja/HT69xU9w2DyZMm935MR2RUKLzzfRSO59bZZqNfpD6sTW4WPcPUkR0ZQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FovGJSHJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VKIWTu002947;
	Wed, 31 Jan 2024 21:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VSmWxBVvc2xkcIX+gkx/UVrUWEErF1uF9lLFMiteliw=; b=Fo
	vGJSHJR9BSy1xHAsRlsvM+Z5hTi1Q5hOkqvl0ClYGRdTVk44QxEaU+nCOrHc45HL
	x8cfljH2bfWHCeB6jmW57F2tfzg1mh9lxiJkHGYqMNHFmIH1xelBiHoqdMyeGSaN
	OKTG+BxyDJ8WFmM/ApiekunRiSuJXDfe09uT9Wi7XNHL1FIQKx0FKbejN5lUWzNL
	h3kjvO99SeuF+WWovhwXujcExQQs589ndh6TujIs/9kko8yFQfSJXUT9eOvnujj2
	xwvsQw697GAkgApBXe0eRaIT15bsx0MNyhj0XC1W2oP1XB/krDUyZr9Wipj2W5f0
	Vd4DHWQU5ECMsPxDQm0w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vym2m9jbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:04:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL4Yj3019901
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:04:34 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:04:33 -0800
Message-ID: <8d804e28-603a-4f3e-b9ed-cbccfb16af50@quicinc.com>
Date: Wed, 31 Jan 2024 13:04:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] wifi: ath12k: indicate NON MBSSID vdev by
 default during vdev start
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-2-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-2-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gqSmUAxzGsR-2jPMg8DACjeEKjoQXEIi
X-Proofpoint-ORIG-GUID: gqSmUAxzGsR-2jPMg8DACjeEKjoQXEIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=574
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401310163

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> When any VDEV is started, MBSSID flags are passed to firmware to
> indicate if its a MBSSID/EMA AP vdev. If the interface is not an AP
> or if the AP doesn't support MBSSID, the vdev needs to be brought up
> as a non MBSSID vdev. Set these flags as a non MBSSID AP by default
> which can be updated as and when MBSSID support is added in ath12k.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


