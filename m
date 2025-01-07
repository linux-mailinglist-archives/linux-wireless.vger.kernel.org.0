Return-Path: <linux-wireless+bounces-17138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48230A03C83
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 11:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB01161BB0
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E1A1E9B30;
	Tue,  7 Jan 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qhzdkakg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE321E572A
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246025; cv=none; b=BDY0DPEeQHfHWhRrAmwH3drpokEYqW+8JcxhX0oyu0tq7ZDtooDmE0tXYF79XKChWizHTS1e0fyrVv0xHQiPQfb8U5pc8MB/hBgf8sSqOjKeOary8ZjFR5WzqrYNCUdQjYItErqLjPIInzGFtayixw/lIIGJDS7QSsBijU1GxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246025; c=relaxed/simple;
	bh=Zp8JC/GDrUTyqZBKVPSVRyWvMyyBsA5WtwVDW+D4SuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fhGWTnIG+HIgrOKxkljwikcDi1vTr9j1E7bwAYYBDKWdup50zcrbORGf5XbaA1hSC0mG6OWggeegDRCnCHrmMKBomoOufsUN3R/TJQqyKrcPfmxsgBH7TPedRSgiFI1H6vfFvFrd1gruhM7Y9P4bTakrmP925MifY+3BSUeWrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qhzdkakg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507A0dkC019799;
	Tue, 7 Jan 2025 10:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bng/oGlTfh/22tU8tFNz3Tnv/mZDCP1Htp6/4ME1730=; b=QhzdkakgnXBTMCBY
	c7W3zNgIPGVPQ/HmRbF8jtWZ2bK5oFue5t70Si92xIBZcEfN42a73133BGG6/kQH
	p6yXzTkjqEffQepcT6UnWKWFKIlCTQTEIyEdEKletGcTRIlHyu3/RLL5Cd1DJpGv
	o8lRg0QHzTlFLF1fYvr9d70XXCR3itC+6WDS0181Uru1lPHoiifHZe+hTQpYodgz
	EKij1zC738QXs4K8ee2UB8liSHDLEeaIvnlZs8WrSLyiffSn3+AIfWGVNDos6I3s
	DLUXG7X7mcbrZPgpB2yo60FBr3mRS/1d/UeHxolictQnOTCCPV3wPges7gbkp7Re
	ziCU2w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44124xr2gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:33:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507AXdCK022576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 10:33:39 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 Jan 2025
 02:33:37 -0800
Message-ID: <f7738ed3-d27a-48a8-b0cc-cb52d47e54f9@quicinc.com>
Date: Tue, 7 Jan 2025 16:03:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: rearrange kernel document for sinfo
 structure
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250107041727.3810446-1-quic_sarishar@quicinc.com>
 <5f774e0f0e00138240108bc0e4028b588e1ac927.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <5f774e0f0e00138240108bc0e4028b588e1ac927.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: guIX1BcxDwniLK_aSAzLujFbOx8L3hIC
X-Proofpoint-GUID: guIX1BcxDwniLK_aSAzLujFbOx8L3hIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=717 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070087

On 1/7/2025 2:28 PM, Johannes Berg wrote:
> On Tue, 2025-01-07 at 09:47 +0530, Sarika Sharma wrote:
>> Currently, the sinfo kernel documentation is not aligned with the
>> order of the sinfo structure elements. Therefore, rearrange the
>> kernel documentation fields to align correctly with the structure.
>> No functionality changes added.
>>
> 
> Why?
> 
> johannes

Actually, there is ongoing work to extend sinfo for link-level details. 
While working on this, I noticed a documentation mismatch and decided to 
correct the existing documentation first, as it's good to have aligned 
structure and documentation.
Since this change is not dependent on anything, sent it separately.

