Return-Path: <linux-wireless+bounces-2970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F32845F05
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 18:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9620B23067
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529E82C76;
	Thu,  1 Feb 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GojfHgjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0B82C7B
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810316; cv=none; b=kLJuiDxPI7P/dqf+nC2X8joY/eZutd4qAPC6t1OCcYoO4C9QrY0o97xUlQ5gTs8sOvLX75aE44i0hZKW5AyJLCLYxnbycBWdG9pyHQWrWPlJwzLopEjg2BaKubvMX2OFY4tT0awBSXRS9J/5xNFFrepv3vVtt4hIsIHNqRrjs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810316; c=relaxed/simple;
	bh=/Xxb3v0zGGEd3GlHgIVQr1yT45N6WP7T5Qpn+yKk8Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LBKakuoeHUvN5wIrMybP7XIP5Me0intHDzcDmgw7xlFPQXkRb5JLEfKSzDLd12oKH8GHKI7qIVAEX07aSzCdq90x9USn94fpqtbJi8OpB/gNQ18vOnJ5ju/fd0jFnpDVDUM+Ra5lxtoaTAoZtpt4lLDa8+RIHaaE/T8On+L5Sd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GojfHgjn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411EqV5G011702;
	Thu, 1 Feb 2024 17:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dFUpQFVpUoh+ASg1KnkMHuDzX81vWq5BzzG8sa55Q2w=; b=Go
	jfHgjneyWCo0YPcIWCxC/HkAUkYef2d4v/fLmjSMv1CK+ZvtCtm5WyU2LVPH4L4D
	2pbseLbF2KWkCJ688NLankQo40RbhDynHr3iQYt5HtJ+ecsymbHwKZsqrqgZWDch
	mWiWNvUkOqfBZCMOAO3m90YPgwb8sIsiizdvkXsaapEj7xiOe7ild/xKvdToKiP9
	gwuka0AceMvBZ8n+BEYEtKyDAj0Pj1MZOsQy86KodDgG5p4V4M9cmNTVhdokFSfh
	9+QXe4cXWIym082nCqBB9nTxzilo+Q96aIXBPJJJaEYCyKmvBjUsbdl9ERn7V+H6
	9pKOAp9Ex+jNpLOvVQSQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0deg8fk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:58:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411HwTn9028622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 17:58:29 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 09:58:28 -0800
Message-ID: <bf5de7c1-3fe8-4fea-884c-748820c7271b@quicinc.com>
Date: Thu, 1 Feb 2024 09:58:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: move WPA version validation to policy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
References: <20240129195421.e8cae9866ccb.I2539b395e3476307d702c6867e51a937e52e57a0@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129195421.e8cae9866ccb.I2539b395e3476307d702c6867e51a937e52e57a0@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A1RDLoVwgqqULA9IEOO3Bd_v2mIIc02V
X-Proofpoint-GUID: A1RDLoVwgqqULA9IEOO3Bd_v2mIIc02V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=854 malwarescore=0
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010139

On 1/29/2024 10:54 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> For a contiguous mask (starting with bit 0) of allowed values
> in a bitmap, it's equivalent to check "!(val & ~mask)" and
> "val ∈ [0, mask]". Use that to move the WPA versions check to
> the policy, for better error reporting.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


