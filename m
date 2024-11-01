Return-Path: <linux-wireless+bounces-14827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD19B9525
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30AC2811D9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4F1DA53;
	Fri,  1 Nov 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d8X00vwp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DC1798C
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478119; cv=none; b=WuMhE1e7kksxz5wGaXMoff+WUqG0hSmxW8vhiVXoNZss9vRmqsXBtsRccGTDnBAlW7jMN/X39voO/V4gLZ+V7CQxk/NtivxwUXVB3LDPrHDRNGM9iE9xTLKysilxIHRWDcxMV4JrWM56tWaFJhRq45pxP/1+QB4EhJ1eeOLjjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478119; c=relaxed/simple;
	bh=PcWheD0yKW/nv54LKZVDU90NERxT+bZjCLXnoxPT/Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nhv+5fdEHuETUv9rPdYDSHCOF61X9y+6VP+mSIMPl/EUDJHJDkSDRpcwIn8jTAajzSlhN4LEHfSn5jm2T37hHrAsS+zz70KTwCW9Cign8nYvKIFwDAUd/ToUEgEIWKp47Vpkrn4cUIy73QEP4fz/rJHjAXBY2kFrWzfwXPNNt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d8X00vwp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A188NSK027265;
	Fri, 1 Nov 2024 16:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OECpEb3C40nifqFFTk3EVE+l+oT1aG0eXSibUIjmFCw=; b=d8X00vwpzW4KcEum
	imlesbZ2D6juxi6iIo4T4KkP7aeHWidsz1VjTYNx1K+oClFIh6ulhUFf6xIVdaLv
	QIL25bxyW59IKXt4f0dX+6MU/ZFcdzAsvV7nDUQNFAmmbvj+6uDtnzUxjps8CrkN
	5d5puFsmYhFbD7Tuh9MZ/+civr38XnAvcrDWsCvH5jXw48XJ9djVLIux4JOBDg3Q
	I0iICWtQInI2GKmW5jNKKPrc8EyM0fOQWrqhsRJQFB1rx65fJRROtgLm7vIYGW7a
	pFzkIEalat9u5ShwwmmhOmW2UYDh/L32Pl37euRCJr7ZdvE2WtgK6opFMHXrbmNC
	ZnR8ng==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42mu7c9hnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 16:21:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1GLnuT007623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 16:21:49 GMT
Received: from [10.48.242.225] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 1 Nov 2024
 09:21:48 -0700
Message-ID: <0f1b2f1b-eabc-4e96-aa4a-1372db571588@quicinc.com>
Date: Fri, 1 Nov 2024 09:21:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] wifi: ath12k: ath12k_mac_vdev_create(): use goto
 for error handling
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
 <20241101151705.165987-2-kvalo@kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241101151705.165987-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1JJIrQc8AkcVMA7ZdSVLLHXtDmbIw72G
X-Proofpoint-ORIG-GUID: 1JJIrQc8AkcVMA7ZdSVLLHXtDmbIw72G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=724 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010119

On 11/1/2024 8:16 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> In commit 477cabfdb776 ("wifi: ath12k: modify link arvif creation and removal
> for MLO") I had accidentally left one personal TODO comment about using goto
> instead of ret. Switch to use goto to be consistent with the error handling in
> the function.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


