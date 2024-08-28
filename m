Return-Path: <linux-wireless+bounces-12175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E5962BE6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC31285DD7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081D1A4AD7;
	Wed, 28 Aug 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fUbZQBpK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899441A3BCF
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858139; cv=none; b=pCWxXNNCpTX6mWfE1fos8mk/HueoVFwLEOmUa7IpWvtp1SVsmr9sF2grrpaJZDD+DO2Ghl64ySEBC9R7eeJFFWfRDfHzwVzMAiwZ55FUak84UNLyLrS8u2fPlw1WKtejygkoSzyV7ZfeYavCWkeHTgkuBDsnnMFoOvPh4Hfm7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858139; c=relaxed/simple;
	bh=a0z6lBlmdnd7+IIz6OHPyjCw/REF9bRa9vagPVp1tH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uXWB948glprn2BdL4Fj2arjM1GknkEByjbBdNNZLsmx2jWPS7li6nFFjAlPaRDKb9UyoCXDeiJjgOseucm982Z4XDVUDamJWYxtIt6DAFzBYJgpeQailLyeqOhEgIlruEAQmljmXqHQSThPiHPaP9+1BrNrY4EtiIzHiSD6Qw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fUbZQBpK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SBHSc6009010;
	Wed, 28 Aug 2024 15:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fz+jyOUHiqicb0q5TClyvt2Yxf+WHzOKQwY7LgY+Ep4=; b=fUbZQBpKXEJXXnzE
	8tDvYIuIJEmxN7g3FJ26yb3ZDer3M/s/z9VwQEXuWFmzfktfNIAVr/mZV+oOFPIE
	RaqPwmQUVF5QnSTy4n/h/El7A1L+LvQBPm6vqANfCpR4k8vh51djc/rd73mRbp7z
	/lD7J+3/BDuhMFhezUlZxW04qJJCuHBHL3fLZXWYg7KjvFFvhAB0lSqhN0FTCTE2
	ILS21oZLbnE3sFGUduh2g4FFABiprODqSAGHVRvjrmfZ6yVWrH/Uhz+rCgwRFoda
	vpMINK143Fzl6U+t8OxToDK4PFAe1skFme6qnZUGmnFI1YKEEVoLbqzKiazR4dP3
	aaaF8Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419px5j6rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 15:15:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47SFFFNw005701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 15:15:15 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 08:15:14 -0700
Message-ID: <6c525c85-1439-4a5c-aacd-f094dd882180@quicinc.com>
Date: Wed, 28 Aug 2024 08:15:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: enable fw_wmi_diag_event hw param for
 WCN6750
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240828103043.2413-1-quic_bpothuno@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240828103043.2413-1-quic_bpothuno@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xTIcptSioBqdMBYmmYc0IaakWYsxvmj0
X-Proofpoint-GUID: xTIcptSioBqdMBYmmYc0IaakWYsxvmj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_05,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=843 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408280110

On 8/28/2024 3:30 AM, Balaji Pothunoori wrote:
> WCN6750 firmware sends the log messages via WMI_DIAG_EVENTID only
> when the host driver enables the same via QMI_WLANFW_WLAN_INI_REQ_V01
> QMI message. This is further controlled via fw_wmi_diag_event.
> Hence set this flag to true for the firmware to send the logs.
> These logs are further collected in the user space through
> the trace infrastructure.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00233-QCAMSLSWPLZ-1
> 
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


