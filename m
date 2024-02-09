Return-Path: <linux-wireless+bounces-3407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFB84FC94
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 20:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F364B29672
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 19:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7966BB22;
	Fri,  9 Feb 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YOmsPfIm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9222E3F7
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505295; cv=none; b=UFpsVcbtz8jDarepf9OkEC3l2w7BjodpR+JLTfC8DGsdstdWprKzNhxQhBugoIrSf/BWgix6+slecXC0S5114egeFUj2yyF4WvAj487uNRfRCWqu++DsE3v5F6IMBAnuEk4zfYT3HjMSRMduQ9F6jSuEH6RfIFsVjRoidfdc7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505295; c=relaxed/simple;
	bh=4I2JJLx/01cJfSD6aBhOhKeG3zj2UkHxm3kZAWgBHmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RvWOPITAGacbMJGLL2L0BPK4/f1WgxA7eG4b5udDJdvO/Xsj9htQhNTJ2WEvcKPAPPCtLW7gq52S8F88Pcdt1MmbgFVDrBN2R0IlFpR47EnnX8KqO44dI6cwgnSe5wIducb4jTa1tTAaWRgn5DX8MDpPp6kofe68QzNHs/zj660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YOmsPfIm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419Gkr3u005845;
	Fri, 9 Feb 2024 19:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VkXqMXdfoFxKguZc6tdH9CCpBWO+EkZ6DvrLzeen3Pc=; b=YO
	msPfImJshsppdHSSGa6uIAyE+Xi55fzyMJgLcvoQb8LRoV6L9gqqiMyMgQGg9YW0
	iqtjiR86UaXT7WU7nBMMI8Wvs4pncZXZjQkCsq+eFIlwOhIwy+UrLtdqelY9Md+J
	HEGdIwBxx4Tdcbdsivq6ef/jPc0wNO03rc65+4U5sl9mPHrsFPlP0olqmYufEZVj
	utte3L/ajistGcLkhQYwixUs58NLsrhBpvPsnY8UDOa/bSLfK/am7ZcWMyDH12hu
	qCr9PtIB86lvEVxQlW3LaFWdTWOgKY/OZlcQYagm7cqg2aT6M3w8L9GK6THH2sLd
	H00WHeg+F7zjqXqKbRRg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5qvag8xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 19:01:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419J1SHj012070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 19:01:28 GMT
Received: from [10.110.97.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 11:01:27 -0800
Message-ID: <0cd0101f-7a76-411e-af1e-95b3017264cc@quicinc.com>
Date: Fri, 9 Feb 2024 11:01:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath11k: Do not directly use scan_flags in
 struct scan_req_params
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240209113536.266822-1-nico.escande@gmail.com>
 <20240209113536.266822-2-nico.escande@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240209113536.266822-2-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aj0yCSsbzrjWZQ-uPBSjkdCURcOdYVc-
X-Proofpoint-ORIG-GUID: aj0yCSsbzrjWZQ-uPBSjkdCURcOdYVc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_16,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=522 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090139

On 2/9/2024 3:35 AM, Nicolas Escande wrote:
> As discussed in [1] lets not use WMI_SCAN_XXX defines in combination with
> scan_flags directly when setting scan params in struct scan_req_params but use
> the underlying bitfield. This bitfield is then converted to WMI_SCAN_XXX when
> filling the WMI command to send to the firmware.
> 
> [1] https://lore.kernel.org/all/871qae51wx.fsf@kernel.org/
> 
> Tested-on: QCN9074 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


