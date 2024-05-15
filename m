Return-Path: <linux-wireless+bounces-7719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CEF8C6EB6
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 00:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993FA284ADD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499C39FEC;
	Wed, 15 May 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RDuE6weq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1012A8D7
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715812925; cv=none; b=Ta5ba8UGd+k7SjY9g6PqeO7SrcwIxt4XaNvopaYC9mIasGzXBpvsOrgCqUpqpZ35AuZo28DGY3Qt/ybO3W3Nn4RgSfBiQtoJKJZatT9h6vXMoptyxFKWkk+jPCsj1YoK7gGNJzwquZsCYWyj7MOlVqUWukv3aL7J36kOCa6S0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715812925; c=relaxed/simple;
	bh=HBSMU+Z9tPrPIXFQinW++kphzwFEIcAgYgdBVZqIFTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mNg92TMeDxLM9QE6P0afM7fysaA5s58CTIArYjYGddVLcvoRLLeW4gAvG9T/cT9r8BPRIQ1Ty4OfdJVaFcpHcU7nCMfxGguC5ueNXi3hS2WPqnwFScfU0z4yz72E+N6Aoz/EU+L4cvbLIA1Sr7J3q4+jRA33YvlLEjlflSb2n5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RDuE6weq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FJCg9t027381;
	Wed, 15 May 2024 22:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J8SPinwZZR3nZ+KHLyX3CJD5HrH9koLN+T4VCyaaH7w=; b=RD
	uE6weqWxzTdwLj79QPvSV+T6jTV1wqV3y6tSFK7qaOlQzhG/bOZQl+9TzBFvzsN7
	NDdzyTs3wM41o30e6nr/5Jy/6vq5riPE2IhZr2kC6aYhaE7g+WaCxPuei3XYhCrs
	zGbaIUrwkMM9X3Dwrgv7XWBHnry3IiVrwQPIPT2mx5pcbBHrw3bmykTAWNwZiURz
	0e+fBQqJ7zfD5l1BW3NcSB9VMAI2i+u7Yy/HDsspGK+deK5LSi56Np/QQM2M3s8m
	/8h4dkrIG7yAXw3iKORZqihvDbJD1qctDF0IQ2JPLLq3YPON/TnIunSpEfLaMQ2v
	XaJdTnyxN7R8Ehr01iJQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y42kvvryk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 22:41:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FMfsfm027406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 22:41:54 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 May
 2024 15:41:53 -0700
Message-ID: <71285d54-4685-436e-98e3-e8c2bd7b8b0f@quicinc.com>
Date: Wed, 15 May 2024 15:41:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: Add Dynamic VLAN support
Content-Language: en-US
To: Muna Sinada <quic_msinada@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240515192830.995013-1-quic_msinada@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240515192830.995013-1-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qi_nxVfgmEt5mt53Kj7xNHYo3FsNmfS9
X-Proofpoint-ORIG-GUID: qi_nxVfgmEt5mt53Kj7xNHYo3FsNmfS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=831 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150161

On 5/15/2024 12:28 PM, Muna Sinada wrote:
> Add support for dynamic VLAN. VLAN group traffic is encapsulated and
> encrypted in mac80211 and driver needs to set flags for the VLAN group
> traffic to skip hardware encapsulation and encryption.
> 
> VLAN group traffic utilizes ext MSDU and HTT Metadata to set
> encapsulation type to RAW and encryption type to OPEN in order to
> inform firmware to skip hardware encapsulation and encryption.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

(you should have carried this forward yourself from v1)


