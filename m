Return-Path: <linux-wireless+bounces-24903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EEEAFC1E3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 07:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7661E3BFC26
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 05:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935CD1C5F14;
	Tue,  8 Jul 2025 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GDdw5m1s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD813B5AE
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951377; cv=none; b=On4W//jFyfmxeVc8LeR4DH8pdupHRCK8838HubLybpK45y+yq/T0Vj4X77aHUfKEvaXZmksv2/8UN4sYSDTLdvOaMpA0cBclTgzNOHiFHogzHCAdDcv4+LRDlNwK37yQDC+XGnVP3SMpMNdm2viFUYiUv56PPBVzd5fOkp/dVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951377; c=relaxed/simple;
	bh=dIG3D3ISZWDm1h3WWMPilDRSeEIDRRPG5W/1F/m4nR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MsKzO3AMk4rgfLEtt/jH5YecRtudgnRVAKdF1fj3pYFY+ZfLR1aDT1FxYoO3pA/xaoeTw5JYolTAl4RE7QRKwh/35db0s791PzQWF1O0x7gi9/0j5R8/WviyekutNJl7yA2MGpavvQaafaO3Zvj8hga12rtznP7vVesQoSiB3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GDdw5m1s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567KSNQK006944;
	Tue, 8 Jul 2025 05:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6nO29YvvxA3g37DZV759dO0hrJDh4lNF+Inrkz+JgWc=; b=GDdw5m1sHeLhIhui
	uZmpOM2+4YhkKMWWBc1qfUuJusuIuNBx3ZT28PxMgbdUXrsUubY5zt63k/iO9RZ9
	E3SizuUuVsSqtMxvdybUCuDh1rZc/ILykNM5JNIDRkvwO25CzRizLz+izjUVd/jp
	bMM51QyqyuqSEC9YHtwqm3619beYPpVhcFZXopdqIOpXVPYtjz9J7ufo6Wbj9zQM
	rbOvliG22JTf2DGS4qn3PExAQ61itCkD6eysMg06rW5wQaLkfF/DT/kbxcxzBa/s
	U1zBESMRt7ht/xICulCkhMRRu0eyJipd6vZVfchKYP0clQTmBcMO1Qznu3hpuimt
	Xiu3rQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wamde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 05:09:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56859SxW019630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Jul 2025 05:09:28 GMT
Received: from [10.216.52.3] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 22:09:27 -0700
Message-ID: <3298c943-c26a-848c-0606-915295241f86@quicinc.com>
Date: Tue, 8 Jul 2025 10:39:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: allow beacon protection keys to
 be installed in hardware
Content-Language: en-US
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250604101620.2948103-1-karthikeyan.kathirvel@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250604101620.2948103-1-karthikeyan.kathirvel@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ny80kNnzNPWP8Nbex1HB_LaSnTT_nwT0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAzNyBTYWx0ZWRfX2CI4vO8w4gDS
 XQrgcELS6l+lw/By6s8Q7lCs3e8QdXzIEoOyVdDTrQw4Ex82TRZsv2sRoTpE9XLvcBtwBXuQVrO
 b7R2eJoA/+EGq/dCscw53FWMJwdlwU5+mNaabeJ5zP/X5DzHtnIvOn4FNBKqk02vxRxHOmc6juT
 NM8cmggZcjx+svq46p+WiEDyIP24krLuy7LDbp3Wg11CINbOC66bVcCYb8ZtEPaV7vn+w+JRBk4
 95OS/eyuXCyJCuS86BxYOxzbMVYb7QgulC+Jp8AAdyuP7KQl0RZXEuYl447ItDvNUIDDjlNkLyN
 5VBcsnkN8dKB8Qxg21tm+ghs47LOcsAthE94BW0fSNw7XF1j6taLtMfn1D1G40ywW4jsuYznVHb
 63KRZO16vamy44dojLw8/P0LDQdemts6xtAwFijImEA9lkAn/mAl0+IiZHEuTDepTOthUr8C
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686ca809 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=pyrcEYqWyCnS-5z31K8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ny80kNnzNPWP8Nbex1HB_LaSnTT_nwT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=773 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080037



On 6/4/2025 3:46 PM, Karthikeyan Kathirvel wrote:
> Install beacon protection keys in hardware for AP modes only if hardware
> supports it, as indicated by the WMI service bit
> WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT. Allow keyidx up to 7, since
> beacon protection uses keyidx 6 and 7.
> 
> Control this feature by setting bit 0 of feature_enable_bitmap when sending
> the WMI_BCN_TMPL_CMDID command to firmware.
> 
> Check for the beacon protection enabled bit in both tx and non-tx profiles
> for MBSSID cases. If set in either profile, enable the beacon protection
> feature in firmware for transmitted vif.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

