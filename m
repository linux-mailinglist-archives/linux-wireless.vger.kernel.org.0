Return-Path: <linux-wireless+bounces-9556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101E917076
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 20:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9171C1C2508A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81C17C230;
	Tue, 25 Jun 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MmillfBi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A017C22E
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341041; cv=none; b=GHZz3KCcpH+YUm86WJIQuRKSLwzKb3AeqSDdMRcDJ1wT+WEDvdreeQR+3DbM8ChV6XzUiu3YsMHrRVSqAwt56kw9QkHfH17S3kVKyybYtsjSZOwqQviXOW/L4facXfSM27fmSr9oClGroLTkybAV1MaaT287j8lRgrNYAvvfPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341041; c=relaxed/simple;
	bh=t6TkR+H5DNCzWC650/jq5F5uF/5AHYcyFbCxYuNd8ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UuZpvmJrIctQKyOFYH8Ggr9VhgqNh7Y9g6BHn8zDvpr3w3qKZR5jVeVpLfW1glr3QfzV6ejB4KGv8JSRAbNwkY1oCDwg2m+uhAARES/GjC3oe7MOWhIpCat+/8aXrnMfH+fShSvEros//o+//Iaq2uxGDMmAKrphgUiADUaZbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MmillfBi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PI4Uj2018138;
	Tue, 25 Jun 2024 18:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rk+yFXt4mGCCDdJUJyZW67O7+a6gk3bTrwwiN30t4t0=; b=MmillfBiHy/0xzS5
	rFzSB/Ih62AQmVeO4Sei5Vsk4ro8rplxCYcqeb2pWN1hXOkKlG5336Z4X4LogEjN
	HmePGmXMx2ZiLfMTF/pGhMQus0Dqzh4iigqsBnhEylSq3dOT6nNi0H2oqgANR4mi
	u/zlwT3atlzkuqUEg0LLiyf+ayOhDL0BXiPX9FMYLT+CmM1fwLBX7NIkzIxoyxt6
	8h5j3psot9zLnBJd5zdn5ly7b/HfqFbvcwOwvpq8nnL9/0RPT8zUlAL0JNF77vyc
	fROLTl0eYk9oCnrzo2Oh9XUj0UOeLOvVhnW5Z3e+RiNhNK27+zyLUNJM8+xjn0Ym
	+knZpw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6qb8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:43:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PIhsLg032715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:43:54 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 11:43:53 -0700
Message-ID: <49516232-ef06-4ed7-9c51-b36d38e4a677@quicinc.com>
Date: Tue, 25 Jun 2024 11:43:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] wifi: ath12k: export ath12k_wmi_tlv_hdr for
 testmode
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
 <20240624095305.37189-3-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240624095305.37189-3-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tp1RXFfrDYwq-j9Ifit0cPvmdZCTYSD8
X-Proofpoint-ORIG-GUID: Tp1RXFfrDYwq-j9Ifit0cPvmdZCTYSD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_13,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=786 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250137

On 6/24/2024 2:53 AM, Aaradhana Sahu wrote:
> Export ath12k_wmi_tlv_hdr() to further use in the testmode command
> processing.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


