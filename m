Return-Path: <linux-wireless+bounces-7406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD58C1C53
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4EE1C20EBD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58113B5B3;
	Fri, 10 May 2024 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RQ6rfvK6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228AECF
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307366; cv=none; b=fAXT7I6j349HKJBuSnlIojk/YJ1L8hAwhOS8d1NyEO00XiHKJ5xkljlkVg5O54T+CuWvOuyxXZfMNzmP/9eODxmp0WdbU5jTd2aHdz7obhUgC5SRYTtKhq9zo0Shw9HCZ3DvNvCoelJoah2oPdnObu7kzYw+6/KsNwwy1E1je88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307366; c=relaxed/simple;
	bh=HoBTZnb1XePy6NjCrgI4nOXapL6Y9xaKk8+HEFSfNFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n4AProWQob412GL8NgKKxxcPHLpTuyBxQzrAOPVy5zbte/co9gySNDPdkWpZL9fVACtlJ8qDQs6xm7QKQuPzAOL7rM07hsImAjKNF4biOWN4KzQ3I6ZFPOgUlQmu7eMYSczoryE4ZTHzRPyIMhDLnsqEfmvq3JrTwGJ+9XC5HP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RQ6rfvK6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1B61S028216;
	Fri, 10 May 2024 02:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gB7zNLZr+Lbij8uj+HfDGqSlSiXhfo8qjfbahnPHcd4=; b=RQ
	6rfvK6SPNPMmcXRJm9yDYILO75YPksV0q8zb04xwaBmLHg8JiNbTfTsUAjo3CA4R
	wM+Kv7l4umcfyOwA0hH5h9SvPtFJ3HJGlKNIE0C7ttz6EAUd4oMKLDCRCmz61a9H
	dUvnQuOlgPziuOC7Dv7VdwrKpso+bkbd8OmYD5QjZhyDGyMEbXMZD7XqlsWsX8Cj
	cEZMJmAvgPwSo1Lv1N2KUXfuqLyq0d9nXK+IIRJic3yUHwNlbk826GdTX/CgdklQ
	00zd+Spbe+7TWHloy2WlNI6iJR2nI4fE4x9ocaAeBHfLAArBiCUC6Y+6oiWaiA5E
	/Gf23AsMwddwTKdiKVSA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w28bf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:16:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A2FxuJ026110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:15:59 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 19:15:58 -0700
Message-ID: <ca14a4ed-1089-4f18-997f-d01d4ae22e57@quicinc.com>
Date: Thu, 9 May 2024 19:15:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] wifi: ath12k: Add helpers to get or set ath12k_hw
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
 <20240507045702.2858954-3-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240507045702.2858954-3-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T54WGhJkWxftNN6s-6z6QQWDuokc3Lec
X-Proofpoint-ORIG-GUID: T54WGhJkWxftNN6s-6z6QQWDuokc3Lec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_01,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxlogscore=607 mlxscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405100015

On 5/6/2024 9:56 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, one or more ath12k_hw is part of a device (ath12k_base) but
> in future, it would be part of device group abstraction (ath12k_hw_group),
> i.e., when multiple radios (ar) across different devices can be combined
> together in a device group (ath12k_hw_group).
> 
> In order to facilitate the above transition, introduce helpers such as
> ath12k_ab_to_ah() and ath12k_ab_set_ah() to get and set values of ath12k_hw
> respectively.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


