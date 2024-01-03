Return-Path: <linux-wireless+bounces-1450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B382312F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD7B1C233B8
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D41B296;
	Wed,  3 Jan 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X07PmXVr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA31B297
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403FqJ7j006414;
	Wed, 3 Jan 2024 16:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0iMW22XVoA5EYuKjSRktWPaoevirJknKUkzcyB462UM=; b=X0
	7PmXVr/4W8fMkC/f3EtNMucgHJr3eTLWjBWLz8sb932HpLbh32M357LACTLgBqtT
	YBLuEuxFF4nQCdh0rsukA1cjJUeyhbqvHcN+3NjSLQNmwgItVg76s8fVfN2/4X9w
	JP1ega2oyRBPhQ+S5u/+K8Iy7XTnnIJRO4g51bR64dsiD2wHtTOccqnDSDTMRP04
	t0tB2goRHFXZWZpT8Z2Ksw8rXHK7WU3D7jNu+ToyNNsJm2wMsgGD3GSV2d7m+PFp
	7raL2Gb8I71IwG/fXSlFi/iujoMomzANKgQPpRZbjjklvqEAOgSRZovkjqFmHn0I
	Cngxzh7m4mN7GEd77ScA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd2tm9bjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 16:23:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403GNNgP022873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 16:23:23 GMT
Received: from [10.110.76.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 08:23:23 -0800
Message-ID: <0c12c1f1-6952-4ae8-8875-81c149ab430b@quicinc.com>
Date: Wed, 3 Jan 2024 08:23:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240103041220.3082014-1-quic_periyasa@quicinc.com>
 <20240103041220.3082014-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240103041220.3082014-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dfw1Fny-ZTpLkdr9fGY3wQrYBU-a-kXp
X-Proofpoint-ORIG-GUID: dfw1Fny-ZTpLkdr9fGY3wQrYBU-a-kXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=365 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030134

On 1/2/2024 8:12 PM, Karthikeyan Periyasamy wrote:
> ENOTSUPP is not a standard error code, don't use it. Replace with
> EOPNOTSUPP instead.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


