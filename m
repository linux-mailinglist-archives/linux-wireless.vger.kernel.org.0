Return-Path: <linux-wireless+bounces-5039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029148818E0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFDB1F218BE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464985653;
	Wed, 20 Mar 2024 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aAMJSh/T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44998EDB
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968442; cv=none; b=Ktti64WJkkI29jbYaUkc+N9hGWEdtq0Uggbmb6ZmD5rFMV0XXPSpiD7f6QFO/ageT9hySP6ohqDRUlAfUYMMqH8gekZexjKlVCnEmbx6A4Q342sEFfkt7b00Xma1bYdlzUMN8pN/nO3rAt7VYpiQ778/4p6W5o5MblpndoNkb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968442; c=relaxed/simple;
	bh=cQsp3zH/2eVUhpEz4AeLRABgNjVvBpgOE0ae048wM+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JURZ9j6qLeVh3TuaiE2A99VvGctldh+U4vgg74SZU4OC78TsF0xNQgVuxB5uStHF8IMv880NFTP/5hIRERVlcsyBCAQBAPoE/SC7XhtjUEoPTRov6FHWayuG4aJ2CIVL7KV+YwfKlevFtlX3Fn72isU2MyQpyHYEuYzCBTHkYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aAMJSh/T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KKeT2x028418;
	Wed, 20 Mar 2024 21:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JtSr7WUR+Ulg+MDYsVvklR/HCpfKcvzboRY+oAK3atI=; b=aA
	MJSh/TIzBIB6L3s7ACxpOmGhd9l92fq6cJtEqY2dXBRR2oFmlx4ezn7R0f4kScEj
	BXCjfXvH5hE3x/YHkt/spR/4B5AQAPx2PN3/jJGMjFTZWeQZuybWiqdZhSDF9wta
	x/NXWaAoPLWV81hGKOmTQU3DhjCmQfxtzm+ZIKzbFabK3pmCPykqDwMtlCu2pVnD
	7p+8oaSfkjWBZfiH5Lp0L1Wn3T373jI83P2ZwtsG8IfhdiXS2diCg/HnAXiFxu9Q
	1omCB/vL7bQ7Qc0gHh6Mp2UZY9d4sIdiISDgf93ZDGhaz/CdbMBJI52SLrhrt6ZH
	s8IpqwkeB6N5QM0un6SA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x04qm0by2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:00:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KL0bMw011446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:00:37 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 14:00:36 -0700
Message-ID: <ff7db654-fa0a-479a-8497-9d61065bc60e@quicinc.com>
Date: Wed, 20 Mar 2024 14:00:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] wifi: ath12k: Add single wiphy support
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320190943.3850106-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xFwABIqj3ytp-5fDDDOuJTp0kExaf6GN
X-Proofpoint-GUID: xFwABIqj3ytp-5fDDDOuJTp0kExaf6GN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_11,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=947 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200168

On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> With the introduction of Multi Link Operation (MLO) support in
> IEEE802.11be, each EHT AP/non AP interface is capable of
> operating with multiple radio links.
> 
> cfg80211/mac80211 expects drivers to abstract the communication
> between such Multi Link HW and mac80211/cfg80211 since it depends
> on different driver/HW implementation. Hence the single wiphy
> abstraction with changes in datastructures were introduced in
> "wifi: ath12k: Introduce hw abstraction"
> 
> This patchset extends the implementation to allow combination
> of multiple underlying radios into a single composite hw/wiphy
> for registration. Since now multiple radios are represented by
> a single wiphy, changes are required in various mac ops that the
> driver supports since the driver now needs to learn on how to tunnel
> various mac ops properly to a specific radio.
> 
> This patchset covers the basic mac80211 ops for an interface bring up
> and operation.
> 
> Note:
> Monitor and hw reconfig support for Single Wiphy will be done in future
> patchsets.
> 
> ---
>  v5:
>  - Addressed Jeff's comments
>  - Made arvif config cache to be dynamic in PATCH 07/12

In the future please be specific about what patches in the series were
modified so that reviewers don't have to spend time reviewing the parts that
didn't change.


