Return-Path: <linux-wireless+bounces-3047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329584763C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 18:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C551F2E2A9
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62BA14A4DD;
	Fri,  2 Feb 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V9gs43fF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28E14A4CD
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895341; cv=none; b=AEdPF0SkRJ4yZR4/iV3Xniu3ba06AOvaWYv5ItHJ14okFVJDye3R+NLJ5Zj6/X7xHTP/RkoVhjp4rXkEDc7Nu7w1rxBlH8gqt2ebHc6YlcTJOIwiSdg9wBQvhuGSf6zK7I7KCJN34CQfkBFM347R9JDNr2yLBJ9Qrncinqhzmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895341; c=relaxed/simple;
	bh=rBBZUG5JwSLHIHhLFpBaGdY5ZDZRk99sPO0Okb1rIgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ejCmp9C6t+gVUBY6qbrASwOp9dVFOgPuiAtaZEFQeN7gouzieehObPSo67HKQKB/lG8vxSWm+Qoab/yGXgkMXH7DmxxaZYtXHTISRvAwcTfeRYiZNFn5JLn09foSzcvCb7KhPSrlrJJHhgik86xa9He2TKzgPRF5TtTQEMn6l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V9gs43fF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412FxVR5027811;
	Fri, 2 Feb 2024 17:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rk7BwcRvegcVOez6WN6YBR1Lo3V8ZCng/o8HMDa3jAs=; b=V9
	gs43fFWHziKb09WVYNcm4zEo7vih/JEvL+/tS+WnUGgaSzXqtUc+ZpexvqjqwmzL
	hFtjyLfDw/XE40Fvjuw21M539TS5nBLvVN7XpR1+qHMoYaYzrkKY3mcheR1cSHnx
	OsLn4yLwtHLmDsuAJJk0gjJGJb3xCqtsuTpAOxL2tjQaLAUl3a3lFhK7V4n44JlI
	47o0LxVXAResKJP40UJOar4HXQ79w0wfEtuVisjzSVmN4NA9lKO1E9hc4/x9rsgS
	DfkEkrlH0/nSmCGylkJPWsrUW9+Cj2AlK6RedzYJzDHKrBudcECuZg6fynEJ4NGn
	IaHaSnL1iFhIG5ea8TxA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptvj04c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:35:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412HZVS2016696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 17:35:31 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 09:35:30 -0800
Message-ID: <acccf6fa-6a99-4909-97cf-da5e31a171a6@quicinc.com>
Date: Fri, 2 Feb 2024 09:35:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: initialize eirp_power before use
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240202024011.11341-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240202024011.11341-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DjOtAFSEt8bmk67x5Powmtrh4KZVdb9l
X-Proofpoint-ORIG-GUID: DjOtAFSEt8bmk67x5Powmtrh4KZVdb9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_11,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 lowpriorityscore=0
 adultscore=0 mlxlogscore=189 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=1 impostorscore=0
 mlxscore=1 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020126

On 2/1/2024 6:40 PM, Baochen Qiang wrote:
> Currently, at the end of ath11k_mac_fill_reg_tpc_info(), the
> reg_tpc_info struct is populated, including the following:
> 	reg_tpc_info->is_psd_power = is_psd_power;
> 	reg_tpc_info->eirp_power = eirp_power;
> 
> Kernel test robot complains on uninitialized symbol:
> drivers/net/wireless/ath/ath11k/mac.c:7949
> ath11k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
> 
> This is because there are some code paths that never set eirp_power, so
> the assignment of reg_tpc_info->eirp_power can come from an
> uninitialized variable. Functionally this is OK since the eirp_power
> only has meaning when is_psd_power is true, and all code paths which set
> is_psd_power to true also set eirp_power. However, to keep the robot
> happy, always initialize eirp_power before use.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Fixes: 92425f788fee ("wifi: ath11k: fill parameters for vdev set tpc power WMI command")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401311243.NyXwWZxP-lkp@intel.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


