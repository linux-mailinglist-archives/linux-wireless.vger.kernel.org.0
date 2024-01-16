Return-Path: <linux-wireless+bounces-2059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3914E82FBA9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 23:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDAB1C23735
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAAB67049;
	Tue, 16 Jan 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZyiXSeBd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612867069
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435476; cv=none; b=LXtbJQ6q95XEbYZ5Oz861PQm7rSoGTLCh62tpy3cIYswK3IkH5YIOGW5raTKfL65rSpVZlYBflp7JABsOxC4AX9feMnPXY4MFaXI+PPSkTq5Fl+ULmDd/LE+Z+8WQc3tzjjs//KKssTqmSbz7Ptu9SsQIYKHeUOuGjXnCOgupFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435476; c=relaxed/simple;
	bh=wa1V2GkipVVfoEPy+xFf0pJB1DcmBtp3oAjLnuUjxCc=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=ZZ5BA2qNi66OWEKsljv891ID3J8GRJwfZ1t7bcUGr0L2vlcw1XKiconE7A8res3WDZuaXan4sRQri9LElqy90yJVl5gy1NubDXGaHh62F9lyqNIi2FqgKqvnCHYIsWitfuJpqCuWKHWkeTe85h/ximRccJGK2QKIBq+ehZUqmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZyiXSeBd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GHtivH015885;
	Tue, 16 Jan 2024 20:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4ReoGPfYklfwCZlaqdmEKibjC0wze4T4BY193JwG4r4=; b=Zy
	iXSeBdoYAUyYrJozQwtyUk5UeoifmWtPOncDOrOZH+No+yjQMUb4DYWjtPYOtZnx
	gRCJvw22AwvZE+v/bqW0xuRq+KUtDZViIHt3R7QRWWrYfGwpxVxTGmseyu26MpDy
	9M6bzQ++9T5+AlanbY1KrwxwJLP5Q94sjmduhIbqxzPDw2WH1InOMHqMkQof5JFo
	sw/vbOqF+XUuNVBdhEFm1dx5oqk9Id3SKqMT5LsxyvIsHf3ZpsHbGPegnWXvTngw
	q+b1eQVX/3hfegirQ7RaZCrg15DtfnjE0MCbw0fQgMvT4zNehnBU0tRWYwvDjbQ8
	zyMZ/ZuZ3KMkVo1JN/cg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnq4t1kev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 20:04:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GK4Ouj020803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 20:04:24 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 12:04:24 -0800
Message-ID: <f3822735-8366-47b6-be78-af09aee0307c@quicinc.com>
Date: Tue, 16 Jan 2024 12:04:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: do not process consecutive RDDM event
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240111071406.14053-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240111071406.14053-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q6hEjz6xJjNdNu5AOsG4nepxsXNe5Z2x
X-Proofpoint-ORIG-GUID: Q6hEjz6xJjNdNu5AOsG4nepxsXNe5Z2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=655 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160158

On 1/10/2024 11:14 PM, Baochen Qiang wrote:
> Currently we do reset for each RDDM event from MHI, however there are
> cases, see below log, that we get two or more consecutive events, and
> it is pointless to do reset for the subsequent ones. What's more, it
> makes reset process more likely to fail.
> 
> [ 1502.115876] ath11k_pci 0000:04:00.0: boot notify status reason MHI_CB_EE_RDDM
> [ 1502.115884] ath11k_pci 0000:04:00.0: firmware crashed: MHI_CB_EE_RDDM
> [ 1502.224041] ath11k_pci 0000:04:00.0: boot notify status reason MHI_CB_EE_RDDM
> [ 1502.224050] ath11k_pci 0000:04:00.0: firmware crashed: MHI_CB_EE_RDDM
> 
> Add a check to avoid reset again and again. This is done by tracking previous
> MHI status: if we receive a new RDDM event while the previous one is
> also the same, we treat it as duplicate and ignore it, because normally
> we should receive a MHI_CB_EE_MISSION_MODE event between them.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


