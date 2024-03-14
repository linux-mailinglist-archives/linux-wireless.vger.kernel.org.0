Return-Path: <linux-wireless+bounces-4778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F7687C4C1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694D4B21154
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21F97640C;
	Thu, 14 Mar 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EyF0I4kQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3D74BF1
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710451488; cv=none; b=ZgBTRLQ7O6OCCzMfan921bgocvqNHPQSK4Fw/MipoBZQWhyT4/44jr2VnpPOOcZIFvo0YP2cv/KaxOh0a37U9HcA6tG6aC6sXkci/RT7K3i0uFZs4RUtL2g1dwXA9qtRAst+hWNPDlgIPUnZvDX2GAHh4ROMagLU3ixxwpt99yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710451488; c=relaxed/simple;
	bh=W/hXeWm+v2YqqqqC3DDavWoVyQkGobg+HHjOsVfvuHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YG6BG6+LVNeXChNS8D+75sEXTYikrrnyJptWI06465MWAkIbqvinbEtnYZZ7Npdk9nS/sB8wKDJXtt35juTfHBwBwbd9rDNmoAzosgTqC5zz0NzqOzRiZL3kaFD9Nld74fJ7p+HDmej9oqVaLeowI6aFVYgEaoJu3mJ1jwBW25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EyF0I4kQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ELAXHm014510;
	Thu, 14 Mar 2024 21:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5+WhH3GXYyzEzRVu9QxZwTfRAfgprcISvWQoDCqhOAs=; b=Ey
	F0I4kQKf21gLaVkdVCk1/JtLK8MdYI6L+Z+R2wYmgjgxBt0sr7pta20B8L+gxXml
	C2vC+xon4n8c7QM9RS/fwib0Ojd7mbQJIm+K87FvI0M8eFPBOI09p4zEVztulDqL
	Gt+l4Z+xmEw9vf7Da5/Nq90uO3wVokNIyEryP8R2DPpAV2GjrhX7ixtCPRoOTAxP
	xqx/e+0HhIVZ5h6hdoj5DNEUOO2+yXRDDdGfBq2pvTBhaQ/feBOzrYL8gcBHEfKA
	LhFBev9HcmfDHSKq9UIr8EMXJDWjBDKN4pdsqkljZmqhc5+Q1E/iIy22gfphyGBB
	dqu3HBH7d1f4OxITIJPw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuruqtayr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 21:24:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42ELOhTm002271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 21:24:43 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 14:24:43 -0700
Message-ID: <8014476e-dc2e-4658-97ef-d03478299a1e@quicinc.com>
Date: Thu, 14 Mar 2024 14:24:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: use correct flag field for 320 MHz
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240314204651.11075-1-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240314204651.11075-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ONzGfhLnjI4j-PwPuz-E7ZttnTRaffRI
X-Proofpoint-GUID: ONzGfhLnjI4j-PwPuz-E7ZttnTRaffRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=571 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140164

On 3/14/2024 1:46 PM, Aloka Dixit wrote:
> WMI_PEER_EXT_320MHZ (0x2) is defined as an extended flag, replace
> peer_flags by peer_flags_ext while sending peer data.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6734cf9b4cc7 ("wifi: ath12k: peer assoc for 320 MHz")
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


