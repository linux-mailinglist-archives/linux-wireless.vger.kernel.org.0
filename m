Return-Path: <linux-wireless+bounces-3483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010F851D54
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 19:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26F01C21F03
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720F3F9EF;
	Mon, 12 Feb 2024 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j3zYjbvx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8EB46544
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763876; cv=none; b=bB0SOyhu4YljiagUIz58TDnXB6L5ZWUe5ogsEA3oH0CgXpvHBiIz7wzcOhIBQTwCgHqogezyilQjhui7Rbm2VFG4eLgee1hVKJ1gJ83I4WcDW0TYbpi+WuQsxj4rCZOLz6Zqk43DgkyVK7uvAgMhUYURzVZBeU3k9IE6kf/yDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763876; c=relaxed/simple;
	bh=mqaGR5DIDIKRZcGY6bZoYuiBBP2/kWpGz/WrdbwGaFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DJu3k4vz4VFgITVtvh62nVFQ8EOQxwltFACYPO7/Z6FQfqzxQyYpEZRjU44H/OaJqsey69PxkSmKkEZuhPA2OyGPpguqU7jr2brcC+mZYgOCCPopacgCdF5uarwEU+M5vIjRrrg5OXTw9VLg+pDHr3R+NMJjpvD5xiOQDtGrQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j3zYjbvx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CGT8QR003794;
	Mon, 12 Feb 2024 18:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iNLFPIB0kip7haSFEstgqeTp9AVQBoSxPW72xcS7JU8=; b=j3
	zYjbvxk93YW7oia3NXnsJU5DEZUSg4VioZuoqSxW01tLQRkjCvOabSq+bQsNK3L5
	ux04UzPmQOdTaSZa25OVUlsxOrmFswqZcHwkAY5+fnGUL02vvk+q9E5o4aZ0Igiv
	XxhgiHFAb27Hr3StSU+KZjDzQnHELy+Iv+mNMa0Y/XZxAXzDS2gxihcAN4WFdkP7
	N33WjUEUatkvyNuuldefMHh4PtXIh2vM5qjrxu0LpfKy1nTrP/zJorOyQNUbMh8s
	ZTOSDzak+pgB/yRVAP3O0F7DvIq7YXxJiTBkfXeR8U9hwYyqtQWhQc/QfHIm681L
	jcuBZ8YW6eWt5xvK+ZZA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gs1h8tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:51:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CIp1Kl029814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:51:01 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 10:51:00 -0800
Message-ID: <51e12308-4e5c-4f22-9288-d3efb3c81d64@quicinc.com>
Date: Mon, 12 Feb 2024 10:51:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: remove the unused scan_events from
 ath12k_wmi_scan_req_arg
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240211151104.1951418-1-nico.escande@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240211151104.1951418-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZssOdssODhGdPW9pF2lLGcUbf4XgBDzy
X-Proofpoint-ORIG-GUID: ZssOdssODhGdPW9pF2lLGcUbf4XgBDzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=688
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120144

On 2/11/2024 7:11 AM, Nicolas Escande wrote:
> As done for ath11k, lets keep on cleaning up struct ath12k_wmi_scan_req_arg by
> removing the unused scan_events. Also remove the underlying union & struct
> construct as it isn't needed anymore. No functionnal changes.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


