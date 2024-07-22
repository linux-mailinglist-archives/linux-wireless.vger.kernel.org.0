Return-Path: <linux-wireless+bounces-10438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BDA9396E8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 01:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B3B282210
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84650A6D;
	Mon, 22 Jul 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NXkQa+w4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9345BE3
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690598; cv=none; b=SIpl/ohBIsG4QEsAzqGdagjH35B9frgZXFxvRch2P+CcWB3CXDPB72EIr50DZQGUJw5mmUfgkBwt3Q4GhtYE2Iai9o0u+fG/YER/qrnDr+Nc7xnB86Rxd1mbjqY9uj7NjPGyQe1ElYi6IeFlBFVyXXu90iRUn3CQIv7Q1FzrK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690598; c=relaxed/simple;
	bh=TqeR2oapmzfq+WxydFdZnQ+K9f3sB9RR2pSMFVghhfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V7LrV/RLTBnFlpm6Y+VYF+z5rQU8nt4F9NtA2rFYurN35rcNaL36rj8nB917aacMtU3b37KfBVMJjx3AVyaT543GgipTPUJcoyR9v3aF6OWCE02O0p6y6v+kGweYTjqL7fLA0IJ5RJQAukHKqfzPnf5jKHigZj5AFuFTl+9Gebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NXkQa+w4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MArQAC005440;
	Mon, 22 Jul 2024 23:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yTJNJO7nX6K8ALk5OD7mCfTxogiN2tYAJ6floJyReuQ=; b=NXkQa+w4Bi5FfhH/
	kZ7ce2IPY1XwSuuk+pvvrG6KOmzJd0nxoC8KmqGuvGWpwxFiamiM2xzNfKL/cohk
	8H9ZsE29bDxP7v5ZoA33ORqDzt7EF26SR15G5ydqTriHpGJhrddsClvHx/rRrm1y
	N2EYBtjH0StApz9tD3h9ErVpsX/oMKX4TmAo75/+qIUqqQtR9T8dvPX7nY12BAnZ
	6UKd/wwh2UGvvcbcjmKppja/1mktHZw1egPhL0cQJjNVhtnoTIYOhlp2DKbsL80w
	u32zrF63pUFdT1CBy9Mg6DkvFqqVZUWtAx7EOt6D0BsaB+Eeq9ZigYR6bPpn86Ap
	tfe0yQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487d2g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 23:23:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46MNNB3S021907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 23:23:11 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 16:23:11 -0700
Message-ID: <cb198e25-971d-4b9e-8e3d-1e9defb64c11@quicinc.com>
Date: Mon, 22 Jul 2024 16:23:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath10k: fix invalid VHT parameters in
 supported_vht_mcs_rate_nss2
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240711020344.98040-1-quic_bqiang@quicinc.com>
 <20240711020344.98040-3-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240711020344.98040-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U5MEANccvV52XAQtOdZvvb_TzryUj7-6
X-Proofpoint-GUID: U5MEANccvV52XAQtOdZvvb_TzryUj7-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_16,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=809
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407220174

On 7/10/2024 7:03 PM, Baochen Qiang wrote:
> In supported_vht_mcs_rate_nss2, the rate for MCS9 & VHT20 is defined as
> {1560, 1733}, this does not align with firmware's definition and therefore
> fails the verification in ath10k_mac_get_rate_flags_vht():
> 
> 	invalid vht params rate 1730 100kbps nss 2 mcs 9
> and:
> 	invalid vht params rate 1920 100kbps nss 2 mcs 9
> 
> Change it to {1730,  1920} to align with firmware, so this issue could be
> fixed.
> 
> Since ath10k_hw_params::supports_peer_stats_info is enabled only for
> QCA6174, this change does not affect other chips.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
> 
> Fixes: 3344b99d69ab ("ath10k: add bitrate parse for peer stats info")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/lkml/fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


