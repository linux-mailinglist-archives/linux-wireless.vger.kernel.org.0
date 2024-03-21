Return-Path: <linux-wireless+bounces-5119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C078C88619C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 21:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA66284C7D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5DC134CC0;
	Thu, 21 Mar 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SBKZ1wTV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B56133402
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052819; cv=none; b=u/1Ue5CAJleBT7T2wEffvXM8oM/0LG2p2J7JDe4lCTA/dqE0BmIW70tdtszbkheow7+DLsyvvci744uOOb9lw7oclBAUdyJLe17yCK6ma7sj4pbOiJosoXy/Rgw1cSOc3X+ZAxbRgWBCVSi6ymfVEZIKzNVPpYXDqltbsFcF0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052819; c=relaxed/simple;
	bh=hZe5XeAfTjE5Lf0i01jt1pm7UNHV23SPV83HVvyjkrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pcGkuiX85Y//LdlaPrbVUSp22Qk/FnEYSUPX7Yl7AP18QuKPSHcPDXdPBYKK35Jz3F5LQIufiQVpDH+PJslp/0Vkv8tlFKGncMMP4z9xnCEpnRcLmeZWFkE8Ga9wOaiyE4YGDY+UnQTcaS99bqyZhVgDq8Z+AAIPBtpqYQqk8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SBKZ1wTV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LJq38p017590;
	Thu, 21 Mar 2024 20:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zB9Tp9jC2IE3scsHRqJVGjwcJipZ4G1OwxZ4knrp4s0=; b=SB
	KZ1wTV3VeJQAiRC+x9tPb7KSm1PncOY67y2TKDGSWve++sZWpjZw215wZqXKJGxE
	IND36+DKB+oHGMpt6vC/LotrdnzuDCw88TOR9TE+mqSRiSIX9PnL5dohbiiqYgAN
	sSJAaOSNw85j5d1lOnMqRbZYONbB19k2LDSHvdl3U8mm+JMUAXLxSbvkpBQW4j9b
	sDdSP2SJikYOyds9TGIczJSCdkwj4+MjEP4gTOXAI2kf9AWbXDGYRwfwaMiFwY4r
	Y1v9jdGyLF/6E7jYJem+0FFuSHEEfkfH+0BOYRI2MzMCp+T/I4LpEsVChrFbrYYp
	P2FyfSN3mD3clJI4/gqw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0ue601w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:26:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LKQpdW017863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:26:51 GMT
Received: from [10.110.74.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 13:26:51 -0700
Message-ID: <8f477028-1411-443a-8c0b-351ed0186bb1@quicinc.com>
Date: Thu, 21 Mar 2024 13:26:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
Content-Language: en-US
To: Hari Chandrakanthan <quic_haric@quicinc.com>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
 <20240319134522.4021062-2-quic_haric@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240319134522.4021062-2-quic_haric@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Idceh1EhwyJK8eddX36HbBDNXB3ITmsh
X-Proofpoint-GUID: Idceh1EhwyJK8eddX36HbBDNXB3ITmsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=873
 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210152

On 3/19/2024 6:45 AM, Hari Chandrakanthan wrote:
> Add support to count station level rx retries.
> It denotes the number of data frames(MPDUs) with rx retry bit set.
> 
> The rx retry stats helps in understanding the medium
> during UL transmission.
> 
> The counting logic of rx retry stats in the mac80211 rx path accounts the
> data frames for which decap is not offloaded.
> 
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


