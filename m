Return-Path: <linux-wireless+bounces-2588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612283E873
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EF528491C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2E257B;
	Sat, 27 Jan 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WDST7i/k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B22573
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315188; cv=none; b=PalwvDvm3vZgvekMMLuqKD7q53KJT+SHYtx7IA0ay40tkmYl+hvqoO5tp+t7YrcwiZv2mrS5ySR5aW5+jrF6m+pVAl1UK122SwrRJh1WRvrgB1WkGxbnS9z0MEjrv60+7FQjr1YgZsyDzGV1rexiOyyrntGdYiEoIQX5U8OAGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315188; c=relaxed/simple;
	bh=aAbqAq1G0l+3iIk+6DiTmMP+o2+GzPV8LZjneDDrp7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cDs+y1WqOUD3Sv01JNGcmKIDIfM/g+Hm1zNzd+zYHkBayVGRX83rbUVyTiWopobJJVQdsWzA/kDh+3OSvXQ91rz+kXHOB6VOrcSePdfAvQh8BjXLF61zGzQ79fwpnHFbXVAIlI/RC/xG3M+eGd9vQ0x5u1DqWnxb80NdLhhkzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WDST7i/k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R0K1JY021212;
	Sat, 27 Jan 2024 00:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pkXNXGewLkSwd4mM9yX4CC35BdWPH8+PA49o70Klfmg=; b=WD
	ST7i/kebNNGhjJymUXz/eGpVtMCgp6sfnAJeVKYWuF2v5hgeUwThtmfl5HWtDc1g
	NqIpDpqM7ceKqt4fyqMfeGh/hwZ1fMQbTxVBC1ErT1nQRq2Ul6POKcs/taKLBrP5
	scL5SNix4BV89JNgqVHf3VXZjUSF/DE8S3kQuqzhopm4wjBADHUwlK5CCuYGVBPD
	rge7JjsglNh90QiFmaDaxTi6/UGxQFXAE0fKRTDnn0Y+s6rIZ/vLNwR11V8rogyy
	EN5l3Wcmd4YE2IeoZol9YnGKHeAyHzHokUcFAlQfqodYpjXIfqRNeqEAonJKSOzT
	uBk5V/KFRo16r3qWQsbQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvq6sg0au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:26:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0QM6p012900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:26:22 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:26:22 -0800
Message-ID: <eb8d93e8-ac2d-484a-b97c-4eb21fb74d1e@quicinc.com>
Date: Fri, 26 Jan 2024 16:26:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] wifi: ath12k: designating channel frequency for
 ROC scan
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-10-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240126115231.356658-10-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V-t0whNYYwynU1Nrce0-uEUnfysYN--w
X-Proofpoint-ORIG-GUID: V-t0whNYYwynU1Nrce0-uEUnfysYN--w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=853
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270001

On 1/26/2024 3:52 AM, Kang Yang wrote:
> For P2P mode, the WLAN interface may be requested to remain on a
> specific channel and then to send some management frames on that
> channel. Now chananel frequency of wmi_mgmt_send_cmd is set as 0. As
> a result, firmware may choose a default but wrong channel.
> 
> Fix it by assigning chanfreq field with the ROC channel frequency.
> 
> This change only applies to WCN7850, other chips are not affected.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


