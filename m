Return-Path: <linux-wireless+bounces-2844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7840842AD4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59963B25746
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679D1292D0;
	Tue, 30 Jan 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fcwEEQHq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEB1292F0
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635450; cv=none; b=YNy24H3qOIGucoNnH5SGiEi2eoU5mwNJKZWBUa9KN5AJpKWqZbTmEqr05AxwoFm7wIe6c+4Ag3bpUD4IPeKxTF0X4MNG4VMAZEWxPcHvQcTKPbs9J8u3ppwcRXX5hBe77LeZNkgPZ77YhaFGTMBiDEyjN2OkHK78SJmhgvsoViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635450; c=relaxed/simple;
	bh=AIPlHHhdnXzCrwsMVMktbvjUf8l/fo+zp/nTYpc2mLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=caGMrrPC1qmhBR+Tb8P+9CEwh8khg5F+l5krsewpKk5SitlT9lbSNdYd2QhN6NfbYRWp+i/RH52ipHG5IHdpxYxmUAtig/gDj0WdkcJqsgxmTvBDeQdew1cY+aT8X6o2/Gy1AAID3T+077tMbfqBRMafUXDonZzeEw71PfVZNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fcwEEQHq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UEME4p002442;
	Tue, 30 Jan 2024 17:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1HNVLDtd85ifl9duJnr5kt0j3/uI6aaehxzHBCZO6Do=; b=fc
	wEEQHqnWeyxPpBSlg+eSrdLJk+Rs/FgxRvBBa95KVtM8Oo5hEkZfG+zRKDg/ANPB
	aOskeJQpSM7KPGPdB0ITkJwquVNaORahkVXKFSXrWAV6fbLaaRhHgvOPNs+PXs/J
	/j1b9t81ZEtVTAB+EoEc8k4NQ6d3HegEhLhIBIS+j9uNMCMPBlDvQSZZyWPcv3ji
	O0MMb5OwYeNs0IkScFuMxhX42Qer/ivLejODLTsTsmPamkwit4Ywr9LXmHZMTJPE
	Rc1LD3Wsdr815iLScnsMuoVN1vZ8uWWNNX3TUbGQM5ja3hMFjZXCjn1gqL1c+EYS
	uQd84drD/+bwgKQvEDkg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxtp31kv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:24:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UHO4Yq006966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:24:04 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 09:24:04 -0800
Message-ID: <940e9774-efd6-4964-9015-9c058134ab42@quicinc.com>
Date: Tue, 30 Jan 2024 09:24:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/11] wifi: ath12k: move peer delete after vdev stop
 of station for WCN7850
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-10-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130040303.370590-10-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nS5slaC0I7J-Syiv1BKjxusMv5aF8MfS
X-Proofpoint-GUID: nS5slaC0I7J-Syiv1BKjxusMv5aF8MfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_08,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=882 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300126

On 1/29/2024 8:03 PM, Kang Yang wrote:
> In current code, when STA/P2P Client connect to AP/P2P GO, the WMI
> command sequence is:
> 
> peer_create->vdev_start->vdev_up
> 
> And sequence of STA/P2P Client disconnect from AP/P2P GO is:
> 
> peer_delete->vdev_down->vdev_stop
> 
> This sequence of disconnect is not opposite of connect. For STA or P2P
> GO, bss peer is not needed by firmware during handling vdev stop
> command. So with this sequence, STA and P2P GO can work normally.
> 
> But for P2P Client, firmware needs bss peer in some functions during
> handling vdev stop command. The opposite sequence of disconnect should
> be:
> 
> vdev_down->vdev_stop->peer_delete
> 
> So change the sequence of disconnect as above opposite sequence for
> WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


