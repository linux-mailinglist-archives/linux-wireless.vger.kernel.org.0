Return-Path: <linux-wireless+bounces-1594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D68276B1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 18:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808861C21AA9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7254F8D;
	Mon,  8 Jan 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fFBLK6g+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D654BD3
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408Ej50l023547;
	Mon, 8 Jan 2024 17:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OJ5Cxm5UlnPCIE/+NoU4vrvM4xh18aVN066891HC0wY=; b=fF
	BLK6g+ysh3cL4HdJo3rYYph+DBnjp2TRvzFpbeMDafaGaqbBUgMyqkeARu85B75t
	aP/mSGj7hM2B8EMA2z1/1oiHd44+g50IduZERzK66xKc6ARqvfFF41FbN3Z8SouJ
	zUn9/p8MingdfM+Vr6zR6NYJwC8EGfWhOiwbz7Wx0Nc02tpGYpfDp4PBIMC3+t/E
	8zoir1H07eUyNXEjPjCEVYyfGhXTQWvN3j427Iy/U4Y9i1oC5DDKWFcrD+tJ1ytz
	qY7ReN3wfgDDH3XfYyUWc1G1FlkMs9+V3yIIk3IAIFwRyPxeZHriAReh3UB8lohP
	5IB24M0H5yqk3T/Zymrw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8n09rb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 17:52:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408HqjNR001254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 17:52:45 GMT
Received: from [10.110.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 09:52:45 -0800
Message-ID: <6fc15b1d-b8a4-40d2-8c6a-857dcaa0ac96@quicinc.com>
Date: Mon, 8 Jan 2024 09:52:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] wifi: ath12k: QCN9274 dualmac bring up
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jq-mpVfIck8yLounE4kwvilBy1RuXGPo
X-Proofpoint-ORIG-GUID: Jq-mpVfIck8yLounE4kwvilBy1RuXGPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=467 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080151

On 1/5/2024 11:56 AM, Raj Kumar Bhagat wrote:
> QCN9274 Ath12k chipset can support single-mac or dualmac architecture.
> Currently, Ath12k driver supports only the single-mac QCN9274
> architecture.
> 
> Hence, add support for dualmac QCN9274 chipset.

Can you please have the WCN7850 test team validate there are no
regression issues with this series, and then add their Tested-on: tag to
each patch?


