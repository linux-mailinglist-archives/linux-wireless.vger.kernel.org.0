Return-Path: <linux-wireless+bounces-6737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A818AF711
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 21:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A1AB2744D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5913FD65;
	Tue, 23 Apr 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MfSPOj59"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439B23741
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899570; cv=none; b=TQ6EX9H/YOcvNlGKvDdl2Oe5HVcT3dFxaO3mncb/6rpSNmRq8ugU53KQ2ZSG7tnW23aFsx9baQpR21/BaCWWFDxtW2W/1ictRBUS9Lo6BxiEwdHu5pimdLL7zL23I+mgV7d26t0/yRwX5Ql/74OZz8PitSpL2FnxRgdd+6dEOOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899570; c=relaxed/simple;
	bh=3v8Fkd4+FNP10PBahzQd1I40VWFHFO9GBoCNZvPzvOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OdV60A5AYIt+kMTIhOwol7BpwhvZ4H7PbIEgZCIZKJU0JUm7vnnoWONCzV4PG7SqikpRkrkcZ02xgpYtTv2mtoduEqPLIRTSDJarmdONl8pH9Rm1jM3GFtSY1OvU4bqFe2LufWo4fw/gTv2NPRf8vVtBIYm63CzRLIa6Mi+EhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MfSPOj59; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5eqB5027978;
	Tue, 23 Apr 2024 19:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3v8Fkd4+FNP10PBahzQd1I40VWFHFO9GBoCNZvPzvOI=; b=Mf
	SPOj59ZUILU8VFfRyL8b79Lr2DzJcfK4003t1zMLxJH6azxonjCXbXE1L81EfQbH
	VCiJRDeKMPdIDDflMuxR0UUQcS6fpOCWxx2Zgn0Tn9ubY0QGEAmxTfvQDMcA/Fqz
	dlvLFRCj73WpNcvLdJ+DPndGk4ZXA3Fyd6RJxRU/9v8w3P+0v6vRqVmOnHfRjWos
	Z0cZTaqrhJZstSE66njZfp8VloKmJtyAzJ2TaL2q2174PCL42+Oj8a9Q4XoqbOmj
	qjcK8uJhUnsTBeL1XORFe9j+OtYdw+APkuBcXSGqMzZx0nZZbHQzezGdOMyG99sh
	T7L3lv288P32DsotLUgQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtnbcwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 19:12:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NJCYNI017115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 19:12:34 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 12:12:33 -0700
Message-ID: <7587ecfc-e580-488f-b74e-20e2c115df93@quicinc.com>
Date: Tue, 23 Apr 2024 12:12:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: Update bssid indicator with real BSS
 numbers
Content-Language: en-US
To: Allen Ye <allen.ye@mediatek.com>, <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Evelyn Tsai
	<evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
References: <20231208063820.25983-1-allen.ye@mediatek.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231208063820.25983-1-allen.ye@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bLOI3Jz49yo95IjSGPRxuKPJloMHG6rJ
X-Proofpoint-ORIG-GUID: bLOI3Jz49yo95IjSGPRxuKPJloMHG6rJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=663 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230044

On 12/7/2023 10:38 PM, Allen Ye wrote:
> The cnt member in mbssid is the count of total number of MBSSID elements
> instead of BSSID. Therefore, we fix this by reading the MaxBSSID Indicator
> field directly.

Commit text is much more readable if you somewhat follow the guidance:
Describe what the current code does.
Describe the problem with the current code.
Describe how to modify the code to fix the problem.

And write this at a high enough level that a manager can understand :)


