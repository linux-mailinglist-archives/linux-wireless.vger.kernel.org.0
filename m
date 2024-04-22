Return-Path: <linux-wireless+bounces-6688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CD8AD38B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A921F21DF3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9B153BED;
	Mon, 22 Apr 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="APFs+JTs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49013153BF2
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808333; cv=none; b=l/e9BpYnV9F5AHJ9b/XbETZxWCFxuh++wWeXdZi8kk/CLb5ww6QOSMfzWqv8HBRRjI8WRIKO27jD6ppS1LAAhNWNWgF8xpvVSYxOfxqC/HMhSH21D6U9F5j4aAr3gmTVJXlpks1lSTnE30ccb6uHRWBKQlFN5e97z9hez0x7jy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808333; c=relaxed/simple;
	bh=QNm/Ribk5Unq6BcKOV5w4oFOKH/NTQGK06Sva5OTjh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jT3wscsSofj6zUaYMYtLA7qd946USSRIx3hEv5+glLN48Rvx1ysZ91D1MxUozR/Gfsc1aZY8I66IQhKKgqa7wY49WDBH6kEJIglw6B264dLsfy/zioWSOcwZHdjca5Lst3J4w3Mm1GjHQT9ltm4mr6Eim5D+wOeEBDo9fW+AmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=APFs+JTs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M5cL75020716;
	Mon, 22 Apr 2024 17:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7FvykEc6MT+7sm5CoYYCL+RYIKRYGnW3N/yymB/201c=; b=AP
	Fs+JTs9TdfX5GPS+bUD6YcyWQg4wqMlWeF2MKY1PStv/7fBjFfRjrtkPh0xYn35m
	qePbK0DUfXLTs1eeB/VTmWjz9HyOT9xIJ0ivEW6uluZZA/tYba80/FDtagK/2QXV
	xYVNATYhIfsqZQnOcPcr/BfRCDaUzzoTHnW5z9Vkl1OHqzTnGvtl21MviuVs7qgP
	SClhO6DaeknABfmxQJ47UXShobz+NfBUjqSHshSgFLg5gasP11XI1cEc7xAaPSMH
	JfFV4vh0+W2IiQToiY2z48xuK2CZy+lbPaLppZ+5504jr4sgPgKvsuT96hLeuxYZ
	iLvZJGF/MTthdfedZklQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qddafu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:52:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MHq8MA024820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:52:08 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 10:52:07 -0700
Message-ID: <5dd501d3-8668-4d31-8210-4f397b27b1cc@quicinc.com>
Date: Mon, 22 Apr 2024 10:52:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] wifi: ath12k: avoid stopping mac80211 queues in
 ath12k_core_restart()
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-9-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412060620.27519-9-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KkjSp_V3h9fptCYImF_r-7Ez_IexUvPf
X-Proofpoint-ORIG-GUID: KkjSp_V3h9fptCYImF_r-7Ez_IexUvPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=641 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220075

On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> Currently when resume ath12k_core_restart() calls
> ath12k_core_pre_reconfigure_recovery() where mac80211 queues are
> stopped by calling ieee80211_stop_queues(). Then in
> ath12k_mac_op_reconfig_complete() those queues are not started
> because ieee80211_wake_queues() is skipped due to the check on
> reconfig_type. The result is that mac80211
> could not deliver any frame to ath12k to send out, finally making
> connection fail.
> 
> [84473.104249] PM: suspend exit
> [84479.372397] wlan0: no VHT 160 MHz capability on 5 GHz, limiting to 80 MHz
> [84479.372401] wlan0: determined local STA to be EHT, BW limited to 80 MHz
> [84479.372416] wlan0: determined AP 00:03:7f:12:b7:b7 to be HE
> [84479.372420] wlan0: connecting with HE mode, max bandwidth 80 MHz
> [84479.580348] wlan0: authenticate with 00:03:7f:12:b7:b7 (local address=00:03:7f:37:11:53)
> [84479.580351] wlan0: send auth to 00:03:7f:12:b7:b7 (try 1/3)
> [84480.698993] wlan0: send auth to 00:03:7f:12:b7:b7 (try 2/3)
> [84481.816505] wlan0: send auth to 00:03:7f:12:b7:b7 (try 3/3)
> [84482.810966] wlan0: authentication with 00:03:7f:12:b7:b7 timed out
> 
> Actually we don't need to stop/start queues during suspend/resume,
> so remove ath12k_core_pre_reconfigure_recovery() from ath12k_core_restart().
> This won't cause any regression because currently the only chance
> ath12k_core_restart() gets called is in reset case, where ab->is_reset
> is set so that function will never be executed.
> 
> Also remove ath12k_core_post_reconfigure_recovery() because it is
> not needed in suspend/resume case. This is also valid due to above
> analysis.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


