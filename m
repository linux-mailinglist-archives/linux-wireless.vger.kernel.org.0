Return-Path: <linux-wireless+bounces-3046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6DF84763B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 18:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711E1284643
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7142A14A4F4;
	Fri,  2 Feb 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nlxMLATV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227D14C58B
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895324; cv=none; b=fo8DX1H9ygsC3xiqTWrZ0isLJZWdmmxbX8WgIHwLsATG5huHpMN+WAId2UV4/IEoRx5gxDU+e9ezsNHjPi0Wbk7pbot8cs0SI5ryt3NVaYvwqWyAIDTnEXrjGIw9dn0jdgQ+xNDdhPErAtr0Ud6HzY6tIsE3/Cpy1V94t9iqRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895324; c=relaxed/simple;
	bh=/Dmg5Oass4Znr75cL/3jRW7o4BEB8ohPrEDNsT568rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YB4KenN51qLm1/YcgHSVDY6+mdaSU//Zld+urHyhnVEbU7wU8QWNUWFjVslLEe93DTPsef7RhoYpUXLHAOs6wbAvr5a+XNWMAatxPlz3I+ccDDpRQB9JhgXVCQmmMYQ+q0yRUA0VixVlNXyEkl+uLWFnxJj/LM5WTjIXFPJseUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nlxMLATV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412FCDeK026775;
	Fri, 2 Feb 2024 17:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=n6KP2mUsnd1Bgsgcfi/Gkn3F+8FvYp93hGgnFi5fB7w=; b=nl
	xMLATVzYwwoh+EfbiUpLlLdsILUHcbx4HCYcixALDQaK3hf7u6WZ+N9d6/q6Qgzn
	nkhPur/ykhKE5unWE8x6WbBMMEvGyOLs/uUBwe1AszRbgynNEgBPFj4AMLJrYGjl
	aRmwPYbcIAi3UOH4Arc93Ia7wcAs71YbAJqBJ5OiJs9pc4I2he2TWcXkFfSae7B/
	nDEkYYvXdbnSAG4ux7Rmprx4EJCLH9fMnA/ItnsSTd7gW88tktvU4jSF+trxTYgL
	EhM6iwSgfDDSbVLyB/eEd0B2ktgwU5jNkAP/MpB9aQVNMoZJzYWem6IIcnjmD0//
	QSKH5kfsMeOQlzVUFztg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwm20eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:35:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412HZFpw024085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 17:35:15 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 09:35:15 -0800
Message-ID: <d9b3261a-549c-4db4-883c-75e17de3e1ee@quicinc.com>
Date: Fri, 2 Feb 2024 09:35:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before
 use
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240202023547.11141-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240202023547.11141-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DmnHWDkETyfSXKDDpLQquEEuXuVlXlB4
X-Proofpoint-ORIG-GUID: DmnHWDkETyfSXKDDpLQquEEuXuVlXlB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=402
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402020125

On 2/1/2024 6:35 PM, Baochen Qiang wrote:
> Currently in ath11k_peer_assoc_h_he() rx_mcs_80 and rx_mcs_160
> are used to calculate max_nss, see
> 	if (support_160)
> 		max_nss = min(rx_mcs_80, rx_mcs_160);
> 	else
> 		max_nss = rx_mcs_80;
> 
> Kernel test robot complains on uninitialized symbols:
> drivers/net/wireless/ath/ath11k/mac.c:2321 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
> drivers/net/wireless/ath/ath11k/mac.c:2321 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_160'.
> drivers/net/wireless/ath/ath11k/mac.c:2323 ath11k_peer_assoc_h_he() error: uninitialized symbol 'rx_mcs_80'.
> 
> This is because there are some code paths that never set them, so
> the assignment of max_nss can come from uninitialized variables.
> This could result in some unknown issues since a wrong peer_nss
> might be passed to firmware.
> 
> Change to initialize them to an invalid value at the beginning. This
> makes sense because even max_nss gets an invalid value, due to either
> or both of them being invalid, we can get an valid peer_nss with
> following guard:
> 	arg->peer_nss = min(sta->deflink.rx_nss, max_nss)
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Fixes: 3db26ecf7114 ("ath11k: calculate the correct NSS of peer for HE capabilities")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401311243.NyXwWZxP-lkp@intel.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


