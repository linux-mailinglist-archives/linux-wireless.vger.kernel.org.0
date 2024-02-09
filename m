Return-Path: <linux-wireless+bounces-3408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3E84FC87
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23FB1F29C05
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3261484A35;
	Fri,  9 Feb 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EhgqYVzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F280C1A
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505311; cv=none; b=h0zXNjxKqZAM5BSOQWY4OFcCXxCSOU7tJk/NU/oRQkpDcruVlV3LkyczG8c/+QZl8X4wGV2GgmAIHpdofFt+caL2ceGYBHl3pIkRJIPIX1t5SjpSPW5OboyyxfiDWphr5NUtXcqefIR0K6F/X5PeENT2eJJP0eD3JnHT6xileM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505311; c=relaxed/simple;
	bh=CeaAKIv5/Cw30K5fz8Pp3cwgG0YXLSeEm6/JFhcFZGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GBB76qpLRWDLtEPSNBAB6plR7r2CSEz9vzk//l7ivto831BKJYsjZCmZtu+BnDxizmguql6B/IL/dot6zVJoTSNFKqubI7TQlrxPMbMuMJPwZkkpYQEFBA1T/u9NYmk7YmdN97JMzo2BUC3xEOtykQRtGjgjx+CqO5QfPAAZtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EhgqYVzJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419IWlfp010062;
	Fri, 9 Feb 2024 19:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=70uh/SjpspiS47BwsBvXUNbn3xTcam28J4dhzSxqJjU=; b=Eh
	gqYVzJH+vz9wRVctCTp/TwDFRk/J0EhvRWX8yApqCwWbJnu9HaD1S4t+2dhj6/5N
	IlJFJUfLRhYrMj/EVBCpxrY0tQ5DYpeJB6fFiPgpka9jLhnCZrkU4I72VxbWcCVd
	QcaZYyK66th5ShWetmXJHx4NEy1M20Z15QXKxOWBlRTyR47wAFSPSMRFU1xvZUTX
	fOVrFK3D5ichEF13x50eOFJml+N3QbECvsNJHfHIQ656H1muwTIvq0s+dXo0VVsQ
	1Jj06nZmWKZO+/jQ7C2DvSnIL01qFGQw1+/SdAbwhZL9u8MgFDNc3EF4RP3CK+3j
	8Y4qsl5spi3YpKLzAVgg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5ef1skkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 19:01:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419J1kHd005510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 19:01:46 GMT
Received: from [10.110.97.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 11:01:45 -0800
Message-ID: <c79e3164-4b43-49f4-bf02-98fda35a6716@quicinc.com>
Date: Fri, 9 Feb 2024 11:01:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath11k: Remove scan_flags union from struct
 scan_req_params
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240209113536.266822-1-nico.escande@gmail.com>
 <20240209113536.266822-3-nico.escande@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240209113536.266822-3-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qMAEEOra08Ls2CqitsD4he7AmFYLQqwP
X-Proofpoint-ORIG-GUID: qMAEEOra08Ls2CqitsD4he7AmFYLQqwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_16,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=392
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090139

On 2/9/2024 3:35 AM, Nicolas Escande wrote:
> Now that we do not use scan_flags directly with WMI_SCAN_XXX macros anymore but
> only the bitfield scan_f_xxx, lets remove the scan_flags & the underlying union.
> 
> This will prevent further problems as some entries in the scan_f_xxx bitfield
> don't match their corresponding WMI_SCAN_XXX flags as seen in [1]
> 
> [1] https://lore.kernel.org/all/20231127180559.1696041-1-nico.escande@gmail.com/
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


