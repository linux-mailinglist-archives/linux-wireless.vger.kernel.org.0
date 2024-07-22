Return-Path: <linux-wireless+bounces-10439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DB9396E7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 01:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C6B280D93
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80E49644;
	Mon, 22 Jul 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qx81uHzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47E481B1
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690598; cv=none; b=dBcSsB2iz65zbWU1lvLtyNYm1nASSKXtc+HRt49fub50wIFwh8/jbEqpAQc0z1PFXJmqz7vDZ53VRJgvorPG9zY9hjpCesYCa7yscfoezgfz/3cdPbuYP2AH8279yNqMcyopEd2OvPfwDOUU3k4FK6Q/gxWqtPxFbQj+Ri+UIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690598; c=relaxed/simple;
	bh=P1goCxwjpT5DzdG68eo4JSLhxFci4Zbt4D8GUq+ZKaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OXy3LVQf7NhOZ6NPGg9hb5w2BiMUZVmr7k522BkWuabU1Tl4ljbzkOaxKXCRBPJMXhJ6F3owR5/7GyZI445jwkFyAZr/dM5SOCcvg2sAo4cd2jMEcYfGd1i20sGXJSI411VWDSYhkFkg6h7TJG7phWCAT6W1MBCW+7Ol8Yq62lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qx81uHzJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MLcE11013299;
	Mon, 22 Jul 2024 23:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BKI+0YYPf0a/HqpDegYmr6hHmJIDAIHwcwCeskQ9xWI=; b=Qx81uHzJGplcfgqa
	ygAFaqofLWf2cU1aIMeh+82d4bm70hjrfFIAHEnY6oCoZhUNKlt6COtrDEryiWTt
	yRCro4Bn0x0tlJhPb7cxv5zSSxUa0QZsvCY+WgRw9vrNQokGCAykdiKRtnXiG0Dz
	aUg9eA19KWNd1UBtlvy/aLbXCN14wWOpFHmx21/uZ0EU72Gyi1OX7OdN1r1LniZP
	VE1KAHBMpk+01K1LVT/k9zUhBdZwRs9zTDhk7RBf1DCQk8FjD1k2eAGJIijmg3qS
	RVlm3OZyp52Z2X0njxkDwAFi3LUDOtqQjLm5dVO/hHqo8XJu3RnpPqh/nXRDmev8
	/N1JUA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5m6w44s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 23:23:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46MNN8B9028289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 23:23:08 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 16:23:08 -0700
Message-ID: <e18c35c4-c57b-444d-8f55-822b17ec8177@quicinc.com>
Date: Mon, 22 Jul 2024 16:23:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath10k: fix invalid VHT parameters in
 supported_vht_mcs_rate_nss1
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240711020344.98040-1-quic_bqiang@quicinc.com>
 <20240711020344.98040-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240711020344.98040-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lwNpHTsywc87ZrXFUDQdg4WWYnoU5jvY
X-Proofpoint-ORIG-GUID: lwNpHTsywc87ZrXFUDQdg4WWYnoU5jvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_16,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=874 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220173

On 7/10/2024 7:03 PM, Baochen Qiang wrote:
> In supported_vht_mcs_rate_nss1, the rate for MCS9 & VHT20 is defined as
> {780,  867}, this does not align with firmware's definition and therefore
> fails the verification in ath10k_mac_get_rate_flags_vht():
> 
> 	invalid vht params rate 960 100kbps nss 1 mcs 9
> 
> Change it to {865,  960} to align with firmware, so this issue could be
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



