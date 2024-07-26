Return-Path: <linux-wireless+bounces-10537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84493CC04
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 02:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3354B21858
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 00:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C6812;
	Fri, 26 Jul 2024 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WdSLg5ax"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9781B86C4
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953083; cv=none; b=Mdi3uTNVtgp0I7WZrAScWSHFMosWxJ2vtMQDIuib/rG9aNRdjfluubzSqzdbCg2nqPwSK8G40L0ducCYT4+k1twTZjum4nLUpFLOhSkqoMX0xTPprBRzeyU/d0I5pNTkULlTLJPc3KlkjwNWo0UiPycKbSC9Zd5pAT6Y6t6ZAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953083; c=relaxed/simple;
	bh=Ecz71I0T0uD0oLXLOXgwVKBBrievnLZlUksJcLwv9BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dk7mj8dIWcxgObrZtCn7dFW3Mu805ynMp0PwDmoIZvj6q1Rt4OlYk12t1aXg9xG+4ipMq/YiLf8d8Fq8rGIx1C2sPhvmhBVIZ/xn8Ya+xafVc5nrgrE4f/vAqD4s4ZkE3zXqLOtBEdDdbh7gshoqeBWOuuJnnq49sTyrIt5S6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WdSLg5ax; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PKtQGl010804;
	Fri, 26 Jul 2024 00:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F0Vm+bbCEh4Jla68pOE4PtbCWCjDW9tH7zIpIGBBR+g=; b=WdSLg5axKrWHshRP
	9bkGxeXs54KUUzQ61epaT1cX9Frth8xP4Lvq9TcY3CI9o7XolYtoQiiW+PhVAnyw
	g3EwUEM4uSvQQDve7rPbL1HtpUeEo6nFbTVH4SUVn9HJEWVMNOU3lIIjp2vAvhtz
	zknKlAyOxQlJFpcJrrbeA1rMrWhFFYBlA8iNWcJCOM9U3KsOJx1H9LgKzqKjnUXv
	yzHBkWEytX76hepWHV8KJOFAQyx1uKpWeGuiSNNL2jgWHaN/aH8Z6XwI5Be6cMHG
	a5Tx4RFGzbIPmCMITzY56T3MGlFEl4nGvGZx70Y6cnkyl9zrdlWi6sPGxfknWLWR
	e9uriQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40jyrfmuwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:18:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q0HxmR004044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:59 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 17:17:59 -0700
Message-ID: <3a0a2d45-ef8a-4bd4-9931-eec88dcd4dee@quicinc.com>
Date: Thu, 25 Jul 2024 17:17:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] wifi: ath12k: use tail MSDU to get MSDU information
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-10-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725120035.493-10-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EPr_EvWD4Nvu2lxU3hQ0Xp4MWI_RpQkt
X-Proofpoint-ORIG-GUID: EPr_EvWD4Nvu2lxU3hQ0Xp4MWI_RpQkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_26,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=896 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260000

On 7/25/2024 5:00 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> When receiving a packet in monitor mode, hardware will fill status
> information msdu_end for MSDUs. Then host can use these status
> information to get specific information about this packet, such as
> l3 offset, bandwidth, mcs, packet type.
> 
> If this packet is composed of multiple MSDUs, then hardware will only
> fill status information for the last(tail) MSDU. At this time,
> MSDU information is uncertain for others MSDUs. But current code use
> the first MSDU in monitor mode, so will get the wrong information.
> 
> Fix it by getting msdu information from last(tail) msdu.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



