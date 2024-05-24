Return-Path: <linux-wireless+bounces-8046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA3B8CE8A1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 18:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9841C20ACD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 16:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAC712E1F9;
	Fri, 24 May 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M/cFfa7y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A60126F06
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568073; cv=none; b=ThSSDpaFy8FhskOajbvBq96arB6vikCe9f/kpxHaMv7hDeDXAd7bt/YO4KA3BnBtIpg4HkGhitwGEq9qDNkoFAWrsjH0ad+bEHbnxTglGXYlUr3OG1QG2D+Gcz0NHa9d55QmgznNqVRDhEoYh6DiswwuhVi7QPrs4PDcAtbHVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568073; c=relaxed/simple;
	bh=mMfmZEFKQYORJPCP1Gva0tD4/BNYWayeteSvtkEYGGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D4MyL52A1j08euHqRUZ8s8GdDx+8HRX6Zd8U11OpCaDpaVv3RxD9e2HajSI0E9bHhht6PIBtVx9jxRE/AF4KrNERVJvXGcOu+WheFHAlYc9lM2lNxq6y5kXboooHIk+UgfzJ35i0WMi8t1zmtIdR+A9DfUhbP3Kh1//LYi9NDxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M/cFfa7y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O9Ck12012370;
	Fri, 24 May 2024 16:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7H2CMLcz4w0LrB0+lpDZ994mnA5ZLqOXlT9kIlNKna0=; b=M/cFfa7yUClaoJC6
	y1Gh8HJn+aDFmNDyo2vXSrnie+Yisud725lwXarfjg7b4sYSplF0LbcC6AFK5DKB
	6JFdsrroNmzitc1dpcBXM35Bbdo5LROM4iF4P2qS3y4syUdY1jC08Pw9QnpOd6lE
	SN3dTD3lPlY6iZPQOpPIprPn3xftmEMVbhjsrSGXi8KhCzED5IyBNqR/hiNBUWAt
	2goagYaY/vvyQY+/powLjxB7Et3166u6CM4tZdvvmiVQN1UHJ0j4vRMvUsFic2dm
	g8/Gq5Rv0vQLmLhc+UG9dzbgEy8rwf4RIZsmonEa2pzg9xhclXYIOxx6HQRM+UV9
	+kRE2w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8htyxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 16:27:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OGRlER012634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 16:27:47 GMT
Received: from [10.110.127.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 09:27:46 -0700
Message-ID: <1a29a21d-fb3f-4b0b-a720-6f005608990c@quicinc.com>
Date: Fri, 24 May 2024 09:27:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix wrong definition of CE ring's base
 address
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240524024021.37711-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240524024021.37711-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jg7xt9BT4fife6WFyYRDBX7xgQ5avdJ8
X-Proofpoint-GUID: jg7xt9BT4fife6WFyYRDBX7xgQ5avdJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxlogscore=879 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240115

On 5/23/2024 7:40 PM, Baochen Qiang wrote:
> Base address of CE ring is defined as u32, currently this works
> because DMA mask configured as 32 bit:
> 
> 	#define ATH12K_PCI_DMA_MASK	32
> 
> However this mask could be changed once firmware bugs are fixed
> to fully support 36 bit DMA addressing. So to protect against any
> future changes to the DMA mask, change the type of the fields that
> are dependent upon it.
> 
> This is found during code review. Compile tested only.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


